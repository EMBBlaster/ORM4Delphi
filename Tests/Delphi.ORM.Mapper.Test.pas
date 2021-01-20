unit Delphi.ORM.Mapper.Test;

interface

uses System.Rtti, DUnitX.TestFramework, Delphi.ORM.Attributes;

type
  [TestFixture]
  TMapperTest = class
  private
    FContext: TRttiContext;
  public
    [SetupFixture]
    procedure Setup;
    [Test]
    procedure WhenCallLoadAllMustLoadAllClassesWithTheEntityAttribute;
    [Test]
    procedure WhenTryToFindATableMustReturnTheTableOfTheClass;
    [Test]
    procedure WhenTryToFindATableWithoutTheEntityAttributeMustReturnANilValue;
    [Test]
    procedure WhenLoadATableMustLoadAllFieldsToo;
    [Test]
    procedure WhenTheFieldsAreLoadedMustFillTheNameWithTheNameOfPropertyOfTheClass;
    [Test]
    procedure WhenLoadAClassMustKeepTheOrderingOfTablesToTheFindTableContinueToWorking;
    [Test]
    procedure WhenLoadAFieldMustFillThePropertyWithThePropertyInfo;
    [Test]
    procedure WhenAClassDoesNotHaveThePrimaryKeyAttributeAndHasAnIdFieldThisWillBeThePrimaryKey;
    [Test]
    procedure WhenTheClassHaveThePrimaryKeyAttributeThePrimaryKeyWillBeTheFieldFilled;
    [Test]
    procedure TheFieldInPrimaryKeyMustBeMarkedWithInPrimaryKey;
    [Test]
    procedure TheDatabaseNameOfATableMustBeTheNameOfClassRemovingTheFirstCharOfTheClassName;
    [Test]
    procedure WhenTheClassHaveTheTableNameAttributeTheDatabaseNameMustBeLikeTheNameInAttribute;
    [Test]
    procedure OnlyPublishedFieldMutsBeLoadedInTheTable;
    [Test]
    procedure WhenTheFieldHaveTheFieldNameAttributeMustLoadThisNameInTheDatabaseName;
    [Test]
    procedure EveryPropertyThatIsAnObjectMustCreateAForeignKeyInTheListOfTheTable;
    [Test]
    procedure WhenTheForeignKeyIsCreatesMustLoadTheParentTable;
    [Test]
    procedure TheParentTableMustBeTheTableLinkedToTheField;
    [Test]
    procedure WhenTheFieldIsAClassMustFillTheDatabaseNameWithIdPlusPropertyName;
    [Test]
    procedure TheFieldOfAForeignKeyMustBeFilledWithTheFieldOfTheClassThatIsAForeignKey;
    [Test]
    procedure TheLoadingOfForeingKeyMustBeAfterAllTablesAreLoadedToTheFindTableWorksPropertily;
    [Test]
    procedure WhenMapAForeignKeyIsToAClassWithoutAPrimaryKeyMustRaiseAnError;
    [Test]
    procedure WhenCallLoadAllMoreThemOneTimeCantRaiseAnError;
    [Test]
    procedure TheClassWithTheSingleTableInheritanceAttributeCantBeMappedInTheTableList;
    [Test]
    procedure WhenAClassIsInheritedFromAClassWithTheSingleTableInheritanceAttributeMustLoadAllFieldsInTheTable;
    [Test]
    procedure WhenAClassIsInheritedFromAClassWithTheSingleTableInheritanceAttributeCantGenerateAnyForeignKey;
    [Test]
    procedure WhenTheClassIsInheritedFromANormalClassCantLoadFieldsFormTheBaseClass;
    [Test]
    procedure WhenTheClassIsInheritedFromANormalClassMustCreateAForeignKeyForTheBaseClass;
    [Test]
    procedure WhenTheClassIsInheritedFromTObjectCantCreateAForeignKeyForThatClass;
    [Test]
    procedure WhenAClassIsInheritedFromAClassWithTheSingleTableInheritanceAttributeThePrimaryKeyMustBeLoadedFromTheTopClass;
    [Test]
    procedure WhenTheClassIsInheritedFromANormalClassMustCreateAForeignKeyForTheBaseClassWithThePrimaryKeyFields;
    [Test]
    procedure WhenTheClassIsInheritedMustLoadThePrimaryKeyFromBaseClass;
    [Test]
    procedure WhenTheClassIsInheritedMustShareTheSamePrimaryKeyFromTheBaseClass;
    [Test]
    procedure WhenTheForeignKeyIsAClassAliasMustLoadTheForeignClassAndLinkToForeignKey;
    [Test]
    procedure WhenLoadMoreThenOneTimeTheSameClassCantRaiseAnError;
    [Test]
    procedure WhenAPropertyIsAnArrayMustLoadAManyValueLink;
    [Test]
    procedure TheTableOfManyValueAssociationMustBeTheChildTableOfThisLink;
    [Test]
    procedure TheFieldLinkingTheParentAndChildOfManyValueAssociationMustBeLoaded;
    [Test]
    procedure WhenTheChildClassIsDeclaredBeforeTheParentClassTheLinkBetweenOfTablesMustBeCreated;
    [Test]
    procedure TheManyValueAssociationMustLoadTheFieldThatGeneratedTheValue;
    [Test]
    procedure WhenAFieldIsWithTheAutoGeneratedAttributeMustLoadAsTrueThePropertyInField;
    [TestCase('AnsiChar', 'AnsiChar')]
    [TestCase('AnsiString', 'AnsiString')]
    [TestCase('Char', 'Char')]
    [TestCase('Enumerator', 'Enumerator')]
    [TestCase('Float', 'Float')]
    [TestCase('GUID', 'GUID')]
    [TestCase('Integer', 'Integer')]
    [TestCase('Int64', 'Int64')]
    [TestCase('String', 'String')]
    procedure WhenSetValueFieldMustLoadThePropertyOfTheClassAsWithTheValueExpected(FieldName: String);
    [Test]
    procedure WhenTheFieldValueIsNullMustLoadTheFieldWithTheEmptyValue;
    [Test]
    procedure WhenAFieldIsAForeignKeyThePropertyIsForeignKeyMustReturnTrue;
    [Test]
    procedure WhenAFieldIsAManyValueAssociationThePropertyIsManyValueAssociationReturnTrue;
    [Test]
    procedure WhenAFieldIsAForeignKeyThePropertyIsJoinLinkMustReturnTrue;
    [Test]
    procedure WhenAFieldIsAManyValueAssociationThePropertyIsJoinLinkReturnTrue;
    [Test]
    procedure TheFunctionGetValueFromFieldMustReturnTheValueOfThePropertyOfTheField;
    [TestCase('AnsiChar', 'AnsiChar')]
    [TestCase('AnsiString', 'AnsiString')]
    [TestCase('Char', 'Char')]
    [TestCase('Class', 'Class')]
    [TestCase('Empty Class', 'EmptyClass')]
    [TestCase('Enumerator', 'Enumerator')]
    [TestCase('Float', 'Float')]
    [TestCase('Date', 'Date')]
    [TestCase('DateTime', 'DateTime')]
    [TestCase('GUID', 'GUID')]
    [TestCase('Integer', 'Integer')]
    [TestCase('Int64', 'Int64')]
    [TestCase('String', 'String')]
    [TestCase('Time', 'Time')]
    procedure WhenGetTheValueOfTheFieldAsStringMustBuildTheStringAsExpected(FieldName: String);
    [Test]
    procedure WhenTheFieldIsMappedMustLoadTheReferenceToTheTableOfTheField;
    [Test]
    procedure WhenAClassWithManyValueAssociationHasAChildClassWithMoreThenOneForeignKeyToParentClassMustLoadTheForeignKeyWithTheSameNameOfTheParentTable;
    [Test]
    procedure WhenTheLinkBetweenTheManyValueAssociationAndTheChildTableForeignKeyDontExistsMustRaiseAnError;
    [Test]
    procedure TheNameOfManyValueAssociationLinkCanBeDefinedByTheAttributeToTheLinkHappen;
  end;

