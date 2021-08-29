unit fr_beschluss;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_textblock,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, fr_editForm, Vcl.Menus, i_beschluss,
  Vcl.OleCtrls, SHDocVw, Vcl.ComCtrls, u_stub;

type
  TBeschlussFrame = class(TFrame)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    TextBlockFrame1: TTextBlockFrame;
    EditFrame1: TEditFrame;
    PopupMenu1: TPopupMenu;
    extbausteine1: TMenuItem;
    Splitter2: TSplitter;
    Groupbox4: TGroupBox;
    Memo1: TMemo;
    Panel1: TPanel;
    GroupBox5: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Button2: TBitBtn;
    Button1: TBitBtn;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    GroupBox6: TGroupBox;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    BitBtn1: TBitBtn;
    SpeedButton1: TSpeedButton;
    GroupBox3: TGroupBox;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox7: TGroupBox;
    BitBtn4: TBitBtn;
    procedure EditFrame1REDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure EditFrame1REDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure extbausteine1Click(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure LabeledEdit1Exit(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    m_org         : IBeschluss;
    m_be          : IBeschluss;
    m_changed     : boolean;
    FSAveBeschluss: TBeschlusChange;
    FhasLead: boolean;
    FHell: TdsSitzungClient;

    procedure save;
    procedure updateBeView;

    procedure setHasLead( value : boolean );


  public
    procedure init;
    procedure release;

    property hasLead: boolean read FhasLead write setHasLead;
    property SaveBeschluss: TBeschlusChange read FSAveBeschluss write FSAveBeschluss;

    property Hell: TdsSitzungClient read FHell write FHell;

    procedure setBeschluss( be : IBeschluss );
    property Beschluss : IBeschluss read m_be write setBeschluss;


  end;

implementation

uses
  f_bechlus, i_personen, system.UITypes, f_abstimmung, System.JSON, u_json, m_glob_client, u_Konst;

{$R *.dfm}

procedure TBeschlussFrame.BitBtn1Click(Sender: TObject);
begin
  Application.CreateForm(TBeschlusform, Beschlusform);
  Beschlusform.Beschluss := m_be;
  Beschlusform.setPage( 2 );
  Beschlusform.ShowModal;
  Beschlusform.Free;

  m_be.Abstimmung.clear;
  m_changed := true;

  updateBeView;
end;

procedure TBeschlussFrame.BitBtn2Click(Sender: TObject);
begin
  if not Assigned(m_org) or not Assigned(m_be) then
    exit;

  m_be.Release;
  m_be := m_org.clone;

  updateBeView;
  m_changed     := false;
end;

procedure TBeschlussFrame.BitBtn3Click(Sender: TObject);
begin
  save;
end;

procedure TBeschlussFrame.Button1Click(Sender: TObject);
begin
  if not Assigned(m_be) then
    exit;

   m_be.Abstimmung.Einstimmig(true);
   m_be.Abstimmung.Zeitpunkt := now;

  updateBeView;

  m_changed := true;
end;

procedure TBeschlussFrame.Button2Click(Sender: TObject);
begin
  if not Assigned(m_be) then
    exit;

  m_be.Abstimmung.Einstimmig(false);
  m_be.Abstimmung.Zeitpunkt := now;

  updateBeView;

  m_changed := true;
end;

procedure TBeschlussFrame.EditFrame1REDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  text : string;
begin
  if sender = Source then
    exit;

  if (source = TextBlockFrame1.LV)  and( Sender = EditFrame1.RE) then
  begin
    if TextBlockFrame1.getContent(text) then
      EditFrame1.Add(text);
  end;
end;

procedure TBeschlussFrame.EditFrame1REDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := true;
end;

procedure TBeschlussFrame.extbausteine1Click(Sender: TObject);
begin
  extbausteine1.Checked := not extbausteine1.Checked;

  GroupBox2.Visible := extbausteine1.Checked;
  Splitter1.Visible := extbausteine1.Checked;
end;

procedure TBeschlussFrame.init;
begin
  FSAveBeschluss  := NIL;
  m_org           := NIL;
  m_be            := NIL;
  FHell           := NIL;

  TextBlockFrame1.init();
  setBeschluss(NIL);
end;

procedure TBeschlussFrame.LabeledEdit1Exit(Sender: TObject);
var
  lab : TLabeledEdit;
begin
  lab := (Sender as TLabeledEdit);
  try
    StrToInt( lab.Text);
  except
    begin
      ShowMessage(Format('Bitte eine Zahl in das Feld "%s" eingeben!', [lab.EditLabel.Caption]));
      lab.SetFocus;
    end;
  end;
end;

procedure TBeschlussFrame.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  m_changed := true;
end;

procedure TBeschlussFrame.release;
begin
  if Assigned(m_be) then
    m_be.release;

  m_be  := NIL;
  m_org := NIL;

  TextBlockFrame1.release;
end;

procedure TBeschlussFrame.save;

  function getValue( lab : TLabeledEdit; def : integer ) : integer;
  begin
    Result := def;
    try
      Result := StrToInt(trim(lab.Text));
    except
    end;
  end;

begin
  if not Assigned(m_be) or not Assigned(m_org) then
    exit;

  m_org.Assign(m_be);
  m_be.Release;

  m_org.Abstimmung.Zustimmung  := getValue( LabeledEdit1, m_org.Abstimmung.Zustimmung );
  m_org.Abstimmung.Abgelehnt   := getValue( LabeledEdit2, m_org.Abstimmung.Abgelehnt);
  m_org.Abstimmung.Enthalten   := getValue( LabeledEdit3, m_org.Abstimmung.Enthalten);

  if m_org.Abstimmung.Zeitpunkt = 0.0 then
    m_org.Abstimmung.Zeitpunkt   := now;

  m_org.Text                   := EditFrame1.Text;

  if Assigned(FSAveBeschluss) then
    FSAveBeschluss(m_org);

  m_be := m_org.clone;

  m_changed           := false;
  EditFrame1.Modified := false;
end;

procedure TBeschlussFrame.setBeschluss(be: IBeschluss);
begin
  if m_changed or EditFrame1.Modified then begin
    if (MessageDlg('Der Beschluss wurde geändert.'+#13+#10+
                   'Soll er gespeichert werden?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    Save;
  end;

  if Assigned(m_be) then begin
    m_be.Release;
    m_be := NIL;
  end;

  m_org := be;

  if Assigned(m_org) then
    m_be := m_org.clone
  else
    m_be := NIL;

  self.Enabled  := Assigned(m_be);
  updateBeView;
  m_changed     := false;
end;

procedure TBeschlussFrame.setHasLead(value: boolean);
begin
  FhasLead := value;
  GroupBox5.Enabled     := FhasLead;
  LabeledEdit4.Enabled  := FhasLead;
  LabeledEdit5.Enabled  := FhasLead;
  LabeledEdit6.Enabled  := FhasLead;
  GroupBox3.Enabled     := FhasLead;
  GroupBox7.Enabled     := FhasLead;
end;

procedure TBeschlussFrame.SpeedButton1Click(Sender: TObject);
begin
  m_be.Abstimmung.Zeitpunkt := now;
  DateTimePicker1.Time      := m_be.Abstimmung.Zeitpunkt;
end;

procedure TBeschlussFrame.updateBeView;
  function getList( list : IPersonenListe ) : string;
  var
    i : integer;
    p : IPerson;
  begin
    Result := '';
    for i := 0 to pred(list.count) do begin
      p := list.Items[i];
      Result := Result + p.Vorname+' '+p.Name;

      if p.Abteilung <> '' then
        Result := Result + '('+p.Abteilung+')';
      Result := Result + ', ';
    end;

    if Result <> '' then
      SetLength( Result, Length(Result)-2);
  end;

var
  s : string;
begin
  s := '';
  if Assigned(m_be ) then begin
    EditFrame1.Text := m_be.Text;

    LabeledEdit1.Text := IntToStr( m_be.Abstimmung.Zustimmung);
    LabeledEdit2.Text := IntToStr( m_be.Abstimmung.Abgelehnt);
    LabeledEdit3.Text := IntToStr( m_be.Abstimmung.Enthalten);

    LabeledEdit4.Text := IntToStr( m_be.Abstimmung.Gremium.count);
    LabeledEdit5.Text := IntToStr( m_be.Abstimmung.Abwesend.count);
    LabeledEdit6.Text := IntToStr( m_be.Abstimmung.NichtAbgestimmt.count);

    s := '';
    if m_be.Abstimmung.NichtAbgestimmt.count > 0 then begin
      s := s + getList(m_be.Abstimmung.NichtAbgestimmt);
    end;
  end else begin
    EditFrame1.Text := '';
    LabeledEdit1.Text := '';
    LabeledEdit2.Text := '';
    LabeledEdit3.Text := '';

    LabeledEdit4.Text := '';
    LabeledEdit5.Text := '';
    LabeledEdit6.Text := '';
  end;
  Groupbox4.Visible := s <> '';
  Memo1.Lines.Text  := s;

end;

end.
