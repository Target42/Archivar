unit fr_mails;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.Generics.Collections,u_TMail, VirtualTrees, IdBaseComponent,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TMailOrder = (moDate, moSender);
  TMailFrame = class(TFrame)
    VST: TVirtualDrawTree;
    Image1: TImage;
    procedure VSTInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure VSTDrawNode(Sender: TBaseVirtualTree;
      const PaintInfo: TVTPaintInfo);
  private
    type
      PVSTData = ^VSTData;
      VSTData = record
        Titel : string;
        mail  : TMail;
      end;
  private
    m_mails : TList<TMail>;
    m_mailOrder : TMailOrder;
    m_up : boolean;

    procedure setMailOrdner( value : TMailOrder );
    function getMailOrder: TMailOrder;
    procedure setUp( value : boolean );

    procedure resort;
  public
    procedure prepare;
    procedure release;

    property Mails: TList<TMail> read m_mails;

    property MailOrder : TMailOrder read getMailOrder write setMailOrdner;
    property Up : boolean read m_up write setUp;

    procedure UpdateView;

    procedure beginUpdate;
    procedure clearView;
    procedure clearMails;
    procedure endUpdate;
    function newMail : TMail;

    function SelectedMail : TMail;
  end;

implementation

uses
  System.Generics.Defaults, System.UITypes;

{$R *.dfm}

{ TMailFrame }

procedure TMailFrame.beginUpdate;
begin
  VSt.BeginUpdate;
end;

procedure TMailFrame.clearMails;
var
  mail : TMail;
begin
  for mail in m_mails do
    mail.Free;
  mails.Clear;
end;

procedure TMailFrame.clearView;
begin
  vst.Clear;
  clearMails;
end;

procedure TMailFrame.endUpdate;
begin
  vst.EndUpdate;
end;

function TMailFrame.getMailOrder: TMailOrder;
begin
  Result := m_mailOrder;
end;

function TMailFrame.newMail: TMail;
begin
  Result := TMail.create;
  m_mails.Add(Result);
end;

procedure TMailFrame.prepare;
begin
  m_mails := TList<TMail>.create;
  vst.NodeDataSize := SizeOf(VSTData);
  m_up := true;
end;

procedure TMailFrame.release;
var
  mail : TMail;
begin
  VST.BeginUpdate;
  VST.Clear;
  VST.EndUpdate;

  for mail in m_mails do
    mail.Free;
  mails.Free;
end;

procedure TMailFrame.resort;
begin
  case m_mailOrder of
    moDate:   begin
      m_mails.sort(
        TComparer<TMail>.Construct(
          function(const Left, Right: TMail): Integer
          begin
            if left.TimeStamp < right.TimeStamp then
              Result := 1
            else if left.TimeStamp > right.TimeStamp then
              Result := -1
            else
              Result := 0;
          end
        )
      );
    end;
    moSender: ;
  end;
end;

function TMailFrame.SelectedMail: TMail;
var
  ptr : PVSTData;
begin
  Result := NIL;
  if not Assigned(VSt.FocusedNode) then  exit;

  ptr     := VST.FocusedNode.GetData;
  Result  := ptr^.mail;
end;

procedure TMailFrame.setMailOrdner(value: TMailOrder);
begin
  m_mailOrder := value;
  resort;
end;

procedure TMailFrame.setUp(value: boolean);
begin
  m_up := value;
  resort;
end;

procedure TMailFrame.UpdateView;
var
  mail  : TMail;
  ptr   : PVSTData;
  node  : PVirtualNode;
  root  : PVirtualNode;
  header: string;
  function getHeader : string;
  begin
    Result := '';
    case m_mailOrder of
      moDate  : Result := mail.SendDate;
      moSender: Result := mail.Absender;
    end;
  end;
begin
  root := NIL;
  VST.BeginUpdate;
  VST.Clear;
  header := '';
  for mail in m_mails do begin
    if mail.Attachments and mail.Attachment.Empty then
      Mail.Attachment.Assign(Image1.Picture);

    if not SameText(header, getHeader) then begin
      header := getHeader;
      root := VST.AddChild(NIL);
      ptr := root.GetData;
      ptr^.Titel := header;
    end;

    if Assigned(root) then begin
      node := VST.AddChild(root);
      ptr  := node.GetData;
      ptr^.mail := mail;
    end;
  end;
  VST.EndUpdate;
end;

procedure TMailFrame.VSTDrawNode(Sender: TBaseVirtualTree;
  const PaintInfo: TVTPaintInfo);
