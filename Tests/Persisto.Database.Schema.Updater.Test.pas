﻿unit Persisto.Database.Schema.Updater.Test;

interface

uses System.SysUtils, System.Generics.Collections, DUnitX.TestFramework, Persisto, Persisto.Mapping;

type
  [TestFixture]
  TDatabaseSchemaUpdaterTest = class
  private
    FManager: TManager;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure IfTheTableDontExistsInTheDatabaseMustCreateTheTable;
    [Test]
    procedure OnlyTheTableNoExistingTableMustCreatedInTheDatabase;
    [Test]
    procedure WhenCreateATableMustCreateAllFieldsOfTheTableToo;
    [Test]
    procedure TheTableWithManyValueAssociationFieldCantTryToCreateTheFieldMustBeIgnored;
    [Test]
    procedure WhenCreateAFieldMustLoadTheFieldInfoTypeFromTheManipulador;
    [Test]
    procedure WhenComparingNamesOfTablesMustBeCaseInsensitivityTheComparision;
    [Test]
    procedure IfTheTableExistsInTheDatabaseMustCreateTheFieldThatDontExists;
    [Test]
    procedure IfTheForeignKeyNotExistsInTheDatabaseMustBeCreated;
    [Test]
    procedure IfTheForeignKeyExistsInDatabaseButTheFieldHasADifferentNameMustRecreateTheForeignKey;
    [Test]
    procedure IfTheForeignKeyExistsInDatabaseButNotExistsInTheMapperTheForeignKeyMustBeRemoved;
    [Test]
    procedure WhenTheTableIsntMappedMustDropTheTable;
    [Test]
    procedure WhenTheIndexDontExistInDatabaseMustCreateIt;
    [Test]
    procedure WhenExistsMoreThenOneIndexMustCreateAll;
    [Test]
    procedure IfTheIndexDontExistsInTheMappingClassesMustBeDropped;
    [Test]
    procedure TheIndexCanBeCreatedOnlyIfNotExistsInDatabase;
    [Test]
    procedure WhenTheIndexExistsInDatabaseButTheFieldsAreDiffentMustRecreateTheIndex;
    [Test]
    procedure WhenTheFieldDontExistsInTheMappingMustBeDropedFromTheTable;
    [Test]
    procedure WhenTryToGetATableAndIsntInTheListMustReturnNil;
    [Test]
    procedure WhenTheTableIsInTheListMustReturnTheTable;
    [Test]
    procedure WhenFindAnObjectInTheListMustReturnTheObjectWhenFindByName;
    [Test]
    procedure TheComparisionOfNamesMustBeCaseInsensitive;
    [Test]
    procedure WhenFindAForeignKeyInATableMustReturnTheForeignKey;
    [Test]
    procedure WhenGetAFieldInDatabaseTableMustReturnTheFieldInTheList;
    [Test]
    procedure WhenGetAnIndexInDatabaseTableMustReturnTheIndexInTheList;
    [Test]
    procedure WhenCheckTheSchemaCantRaiseAnyError;
    [Test]
    procedure WhenTheFieldHasChangedMustCreateATempFieldForTransferTheFieldData;
    [Test]
    procedure AfterCreatingTheTempFieldMustTransferTheDataForTheTempField;
    [Test]
    procedure AfterTransferTheDataMustDropTheFieldFromDatabase;
    [Test]
    procedure AfterDropTheFieldMustCreateTheNewField;
    [Test]
    procedure AfterTransferTheDataMustDropTheTempField;
    [Test]
    procedure TheTempFieldMustHaveTheSamePropertiesOfTheOriginalFieldExceptByTheNameOfTheField;
    [Test]
    procedure IfTheFieldHaveASpecialTypeMustBeCopiedInTheTempField;
    [Test]
    procedure WhenTheFieldIsntChangedCantRecreateTheField;
    [Test]
    procedure WhenChangeTheTypeOfAFieldMustRecreateTheField;
    [Test]
    procedure WhenTheFieldIsAnEnumeratorAndTheDatabaseFieldTypeIsIntegerCantRecreateTheField;
    [Test]
    procedure WhenTheSizeOfTheFieldWasChangedMustRecreateTheField;
    [Test]
    procedure IfThePrecisionHasChangedMustRecreateTheField;
    [Test]
    procedure WhenTheSpecialTypeOfTheFieldHasChangedMustRecreateTheField;
    [Test]
    procedure WhenTheRequiredValueHasChangedMustRecreateTheField;
    [Test]
    procedure WhenTheDatabaseFieldDontHaveDefaultValueAndTheFieldDontHaveADefaultValueCantRecreateTheDefaultConstraint;
    [Test]
    procedure WhenTheDatabaseFieldHaveDefaultValueAndTheFieldHaveADefaultValueCantRecreateTheDefaultConstraint;
    [Test]
    procedure WhenTheDatabaseFieldHaveDefaultValueAndTheFieldDontHaveADefaultValueMustRecreateTheDefaultConstraint;
    [Test]
    procedure WhenTheDatabaseFieldDontHaveDefaultValueAndTheFieldHaveADefaultValueMustRecreateTheDefaultConstraint;
    [Test]
    procedure WhenTheDefaultConstraintNameHasChangedMustRecreateTheDefaultConstraint;
    [Test]
    procedure WhenTheDefaultValueHasChangedMustRecreateTheConstraint;
    [Test]
    procedure WhenDropAFieldMustDropTheIndexesBeforeDropTheField;
    [Test]
    procedure WhenDropAFieldMustDropTheForeignKeyWithThisFieldIsLinked;
    [Test]
    procedure WhenDropAFieldThatIsAReferenceOfAForeignKeyMustDropAllForeignKeyLinkedToThisField;
    [Test]
    procedure WhenDropAnIndexForFieldChangeMustCreateTheIndexAgain;
    [Test]
    procedure WhenDropAnForeignKeyForFieldChangeMustCreateTheForeignKeyAgain;
    [Test]
    procedure OnlyTheFieldThatTheSizeMatterMustBeRecreated;
    [Test]
    procedure OnlyTheFloatFieldMustCheckThePrecisionChange;
    [Test]
    procedure WhenRemoveTheDefualtConstraintOfAFieldCantTryToCreateTheDefualtConstraintAgain;
    [Test]
    procedure WhenTheFieldIsManyValueAssociationCantCreateThisTypeOfField;
    [Test]
    procedure WhenTheFieldIsBooleanTypeCantBeRecreatedAllTheTime;
    [Test]
    procedure WhenTheFieldAddADefaultConstraintCantTryToDropTheConstraint;
    [Test]
    procedure WhenCreateATempFieldOfAForeignKeyMustLoadThePropertiesAsExpected;
    [Test]
    procedure IfTheFieldIsRecreatedTheDefaultConstraintDontNeedToBeCreated;
    [Test]
    procedure WhenThePrimaryKeyIndexAsChangedTheNameMustRecreateTheIndex;
    [Test]
    procedure WhenTheIndexWasDropedMustRemoveAllForeignKeysToTheTable;
    [Test]
    procedure WhenTheFieldNameDontHaveTheSameCaseNameMustRenameTheField;
    [Test]
    procedure AfterRenameTheFieldInDatabaseMustChangeTheInTheClass;
    [Test]
    procedure WhenDontFindThePrimaryKeyIndexMustCreateTheIndex;
    [Test]
    procedure BeforeDropATableMustDropAllForeignKeysThatReferencesThisTable;
    [Test]
    procedure WhenTheTableHasDefaultRecordsMustLoadTheRecordsOfTheTableFromDatabase;
    [Test]
    procedure WhenTheDefaultRecordsArentInTheTableMustBeAllInserted;
    [Test]
    procedure WhenTheRecordAlreadyInTheDatabaseMustUpdateTheRecord;
    [Test]
    procedure WhenTheSequenceNotExistsInDatabaseMustBeCreated;
    [Test]
    procedure WhenTheSequenceNotExistsInTheMapperMustBeDroped;
    [Test]
    procedure WhenCreateTheTableMustCreateThePrimaryKeyIndexOfTheTable;
    [Test]
    procedure WhenCreateTheTableMustCreateAllForeignKeysOfTheTable;
    [Test]
    procedure WhenAnIndexBecameUniqueMustRecreateTheIndex;
  end;

  TMyForeignKeyClass = class
  private
    FId: String;
  published
    [Size(50)]
    property Id: String read FId write FId;
  end;

  TMyAnotherForeignKeyClass = class
  private
    FId: Integer;
  published
    property Id: Integer read FId write FId;
  end;

  [Index('MyIndex', 'AnotherForeignKey')]
  [Index('MyIndex2', 'AnotherForeignKey')]
  [Index('MyIndex3', 'ForeignKey;AnotherForeignKey')]
  [Index('MyIndex4', 'ForeignKey')]
  [UniqueKey('UniqueKey', 'Id')]
  TMyClass = class
  private
    FAnotherForeignKey: TMyAnotherForeignKeyClass;
    FForeignKey: TMyForeignKeyClass;
    FForeignKey2: TMyForeignKeyClass;
    FId: String;
  published
    property AnotherForeignKey: TMyAnotherForeignKeyClass read FAnotherForeignKey write FAnotherForeignKey;
    property Id: String read FId write FId;
    property ForeignKey: TMyForeignKeyClass read FForeignKey write FForeignKey;
    property ForeignKey2: TMyForeignKeyClass read FForeignKey2 write FForeignKey2;
  end;

  TMyEnumerator = (meOne, meTwo, meThree);

  TMyClassWithAllFieldsType = class
  private
    FBigint: Int64;
    FBoolean: Boolean;
    FByte: Byte;
    FChar: Char;
    FDate: TDate;
    FDateTime: TDateTime;
    FDefaultField: String;
    FEnumerator: TMyEnumerator;
    FFloat: Double;
    FInteger: Integer;
    FSmallint: Word;
    FText: String;
    FTime: TTime;
    FUniqueIdentifier: String;
    FVarChar: String;
    FNullField: Nullable<Integer>;
    FDefaultInternalFunction: String;
  published
    property Boolean: Boolean read FBoolean write FBoolean;
    property Bigint: Int64 read FBigint write FBigint;
    property Byte: Byte read FByte write FByte;
    property Char: Char read FChar write FChar;
    [CurrentDate]
    property Date: TDate read FDate write FDate;
    [CurrentDateTime]
    property DateTime: TDateTime read FDateTime write FDateTime;
    [FieldInfo(10)]
    [NewGuid]
    property DefaultField: String read FDefaultField write FDefaultField;
    [FieldInfo(10)]
    [NewUniqueIdentifier]
    property DefaultInternalFunction: String read FDefaultInternalFunction write FDefaultInternalFunction;
    property Enumerator: TMyEnumerator read FEnumerator write FEnumerator;
    [FieldInfo(10, 5)]
    property Float: Double read FFloat write FFloat;
    [Sequence('Integer')]
    property Integer: Integer read FInteger write FInteger;
    property NullField: Nullable<Integer> read FNullField write FNullField;
    property Smallint: Word read FSmallint write FSmallint;
    [FieldInfo(stText)]
    property Text: String read FText write FText;
    [CurrentTime]
    property Time: TTime read FTime write FTime;
    [FieldInfo(stUniqueIdentifier)]
    [NewUniqueIdentifier]
    property UniqueIdentifier: String read FUniqueIdentifier write FUniqueIdentifier;
    [FieldInfo(150)]
    [NewUniqueIdentifier]
    property VarChar: String read FVarChar write FVarChar;
  end;

  TClassWithSequence = class
  private
    FId: Integer;
    FSequence: String;
  published
    property Id: Integer read FId write FId;
    [Sequence('MySequence')]
    property Sequence: String read FSequence write FSequence;
    [Sequence('AnotherSequence')]
    property AnotherSequence: String read FSequence write FSequence;
  end;

