unit fr_editForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Xml.XMLIntf;

type
  TEditFrame = class(TFrame)
    RE: TRichEdit;
  private
  public
    procedure setText( text : string);
    function getText : string;
    function changed : boolean;
  end;

implementation

{$R *.dfm}

{ TEditFrame }

function TEditFrame.changed: boolean;
begin
  Result := RE.Modified;
end;

function TEditFrame.getText : string;
begin
  Result := RE.Lines.Text;
end;

procedure TEditFrame.setText(text : string);
var
 st : TStringStream;
begin
  st := TStringStream.Create( text);
  st.Position := 0;
  Re.Lines.LoadFromStream(st);
  st.Free;

  RE.Modified := false;
end;

end.
