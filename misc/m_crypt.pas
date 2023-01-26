unit m_crypt;

interface

uses
  System.SysUtils, System.Classes, uTPLb_Hash, uTPLb_Signatory,
  uTPLb_CryptographicLibrary, uTPLb_Codec,
  uTPLb_Asymetric, u_ICrypt, uTPLb_BaseNonVisualComponent;

type
  TCryptMod = class(TDataModule, ICrypt)
    RSAKeyGen: TCodec;
    CryptographicLibrary1: TCryptographicLibrary;
    Signatory1: TSignatory;
    Hash1: THash;
    AES: TCodec;
    VerifyCodec: TCodec;
    Signatory2: TSignatory;
    RSACrypt: TCodec;
    procedure DataModuleCreate(Sender: TObject);
  public type
    TSignInfo = record
      FileName: string;
      FileHash: string;
      TimeStamp: TDateTime;
      user: string;
    end;
  private
    FPassword: string;
    FPrivateKeyFile: string;
    FPublicKeyFile: string;
    FBinaryKeys: boolean;

    procedure setBinaryKeys(value: boolean);
    function  getBinaryKeys: boolean;
    procedure setPublicKeyFile(value: string);
    function  getPublicKeyFile: string;
    procedure setPrivateKeyFile(value: string);
    function  getPrivateKeyFile: string;
    procedure setPassword(value: string);
    function  getPassword: string;

    function save(part: TKeyStoragePart): boolean;
    function load(part: TKeyStoragePart): boolean;
    function loadToStream(st: TStream; inSt: TStream): boolean;
    function saveToStream(st: TStream; outSt: TStream): boolean;
    function GetpPassword: pchar;
    procedure SetpPassword(const Value: pchar);

  public

    property BinaryKeys: boolean    read getBinaryKeys      write setBinaryKeys;
    property Password: string       read getPassword        write setPassword;
    property pPassword: pchar read GetpPassword write SetpPassword;
    property PrivateKeyFile: string read getPrivateKeyFile
      write setPrivateKeyFile;

    property PublicKeyFile: string read getPublicKeyFile write setPublicKeyFile;

    function generateKeys(hourglass: boolean): boolean;
    function saveKeys: boolean;
    function loadKeys: boolean;
    function Encrypt(plain: TStream; crypt: TStream): boolean; overload;
    function Encrypt(plain: string; var crypt: string): boolean; overload;
    function Decrypt(crypt: TStream; plain: TStream): boolean; overload;
    function Decrypt(crypt: string; var plain: string): boolean; overload;
    function Sign(document: TStream; signature: TStream): boolean; overload;
    function Sign(FileName: string; signature: String): boolean; overload;
    function Verify(document, signature, keyfile: TStream; binKey: boolean)
      : boolean; overload;
    function Verify(document, signature, keyfile: string; binKey: boolean)
      : boolean; overload;
    function hasKeyFiles: boolean;
    function hasKeysLoaded: boolean;
    procedure clearKeys;
  end;

var
  CryptMod: TCryptMod;

implementation

uses
  System.IOUtils, uTPLb_StreamUtils, System.StrUtils,
  Vcl.Forms, system.UITypes, f_passwd, Vcl.Dialogs;


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TCryptMod }

procedure TCryptMod.clearKeys;
begin
  Signatory1.Burn;
end;

procedure TCryptMod.DataModuleCreate(Sender: TObject);
begin
  FBinaryKeys := false;
end;

function TCryptMod.Decrypt(crypt, plain: TSTream): boolean;
begin
  AES.Password  := FPassword;
  try
    AES.DecryptStream( plain, crypt);
    Result := true;
  except
    REsult := false;
  end;
  AES.Burn;
end;

function TCryptMod.Decrypt(crypt: string; var plain: string): boolean;
begin
  AES.Password := FPassword;
  try
    AES.DecryptString( plain, crypt,TEncoding.UTF8);
    Result := true;
  except
    Result := false;
  end;
  AES.Burn;
end;


function TCryptMod.Encrypt(plain, crypt: TStream): boolean;
begin
  AES.Password  := FPassword;
  try
    AES.EncryptStream( plain, crypt);
    Result := true;
  except
    REsult := false;
  end;
  AES.Password  := '';
end;

function TCryptMod.Encrypt(plain: string; var crypt: string): boolean;
begin
  AES.Password := FPassword;
  try
    AES.EncryptString(plain, crypt, TEncoding.UTF8);
    Result := true;
  except
    Result := false;
  end;
  AES.Password  := '';