implementation

uses System.Variants, System.SysUtils, Delphi.ORM.Mapper, Delphi.ORM.Query.Builder.Test.Entity;

{ TMapperTest }

procedure TMapperTest.EveryPropertyThatIsAnObjectMustCreateAForeignKeyInTheListOfTheTable;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithFieldNameAttribute);

  Assert.AreEqual<Integer>(2, Length(Table.ForeignKeys));

  Mapper.Free;
end;

procedure TMapperTest.OnlyPublishedFieldMutsBeLoadedInTheTable;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntity);

  Assert.AreEqual<Integer>(3, Length(Table.Fields));

  Mapper.Free;
end;

procedure TMapperTest.Setup;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  FContext.GetType(TMyEntity);

  Mapper.Free;
end;

procedure TMapperTest.TheClassWithTheSingleTableInheritanceAttributeCantBeMappedInTheTableList;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.IsNull(Mapper.FindTable(TMyEntityWithSingleTableInheritanceAttribute));

  Mapper.Free;
end;

procedure TMapperTest.TheDatabaseNameOfATableMustBeTheNameOfClassRemovingTheFirstCharOfTheClassName;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity);

  Assert.AreEqual('MyEntity', Table.DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.TheFieldInPrimaryKeyMustBeMarkedWithInPrimaryKey;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity);

  Assert.IsTrue(Table.PrimaryKey.InPrimaryKey);

  Mapper.Free;