implementation

uses System.Rtti, Translucent, Translucent.Intf, Persisto.Test.Entity, Persisto.Test.Connection;

{ TDatabaseSchemaUpdaterTest }

procedure TDatabaseSchemaUpdaterTest.AfterCreatingTheTempFieldMustTransferTheDataForTheTempField;
begin
//  var Field := FMapper.GetTable(TMyClassWithAllFieldsType).Field['Integer'];
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Integer'].FieldType := tkUnknown;
//    end;
//
//  FMetadataManipulator.Setup.WillExecute(
//    procedure (const Params: TArray<TValue>)
//    begin
//      Assert.StartsWith('TempField', Params[2].AsType<TField>.DatabaseName);
//    end).When.UpdateField(It.IsEqualTo(Field), It.IsAny<TField>);
//
//  FMetadataManipulator.Expect.Once.When.UpdateField(It.IsEqualTo(Field), It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.AfterDropTheFieldMustCreateTheNewField;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Integer'].FieldType := tkUnknown;
//    end;
//
//  FMetadataManipulator.Setup.WillExecute(
//    procedure (const Params: TArray<TValue>)
//    begin
//      Assert.AreEqual('Integer', Params[2].AsType<TField>.Name);
//    end).When.RenameField(It.IsAny<TField>, It.IsAny<TField>);
//
//  FMetadataManipulator.Expect.Once.When.RenameField(It.IsAny<TField>, It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.AfterRenameTheFieldInDatabaseMustChangeTheInTheClass;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Integer'].Name := 'INTEGER';
//    end;
//
//  FMetadataManipulator.Setup.WillExecute(
//    procedure (const Params: TArray<TValue>)
//    begin
//      Assert.AreEqual('Integer', FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Integer'].Name, False);
//    end).When.RenameField(It.IsAny<TField>, It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
end;

