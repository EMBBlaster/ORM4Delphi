﻿unit Delphi.ORM.Database.Metadata.Manipulator.Test;

interface

uses System.Rtti, System.Generics.Collections, DUnitX.TestFramework, Delphi.Mock.Intf, Delphi.ORM.Database.Metadata.Manipulator, Delphi.ORM.Database.Metadata, Delphi.ORM.Mapper,
  Delphi.ORM.Database.Connection, Delphi.ORM.Attributes;

type
  TMetadataManipulatorMock = class;

  [TestFixture]
  TMetadataManipulatorTest = class
  private
    FConnection: IMock<IDatabaseConnection>;
    FCursor: IMock<IDatabaseCursor>;
    FDatabaseField: TDatabaseField;
    FDatabaseIndex: TDatabaseIndex;
    FDatabaseSchema: TDatabaseSchema;
    FDatabaseTable: TDatabaseTable;
    FMapper: TMapper;
    FMetadataManipulator: IMetadataManipulator;
    FMetadataManipulatorClass: TMetadataManipulatorMock;
    FSQLExecuted: String;
    FTransaction: IMock<IDatabaseTransaction>;
  public
    [Setup]
    procedure Setup;
    [SetupFixture]
    procedure SetupFixture;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TheFieldDefinitionMustBuildTheSQLHasExpected;
    [Test]
    procedure IfTheFieldIsNullableMustBuildTheSQLHasExpected;
    [Test]
    procedure IfTheFieldHasASpecialTypeMustLoadThisTypeInTheSQL;
    [Test]
    procedure IfTheFieldHasCollationMustLoadTheCollationOfTheField;
    [Test]
    procedure TheFieldDefinitionMustLoadTheSQLWithTheDatabaseNameFieldName;
    [Test]
    procedure WhenTheFieldTypeIsStringMustLoadTheSizeInTheFieldDefinition;
    [Test]
    procedure WhenTheFieldTypeIsCharMustLoadTheSizeInTheFieldDefinition;
    [Test]
    procedure WhenTheFieldIsAndFloatFieldMustLoadThePrecisionAndScaleInTheFieldDefinition;
    [Test]
    procedure IfTheFieldIsASpecialTypeCantLoadTheSizeOfTheField;
    [Test]
    procedure WhenTheFieldHasDefaultValueMustLoadTheDefaultValueHasExpected;
    [Test]
    procedure WhenCreateTheTableMustBuildTheSQLHasExpected;
    [Test]
    procedure WhenCreateAFieldMustBuildTheSQLHasExpected;
    [Test]
    procedure WhenDropAFieldMustExecuteTheSQLHasExpected;
    [Test]
    procedure WhenDropATableMustExecuteTheSQLHasExpected;
    [Test]
    procedure WhenUpdateAFieldMustExecuteTheSQLHasExpected;
    [Test]
    procedure WhenDropADefaultConstratintMustExecuteTheSQLHasExpected;
    [Test]
    procedure WhenGetTheNameOfDefaultContraintFunctionMustReturnTheNameAsExpected;
    [Test]
    procedure WhenDropIndexMustExecuteTheSQLAsExpected;
    [Test]
    procedure WhenCreateAForeignKeyMustExecuteTheSQLAsExpected;
    [Test]
    procedure WhenCreateAnIndexMustExecuteTheSQLAsExpected;
    [Test]
    procedure WhenDropAForeignKeyMustExecuteTheSQLAsExpected;
    [Test]
    procedure WhenCreateATableWithManyValueAssociationThisFieldCantBeCreated;
    [Test]
    procedure WhenGetTheFieldDefinitionOfAForeignKeyFieldMustLoadTheInfoFromThePrimaryKeyOfTheForeignKeyTable;
    [Test]
    procedure IfTheForeignKeyFieldIsASpecialTypeMustUseThisTypeInTheFieldCreation;
    [Test]
    procedure WhenCreateAPrimaryKeyIndexMustExecuteTheSQLAsExpected;
    [Test]
    procedure WhenGetAllRecordsMustSelectAllRecordsFromTheDataDatabase;
    [Test]
    procedure WhenInsertARecordMustExecuteTheSQLAsExpected;
    [Test]
    procedure WhenUpdateARecordMustExecuteTheSQLAsExpected;
    [Test]
    procedure WhenCreateATableWithoutPrimaryKeyCantRaiseAnyError;
    [Test]
    procedure WhenCreateATableWithoutPrimaryKeyMustExecuteTheSQLAsExpected;
    [Test]
    procedure WhenCreateASequenceMustExecuteTheSQLAsExpected;
    [Test]
    procedure WhenDropASequenceMustExecuteTheSQLAsExpected;
    [Test]
    procedure WhenCreateAUniqueIndexMustExecuteTheSQLAsExpected;
  end;

  TMetadataManipulatorMock = class(TMetadataManipulator, IMetadataManipulator)
  private
    procedure LoadSchema(const Schema: TDatabaseSchema);
  public
    function GetAutoGeneratedValue(const DefaultConstraint: TDefaultConstraint): String; override;
    function GetFieldType(const Field: TField): String; override;
    function GetSpecialFieldType(const Field: TField): String; override;
  end;

  TMyTableForeingKey = class
  private
    FId: String;
    FValue: TDateTime;
  published
    [Size(50)]
    property Id: String read FId write FId;
    property Value: TDateTime read FValue write FValue;
  end;

  TMyTableForeingKeySpecial = class
  private
    FId: TDateTime;
  published
    property Id: TDateTime read FId write FId;
  end;

  [TableName('MyTableDB')]
  [Index('MyIndex', 'ForeignKeyField;RequiredField')]
  [UniqueKey('MyUniqueKey', 'RequiredField')]
  TMyTable = class
  private
    FDateTimeField: TDateTime;
    FStringField: String;
    FRequiredField: Integer;
    FFloatField: Double;
    FCharField: Char;
    FForeignKeyField: TMyTableForeingKey;
    FAutoGeneratedField: TDateTime;
    FForeignKeyFieldSpecial: TMyTableForeingKeySpecial;
  published
    [CurrentDateTime]
    property AutoGeneratedField: TDateTime read FAutoGeneratedField write FAutoGeneratedField;
    [Size(1)]
    property CharField: Char read FCharField write FCharField;
    property DateTimeField: TDateTime read FDateTimeField write FDateTimeField;
    [FieldName('FKField'), Required, NewUniqueIdentifier]
    property ForeignKeyField: TMyTableForeingKey read FForeignKeyField write FForeignKeyField;
    property ForeignKeyFieldSpecial: TMyTableForeingKeySpecial read FForeignKeyFieldSpecial write FForeignKeyFieldSpecial;
    [Precision(10, 5)]
    property FloatField: Double read FFloatField write FFloatField;
    property RequiredField: Integer read FRequiredField write FRequiredField;
    [Size(250)]
    property StringField: String read FStringField write FStringField;
  end;