end;

procedure TMapperTest.TheFieldLinkingTheParentAndChildOfManyValueAssociationMustBeLoaded;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var ChildTable := Mapper.FindTable(TMyEntityWithManyValueAssociationChild);
  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociation);

  Assert.AreEqual(ChildTable.Fields[1], Table.ManyValueAssociations[0].ForeignKey.Field);

  Mapper.Free;
end;

procedure TMapperTest.TheFieldOfAForeignKeyMustBeFilledWithTheFieldOfTheClassThatIsAForeignKey;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithFieldNameAttribute);

  Assert.AreEqual(Table.Fields[1], Table.ForeignKeys[0].Field);

  Mapper.Free;
end;

procedure TMapperTest.TheFunctionGetValueFromFieldMustReturnTheValueOfThePropertyOfTheField;
begin
  var Mapper := TMapper.Create;
  var MyClass := TMyEntityWithAllTypeOfFields.Create;
  MyClass.&String := 'My Field';

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithAllTypeOfFields);
  var Field := Table.Fields[8];

  Assert.AreEqual('My Field', Field.GetValue(MyClass).AsString);

  Mapper.Free;

  MyClass.Free;
end;

procedure TMapperTest.TheLoadingOfForeingKeyMustBeAfterAllTablesAreLoadedToTheFindTableWorksPropertily;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TZZZZ);

  Assert.IsNotNull(Table.ForeignKeys[0].ParentTable);

  Mapper.Free;
end;

procedure TMapperTest.TheManyValueAssociationMustLoadTheFieldThatGeneratedTheValue;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociation);

  Assert.AreEqual(Table.Fields[1], Table.ManyValueAssociations[0].Field);

  Mapper.Free;
end;

procedure TMapperTest.TheNameOfManyValueAssociationLinkCanBeDefinedByTheAttributeToTheLinkHappen;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociation);

  Assert.AreEqual('ManyValueAssociation', Table.ManyValueAssociations[0].ForeignKey.Field.TypeInfo.Name);

  Mapper.Free;
end;

