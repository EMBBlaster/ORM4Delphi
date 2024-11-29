﻿unit Persisto.PostgreSQL;

interface

uses Persisto, Persisto.Mapping;

type
  TDatabaseManipulatorPostgreSQL = class(TDatabaseManipulator, IDatabaseManipulator)
  private
    function CreateDatabase(const DatabaseName: String): String;
    function DropDatabase(const DatabaseName: String): String;
    function GetDefaultValue(const DefaultConstraint: TDefaultConstraint): String;
    function GetFieldType(const Field: TField): String;
    function GetMaxNameSize: Integer;
    function GetSchemaTablesScripts: TArray<String>;
    function GetSpecialFieldType(const Field: TField): String;
  end;

implementation

uses System.SysUtils, System.Rtti, System.TypInfo;

{ TDatabaseManipulatorPostgreSQL }

function TDatabaseManipulatorPostgreSQL.CreateDatabase(const DatabaseName: String): String;
begin
  Result := Format('create database %s', [DatabaseName]);
end;

function TDatabaseManipulatorPostgreSQL.DropDatabase(const DatabaseName: String): String;
begin
  Result := Format('drop database if exists %s with (force)', [DatabaseName]);
end;

function TDatabaseManipulatorPostgreSQL.GetDefaultValue(const DefaultConstraint: TDefaultConstraint): String;
const
  DEFAULT_VALUE: array[TAutoGeneratedType] of String = ('', 'current_date', 'localtime(0)', 'localtimestamp(0)', 'gen_random_uuid()', 'gen_random_uuid()', 'nextval(''%0:s'')', '%1:s');

begin
  var SequenceName := EmptyStr;

  if Assigned(DefaultConstraint.Sequence) then
    SequenceName := DefaultConstraint.Sequence.Name;

  Result := Format(DEFAULT_VALUE[DefaultConstraint.AutoGeneratedType], [SequenceName, DefaultConstraint.FixedValue]);
end;

function TDatabaseManipulatorPostgreSQL.GetFieldType(const Field: TField): String;
begin
  case Field.FieldType.TypeKind of
    tkInteger: Result := 'integer';
    tkEnumeration: Result := 'smallint';
    tkFloat: Result := 'numeric';
    tkChar,
    tkWChar: Result := 'character';
    tkInt64: Result := 'bigint';
    tkString,
    tkLString,
    tkWString,
    tkUString: Result := 'character varying';
    else Result := EmptyStr;
  end;
end;

function TDatabaseManipulatorPostgreSQL.GetMaxNameSize: Integer;
begin
  Result := 63;
end;