implementation

uses System.SysUtils, Delphi.Mock, Delphi.ORM.Test.Entity;

{ TMetadataManipulatorTest }

procedure TMetadataManipulatorTest.IfTheFieldHasASpecialTypeMustLoadThisTypeInTheSQL;
begin
  var Field := FMapper.FindTable(TMyTable).Field['DateTimeField'];

  Assert.AreEqual('DateTimeField SpecialFieldType not null', FMetadataManipulatorClass.GetFieldDefinition(Field));
end;

procedure TMetadataManipulatorTest.IfTheFieldHasCollationMustLoadTheCollationOfTheField;
begin
  var Field := FMapper.FindTable(TMyTable).Field['StringField'];
  Field.Collation := 'MyCollate';

  Assert.AreEqual('StringField FieldType(250) not null collate MyCollate', FMetadataManipulatorClass.GetFieldDefinition(Field));
end;

procedure TMetadataManipulatorTest.IfTheFieldIsASpecialTypeCantLoadTheSizeOfTheField;
begin
  var Field := FMapper.FindTable(TMyTable).Field['DateTimeField'];
  Field.Scale := 5;
  Field.Size := 10;

  Assert.AreEqual('DateTimeField SpecialFieldType not null', FMetadataManipulatorClass.GetFieldDefinition(Field));
