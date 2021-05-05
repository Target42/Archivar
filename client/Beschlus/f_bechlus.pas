unit f_bechlus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, fr_editForm, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.Menus, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, xsd_TaskData, i_personen,
  fr_textblock, i_beschluss;

type
  TBeschlusform = class(TForm)
    BaseFrame1: TBaseFrame;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox4: TGroupBox;
    LVGremium: TListView;
    Panel4: TPanel;
    Splitter4: TSplitter;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    Splitter5: TSplitter;
    LVAbwesend: TListView;
    LVNichtabgestimmt: TListView;
    TabSheet2: TTabSheet;
    GroupBox3: TGroupBox;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    EditFrame2: TEditFrame;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Panel2: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
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
    procedure LVGremiumDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure LVAbwesendDblClick(Sender: TObject);
    procedure LVGremiumDblClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure EditFrame2REDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure EditFrame2REDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LVNichtabgestimmtDblClick(Sender: TObject);
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
    m_gremium   : IPersonenListe;
    m_abwesende : IPersonenListe;
    m_nichtAbgestimmt : IPersonenListe;

    m_zustimmung  : integer;
    m_ablehnung   : integer;
    m_enthaltung  : integer;

    procedure UpdateList( LV : TListView; list : IPersonenListe );

    procedure updateInfo;
    function GetBeschluss: IBeschluss;
    procedure SetBeschluss(const Value: IBeschluss);

  public
    property Beschluss: IBeschluss read GetBeschluss write SetBeschluss;
  end;

var
  Beschlusform: TBeschlusform;

implementation

uses
  m_glob_client, f_textblock_param, xsd_TextBlock;

{$R *.dfm}

procedure TBeschlusform.BaseFrame1OKBtnClick(Sender: TObject);
begin
  m_be.Text := EditFrame2.Text;

  m_be.Abstimmung.Zustimmung  := m_zustimmung;
  m_be.Abstimmung.Abgelehnt   := m_ablehnung;
  m_be.Abstimmung.Enthalten   := m_enthaltung;
  m_be.Abstimmung.Zeitpunkt   := now;

  m_be.Abstimmung.Abwesend.Assign(        m_abwesende );
  m_be.Abstimmung.NichtAbgestimmt.Assign( m_nichtAbgestimmt );
  m_be.Abstimmung.Gremium.Assign(         m_gremium );

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

  if sum <> m_gremium.count then begin
    ShowMessage('Es wurden ' + intToStr( sum ) + ' anstelle von '+IntToStr(m_gremium.count)+' gezählt');
    exit;
  end;

end;

procedure TBeschlusform.Button1Click(Sender: TObject);
begin
  m_zustimmung  := m_gremium.count;
  m_enthaltung  := 0;
  m_ablehnung   := 0;

  updateInfo;
end;

procedure TBeschlusform.Button2Click(Sender: TObject);
begin
  m_zustimmung  := 0;
  m_enthaltung  := 0;
  m_ablehnung   := m_gremium.count;
  updateInfo;
end;

procedure TBeschlusform.EditFrame2REDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  blk : IXMLBlock;
begin
  if sender = Source then
    exit;
  if (source = TextBlockFrame1.LV)  and( Sender = EditFrame2.RE) then
  begin
    blk := TextBlockFrame1.getBlock;

    if blk.Fields.Count = 0 then
      EditFrame2.RE.Lines.Add(blk.Content)
    else
    begin
      Application.CreateForm(TTextBlockParameterForm, TextBlockParameterForm);
      TextBlockParameterForm.Xblock := blk;
      if TextBlockParameterForm.ShowModal = mrOk then
      begin
        EditFrame2.RE.Lines.Add( TextBlockParameterForm.getContext );
      end;
      TextBlockParameterForm.free;
    end;
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

  m_abwesende       := NIL;
  m_nichtAbgestimmt := NIL;
  m_gremium         := NIL;

  TextBlockFrame1.init(true);
end;