procedure TDatabaseSchemaUpdaterTest.AfterTransferTheDataMustDropTheFieldFromDatabase;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Integer'].FieldType := tkUnknown;
//    end;
//
//  FMetadataManipulator.Setup.WillExecute(
//    procedure (const Params: TArray<TValue>)
//    begin
//      Assert.AreEqual('Integer', Params[1].AsType<TDatabaseField>.Name);
//    end).When.DropField(It.IsAny<TDatabaseField>);
//
//  FMetadataManipulator.Expect.Once.When.DropField(It.IsAny<TDatabaseField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.AfterTransferTheDataMustDropTheTempField;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Integer'].FieldType := tkUnknown;
//    end;
//
//  FMetadataManipulator.Setup.WillExecute(
//    procedure (const Params: TArray<TValue>)
//    begin
//      Assert.StartsWith('TempField', Params[1].AsType<TField>.DatabaseName);
//    end).When.RenameField(It.IsAny<TField>, It.IsAny<TField>);
//
//  FMetadataManipulator.Expect.Once.When.RenameField(It.IsAny<TField>, It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.BeforeDropATableMustDropAllForeignKeysThatReferencesThisTable;
begin
//  var ExecutionCount := 0;
//
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyForeignKeyClass'].Name := 'AnotherName';
//    end;
//
//  FMetadataManipulator.Setup.WillExecute(
//    procedure
//    begin
//      Inc(ExecutionCount);
//    end).When.DropForeignKey(It.IsAny<TDatabaseForeignKey>);
//
//  FMetadataManipulator.Setup.WillExecute(
//    procedure
//    begin
//      Assert.IsTrue(ExecutionCount > 0);
//    end).When.DropTable(It.IsAny<TDatabaseTable>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.AreEqual(2, ExecutionCount);
end;