end;

procedure TMetadataManipulatorTest.IfTheFieldIsNullableMustBuildTheSQLHasExpected;
begin
  var Field := FMapper.FindTable(TMyTable).Field['RequiredField'];
  Field.Required := False;

  Assert.AreEqual('RequiredField FieldType null', FMetadataManipulatorClass.GetFieldDefinition(Field));
end;

procedure TMetadataManipulatorTest.IfTheForeignKeyFieldIsASpecialTypeMustUseThisTypeInTheFieldCreation;
begin
  var Field := FMapper.FindTable(TMyTable).Field['ForeignKeyFieldSpecial'];

  Assert.AreEqual('IdForeignKeyFieldSpecial SpecialFieldType null', FMetadataManipulatorClass.GetFieldDefinition(Field));
end;

procedure TMetadataManipulatorTest.Setup;
begin
  FConnection := TMock.CreateInterface<IDatabaseConnection>(True);
  FCursor := TMock.CreateInterface<IDatabaseCursor>(True);
  FDatabaseSchema := TDatabaseSchema.Create;
  FDatabaseTable := TDatabaseTable.Create(FDatabaseSchema, 'MyTableDB');
  FMapper := TMapper.Create;
  FMetadataManipulatorClass := TMetadataManipulatorMock.Create(FConnection.Instance);
  FSQLExecuted := EmptyStr;
  FTransaction := TMock.CreateInterface<IDatabaseTransaction>(True);

  FDatabaseField := TDatabaseField.Create(FDatabaseTable, 'MyFieldDB');
  FDatabaseIndex := TDatabaseIndex.Create(FDatabaseTable, 'MyIndex');
  FMetadataManipulator := FMetadataManipulatorClass;

  FMapper.LoadClass(TMyTable);

  FMapper.LoadClass(TMyEntityWithManyValueAssociation);

  FMapper.LoadClass(TMyEntity2);

  FConnection.Setup.WillExecute(
    procedure (const Params: TArray<TValue>)
    begin
      FSQLExecuted := Params[1].AsString;
    end).When.ExecuteDirect(It.IsAny<String>);

  FConnection.Setup.WillExecute(
    function (const Params: TArray<TValue>): TValue
    begin
      FSQLExecuted := Params[1].AsString;
      Result := TValue.From(FCursor.Instance);
    end).When.OpenCursor(It.IsAny<String>);

  FConnection.Setup.WillExecute(
    function (const Params: TArray<TValue>): TValue
    begin
      FSQLExecuted := Params[1].AsString;
      Result := TValue.From(FCursor.Instance);
    end).When.ExecuteInsert(It.IsAny<String>, It.IsAny<TArray<String>>);

  FConnection.Setup.WillExecute(
    function (const Params: TArray<TValue>): TValue
    begin
      Result := TValue.From(FTransaction.Instance);
    end).When.StartTransaction;
end;

procedure TMetadataManipulatorTest.SetupFixture;
begin
  Setup;

  TearDown;
end;

procedure TMetadataManipulatorTest.TearDown;
begin
  FConnection := nil;
  FCursor := nil;
  FMetadataManipulator := nil;
  FSQLExecuted := EmptyStr;
  FTransaction := nil;

  FDatabaseSchema.Free;

  FMapper.Free;
end;

procedure TMetadataManipulatorTest.TheFieldDefinitionMustBuildTheSQLHasExpected;
begin
  var Field := FMapper.FindTable(TMyTable).Field['RequiredField'];

  Assert.AreEqual('RequiredField FieldType not null', FMetadataManipulatorClass.GetFieldDefinition(Field));
end;

