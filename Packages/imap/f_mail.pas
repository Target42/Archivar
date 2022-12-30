unit f_mail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_ForceClose, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, VirtualTrees, IdMessage, IdEMailAddress,
  Vcl.OleCtrls, SHDocVw, Web.HTTPApp, Web.HTTPProd,
  System.Generics.Collections;

type
  TMailForm = class(TForm, IForceClose)
    GroupBox1: TGroupBox;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    VST: TVirtualStringTree;
    Panel1: TPanel;
    ComboBox1: TComboBox;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    WebBrowser1: TWebBrowser;
    PageProducer1: TPageProducer;
    LB: TListBox;
    Splitter2: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure VSTPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure VSTDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; const Text: string;
      const CellRect: TRect; var DefaultDraw: Boolean);
    procedure VSTDblClick(Sender: TObject);
    procedure PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
  private
  type
    PTVSTData = ^TVSTData;
    TVSTData = record
      level : integer;
      title : string;
      from  : string;
      send  : string;
      mail  : TidMessage;
    end;
  private
    m_wwwRoot : string;
    m_wwwPort : integer;

    m_msg: TidMessage;
    m_html: TStringList;

    procedure UpdateTree;
    function prettyName( addr : TIdEMailAddressItem ) : string;
    procedure UpdateMail( mail : TIdMessage );

    procedure clearFiles;
  public
    procedure ForceClose( force : boolean);
  end;

var
  MailForm: TMailForm;

implementation

uses
  u_TPluginImap, m_mail, System.JSON, u_json, system.DateUtils, system.IOUtils,
  System.Types, System.StrUtils, IdText, IdAttachmentFile, u_mail_decoder;

{$R *.dfm}

{ TMailForm }

procedure TMailForm.clearFiles;
var
  arr : TStringDynArray;
  i   : integer;
begin
  arr := TDirectory.GetFiles(m_wwwRoot);
  for i := low(arr) to high(arr) do
      DeleteFile(arr[i]);
end;

procedure TMailForm.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.ItemIndex > -1 then
    updateTree;
end;

procedure TMailForm.ForceClose(force: boolean);
begin
  if force then begin
  end;
  Self.Close;

end;

procedure TMailForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  MailForm := NIL;
end;

procedure TMailForm.FormCreate(Sender: TObject);
var
  data : TJSONObject;
  req  : TJSONObject;

  procedure getMailCfg;
  begin
    req := TJSONObject.Create;
    JReplace( req, 'cmd', 'mailconfig');
    data := PluginImap.Data.getConfigData(req);
    if Assigned(data) then begin
      MailMod.config(data);
      data.Free;
    end;
  end;
  procedure getHttpCfg;
  begin
    req := TJSONObject.Create;
    JReplace( req, 'cmd', 'htmlconfig');
    data := PluginImap.Data.getConfigData(req);
    if Assigned(data) then begin
      m_wwwRoot := JString( data, 'wwwroot');
      m_wwwPort := JInt(    data, 'port');
      data.Free;
    end;
    if m_wwwRoot <> '' then begin
      m_wwwRoot := TPath.Combine( m_wwwRoot, 'mail');
      ForceDirectories(m_wwwRoot);
    end;
  end;
begin
  PluginImap.Data.WndHandler.registerForm(self);
  MailMod := TMailMod.create(self);
  m_html  := TStringList.Create;

  VST.NodeDataSize := sizeof(TVSTData);

  getMailCfg;
  getHttpCfg;

  timer1.Enabled := true;
end;

procedure TMailForm.FormDestroy(Sender: TObject);
begin
  clearFiles;
  PluginImap.Data.WndHandler.unregisterForm(self);
  FreeAndNil(MailMod);
  m_html.free;

end;

procedure TMailForm.PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);

  function addrList( list : TIdEmailAddressList ): string;
  var
    i : integer;
  begin
    Result := '';
    for i := 0 to pred(list.Count) do
      Result := Result + prettyName(list.Items[i])+';';
    if Result <> '' then
      SetLength( Result, length(Result)-1);
  end;
  function repHTML( text : string ) : string;
  begin
    Result := System.StrUtils.ReplaceText(text, '<', '&lt;' );
    Result := System.StrUtils.ReplaceText(Result, '<', '&gt;' );
  end;
var
  s : string;
begin
       if SameText(TagString, 'date')     then  ReplaceText := FormatDateTime('ddd, dd.mmmm.yyyy hh:nn', m_msg.Date )
  else if SameText(TagString, 'sender')   then  ReplaceText := repHTML(prettyName(m_msg.From))
  else if SameText(TagString, 'subject')  then  ReplaceText := m_msg.Subject
  else if SameText(TagString, 'an')       then  ReplaceText := repHTML(addrList(m_msg.Recipients))
  else if SameText(TagString, 'cc')       then  begin
    s := repHTML(addrList(m_msg.CCList));
    if s <> '' then
      ReplaceText := 'cc:'+s;
  end
  else if SameText(TagString, 'text')     then  ReplaceText := m_html.Text;
