unit u_broadcastMsg;

interface

uses
  System.JSON;

type
  TBroadcastMsg = class
    private
      m_msg : TJSONObject;
      FChannel: string;
      FAction: string;

      procedure setAction( value : string );
    public
      class procedure SendMsg( var msg : TBroadcastMsg );
      constructor create; overload;
      constructor create( name : string ); overload;

      property Action : string read FAction   write setAction;
      property Channel: string read FChannel  write FChannel;

      procedure add( name : string; value : string ); overload;
      procedure add( name : string; value : integer); overload;
      procedure add( name : string; value : boolean); overload;

      function send : boolean;
  end;

implementation

uses
  u_json, u_Konst, ServerContainerUnit1, Grijjy.CloudLogging;

{ TBroadcastMsg }

procedure TBroadcastMsg.add(name: string; value: integer);
begin
  JReplace( m_msg, name, value);
end;

procedure TBroadcastMsg.add(name, value: string);
begin
  JReplace(m_msg, name, value);
end;

procedure TBroadcastMsg.add(name: string; value: boolean);
begin
  JReplace( m_msg, name, value);
end;

constructor TBroadcastMsg.create(name: string);
begin
  m_msg     := TJSONObject.Create;
  FChannel  := BRD_CHANNEL;

  FAction := name;
  JAction( m_msg, FAction);
end;

function TBroadcastMsg.send: boolean;
begin
  Result := true;
  GrijjyLog.Send('broadcast', m_msg.ToJSON);

  try
    ArchivService.BroadcastMessage(FChannel, m_msg);
  except
    Result := false;
  end;
end;

class procedure TBroadcastMsg.SendMsg(var msg: TBroadcastMsg);
begin
  if Assigned(msg) then begin
    msg.send;
    msg.Free;
    msg := NIL;
  end;

end;

procedure TBroadcastMsg.setAction(value: string);
begin
  FAction := value;
  JAction( m_msg, FAction );
end;

constructor TBroadcastMsg.create;
begin
  m_msg     := TJSONObject.Create;
  FChannel  := BRD_CHANNEL;
end;

end.
