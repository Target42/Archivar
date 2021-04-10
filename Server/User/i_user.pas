unit i_user;

interface

type
  IServerUser       = interface;
  IOnlineUserServer = interface;

  IServerUser       = interface
    ['{88C76639-E3DE-418E-8333-A9ECCBAE8FAE}']
    //private
    function GetID: integer;
    procedure SetID(const Value: integer);
    function GetName: string;
    procedure SetName(const Value: string);
    function GetVorname: string;
    procedure SetVorname(const Value: string);
    function GetStatus: string;
    procedure SetStatus(const Value: string);

    // public
    property ID         : integer     read GetID          write SetID;
    property Name       : string      read GetName        write SetName;
    property Vorname    : string      read GetVorname     write SetVorname;
    property Status     : string      read GetStatus      write SetStatus;

    procedure addSessionID( id : NativeInt );
    procedure removeSessionID( id : NativeInt );
    function hasSessionID( id : NativeInt ) : boolean;

    function isOffline : boolean;

    procedure release;
  end;

  IOnlineUserServer = interface
    ['{D7F4295D-3C84-4E12-9BE8-C3F84A840713}']

    // private
    function  GetCount: integer;
    function  GetItems(inx : integer ): IServerUser;
    procedure SetItems(inx : integer; const Value: IServerUser);
    //public
    property Count                : integer     read GetCount;
    property Items[inx : integer ]: IServerUser read GetItems   write SetItems;

    function addUser( id : integer; name, vorname : string; sessionID : NativeInt ) :IServerUser;
    procedure removeSessionID( id : NativeInt );

    procedure changeStatus( id : integer;  text : string );

    procedure lockServer;
    procedure unlockServer;

    procedure release;
  end;

var
  ous : IOnlineUserServer;

implementation

uses
  u_TOnlineUserServerImpl;


initialization
  ous := TOnlineUserServerImpl.create;
finalization
  ous.release;
end.
