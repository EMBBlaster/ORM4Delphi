﻿unit Delphi.ORM.DataSet.Test;

interface

uses Data.DB, DUnitX.TestFramework;

type
  [TestFixture]
  TORMDataSetTest = class
  private
    procedure DestroyObjectArray(Values: TArray<TObject>);
  public
    [SetupFixture]
    procedure Setup;
    [Test]
    procedure WhenOpenDataSetHaveToLoadFieldListWithPropertiesOfMappedObject;
    [Test]
    procedure TheNameOfFieldMustBeEqualToTheNameOfTheProperty;
    [Test]
    procedure WhenOpenDataSetFromAListMustHaveToLoadFieldListWithPropertiesOfMappedObject;
    [TestCase('Array', 'MyArray,ftDataSet')]
    [TestCase('Boolean', 'Boolean,ftBoolean')]
    [TestCase('Byte', 'Byte,ftByte')]
    [TestCase('Cardinal', 'Cardinal,ftLongWord')]
    [TestCase('Char', 'Char,ftString')]
    [TestCase('Class', 'Class,ftVariant')]
    [TestCase('Currency', 'Currency,ftCurrency')]
    [TestCase('Date', 'Date,ftDate')]
    [TestCase('DateTime', 'DateTime,ftDateTime')]
    [TestCase('Double', 'Double,ftFloat')]
    [TestCase('Enumerator', 'MyEnum,ftInteger')]
    [TestCase('Int64', 'Int64,ftLargeint')]
    [TestCase('Integer', 'Int,ftInteger')]
    [TestCase('Sigle', 'Single,ftSingle')]
    [TestCase('String', 'Str,ftString')]
    [TestCase('Time', 'Time,ftTime')]
    [TestCase('WideChar', 'WideChar,ftString')]
    [TestCase('WideString', 'WideString,ftWideString')]
    [TestCase('Word', 'Word,ftWord')]
    procedure TheFieldTypeMustMatchWithPropertyType(FieldName: String; TypeToCompare: TFieldType);
    [Test]
    procedure WhenOpenTheDataSetWithAObjectTheRecordCountMustBeOne;
    [Test]
    procedure WhenOpenTheDataSetWithAListTheRecordCountMustBeTheSizeOfTheList;
    [Test]
    procedure AfterOpenTheFieldMustLoadTheValuesFromTheObjectClass;
    [Test]
    procedure WhenNavigateByDataSetMustHaveToShowTheValuesFromTheList;
    [Test]
    procedure WhenNavigatingBackHaveToLoadTheListValuesAsExpected;
    [Test]
    procedure WhenHaveFieldDefDefinedCantLoadFieldsFromTheClass;
    [Test]
    procedure WhenTheFieldDefNameNotExistsInPropertyListMustRaiseAException;
    [Test]
    procedure WhenTheFieldAndPropertyTypeAreDifferentItHasToRaiseAnException;
    [Test]
    procedure WhenAFieldIsSeparatedByAPointItHasToLoadTheSubPropertiesOfTheObject;
    [Test]
    procedure WhenTryOpenADataSetWithoutAObjectDefinitionMustRaiseAnError;
    [Test]
    procedure WhenFilledTheObjectClassNameHasToLoadTheDataSetWithoutErrors;
    [Test]
    procedure WhenUseQualifiedClassNameHasToLoadTheDataSetWithoutErrors;
    [Test]
    procedure WhenCheckingIfTheFieldIsNullCantRaiseAnError;
    [Test]
    procedure WhenCallFirstHaveToGoToTheFirstRecord;
    [Test]
    procedure UsingBookmarkHaveToWorkLikeSpected;
    [Test]
    procedure WhenUseTheOpenClassMustLoadFieldFromTheClass;
    [Test]
    procedure WhenExistsAFieldInDataSetMustFillTheFieldDefFromThisField;
    [Test]
    procedure WhenInsertIntoDataSetCantRaiseAnError;
    [Test]
    procedure WhenPostARecordMustAppendToListOfObjects;
    [TestCase('Boolean', 'Boolean,True')]
    [TestCase('Byte', 'Byte,123')]
    [TestCase('Cardinal', 'Cardinal,123')]
    [TestCase('Char', 'Char,C')]
    [TestCase('Currency', 'Currency;123,456', ';')]
    [TestCase('Date', 'Date,21/12/2020')]
    [TestCase('DateTime', 'DateTime,21/12/2020 17:17:17')]
    [TestCase('Double', 'Double;123,456', ';')]
    [TestCase('Enumerator', 'MyEnum,1')]
    [TestCase('Int64', 'Int64,123')]
    [TestCase('Integer', 'Int,123')]
    [TestCase('Sigle', 'Single;123,456', ';')]
    [TestCase('String', 'Str,Value String')]
    [TestCase('Time', 'Time,17:17:17')]
    [TestCase('WideChar', 'WideChar,C')]
    [TestCase('WideString', 'WideString,Value String')]
    [TestCase('Word', 'Word,123')]
    procedure WhenSetTheFieldValueMustChangeTheValueFromTheClass(FieldName, FieldValue: String);
    [TestCase('Char', 'Char,1')]
    [TestCase('String', 'Str,50')]
    [TestCase('WideChar', 'WideChar,1')]
    [TestCase('WideString', 'WideString,50')]
    procedure WhenAFieldIsACreateTheFieldMustHaveTheMinimalSizeDefined(FieldName: String; Size: Integer);
    [Test]
    procedure WhenOpenAnEmptyDataSetCantRaiseAnError;
    [Test]
    procedure WhenOpenAnEmptyDataSetTheCurrentObjectMustReturnNil;
    [Test]
    procedure WhenTryToGetAFieldValueFromAEmptyDataSetCantRaiseAnError;
    [Test]
    procedure WhenOpenAnEmptyDataSetTheValueOfTheFieldMustReturnNull;
    [Test]
    procedure WhenASubPropertyIsAnObjectAndTheValueIsNilCantRaiseAnError;
    [Test]
    procedure WhenFillingAFieldWithSubPropertyMustFillTheLastLevelOfTheField;
    [Test]
    procedure WhenOpenAClassWithDerivationMustLoadTheFieldFromTheBaseClassToo;
    [Test]
    procedure WhenTheDataSetIsEmptyCantRaiseAnErrorWhenGetAFieldFromASubPropertyThatIsAnObject;
    [Test]
    procedure EveryInsertedObjectMustGoToTheObjectList;
    [Test]
    procedure AfterInsertAnObjectMustResetTheObjectToSaveTheNewInfo;
    [Test]
    procedure WhenEditingTheDataSetAndSetAFieldValueMustChangeThePropertyOfTheObjectToo;
    [Test]
    procedure TheOldValuePropertyFromFieldMustReturnTheOriginalValueOfTheObjectBeingEdited;
    [Test]
    procedure WhenAStringFieldIsEmptyCantRaiseAnErrorBecauseOfIt;
    [Test]
    procedure WhenTheEditionIsCanceledMustReturnTheOriginalValueFromTheField;
    [Test]
    procedure WhenEditingCantIncreseTheRecordCountWhenPostTheRecord;
    [Test]
    procedure WhenSetAValueToAFieldThatIsAnObjectMustFillThePropertyInTheClassWithThisObject;
    [Test]
    procedure WhenGetAValueFromAFieldAndIsAnObjectMustReturnTheObjectFromTheClass;
    [Test]
    procedure OpenArrayObjectMustLoadTheObjectTypeFromTheParam;
    [Test]
    procedure OpenArrayObjectMustActiveTheDataSet;
    [Test]
    procedure OpenArrayMustLoadTheObjectListWithTheParamPassed;
    [Test]
    procedure TheRecNoPropertyMustReturnTheCurrentRecordPositionInTheDataSet;
    [Test]
    procedure WhenADataSetIsActiveCantOpenItAgainMustRaiseAnError;
    [Test]
    procedure WhenCleanUpTheObjectClassNameMustStayEmpty;
    [Test]
    procedure WhenChangeTheObjectTypeOfTheDataSetMustBeClosedToAcceptTheChange;
    [Test]
    procedure WhenFillTheDataSetFieldPropertyMustLoadTheParentDataSetPropertyWithTheDataSetCorrect;
    [Test]
    procedure WhenCleanUpTheDataSetFieldPropertyTheParentDataSetMustBeCleanedToo;
    [Test]
    procedure WhenFillTheDataSetFieldMustLoadTheObjectTypeFromThePropertyOfTheField;
    [Test]
    procedure WhenOpenTheDetailDataSetMustLoadAllRecordsFromTheParentDataSet;
    [Test]
    procedure WhenScrollTheParentDataSetMustLoadTheArrayInDetailDataSet;
    [Test]
    procedure WhenCloseTheDataSetMustCleanUpTheObjectList;
    [Test]
    procedure WhenPostTheDetailDataSetMustUpdateTheArrayValueFromParentDataSet;
    [Test]
    procedure WhenTheRecordBufferIsBiggerThenOneMustLoadTheBufferOfTheDataSetAsExpected;
    [Test]
    procedure WhenOpenADataSetWithDetailMustLoadTheRecordsOfTheDetail;
    [Test]
    procedure WhenTheDetailDataSetHasAComposeNameMustLoadTheObjectTypeCorrectly;
    [Test]
    procedure WhenTheDetailDataSetHasAComposeNameMustLoadTheDataCorrecty;
    [Test]
    procedure WhenInsertARecordThenCancelTheInsertionAndStartANewInsertTheOldBufferMustBeCleanedUp;
    [Test]
    procedure WhenThePropertyIsANullableTypeMustCreateTheField;
    [Test]
    procedure WhenThePropertyIsANullableTypeMustCreateTheFieldWithTheInternalTypeOfTheNullable;
    [Test]
    procedure WhenTheFieldIsMappedToANullableFieldAndTheValueIsntFilledMustReturnNullInTheFieldValue;
    [Test]
    procedure WhenTheNullablePropertyIsFilledMustReturnTheValueFilled;
    [Test]
    procedure WhenClearAFieldCantRaiseAnError;
    [Test]
    procedure WhenFillANullableFieldWithTheNullValueMustMarkThePropertyWithIsNullTrue;
    [Test]
    procedure WhenFillANullableFieldWithAnValueMustFillThePropertyWithTheValue;
    [Test]
    procedure GetADateTimeFieldMustReturnTheValueAsExpected;
    [Test]
    procedure WhenThePropertyOfTheClassIsLazyLoadingMustCreateTheField;
    [Test]
    procedure WhenThePropertyOfTheClassIsLazyLoadingMustCreateTheFieldWithTheGenericTypeOfTheLazyRecord;
    [Test]
    procedure WhenGetTheValueOfALazyPropertyMustReturnTheValueInsideTheLazyRecord;
    [Test]
    procedure WhenFillAFieldOfALazyPropertyMustFieldTheLazyStructure;
    [Test]
    procedure WhenTryToGetAComposeFieldNameFromALazyPropertyMustLoadAsExpected;
  end;

  TAnotherObject = class
  private
    FAnotherObject: TAnotherObject;
    FAnotherName: String;
  public
    destructor Destroy; override;
  published
    property AnotherName: String read FAnotherName write FAnotherName;
    property AnotherObject: TAnotherObject read FAnotherObject write FAnotherObject;
  end;

  TMyTestClass = class
  private
    FId: Integer;
    FName: String;
    FValue: Double;
    FAnotherObject: TAnotherObject;
  public
    destructor Destroy; override;
  published
    property Id: Integer read FId write FId;
    property Name: String read FName write FName;
    property Value: Double read FValue write FValue;
    property AnotherObject: TAnotherObject read FAnotherObject write FAnotherObject;
  end;

  TMyTestClassChild = class(TMyTestClass)
  private
    FAField: String;
    FAnotherField: Integer;
  published
    property AField: String read FAField write FAField;
    property AnotherField: Integer read FAnotherField write FAnotherField;
  end;

  TMyEnumerator = (Enum1, Enum2, Enum3);

  TMyTestClassTypes = class
  private
    FInt: Integer;
    FDate: TDate;
    FWideChar: WideChar;
    FWord: Word;
    FByte: Byte;
    FDouble: Double;
    FChar: AnsiChar;
    FCardinal: Cardinal;
    FStr: String;
    FBoolean: Boolean;
    FTime: TTime;
    FSmallInt: SmallInt;
    FExtended: Extended;
    FDateTime: TDateTime;
    FWideString: WideString;
    FInt64: Int64;
    FSingle: Single;
    FCurrency: Currency;
    FClass: TObject;
    FMyEnum: TMyEnumerator;
    FMyArray: TArray<TMyTestClassTypes>;
  published
    property Boolean: Boolean read FBoolean write FBoolean;
    property Byte: Byte read FByte write FByte;
    property Cardinal: Cardinal read FCardinal write FCardinal;
    property Char: AnsiChar read FChar write FChar;
    property &Class: TObject read FClass write FClass;
    property Currency: Currency read FCurrency write FCurrency;
    property Date: TDate read FDate write FDate;
    property DateTime: TDateTime read FDateTime write FDateTime;
    property Double: Double read FDouble write FDouble;
    property Extended: Extended read FExtended write FExtended;
    property Int64: Int64 read FInt64 write FInt64;
    property Int: Integer read FInt write FInt;
    property MyEnum: TMyEnumerator read FMyEnum write FMyEnum;
    property Single: Single read FSingle write FSingle;
    property SmallInt: SmallInt read FSmallInt write FSmallInt;
    property Str: String read FStr write FStr;
    property Time: TTime read FTime write FTime;
    property WideChar: WideChar read FWideChar write FWideChar;
    property WideString: WideString read FWideString write FWideString;
    property Word: Word read FWord write FWord;
    property MyArray: TArray<TMyTestClassTypes> read FMyArray write FMyArray;
  end;

  TParentClass = class
  private
    FMyClass: TMyTestClassTypes;
  published
    property MyClass: TMyTestClassTypes read FMyClass write FMyClass;
  end;

