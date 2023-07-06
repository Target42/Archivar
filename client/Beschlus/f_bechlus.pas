unit f_bechlus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, fr_editForm, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.Menus, System.Actions,
  Vcl.ActnList, xsd_TaskData,
  fr_textblock, i_beschluss, fr_teilnehmer, System.ImageList, Vcl.ImgList;

type
  TBeschlusform = class(TForm)
    BaseFrame1: TBaseFrame;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox3: TGroupBox;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    EditFrame2: TEditFrame;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ac_p1_delete: TAction;
    TextBlockFrame1: TTextBlockFrame;
    GroupBox7: TGroupBox;
    Button1: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    Button2: TBitBtn;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    MainMenu1: TMainMenu;
    Erweitert1: TMenuItem;
    extbeusteine1: TMenuItem;
    TNFrame1: TTNFrame;
    ImageList2: TImageList;
    PopupMenu1: TPopupMenu;
    extbausteine1: TMenuItem;
    procedure LVGremiumDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure EditFrame2REDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure EditFrame2REDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure extbeusteine1Click(Sender: TObject);
    procedure LabeledEdit1Exit(Sender: TObject);
    procedure LabeledEdit2Exit(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure LVGremiumCustomDraw(Sender: TCustomListView; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure LVGremiumCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
  private

    m_be        : IBeschluss;
    m_data      : IXMLList;

    m_zustimmung  : integer;
    m_ablehnung   : integer;
    m_enthaltung  : integer;
    FSimplePanel: boolean;

    procedure updateInfo;
    function GetBeschluss: IBeschluss;
    procedure SetBeschluss(const Value: IBeschluss);

    procedure changeTB( sender : TObject );
    procedure setSimplePanel( value : boolean );

  public
    property Beschluss: IBeschluss read GetBeschluss write SetBeschluss;
    property SimplePanel: boolean read FSimplePanel write setSimplePanel;
    procedure setPage( nr : integer );


  end;

var
  Beschlusform: TBeschlusform;

implementation



{$R *.dfm}

procedure TBeschlusform.BaseFrame1OKBtnClick(Sender: TObject);
begin
  m_be.Text := EditFrame2.Text;

  m_zustimmung := StrTointDef( LabeledEdit1.Text, m_zustimmung );
  m_ablehnung  := StrTointDef( LabeledEdit2.Text, m_ablehnung );
  m_enthaltung := StrTointDef( LabeledEdit3.Text, m_enthaltung );

  m_be.Abstimmung.Zustimmung  := m_zustimmung;
  m_be.Abstimmung.Abgelehnt   := m_ablehnung;
  m_be.Abstimmung.Enthalten   := m_enthaltung;
  m_be.Abstimmung.Zeitpunkt   := now;

  m_be.Abstimmung.Abwesend.Assign(        TNFrame1.Abwesende );
  m_be.Abstimmung.NichtAbgestimmt.Assign( TNFrame1.NichtAbgestimt );
  m_be.Abstimmung.Gremium.Assign(         TNFrame1.Gremium );

  m_be.Modified := true;
end;

procedure TBeschlusform.BitBtn1Click(Sender: TObject);
var
  sum : integer;
  val : integer;
begin
  sum := 0;
  if TryStrToInt(LabeledEdit1.Text, val) then
    sum := sum+ val;
  if TryStrToInt(LabeledEdit2.Text, val) then
    sum := sum+ val;
  if TryStrToInt(LabeledEdit3.Text, val) then
    sum := sum+ val;

  if sum <> TNFrame1.Gremium.count then begin
    ShowMessage('Es wurden ' + intToStr( sum ) + ' anstelle von '+IntToStr(TNFrame1.Gremium.count)+' gezählt');
    exit;
  end;

end;

procedure TBeschlusform.Button1Click(Sender: TObject);
begin
  m_zustimmung  := TNFrame1.Gremium.count;
  m_enthaltung  := 0;
  m_ablehnung   := 0;

  updateInfo;
end;

procedure TBeschlusform.Button2Click(Sender: TObject);
begin
  m_zustimmung  := 0;
  m_enthaltung  := 0;
  m_ablehnung   := TNFrame1.Gremium.count;
  updateInfo;
end;

procedure TBeschlusform.changeTB(sender: TObject);
begin
  updateInfo;
end;

procedure TBeschlusform.EditFrame2REDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  text : string;
begin
  if sender = Source then
    exit;

  if (source = TextBlockFrame1.LV)  and( Sender = EditFrame2.RE) then
  begin
    if TextBlockFrame1.getContent(text) then
      EditFrame2.Add(text);
  end;
end;

procedure TBeschlusform.EditFrame2REDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := true;
end;

procedure TBeschlusform.extbeusteine1Click(Sender: TObject);
begin
  extbeusteine1.Checked := not extbeusteine1.Checked;
  GroupBox1.Visible := extbeusteine1.Checked;
end;

procedure TBeschlusform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TBeschlusform.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage := TabSheet2;

  m_be          := NIL;
  m_zustimmung  := 0;
  m_ablehnung   := 0;
  m_enthaltung  := 0;

  m_data        := NewList;
  TNFrame1.init;

  TextBlockFrame1.init(true);
  TextBlockFrame1.TagFilter := 'beschluss';
  EditFrame2.prepare;
end;

procedure TBeschlusform.FormDestroy(Sender: TObject);
begin
  EditFrame2.Release;
  TNFrame1.release;
  TextBlockFrame1.release;
end;

function TBeschlusform.GetBeschluss: IBeschluss;
begin
  Result := m_be;
end;

procedure TBeschlusform.LabeledEdit1Exit(Sender: TObject);
var
  val : integer;
begin
  if TryStrToInt(LabeledEdit1.Text, val) then
  begin
    if val > TNFrame1.Gremium.count then
      val := TNFrame1.Gremium.count;
    m_zustimmung := val;
    if val = TNFrame1.Gremium.count then
    begin
      m_ablehnung := 0;
    end
    else
    begin
      m_ablehnung := TNFrame1.Gremium.count - m_zustimmung;
    end;
    m_enthaltung := 0;
  end;
  updateInfo;
end;

procedure TBeschlusform.LabeledEdit2Exit(Sender: TObject);
var
  val : integer;
begin
  if TryStrToInt(LabeledEdit2.Text, val) then
  begin
    m_ablehnung := val;
    m_enthaltung := TNFrame1.Gremium.count - m_zustimmung - m_ablehnung;
  end;
  updateInfo;
end;

procedure TBeschlusform.LVGremiumCustomDraw(Sender: TCustomListView;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
  //
end;

procedure TBeschlusform.LVGremiumCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if item.Index mod 2 = 0 then
    Sender.Canvas.Brush.Color := TColor(RGB( 200, 255, 200 ))
  else
    Sender.Canvas.Brush.Color := clWindow;
end;

procedure TBeschlusform.LVGremiumDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := true;
end;

procedure TBeschlusform.SetBeschluss(const Value: IBeschluss);
begin
  m_be := value;

  EditFrame2.Text := m_be.Text;

  m_zustimmung := m_be.Abstimmung.Zustimmung;
  m_ablehnung  := m_be.Abstimmung.Abgelehnt;
  m_enthaltung := m_be.Abstimmung.Enthalten;

  TNFrame1.Beschluss := m_be;
  TNFrame1.OnUserChange := self.changeTB;

  updateInfo

end;

procedure TBeschlusform.setPage(nr: integer);
begin
  case nr of
    1 : PageControl1.ActivePage := TabSheet2;
    2 : PageControl1.ActivePage := TabSheet1;
  else
    PageControl1.ActivePage := TabSheet2;
  end;
end;

procedure TBeschlusform.setSimplePanel(value: boolean);
begin
  FSimplePanel := value;

  if FSimplePanel then begin
    GroupBox3.Visible := false;
    TabSheet1.PageControl := NIL;
  end else begin
    GroupBox3.Visible := true;
    TabSheet1.PageControl := PageControl1;
  end;
end;

procedure TBeschlusform.updateInfo;
begin

  LabeledEdit4.Text := IntToStr(TNFrame1.Gremium.count);
  LabeledEdit5.Text := IntToStr(TNFrame1.Abwesende.count);
  LabeledEdit6.Text := IntToStr(TNFrame1.NichtAbgestimt.count);

  LabeledEdit1.Text := IntToStr(m_zustimmung);
  LabeledEdit2.Text := IntToStr(m_ablehnung );
  LabeledEdit3.Text := IntToStr(m_enthaltung);
end;


end.