procedure TBeschlusform.FormDestroy(Sender: TObject);
begin
  if Assigned(m_gremium) then
    m_gremium.release;

  if Assigned(m_abwesende) then
    m_abwesende.release;

  if Assigned(m_nichtAbgestimmt) then
    m_nichtAbgestimmt.release;

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
    if val > m_gremium.count then
      val := m_gremium.count;
    m_zustimmung := val;
    if val = m_gremium.count then
    begin
      m_ablehnung := 0;
    end
    else
    begin
      m_ablehnung := m_gremium.count - m_zustimmung;
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
    m_enthaltung := m_gremium.count - m_zustimmung - m_ablehnung;
  end;
  updateInfo;
end;

procedure TBeschlusform.LVAbwesendDblClick(Sender: TObject);
begin
  SpeedButton1.Click;
end;

procedure TBeschlusform.LVNichtabgestimmtDblClick(Sender: TObject);
begin
  SpeedButton3.Click;
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

procedure TBeschlusform.LVGremiumDblClick(Sender: TObject);
begin
  SpeedButton2.Click;
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

  m_gremium         := m_be.Abstimmung.Gremium.clone;
  m_abwesende       := m_be.Abstimmung.Abwesend.clone;
  m_nichtAbgestimmt := m_be.Abstimmung.NichtAbgestimmt.clone;

  UpdateList( LVGremium,    m_gremium   );
  UpdateList( LVNichtabgestimmt,  m_nichtAbgestimmt );
  UpdateList( LVAbwesend,   m_abwesende );

  updateInfo;
end;

procedure TBeschlusform.SpeedButton1Click(Sender: TObject);
var
  p : IPerson;
begin
  if not Assigned(LVAbwesend.Selected) then
    exit;

  p := IPerson(LVAbwesend.Selected.Data);
  m_gremium.add(p);

  UpdateList( LVGremium, m_gremium);
  UpdateList( LVAbwesend, m_abwesende);
end;

procedure TBeschlusform.SpeedButton2Click(Sender: TObject);
var
  p : IPerson;
begin
  if not Assigned(LVGremium.Selected) then
    exit;

  p := IPerson(LVGremium.Selected.Data);
  m_abwesende.add(p);

  UpdateList( LVGremium, m_gremium);
  UpdateList( LVAbwesend, m_abwesende);
end;

procedure TBeschlusform.SpeedButton3Click(Sender: TObject);
var
  p : IPerson;
begin
  if not Assigned(LVNichtabgestimmt.Selected) then
    exit;

  p := IPerson(LVNichtabgestimmt.Selected.Data);
  m_gremium.add(p);

  UpdateList( LVGremium, m_gremium);
  UpdateList( LVNichtabgestimmt, m_nichtAbgestimmt);
end;

procedure TBeschlusform.SpeedButton4Click(Sender: TObject);
var
  p : IPerson;
begin
  if not Assigned(LVGremium.Selected) then
    exit;

  p := IPerson(LVGremium.Selected.Data);
  m_nichtAbgestimmt.add(p);

  UpdateList( LVGremium, m_gremium);
  UpdateList( LVNichtabgestimmt, m_nichtAbgestimmt);
end;

procedure TBeschlusform.updateInfo;
begin
  LabeledEdit4.Text := IntToStr(m_gremium.count);
  LabeledEdit5.Text := IntToStr(m_abwesende.count);
  LabeledEdit6.Text := IntToStr(m_nichtAbgestimmt.count);

  LabeledEdit1.Text := IntToStr(m_zustimmung);
  LabeledEdit2.Text := IntToStr(m_ablehnung );
  LabeledEdit3.Text := IntToStr(m_enthaltung);
end;

procedure TBeschlusform.UpdateList(LV: TListView; list: IPersonenListe);
var
  i : integer;
  p : IPerson;
  item : TListItem;
begin
  LV.Items.BeginUpdate;
  LV.Items.Clear;

  for i := 0 to pred(list.count) do
  begin
    p     := list.Items[i];
    item  := LV.Items.Add;
    item.Data := p;
    item.Caption := p.Name;
    item.SubItems.Add(p.Vorname);
    item.SubItems.Add(p.Abteilung);
    item.SubItems.Add(p.Rolle);
  end;
  LV.Items.EndUpdate;

end;


end.

