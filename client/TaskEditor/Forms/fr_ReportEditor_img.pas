unit fr_ReportEditor_img;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_ReportEditor, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ExtDlgs, i_taskEdit, Vcl.StdCtrls;

type
  TReportFrameEditorImg = class(TReportFrameEditor)
    Panel2: TPanel;
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  protected
    function changed : boolean; override;
    procedure setDataFile( value : ITaskFile ); override;
  public
    procedure save; override;

    procedure init; override;
    procedure release; override;
  end;

var
  ReportFrameEditorImg: TReportFrameEditorImg;

implementation

{$R *.dfm}

procedure TReportFrameEditorImg.BitBtn1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin

  end;
end;

function TReportFrameEditorImg.changed: boolean;
begin
  Result := m_changed;
end;

procedure TReportFrameEditorImg.init;
begin
  inherited;
end;

procedure TReportFrameEditorImg.release;
begin
  inherited;

end;

procedure TReportFrameEditorImg.save;
begin
  inherited;

  if Assigned(m_tf) then
    Image1.Picture.SaveToStream(m_tf.DataStream);
end;

procedure TReportFrameEditorImg.setDataFile(value: ITaskFile);
var
  st : TStream;
begin
  inherited;
  st := m_tf.DataStream;
  if st.Size <> 0 then
  begin
    Image1.Picture.LoadFromStream(st);
  end;
end;

end.
