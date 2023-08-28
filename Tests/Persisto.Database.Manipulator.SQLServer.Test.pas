﻿unit Persisto.Database.Manipulator.SQLServer.Test;

interface

uses System.Generics.Collections, DUnitX.TestFramework, Translucent.Intf, Persisto, Persisto.Mapping;

type
  [TestFixture]
  TManipulatorSQLServerTest = class
  private
    FConnection: IMock<IDatabaseConnection>;
    FFieldType: TDictionary<String, TTypeKind>;
    FForeignKeyCursor: IDatabaseCursor;
    FIndexCursor: IDatabaseCursor;
    FManager: TManager;
    FManipulator: IMetadataManipulator;
    FMapper: TMapper;
    FSchema: TDatabaseSchema;
    FSequenceCursor: IDatabaseCursor;
    FTableCursor: IDatabaseCursor;

    procedure CheckExecution(const SQL: String);
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure WhenCallLoadTablesMustLoadAllTablesFromTheDatabase;
    [Test]
    procedure MustLoadTheTableNameFromTheCursorAsExpected;
    [Test]
    procedure WhenLoadingTheTableCantRaiseDuplicationError;
    [Test]
    procedure WhenLoadTheTableMustLoadTheColumnsOfTheTable;
    [TestCase('Bigint', 'Table3,Bigint,bigint,8,19,0,0')]
    [TestCase('Boolean', 'Table4,Boolean,bit,1,1')]
    [TestCase('Char', 'Table1,Char,char,1,0,0,0,MyCollate')]
    [TestCase('Date', 'Table1,Date,date,3,10')]
    [TestCase('DateTime', 'Table2,DateTime,datetime, 8, 23, 3')]
    [TestCase('DefaultValue', 'Table3,DefaultValue,datetime,8,23,3,0,,getdate(),DF_Default_Value')]
    [TestCase('Int', 'Table3,Int,int,4,10')]
    [TestCase('Nullable', 'Table2,Nullable,datetime, 8, 23, 3, 1')]
    [TestCase('Numeric', 'Table3,Numeric,numeric, 9, 18, 8')]
    [TestCase('Time', 'Table1,Time,time, 5, 16, 7')]
    [TestCase('Tinyint', 'Table2,Tinyint,tinyint, 1, 3')]
    [TestCase('Uniqueidentifier', 'Table1,Uniqueidentifier,uniqueidentifier, 16')]
    [TestCase('Varchar', 'Table3,Varchar,varchar, 50, 0, 0, 0,MyCollate')]
    procedure TheColumnInfoMustBeLoadedHasExpected(const TableName, ColumnName, TypeName: String; const Size, Precision, Scale, Nullable: Word; const Collation, DefaultValue, DefaultName: String);
    [Test]
    procedure MustLoadAllIndexesInTheTablesAsExpected;
    [Test]
    procedure TheIndexMustLoadTheNameHasExpected;
    [Test]
    procedure WhenLoadTheIndexMustLoadAllFieldOfTheIndexHasExpected;
    [Test]
    procedure WhenTheIndexIsPrimaryKeyMustMarkTheInfoInTheIndex;
    [Test]
    procedure WhenTheIndexIsUniqueMustLoadTheInfo;
    [TestCase('Date', 'Table1,Date,stDate')]
    [TestCase('DateTime', 'Table2,DateTime,stDateTime')]
    [TestCase('Time', 'Table1,Time,stTime')]
    [TestCase('Text', 'Table4,Text,stText')]
    [TestCase('Varchar(MAX)', 'Table4,VarcharMax,stText')]
    [TestCase('Uniqueidentifier', 'Table1,Uniqueidentifier,stUniqueIdentifier')]
    procedure WhenLoadTheFieldInfoMustLoadTheSpecialFieldInfo(const TableName, ColumnName: String; const SpecialType: TDatabaseSpecialType);
    [Test]
    procedure WhenLoadTheTableMustLoadTheForeignKeysOfTheTable;
    [Test]
    procedure TheNameOfForeignKeyMustBeLoaded;
    [Test]
    procedure TheFieldsOfTheForeignKeyMustBeLoadedHasExpected;
    [Test]
    procedure TheFieldsLoadedInForeignKeyMustLoadFieldFromTheTable;
    [Test]
    procedure TheReferenceTableOfForeignKeyMustBeLoaded;
    [Test]
    procedure MustLoadTheReferenceFieldsOfTheForeignKey;
    [Test]
    procedure TheReferenceFieldsMustBeLoadedWithTheReferenceFieldOfTheReferenceTable;
    [TestCase('Bigint', 'tkInt64,stNotDefined,bigint')]
    [TestCase('Char', 'tkWChar,stNotDefined,char')]
    [TestCase('Enumerator', 'tkEnumeration,stNotDefined,tinyint')]
    [TestCase('Int', 'tkInteger,stNotDefined,int')]
    [TestCase('Numeric', 'tkFloat,stNotDefined,numeric')]
    [TestCase('Varchar', 'tkUString,stNotDefined,varchar')]
    procedure TheFieldTypeFunctionMustReturnTheTypeHasExpected(const FieldType: TTypeKind; const SpecialType: TDatabaseSpecialType; const FieldTypeComparision: String);
    [Test]
    procedure IfTheFieldTypeUsedIsntMappedMustLoadTheFieldTypeWithUnkownEnumerator;
    [TestCase('Current Date', 'agtCurrentDate,cast(getdate() as date)')]
    [TestCase('Current Time', 'agtCurrentTime,cast(getdate() as time)')]
    [TestCase('Current Date and Time', 'agtCurrentDateTime,getdate()')]
    [TestCase('Unique Identifier', 'agtNewUniqueIdentifier,newsequentialid()')]
    [TestCase('New Guid', 'agtNewGuid,newid()')]
    procedure TheAutoGeneratedValueMustBeReturnedAsExpected(const AutoGeneratedType: TAutoGeneratedType; const ExpectedValue: String);
    [Test]
    procedure WhenTheFieldHasASequenceMustGenerateTheValueAsExpected;
    [Test]
    procedure WhenTheFieldHasAFixedValueMustGenerateTheValueAsExpected;
    [Test]
    procedure WhenCreateARequiredTempFieldMustLoadTheDefaultValueHasExpected;
    [Test]
    procedure WhenCreateTheTempFieldMustCallTheBaseClassToExecuteTheCreation;
    [Test]
    procedure WhenCreateTheTempFieldNotRequiredCantLoadTheFixedValue;
    [Test]
    procedure WhenCreateARequiredUniqueIdentifierFieldMustCreateTheDefaultAsExpected;
    [Test]
    procedure WhenRenameAColumnMustExecuteTheSQLAsExpected;
    [Test]
    procedure WhenCreateADefaultConstraintMustExecuteTheSQLAsExpected;
    [Test]
    procedure WhenDropAnIndexWithPrimaryKeyFlagMustExecuteADropConstraint;
    [Test]
    procedure WhenDropAnIndexMustExecuteTheSQLAsExpected;
    [Test]
    procedure WhenLoadTheSequencesMustLoadTheSequenceList;
    [Test]
    procedure WhenLoadTheSequenceMustLoadTheNameOfTheSequenceAsExpected;
  end;

  [TableName('MyTable')]
  TMyTestClass = class
  private
    FField: String;
    FNoRequeriedField: Nullable<String>;
    FUniqueIdentifier: String;
  published
    [Required]
    property Field: String read FField write FField;
    property NoRequeriedField: Nullable<String> read FNoRequeriedField write FNoRequeriedField;
    [Required, UniqueIdentifier, NewUniqueIdentifier, FieldName('MyField')]
    property UniqueIdentifier: String read FUniqueIdentifier write FUniqueIdentifier;
  end;

