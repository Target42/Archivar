unit u_MailHandler;

interface

uses
  u_Mailthread, System.JSON, System.Generics.Collections, i_mail;

type
  TMailHandler = class
    private
      m_worker : MailThread;
      m_list   : TThreadList<IMail>;
    public
      constructor create;
      Destructor Destroy; override;

      function addMail( data : TJSONObject ) : boolean;

      procedure start;
      procedure stop;

  end;

var
  MailHandler : TMailHandler;

implementation

uses
  u_json, System.SysUtils, m_mail_imap;

{ TMailHandler }

function TMailHandler.addMail(data: TJSONObject): boolean;
var
  mail : IMail;
  name : string;
  list : TList<IMail>;
begin
  Result := true;
  list := m_list.LockList;
  try
    name := JString( data, 'kontoname');
    for mail in list do begin
      if SameText( mail.KontoName,  name) then begin
        Result := false;
        break;
      end;
    end;

    mail := NIL;
    if Result then begin
      name := JString( data, 'typ' );
      if SameText( name, 'imap/smtp') then begin
        mail := TMailIMap.create( NIL );
        mail.config( data);
        m_list.Add(mail);
      end;
    end;
  finally
    m_list.UnlockList;
  end;
end;

constructor TMailHandler.create;
begin
  m_worker := NIL;
  m_list   := TThreadList<IMail>.create;
end;

destructor TMailHandler.Destroy;
begin
  inherited;

  m_worker.FreeOnTerminate := true;
  m_worker.Terminate;

  m_list.Free;
end;

procedure TMailHandler.start;
begin
  m_worker := MailThread.Create;
  m_worker.setKonten(m_list);
  m_worker.Start;
end;

procedure TMailHandler.stop;
begin
  m_worker.Terminate;

end;


end.