procedure TMetadataManipulatorTest.TheFieldDefinitionMustLoadTheSQLWithTheDatabaseNameFieldName;
begin
  var Field := FMapper.FindTable(TMyTable).Field['RequiredField'];
  Field.DatabaseName := 'IdMyField';
  Field.Name := 'MyField';

  Assert.AreEqual('IdMyField FieldType not null', FMetadataManipulatorClass.GetFieldDefinition(Field));
end;

procedure TMetadataManipulatorTest.WhenCreateAFieldMustBuildTheSQLHasExpected;
begin
  var Field := FMapper.FindTable(TMyTable).Field['RequiredField'];
  var SQL := 'alter table MyTableDB add RequiredField FieldType not null';

  FMetadataManipulator.CreateField(Field);

  Assert.AreEqual(SQL, FSQLExecuted);
end;

procedure TMetadataManipulatorTest.WhenCreateAForeignKeyMustExecuteTheSQLAsExpected;
begin
  var SQL := 'alter table MyTableDB add constraint FK_MyTableDB_MyTableForeingKey_FKField foreign key (FKField) references MyTableForeingKey (Id)';

  FMetadataManipulator.CreateForeignKey(FMapper.FindTable(TMyTable).ForeignKeys[0]);

  Assert.AreEqual(SQL, FSQLExecuted);
end;

procedure TMetadataManipulatorTest.WhenCreateAnIndexMustExecuteTheSQLAsExpected;
begin
  var SQL := 'create index MyIndex on MyTableDB (FKField,RequiredField)';

  FMetadataManipulator.CreateIndex(FMapper.FindTable(TMyTable).Indexes[0]);

  Assert.AreEqual(SQL, FSQLExecuted);
end;

procedure TMetadataManipulatorTest.WhenCreateAPrimaryKeyIndexMustExecuteTheSQLAsExpected;
begin
  var Index := FMapper.FindTable(TMyEntity2).Indexes[0];
  var SQL := 'alter table AnotherTableName add constraint PK_AnotherTableName primary key (Id)';

  FMetadataManipulator.CreateIndex(Index);

  Assert.AreEqual(SQL, FSQLExecuted);
end;

procedure TMetadataManipulatorTest.WhenCreateASequenceMustExecuteTheSQLAsExpected;
begin
  var Sequence := TSequence.Create('MySequence');
  var SQL := 'create sequence MySequence increment by 1 start with 1';

  FMetadataManipulator.CreateSequence(Sequence);

  Assert.AreEqual(SQL, FSQLExecuted);

  Sequence.Free;
end;

procedure TMetadataManipulatorTest.WhenCreateATableWithManyValueAssociationThisFieldCantBeCreated;
begin
  var SQL :=
    'create table MyEntityWithManyValueAssociation (' +
      'Id FieldType not null)';

  FMetadataManipulator.CreateTable(FMapper.FindTable(TMyEntityWithManyValueAssociation));

  Assert.AreEqual(SQL, FSQLExecuted);
end;

procedure TMetadataManipulatorTest.WhenCreateATableWithoutPrimaryKeyCantRaiseAnyError;
begin
  var Table := FMapper.LoadClass(TClassWithoutPrimaryKey);

  Assert.WillNotRaise(
    procedure
    begin
      FMetadataManipulator.CreateTable(Table);
    end);
end;

procedure TMetadataManipulatorTest.WhenCreateATableWithoutPrimaryKeyMustExecuteTheSQLAsExpected;
begin
  var SQL :=
    'create table ClassWithoutPrimaryKey (' +
      'Value FieldType not null)';
  var Table := FMapper.LoadClass(TClassWithoutPrimaryKey);

  FMetadataManipulator.CreateTable(Table);

  Assert.AreEqual(SQL, FSQLExecuted);
end;