implementation

uses System.Rtti, System.Generics.Collections, System.SysUtils, System.Classes, System.Variants, Data.DBConsts, Delphi.ORM.DataSet, Delphi.ORM.Test.Entity;

{ TORMDataSetTest }

procedure TORMDataSetTest.AfterInsertAnObjectMustResetTheObjectToSaveTheNewInfo;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenClass<TMyTestClass>;

  DataSet.Append;

  DataSet.FieldByName('Name').AsString := 'Name1';

  DataSet.Post;

  DataSet.Append;

  DataSet.FieldByName('Name').AsString := 'Name2';

  DataSet.Post;

  Assert.AreEqual('Name1', TMyTestClass(DataSet.ObjectList[0]).Name);

  DestroyObjectArray(DataSet.ObjectList);

  DataSet.Free;
end;

procedure TORMDataSetTest.AfterOpenTheFieldMustLoadTheValuesFromTheObjectClass;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyObject := TMyTestClass.Create;
  MyObject.Id := 123456;
  MyObject.Name := 'MyName';
  MyObject.Value := 5477.555;

  DataSet.OpenObject(MyObject);

  Assert.AreEqual(123456, DataSet.FieldByName('Id').AsInteger);
  Assert.AreEqual('MyName', DataSet.FieldByName('Name').AsString);
  Assert.AreEqual<Double>(5477.555, DataSet.FieldByName('Value').AsFloat);

  DataSet.Free;

  MyObject.Free;
