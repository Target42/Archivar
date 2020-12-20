unit m_cache;

interface

uses
  System.SysUtils, System.Classes, m_glob_client, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect;

type
  TCacheMod = class(TDataModule)
    DSProviderConnection1: TDSProviderConnection;
    HCTab: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure download( fname : string );
  public
    procedure checkFiles;
  end;

var
  CacheMod: TCacheMod;

implementation

uses
  system.IOUtils, IdHashMessageDigest;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TCacheMod.checkFiles;
var
  fname : string;
  needUpdate : boolean;
begin
  HCTab.Open;
  while not HCTab.Eof do
  begin
    fname := TPath.Combine( GM.wwwHome, HCTab.FieldByName('HC_PATH').AsString);
    ForceDirectories(fname);
    fname := TPath.Combine( fname, HCTab.FieldByName('HC_NAME').AsString);

    needUpdate := not SameText( gm.md5(fname), HCTab.FieldByName('HC_MD5').AsString);
    if needUpdate then
    begin
      download( fname );
    end;
    HCTab.Next;
  end;
  HCTab.close;
end;

procedure TCacheMod.DataModuleCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
end;

procedure TCacheMod.download(fname: string);
var
  src, dest : TStream;
begin
  src := HCTab.CreateBlobStream(HCTab.FieldByName('HC_DATA'), bmRead);
  dest  := TFileStream.Create( fname, fmCreate + fmShareExclusive );
  try
    dest.CopyFrom(src, -1);
  finally
    dest.Free;
    src.Free;
  end;
end;


end.