implementation

uses System.Rtti, System.Variants, System.SysUtils, Translucent, Persisto.SQLServer, Persisto.Cursor.Mock;

{ TManipulatorSQLServerTest }

procedure TManipulatorSQLServerTest.CheckExecution(const SQL: String);
begin
  FConnection.Setup.WillExecute(
    procedure (const Params: TArray<TValue>)
    begin
      Assert.AreEqual(SQL, Params[1].AsString);
    end).When.ExecuteDirect(It.IsAny<String>);
end;

procedure TManipulatorSQLServerTest.IfTheFieldTypeUsedIsntMappedMustLoadTheFieldTypeWithUnkownEnumerator;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.AreEqual(tkUnknown, FSchema.Table['Table4'].Field['Unknow'].FieldType);
end;

procedure TManipulatorSQLServerTest.MustLoadAllIndexesInTheTablesAsExpected;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.AreEqual(2, FSchema.Table['Table1'].Indexes.Count);

  Assert.AreEqual(1, FSchema.Table['Table2'].Indexes.Count);
end;

procedure TManipulatorSQLServerTest.MustLoadTheReferenceFieldsOfTheForeignKey;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.AreEqual<NativeInt>(2, Length(FSchema.Table['Table1'].ForeignKey['FK1'].FieldsReference));

  Assert.AreEqual<NativeInt>(1, Length(FSchema.Table['Table1'].ForeignKey['FK2'].FieldsReference));

  Assert.AreEqual<NativeInt>(1, Length(FSchema.Table['Table2'].ForeignKey['FK3'].FieldsReference));
