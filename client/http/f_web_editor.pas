unit f_web_editor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SynHighlighterXML, SynHighlighterDWS,
  SynHighlighterJSON, SynHighlighterHtml, SynEditHighlighter, SynHighlighterCSS,
  SynEdit, fr_base;

type
  TWebEditorForm = class(TForm)
    BaseFrame1: TBaseFrame;
    SynEdit1: TSynEdit;
    SynCssSyn1: TSynCssSyn;
    SynHTMLSyn1: TSynHTMLSyn;
    SynJSONSyn1: TSynJSONSyn;
    SynDWSSyn1: TSynDWSSyn;
    SynXMLSyn1: TSynXMLSyn;
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_fname : string;
    FNeedUpload: boolean;
    function GetFileName: string;
    procedure SetFileName(const Value: string);
  public
    property FileName: string read GetFileName write SetFileName;
    property NeedUpload: boolean read FNeedUpload write FNeedUpload;
  end;

var
  WebEditorForm: TWebEditorForm;

implementation

{$R *.dfm}

{ TWebEditorForm }

procedure TWebEditorForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  SynEdit1.Lines.SaveToFile(m_fname);
  FNeedUpload := true;
end;

function TWebEditorForm.GetFileName: string;
begin
  Result := m_fname;
end;

procedure TWebEditorForm.SetFileName(const Value: string);
begin
  m_fname := value;
  SynEdit1.Lines.LoadFromFile(m_fname);
  FNeedUpload := false;
end;

end.
