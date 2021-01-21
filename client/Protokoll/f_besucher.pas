unit f_besucher;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, fr_base,
  i_chapter, Vcl.ComCtrls;

type
  TBesucherForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    DateTimePicker2: TDateTimePicker;
    LabeledEdit4: TLabeledEdit;
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_besucher : IBesucher;
    function GetBesucher: IBesucher;
    procedure SetBesucher(const Value: IBesucher);
  public
    property Besucher: IBesucher read GetBesucher write SetBesucher;
  end;

var
  BesucherForm: TBesucherForm;

implementation

{$R *.dfm}

{ TBesucherForm }

procedure TBesucherForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  m_besucher.Name     := LabeledEdit1.Text;
  m_besucher.Vorname  := LabeledEdit2.Text;
  m_besucher.Grund    := LabeledEdit3.Text;
  m_besucher.Abteilung:= LabeledEdit4.Text;

  m_besucher.Von      := DateTimePicker1.DateTime;
  m_besucher.bis      := DateTimePicker2.DateTime;

end;

function TBesucherForm.GetBesucher: IBesucher;
begin
  Result := m_besucher;
end;

procedure TBesucherForm.SetBesucher(const Value: IBesucher);
begin
  m_besucher := value;

  LabeledEdit1.Text := m_besucher.Name;
  LabeledEdit2.Text := m_besucher.Vorname;
  LabeledEdit3.Text := m_besucher.Grund;
  LabeledEdit4.Text := m_besucher.Abteilung;

  DateTimePicker1.DateTime := m_besucher.Von;
  DateTimePicker2.DateTime := m_besucher.bis;
end;

end.