procedure TDatabaseSchemaUpdaterTest.IfTheFieldHaveASpecialTypeMustBeCopiedInTheTempField;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['DateTime'].FieldType := tkUnknown;
//    end;
//
//  FMetadataManipulator.Setup.WillExecute(
//    procedure (const Params: TArray<TValue>)
//    begin
//      var TempField := Params[1].AsType<TField>;
//
//      Assert.AreEqual(stDateTime, TempField.SpecialType);
//    end).When.CreateTempField(It.IsAny<TField>);
//
//  FMetadataManipulator.Expect.Once.When.CreateTempField(It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.IfTheFieldIsRecreatedTheDefaultConstraintDontNeedToBeCreated;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      var DatabaseField := FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['DefaultField'];
//      DatabaseField.FieldType := tkUnknown;
//
//      FreeAndNil(DatabaseField.DefaultConstraint);
//    end;
//
//  FMetadataManipulator.Expect.Never.When.DropDefaultConstraint(It.IsAny<TDatabaseField>);
//
//  FMetadataManipulator.Expect.Never.When.CreateDefaultConstraint(It.IsAny<TField>);
//
//  Assert.WillNotRaise(
//    procedure
//    begin
//      FDatabaseMetadataUpdate.UpdateDatabase;
//    end);
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.IfTheForeignKeyExistsInDatabaseButNotExistsInTheMapperTheForeignKeyMustBeRemoved;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      var ForeignKey := TDatabaseForeignKey.Create(FDatabaseSchema.Table['MyClass'], 'MyForeignKey', nil);
//
//      FMetadataManipulator.Expect.Once.When.DropForeignKey(It.IsEqualTo(ForeignKey));
//    end;
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.IfTheForeignKeyExistsInDatabaseButTheFieldHasADifferentNameMustRecreateTheForeignKey;
begin
//  var ForeignKey: TDatabaseForeignKey;
//  var Table := FMapper.GetTable(TMyClass);
//
//  FOnSchemaLoad :=
//    procedure
//    begin
//      var Table := FDatabaseSchema.Table['MyClass'];
//
//      ForeignKey := Table.ForeignKeys[0];
//      ForeignKey.Fields[0] := Table.Field['IdForeignKey'];
//
//      FMetadataManipulator.Expect.Once.When.DropForeignKey(It.IsEqualTo(ForeignKey));
//    end;
//
//  FMetadataManipulator.Expect.Once.When.CreateForeignKey(It.IsEqualTo(Table.ForeignKeys[0]));
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.IfTheForeignKeyNotExistsInTheDatabaseMustBeCreated;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      RemoveForeignKey('MyClass', 'FK_MyClass_MyForeignKeyClass_IdForeignKey');
//    end;
//  var Table := FMapper.GetTable(TMyClass);
//
//  FMetadataManipulator.Expect.Never.When.CreateForeignKey(It.IsEqualTo(Table.ForeignKeys[0]));
//
//  FMetadataManipulator.Expect.Once.When.CreateForeignKey(It.IsEqualTo(Table.ForeignKeys[1]));
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.IfTheIndexDontExistsInTheMappingClassesMustBeDropped;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      var DatabaseTable := FDatabaseSchema.Table['MyClass'];
//      var Index := TDatabaseIndex.Create(DatabaseTable, 'MyAnotherIndex');
//
//      FMetadataManipulator.Expect.Once.When.DropIndex(It.IsEqualTo(Index));
//    end;
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.IfThePrecisionHasChangedMustRecreateTheField;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Float'].Scale := 20;
//    end;
//
//  FMetadataManipulator.Expect.Once.When.CreateTempField(It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.IfTheTableDontExistsInTheDatabaseMustCreateTheTable;
begin
  FManager.UpdateDatabaseSchema;

  Assert.WillNotRaise(
    procedure
    begin
      FManager.OpenCursor('select * from MyTestClass').Next;
    end);
end;

procedure TDatabaseSchemaUpdaterTest.IfTheTableExistsInTheDatabaseMustCreateTheFieldThatDontExists;
begin
  FManager.UpdateDatabaseSchema;

  FManager.ExectDirect('alter table MyTestClass drop column Value');

  FManager.UpdateDatabaseSchema;

  var Cursor := FManager.OpenCursor('select Value from MyTestClass');

  Assert.WillNotRaise(
    procedure
    begin
      Cursor.Next;
    end);
end;

procedure TDatabaseSchemaUpdaterTest.OnlyTheFieldThatTheSizeMatterMustBeRecreated;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      for var Field in FDatabaseSchema.Table['MyClassWithAllFieldsType'].Fields do
//        Field.Size := 2000;
//
//      FMetadataManipulator.Expect.ExecutionCount(4).When.UpdateField(It.IsAny<TField>, It.IsAny<TField>);
//    end;
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.OnlyTheFloatFieldMustCheckThePrecisionChange;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      for var Field in FDatabaseSchema.Table['MyClassWithAllFieldsType'].Fields do
//        Field.Scale := 2000;
//
//      FMetadataManipulator.Expect.ExecutionCount(1).When.UpdateField(It.IsAny<TField>, It.IsAny<TField>);
//    end;
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.OnlyTheTableNoExistingTableMustCreatedInTheDatabase;
begin
  FManager.ExectDirect('create table MyTestClass (Id varchar(10))');

  Assert.WillNotRaise(
    procedure
    begin
     FManager.UpdateDatabaseSchema;
    end);
end;

procedure TDatabaseSchemaUpdaterTest.Setup;
begin
  RebootDatabase;

  FManager := TManager.Create(CreateConnection, CreateDatabaseManipulator);

  FManager.Mapper.LoadAll;
end;

procedure TDatabaseSchemaUpdaterTest.TearDown;
begin
  FManager.Free;

  DropDatabase;
end;

procedure TDatabaseSchemaUpdaterTest.TheComparisionOfNamesMustBeCaseInsensitive;
begin
//  var MyList := TObjectList<TDatabaseNamedObject>.Create;
//
//  MyList.Add(TDatabaseNamedObject.Create('A'));
//  MyList.Add(TDatabaseNamedObject.Create('B'));
//  MyList.Add(TDatabaseNamedObject.Create('C'));
//  MyList.Add(TDatabaseNamedObject.Create('D'));

//  var MyObject := TDatabaseNamedObject.FindObject<TDatabaseNamedObject>(MyList, 'c');
//
//  Assert.IsNotNull(MyObject);
//
//  Assert.AreEqual('C', MyObject.Name);
//
//  MyList.Free;
end;

procedure TDatabaseSchemaUpdaterTest.TheIndexCanBeCreatedOnlyIfNotExistsInDatabase;
begin

end;

procedure TDatabaseSchemaUpdaterTest.TheTableWithManyValueAssociationFieldCantTryToCreateTheFieldMustBeIgnored;
begin
  FManager.UpdateDatabaseSchema;

  var Cursor := FManager.OpenCursor('select * from ManyValueParentError');

  Cursor.Next;

  Assert.IsNull(Cursor.GetDataSet.FindField('Childs'));
end;