end;

function TCryptMod.generateKeys(hourglass : boolean ): boolean;
begin
  if hourglass then
    Screen.Cursor := crHourGlass;

  Result := Signatory1.GenerateKeys;

  if hourglass then
    Screen.Cursor := crDefault
end;

function TCryptMod.getBinaryKeys: boolean;
begin
  Result := FBinaryKeys;
end;

function TCryptMod.getPassword: string;
begin
  Result := FPassword;
end;

function TCryptMod.GetpPassword: pchar;
begin
  Result := pChar(FPassword);
end;

function TCryptMod.getPrivateKeyFile: string;
begin
  Result := FPrivateKeyFile;
end;

function TCryptMod.getPublicKeyFile: string;
begin
  Result := FPublicKeyFile;
end;

function TCryptMod.hasKeyFiles: boolean;
begin
  Result := FileExists(FPublicKeyFile) and FileExists(FPrivateKeyFile);
end;

function TCryptMod.hasKeysLoaded: boolean;
begin
  Result := Signatory1.HasParts <> [];
end;

function TCryptMod.load(part: TKeyStoragePart): boolean;
var
  fname : string;
  mem   : TStream;
  plain : TStream;
  st    : TStream;
  error : boolean;
begin
  Result := false;
  case part of
    partPublic  : fname := FPublicKeyFile;
    partPrivate : fname := FPrivateKeyFile;
  end;

  if not FileExists(fname) then  exit;

  mem := TMemoryStream.Create;
  try
    error := false;
    if not FBinaryKeys then begin
      st := TFile.OpenRead(fname);
      loadToStream(st, mem);
      st.free
    end
    else
      (mem as TMemoryStream).LoadFromFile(fname);

    mem.Position := 0;

    // decryp
    if part = partPrivate then begin

      AES.Password := FPassword;

      plain := TMemoryStream.Create;
      try
        aes.DecryptStream(plain, mem);
        mem.Size := 0;
        mem.CopyFrom(plain, -1);
      except
        error := true;
      end;
      mem.Position := 0;
      plain.Free;
      AES.Password  := '';
    end;

    if not error then begin
      try
        Signatory1.LoadKeysFromStream(mem, [part]);
        Result := true;
      except
        Result := false;
      end;
    end;
  except
    Result := false;
  end;
  mem.Free;

end;


function TCryptMod.loadKeys: boolean;
begin
  Result := hasKeyFiles;
  if not Result then
    exit;

  try
    if FPassword = '' then begin
      Application.CreateForm(TPassWdform, PassWdform);
      Result := PassWdform.ShowModal = mrOk;
      if  Result then
        FPassword := PassWdform.Password;
      PassWdform.Free;
    end;

    if Result then begin
      Result := load( partPublic);
      Result := Result and load(partPrivate);
    end;
  except
    begin
      Result := false;
    end;
  end;
  if not Result then begin
    ShowMessage( 'Fehler beim Entschlüsseln');
    FPassword := '';
  end;
end;

function TCryptMod.loadToStream(st: TStream; inSt : TStream): boolean;
var
  list  : TStringList;
  s     : string;
  arr   : TBytes;
  i     : integer;
