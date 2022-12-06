unit f_connect_form2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, u_SpellChecker;

type
  TFullCorrectForm = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    RichEdit1: TRichEdit;
    GroupBox1: TPanel;
    GroupBox3: TGroupBox;
    Edit1: TEdit;
    BitBtn3: TBitBtn;
    GroupBox4: TGroupBox;
    LB: TListBox;
    GroupBox5: TGroupBox;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure LBDblClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    m_checker : TSpellChecker;
    procedure test;
    function GetText: TStrings;
    procedure SetText(const Value: TStrings);
  public
    procedure clear;

    property Checker  : TSpellChecker read m_checker write m_checker;
    property Text: TStrings read GetText write SetText;
  end;

var
  FullCorrectForm: TFullCorrectForm;

implementation

{$R *.dfm}

{ TForm3 }

procedure TFullCorrectForm.BitBtn3Click(Sender: TObject);
begin
  m_checker.replaceText(Edit1.Text);
  BitBtn6.Click;
end;

procedure TFullCorrectForm.BitBtn4Click(Sender: TObject);
begin
  clear;

  m_checker.start;
  test;
end;

procedure TFullCorrectForm.BitBtn5Click(Sender: TObject);
begin
	m_checker.startPosition;
  test;
end;

procedure TFullCorrectForm.BitBtn6Click(Sender: TObject);
begin
	m_checker.nextWord;
  test;
end;

procedure TFullCorrectForm.BitBtn7Click(Sender: TObject);
begin
	m_checker.addWord( Trim(Edit1.Text) );
end;

procedure TFullCorrectForm.clear;
begin
  Edit1.Text := '';
  LB.Items.Clear();
end;

procedure TFullCorrectForm.FormCreate(Sender: TObject);
begin
  clear;
end;

function TFullCorrectForm.GetText: TStrings;
begin
  Result := RichEdit1.Lines;
end;

procedure TFullCorrectForm.LBDblClick(Sender: TObject);
begin
  BitBtn3.Click;
end;

procedure TFullCorrectForm.SetText(const Value: TStrings);
begin
  RichEdit1.Lines.Assign(value);
end;

procedure TFullCorrectForm.test;
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