end;

procedure TManipulatorSQLServerTest.MustLoadTheTableNameFromTheCursorAsExpected;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.IsNotNull(FSchema.Table['Table1']);

  Assert.AreEqual('Table1', FSchema.Table['Table1'].Name);
end;

procedure TManipulatorSQLServerTest.Setup;
begin
  FConnection := TMock.CreateInterface<IDatabaseConnection>(True);
  FFieldType := TDictionary<String, TTypeKind>.Create;
  FForeignKeyCursor := TCursorMock.Create([
    ['Table1', 'FK1', 'Char', 'Table2', 'DateTime'],
    ['Table1', 'FK1', 'Date', 'Table2', 'Tinyint'],
    ['Table1', 'FK2', 'Date', 'Table2', 'DateTime'],
    ['Table2', 'FK3', 'Nullable', 'Table1', 'Date']]);
  FIndexCursor := TCursorMock.Create([
    ['Table1', 'Index1', 'Char', 0, 0],
    ['Table1', 'Index1', 'Date', 0, 0],
    ['Table2', 'Index2', 'DateTime', 0, 1],
    ['Table1', 'Index3', 'Time', 1, 0]]);
  FSequenceCursor := TCursorMock.Create([
    ['Sequence1'],
    ['Sequence2'],
    ['Sequence3']]);
  FTableCursor := TCursorMock.Create([
    ['Table3', 'Bigint', 'bigint', 8, 19, 0, 0, NULL, NULL, NULL],
    ['Table4', 'Boolean', 'bit', 1, 1, 0, 0, NULL, NULL, NULL],
    ['Table1', 'Char', 'char', 1, 0, 0, 0, 'MyCollate', NULL, NULL],
    ['Table1', 'Date', 'date', 3, 10, 0, 0, NULL, NULL, NULL],
    ['Table2', 'DateTime', 'datetime', 8, 23, 3, 0, NULL, NULL, NULL],
    ['Table3', 'DefaultValue', 'datetime', 8, 23, 3, 0, NULL, 'DF_Default_Value', '(getdate())'],
    ['Table3', 'Int', 'int', 4, 10, 0, 0, NULL, NULL, NULL],
    ['Table2', 'Nullable', 'datetime', 8, 23, 3, 1, NULL, NULL, NULL],
    ['Table3', 'Numeric', 'numeric', 9, 18, 8, 0, NULL, NULL, NULL],
    ['Table1', 'Time', 'time', 5, 16, 7, 0, NULL, NULL, NULL],
    ['Table2', 'Tinyint', 'tinyint', 1, 3, 0, 0, NULL, NULL, NULL],
    ['Table1', 'Uniqueidentifier', 'uniqueidentifier', 16, 0, 0, 0, NULL, NULL, NULL],
    ['Table3', 'Varchar', 'varchar', 50, 0, 0, 0, 'MyCollate', NULL, NULL],
    ['Table4', 'Text', 'text', 16, 0, 0, 0, 'MyCollate', NULL, NULL],
    ['Table4', 'VarcharMax', 'varchar', -1, 0, 0, 0, 'MyCollate', NULL, NULL],
    ['Table4', 'Unknow', 'unknow', 0, 0, 0, 0, NULL, NULL, NULL]]);
  FMapper := TMapper.Create;
  FManager := TManager.Create(FConnection.Instance, nil);
  FSchema := TDatabaseSchema.Create;

  FManipulator := TManipulatorSQLServer.Create(FManager);

  FConnection.Setup.WillReturn(TValue.From(FForeignKeyCursor)).When.OpenCursor(It.IsEqualTo(FOREIGN_KEY_LOAD_SQL));

  FConnection.Setup.WillReturn(TValue.From(FIndexCursor)).When.OpenCursor(It.IsEqualTo(INDEX_LOAD_SQL));

  FConnection.Setup.WillReturn(TValue.From(FTableCursor)).When.OpenCursor(It.IsEqualTo(TABLE_LOAD_SQL));

  FConnection.Setup.WillReturn(TValue.From(FSequenceCursor)).When.OpenCursor(It.IsEqualTo(SEQUENCE_LOAD_SQL));

  FMapper.LoadClass(TMyTestClass);

  FFieldType.Add('bigint', tkInt64);
  FFieldType.Add('bit', tkEnumeration);
  FFieldType.Add('char', tkWChar);
  FFieldType.Add('date', tkFloat);
  FFieldType.Add('datetime', tkFloat);
  FFieldType.Add('int', tkInteger);
  FFieldType.Add('numeric', tkFloat);
  FFieldType.Add('time', tkFloat);
  FFieldType.Add('tinyint', tkEnumeration);
  FFieldType.Add('uniqueidentifier', tkUString);
  FFieldType.Add('varchar', tkUString);