procedure TMetadataManipulatorTest.WhenCreateAUniqueIndexMustExecuteTheSQLAsExpected;
begin
  var SQL := 'create unique index MyUniqueKey on MyTableDB (RequiredField)';

  FMetadataManipulator.CreateIndex(FMapper.FindTable(TMyTable).Indexes[1]);

  Assert.AreEqual(SQL, FSQLExecuted);
end;

procedure TMetadataManipulatorTest.WhenCreateTheTableMustBuildTheSQLHasExpected;
begin
  var SQL :=
    'create table MyTableForeingKey (' +
      'Id FieldType(50) not null,' +
      'Value SpecialFieldType not null)';
  var Table := FMapper.FindTable(TMyTableForeingKey);

  FMetadataManipulator.CreateTable(Table);

  Assert.AreEqual(SQL, FSQLExecuted);
end;

procedure TMetadataManipulatorTest.WhenDropADefaultConstratintMustExecuteTheSQLHasExpected;
begin
  var SQL := 'alter table MyTableDB drop constraint MyConstraint';

  TDatabaseDefaultConstraint.Create(FDatabaseField, 'MyConstraint', 'MyValue');

  FMetadataManipulator.DropDefaultConstraint(FDatabaseField);

  Assert.AreEqual(SQL, FSQLExecuted);
end;

procedure TMetadataManipulatorTest.WhenDropAFieldMustExecuteTheSQLHasExpected;
begin
  var SQL := 'alter table MyTableDB drop column MyFieldDB';

  FMetadataManipulatorClass.DropField(FDatabaseField);

  Assert.AreEqual(SQL, FSQLExecuted);
end;

procedure TMetadataManipulatorTest.WhenDropAForeignKeyMustExecuteTheSQLAsExpected;
begin
  var DatabaseForeignKey := TDatabaseForeignKey.Create(FDatabaseTable, 'MyForeignKey', FDatabaseTable);
  var SQL := 'alter table MyTableDB drop constraint MyForeignKey';

  FMetadataManipulator.DropForeignKey(DatabaseForeignKey);

  Assert.AreEqual(SQL, FSQLExecuted);
end;

procedure TMetadataManipulatorTest.WhenDropASequenceMustExecuteTheSQLAsExpected;
begin
  var Sequence := TDatabaseSequence.Create('MySequence');
  var SQL := 'drop sequence MySequence';

  FMetadataManipulator.DropSequence(Sequence);

  Assert.AreEqual(SQL, FSQLExecuted);

  Sequence.Free;
end;

procedure TMetadataManipulatorTest.WhenDropATableMustExecuteTheSQLHasExpected;
begin
  var SQL := 'drop table MyTableDB';

  FMetadataManipulatorClass.DropTable(FDatabaseTable);

  Assert.AreEqual(SQL, FSQLExecuted);
end;

procedure TMetadataManipulatorTest.WhenDropIndexMustExecuteTheSQLAsExpected;
begin
  var SQL := 'drop index MyIndex on MyTableDB';

  FMetadataManipulator.DropIndex(FDatabaseIndex);

  Assert.AreEqual(SQL, FSQLExecuted);
end;

procedure TMetadataManipulatorTest.WhenGetAllRecordsMustSelectAllRecordsFromTheDataDatabase;
begin
  var SQL := 'select T1.Id F1,T1.Value F2 from ClassWithPrimaryKey T1';

  FMetadataManipulatorClass.GetAllRecords(FMapper.LoadClass(TClassWithPrimaryKey));

  Assert.AreEqual(SQL, FSQLExecuted);
end;

procedure TMetadataManipulatorTest.WhenGetTheFieldDefinitionOfAForeignKeyFieldMustLoadTheInfoFromThePrimaryKeyOfTheForeignKeyTable;
begin
  var Field := FMapper.FindTable(TMyTable).Field['ForeignKeyField'];

  Assert.AreEqual('FKField FieldType(50) not null constraint DF_MyTableDB_FKField default(AutoGeneratedValue)', FMetadataManipulatorClass.GetFieldDefinition(Field));
end;

