unit f_mail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_ForceClose, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, VirtualTrees, IdMessage;

type
  TMailForm = class(TForm, IForceClose)
    GroupBox1: TGroupBox;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    VST: TVirtualStringTree;
    Panel1: TPanel;
    ComboBox1: TComboBox;
    Splitter1: TSplitter;
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
  private
  type
    PTVSTData = ^TVSTData;
    TVSTData = record
      title : string;
      from  : string;
      send  : string;
      mail  : TidMessage;
    end;
  private
    procedure UpdateTree;
  public
    procedure ForceClose( force : boolean);
  end;

var
  MailForm: TMailForm;

implementation

uses
  u_TPluginImap, m_mail, System.JSON, u_json, system.DateUtils;

{$R *.dfm}

{ TMailForm }

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

begin
  PluginImap.Data.WndHandler.registerForm(self);
  MailMod := TMailMod.create(self);

  VST.NodeDataSize := sizeof(TVSTData);
  req := TJSONObject.Create;
  JReplace( req, 'cmd', 'mailconfig');

  data := PluginImap.Data.getConfigData(req);
  if Assigned(data) then begin
    MailMod.config(data);
    data.Free;
  end;
  timer1.Enabled := true;
end;

procedure TMailForm.FormDestroy(Sender: TObject);
begin
  PluginImap.Data.WndHandler.unregisterForm(self);
  FreeAndNil(MailMod);
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
      root := VST.AddChild(NIL);
      ptr  := root.GetData;
      ptr^.title := FormatDateTime('dddddd', mail.Date);
      ptr^.mail  := NIL;
      vst.Expanded[root] := true;
    end;

    node := VST.AddChild(root);
    ptr  := node.GetData;
    ptr^.mail  := mail;

    ptr^.title := mail.Subject;
    if ptr^.mail.From.Name<>'' then
      ptr^.from := ptr^.mail.From.Name+'<'+ptr^.mail.From.Address+'>'
    else
      ptr^.from := ptr^.mail.From.Address;
    ptr^.send := FormatDateTime('hh:nn', ptr^.mail.Date);

    VST.MultiLine[node] := true;
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
  if Vst.GetNodeLevel(node) > 0 then begin
    DefaultDraw := false;

    fh := TargetCanvas.TextHeight('W');
    ptr:= node.GetData;

    re := CellRect;
    re.Bottom := re.Top + fh;

    TargetCanvas.Font.Color := clBlue;
    TargetCanvas.TextRect( re, ptr^.title);

    re.Top := re.Top + fh;
    re.Bottom := re.Bottom + fh;

    TargetCanvas.Font.Color := clBlack;
    TargetCanvas.TextRect( re, ptr^.from);

    re.Top := re.Top + fh;
    re.Bottom := re.Bottom + fh;

    TargetCanvas.Font.Color := clGreen;
    TargetCanvas.TextRect( re, ptr^.send, [tfRight]);
  end;
end;

procedure TMailForm.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  ptr : PTVSTData;
begin
  ptr := node.GetData;
  if VST.GetNodeLevel(node) = 0 then
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
begin
  if VST.GetNodeLevel(node) = 0 then
    TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsBold]
  else
    TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsBold];

end;

end.