end;

procedure TManipulatorSQLServerTest.TearDown;
begin
  FConnection := nil;
  FForeignKeyCursor := nil;
  FIndexCursor := nil;
  FManipulator := nil;
  FSequenceCursor := nil;
  FTableCursor := nil;

  FFieldType.Free;

  FManager.Free;

  FMapper.Free;

  FSchema.Free;
end;

procedure TManipulatorSQLServerTest.TheAutoGeneratedValueMustBeReturnedAsExpected(const AutoGeneratedType: TAutoGeneratedType; const ExpectedValue: String);
begin
  var DefaultConstraint := TDefaultConstraint.Create;
  DefaultConstraint.AutoGeneratedType := AutoGeneratedType;

  Assert.AreEqual(ExpectedValue, FManipulator.GetAutoGeneratedValue(DefaultConstraint));

  DefaultConstraint.Free;
end;

procedure TManipulatorSQLServerTest.TheColumnInfoMustBeLoadedHasExpected(const TableName, ColumnName, TypeName: String; const Size, Precision, Scale, Nullable: Word;
  const Collation, DefaultValue, DefaultName: String);
begin
  FManipulator.LoadSchema(FSchema);

  var Field := FSchema.Table[TableName].Field[ColumnName];

  Assert.IsNotNull(Field);

  Assert.AreEqual(ColumnName, Field.Name, 'Column name');
  Assert.AreEqual(FFieldType[TypeName], Field.FieldType, 'Column type');
  Assert.AreEqual(Scale, Field.Scale, 'Column scale');
  Assert.AreEqual(Nullable = 0, Field.Required, 'Nullable');
  Assert.AreEqual(Collation, Field.Collation, 'Collation');

  if Field.FieldType = tkFloat then
    Assert.AreEqual<Word>(Precision, Field.Size, 'Column size')
  else
    Assert.AreEqual<Word>(Size, Field.Size, 'Column size');

  Assert.AreEqual(DefaultName.IsEmpty, not Assigned(Field.DefaultConstraint), 'Default info');

  if not DefaultName.IsEmpty then
  begin
    Assert.AreEqual(DefaultName, Field.DefaultConstraint.Name, 'Default name');
    Assert.AreEqual(DefaultValue, Field.DefaultConstraint.Value, 'Default value');
  end;
end;