procedure TDatabaseSchemaUpdaterTest.TheTempFieldMustHaveTheSamePropertiesOfTheOriginalFieldExceptByTheNameOfTheField;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Float'].FieldType := tkUnknown;
//    end;
//
//  FMetadataManipulator.Setup.WillExecute(
//    procedure (const Params: TArray<TValue>)
//    begin
//      var TempField := Params[1].AsType<TField>;
//
//      Assert.StartsWith('TempField', TempField.DatabaseName);
//      Assert.StartsWith(TempField.DatabaseName, TempField.Name);
//
//      Assert.AreEqual(tkFloat, TempField.FieldType.TypeKind);
//      Assert.AreEqual(5, TempField.Scale);
//      Assert.AreEqual(10, TempField.Size);
//
//      Assert.IsNotNull(TempField.Table);
//
//      Assert.IsTrue(TempField.Required);
//
//      Assert.AreEqual('MyClassWithAllFieldsType', TempField.Table.Name);
//    end).When.CreateTempField(It.IsAny<TField>);
//
//  FMetadataManipulator.Expect.Once.When.CreateTempField(It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenAnIndexBecameUniqueMustRecreateTheIndex;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClass'].Index['UniqueKey'].Unique := False;
//    end;
//  var Table := FMapper.GetTable(TMyClass);
//
//  FMetadataManipulator.Expect.Once.When.DropIndex(It.IsAny<TDatabaseIndex>);
//
//  FMetadataManipulator.Expect.Once.When.CreateIndex(It.IsEqualTo(Table.Indexes[5]));
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenChangeTheTypeOfAFieldMustRecreateTheField;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Integer'].FieldType := tkUnknown;
//    end;
//
//  FMetadataManipulator.Expect.Once.When.CreateTempField(It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenCheckTheSchemaCantRaiseAnyError;
begin
//  Assert.WillNotRaise(FDatabaseMetadataUpdate.UpdateDatabase);
end;

procedure TDatabaseSchemaUpdaterTest.WhenComparingNamesOfTablesMustBeCaseInsensitivityTheComparision;
begin
  FManager.ExectDirect('create table manyvalueparenterror (id varchar(10))');

  Assert.WillNotRaise(
    procedure
    begin
      FManager.UpdateDatabaseSchema;
    end);
end;

procedure TDatabaseSchemaUpdaterTest.WhenCreateAFieldMustLoadTheFieldInfoTypeFromTheManipulador;
begin
  var FunctionCalled := False;
  var Manipulator := CreateDatabaseManipulator;
  var ManipulatorMock := TMock.CreateInterface<IDatabaseManipulator>;

  var Manager := TManager.Create(CreateConnection, ManipulatorMock.Instance);
  Manager.Mapper.GetTable(TMyClassWithAllFieldsType);

  ManipulatorMock.Setup.WillExecute(
    function: TValue
    begin
      FunctionCalled := True;
      Result := 'varchar(10)';
    end).When.GetFieldType(It.IsAny<TField>);

  ManipulatorMock.Setup.WillExecute(
    function: TValue
    begin
      Result := TValue.From(Manipulator.GetSchemaTablesScripts);
    end).When.GetSchemaTablesScripts;

  Manager.UpdateDatabaseSchema;

  Assert.IsTrue(FunctionCalled);

  Manager.Free;
end;

procedure TDatabaseSchemaUpdaterTest.WhenCreateATableMustCreateAllFieldsOfTheTableToo;
begin
  FManager.UpdateDatabaseSchema;

  var Cursor := FManager.OpenCursor('select Field, Name, Value from MyTestClass');

  Assert.WillNotRaise(
    procedure
    begin
      Cursor.Next;
    end);
end;

procedure TDatabaseSchemaUpdaterTest.WhenCreateATempFieldOfAForeignKeyMustLoadThePropertiesAsExpected;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClass'].Field['IdForeignKey'].FieldType := tkUnknown;
//    end;
//
//  FMetadataManipulator.Setup.WillExecute(
//    procedure (const Params: TArray<TValue>)
//    begin
//      var TempField := Params[1].AsType<TField>;
//
//      Assert.IsTrue(TempField.IsForeignKey);
//
//      Assert.IsNotNull(TempField.ForeignKey);
//    end).When.CreateTempField(It.IsAny<TField>);
//
//  FMetadataManipulator.Expect.Once.When.CreateTempField(It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenCreateTheTableMustCreateAllForeignKeysOfTheTable;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      RemoveTable('MyClass');
//    end;
//
//  FMetadataManipulator.Expect.ExecutionCount(3).When.CreateForeignKey(It.IsAny<TForeignKey>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenCreateTheTableMustCreateThePrimaryKeyIndexOfTheTable;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      RemoveTable('MyForeignKeyClass');
//    end;
//
//  FMetadataManipulator.Expect.Once.When.CreateIndex(It.IsAny<TIndex>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenDontFindThePrimaryKeyIndexMustCreateTheIndex;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      var DatabaseTable := FDatabaseSchema.Table['MyForeignKeyClass'];
//
////      DatabaseTable.Indexes.Remove(DatabaseTable.Index['PK_MyForeignKeyClass']);
//    end;
//  var Table := FMapper.GetTable(TMyForeignKeyClass);
//
//  FMetadataManipulator.Expect.Never.When.DropIndex(It.IsAny<TDatabaseIndex>);
//
//  FMetadataManipulator.Expect.Once.When.CreateIndex(It.IsEqualTo(Table.Indexes[0]));
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenDropAFieldMustDropTheForeignKeyWithThisFieldIsLinked;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClass'].Field['IdForeignKey'].FieldType := tkUnknown;
//    end;
//
//  FMetadataManipulator.Expect.Once.When.DropField(It.IsAny<TDatabaseField>);
//
//  FMetadataManipulator.Expect.Once.When.DropForeignKey(It.IsAny<TDatabaseForeignKey>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenDropAFieldMustDropTheIndexesBeforeDropTheField;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClass'].Field['IdAnotherForeignKey'].FieldType := tkUnknown;
//    end;
//
//  FMetadataManipulator.Expect.Once.When.DropField(It.IsAny<TDatabaseField>);
//
//  FMetadataManipulator.Expect.ExecutionCount(3).When.DropIndex(It.IsAny<TDatabaseIndex>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenDropAFieldThatIsAReferenceOfAForeignKeyMustDropAllForeignKeyLinkedToThisField;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyForeignKeyClass'].Field['Id'].FieldType := tkUnknown;
//    end;
//
//  FMetadataManipulator.Expect.Once.When.DropField(It.IsAny<TDatabaseField>);
//
//  FMetadataManipulator.Expect.ExecutionCount(2).When.DropForeignKey(It.IsAny<TDatabaseForeignKey>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenDropAnForeignKeyForFieldChangeMustCreateTheForeignKeyAgain;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClass'].Field['IdForeignKey'].FieldType := tkUnknown;
//      FDatabaseSchema.Table['MyForeignKeyClass'].Field['Id'].FieldType := tkUnknown;
//    end;
//
//  FMetadataManipulator.Expect.ExecutionCount(2).When.CreateForeignKey(It.IsAny<TForeignKey>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenDropAnIndexForFieldChangeMustCreateTheIndexAgain;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClass'].Field['IdForeignKey'].FieldType := tkUnknown;
//    end;
//
//  FMetadataManipulator.Expect.ExecutionCount(2).When.CreateIndex(It.IsAny<TIndex>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenExistsMoreThenOneIndexMustCreateAll;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      RemoveIndex('MyClass', 'MyIndex');
//
//      RemoveIndex('MyClass', 'MyIndex2');
//
//      RemoveIndex('MyClass', 'MyIndex3');
//    end;
//
//  FMetadataManipulator.Expect.ExecutionCount(3).When.CreateIndex(It.IsAny<TIndex>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenFindAForeignKeyInATableMustReturnTheForeignKey;
begin
//  var MySchema := TDatabaseSchema.Create;
//  var MyTable := TDatabaseTable.Create(MySchema, 'MyTable');
//
//  var MyForeignKey := TDatabaseForeignKey.Create(MyTable, 'MyForeignKey', nil);
//
//  Assert.IsNotNull(MyForeignKey);
//
//  Assert.AreEqual(MyForeignKey, MyTable.ForeignKey[MyForeignKey.Name]);
//
//  MySchema.Free;
end;

