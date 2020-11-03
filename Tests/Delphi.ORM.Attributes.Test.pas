unit Delphi.ORM.Attributes.Test;

interface

uses DUnitX.TestFramework;

type
  [TestFixture]
  TPrimaryKeyAttributeTeste = class
  public
    [Test]
    procedure TheFieldsPropertyMustReturnAllFieldsInTheStringInTheConstructor;
    [Test]
    procedure TheFieldsPassedInConstructorMustReturnInTheListOfFields;
    [Test]
    procedure MustRemoveAllWhiteSpaceFromFieldNames;
  end;

implementation

uses Delphi.ORM.Attributes;

{ TPrimaryKeyAttributeTeste }

procedure TPrimaryKeyAttributeTeste.MustRemoveAllWhiteSpaceFromFieldNames;
begin
  var Attribute := PrimaryKeyAttribute.Create(' F1 ,F2  ,F3 ');

  Assert.AreEqual('F1', Attribute.Fields[0]);
  Assert.AreEqual('F2', Attribute.Fields[1]);
  Assert.AreEqual('F3', Attribute.Fields[2]);

  Attribute.Free;
end;

procedure TPrimaryKeyAttributeTeste.TheFieldsPassedInConstructorMustReturnInTheListOfFields;
begin
  var Attribute := PrimaryKeyAttribute.Create('F1,F2,F3');

  Assert.AreEqual('F1', Attribute.Fields[0]);
  Assert.AreEqual('F2', Attribute.Fields[1]);
  Assert.AreEqual('F3', Attribute.Fields[2]);

  Attribute.Free;
end;

procedure TPrimaryKeyAttributeTeste.TheFieldsPropertyMustReturnAllFieldsInTheStringInTheConstructor;
begin
  var Attribute := PrimaryKeyAttribute.Create('F1,F2,F3');

  Assert.AreEqual<Integer>(3, Length(Attribute.Fields));

  Attribute.Free;
end;

end.
