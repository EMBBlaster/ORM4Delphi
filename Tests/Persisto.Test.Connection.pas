﻿unit Persisto.Test.Connection;

interface

uses Persisto;

function CreateConnection: IDatabaseConnection;
function CreateMetadataManipulator: IMetadataManipulator;

implementation

uses Persisto.SQLite, Persisto.Connection.Firedac;

function CreateConnection: IDatabaseConnection;
begin
  var Connection := TDatabaseConnectionFireDAC.Create;
  Connection.Connection.DriverName := 'SQLite';
  Connection.Connection.Params.Database := ':memory:';

  Result := Connection;
end;

function CreateMetadataManipulator: IMetadataManipulator;
begin
  Result := TManipulatorSQLite.Create(nil);
end;

end.