procedure TMapperTest.TheParentTableMustBeTheTableLinkedToTheField;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var ParentTable := Mapper.FindTable(TMyEntityWithPrimaryKey);
  var Table := Mapper.FindTable(TMyEntityWithFieldNameAttribute);

  Assert.AreEqual(ParentTable, Table.ForeignKeys[0].ParentTable);

  Mapper.Free;
end;

procedure TMapperTest.TheTableOfManyValueAssociationMustBeTheChildTableOfThisLink;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var ChildTable := Mapper.FindTable(TMyEntityWithManyValueAssociationChild);
  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociation);

  Assert.AreEqual(ChildTable, Table.ManyValueAssociations[0].ChildTable);

  Mapper.Free;
end;

procedure TMapperTest.WhenAClassDoesNotHaveThePrimaryKeyAttributeAndHasAnIdFieldThisWillBeThePrimaryKey;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity2);

  Assert.AreEqual('Id', Table.PrimaryKey.DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.WhenAClassIsInheritedFromAClassWithTheSingleTableInheritanceAttributeCantGenerateAnyForeignKey;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.AreEqual<Integer>(0, Length(Mapper.FindTable(TMyEntityInheritedFromSingle).ForeignKeys));

  Mapper.Free;
end;

procedure TMapperTest.WhenAClassIsInheritedFromAClassWithTheSingleTableInheritanceAttributeMustLoadAllFieldsInTheTable;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.AreEqual<Integer>(3, Length(Mapper.FindTable(TMyEntityInheritedFromSingle).Fields));

  Mapper.Free;
end;

procedure TMapperTest.WhenAClassIsInheritedFromAClassWithTheSingleTableInheritanceAttributeThePrimaryKeyMustBeLoadedFromTheTopClass;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityInheritedFromSingle);

  Assert.IsTrue(Assigned(Table.PrimaryKey));

  Mapper.Free;
end;

procedure TMapperTest.WhenAClassWithManyValueAssociationHasAChildClassWithMoreThenOneForeignKeyToParentClassMustLoadTheForeignKeyWithTheSameNameOfTheParentTable;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TManyValueAssociationParent);

  Assert.AreEqual('IdManyValueAssociationParent', Table.ManyValueAssociations[0].ForeignKey.Field.DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.WhenAFieldIsAForeignKeyThePropertyIsForeignKeyMustReturnTrue;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociationChild);

  var Field := Table.Fields[1];

  Assert.IsTrue(Field.IsForeignKey);

  Mapper.Free;
end;

procedure TMapperTest.WhenAFieldIsAForeignKeyThePropertyIsJoinLinkMustReturnTrue;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociationChild);

  var Field := Table.Fields[1];

  Assert.IsTrue(Field.IsJoinLink);

  Mapper.Free;
end;

procedure TMapperTest.WhenAFieldIsAManyValueAssociationThePropertyIsJoinLinkReturnTrue;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociation);

  var Field := Table.Fields[1];

  Assert.IsTrue(Field.IsJoinLink);

  Mapper.Free;
end;

procedure TMapperTest.WhenAFieldIsAManyValueAssociationThePropertyIsManyValueAssociationReturnTrue;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociation);

  var Field := Table.Fields[1];

  Assert.IsTrue(Field.IsManyValueAssociation);

  Mapper.Free;
end;

procedure TMapperTest.WhenAFieldIsWithTheAutoGeneratedAttributeMustLoadAsTrueThePropertyInField;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity);

  Assert.IsTrue(Table.Fields[0].AutoGenerated);

  Mapper.Free;
end;

procedure TMapperTest.WhenAPropertyIsAnArrayMustLoadAManyValueLink;
begin
  var Mapper := TMapper.Create;

  var Table := Mapper.LoadClass(TMyEntityWithManyValueAssociation);

  Assert.AreEqual<Integer>(1, Length(Table.ManyValueAssociations));

  Mapper.Free;