end;

procedure TORMDataSetTest.DestroyObjectArray(Values: TArray<TObject>);
begin
  for var Value in Values do
    Value.Free;
end;

procedure TORMDataSetTest.EveryInsertedObjectMustGoToTheObjectList;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenClass<TMyTestClass>;

  DataSet.Append;

  DataSet.Post;

  Assert.IsNotNull(DataSet.ObjectList[0]);

  DestroyObjectArray(DataSet.ObjectList);

  DataSet.Free;
end;

procedure TORMDataSetTest.GetADateTimeFieldMustReturnTheValueAsExpected;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyObject := TMyTestClassTypes.Create;
  MyObject.DateTime := EncodeDate(2020, 02, 18) + EncodeTime(12, 34, 56, 0);

  DataSet.OpenObject(MyObject);

  Assert.AreEqual(MyObject.DateTime, DataSet.FieldByName('DateTime').AsDateTime);

  DataSet.Free;

  MyObject.Free;
end;

procedure TORMDataSetTest.OpenArrayMustLoadTheObjectListWithTheParamPassed;
begin
  var Context := TRttiContext.Create;
  var DataSet := TORMDataSet.Create(nil);
  var MyClass := TMyTestClass.Create;

  DataSet.OpenObjectArray(TMyTestClass, [MyClass]);

  Assert.AreEqual(1, DataSet.RecordCount);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.OpenArrayObjectMustActiveTheDataSet;
begin
  var Context := TRttiContext.Create;
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenObjectArray(TMyTestClass, nil);

  Assert.IsTrue(DataSet.Active);

  DataSet.Free;
end;

procedure TORMDataSetTest.OpenArrayObjectMustLoadTheObjectTypeFromTheParam;
begin
  var Context := TRttiContext.Create;
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenObjectArray(TMyTestClass, nil);

  Assert.AreEqual(Context.GetType(TMyTestClass) as TRttiInstanceType, DataSet.ObjectType);

  DataSet.Free;
end;

procedure TORMDataSetTest.Setup;
begin
Exit;
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenClass<TMyTestClassTypes>;

  DataSet.Free;

  for var &Type in TRttiContext.Create.GetTypes do
    &Type.QualifiedName;

  try
    DatabaseError(SDataSetOpen, nil);
  except
  end;
end;

procedure TORMDataSetTest.TheFieldTypeMustMatchWithPropertyType(FieldName: String; TypeToCompare: TFieldType);
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyObject := TMyTestClassTypes.Create;

  DataSet.OpenObject(MyObject);

  Assert.AreEqual(TypeToCompare, DataSet.FieldByName(FieldName).DataType);

  DataSet.Free;

  MyObject.Free;
end;

procedure TORMDataSetTest.TheNameOfFieldMustBeEqualToTheNameOfTheProperty;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyObject := TMyTestClass.Create;

  DataSet.OpenObject(MyObject);

  Assert.AreEqual('Id', DataSet.Fields[0].FieldName);
  Assert.AreEqual('Name', DataSet.Fields[1].FieldName);
  Assert.AreEqual('Value', DataSet.Fields[2].FieldName);
  Assert.AreEqual('AnotherObject', DataSet.Fields[3].FieldName);

  DataSet.Free;

  MyObject.Free;
end;