procedure TDatabaseSchemaUpdaterTest.WhenFindAnObjectInTheListMustReturnTheObjectWhenFindByName;
begin
//  var MyList := TObjectList<TDatabaseNamedObject>.Create;
//
//  MyList.Add(TDatabaseNamedObject.Create('A'));
//  MyList.Add(TDatabaseNamedObject.Create('B'));
//  MyList.Add(TDatabaseNamedObject.Create('C'));
//  MyList.Add(TDatabaseNamedObject.Create('D'));

//  var MyObject := TDatabaseNamedObject.FindObject<TDatabaseNamedObject>(MyList, 'C');
//
//  Assert.IsNotNull(MyObject);
//
//  Assert.AreEqual('C', MyObject.Name);
//
//  MyList.Free;
end;

procedure TDatabaseSchemaUpdaterTest.WhenGetAFieldInDatabaseTableMustReturnTheFieldInTheList;
begin
//  var MySchema := TDatabaseSchema.Create;
//  var MyTable := TDatabaseTable.Create(MySchema, 'MyTable');
//
//  var MyField := TDatabaseField.Create(MyTable, 'MyField');
//
//  Assert.IsNotNull(MyField);
//
//  Assert.AreEqual(MyField, MyTable.Field[MyField.Name]);
//
//  MySchema.Free;
end;

procedure TDatabaseSchemaUpdaterTest.WhenGetAnIndexInDatabaseTableMustReturnTheIndexInTheList;
begin
//  var MySchema := TDatabaseSchema.Create;
//  var MyTable := TDatabaseTable.Create(MySchema, 'MyTable');
//
//  var MyIndex := TDatabaseIndex.Create(MyTable, 'MyIndex');
//
//  Assert.IsNotNull(MyIndex);
//
//  Assert.AreEqual(MyIndex, MyTable.Index[MyIndex.Name]);
//
//  MySchema.Free;
end;