end;

procedure TMapperTest.WhenCallLoadAllMoreThemOneTimeCantRaiseAnError;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.WillNotRaise(Mapper.LoadAll);

  Mapper.Free;
end;

procedure TMapperTest.WhenCallLoadAllMustLoadAllClassesWithTheEntityAttribute;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.IsTrue(Length(Mapper.Tables) > 0, 'No entities loaded!');

  Mapper.Free;
end;

procedure TMapperTest.WhenGetTheValueOfTheFieldAsStringMustBuildTheStringAsExpected(FieldName: String);
begin
  var FieldToCompare: TField := nil;
  var Mapper := TMapper.Create;
  var MyClass := TMyEntityWithAllTypeOfFields.Create;
  var ValueToCompare := EmptyStr;

  var Table := Mapper.LoadClass(TMyEntityWithAllTypeOfFields);

  MyClass.AnsiChar := 'C';
  MyClass.AnsiString := 'AnsiString';
  MyClass.Char := 'C';
  MyClass.&Class := TMyEntityWithPrimaryKey.Create;
  MyClass.&Class.Value := 222.333;
  MyClass.Date := EncodeDate(2020, 1, 31);
  MyClass.DateTime := EncodeDate(2020, 1, 31) + EncodeTime(12, 34, 56, 0);
  MyClass.Enumerator := Enum2;
  MyClass.Float := 1234.456;
  MyClass.GUID := StringToGUID('{BD2BBA84-C691-4C5E-ABD3-4F32937C53F8}');
  MyClass.Integer := 1234;
  MyClass.Int64 := 1234;
  MyClass.&String := 'String';
  MyClass.Time := EncodeTime(12, 34, 56, 0);

  for var Field in Table.Fields do
    if Field.TypeInfo.Name = FieldName then
      FieldToCompare := Field;

  case FieldToCompare.TypeInfo.PropertyType.TypeKind of
    tkChar, tkWChar: ValueToCompare := '''C''';
    tkEnumeration: ValueToCompare := '1';
    tkFloat:
    begin
      if FieldToCompare.TypeInfo.PropertyType.Handle = TypeInfo(TDate) then
        ValueToCompare := '''2020-01-31'''
      else if FieldToCompare.TypeInfo.PropertyType.Handle = TypeInfo(TTime) then
        ValueToCompare := '''12:34:56'''
      else if FieldToCompare.TypeInfo.PropertyType.Handle = TypeInfo(TDateTime) then
        ValueToCompare := '''2020-01-31 12:34:56'''
      else
        ValueToCompare := '1234.456';
    end;
    tkInteger, tkInt64: ValueToCompare := '1234';
    tkRecord: ValueToCompare := '''{BD2BBA84-C691-4C5E-ABD3-4F32937C53F8}''';
    tkLString: ValueToCompare := '''AnsiString''';
    tkUString: ValueToCompare := '''String''';
    tkClass:
      if FieldName = 'Class' then
        ValueToCompare := '222.333'
      else
        ValueToCompare := 'null';
  end;

  Assert.AreEqual(ValueToCompare, FieldToCompare.GetAsString(MyClass));

  MyClass.&Class.Free;

  Mapper.Free;

  MyClass.Free;
end;

procedure TMapperTest.WhenLoadAClassMustKeepTheOrderingOfTablesToTheFindTableContinueToWorking;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadClass(TMyEntity2);

  Mapper.LoadClass(TMyEntity);

  Mapper.LoadClass(TMyEntity3);

  var Table := Mapper.FindTable(TMyEntity);

  Assert.AreSame(FContext.GetType(TMyEntity), Table.TypeInfo);

  Mapper.Free;
end;

procedure TMapperTest.WhenLoadAFieldMustFillThePropertyWithThePropertyInfo;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity3);
  var TypeInfo := FContext.GetType(TMyEntity3).GetProperties[0];

  Assert.AreEqual<TObject>(TypeInfo, Table.Fields[0].TypeInfo);

  Mapper.Free;
