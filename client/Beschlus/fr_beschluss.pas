unit fr_beschluss;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_textblock,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, fr_editForm, Vcl.Menus, i_beschluss;

type
  TBeschlussFrame = class(TFrame)
    GroupBox3: TGroupBox;
    Button1: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    Button2: TBitBtn;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    TextBlockFrame1: TTextBlockFrame;
    EditFrame1: TEditFrame;
    PopupMenu1: TPopupMenu;
    extbausteine1: TMenuItem;
    BitBtn1: TBitBtn;
    procedure EditFrame1REDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure EditFrame1REDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure extbausteine1Click(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure LabeledEdit1Exit(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    m_be : IBeschluss;
    m_changed : boolean;
    FSAveBeschluss: TBeschlusChange;

    procedure save;
    procedure updateBeView;
  public
    procedure init;
    procedure release;

    property SaveBeschluss: TBeschlusChange read FSAveBeschluss write FSAveBeschluss;

    procedure setBeschluss( be : IBeschluss );
  end;

implementation

uses
  f_bechlus;

{$R *.dfm}

procedure TBeschlussFrame.BitBtn1Click(Sender: TObject);
begin
  Application.CreateForm(TBeschlusform, Beschlusform);
  Beschlusform.Beschluss := m_be;
  Beschlusform.setPage( 2 );
  Beschlusform.ShowModal;
  Beschlusform.Free;
  updateBeView;
end;

procedure TBeschlussFrame.Button1Click(Sender: TObject);
begin
  m_be.Abstimmung.Zustimmung  := m_be.Abstimmung.Gremium.count;
  m_be.Abstimmung.Abgelehnt   := 0;
  m_be.Abstimmung.Enthalten   := 0;

  updateBeView;

  m_changed := true;
end;

procedure TBeschlussFrame.Button2Click(Sender: TObject);
begin
  m_be.Abstimmung.Zustimmung  := 0;
  m_be.Abstimmung.Abgelehnt   := m_be.Abstimmung.Gremium.count;
  m_be.Abstimmung.Enthalten   := 0;

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
  GroupBox2.Visible := not GroupBox2.Visible;
  extbausteine1.Checked := GroupBox2.Visible;
end;

procedure TBeschlussFrame.init;
begin
  FSAveBeschluss := NIL;

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
  m_be := NIL;
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
  if not Assigned(m_be) then
    exit;

  m_be.Abstimmung.Zustimmung := getValue( LabeledEdit1, m_be.Abstimmung.Zustimmung );
  m_be.Abstimmung.Abgelehnt  := getValue( LabeledEdit2, m_be.Abstimmung.Abgelehnt);
  m_be.Abstimmung.Enthalten  := getValue( LabeledEdit3, m_be.Abstimmung.Enthalten);

  m_be.Text := EditFrame1.Text;

  if Assigned(FSAveBeschluss) then
    FSAveBeschluss(m_be);
end;

procedure TBeschlussFrame.setBeschluss(be: IBeschluss);
begin
  if m_changed or EditFrame1.Modified then
    Save;

  m_be := be;

  self.Enabled := Assigned(m_be);
  updateBeView;
  m_changed := false;
end;

procedure TBeschlussFrame.updateBeView;
begin
  if Assigned(m_be ) then begin
    EditFrame1.Text := m_be.Text;

    LabeledEdit1.Text := IntToStr( m_be.Abstimmung.Zustimmung);
    LabeledEdit2.Text := IntToStr( m_be.Abstimmung.Abgelehnt);
    LabeledEdit3.Text := IntToStr( m_be.Abstimmung.Enthalten);

    LabeledEdit4.Text := IntToStr( m_be.Abstimmung.Gremium.count);
    LabeledEdit5.Text := IntToStr( m_be.Abstimmung.Abwesend.count);
    LabeledEdit6.Text := IntToStr( m_be.Abstimmung.NichtAbgestimmt.count);
  end else begin
    EditFrame1.Text := '';
    LabeledEdit1.Text := '';
    LabeledEdit2.Text := '';
    LabeledEdit3.Text := '';

    LabeledEdit4.Text := '';
    LabeledEdit5.Text := '';
    LabeledEdit6.Text := '';
  end;

end;

end.