var
  ptr : PVSTData;
  s   : string;
  re  : TRect;

  procedure PaintSection;
  var
    dx : integer;
    dy : integer;
  begin
    PaintInfo.Canvas.Font.Size := 10;
    PaintInfo.Canvas.Font.Style := PaintInfo.Canvas.Font.Style + [fsBold];
    PaintInfo.Canvas.Brush.Color := clBtnFace;

    s := ptr^.Titel;
    re := PaintInfo.ContentRect;
    PaintInfo.Canvas.FillRect(re);
    //PaintInfo.Canvas.TextRect(re, s, [tfCenter] );
    dx := (re.Width - PaintInfo.Canvas.TextWidth(s)) div 2;
    dy := (re.Height- PaintInfo.Canvas.TextHeight(s)) div 2;
    PaintInfo.Canvas.TextRect( re, re.Left + dx, re.Top + dy , s );
    PaintInfo.Canvas.Font.Style := PaintInfo.Canvas.Font.Style - [fsBold];
    PaintInfo.Canvas.Brush.Color := clWindow;
  end;

  procedure paintSender;
  begin
    PaintInfo.Canvas.Font.Size := 10;
    PaintInfo.Canvas.Font.Color := clBlue;
    re := PaintInfo.ContentRect;
    re.Width := re.Width - 36;
    re.Bottom := re.Top + PaintInfo.Canvas.TextHeight('W')+2;

    s := ptr^.mail.Absender;
    UniqueString(s);
    PaintInfo.Canvas.TextRect(re, s, [tfModifyString, tfEndEllipsis]);
    PaintInfo.Canvas.Font.Color := clBlack;
  end;
  procedure paintSubject;
  begin
    PaintInfo.Canvas.Font.Size := 8;
    PaintInfo.Canvas.Font.Style := PaintInfo.Canvas.Font.Style + [fsItalic];
    re.Top := re.Bottom;
    re.Bottom := re.Bottom + PaintInfo.Canvas.TextHeight('W')+2;
    s :=  ptr^.mail.Titel;
    UniqueString(s);
    PaintInfo.Canvas.TextRect(re, s, [tfModifyString, tfEndEllipsis]);
    PaintInfo.Canvas.Font.Style := PaintInfo.Canvas.Font.Style - [fsItalic];
  end;
  procedure paintSendTime;
  var
   r : TRect;
  begin
    s := ptr^.mail.SendTime;

    r := re;
    r.Right := PaintInfo.ContentRect.Right;
    r.Left := r.Right - PaintInfo.Canvas.TextWidth(s) - 4;

    PaintInfo.Canvas.TextRect(r, s);
  end;
  procedure drawHeadLine;
  begin
    re.Left  := PaintInfo.ContentRect.Left;
    re.Right := PaintInfo.ContentRect.Right;
    re.Top   := re.Bottom + 2;
    re.Bottom := re.Top + PaintInfo.Canvas.TextHeight('W');
    s := ptr^.mail.Headline;
    PaintInfo.Canvas.TextRect(re, s);
  end;
  procedure paintAttach;
  var
    r : TRect;
  begin
    if not ptr^.mail.Attachment.Empty then begin
      r := PaintInfo.ContentRect;
      r.Left := r.Right - 18;
      r.Bottom := r.Top + 18;
      ptr^.mail.Attachment.Draw(PaintInfo.Canvas, r);
    end;

    if ptr^.mail.Kategorie <> '' then begin
      r.Left := r.Left - 16;
      r.Right := r.Right - 16;
      PaintInfo.Canvas.CopyRect( r, ptr^.mail.Katbmp.Canvas, Rect( 0, 0, 16, 16));
    end;
  end;
begin
  with sender as TVirtualDrawTree, PaintInfo do begin
    ptr := node.GetData;
    if (Selected[Node]) then
      Canvas.Font.Color := clHighlightText
    else
      Canvas.Font.Color := clWindowText;

    SetBKMode(Canvas.Handle, TRANSPARENT);

    Canvas.Brush.Style := bsClear;

    if VST.GetNodeLevel(node) = 0 then begin
      PaintSection;
    end else begin
      paintSender;
      paintSubject;
      paintAttach;
      paintSendTime;
      drawHeadLine;
    end;
  end;
end;

procedure TMailFrame.VSTInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  if VSt.GetNodeLevel(node) = 0 then
  begin
    VST.NodeHeight[Node] := 24;
  end
  else begin
    VST.NodeHeight[Node]  := 48;
    Include(InitialStates, ivsMultiline);
  end;
end;

end.