end;

procedure TMapperTest.WhenLoadATableMustLoadAllFieldsToo;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntity);

  Assert.AreEqual<Integer>(3, Length(Table.Fields));

  Mapper.Free;
end;

procedure TMapperTest.WhenLoadMoreThenOneTimeTheSameClassCantRaiseAnError;
begin
  var Mapper := TMapper.Create;

  Assert.WillNotRaise(
    procedure
    begin
      Mapper.LoadClass(TMyEntity);

      Mapper.LoadClass(TMyEntity);
    end);

  Mapper.Free;
end;

procedure TMapperTest.WhenMapAForeignKeyIsToAClassWithoutAPrimaryKeyMustRaiseAnError;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.WillRaise(
    procedure
    begin
      Mapper.LoadClass(TMyEntityForeignKeyToClassWithoutPrimaryKey);
    end, EClassWithoutPrimaryKeyDefined);

  Mapper.Free;
end;

procedure TMapperTest.WhenSetValueFieldMustLoadThePropertyOfTheClassAsWithTheValueExpected(FieldName: String);
begin
  var FieldToCompare: TField := nil;
  var Mapper := TMapper.Create;
  var MyClass := TMyEntityWithAllTypeOfFields.Create;
  var ValueToCompare := NULL;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithAllTypeOfFields);

  for var Field in Table.Fields do
    if Field.DatabaseName = FieldName then
      FieldToCompare := Field;

  case FieldToCompare.TypeInfo.PropertyType.TypeKind of
    tkChar: ValueToCompare := AnsiChar('C');
    tkEnumeration: ValueToCompare := Enum2;
    tkFloat: ValueToCompare := Double(1234.456);
    tkInt64: ValueToCompare := Int64(1234);
    tkInteger: ValueToCompare := 1234;
    tkRecord: ValueToCompare := '{BD2BBA84-C691-4C5E-ABD3-4F32937C53F8}';
    tkLString: ValueToCompare := AnsiString('AnsiString');
    tkUString: ValueToCompare := 'String';
    tkWChar: ValueToCompare := Char('C');
  end;

  FieldToCompare.SetValue(MyClass, ValueToCompare);

  if FieldToCompare.TypeInfo.PropertyType.TypeKind = tkRecord then
    Assert.AreEqual<String>(ValueToCompare, FieldToCompare.GetValue(MyClass).AsType<TGUID>.ToString)
  else
    Assert.AreEqual(ValueToCompare, FieldToCompare.GetValue(MyClass).AsVariant);

  Mapper.Free;

  MyClass.Free;
end;

procedure TMapperTest.WhenTheChildClassIsDeclaredBeforeTheParentClassTheLinkBetweenOfTablesMustBeCreated;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociation);

  Assert.AreEqual<Integer>(1, Length(Table.ManyValueAssociations));

  Mapper.Free;
end;

procedure TMapperTest.WhenTheClassHaveThePrimaryKeyAttributeThePrimaryKeyWillBeTheFieldFilled;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntityWithPrimaryKey);

  Assert.AreEqual('Value', Table.PrimaryKey.DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheClassHaveTheTableNameAttributeTheDatabaseNameMustBeLikeTheNameInAttribute;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity2);

  Assert.AreEqual('AnotherTableName', Table.DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheClassIsInheritedFromANormalClassCantLoadFieldsFormTheBaseClass;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.AreEqual<Integer>(1, Length(Mapper.FindTable(TMyEntityInheritedFromSimpleClass).Fields));

  Mapper.Free;
end;

procedure TMapperTest.WhenTheClassIsInheritedFromANormalClassMustCreateAForeignKeyForTheBaseClass;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.AreEqual<Integer>(1, Length(Mapper.FindTable(TMyEntityInheritedFromSimpleClass).ForeignKeys));

  Mapper.Free;
end;

procedure TMapperTest.WhenTheClassIsInheritedFromANormalClassMustCreateAForeignKeyForTheBaseClassWithThePrimaryKeyFields;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityInheritedFromSimpleClass);

  var ForeignKey := Table.ForeignKeys[0];

  Assert.AreEqual(Table.PrimaryKey, ForeignKey.Field);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheClassIsInheritedFromTObjectCantCreateAForeignKeyForThatClass;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.AreEqual<Integer>(0, Length(Mapper.FindTable(TMyEntity).ForeignKeys));

  Mapper.Free;
