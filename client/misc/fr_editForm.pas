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
    procedure setText( text : string);
    function getText : string;

    procedure setRO( value : boolean );
    function  getRO : boolean;

    function getchanged : boolean;
    procedure setChanged( value : boolean );
  public
    property Text     : string  read getText  write setText;
    property ReadOnly : boolean read getRO    write setRO;

    property Modified : boolean read getChanged write setChanged;

    procedure saveToStream( st : TStream );
    procedure loadFromStream( st : TStream );

    procedure add( text : string );
  end;

implementation

{$R *.dfm}

{ TEditFrame }

procedure TEditFrame.add(text: string);
begin
  RE.Lines.Add(text);
end;

function TEditFrame.getchanged: boolean;
begin
  Result := RE.Modified;
end;

function TEditFrame.getRO: boolean;
begin
  Result := RE.ReadOnly;
end;

function TEditFrame.getText : string;
begin
  Result := RE.Lines.Text;
end;

procedure TEditFrame.loadFromStream(st: TStream);
begin
  RE.Lines.LoadFromStream(st);
  setChanged( false );
end;

procedure TEditFrame.saveToStream(st: TStream);
begin
  RE.Lines.SaveToStream(st);
  setChanged( false );
end;

procedure TEditFrame.setChanged(value: boolean);
begin
  RE.Modified := value;
end;

procedure TEditFrame.setRO(value: boolean);
begin
  RE.ReadOnly := value;
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
