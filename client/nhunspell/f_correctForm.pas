unit f_correctForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  u_SpellChecker;

type
  TCorrectForm = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    LB: TListBox;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure LBDblClick(Sender: TObject);
  private
    m_checker : TSpellChecker;

    procedure test;
  public
    procedure clear;

    property Checker  : TSpellChecker read m_checker write m_checker;
  end;

var
  CorrectForm: TCorrectForm;

implementation

{$R *.dfm}

procedure TCorrectForm.BitBtn2Click(Sender: TObject);
begin
  Edit1.Text := '';
  LB.Items.Clear();

  m_checker.start;
  test;
end;

procedure TCorrectForm.BitBtn3Click(Sender: TObject);
begin
	m_checker.nextWord;
  test;
end;

procedure TCorrectForm.BitBtn4Click(Sender: TObject);
begin
	m_checker.startPosition;
  test;
end;

procedure TCorrectForm.BitBtn5Click(Sender: TObject);
begin
	m_checker.addWord( Trim(Edit1.Text) );
end;

procedure TCorrectForm.clear;
begin
	Edit1.Text := '';
  LB.Items.Clear();
end;

procedure TCorrectForm.FormCreate(Sender: TObject);
begin
  m_checker := NIL;
  clear;
end;

procedure TCorrectForm.LBDblClick(Sender: TObject);
begin
  BitBtn3.Click;
end;

procedure TCorrectForm.test;
var
  Result : boolean;
begin
	repeat
    Result := m_checker.check(m_checker.Word);
    if not Result then
    begin
      if not m_checker.Word.IsEmpty then begin
        Edit1.Text := m_checker.Word;
        LB.Items.Clear;
        m_checker.suggest(m_checker.Word, LB.Items);
      end;
      break;
    end;
    Result := m_checker.nextWord;
  until not Result;
end;

end.