procedure TDatabaseSchemaUpdaterTest.WhenRemoveTheDefualtConstraintOfAFieldCantTryToCreateTheDefualtConstraintAgain;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FreeAndNil(FMapper.GetTable(TMyClassWithAllFieldsType).Field['DefaultField'].DefaultConstraint);
//    end;
//
//  FMetadataManipulator.Expect.Once.When.DropDefaultConstraint(It.IsAny<TDatabaseField>);
//
//  FMetadataManipulator.Expect.Never.When.CreateDefaultConstraint(It.IsAny<TField>);
//
//  Assert.WillNotRaise(
//    procedure
//    begin
//      FDatabaseMetadataUpdate.UpdateDatabase;
//    end);
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheDatabaseFieldDontHaveDefaultValueAndTheFieldDontHaveADefaultValueCantRecreateTheDefaultConstraint;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FreeAndNil(FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Boolean'].DefaultConstraint);
//      FreeAndNil(FMapper.GetTable(TMyClassWithAllFieldsType).Field['Boolean'].DefaultConstraint);
//    end;
//
//  FMetadataManipulator.Expect.Never.When.DropDefaultConstraint(It.IsAny<TDatabaseField>);
//
//  FMetadataManipulator.Expect.Never.When.CreateDefaultConstraint(It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheDatabaseFieldDontHaveDefaultValueAndTheFieldHaveADefaultValueMustRecreateTheDefaultConstraint;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      var Field := FMapper.GetTable(TMyClassWithAllFieldsType).Field['DefaultField'];
//      Field.DefaultConstraint := TDefaultConstraint.Create;
//      Field.DefaultConstraint.AutoGeneratedType := agtCurrentDate;
//    end;
//
//  FMetadataManipulator.Expect.Once.When.DropDefaultConstraint(It.IsAny<TDatabaseField>);
//
//  FMetadataManipulator.Expect.Once.When.CreateDefaultConstraint(It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheDatabaseFieldHaveDefaultValueAndTheFieldDontHaveADefaultValueMustRecreateTheDefaultConstraint;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      var DatabaseField := FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['DefaultField'];
//      DatabaseField.DefaultConstraint := TDatabaseDefaultConstraint.Create(DatabaseField, 'My Default', 'My Value');
//    end;
//
//  FMetadataManipulator.Expect.Once.When.DropDefaultConstraint(It.IsAny<TDatabaseField>);
//
//  FMetadataManipulator.Expect.Once.When.CreateDefaultConstraint(It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheDatabaseFieldHaveDefaultValueAndTheFieldHaveADefaultValueCantRecreateTheDefaultConstraint;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      var DatabaseField := FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Boolean'];
//      DatabaseField.DefaultConstraint := TDatabaseDefaultConstraint.Create(DatabaseField, 'Default', 'Sequence()');
//      var Field := FMapper.GetTable(TMyClassWithAllFieldsType).Field['Boolean'];
//
//      Field.DefaultConstraint := TDefaultConstraint.Create;
//      Field.DefaultConstraint.AutoGeneratedType := agtSequence;
//    end;
//
//  FMetadataManipulator.Expect.Never.When.DropDefaultConstraint(It.IsAny<TDatabaseField>);
//
//  FMetadataManipulator.Expect.Never.When.CreateDefaultConstraint(It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheDefaultConstraintNameHasChangedMustRecreateTheDefaultConstraint;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Integer'].DefaultConstraint.Name := 'Another default constraint';
//    end;
//
//  FMetadataManipulator.Expect.Once.When.DropDefaultConstraint(It.IsAny<TDatabaseField>);
//
//  FMetadataManipulator.Expect.Once.When.CreateDefaultConstraint(It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheDefaultRecordsArentInTheTableMustBeAllInserted;
begin
//  var MyClass1 := TMyClass.Create('1');
//  var MyClass2 := TMyClass.Create('2');
//  var MyClass3 := TMyClass.Create('3');
//
//  FMapper.AddDefaultRecord(MyClass1);
//
//  FMapper.AddDefaultRecord(MyClass2);
//
//  FMapper.AddDefaultRecord(MyClass3);
//
////  FMetadataManipulator.Expect.Never.When.UpdateRecord(It.IsAny<TObject>);
////
////  FMetadataManipulator.Expect.ExecutionCount(3).When.InsertRecord(It.IsAny<TObject>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
//
//  MyClass1.Free;
//
//  MyClass2.Free;
//
//  MyClass3.Free;
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheDefaultValueHasChangedMustRecreateTheConstraint;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Integer'].DefaultConstraint.Value := 'Another default value';
//    end;
//
//  FMetadataManipulator.Expect.Once.When.DropDefaultConstraint(It.IsAny<TDatabaseField>);
//
//  FMetadataManipulator.Expect.Once.When.CreateDefaultConstraint(It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheFieldAddADefaultConstraintCantTryToDropTheConstraint;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FreeAndNil(FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['DefaultField'].DefaultConstraint);
//    end;
//
//  FMetadataManipulator.Expect.Never.When.DropDefaultConstraint(It.IsAny<TDatabaseField>);
//
//  FMetadataManipulator.Expect.Once.When.CreateDefaultConstraint(It.IsAny<TField>);
//
//  Assert.WillNotRaise(
//    procedure
//    begin
//      FDatabaseMetadataUpdate.UpdateDatabase;
//    end);
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheFieldDontExistsInTheMappingMustBeDropedFromTheTable;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      var DatabaseTable := FDatabaseSchema.Table['MyClassWithAllFieldsType'];
//      var DatabaseField := TDatabaseField.Create(DatabaseTable, 'MyAnotherField');
//
//      FMetadataManipulator.Expect.Once.When.DropField(It.IsEqualTo(DatabaseField));
//    end;
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheFieldHasChangedMustCreateATempFieldForTransferTheFieldData;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Integer'].FieldType := tkUnknown;
//    end;
//
//  FMetadataManipulator.Expect.Once.When.CreateTempField(It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheFieldIsAnEnumeratorAndTheDatabaseFieldTypeIsIntegerCantRecreateTheField;
begin
//  FMetadataManipulator.Expect.Never.When.CreateTempField(It.IsAny<TField>);
//
//  FMetadataManipulator.Expect.Never.When.CreateField(It.IsEqualTo(FMapper.GetTable(TMyClassWithAllFieldsType).Field['Enumerator']));
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheFieldIsBooleanTypeCantBeRecreatedAllTheTime;
begin
//  FMetadataManipulator.Expect.Never.When.UpdateField(It.IsAny<TField>, It.IsEqualTo(FMapper.GetTable(TMyClassWithAllFieldsType).Field['Boolean']));
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheFieldIsManyValueAssociationCantCreateThisTypeOfField;
begin
//  FMetadataManipulator.Expect.Never.When.CreateField(It.IsEqualTo(FMapper.GetTable(TMyEntityWithManyValueAssociation).Field['ManyValueAssociationList']));
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheFieldIsntChangedCantRecreateTheField;
begin
//  FMetadataManipulator.Expect.Never.When.CreateTempField(It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheFieldNameDontHaveTheSameCaseNameMustRenameTheField;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Integer'].Name := 'INTEGER';
//    end;
//
//  FMetadataManipulator.Expect.Once.When.RenameField(It.IsAny<TField>, It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheIndexDontExistInDatabaseMustCreateIt;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      RemoveIndex('MyClass', 'MyIndex');
//    end;
//  var Table := FMapper.GetTable(TMyClass);
//
//  FMetadataManipulator.Expect.Once.When.CreateIndex(It.IsEqualTo(Table.Indexes[1]));
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheIndexExistsInDatabaseButTheFieldsAreDiffentMustRecreateTheIndex;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      var DatabaseTable := FDatabaseSchema.Table['MyClass'];
//      var Index := DatabaseTable.Index['MyIndex'];
//      Index.Fields[0] := DatabaseTable.Field['IdForeignKey'];
//
//      FMetadataManipulator.Expect.Once.When.DropIndex(It.IsEqualTo(Index));
//    end;
//  var Table := FMapper.GetTable(TMyClass);
//
//  FMetadataManipulator.Expect.Once.When.CreateIndex(It.IsEqualTo(Table.Indexes[1]));
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheIndexWasDropedMustRemoveAllForeignKeysToTheTable;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyForeignKeyClass'].Index['PK_MyForeignKeyClass'].Name := 'AnotherName';
//    end;
//
//  FMetadataManipulator.Setup.WillExecute(
//    procedure
//    begin
//      Assert.IsNull(FDatabaseSchema.Table['MyClass'].ForeignKey['FK_MyClass_MyForeignKeyClass_IdForeignKey']);
//      Assert.IsNull(FDatabaseSchema.Table['MyClass'].ForeignKey['FK_MyClass_MyForeignKeyClass_IdForeignKey2']);
//    end).When.DropIndex(It.IsAny<TDatabaseIndex>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
end;

procedure TDatabaseSchemaUpdaterTest.WhenThePrimaryKeyIndexAsChangedTheNameMustRecreateTheIndex;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyForeignKeyClass'].Index['PK_MyForeignKeyClass'].Name := 'AnotherName';
//    end;
//  var Table := FMapper.GetTable(TMyForeignKeyClass);
//
//  FMetadataManipulator.Expect.Once.When.DropIndex(It.IsAny<TDatabaseIndex>);
//
//  FMetadataManipulator.Expect.Once.When.CreateIndex(It.IsEqualTo(Table.Indexes[0]));
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheRecordAlreadyInTheDatabaseMustUpdateTheRecord;
begin
//  var MyClass1 := TMyClass.Create('1');
//  var MyClass2 := TMyClass.Create('2');
//  var MyClass3 := TMyClass.Create('3');
//
//  FMapper.AddDefaultRecord(MyClass1);
//
//  FMapper.AddDefaultRecord(MyClass2);
//
//  FMapper.AddDefaultRecord(MyClass3);
//
////  FMetadataManipulator.Setup.WillReturn(TValue.From<TArray<TObject>>([MyClass1, MyClass2, MyClass3])).When.GetAllRecords(It.IsAny<TTable>);
////
////  FMetadataManipulator.Expect.Never.When.InsertRecord(It.IsAny<TObject>);
////
////  FMetadataManipulator.Expect.ExecutionCount(3).When.UpdateRecord(It.IsAny<TObject>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
//
//  MyClass1.Free;
//
//  MyClass2.Free;
//
//  MyClass3.Free;
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheRequiredValueHasChangedMustRecreateTheField;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Integer'].Required := False;
//    end;
//
//  FMetadataManipulator.Expect.Once.When.CreateTempField(It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheSequenceNotExistsInDatabaseMustBeCreated;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Sequences.Remove(FDatabaseSchema.Sequence['MySequence']);
//    end;
//
//  FMetadataManipulator.Expect.Once.When.CreateSequence(It.IsAny<TSequence>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheSequenceNotExistsInTheMapperMustBeDroped;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Sequences.Add(TDatabaseSequence.Create('AnySequence'));
//    end;
//
//  FMetadataManipulator.Expect.Once.When.DropSequence(It.IsAny<TDatabaseSequence>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheSizeOfTheFieldWasChangedMustRecreateTheField;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['VarChar'].Size := 20;
//    end;
//
//  FMetadataManipulator.Expect.Once.When.CreateTempField(It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheSpecialTypeOfTheFieldHasChangedMustRecreateTheField;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      FDatabaseSchema.Table['MyClassWithAllFieldsType'].Field['Integer'].SpecialType := stDateTime;
//    end;
//
//  FMetadataManipulator.Expect.Once.When.CreateTempField(It.IsAny<TField>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheTableHasDefaultRecordsMustLoadTheRecordsOfTheTableFromDatabase;
begin
//  var MyClass := TMyClass.Create;
//
//  FMapper.AddDefaultRecord(MyClass);
//
////  FMetadataManipulator.Expect.Once.When.GetAllRecords(It.IsAny<TTable>);
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
//
//  MyClass.Free;
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheTableIsInTheListMustReturnTheTable;
begin
//  var MySchema := TDatabaseSchema.Create;
//  var MyTable := TDatabaseTable.Create(MySchema, 'MyTable');
//
//  Assert.AreEqual('MyTable', MyTable.Name);
//
//  MySchema.Free;
end;

procedure TDatabaseSchemaUpdaterTest.WhenTheTableIsntMappedMustDropTheTable;
begin
//  FOnSchemaLoad :=
//    procedure
//    begin
//      var DatabaseTable := TDatabaseTable.Create(FDatabaseSchema, 'NotExistsTable');
//
//      FMetadataManipulator.Expect.Once.When.DropTable(It.IsEqualTo(DatabaseTable));
//    end;
//
//  FDatabaseMetadataUpdate.UpdateDatabase;
//
//  Assert.CheckExpectation(FMetadataManipulator.CheckExpectations);
end;

procedure TDatabaseSchemaUpdaterTest.WhenTryToGetATableAndIsntInTheListMustReturnNil;
begin
//  var MySchema := TDatabaseSchema.Create;
//
//  TDatabaseTable.Create(MySchema, 'MyTable');
//
//  Assert.IsNull(MySchema.Table['Any Table Name']);
//
//  MySchema.Free;
end;

end.