procedure TManipulatorSQLServerTest.TheFieldsLoadedInForeignKeyMustLoadFieldFromTheTable;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.AreEqual('Char', FSchema.Table['Table1'].ForeignKey['FK1'].Fields[0].Name);
  Assert.AreEqual('Date', FSchema.Table['Table1'].ForeignKey['FK1'].Fields[1].Name);
  Assert.AreEqual('Date', FSchema.Table['Table1'].ForeignKey['FK2'].Fields[0].Name);
  Assert.AreEqual('Nullable', FSchema.Table['Table2'].ForeignKey['FK3'].Fields[0].Name);
end;

procedure TManipulatorSQLServerTest.TheFieldsOfTheForeignKeyMustBeLoadedHasExpected;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.AreEqual<NativeInt>(2, Length(FSchema.Table['Table1'].ForeignKey['FK1'].Fields));

  Assert.AreEqual<NativeInt>(1, Length(FSchema.Table['Table1'].ForeignKey['FK2'].Fields));

  Assert.AreEqual<NativeInt>(1, Length(FSchema.Table['Table2'].ForeignKey['FK3'].Fields));
end;

procedure TManipulatorSQLServerTest.TheFieldTypeFunctionMustReturnTheTypeHasExpected(const FieldType: TTypeKind; const SpecialType: TDatabaseSpecialType;
  const FieldTypeComparision: String);
begin
  var Context := TRttiContext.Create;
  var Field := TField.Create(nil);
  Field.SpecialType := SpecialType;
  var Manipulator := TManipulatorSQLServer.Create(nil);

  case FieldType of
    tkEnumeration: Field.FieldType := Context.GetType(TypeInfo(TDatabaseSpecialType));
    tkFloat: Field.FieldType := Context.GetType(TypeInfo(Double));
    tkInteger: Field.FieldType := Context.GetType(TypeInfo(Integer));
    tkInt64: Field.FieldType := Context.GetType(TypeInfo(Int64));
    tkUString: Field.FieldType := Context.GetType(TypeInfo(String));
    tkWChar: Field.FieldType := Context.GetType(TypeInfo(Char));
    else raise Exception.Create('Type not mapped!');
  end;

  Assert.AreEqual(FieldTypeComparision, Manipulator.GetFieldType(Field));

  Context.Free;

  Field.Free;

  Manipulator.Free;
end;

procedure TManipulatorSQLServerTest.TheIndexMustLoadTheNameHasExpected;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.IsNotNull(FSchema.Table['Table1'].Index['Index1']);

  Assert.AreEqual('Index1', FSchema.Table['Table1'].Index['Index1'].Name);
end;

procedure TManipulatorSQLServerTest.TheNameOfForeignKeyMustBeLoaded;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.IsNotNull(FSchema.Table['Table1'].ForeignKey['FK1']);

  Assert.IsNotNull(FSchema.Table['Table1'].ForeignKey['FK2']);

  Assert.IsNotNull(FSchema.Table['Table2'].ForeignKey['FK3']);
end;

procedure TManipulatorSQLServerTest.TheReferenceFieldsMustBeLoadedWithTheReferenceFieldOfTheReferenceTable;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.AreEqual('DateTime', FSchema.Table['Table1'].ForeignKey['FK1'].FieldsReference[0].Name);

  Assert.AreEqual('Tinyint', FSchema.Table['Table1'].ForeignKey['FK1'].FieldsReference[1].Name);

  Assert.AreEqual('DateTime', FSchema.Table['Table1'].ForeignKey['FK2'].FieldsReference[0].Name);

  Assert.AreEqual('Date', FSchema.Table['Table2'].ForeignKey['FK3'].FieldsReference[0].Name);
end;

procedure TManipulatorSQLServerTest.TheReferenceTableOfForeignKeyMustBeLoaded;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.AreEqual(FSchema.Table['Table2'], FSchema.Table['Table1'].ForeignKey['FK1'].ReferenceTable);

  Assert.AreEqual(FSchema.Table['Table2'], FSchema.Table['Table1'].ForeignKey['FK2'].ReferenceTable);

  Assert.AreEqual(FSchema.Table['Table1'], FSchema.Table['Table2'].ForeignKey['FK3'].ReferenceTable);