procedure TORMDataSetTest.TheOldValuePropertyFromFieldMustReturnTheOriginalValueOfTheObjectBeingEdited;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyClass := TMyTestClass.Create;

  MyClass.Name := 'My Name';

  DataSet.OpenObject(MyClass);

  DataSet.Edit;

  DataSet.FieldByName('Name').AsString := 'Another Name';

  Assert.AreEqual<String>('My Name', DataSet.FieldByName('Name').OldValue);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.TheRecNoPropertyMustReturnTheCurrentRecordPositionInTheDataSet;
begin
  var Context := TRttiContext.Create;
  var DataSet := TORMDataSet.Create(nil);
  var List: TArray<TMyTestClass> := [TMyTestClass.Create, TMyTestClass.Create, TMyTestClass.Create, TMyTestClass.Create, TMyTestClass.Create];

  DataSet.OpenArray<TMyTestClass>(List);

  DataSet.Next;

  DataSet.Next;

  Assert.AreEqual(2, DataSet.RecNo);

  for var Item in List do
    Item.Free;

  DataSet.Free;
end;

procedure TORMDataSetTest.UsingBookmarkHaveToWorkLikeSpected;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyList := TObjectList<TMyTestClass>.Create;

  for var A := 1 to 10 do
  begin
    var MyObject := TMyTestClass.Create;
    MyObject.Id := A;
    MyObject.Name := Format('Name%d', [A]);
    MyObject.Value := A + A;

    MyList.Add(MyObject);
  end;

  DataSet.OpenList<TMyTestClass>(MyList);

  for var A := 1 to 4 do
    DataSet.Next;

  var Bookmark := DataSet.Bookmark;

  DataSet.First;

  DataSet.Bookmark := Bookmark;

  Assert.AreEqual('Name5', DataSet.FieldByName('Name').AsString);

  DataSet.Free;

  MyList.Free;
end;

procedure TORMDataSetTest.WhenADataSetIsActiveCantOpenItAgainMustRaiseAnError;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenClass<TMyTestClassTypes>;

  Assert.WillRaise(DataSet.OpenClass<TMyTestClassTypes>);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenAFieldIsACreateTheFieldMustHaveTheMinimalSizeDefined(FieldName: String; Size: Integer);
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenClass<TMyTestClassTypes>;

  Assert.AreEqual(Size, DataSet.FieldByName(FieldName).Size);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenAFieldIsSeparatedByAPointItHasToLoadTheSubPropertiesOfTheObject;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyObject := TMyTestClass.Create;
  MyObject.AnotherObject := TAnotherObject.Create;
  MyObject.AnotherObject.AnotherObject := TAnotherObject.Create;
  MyObject.AnotherObject.AnotherObject.AnotherName := 'MyName';

  DataSet.FieldDefs.Add('AnotherObject.AnotherObject.AnotherName', ftString, 50);

  DataSet.OpenObject(MyObject);

  Assert.AreEqual('MyName', DataSet.FieldByName('AnotherObject.AnotherObject.AnotherName').AsString);

  DataSet.Free;

  MyObject.Free;
end;

procedure TORMDataSetTest.WhenTheDataSetIsEmptyCantRaiseAnErrorWhenGetAFieldFromASubPropertyThatIsAnObject;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.FieldDefs.Add('AnotherObject.AnotherName', ftString, 50);

  DataSet.OpenClass<TMyTestClass>;

  Assert.WillNotRaise(
    procedure
    begin
      DataSet.FieldByName('AnotherObject.AnotherName').AsString
    end);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenTheDetailDataSetHasAComposeNameMustLoadTheDataCorrecty;
begin
  var DataSet := TORMDataSet.Create(nil);
  var DataSetDetail := TORMDataSet.Create(nil);
  var Field := TDataSetField.Create(nil);
  var MyClass: TArray<TParentClass> := [TParentClass.Create, TParentClass.Create];
  MyClass[0].MyClass := TMyTestClassTypes.Create;
  MyClass[0].MyClass.MyArray := [TMyTestClassTypes.Create, TMyTestClassTypes.Create];

  DataSet.ObjectClassName := 'TParentClass';

  Field.FieldName := 'MyClass.MyArray';

  Field.SetParentComponent(DataSet);

  DataSetDetail.DataSetField := Field;

  DataSet.OpenArray<TParentClass>(MyClass);

  Assert.AreEqual(2, DataSetDetail.RecordCount);

  MyClass[0].MyClass.MyArray[0].Free;

  MyClass[0].MyClass.MyArray[1].Free;

  MyClass[0].MyClass.Free;

  MyClass[1].Free;

  MyClass[0].Free;

  DataSetDetail.Free;

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenTheDetailDataSetHasAComposeNameMustLoadTheObjectTypeCorrectly;
begin
  var DataSet := TORMDataSet.Create(nil);
  var DataSetDetail := TORMDataSet.Create(nil);
  var Field := TDataSetField.Create(nil);

  DataSet.ObjectClassName := 'TParentClass';

  Field.FieldName := 'MyClass.MyArray';

  Field.SetParentComponent(DataSet);

  DataSetDetail.DataSetField := Field;

  DataSet.Open;

  Assert.AreEqual('TMyTestClassTypes', DataSetDetail.ObjectType.Name);

  DataSetDetail.Free;

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenTheEditionIsCanceledMustReturnTheOriginalValueFromTheField;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyClass := TMyTestClass.Create;
  MyClass.Name := 'My Name';

  DataSet.OpenObject(MyClass);

  DataSet.Edit;

  DataSet.FieldByName('Name').AsString := 'New Name';

  DataSet.Cancel;

  Assert.AreEqual('My Name', DataSet.FieldByName('Name').AsString);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenAStringFieldIsEmptyCantRaiseAnErrorBecauseOfIt;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyClass := TMyTestClass.Create;

  DataSet.OpenObject(MyClass);

  Assert.WillNotRaise(
    procedure
    begin
      DataSet.FieldByName('Name').AsString;
    end);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenASubPropertyIsAnObjectAndTheValueIsNilCantRaiseAnError;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyObject := TMyTestClass.Create;
  MyObject.AnotherObject := TAnotherObject.Create;

  DataSet.FieldDefs.Add('AnotherObject.AnotherObject.AnotherName', ftString, 50);

  DataSet.OpenObject(MyObject);

  Assert.WillNotRaise(
    procedure
    begin
      DataSet.FieldByName('AnotherObject.AnotherObject.AnotherName').AsString
    end);

  DataSet.Free;

  MyObject.Free;
end;