function TDatabaseManipulatorPostgreSQL.GetSchemaTablesScripts: TArray<String>;
const
  TABLE_SQL =
    '''
      select cast(T.oid as varchar(20)) Id,
             (select cast(C.oid as varchar(20))
                from pg_constraint C
               where C.conrelid = T.oid
                 and contype = 'p') IdPrimaryKeyConstraint,
             relname collate CI Name
        from pg_class T
        join pg_namespace S
          on S.oid = T.relnamespace
       where relkind = 'r'
         and S.nspname = 'public'
    ''';

  COLUMNS_SQL =
    '''
      select cast(cast(attrelid as bigint) * 100000 + attnum as varchar(20)) Id,
             cast(attrelid as varchar(20)) IdTable,
             (select cast(D.oid as varchar(20))
                from pg_attrdef D
               where D.adrelid = C.attrelid
                 and D.adnum = C.attnum) IdDefaultConstraint,
             case atttypid
                -- String
                when 1043 then 5
                -- Integer
                when 23 then 1
                -- Char
                when 1042 then 2
                -- Enumeration
                when 21 then 3
                -- Float
                when 700 then 4
                when 701 then 4
                when 1700 then 4
                -- Int64
                when 20 then 16
                else 0
             end FieldType,
             attname collate CI Name,
             attnotnull Required,
             (atttypmod - 4) & 65535 Scale,
             case
                when atttypid = 1043 then atttypmod - 4
                when atttypid = 1700 then ((atttypmod - 4) >> 16) & 65535
                else ((atttypmod - 4) >> 16) & 65535
             end Size,
             case atttypid
                -- Date
                when 1082 then 1
                -- DateTime
                when 1114 then 2
                when 1184 then 2
                when 14722 then 2
                -- Time
                when 1083 then 3
                when 1266 then 3
                -- Text
                when 25 then 4
                when 142 then 4
                -- Unique Identifier
                when 2950 then 5
                -- Boolean
                when 16 then 6
                -- Binary
                when 17 then 7
                else 0
             end SpecialType
        from pg_attribute C
        join pg_class T
          on T.oid = C.attrelid
        join pg_namespace S
          on S.oid = T.relnamespace
       where T.relkind = 'r'
         and S.nspname = 'public'
         and C.attnum > 0
    ''';

  FOREING_KEY_SQL =
    '''
      select cast(FK.oid as varchar(20)) Id,
             FK.conname collate CI Name,
             cast(FK.conrelid as varchar(20)) IdTable,
             cast(FK.confrelid as varchar(20)) IdReferenceTable,
             C.attname collate CI ReferenceField
        from pg_constraint FK
        join pg_class T
          on T.oid = FK.conrelid
        join pg_namespace S
          on S.oid = T.relnamespace
        join pg_attribute C
          on C.attrelid = T.oid
         and C.attnum = any (FK.conkey)
       where T.relkind = 'r'
         and S.nspname = 'public'
         and FK.contype = 'f'
         and cardinality(FK.conkey) = 1
    ''';

  SEQUENCES_SQL =
    '''
      select cast(S.seqrelid as varchar(20)) Id,
             C.relname collate CI Name
        from pg_sequence S
        join pg_class C
          on C.oid = S.seqrelid
    ''';

  DEFAULT_CONSTRAINT_SQL =
    '''
      select cast(DF.oid as varchar(20)) Id,
             'df_' || T.relname || '_' || C.attname collate CI Name,
             (string_to_array(pg_get_expr(DF.adbin, DF.adrelid), ':'))[1] Value
        from pg_attrdef DF
        join pg_class T
          on T.oid = DF.adrelid
        join pg_namespace S
          on S.oid = T.relnamespace
        join pg_attribute C
          on C.attrelid = DF.adrelid
         and C.attnum = DF.adnum
       where T.relkind = 'r'
         and S.nspname = 'public'
    ''';

  PRIMARY_KEY_CONSTRAINT_SQL =
    '''
      select cast(PK.oid as varchar(20)) Id,
             PK.conname collate CI Name,
             C.attname collate CI FieldName
        from pg_constraint PK
        join pg_class T
          on T.oid = PK.conrelid
        join pg_namespace S
          on S.oid = T.relnamespace
        join pg_attribute C
          on C.attrelid = T.oid
         and C.attnum = any (PK.conkey)
       where T.relkind = 'r'
         and S.nspname = 'public'
         and PK.contype = 'p'
    ''';

  COLLATION_SQL =
    '''
      do
        $do$
      begin
        if (not exists(select 1 from pg_collation where collname = 'ci')) then
          create collation CI (Provider = icu, Locale = 'und-u-ks-level2', Deterministic = false);
        end if;
      end
      $do$
    ''';

  function CreateView(const Name, SQL: String): String;
  begin
    Result := Format('create or replace view PersistoDatabase%s as (%s)', [Name, SQL]);
  end;

begin
  Result := [
    COLLATION_SQL,
    CreateView('DefaultConstraint', DEFAULT_CONSTRAINT_SQL),
    CreateView('ForeignKey', FOREING_KEY_SQL),
    CreateView('Sequence', SEQUENCES_SQL),
    CreateView('Table', TABLE_SQL),
    CreateView('TableField', COLUMNS_SQL),
    CreateView('PrimaryKeyConstraint', PRIMARY_KEY_CONSTRAINT_SQL)
    ];
end;

function TDatabaseManipulatorPostgreSQL.GetSpecialFieldType(const Field: TField): String;
const
  SPECIAL_TYPE_MAPPING: array[TDatabaseSpecialType] of String = ('', 'date', 'timestamp without time zone', 'time without time zone', 'text', 'uuid', 'boolean', 'bytea');

begin
  Result := SPECIAL_TYPE_MAPPING[Field.SpecialType];
end;

end.

