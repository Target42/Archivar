unit u_mail_decoder;

interface

uses
  IdMessage, System.Classes, System.Generics.Collections, IdAttachmentFile,
  IdText;

type
  TMailDecoder = class
    private
      m_msg : TIdMessage;
      m_html: TStringList;
      m_text: TStringList;

      m_inline: TDictionary<string, string>;
      m_attach: TStringList;
      m_keys: TStringList;


      procedure setMsg( value : TIdMessage );
      procedure clear;

      procedure parseAttamchemnts;
      procedure saveAttach(af : TIdAttachmentFile);
      procedure loadText( txt : TIdText );
      procedure CheckOnlyText;

      procedure replaceKeys( dir : string );

      function saveFiles( dir : string ) : boolean;
    public
      constructor create;
      Destructor Destroy; override;

      property Msg : TIdMessage read m_msg write setMsg;
      property Html : TStringList read m_html;
      property Attachments : TStringList read m_attach;

      function SaveToFolder( dir : string ) : boolean;
  end;

implementation

uses
  System.SysUtils, System.IOUtils;

{ TMailDecoder }

procedure TMailDecoder.CheckOnlyText;
var
  i : integer;
begin
  if m_html.Count = 0 then begin
    m_html.Add('<html><body>');
    for i := 0 to pred(m_text.Count) do
      m_html.Add(m_text[i]+'<br>');
    m_html.Add('</body></html>');
  end;
end;

procedure TMailDecoder.clear;
var
  i : integer;
begin
  m_msg     := NIL;
  m_html.clear;
  m_text.Clear;
  m_inline.Clear;

  for i := 0 to pred(m_attach.count) do
    TMemoryStream(m_attach.Objects[i]).Free;
  m_attach.clear;


  for i := 0 to pred(m_keys.count) do

    TMemoryStream(m_keys.Objects[i]).Free;
  m_keys.clear;

end;

constructor TMailDecoder.create;
begin
  m_msg     := NIL;
  m_html    := TStringList.create;
  m_text    := TStringList.create;
  m_inline  := TDictionary<string, string>.create;
  m_attach  := TStringList.create;
  m_keys    := TStringList.create;

end;

destructor TMailDecoder.Destroy;
begin
  m_msg := NIL;
  m_html.free;
  m_text.free;
  m_inline.free;
  m_attach.free;
  m_keys.free;

  inherited;
end;

procedure TMailDecoder.loadText(txt: TIdText);
begin
  if txt.ContentType = 'text/html' then
  begin
    m_html.Add(txt.Body.Text);
  end;
  if txt.ContentType = 'text/plain' then
  begin
    m_text.Add(txt.Body.Text);
  end;
end;

procedure TMailDecoder.parseAttamchemnts;
var
  i : integer;
begin
  if m_msg.MessageParts.Count = 0 then
    m_text.Text := m_msg.Body.Text
  else begin
    for i := 0 to pred(m_msg.MessageParts.Count) do
    begin
      if m_msg.MessageParts.Items[i] is TIdAttachmentFile then
      begin
        saveAttach(m_msg.MessageParts.Items[i] as TIdAttachmentFile);
      end
      else if m_msg.MessageParts.Items[i] is TIdText then
      begin
        loadText(m_msg.MessageParts.Items[i] as TIdText);
      end;
    end;
  end;
end;

procedure TMailDecoder.replaceKeys( dir : string );
var
  key , val : string;
  text      : string;
  i         : integer;
begin
  if m_html.Count > 0 then
  begin
    Text := m_html.Text;
    for i := 0 to pred(m_keys.Count) do
    begin
      key := m_keys.Strings[i];
      val := dir+'\'+m_inline.Items[key];
      key := 'cid:'+Key;

      Text := StringReplace(Text, key, val, [rfReplaceAll, rfIgnoreCase]);
    end;
    m_html.Text := Text;
  end;
end;

procedure TMailDecoder.saveAttach(af: TIdAttachmentFile);
var
  nf, key: string;
  fname : string;
  inx : integer;
  mem : TMemoryStream;
begin
  //if af.FileIsTempFile or (af.ContentDisposition = 'inline') then
  mem := TMemoryStream.create;

  if af.ContentID <> '' then
  begin
    key := af.ContentID;
    key := StringReplace(key, '<', '', []);
    key := StringReplace(key, '>', '', []);

    if not m_inline.ContainsKey(key) then
    begin
      inx := pos( '@', key );
      if inx > 0 then
      begin
        fname := key.Substring(0, inx-1);
      end
      else
        fname := key;

      nf := IntToStr(m_inline.Count) + ExtractFileExt(fname);
      m_keys.AddObject(key, mem);
      m_inline.Add(key, nf);
      af.SaveToStream(mem);
    end;
  end
  else
  begin
    af.saveToStream( mem );
    m_attach.AddObject(af.FileName, mem);
  end;
end;

function TMailDecoder.saveFiles(dir: string): boolean;
var
  i : integer;
  mem : TMemoryStream;
begin
  for i := 0 to pred(m_keys.count) do begin
    mem := m_keys.objects[i] as TMemoryStream;
    mem.Position := 0;
    mem.saveToFile( TPath.Combine( dir, m_inline[m_keys[i]]));
  end;
  for i := 0 to pred(m_attach.count) do begin
    mem := m_attach.objects[i] as TMemoryStream;
    mem.Position := 0;
    mem.saveToFile( TPath.Combine( dir, m_attach[i]));
  end;
  Result := true;
end;

function TMailDecoder.SaveToFolder(dir: string): boolean;
begin
  Result := ForceDirectories(dir);
  if Result then begin
    replaceKeys(dir);
    saveFiles( dir );
    m_html.saveToFile( TPath.Combine( dir, 'index.html'));
  end;
end;

procedure TMailDecoder.setMsg(value: TIdMessage);
begin
  clear;
  m_msg := value;

  parseAttamchemnts;
  CheckOnlyText;
end;

end.