procedure TORMDataSetTest.WhenCallFirstHaveToGoToTheFirstRecord;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyList := TObjectList<TMyTestClass>.Create;

  for var A := 1 to 10 do
  begin
    var MyObject := TMyTestClass.Create;
    MyObject.Id := A;
    MyObject.Name := Format('Name%d', [A]);
    MyObject.Value := A + A;

    MyList.Add(MyObject);
  end;

  DataSet.OpenList<TMyTestClass>(MyList);

  while not DataSet.Eof do
    DataSet.Next;

  DataSet.First;

  Assert.AreEqual('Name1', DataSet.FieldByName('Name').AsString);

  DataSet.Free;

  MyList.Free;
end;

procedure TORMDataSetTest.WhenEditingCantIncreseTheRecordCountWhenPostTheRecord;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyClass := TMyTestClass.Create;
  MyClass.Name := 'My Name';

  DataSet.OpenObject(MyClass);

  DataSet.Edit;

  DataSet.Post;

  Assert.AreEqual(1, DataSet.RecordCount);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenEditingTheDataSetAndSetAFieldValueMustChangeThePropertyOfTheObjectToo;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyClass := TMyTestClass.Create;

  MyClass.Name := 'My Name';

  DataSet.OpenObject(MyClass);

  DataSet.Edit;

  DataSet.FieldByName('Name').AsString := 'Name1';

  Assert.AreEqual('Name1', MyClass.Name);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenExistsAFieldInDataSetMustFillTheFieldDefFromThisField;
begin
  var DataSet := TORMDataSet.Create(nil);
  var Field := TStringField.Create(DataSet);
  Field.FieldName := 'Name';

  Field.SetParentComponent(DataSet);

  DataSet.OpenClass<TMyTestClass>;

  Assert.AreEqual(1, DataSet.FieldDefs.Count);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenFillAFieldOfALazyPropertyMustFieldTheLazyStructure;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyClass := TLazyClass.Create;
  var TheValue := TMyEntity.Create;

  DataSet.OpenObject(MyClass);

  DataSet.Edit;

  TORMObjectField(DataSet.FindField('Lazy')).AsObject := TheValue;

  Assert.AreEqual<TObject>(TheValue, MyClass.Lazy.Value);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenFillANullableFieldWithAnValueMustFillThePropertyWithTheValue;
begin
  var DataSet := TORMDataSet.Create(nil);

  var MyClass := TClassWithNullableProperty.Create;

  DataSet.OpenObject(MyClass);

  DataSet.Edit;

  DataSet.FieldByName('Nullable').AsInteger := 12345678;

  DataSet.Post;

  Assert.AreEqual(12345678, MyClass.Nullable.Value);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenFillANullableFieldWithTheNullValueMustMarkThePropertyWithIsNullTrue;
begin
  var DataSet := TORMDataSet.Create(nil);

  var MyClass := TClassWithNullableProperty.Create;
  MyClass.Nullable := 12345678;

  DataSet.OpenObject(MyClass);

  DataSet.Edit;

  DataSet.FieldByName('Nullable').Clear;

  DataSet.Post;

  Assert.IsTrue(MyClass.Nullable.IsNull);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenFilledTheObjectClassNameHasToLoadTheDataSetWithoutErrors;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.ObjectClassName := 'TMyTestClass';

  Assert.WillNotRaise(DataSet.Open);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenFillingAFieldWithSubPropertyMustFillTheLastLevelOfTheField;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyObject := TMyTestClass.Create;
  MyObject.AnotherObject := TAnotherObject.Create;
  MyObject.AnotherObject.AnotherObject := TAnotherObject.Create;

  DataSet.FieldDefs.Add('AnotherObject.AnotherObject.AnotherName', ftString, 50);

  DataSet.OpenObject(MyObject);

  DataSet.Edit;

  DataSet.FieldByName('AnotherObject.AnotherObject.AnotherName').AsString := 'A Name';

  Assert.AreEqual('A Name', DataSet.FieldByName('AnotherObject.AnotherObject.AnotherName').AsString);

  DataSet.Free;

  MyObject.AnotherObject := nil;

  MyObject.Free;
end;

procedure TORMDataSetTest.WhenFillTheDataSetFieldMustLoadTheObjectTypeFromThePropertyOfTheField;
begin
  var DataSet := TORMDataSet.Create(nil);
  var DataSetDetail := TORMDataSet.Create(nil);

  DataSet.ObjectClassName := 'TMyTestClassTypes';

  DataSet.Open;

  DataSetDetail.DataSetField := DataSet.FieldByName('MyArray') as TDataSetField;

  Assert.IsNotNull(DataSetDetail.ObjectType);

  Assert.AreEqual('TMyTestClassTypes', DataSetDetail.ObjectType.Name);

  DataSetDetail.Free;

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenFillTheDataSetFieldPropertyMustLoadTheParentDataSetPropertyWithTheDataSetCorrect;
begin
  var DataSet := TORMDataSet.Create(nil);
  var DataSetDetail := TORMDataSet.Create(nil);

  DataSet.ObjectClassName := 'TMyTestClassTypes';

  DataSet.Open;

  DataSetDetail.DataSetField := DataSet.FieldByName('MyArray') as TDataSetField;

  Assert.AreEqual(DataSet, DataSetDetail.ParentDataSet);

  DataSetDetail.Free;

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenGetAValueFromAFieldAndIsAnObjectMustReturnTheObjectFromTheClass;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyClass := TMyTestClass.Create;
  MyClass.AnotherObject := TAnotherObject.Create;

  DataSet.OpenObject(MyClass);

  Assert.AreEqual<TObject>(MyClass.AnotherObject, (DataSet.FieldByName('AnotherObject') as TORMObjectField).AsObject);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenGetTheValueOfALazyPropertyMustReturnTheValueInsideTheLazyRecord;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyClass := TLazyClass.Create;
  var TheValue := TMyEntity.Create;

  MyClass.Lazy := TheValue;

  DataSet.OpenObject(MyClass);

  Assert.AreEqual<TObject>(TheValue, TORMObjectField(DataSet.FindField('Lazy')).AsObject);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenHaveFieldDefDefinedCantLoadFieldsFromTheClass;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyObject := TMyTestClass.Create;

  DataSet.FieldDefs.Add('Id', ftInteger);
  DataSet.FieldDefs.Add('Name', ftString, 20);
  DataSet.FieldDefs.Add('Value', ftFloat);

  DataSet.OpenObject(MyObject);

  Assert.AreEqual(3, DataSet.FieldDefs.Count);

  DataSet.Free;

  MyObject.Free;