begin
  st.Position := 0;
  try
    list := TStringList.Create;
    list.LoadFromStream(st);
    // last line remove
    for i := pred(list.Count) downto 0 do begin
      if trim(list[i])= '' then
        list.Delete(i);
      if list[i][1] = '-' then
        list.Delete(i);
    end;


    s := trim(ReplaceStr(list.Text, #10, ''));
    s := trim(ReplaceStr(s,         #13, ''));
    s := trim(ReplaceStr(s,         ' ', ''));
    s := trim(ReplaceStr(s,         #9,  ''));
    list.Free;
    arr := TEncoding.UTF8.GetBytes(s);
    Base64_to_stream(arr, inSt );
    SetLength(arr, 0);
    Result := true;
  except
    Result := false;
  end;


end;

function TCryptMod.save(part: TKeyStoragePart) : boolean;
var
  fname : string;
  mem   : TStream;
  crypt : TStream;
  st    : TStream;
begin
  case part of
    partPublic  : fname := FPublicKeyFile;
    partPrivate : fname := FPrivateKeyFile;
  end;

  mem := TMemoryStream.Create;
  try
    Signatory1.StoreKeysToStream(mem, [part]);
    mem.Position := 0;

    if part = partPrivate then begin
      AES.Password := FPassword;

      crypt := TMemoryStream.Create;
      aes.EncryptStream(mem, crypt);

      mem.Size := 0;
      mem.CopyFrom(crypt, -1);
      mem.Position := 0;

      crypt.Free;
      AES.Password  := '';
    end;

    if not FBinaryKeys then begin
      st  := TFileStream.Create( fname, fmCreate + fmShareDenyNone);
      saveToStream(mem, st);
      st.Free;
    end else begin
      (mem as TMemoryStream).SaveToFile(fname);
    end;
    Result := true;
  except
    Result := false;

  end;
  mem.Free;
end;

function TCryptMod.saveKeys: boolean;
begin
  Result := save( partPublic) and save(partPrivate);
end;

function TCryptMod.saveToStream(st : TStream; outSt: TSTream ): Boolean;
var
  arr   : TBytes;
  list  : TStringList;
  s     : string;
begin
  st.Position := 0;
  list := TStringList.Create;

  try
    arr := Stream_to_Base64(st);
    s := TEncoding.UTF8.GetString(arr);
    SetLength(arr, 0);
    list.Add('-------start signature-----');
    while length(s) > 0 do begin
      list.Add(copy(s, 1, 64));
      s := copy( s, 65);
    end;
    list.Add('-------end signature-----');
    list.SaveToStream(outSt);
    Result := true;
  except
    Result := false;
  end;
  list.Free;
end;

procedure TCryptMod.setBinaryKeys(value: boolean);
begin
  FBinaryKeys := value;
end;

procedure TCryptMod.setPassword(value: string);
begin
  FPassword := value;
end;

procedure TCryptMod.SetpPassword(const Value: pchar);
begin
  if Assigned(value) then
    FPassword := String( value )
  else
    FPassword := '';
end;

procedure TCryptMod.setPrivateKeyFile(value: string);
begin
  FPrivateKeyFile := value;
end;

procedure TCryptMod.setPublicKeyFile(value: string);
begin
  FPublicKeyFile := value;
end;

function TCryptMod.Sign(fileName, Signature: String): boolean;
var
  doc     : TStream;
  sig     : TStream;
  memSig  : TStream;
begin
  Result := FileExists(fileName);
  memSig := TMemoryStream.Create;
  try
    if Result then begin
      doc := TFile.OpenRead(filename);
      try
        sign( doc, memsig );
      except
        Result := false;
      end;
      doc.Free;

      if memSig.Size > 0 then begin
        sig := TFile.OpenWrite(Signature);
        sig.CopyFrom(memSig, -1);
        sig.Free;
      end;
    end;
  except
    Result := false;
  end;
  memSig.Free;
end;

function TCryptMod.Sign(document, signature: TStream): boolean;
var
  mem : TStream;
  parts : TKeyStoragePartSet;
begin
  Result := false;
  parts := Signatory1.HasParts;
  if parts <> [ partPublic, partPrivate] then
    exit;

  mem := TMemoryStream.Create;
  try
    Result := Signatory1.Sign( document, mem);

    saveToStream(mem, signature);
  except

  end;
  mem.Free;
end;

function TCryptMod.Verify(document, signature, keyfile: string;
  binKey: boolean): boolean;
var
  doc, sig, key : TStream;
begin
  Result := FileExists(document) and FileExists(signature) and FileExists(keyfile);

  if Result then begin
    try
      doc := TFileStream.Create( document,  fmOpenRead + fmShareDenyNone );
      sig := TFileStream.Create( signature, fmOpenRead + fmShareDenyNone);
      key := TFileStream.Create( keyfile,   fmOpenRead + fmShareDenyNone);

      Result := Verify( doc, sig, key, binKey );

      doc.Free;
      sig.Free;
      key.Free;

    except
      Result := false;
    end;
  end;

end;

function TCryptMod.Verify(document, signature, keyfile: TStream;
  binKey: boolean): boolean;
var
  keyMem  : TStream;
  sig     : TMemoryStream;
begin
  keyMem := TMemoryStream.Create;
  if not binKey then begin
    loadToStream( keyfile, keyMem);
  end else
    keyMem.CopyFrom(keyfile, -1);
  keyMem.Position := 0;

  sig := TMemoryStream.Create;
  try
    Signatory2.LoadKeysFromStream(keyMem, [partPublic]);
    loadToStream( signature, sig);
    Result := Signatory2.Verify(document, sig) = vPass;
  except
    Result := false;
  end;
  keyMem.Free;
  sig.Free;
end;

end.
