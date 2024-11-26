﻿unit Persisto.Mapping;

interface

uses System.Rtti, System.TypInfo, System.SysUtils, Data.DB{$IFDEF PAS2JS}, JSApi.JS, BrowserApi.Web{$ENDIF};

type
  TAutoGeneratedType = (agtNotDefined, agtCurrentDate, agtCurrentTime, agtCurrentDateTime, agtNewUniqueIdentifier, agtNewGuid, agtSequence, agtFixedValue);
  TDatabaseSpecialType = (stNotDefined, stDate, stDateTime, stTime, stText, stUniqueIdentifier, stBoolean, stBinary);
  TNullEnumerator = (NULL);

  TCustomNameAttribute = class(TCustomAttribute)
  private
    FName: String;
  public
    constructor Create(const Name: String);

    property Name: String read FName;
  end;

  EntityAttribute = class(TCustomAttribute);
  FieldNameAttribute = class(TCustomNameAttribute);
  ForeignKeyNameAttribute = class(TCustomNameAttribute);
  PrimaryKeyAttribute = class(TCustomNameAttribute);
  SingleTableInheritanceAttribute = class(TCustomAttribute);
  TableNameAttribute = class(TCustomNameAttribute);

  ManyValueAssociationLinkNameAttribute = class(TCustomNameAttribute)
  public
    constructor Create(const ChildFieldName: String);
  end;

  IndexAttribute = class(TCustomNameAttribute)
  private
    FFields: String;
  public
    constructor Create(const Name, Fields: String);

    property Fields: String read FFields;
  end;

  UniqueIndexAttribute = class(IndexAttribute);

  FieldInfoAttribute = class(TCustomAttribute)
  private
    FPrecision: Word;
    FScale: Word;
    FSize: Word;
    FSpecialType: TDatabaseSpecialType;

    constructor Create(const SpecialType: TDatabaseSpecialType; const Size, Scale: Word); overload;
  public
    constructor Create(const Precision, Scale: Word); overload;
    constructor Create(const Size: Word); overload;
    constructor Create(const SpecialType: TDatabaseSpecialType); overload;

    property Precision: Word read FPrecision;
    property Scale: Word read FScale;
    property Size: Word read FSize;
    property SpecialType: TDatabaseSpecialType read FSpecialType;
  end;

  UniqueIdentifierAttribute = class(FieldInfoAttribute)
  public
    constructor Create;
  end;

  TextAttribute = class(FieldInfoAttribute)
  public
    constructor Create;
  end;

  SizeAttribute = class(FieldInfoAttribute)
  public
    constructor Create(const Size: Word);
  end;

  PrecisionAttribute = class(FieldInfoAttribute)
  public
    constructor Create(const Precision, Scale: Word);
  end;

  RequiredAttribute = class(TCustomAttribute)
  end;

  TAutoGeneratedAttribute = class(TCustomAttribute)
  private
    FType: TAutoGeneratedType;

    constructor Create(const &Type: TAutoGeneratedType);
  public
    property &Type: TAutoGeneratedType read FType write FType;
  end;

  CurrentDateAttribute = class(TAutoGeneratedAttribute)
  public
    constructor Create;
  end;

  CurrentTimeAttribute = class(TAutoGeneratedAttribute)
  public
    constructor Create;
  end;

  CurrentDateTimeAttribute = class(TAutoGeneratedAttribute)
  public
    constructor Create;
  end;

  FixedValueAttribute = class(TAutoGeneratedAttribute)
  private
    FValue: String;
  public
    constructor Create(const Value: String);

    property Value: String read FValue write FValue;
  end;

  NewUniqueIdentifierAttribute = class(TAutoGeneratedAttribute)
  public
    constructor Create;
  end;

  NewGuidAttribute = class(TAutoGeneratedAttribute)
  public
    constructor Create;
  end;

  SequenceAttribute = class(TAutoGeneratedAttribute)
  private
    FName: String;
  public
    constructor Create(const Name: String);

    property Name: String read FName write FName;
  end;

  ILazyValue = {$IFDEF DCC} interface{$ELSE} class public {$ENDIF}
    function GetKey: TValue; {$IFDEF PAS2JS} virtual; abstract; {$ENDIF}
    function GetValue: TValue; {$IFDEF PAS2JS} virtual; abstract; {$ENDIF}
{$IFDEF PAS2JS}
    function GetValueAsync: TValue; virtual; abstract; async;
{$ENDIF}
    procedure SetValue(const Value: TValue); {$IFDEF PAS2JS} virtual; abstract; {$ENDIF}

    property Key: TValue read GetKey;
    property Value: TValue read GetValue write SetValue;
  end;

  Lazy<T> = record
  private
    FLazyValue: ILazyValue;

    procedure SetValue(const Value: T);
  public
    function GetLazyValue: ILazyValue;
    function GetValue: T;
{$IFDEF PAS2JS}
    function GetValueAsync: T; async;
{$ENDIF}
{$IFDEF DCC}
    class operator Implicit(const Value: Lazy<T>): T;
    class operator Implicit(const Value: T): Lazy<T>;
{$ENDIF}

    property LazyValue: ILazyValue read GetLazyValue;
    property Value: T read GetValue write SetValue;
  end;

  TLazyValue = class({$IFDEF DCC}TInterfacedObject, {$ENDIF}ILazyValue)
  private
    FValue: TValue;
  protected
    function GetKey: TValue; {$IFDEF PAS2JS} override; {$ENDIF}
    function GetValue: TValue; {$IFDEF PAS2JS} override; {$ENDIF}
{$IFDEF PAS2JS}
    function GetValueAsync: TValue; override; async;
{$ENDIF}
    procedure SetValue(const Value: TValue); {$IFDEF PAS2JS} override; {$ENDIF}
  public
    constructor Create(const Info: PTypeInfo);
  end;

  TRttiTypeHelper = class helper for TRttiType
  public
    function AsArray: TRttiDynamicArrayType;
    function IsArray: Boolean;
  end;

  TValueHelper = record helper for TValue
  private
    function GetArrayElementInternal(Index: Integer): TValue; inline;
    function GetArrayLengthInternal: Integer; inline;

    procedure SetArrayElementInternal(Index: Integer; const Value: TValue); inline;
    procedure SetArrayLengthInternal(const Size: Integer); inline;
  public
    property ArrayElement[Index: Integer]: TValue read GetArrayElementInternal write SetArrayElementInternal;
    property ArrayLength: Integer read GetArrayLengthInternal write SetArrayLengthInternal;
  end;