end;

procedure TORMDataSetTest.WhenInsertARecordThenCancelTheInsertionAndStartANewInsertTheOldBufferMustBeCleanedUp;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenClass<TMyTestClass>;

  DataSet.Append;

  DataSet.FieldByName('Name').AsString := 'Name1';

  DataSet.Cancel;

  DataSet.Append;

  Assert.AreEqual(EmptyStr, DataSet.FieldByName('Name').AsString);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenInsertIntoDataSetCantRaiseAnError;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenClass<TMyTestClass>;

  Assert.WillNotRaise(DataSet.Append);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenNavigateByDataSetMustHaveToShowTheValuesFromTheList;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyList := TObjectList<TMyTestClass>.Create;

  for var A := 1 to 10 do
  begin
    var MyObject := TMyTestClass.Create;
    MyObject.Id := A;
    MyObject.Name := Format('Name%d', [A]);
    MyObject.Value := A + A;

    MyList.Add(MyObject);
  end;

  DataSet.OpenList<TMyTestClass>(MyList);

  for var B := 1 to 10 do
  begin
    Assert.AreEqual<Integer>(B, DataSet.FieldByName('Id').AsInteger);
    Assert.AreEqual(Format('Name%d', [B]), DataSet.FieldByName('Name').AsString);
    Assert.AreEqual<Double>(B + B, DataSet.FieldByName('Value').AsFloat);

    DataSet.Next;
  end;

  DataSet.Free;

  MyList.Free;
end;

procedure TORMDataSetTest.WhenNavigatingBackHaveToLoadTheListValuesAsExpected;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyList := TObjectList<TMyTestClass>.Create;

  for var A := 1 to 10 do
  begin
    var MyObject := TMyTestClass.Create;
    MyObject.Id := A;
    MyObject.Name := Format('Name%d', [A]);
    MyObject.Value := A + A;

    MyList.Add(MyObject);
  end;

  DataSet.OpenList<TMyTestClass>(MyList);

  DataSet.Last;

  for var B := 10 downto 1 do
  begin
    Assert.AreEqual<Integer>(B, DataSet.FieldByName('Id').AsInteger);
    Assert.AreEqual(Format('Name%d', [B]), DataSet.FieldByName('Name').AsString);
    Assert.AreEqual<Double>(B + B, DataSet.FieldByName('Value').AsFloat);

    DataSet.Prior;
  end;

  DataSet.Free;

  MyList.Free;
end;

procedure TORMDataSetTest.WhenOpenAClassWithDerivationMustLoadTheFieldFromTheBaseClassToo;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenClass<TMyTestClassChild>;

  Assert.AreEqual(6, DataSet.FieldCount);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenOpenADataSetWithDetailMustLoadTheRecordsOfTheDetail;
begin
  var DataSet := TORMDataSet.Create(nil);
  var DataSetDetail := TORMDataSet.Create(nil);
  var MyClass: TArray<TMyTestClassTypes> := [TMyTestClassTypes.Create, TMyTestClassTypes.Create];
  MyClass[0].MyArray := [TMyTestClassTypes.Create, TMyTestClassTypes.Create];

  DataSet.OpenArray<TMyTestClassTypes>(MyClass);

  DataSetDetail.DataSetField := DataSet.FieldByName('MyArray') as TDataSetField;

  Assert.AreEqual(2, DataSetDetail.RecordCount);

  MyClass[0].MyArray[0].Free;

  MyClass[0].MyArray[1].Free;

  MyClass[1].Free;

  MyClass[0].Free;

  DataSetDetail.Free;

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenOpenAnEmptyDataSetCantRaiseAnError;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenClass<TMyTestClass>;

  Assert.WillNotRaise(
    procedure
    begin
      DataSet.GetCurrentObject<TMyTestClass>;
    end);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenOpenAnEmptyDataSetTheCurrentObjectMustReturnNil;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenClass<TMyTestClass>;

  Assert.IsNull(DataSet.GetCurrentObject<TMyTestClass>);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenOpenAnEmptyDataSetTheValueOfTheFieldMustReturnNull;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenClass<TMyTestClass>;

  Assert.IsNull(DataSet.FieldByName('Name').Value);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenOpenDataSetFromAListMustHaveToLoadFieldListWithPropertiesOfMappedObject;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyObject := TObjectList<TMyTestClass>.Create;

  DataSet.OpenList<TMyTestClass>(MyObject);

  Assert.AreEqual(4, DataSet.FieldCount);

  DataSet.Free;

  MyObject.Free;
end;

procedure TORMDataSetTest.WhenOpenDataSetHaveToLoadFieldListWithPropertiesOfMappedObject;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyObject := TMyTestClass.Create;

  DataSet.OpenObject(MyObject);

  Assert.AreEqual(4, DataSet.FieldCount);

  DataSet.Free;

  MyObject.Free;
end;

procedure TORMDataSetTest.WhenOpenTheDataSetWithAListTheRecordCountMustBeTheSizeOfTheList;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyList := TObjectList<TMyTestClass>.Create;

  MyList.Add(TMyTestClass.Create);

  MyList.Add(TMyTestClass.Create);

  MyList.Add(TMyTestClass.Create);

  MyList.Add(TMyTestClass.Create);

  DataSet.OpenList<TMyTestClass>(MyList);

  Assert.AreEqual(4, DataSet.RecordCount);

  DataSet.Free;

  MyList.Free;
end;

procedure TORMDataSetTest.WhenOpenTheDataSetWithAObjectTheRecordCountMustBeOne;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyObject := TMyTestClass.Create;

  DataSet.OpenObject(MyObject);

  Assert.AreEqual(1, DataSet.RecordCount);

  DataSet.Free;

  MyObject.Free;
end;

