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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    m_fname : string;
    m_data  : TStringList;
    FNeedUpload: boolean;
    function GetFileName: string;
    procedure SetFileName(const Value: string);
  public
    property FileName: string read GetFileName write SetFileName;
    property NeedUpload: boolean read FNeedUpload write FNeedUpload;

    function canEdit( fname : string ) : boolean;
  end;

var
  WebEditorForm: TWebEditorForm;

implementation

{$R *.dfm}

uses
  StrUtils;
{ TWebEditorForm }

procedure TWebEditorForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  SynEdit1.Lines.SaveToFile(m_fname);
  FNeedUpload := true;
  FreeAndNil(m_data);
end;

function TWebEditorForm.canEdit(fname: string): boolean;
var
  ext : string;
  function contains( sub, text : string ) : boolean;
  begin
    Result := pos( sub, Lowercase(text)) > 0;
  end;
begin
  ext := LowerCase(ExtractFileExt(fname));

  Result := Contains( ext, SynCssSyn1.DefaultFilter)  or
            Contains( ext, SynHTMLSyn1.DefaultFilter) or
            Contains( ext, SynJSONSyn1.DefaultFilter) or
            Contains( ext, SynDWSSyn1.DefaultFilter)  or
            Contains( ext, SynXMLSyn1.DefaultFilter);
end;

procedure TWebEditorForm.FormCreate(Sender: TObject);
begin
  m_data  := TStringList.Create;
end;

procedure TWebEditorForm.FormDestroy(Sender: TObject);
begin
  if Assigned(m_data) and (m_fname <> '' ) then
  begin
    m_data.SaveToFile(m_fname);
    FreeAndNil(m_data);
  end;
end;

function TWebEditorForm.GetFileName: string;
begin
  Result := m_fname;
end;

procedure TWebEditorForm.SetFileName(const Value: string);
var
  ext : string;
  function contains( sub, text : string ) : boolean;
  begin
    Result := pos( sub, Lowercase(text)) > 0;
  end;

begin
  m_fname := value;
  ext := LowerCase(ExtractFileExt(m_fname));

  if      contains( ext, SynCssSyn1.DefaultFilter)    then SynEdit1.Highlighter := SynCssSyn1
  else if contains( ext, SynHTMLSyn1.DefaultFilter)   then SynEdit1.Highlighter := SynHTMLSyn1
  else if contains( ext, SynJSONSyn1.DefaultFilter)   then SynEdit1.Highlighter := SynJSONSyn1
  else if contains( ext, SynDWSSyn1.DefaultFilter)    then SynEdit1.Highlighter := SynDWSSyn1
  else if contains( ext, SynXMLSyn1.DefaultFilter)    then SynEdit1.Highlighter := SynXMLSyn1;

  SynEdit1.Lines.LoadFromFile(m_fname);
  FNeedUpload := false;
end;

end.
