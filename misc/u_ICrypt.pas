unit u_ICrypt;

interface

uses
  System.SysUtils, System.Classes;

type
    ICrypt = interface
    ['{C8BA7EED-42EA-4AEF-82E8-AC1DEA77718B}']
    procedure setPassword(value: string);
    function  getPassword: string;
    procedure setPrivateKeyFile(value: string);
    function  getPrivateKeyFile: string;
    procedure setPublicKeyFile(value: string);
    function  getPublicKeyFile: string;
    procedure setBinaryKeys(value: boolean);
    function  getBinaryKeys: boolean;
    function GetpPassword: pchar;
    procedure SetpPassword(const Value: pchar);


    property BinaryKeys: boolean    read getBinaryKeys      write setBinaryKeys;
    property PublicKeyFile: string  read getPublicKeyFile   write setPublicKeyFile;
    property PrivateKeyFile: string read getPrivateKeyFile  write setPrivateKeyFile;
    property Password: string       read getPassword        write setPassword;
    property pPassword: pchar       read GetpPassword       write SetpPassword;

    function generateKeys(hourglass: boolean): boolean;
    function saveKeys: boolean;
    function loadKeys: boolean;

    function Encrypt(plain: TStream; crypt: TStream): boolean; overload;
    function Encrypt(plain: string; var crypt: string): boolean; overload;

    function Decrypt(crypt: TStream; plain: TStream): boolean; overload;
    function Decrypt(crypt: string; var plain: string): boolean; overload;

    function Sign(document: TStream; signature: TStream): boolean; overload;
    function Sign(FileName: string; signature: string): boolean; overload;

    function Verify(document, signature, keyfile: TStream; binKey: boolean)
      : boolean; overload;
    function Verify(document, signature, keyfile: string; binKey: boolean)
      : boolean; overload;

    function hasKeyFiles: boolean;
    function hasKeysLoaded: boolean;

    procedure clearKeys;
  end;

implementation

end.
