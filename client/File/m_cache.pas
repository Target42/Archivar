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
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_files : TStringList;
    procedure download( fname : string );
    procedure fillFiles;
  public
    procedure checkFiles;
  end;

var
  CacheMod: TCacheMod;

implementation

uses
  system.IOUtils, IdHashMessageDigest, System.Types;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TCacheMod.checkFiles;
var
  fname : string;
  inx   : integer;
  i     : integer;
  needUpdate : boolean;
begin
  fillFiles;

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
    inx := m_files.IndexOf(LowerCase(fname));
    if inx <> -1 then
      m_files.Delete(inx);
    HCTab.Next;
  end;
  HCTab.close;

  if m_files.Count > 0 then
  begin
    for i := 0 to pred(m_files.Count) do
      try
        DeleteFile(m_files[i])
      except

      end;
  end;
  m_files.Clear;
end;

procedure TCacheMod.DataModuleCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_files := TStringList.Create;
end;

procedure TCacheMod.DataModuleDestroy(Sender: TObject);
begin
  m_files.Free;
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


procedure TCacheMod.fillFiles;
var
  i : integer;
  arr : TStringDynArray;
begin
  m_files.Clear;
  arr := TDirectory.GetFiles(GM.wwwHome, '*.*', TSearchOption.soAllDirectories);
  for i := 0 to pred(Length(arr)) do
    m_files.Add(LowerCase(arr[i]));
end;

end.