function GetLazyType(const RttiType: TRttiType): TRttiType;
function IsLazy(const RttiType: TRttiType): Boolean;

implementation

uses {$IFDEF PAS2JS}System.RTLConsts{$ELSE}System.Variants, System.SysConst{$ENDIF};

const
  LAZY_TYPE_NAME = 'Lazy<';

function GetLazyType(const RttiType: TRttiType): TRttiType;
begin
  Result := RttiType.GetMethod('GetValue').ReturnType;
end;

function IsLazy(const RttiType: TRttiType): Boolean;
begin
  Result := RttiType.Name.StartsWith(LAZY_TYPE_NAME);
end;

{ TLazyValue }

constructor TLazyValue.Create(const Info: PTypeInfo);
begin
  inherited Create;

  TValue.Make(nil, Info, FValue);
end;

function TLazyValue.GetKey: TValue;
begin
  Result := TValue.Empty;
end;

function TLazyValue.GetValue: TValue;
begin
  Result := FValue;
end;

procedure TLazyValue.SetValue(const Value: TValue);
begin
  FValue := Value;
end;

{$IFDEF PAS2JS}

function TLazyValue.GetValueAsync: TValue;
begin
  Result := GetValue;
end;
{$ENDIF}
{ Lazy<T> }

function Lazy<T>.GetLazyValue: ILazyValue;
begin
  if not Assigned(FLazyValue) then
    FLazyValue := TLazyValue.Create(TypeInfo(T));

  Result := FLazyValue;
end;

function Lazy<T>.GetValue: T;
begin
  Result := LazyValue.Value.AsType<T>;
end;

{$IFDEF PAS2JS}

function Lazy<T>.GetValueAsync: T;
begin
//  Result := LazyValue.GetValueAsync.AsType<T>;
end;
{$ENDIF}
{$IFDEF DCC}

class operator Lazy<T>.Implicit(const Value: T): Lazy<T>;
begin
  Result.Value := Value;
end;

class operator Lazy<T>.Implicit(const Value: Lazy<T>): T;
begin
  Result := Value.Value;
end;
{$ENDIF}

procedure Lazy<T>.SetValue(const Value: T);
begin
  LazyValue.Value := TValue.From<T>(Value);
end;

