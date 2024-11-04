﻿unit Persisto.SQLite;

interface

uses Persisto, Persisto.Mapping;

type
  TDatabaseManipulatorSQLite = class(TDatabaseManipulator, IDatabaseManipulator)
  private
    function CreateDatabase(const DatabaseName: String): String;
    function DropDatabase(const DatabaseName: String): String;
    function CreateSequence(const Sequence: TSequence): String;
    function DropSequence(const Sequence: TDatabaseSequence): String;
    function GetDefaultValue(const DefaultConstraint: TDefaultConstraint): String;
    function GetFieldType(const Field: TField): String;
    function GetMaxNameSize: Integer;
    function GetSchemaTablesScripts: TArray<String>;
    function GetSpecialFieldType(const Field: TField): String;
    function IsSQLite: Boolean;
  end;

implementation

uses System.SysUtils, System.Rtti, System.TypInfo, System.IOUtils;

{ TDatabaseManipulatorSQLite }

function TDatabaseManipulatorSQLite.CreateDatabase(const DatabaseName: String): String;
begin
  Result := EmptyStr;
end;

function TDatabaseManipulatorSQLite.CreateSequence(const Sequence: TSequence): String;
begin
  Result := Format('insert into sqlite_sequence (name, seq) values (''%s'', 0)', [Sequence.Name]);
end;

function TDatabaseManipulatorSQLite.DropDatabase(const DatabaseName: String): String;
begin
  Result := EmptyStr;
end;

function TDatabaseManipulatorSQLite.DropSequence(const Sequence: TDatabaseSequence): String;
begin
  Result := Format('delete from sqlite_sequence where name = ''%s''', [Sequence.Name]);
end;

function TDatabaseManipulatorSQLite.GetDefaultValue(const DefaultConstraint: TDefaultConstraint): String;
const
  AUTO_GENERATED_VALUE_MAPPING: array [TAutoGeneratedType] of String = ('', 'date()', 'time()', 'datetime(''now'', ''localtime'')', 'uuid()', 'newguid()', '', '');

begin
  case DefaultConstraint.AutoGeneratedType of
    agtFixedValue:
      Result := DefaultConstraint.FixedValue;
    agtSequence:
      Result := Format('next_value_for(''%s'')', [DefaultConstraint.Sequence.Name]);
  else
    Result := AUTO_GENERATED_VALUE_MAPPING[DefaultConstraint.AutoGeneratedType];
  end;
end;

function TDatabaseManipulatorSQLite.GetFieldType(const Field: TField): String;
begin
  case Field.FieldType.TypeKind of
    tkInteger:
      Result := 'integer';
    tkEnumeration:
      Result := 'smallint';
    tkFloat:
      Result := 'numeric';
    tkChar, tkWChar:
      Result := 'char';
    tkInt64:
      Result := 'bigint';
    tkString, tkLString, tkWString, tkUString:
      Result := 'varchar';
  else
    Result := EmptyStr;
  end;
end;

function TDatabaseManipulatorSQLite.GetMaxNameSize: Integer;
begin
  Result := 100;
end;

function TDatabaseManipulatorSQLite.GetSchemaTablesScripts: TArray<String>;
const
  PRIMARY_KEY_CONSTRAINT_SQL =
    '''
    select cast('PK_' || T.name as varchar(250)) Id,
           cast('PK_' || T.name as varchar(250)) Name,
           cast(PK.name as varchar(250)) FieldName
      from PersistoDatabaseTable T,
           pragma_table_info(T.name) PK
     where PK.pk = 1
    ''';

  DEFAULT_CONSTRAINT_SQL =
    'select null Id, null Name, null Value';

  FOREING_KEY_SQL =
    '''
    select cast(FK.id || '.' || FK."table" as varchar(250)) Id,
           cast('FK_' || T.name || '_' || FK."from" as varchar(250)) Name,
           cast(T.name as varchar(250)) IdTable,
           cast(FK."table" as varchar(250)) IdReferenceTable,
           cast(null as varchar(250)) ReferenceField
      from PersistoDatabaseTable T,
           pragma_foreign_key_list(T.name) FK
    ''';

  SEQUENCES_SQL =
    '''
    select cast(name as varchar(250)) Id,
           cast(name as varchar(250)) Name
      from sqlite_sequence
    ''';

  TABLE_SQL =
    '''
    select cast(T.name as varchar(250)) Id,
           cast((select cast('PK_' || T.name as varchar(250))
                   from pragma_table_info(T.name) PK
                  where PK.pk = 1) as varchar(250)) IdPrimaryKeyConstraint,
           cast(T.name as varchar(250)) Name
      from sqlite_master T
     where T.type = 'table'
       and not T.name like 'sqlite_%'
    ''';

  COLUMNS_SQL =
    '''
    select cast(T.name || '#' || C.name as varchar(250)) Id,
           null IdDefaultConstraint,
           cast(T.name as varchar(250)) IdTable,
           case lower(substr(type, 1, iif(instr(type, '(') > 0, 7, length(type))))
              when 'varchar' then 5
              when 'integer' then 1
              when 'char' then 2
              when 'smallint' then 3
              when 'numeric' then 4
              when 'bigint' then 16
              else 0
           end FieldType,
           cast(C.name as varchar(250)) Name,
           "notnull" Required,
           cast(substr(type, instr(type, ',') + 1, length(type) - instr(type, ',') - 1) as integer) Scale,
           cast(substr(type, instr(type, '(') + 1, coalesce(nullif(instr(type, ','), 0), length(type)) - instr(type, '(') - 1) as integer) Size,
           case lower(type)
              -- Date
              when 'date' then 1
              -- DateTime
              when 'datetime' then 2
              -- Time
              when 'time' then 3
              -- Text
              when 'text' then 4
              -- Unique Identifier
              when 'uniqueidentifierchar' then 5
              -- Boolean
              when 'boolean' then 6
              else 0
           end SpecialType
      from PersistoDatabaseTable T,
           pragma_table_info(T.name) C
    ''';

  function CreateView(const Name, SQL: String): String;
  begin
    Result := Format('create temp view if not exists PersistoDatabase%s as %s', [Name, SQL]);
  end;

begin
  Result := ['create table PersistoDatabaseSequenceWorkArround (sequence integer primary key autoincrement)',
    CreateView('Sequence', SEQUENCES_SQL),
    CreateView('Table', TABLE_SQL),
    CreateView('DefaultConstraint', DEFAULT_CONSTRAINT_SQL),
    CreateView('ForeignKey', FOREING_KEY_SQL),
    CreateView('TableField', COLUMNS_SQL),
    CreateView('PrimaryKeyConstraint', PRIMARY_KEY_CONSTRAINT_SQL),
    'drop table PersistoDatabaseSequenceWorkArround'];
end;

function TDatabaseManipulatorSQLite.GetSpecialFieldType(const Field: TField): String;
const
  SPECIAL_TYPE_MAPPING: array [TDatabaseSpecialType] of String = ('', 'date', 'datetime', 'time', 'text', 'uniqueidentifierchar', 'boolean', 'blob');

begin
  Result := SPECIAL_TYPE_MAPPING[Field.SpecialType];
end;

function TDatabaseManipulatorSQLite.IsSQLite: Boolean;
begin
  Result := True;
end;

end.

