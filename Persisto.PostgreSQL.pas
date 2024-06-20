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
    function GetSchemaTablesScripts: TArray<String>;
    function GetSpecialFieldType(const Field: TField): String;
  end;

implementation

uses System.SysUtils;

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

function TDatabaseManipulatorPostgreSQL.GetSchemaTablesScripts: TArray<String>;
const
  FOREIGN_KEY_ID = 'constraint_schema || ''#'' || constraint_name';

  FOREIGN_KEY_FIELD_ID = FOREIGN_KEY_ID + ' || ''#'' || column_name';

  TABLE_ID_FIELDS = 'table_schema || ''#'' || table_name';

  TABLE_ID = 'cast(' + TABLE_ID_FIELDS + ' as varchar(200))';

  COLUMN_ID_FIELDS = TABLE_ID_FIELDS + ' || ''#'' || column_name';

  COLUMN_ID = COLUMN_ID_FIELDS;

  FOREING_KEY_SQL =
      'select cast(' + FOREIGN_KEY_ID + ' as varchar(200)) Id,' +
             'constraint_name Name,' +
             TABLE_ID + ' IdTable,' +
             '(select ' + TABLE_ID +
                'from information_schema.constraint_table_usage CTU ' +
               'where CTU.table_schema = TC.table_schema ' +
                 'and CTU.table_name = TC.table_name ' +
                 'and CTU.constraint_name = TC.constraint_name) IdReferenceTable ' +
        'from information_schema.table_constraints TC';

  FOREING_KEY_COLUMS_SQL =
      'select cast(' + FOREIGN_KEY_FIELD_ID + ' as varchar(200)) Id,' +
             'cast(' + FOREIGN_KEY_ID + ' as varchar(200)) IdForeignKey,' +
             'column_name Name ' +
        'from information_schema.key_column_usage';

  SEQUENCES_SQL =
    'select sequence_name Id,' +
           'sequence_name Name ' +
      'from information_schema.sequences';

  TABLE_SQL =
    'select ' + TABLE_ID + ' Id,' +
            TABLE_ID + ' IdPrimaryKeyConstraint,' +
           'table_name Name ' +
      'from information_schema.tables ' +
     'where table_schema = ''public''';

  COLUMNS_SQL =
    'select ' + COLUMN_ID + ' Id,' +
           'table_name IdTable,' +
           'null IdDefaultConstraint,' +
           'case data_type ' +
              // String
              'when ''character varying'' then 5 ' +
              // Integer
              'when ''integer'' then 1 ' +
              // Char
              'when ''character'' then 2 ' +
              // Enumeration
              'when ''smallint'' then 3 ' +
              // Float
              'when ''numeric'' then 4 ' +
              // Int64
              'when ''bigint'' then 16 ' +
              'else 0 ' +
           'end FieldType,'+
           'column_name Name,' +
           'case is_nullable ' +
              'when ''YES'' then 0 ' +
              'else 1 ' +
           'end Required,'+
           'numeric_scale Scale,' +
           'coalesce(character_maximum_length, numeric_precision) Size,' +
           'case data_type ' +
              // Date
              'when ''date'' then 1 ' +
              // DateTime
              'when ''timestamp without time zone'' then 2 ' +
              // Time
              'when ''time without time zone'' then 3 ' +
              // Text
              'when ''text'' then 4 ' +
              // Unique Identifier
              'when ''uuid'' then 5 ' +
              // Boolean
              'when ''boolean'' then 6 ' +
              'else 0 ' +
           'end SpecialType '+
      'from information_schema.columns';

  DEFAULT_CONSTRAINT_SQL =
    'select ' + COLUMN_ID + ' Id,' +
           '''DF_'' || table_name || ''_'' || column_name Name,' +
           'column_default Value ' +
      'from information_schema.columns';

  PRIMARY_KEY_CONSTRAINT_SQL =
    'select ' + TABLE_ID + ' Id,' +
           'constraint_name Name,' +
           'column_name FieldName ' +
      'from information_schema.constraint_column_usage';

  function CreateView(const Name, SQL: String): String;
  begin
    Result := Format('create or replace temp view  PersistoDatabase%s as (%s)', [Name, SQL]);
  end;

begin
  Result := [
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
  SPECIAL_TYPE_MAPPING: array[TDatabaseSpecialType] of String = ('', 'date', 'timestamp without time zone', 'time without time zone', 'text', 'uuid', 'boolean');

begin
  Result := SPECIAL_TYPE_MAPPING[Field.SpecialType];
end;

end.