{ TCustomNameAttribute }

constructor TCustomNameAttribute.Create(const Name: String);
begin
  inherited Create;

  FName := Name;
end;

{ IndexAttribute }

constructor IndexAttribute.Create(const Name, Fields: String);
begin
  inherited Create(Name);

  FFields := Fields;
end;

{ FieldInfoAttribute }

constructor FieldInfoAttribute.Create(const Precision, Scale: Word);
begin
  Create(stNotDefined, Precision, Scale);
end;

constructor FieldInfoAttribute.Create(const Size: Word);
begin
  Create(stNotDefined, Size, 0);
end;

constructor FieldInfoAttribute.Create(const SpecialType: TDatabaseSpecialType);
begin
  Create(SpecialType, 0, 0);
end;

constructor FieldInfoAttribute.Create(const SpecialType: TDatabaseSpecialType; const Size, Scale: Word);
begin
  inherited Create;

  FScale := Scale;
  FSize := Size;
  FSpecialType := SpecialType;
end;

{ UniqueIdentifierAttribute }

constructor UniqueIdentifierAttribute.Create;
begin
  inherited Create(stUniqueIdentifier, 0, 0);
end;

{ SizeAttribute }

constructor SizeAttribute.Create(const Size: Word);
begin
  inherited Create(Size);
end;

{ PrecisionAttribute }

constructor PrecisionAttribute.Create(const Precision, Scale: Word);
begin
  inherited Create(Precision, Scale);
end;

{ TextAttribute }

constructor TextAttribute.Create;
begin
  inherited Create(stText, 0, 0);
end;

{ TAutoGeneratedAttribute }

constructor TAutoGeneratedAttribute.Create(const &Type: TAutoGeneratedType);
begin
  inherited Create;

  FType := &Type;
end;

{ CurrentDateAttribute }

constructor CurrentDateAttribute.Create;
begin
  inherited Create(agtCurrentDate);
end;

{ CurrentTimeAttribute }

constructor CurrentTimeAttribute.Create;
begin
  inherited Create(agtCurrentTime);
end;

{ CurrentDateTimeAttribute }

constructor CurrentDateTimeAttribute.Create;
begin
  inherited Create(agtCurrentDateTime);
end;

{ NewUniqueIdentifierAttribute }

constructor NewUniqueIdentifierAttribute.Create;
begin
  inherited Create(agtNewUniqueIdentifier);
end;

{ NewGuidAttribute }

constructor NewGuidAttribute.Create;
begin
  inherited Create(agtNewGuid);
end;

{ SequenceAttribute }

constructor SequenceAttribute.Create(const Name: String);
begin
  inherited Create(agtSequence);

  FName := Name;
end;

{ FixedValueAttribute }

constructor FixedValueAttribute.Create(const Value: String);
begin
  inherited Create(agtFixedValue);

  FValue := Value;
end;

{ TValueHelper }

function TValueHelper.GetArrayElementInternal(Index: Integer): TValue;
begin
  Result := GetArrayElement(Index);
end;

function TValueHelper.GetArrayLengthInternal: Integer;
begin
  Result := GetArrayLength;
end;

procedure TValueHelper.SetArrayElementInternal(Index: Integer; const Value: TValue);
begin
  SetArrayElement(Index, Value);
end;

procedure TValueHelper.SetArrayLengthInternal(const Size: Integer);
begin
  if TypeInfo{$IFDEF DCC}^{$ENDIF}.Kind <> tkDynArray then
    raise EInvalidCast.{$IFDEF PAS2JS}Create(SErrInvalidTypecast){$ELSE}CreateRes(@SInvalidCast){$ENDIF};

{$IFDEF PAS2JS}
  SetArrayLength(Size);
{$ELSE}
  var NativeSize: NativeInt := Size;

  DynArraySetLength(PPointer(GetReferenceToRawData)^, TypeInfo, 1, @NativeSize);
{$ENDIF}
end;

{ TRttiTypeHelper }

function TRttiTypeHelper.AsArray: TRttiDynamicArrayType;
begin
  Result := Self as TRttiDynamicArrayType;
end;

function TRttiTypeHelper.IsArray: Boolean;
begin
  Result := Self is TRttiDynamicArrayType;
end;

{ ManyValueAssociationLinkNameAttribute }

constructor ManyValueAssociationLinkNameAttribute.Create(const ChildFieldName: String);
begin
  inherited;
end;

end.
