unit i_mail;

interface

uses
  System.JSON, System.Classes;

type
  IMail = interface
    ['{40A82E14-3701-48CA-91C2-4F3A5BF3B555}']
    procedure setKontoName( value : string );
    function  getKontoName : string;

    property KontoName : string read getKontoName write setKontoName;

    function config( data : TJSONObject ): boolean;
    function connect : boolean;
    procedure disconnect;

    procedure abort;

    function MailTyp : string;
    function update : integer;

    function getFolderList : TStringList;


  end;

implementation

end.
