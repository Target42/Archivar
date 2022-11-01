unit ds_pki;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSProviderDataModuleAdapter, System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
  TdsPKI = class(TDSServerModule)
    GetKeyQry: TFDQuery;
    FDTransaction1: TFDTransaction;
    getUserQry: TFDQuery;
    PKTab: TFDTable;
    UpdateKeyQry: TFDQuery;
    FDTransaction2: TFDTransaction;
    AutoIncQry: TFDQuery;
    PETab: TFDTable;
    GetPrivateQry: TFDQuery;
  private
    function AutoInc( gen : string ) : integer;
  public
    function uploadKeys( net : string; pub, priv : TStream ) : TJSONObject;
    function getPublicKey( net : string; stamp : TDateTime ) : TStream;
    function getPrivateKey : TStream;
    function hasValidKey ( net : string; stamp : TDateTime ) : Boolean;
  end;

implementation

uses
  Datasnap.DSSession, u_json, m_glob_server, System.Variants;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdsPKI }

function TdsPKI.AutoInc(gen: string): integer;
begin
  AutoIncQry.SQL.Text := 'SELECT GEN_ID( '+gen+', 1 ) FROM RDB$DATABASE;';
  AutoIncQry.Open;
  Result := AutoIncQry.FieldByName('GEN_ID').AsInteger;
  AutoIncQry.Close;
end;

function TdsPKI.getPrivateKey: TStream;
var
  st      : TStream;
  Session : TDSSession;
begin
  Result := TMemoryStream.Create;
  Session := TDSSessionManager.GetThreadSession;

  GetPrivateQry.ParamByName('name').AsString  := Session.GetData('user');

  GetPrivateQry.Open;
  if not GetPrivateQry.IsEmpty then begin
    st := GetPrivateQry.CreateBlobStream(GetPrivateQry.FieldByName('PE_KEY'), bmRead);
    Result.CopyFrom(st, -1);
    st.Free;
    Result.Position := 0;
  end;
  GetPrivateQry.Close;

  if GetPrivateQry.Transaction.Active then
    GetPrivateQry.Transaction.Commit;
end;

function TdsPKI.getPublicKey(net: string; stamp: TDateTime): TStream;
var
  st      : TStream;
  Session : TDSSession;
begin
  Result := TMemoryStream.Create;
  Session := TDSSessionManager.GetThreadSession;

  if net = '' then
    net :=Session.GetData('user');

  GetKeyQry.ParamByName('name').AsString  := net;
  GetKeyQry.ParamByName('da').AsDateTime  := stamp;

  GetKeyQry.Open;
  if not GetKeyQry.IsEmpty then begin
    st := GetKeyQry.CreateBlobStream(GetKeyQry.FieldByName('PK_DATA'), bmRead);
    Result.CopyFrom(st, -1);
    st.Free;
    Result.Position := 0;
  end;
  GetKeyQry.Close;

  if GetKeyQry.Transaction.Active then
    GetKeyQry.Transaction.Commit;
end;

function TdsPKI.hasValidKey(net: string; stamp: TDateTime): Boolean;
var
  st : TStream;
begin
  st := getPublicKey(net, stamp);
  Result := st.Size > 0;
  st.Free;
end;

function TdsPKI.uploadKeys(net: string; pub, priv: TStream): TJSONObject;
var
  id    : integer;
  dest  : TStream;
begin
  Result := TJSONObject.Create;

  if FDTransaction2.Active then
    FDTransaction2.Rollback;

  FDTransaction2.StartTransaction;
  try
    id := -1;
    getUserQry.ParamByName('net').AsString := net;
    getUserQry.Open;
    if not getUserQry.IsEmpty then
      id := getUserQry.FieldByName('PE_ID').AsInteger;
    getUserQry.Close;

    if id <> -1  then begin
      UpdateKeyQry.ParamByName('ID').AsInteger := id;
      UpdateKeyQry.ExecSQL;

      PKTab.Open;
      PKTab.Append;
      PKTab.FieldByName('PK_ID').AsInteger      := AutoInc('gen_pk_id');
      PKTab.FieldByName('PE_ID').AsInteger      := id;
      PKTab.FieldByName('PK_START').AsDateTime  := now;
      PKTab.FieldByName('PK_END').AsDateTime    := IncMonth(now, 50*12);

      dest := PKTab.CreateBlobStream(PKTab.FieldByName('PK_DATA'), bmWrite);
      GM.downloadInto(pub, dest);
      dest.Free;

      PKTab.Post;

      PETab.Open;

      if PETab.Locate('PE_ID', VarArrayOf([id]), [] ) then begin
        PETab.Edit;
        dest := PETab.CreateBlobStream(PETab.FieldByName('PE_KEY'), bmWrite);
        GM.downloadInto(priv, dest);
        dest.Free;
        PETab.Post;
      end;

      FDTransaction2.Commit;
      PKTab.Close;
      PeTab.Close;

      JResult( Result, true, '');

    end else
      JResult( Result, false, 'Der Benutzer wurde nicht gefunden!');
  except
    on e : exception do begin
      JResult( Result, false, e.ToString);
      if FDTransaction2.Active then
        FDTransaction2.Rollback;
    end;
  end;


end;

end.