end;

function TMailForm.prettyName(addr: TIdEMailAddressItem): string;
begin
  Result := addr.Address;
  if addr.Name <> '' then
    Result := addr.Name+'<'+Result+'>';
end;

procedure TMailForm.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;

  if MailMod.connect then begin
    MailMod.updateMailFolder;
    ComboBox1.Items.Assign(MailMod.MailFolder);
    ComboBox1.ItemIndex := ComboBox1.Items.IndexOf('INBOX');
    UpdateTree;
  end;
end;
procedure TMailForm.UpdateMail(mail: TIdMessage);
var
  decoder : TMailDecoder;
  fname   : string;
  list    : TStringList;
begin
  m_msg := mail;

  list  := TStringList.Create;
  WebBrowser1.Navigate('about:blank');

  decoder := TMailDecoder.create;
  decoder.Msg := mail;
  decoder.SaveToFolder(m_wwwRoot);

  m_html.Text := decoder.Html.Text;

  fname := TPath.Combine(m_wwwRoot, 'index.html');
  list.Text := PageProducer1.Content;
  list.SaveToFile(fname);
  WebBrowser1.Navigate(fname);
  list.Free;

end;


procedure TMailForm.UpdateTree;
var
  mail : TIdMessage;
  root : PVirtualNode;
  node : PVirtualNode;
  ptr  : PTVSTData;
  da   : TDate;
begin
  if ComboBox1.ItemIndex = -1  then exit;

  da := 0;
  root := nil;
  MailMod.SelectInbox(ComboBox1.Items[ComboBox1.ItemIndex]);

  for mail in MailMod.Mails do begin
    if not SameDate(da, mail.Date) then begin
      da := mail.Date;
      if Assigned(root) then
        VST.Expanded[root] := true;

      root := VST.AddChild(NIL);
      ptr  := root.GetData;
      ptr^.Level := 0;
      ptr^.title := FormatDateTime('dddddd', mail.Date);
      ptr^.mail  := NIL;
    end;

    node := VST.AddChild(root);
    ptr  := node.GetData;
    ptr^.mail  := mail;

    ptr^.Level := 1;
    ptr^.title := mail.Subject;
    ptr^.from := prettyName(ptr^.mail.From);
    ptr^.send := FormatDateTime('hh:nn', ptr^.mail.Date);

    VST.MultiLine[node] := true;
  end;
  if Assigned(root) then
    vst.Expanded[root] := true;
end;

procedure TMailForm.VSTDblClick(Sender: TObject);
var
  ptr : PTVSTData;
begin
  if not Assigned(VST.FocusedNode) then exit;

  ptr := VST.FocusedNode.GetData;

  if Assigned(ptr^.mail) then begin
    UpdateMail(ptr^.mail);
  end;
end;

procedure TMailForm.VSTDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; const Text: string;
  const CellRect: TRect; var DefaultDraw: Boolean);
var
  fh : integer;
  re : TRect;
  ptr: PTVSTData;
begin
  ptr:= node.GetData;

  if ptr^.level > 0 then begin
    DefaultDraw := false;

    fh := TargetCanvas.TextHeight('W');

    re := CellRect;
    re.Bottom := re.Top + fh;

    if not (mfSeen in ptr^.mail.Flags) then  TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsBold]
    else                                     TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsBold];
    TargetCanvas.Font.Color := clBlue;
    TargetCanvas.TextRect( re, ptr^.title);
    TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsBold];

    re.Top := re.Top + fh;
    re.Bottom := re.Bottom + fh;

    TargetCanvas.Font.Color := clBlack;
    TargetCanvas.TextRect( re, ptr^.from);

    re.Top := re.Top + fh;
    re.Bottom := re.Bottom + fh;

    TargetCanvas.Font.Color := clBlack;
    TargetCanvas.TextRect( re, ptr^.send, [tfRight]);
  end;
end;

procedure TMailForm.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  ptr : PTVSTData;
begin
  ptr := node.GetData;
  if ptr^.level = 0 then
    CellText := ptr^.title
  else
    CellText := 'W'#10#13'W'#10#13'W';
end;

procedure TMailForm.VSTInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  if VSt.GetNodeLevel(node) = 0 then
  begin
    VST.NodeHeight[Node] := VST.DefaultNodeHeight;
  end
  else
  begin
    VST.NodeHeight[Node] := VST.DefaultNodeHeight * 3;
    Include(InitialStates, ivsMultiline);
  end;
end;

procedure TMailForm.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  ptr : PTVSTData;
begin
  ptr := node.GetData;

  if ptr^.level = 0 then
    TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsBold]
  else
    TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsBold];

end;

end.
