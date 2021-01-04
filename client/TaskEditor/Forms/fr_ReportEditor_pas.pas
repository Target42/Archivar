unit fr_ReportEditor_pas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_ReportEditor, Vcl.Buttons,
   m_dws, Vcl.ExtCtrls, Vcl.StdCtrls, SynEditHighlighter, SynHighlighterDWS,
  SynEdit, i_taskEdit, SynHighlighterCSS, SynEditOptionsDialog, Vcl.Menus;

type
  TReportFrameEditorPas = class(TReportFrameEditor)
    SynEdit1: TSynEdit;
    Panel2: TPanel;
    Memo1: TMemo;
    Panel3: TPanel;
    Splitter1: TSplitter;
    btnCompile: TBitBtn;
    SynEditOptionsDialog1: TSynEditOptionsDialog;
    SynDWSSyn1: TSynDWSSyn;
    procedure btnCompileClick(Sender: TObject);
    procedure SynEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    m_dws : TDwsMod;
  protected
    function changed : boolean; override;
    procedure setDataFile( value : ITaskFile ); override;
  public
    procedure save; override;

    procedure setPopup( pop : TPopupMenu ); override;
    procedure insertFieldName( name : string ); override;

    procedure init; override;
    procedure release; override;
  end;

var
  ReportFrameEditorPas: TReportFrameEditorPas;

implementation

{$R *.dfm}

{ TReportFrameEditorPas }

procedure TReportFrameEditorPas.btnCompileClick(Sender: TObject);
begin
  inherited;
  Memo1.Lines.Clear;
  Memo1.Lines.Add('Compile...');

  m_dws.Script := SynEdit1.Lines.Text;
  m_dws.compile;
  if not (m_dws.MsgText = '') then
    Memo1.Lines.Add(m_dws.MsgText);
  Memo1.Lines.Add('Fertig');
end;

function TReportFrameEditorPas.changed: boolean;
begin
  Result := m_changed;
end;

procedure TReportFrameEditorPas.init;
begin
  inherited;
  m_dws       := TDwsMod.Create(NIL);
end;

procedure TReportFrameEditorPas.insertFieldName(name: string);
begin
  inherited;
  SynEdit1.SelText := ''''+name+'''';
end;

procedure TReportFrameEditorPas.release;
begin
  inherited;
  if Assigned(m_dws) then
    m_dws.Free;
  m_dws := NIL;
end;

procedure TReportFrameEditorPas.save;
begin
  m_tf.text := SynEdit1.Lines.Text;

  inherited;
end;

procedure TReportFrameEditorPas.setDataFile(value: ITaskFile);
begin
  inherited;
  SynEdit1.Lines.text := m_tf.Text;
  m_changed := false;
end;

procedure TReportFrameEditorPas.setPopup(pop: TPopupMenu);
begin
  inherited;
  SynEdit1.PopupMenu := pop;
end;

procedure TReportFrameEditorPas.SynEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  m_changed := true;
end;

end.
