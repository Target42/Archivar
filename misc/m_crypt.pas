unit m_crypt;

interface

uses
  System.SysUtils, System.Classes, uTPLb_Hash, uTPLb_Signatory,
  uTPLb_CryptographicLibrary, uTPLb_BaseNonVisualComponent, uTPLb_Codec,
  uTPLb_Asymetric;

type
  TCryptMod = class(TDataModule)
    RSAKeyGen: TCodec;
    CryptographicLibrary1: TCryptographicLibrary;
    Signatory1: TSignatory;
    Hash1: THash;
    AES: TCodec;
    VerifyCodec: TCodec;
    Signatory2: TSignatory;
    RSACrypt: TCodec;
    procedure DataModuleCreate(Sender: TObject);
  public
    type TSignInfo = record
      FileName  : string;
      FileHash  : string;
      TimeStamp : TDateTime;
      user      : string;
    end;
  private
    FPassword       : string;
    FPrivateKeyFile : string;
    FPublicKeyFile  : string;
    FBinaryKeys: boolean;

    function save( part : TKeyStoragePart ) : boolean;
    function load( part : TKeyStoragePart ) : boolean;

    function loadToStream( st : TStream; inSt : TStream ) : boolean;
    function saveToStream( st : TStream; outSt: TSTream ) : Boolean;

  public
    property BinaryKeys     : boolean read FBinaryKeys        write FBinaryKeys;

    property Password       : string  read FPassword          write FPassword;
    property PrivateKeyFile : string  read FPrivateKeyFile    write FPrivateKeyFile;
    property PublicKeyFile  : string  read FPublicKeyFile     write FPublicKeyFile;

    function generateKeys(hourglass : boolean )   : boolean;

    function saveKeys       : boolean;
    function loadKeys       : boolean;

    function Encrypt( plain : TStream;    crypt : TStream )  : boolean; overload;
    function Encrypt( plain : string; var crypt : string )   : boolean; overload;

    function Decrypt( crypt : TStream;    plain : TSTream )  : boolean; overload;
    function Decrypt( crypt : string; var plain : string )   : boolean; overload;

    function Sign( document : TStream; signature : TStream ) : boolean; overload;
    function Sign( fileName : string;  Signature : String )  : boolean; overload;

    function Verify( document, signature, keyfile : TStream; binKey : boolean ) : boolean; overload;
    function Verify( document, signature, keyfile : string ; binKey : boolean ) : boolean; overload;

  end;

var
  CryptMod: TCryptMod;

implementation

uses
  System.IOUtils, uTPLb_StreamUtils, f_main, uTPLb_Constants, System.StrUtils,
  Vcl.Forms, system.UITypes;


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TCryptMod }

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
end;

function TCryptMod.generateKeys(hourglass : boolean ): boolean;
begin
  if hourglass then
    Screen.Cursor := crHourGlass;

  Result := Signatory1.GenerateKeys;

  if hourglass then
    Screen.Cursor := crDefault
end;

function TCryptMod.load(part: TKeyStoragePart): boolean;
var
  fname : string;
  mem   : TStream;
  plain : TStream;
  st    : TStream;
begin
  Result := false;
  case part of
    partPublic  : fname := FPublicKeyFile;
    partPrivate : fname := FPrivateKeyFile;
  end;

  if not FileExists(fname) then  exit;

  mem := TMemoryStream.Create;
  try
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
      aes.DecryptStream(plain, mem);
      mem.Size := 0;
      mem.CopyFrom(plain, -1);
      mem.Position := 0;
      plain.Free;
    end;

    Signatory1.LoadKeysFromStream(mem, [part]);
    Result := true;
  except
    Result := false;
  end;
  mem.Free;

end;


function TCryptMod.loadKeys: boolean;
begin
  Result := load( partPublic) and load(partPrivate);
end;

function TCryptMod.loadToStream(st: TStream; inSt : TStream): boolean;
var
  list  : TStringList;
  s     : string;
  arr   : TBytes;
begin
  st.Position := 0;
  try
    list := TStringList.Create;
    list.LoadFromStream(st);

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