end;

procedure TManipulatorSQLServerTest.WhenCallLoadTablesMustLoadAllTablesFromTheDatabase;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.AreEqual(4, FSchema.Tables.Count);
end;

procedure TManipulatorSQLServerTest.WhenCreateADefaultConstraintMustExecuteTheSQLAsExpected;
begin
  var Field := FMapper.FindTable(TMyTestClass).Field['UniqueIdentifier'];

  CheckExecution('alter table MyTable add constraint DF_MyTable_MyField default (newsequentialid()) for MyField');

  FManipulator.CreateDefaultConstraint(Field);
end;

procedure TManipulatorSQLServerTest.WhenCreateARequiredTempFieldMustLoadTheDefaultValueHasExpected;
begin
  var Field := FMapper.FindTable(TMyTestClass).Field['Field'];

  FManipulator.CreateTempField(Field);

  Assert.IsNotNull(Field.DefaultConstraint);

  Assert.AreEqual(agtFixedValue, Field.DefaultConstraint.AutoGeneratedType);

  Assert.AreEqual('0', Field.DefaultConstraint.FixedValue);
end;

procedure TManipulatorSQLServerTest.WhenCreateARequiredUniqueIdentifierFieldMustCreateTheDefaultAsExpected;
begin
  var Field := FMapper.FindTable(TMyTestClass).Field['UniqueIdentifier'];

  FManipulator.CreateTempField(Field);

  Assert.AreEqual('''00000000-0000-0000-0000-000000000000''', Field.DefaultConstraint.FixedValue);
end;

procedure TManipulatorSQLServerTest.WhenCreateTheTempFieldMustCallTheBaseClassToExecuteTheCreation;
begin
  var Field := FMapper.FindTable(TMyTestClass).Field['Field'];

  FConnection.Expect.Once.When.ExecuteDirect(It.IsAny<String>);

  FManipulator.CreateTempField(Field);

  Assert.CheckExpectation(FConnection.CheckExpectations);
end;

procedure TManipulatorSQLServerTest.WhenCreateTheTempFieldNotRequiredCantLoadTheFixedValue;
begin
  var Field := FMapper.FindTable(TMyTestClass).Field['NoRequeriedField'];

  FManipulator.CreateTempField(Field);

  Assert.IsNull(Field.DefaultConstraint);
end;

procedure TManipulatorSQLServerTest.WhenDropAnIndexMustExecuteTheSQLAsExpected;
begin
  FManipulator.LoadSchema(FSchema);

  FConnection.Setup.WillExecute(
    procedure (const Params: TArray<TValue>)
    begin
      var SQL := Params[1].AsString;

      Assert.AreEqual('drop index Index1 on Table1', SQL);
    end).When.ExecuteDirect(It.IsAny<String>);

  FManipulator.DropIndex(FSchema.Table['Table1'].Index['Index1']);
end;

procedure TManipulatorSQLServerTest.WhenDropAnIndexWithPrimaryKeyFlagMustExecuteADropConstraint;
begin
  FManipulator.LoadSchema(FSchema);

  FConnection.Setup.WillExecute(
    procedure (const Params: TArray<TValue>)
    begin
      var SQL := Params[1].AsString;

      Assert.AreEqual('alter table Table1 drop constraint Index3', SQL);
    end).When.ExecuteDirect(It.IsAny<String>);

  FManipulator.DropIndex(FSchema.Table['Table1'].Index['Index3']);
end;

procedure TManipulatorSQLServerTest.WhenLoadingTheTableCantRaiseDuplicationError;
begin
  Assert.WillNotRaise(
    procedure
    begin
      FManipulator.LoadSchema(FSchema);
    end);
end;

procedure TManipulatorSQLServerTest.WhenLoadTheFieldInfoMustLoadTheSpecialFieldInfo(const TableName, ColumnName: String; const SpecialType: TDatabaseSpecialType);
begin
  FManipulator.LoadSchema(FSchema);

  Assert.AreEqual(SpecialType, FSchema.Table[TableName].Field[ColumnName].SpecialType);
end;