procedure TORMDataSetTest.WhenOpenTheDetailDataSetMustLoadAllRecordsFromTheParentDataSet;
begin
  var DataSet := TORMDataSet.Create(nil);
  var DataSetDetail := TORMDataSet.Create(nil);
  var MyClass := TMyTestClassTypes.Create;
  MyClass.MyArray := [TMyTestClassTypes.Create, TMyTestClassTypes.Create];

  DataSet.OpenObject(MyClass);

  DataSetDetail.DataSetField := DataSet.FieldByName('MyArray') as TDataSetField;

  DataSet.Close;

  DataSetDetail.Close;

  DataSet.OpenObject(MyClass);

  Assert.AreEqual(2, DataSetDetail.RecordCount);

  MyClass.MyArray[0].Free;

  MyClass.MyArray[1].Free;

  MyClass.Free;

  DataSetDetail.Free;

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenPostARecordMustAppendToListOfObjects;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenClass<TMyTestClass>;

  DataSet.Append;

  DataSet.Post;

  DataSet.Append;

  DataSet.Post;

  Assert.AreEqual(2, DataSet.RecordCount);

  DestroyObjectArray(DataSet.ObjectList);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenPostTheDetailDataSetMustUpdateTheArrayValueFromParentDataSet;
begin
  var DataSet := TORMDataSet.Create(nil);
  var DataSetDetail := TORMDataSet.Create(nil);
  var MyClass := TMyTestClassTypes.Create;

  DataSet.OpenObject(MyClass);

  DataSetDetail.DataSetField := DataSet.FieldByName('MyArray') as TDataSetField;

  DataSet.Edit;

  DataSetDetail.Append;

  DataSetDetail.Post;

  DataSetDetail.Append;

  DataSetDetail.Post;

  Assert.AreEqual<Integer>(2, Length(MyClass.MyArray));

  MyClass.MyArray[0].Free;

  MyClass.MyArray[1].Free;

  DataSetDetail.Free;

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenScrollTheParentDataSetMustLoadTheArrayInDetailDataSet;
begin
  var DataSet := TORMDataSet.Create(nil);
  var DataSetDetail := TORMDataSet.Create(nil);
  var MyClass: TArray<TMyTestClassTypes> := [TMyTestClassTypes.Create, TMyTestClassTypes.Create];
  MyClass[1].MyArray := [TMyTestClassTypes.Create, TMyTestClassTypes.Create];

  DataSet.OpenArray<TMyTestClassTypes>(MyClass);

  DataSetDetail.DataSetField := DataSet.FieldByName('MyArray') as TDataSetField;

  DataSet.Next;

  Assert.AreEqual(2, DataSetDetail.RecordCount);

  MyClass[1].MyArray[0].Free;

  MyClass[1].MyArray[1].Free;

  MyClass[1].Free;

  MyClass[0].Free;

  DataSetDetail.Free;

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenSetAValueToAFieldThatIsAnObjectMustFillThePropertyInTheClassWithThisObject;
begin
  var AnotherObject := TAnotherObject.Create;
  var DataSet := TORMDataSet.Create(nil);
  var MyClass := TMyTestClass.Create;

  DataSet.OpenObject(MyClass);

  DataSet.Edit;

  (DataSet.FieldByName('AnotherObject') as TORMObjectField).AsObject := AnotherObject;

  DataSet.Post;

  Assert.AreEqual(AnotherObject, MyClass.AnotherObject);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenSetTheFieldValueMustChangeTheValueFromTheClass(FieldName, FieldValue: String);
begin
  var Context := TRttiContext.Create;
  var DataSet := TORMDataSet.Create(nil);
  var RttiType := Context.GetType(TMyTestClassTypes);
  var Value := NULL;

  var &Property := RttiType.GetProperty(FieldName);

  DataSet.OpenClass<TMyTestClassTypes>;

  DataSet.Append;

  var Field := DataSet.FieldByName(FieldName);

  Field.AsString := FieldValue;

  case Field.DataType of
    ftBoolean: Value := True;
    ftDate: Value := EncodeDate(2020, 12, 21);
    ftDateTime: Value := EncodeDate(2020, 12, 21) + EncodeTime(17, 17, 17, 0);
    ftTime: Value := EncodeTime(17, 17, 17, 0);
    ftString,
    ftWideString:
      if Field.Size = 1 then
        Value := 'C'
      else
        Value := 'Value String';

    ftByte,
    ftInteger,
    ftLargeint,
    ftLongWord,
    ftWord:
    begin
      if &Property.PropertyType is TRttiEnumerationType then
        Value := Enum2
      else
        Value := 123;
    end;

    ftCurrency,
    ftFloat,
    ftSingle: Value := 123.456;
  end;

  Assert.IsTrue(Value = &Property.GetValue(DataSet.GetCurrentObject<TMyTestClassTypes>).AsVariant);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenTheFieldAndPropertyTypeAreDifferentItHasToRaiseAnException;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyObject := TMyTestClass.Create;

  DataSet.FieldDefs.Add('Name', ftInteger);

  Assert.WillRaise(
    procedure
    begin
      DataSet.OpenObject(MyObject);
    end, EPropertyWithDifferentType);

  DataSet.Free;

  MyObject.Free;
end;

procedure TORMDataSetTest.WhenTheFieldDefNameNotExistsInPropertyListMustRaiseAException;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyObject := TMyTestClass.Create;

  DataSet.FieldDefs.Add('InvalidPropertyName', ftInteger);

  Assert.WillRaise(
    procedure
    begin
      DataSet.OpenObject(MyObject);
    end, EPropertyNameDoesNotExist);

  DataSet.Free;

  MyObject.Free;
end;

procedure TORMDataSetTest.WhenTheFieldIsMappedToANullableFieldAndTheValueIsntFilledMustReturnNullInTheFieldValue;
begin
  var DataSet := TORMDataSet.Create(nil);

  var MyClass := TClassWithNullableProperty.Create;

  DataSet.OpenObject(MyClass);

  Assert.IsNull(DataSet.FieldByName('Nullable').Value);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenTheNullablePropertyIsFilledMustReturnTheValueFilled;
begin
  var DataSet := TORMDataSet.Create(nil);

  var MyClass := TClassWithNullableProperty.Create;
  MyClass.Nullable := 12345678;

  DataSet.OpenObject(MyClass);

  Assert.AreEqual(12345678, DataSet.FieldByName('Nullable').AsInteger);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenThePropertyIsANullableTypeMustCreateTheField;
begin
  var DataSet := TORMDataSet.Create(nil);

  var MyClass := TClassWithNullableProperty.Create;

  DataSet.OpenObject(MyClass);

  Assert.IsTrue(DataSet.FindField('Nullable') <> nil);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenThePropertyIsANullableTypeMustCreateTheFieldWithTheInternalTypeOfTheNullable;