procedure TMetadataManipulatorTest.WhenGetTheNameOfDefaultContraintFunctionMustReturnTheNameAsExpected;
begin
  var Field := FMapper.FindTable(TMyTable).Field['RequiredField'];
  Field.DatabaseName := 'MyFieldDB';

  Assert.AreEqual('DF_MyTableDB_MyFieldDB', FMetadataManipulator.GetDefaultConstraintName(Field));
end;

procedure TMetadataManipulatorTest.WhenInsertARecordMustExecuteTheSQLAsExpected;
begin
  var MyClass := TClassWithPrimaryKey.Create;
  MyClass.Value := 123;
  var SQL := 'insert into ClassWithPrimaryKey(Value)values(123)';

  FMetadataManipulatorClass.InsertRecord(MyClass);

  Assert.AreEqual(SQL, FSQLExecuted);
end;

procedure TMetadataManipulatorTest.WhenTheFieldHasDefaultValueMustLoadTheDefaultValueHasExpected;
begin
  var Field := FMapper.FindTable(TMyTable).Field['AutoGeneratedField'];

  Assert.AreEqual('AutoGeneratedField SpecialFieldType not null constraint DF_MyTableDB_AutoGeneratedField default(AutoGeneratedValue)', FMetadataManipulatorClass.GetFieldDefinition(Field));
end;

procedure TMetadataManipulatorTest.WhenTheFieldIsAndFloatFieldMustLoadThePrecisionAndScaleInTheFieldDefinition;
begin
  var Field := FMapper.FindTable(TMyTable).Field['FloatField'];

  Assert.AreEqual('FloatField FieldType(10,5) not null', FMetadataManipulatorClass.GetFieldDefinition(Field));
end;

procedure TMetadataManipulatorTest.WhenTheFieldTypeIsCharMustLoadTheSizeInTheFieldDefinition;
begin
  var Field := FMapper.FindTable(TMyTable).Field['CharField'];

  Assert.AreEqual('CharField FieldType(1) not null', FMetadataManipulatorClass.GetFieldDefinition(Field));
end;

procedure TMetadataManipulatorTest.WhenTheFieldTypeIsStringMustLoadTheSizeInTheFieldDefinition;
begin
  var Field := FMapper.FindTable(TMyTable).Field['StringField'];

  Assert.AreEqual('StringField FieldType(250) not null', FMetadataManipulatorClass.GetFieldDefinition(Field));
end;

procedure TMetadataManipulatorTest.WhenUpdateAFieldMustExecuteTheSQLHasExpected;
begin
  var SQL := 'update MyTableDB set RequiredField = StringField';
  var Table := FMapper.FindTable(TMyTable);

  FMetadataManipulatorClass.UpdateField(Table.Field['StringField'], Table.Field['RequiredField']);

  Assert.AreEqual(SQL, FSQLExecuted);
end;

procedure TMetadataManipulatorTest.WhenUpdateARecordMustExecuteTheSQLAsExpected;
begin
  var MyClass := TClassWithPrimaryKey.Create;
  MyClass.Id := 123;
  MyClass.Value := 123;
  var SQL := 'update ClassWithPrimaryKey set Value=444 where Id=123';

  FMetadataManipulatorClass.InsertRecord(MyClass);

  MyClass.Value := 444;

  FMetadataManipulatorClass.UpdateRecord(MyClass);

  Assert.AreEqual(SQL, FSQLExecuted);
end;

{ TMetadataManipulatorMock }

function TMetadataManipulatorMock.GetAutoGeneratedValue(const DefaultConstraint: TDefaultConstraint): String;
begin
  Result := 'AutoGeneratedValue';
end;

function TMetadataManipulatorMock.GetFieldType(const Field: TField): String;
begin
  Result := 'FieldType';
end;

function TMetadataManipulatorMock.GetSpecialFieldType(const Field: TField): String;
begin
  Result := 'SpecialFieldType';
end;

procedure TMetadataManipulatorMock.LoadSchema(const Schema: TDatabaseSchema);
begin

end;

end.

