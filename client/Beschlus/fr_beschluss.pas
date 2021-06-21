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
    procedure EditFrame1REDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure EditFrame1REDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure extbausteine1Click(Sender: TObject);
  private
    m_be : IBeschluss;
  public
    procedure init;
    procedure release;

    procedure setBeschluss( be : IBeschluss );
  end;

implementation

{$R *.dfm}

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
  TextBlockFrame1.init();
  setBeschluss(NIL);
end;

procedure TBeschlussFrame.release;
begin
  m_be := NIL;
  TextBlockFrame1.release;
end;

procedure TBeschlussFrame.setBeschluss(be: IBeschluss);
begin
  m_be := be;

  self.Enabled := Assigned(m_be);
  if Assigned(m_be ) then begin
    EditFrame1.Text := m_be.Text;

    LabeledEdit1.Text := IntToStr(m_be.Abstimmung.Zustimmung);
    LabeledEdit2.Text := IntToStr(m_be.Abstimmung.Abgelehnt);
    LabeledEdit3.Text := IntToStr(m_be.Abstimmung.Enthalten);

    LabeledEdit4.Text := IntToStr( m_be.Abstimmung.Gremium.count - m_be.Abstimmung.Abwesend.count - m_be.Abstimmung.NichtAbgestimmt.count);
    LabeledEdit5.Text := IntToStr(m_be.Abstimmung.Abwesend.count);
    LabeledEdit6.Text := IntToStr(m_be.Abstimmung.NichtAbgestimmt.count);
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
