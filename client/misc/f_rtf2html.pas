unit f_rtf2html;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvComponentBase, JvRichEditToHtml,
  Vcl.StdCtrls, Vcl.ComCtrls;

type
  TRtfToHtmlform = class(TForm)
    RE: TRichEdit;
    JvRichEditToHtml1: TJvRichEditToHtml;
  private
    procedure setRtfText( value : string );
    function getHtmlText : string;
  public
    property RtfText  : string write setRtfText;
    property HtmlText : string read getHtmlText;
  end;

var
  RtfToHtmlform: TRtfToHtmlform;

implementation

{$R *.dfm}

{ TForm1 }

function TRtfToHtmlform.getHtmlText: string;
var
  list : TStringList;
begin
  list := TStringList.Create;
  JvRichEditToHtml1.ConvertToHtmlStrings(RE, list);
  Result := list.Text;
  list.Free;
end;

procedure TRtfToHtmlform.setRtfText(value: string);
var
 st : TStringStream;
begin
  st := TStringStream.Create( value);
  st.Position := 0;
  Re.Lines.LoadFromStream(st);
  st.Free;
end;

end.
