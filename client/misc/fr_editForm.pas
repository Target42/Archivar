unit fr_editForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.Menus, Vcl.ExtCtrls, JvExStdCtrls,
  JvCombobox, JvColorCombo;

type
  TEditFrame = class(TFrame)
    RE: TRichEdit;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    FontDialog1: TFontDialog;
    SpeedButton5: TSpeedButton;
    JvColorComboBox1: TJvColorComboBox;
    SpeedButton6: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure JvColorComboBox1Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
  private
    FPlainText: boolean;
    procedure setText( text : string);
    function getText : string;

    procedure setRO( value : boolean );
    function  getRO : boolean;

    function getchanged : boolean;
    procedure setChanged( value : boolean );

    procedure setAttribute( attr : TFontStyle );
    function getIsEmpty : boolean;

    procedure setPlainText( value : boolean );
  public
    procedure prepare;
    procedure Release;

    property Text     : string  read getText  write setText;
    property ReadOnly : boolean read getRO    write setRO;
    property IsEmpty  : boolean read getIsEmpty;
    property PlainText: boolean read FPlainText write setPlainText;

    property Modified : boolean read getChanged write setChanged;

    procedure saveToStream( st : TStream );
    procedure loadFromStream( st : TStream );

    procedure add( text : string );
    procedure insert( text : string );
  end;

implementation

uses
  NHunspell, u_ini, system.UITypes;

{$R *.dfm}

{ TEditFrame }

procedure TEditFrame.add(text: string);
var
  edit : TRichEdit;
  ss   : TStringStream;
begin
  if not FPlainText then begin
    edit := TRichEdit.Create(NIL);
    edit.Visible  := false;
    edit.Parent   := self;
    ss := TStringStream.Create(text);
    ss.Position := 0;

    edit.Lines.LoadFromStream(ss);
    edit.SelectAll;
    edit.CopyToClipboard;
    RE.PasteFromClipboard;
    ss.Free;
    edit.Free;
  end else
    RE.Lines.Add(text);
end;

function TEditFrame.getchanged: boolean;
begin
  Result := RE.Modified;
end;

function TEditFrame.getIsEmpty: boolean;
begin
  Result := Trim(Re.lines.Text) = '';
end;

function TEditFrame.getRO: boolean;
begin
  Result := RE.ReadOnly;
end;

function TEditFrame.getText : string;
var
  ss : TStringStream;
begin
  if not FPlainText then begin
    ss := TStringStream.Create('');
    try
      RE.Lines.SaveToStream(ss);
      Result := ss.DataString;
    except

    end;
    ss.Free;
  end else
    REsult := RE.Lines.Text;
end;

procedure TEditFrame.insert(text: string);
begin
  Text := text + #10#13;
  RE.Lines.Insert(0, text);
end;

procedure TEditFrame.JvColorComboBox1Click(Sender: TObject);
begin
  RE.SelAttributes.Color := JvColorComboBox1.ColorValue;
end;

procedure TEditFrame.loadFromStream(st: TStream);
begin
  RE.Lines.LoadFromStream(st);
  setChanged( false );
end;

procedure TEditFrame.prepare;
begin
  FPlainText := false;
end;

procedure TEditFrame.Release;
begin
end;

procedure TEditFrame.saveToStream(st: TStream);
begin
  RE.Lines.SaveToStream(st);
  setChanged( false );
end;

procedure TEditFrame.setAttribute(attr: TFontStyle);
begin
  if  attr in RE.SelAttributes.Style then
    RE.SelAttributes.Style := RE.SelAttributes.Style - [attr]
  else
    RE.SelAttributes.Style := RE.SelAttributes.Style + [attr];
end;

procedure TEditFrame.setChanged(value: boolean);
begin
  RE.Modified := value;
end;

procedure TEditFrame.setPlainText(value: boolean);
begin
  FPlainText      := value;
  RE.PlainText    := FPlainText;
  Panel1.Visible  := not FPlainText;
end;

procedure TEditFrame.setRO(value: boolean);
begin
  RE.ReadOnly := value;
end;

procedure TEditFrame.setText(text : string);
var
 st : TStringStream;
begin
  if not FPlainText then begin
    st := TStringStream.Create( text);
    st.Position := 0;
    Re.Lines.LoadFromStream(st);
    st.Free;
  end else
    RE.Lines.Text := text;

  RE.Modified := false;
end;

procedure TEditFrame.SpeedButton1Click(Sender: TObject);
begin
  setAttribute( fsBold );
end;

procedure TEditFrame.SpeedButton2Click(Sender: TObject);
begin
  setAttribute( fsItalic );
end;

procedure TEditFrame.SpeedButton3Click(Sender: TObject);
begin
  setAttribute( fsUnderline );
end;

procedure TEditFrame.SpeedButton5Click(Sender: TObject);
begin
  FontDialog1.Font.Name := Re.SelAttributes.Name;
  FontDialog1.Font.Style:= Re.SelAttributes.Style;
  FontDialog1.Font.Size := Re.SelAttributes.Size;
  FontDialog1.Font.Color:= Re.SelAttributes.Color;

  if FontDialog1.Execute then begin
    Re.SelAttributes.Name   := FontDialog1.Font.Name;
    Re.SelAttributes.Style  := FontDialog1.Font.Style;
    Re.SelAttributes.Size   := FontDialog1.Font.Size;
    Re.SelAttributes.Color  := FontDialog1.Font.Color;
    JvColorComboBox1.ColorValue := FontDialog1.Font.Color;
  end;
end;

procedure TEditFrame.SpeedButton6Click(Sender: TObject);
begin
  if Re.Paragraph.Numbering = nsNone then
    Re.Paragraph.Numbering := nsBullet
  else
    Re.Paragraph.Numbering := nsNone;
end;

end.