end;

procedure TMapperTest.WhenTheClassIsInheritedMustLoadThePrimaryKeyFromBaseClass;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityInheritedFromSimpleClass);

  Assert.IsTrue(Assigned(Table.PrimaryKey));

  Mapper.Free;
end;

procedure TMapperTest.WhenTheClassIsInheritedMustShareTheSamePrimaryKeyFromTheBaseClass;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var BaseTable := Mapper.FindTable(TMyEntityInheritedFromSingle);
  var Table := Mapper.FindTable(TMyEntityInheritedFromSimpleClass);

  Assert.AreSame(BaseTable.PrimaryKey, Table.PrimaryKey);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheFieldHaveTheFieldNameAttributeMustLoadThisNameInTheDatabaseName;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithFieldNameAttribute);

  Assert.AreEqual('AnotherFieldName', Table.Fields[0].DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheFieldIsAClassMustFillTheDatabaseNameWithIdPlusPropertyName;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithFieldNameAttribute);

  Assert.AreEqual('IdMyForeignKey', Table.Fields[1].DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheFieldIsMappedMustLoadTheReferenceToTheTableOfTheField;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity);

  Assert.AreEqual(Table, Table.Fields[0].Table);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheFieldsAreLoadedMustFillTheNameWithTheNameOfPropertyOfTheClass;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity3);

  Assert.AreEqual('Id', Table.Fields[0].DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheFieldValueIsNullMustLoadTheFieldWithTheEmptyValue;
begin
  var Mapper := TMapper.Create;
  var MyClass := TMyEntityWithAllTypeOfFields.Create;
  MyClass.Enumerator := Enum3;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithAllTypeOfFields);

  var Field := Table.Fields[3];

  Field.SetValue(MyClass, NULL);

  Assert.AreEqual(Enum1, Field.GetValue(MyClass).AsType<TMyEnumerator>);

  Mapper.Free;

  MyClass.Free;
end;

procedure TMapperTest.WhenTheForeignKeyIsAClassAliasMustLoadTheForeignClassAndLinkToForeignKey;
begin
  var Mapper := TMapper.Create;

  var Table := Mapper.LoadClass(TMyEntityWithForeignKeyAlias);

  Assert.AreEqual<Integer>(1, Length(Table.ForeignKeys));

  Mapper.Free;
end;

procedure TMapperTest.WhenTheForeignKeyIsCreatesMustLoadTheParentTable;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithFieldNameAttribute);

  Assert.IsNotNull(Table.ForeignKeys[0].ParentTable);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheLinkBetweenTheManyValueAssociationAndTheChildTableForeignKeyDontExistsMustRaiseAnError;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.WillRaise(
    procedure
    begin
      Mapper.LoadClass(TManyValueAssociationParentNoLink);
    end, EManyValueAssociationLinkError);

  Mapper.Free;
end;

procedure TMapperTest.WhenTryToFindATableMustReturnTheTableOfTheClass;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity3);

  Assert.AreEqual(TMyEntity3, Table.TypeInfo.MetaclassType);

  Mapper.Free;
end;

procedure TMapperTest.WhenTryToFindATableWithoutTheEntityAttributeMustReturnANilValue;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithoutEntityAttribute);

  Assert.IsNull(Table);

  Mapper.Free;
end;

end.