begin
  var DataSet := TORMDataSet.Create(nil);

  var MyClass := TClassWithNullableProperty.Create;

  DataSet.OpenObject(MyClass);

  Assert.AreEqual(ftInteger, DataSet.FieldByName('Nullable').DataType);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenThePropertyOfTheClassIsLazyLoadingMustCreateTheField;
begin
  var DataSet := TORMDataSet.Create(nil);

  var MyClass := TLazyClass.Create;

  DataSet.OpenObject(MyClass);

  Assert.IsTrue(DataSet.FindField('Lazy') <> nil);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenThePropertyOfTheClassIsLazyLoadingMustCreateTheFieldWithTheGenericTypeOfTheLazyRecord;
begin
  var DataSet := TORMDataSet.Create(nil);

  var MyClass := TLazyClass.Create;

  DataSet.OpenObject(MyClass);

  Assert.AreEqual(ftVariant, DataSet.FindField('Lazy').DataType);

  DataSet.Free;

  MyClass.Free;
end;

procedure TORMDataSetTest.WhenTryOpenADataSetWithoutAObjectDefinitionMustRaiseAnError;
begin
  var DataSet := TORMDataSet.Create(nil);

  Assert.WillRaise(
    procedure
    begin
      DataSet.Open;
    end, EDataSetWithoutObjectDefinition);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenTryToGetAComposeFieldNameFromALazyPropertyMustLoadAsExpected;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyObject := TLazyClass.Create;
  MyObject.Lazy := TMyEntity.Create;
  MyObject.Lazy.Value.Name := 'Test';

  DataSet.FieldDefs.Add('Lazy.Name', ftString, 50);

  DataSet.OpenObject(MyObject);

  Assert.AreEqual('Test', DataSet.FieldByName('Lazy.Name').AsString);

  DataSet.Free;

  MyObject.Free;
end;

procedure TORMDataSetTest.WhenTryToGetAFieldValueFromAEmptyDataSetCantRaiseAnError;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenClass<TMyTestClass>;

  Assert.WillNotRaise(
    procedure
    begin
      DataSet.FieldByName('Name').AsString;
    end);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenUseQualifiedClassNameHasToLoadTheDataSetWithoutErrors;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.ObjectClassName := 'Delphi.ORM.DataSet.Test.TMyTestClass';

  Assert.WillNotRaise(DataSet.Open);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenUseTheOpenClassMustLoadFieldFromTheClass;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenClass<TMyTestClass>;

  Assert.AreEqual(4, DataSet.FieldCount);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenTheRecordBufferIsBiggerThenOneMustLoadTheBufferOfTheDataSetAsExpected;
begin
  var DataLink := TDataLink.Create;
  var DataSet := TORMDataSet.Create(nil);
  var DataSource := TDataSource.Create(nil);

  DataLink.BufferCount := 15;
  DataLink.DataSource := DataSource;
  DataSource.DataSet := DataSet;

  var MyList := TObjectList<TMyTestClass>.Create;

  for var A := 1 to 10 do
  begin
    var MyObject := TMyTestClass.Create;
    MyObject.Id := A;
    MyObject.Name := Format('Name%d', [A]);
    MyObject.Value := A + A;

    MyList.Add(MyObject);
  end;

  DataSet.OpenList<TMyTestClass>(MyList);

  for var A := 1 to 10 do
    DataSet.Next;

  Assert.AreEqual<Integer>(10, DataSet.FieldByName('Id').AsInteger);
  Assert.AreEqual('Name10', DataSet.FieldByName('Name').AsString);
  Assert.AreEqual<Double>(20, DataSet.FieldByName('Value').AsFloat);

  DataLink.Free;

  DataSource.Free;

  DataSet.Free;

  MyList.Free;
end;

procedure TORMDataSetTest.WhenChangeTheObjectTypeOfTheDataSetMustBeClosedToAcceptTheChange;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.ObjectClassName := 'TMyTestClass';

  DataSet.Open;

  Assert.WillRaise(
    procedure
    begin
      DataSet.ObjectClassName := 'TMyTestClass';
    end);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenCheckingIfTheFieldIsNullCantRaiseAnError;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyObject := TMyTestClass.Create;

  DataSet.OpenObject(MyObject);

  Assert.WillNotRaise(
    procedure
    begin
      DataSet.FieldByName('Id').IsNull;
    end);

  DataSet.Free;

  MyObject.Free;
end;

procedure TORMDataSetTest.WhenCleanUpTheDataSetFieldPropertyTheParentDataSetMustBeCleanedToo;
begin
  var DataSet := TORMDataSet.Create(nil);
  var DataSetDetail := TORMDataSet.Create(nil);

  DataSet.ObjectClassName := 'TMyTestClassTypes';

  DataSet.Open;

  DataSetDetail.DataSetField := DataSet.FieldByName('MyArray') as TDataSetField;

  DataSetDetail.DataSetField := nil;

  Assert.IsNull(DataSetDetail.ParentDataSet);

  DataSetDetail.Free;

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenCleanUpTheObjectClassNameMustStayEmpty;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.ObjectClassName := 'TMyTestClass';

  DataSet.ObjectClassName := EmptyStr;

  Assert.AreEqual(EmptyStr, DataSet.ObjectClassName);

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenClearAFieldCantRaiseAnError;
begin
  var DataSet := TORMDataSet.Create(nil);

  DataSet.OpenClass<TMyTestClass>;

  DataSet.Append;

  Assert.WillNotRaise(DataSet.FieldByName('Id').Clear);

  DataSet.Cancel;

  DataSet.Free;
end;

procedure TORMDataSetTest.WhenCloseTheDataSetMustCleanUpTheObjectList;
begin
  var DataSet := TORMDataSet.Create(nil);
  var MyClass: TArray<TMyTestClassTypes> := [TMyTestClassTypes.Create, TMyTestClassTypes.Create];

  DataSet.OpenArray<TMyTestClassTypes>(MyClass);

  DataSet.Close;

  Assert.AreEqual(0, DataSet.RecordCount);

  MyClass[1].Free;

  MyClass[0].Free;

  DataSet.Free;
end;

{ TMyTestClass }

destructor TMyTestClass.Destroy;
begin
  FAnotherObject.Free;

  inherited;
end;

{ TAnotherObject }

destructor TAnotherObject.Destroy;
begin
  FAnotherObject.Free;

  inherited;
end;

end.

