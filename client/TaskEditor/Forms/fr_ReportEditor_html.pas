unit fr_ReportEditor_html;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_ReportEditor,
  Vcl.ExtCtrls, SynEditHighlighter, SynHighlighterHtml, SynEdit, Vcl.Buttons,
  i_taskEdit, Vcl.Menus, SynHighlighterCSS, SynCompletionProposal;

type
  TReportFrameEditorHtml = class(TReportFrameEditor)
    SynEdit1: TSynEdit;
    SynHTMLSyn1: TSynHTMLSyn;
    SynCssSyn1: TSynCssSyn;
    SynCompletionProposal1: TSynCompletionProposal;
    procedure SynEdit1KeyPress(Sender: TObject; var Key: Char);
  protected
    function changed : boolean; override;
    procedure setDataFile( value : ITaskFile ); override;
  public
    procedure save; override;

    procedure insertFieldName( name : string ); override;
    procedure setPopup( pop : TPopupMenu ); override;

  end;

var
  ReportFrameEditorHtml: TReportFrameEditorHtml;

implementation

{$R *.dfm}

{ TReportFrameEditorHtml }

function TReportFrameEditorHtml.changed: boolean;
begin
  Result := m_changed;
end;

procedure TReportFrameEditorHtml.insertFieldName(name: string);
begin
  inherited;
  SynEdit1.SelText := '<#field '+name+'>';
end;

procedure TReportFrameEditorHtml.save;
begin
  m_tf.Text := SynEdit1.Lines.Text;

  inherited;
end;

procedure TReportFrameEditorHtml.setDataFile(value: ITaskFile);
var
  ex : string;
begin
  inherited;
  SynEdit1.text := m_tf.Text;
  m_changed := false;

  ex := LowerCase(ExtractFileExt(m_tf.Name));
  if (ex = '.html') or (ex = '.htm') then
    SynEdit1.Highlighter := SynHTMLSyn1
  else if ex = '.css' then
    SynEdit1.Highlighter := SynCssSyn1;
end;

procedure TReportFrameEditorHtml.setPopup(pop: TPopupMenu);
begin
  inherited;
  SynEdit1.PopupMenu := pop;
end;

procedure TReportFrameEditorHtml.SynEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  m_changed := true;
end;

end.