procedure TManipulatorSQLServerTest.WhenLoadTheIndexMustLoadAllFieldOfTheIndexHasExpected;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.AreEqual<NativeInt>(2, Length(FSchema.Table['Table1'].Index['Index1'].Fields));

  Assert.IsNotNull(FSchema.Table['Table1'].Index['Index1'].Fields[0]);

  Assert.IsNotNull(FSchema.Table['Table1'].Index['Index1'].Fields[1]);

  Assert.AreEqual('Time', FSchema.Table['Table1'].Index['Index3'].Fields[0].Name);
end;

procedure TManipulatorSQLServerTest.WhenLoadTheSequenceMustLoadTheNameOfTheSequenceAsExpected;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.AreEqual('Sequence1', FSchema.Sequences[0].Name);

  Assert.AreEqual('Sequence2', FSchema.Sequences[1].Name);

  Assert.AreEqual('Sequence3', FSchema.Sequences[2].Name);
end;

procedure TManipulatorSQLServerTest.WhenLoadTheSequencesMustLoadTheSequenceList;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.AreEqual(3, FSchema.Sequences.Count);
end;

procedure TManipulatorSQLServerTest.WhenLoadTheTableMustLoadTheColumnsOfTheTable;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.AreEqual(4, FSchema.Table['Table1'].Fields.Count);

  Assert.AreEqual(3, FSchema.Table['Table2'].Fields.Count);

  Assert.AreEqual(5, FSchema.Table['Table3'].Fields.Count);

  Assert.AreEqual(4, FSchema.Table['Table4'].Fields.Count);
end;

procedure TManipulatorSQLServerTest.WhenLoadTheTableMustLoadTheForeignKeysOfTheTable;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.AreEqual(2, FSchema.Table['Table1'].ForeignKeys.Count);

  Assert.AreEqual(1, FSchema.Table['Table2'].ForeignKeys.Count);
end;

procedure TManipulatorSQLServerTest.WhenRenameAColumnMustExecuteTheSQLAsExpected;
begin
  var Executed := False;
  var Table := FMapper.FindTable(TMyTestClass);

  FConnection.Setup.WillExecute(
    procedure (const Params: TArray<TValue>)
    begin
      Executed := True;
      var SQL := Params[1].AsString;

      Assert.AreEqual('exec sp_rename ''MyTable.Field'', ''MyField'', ''column''', SQL);
    end).When.ExecuteDirect(It.IsAny<String>);

  FManipulator.RenameField(Table.Field['Field'], Table.Field['UniqueIdentifier']);

  Assert.IsTrue(Executed);
end;

procedure TManipulatorSQLServerTest.WhenTheFieldHasAFixedValueMustGenerateTheValueAsExpected;
begin
  var DefaultConstraint := TDefaultConstraint.Create;
  DefaultConstraint.AutoGeneratedType := agtFixedValue;
  DefaultConstraint.FixedValue := 'MyValue';

  Assert.AreEqual('MyValue', FManipulator.GetAutoGeneratedValue(DefaultConstraint));

  DefaultConstraint.Free;
end;

procedure TManipulatorSQLServerTest.WhenTheFieldHasASequenceMustGenerateTheValueAsExpected;
begin
  var DefaultConstraint := TDefaultConstraint.Create;
  DefaultConstraint.AutoGeneratedType := agtSequence;
  DefaultConstraint.Sequence := TSequence.Create('MySequence');

  Assert.AreEqual('next value for [MySequence]', FManipulator.GetAutoGeneratedValue(DefaultConstraint));

  DefaultConstraint.Sequence.Free;

  DefaultConstraint.Free;
end;

procedure TManipulatorSQLServerTest.WhenTheIndexIsPrimaryKeyMustMarkTheInfoInTheIndex;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.IsTrue(FSchema.Table['Table1'].Index['Index3'].PrimaryKey);
end;

procedure TManipulatorSQLServerTest.WhenTheIndexIsUniqueMustLoadTheInfo;
begin
  FManipulator.LoadSchema(FSchema);

  Assert.IsTrue(FSchema.Table['Table2'].Index['Index2'].Unique);
end;

end.

