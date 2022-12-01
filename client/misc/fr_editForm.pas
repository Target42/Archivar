unit fr_editForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  u_SpellChecker, Vcl.Buttons;

type
  TEditFrame = class(TFrame)
    RE: TRichEdit;
    GroupBox1: TGroupBox;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
  private
    m_check : TSpellChecker;
    procedure setText( text : string);
    function getText : string;

    procedure setRO( value : boolean );
    function  getRO : boolean;

    function getchanged : boolean;
    procedure setChanged( value : boolean );
  public
    procedure prepare;
    procedure Release;

    property Text     : string  read getText  write setText;
    property ReadOnly : boolean read getRO    write setRO;

    property Modified : boolean read getChanged write setChanged;

    procedure saveToStream( st : TStream );
    procedure loadFromStream( st : TStream );

    procedure add( text : string );
  end;

implementation

uses
  m_glob_client, NHunspell, u_ini;

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

procedure TEditFrame.prepare;
begin
  m_check := TSpellChecker.create;
  m_check.Edit := RE;

  m_check.selectSpell(IniObject.SpellDict);
  m_check.selectHypen(IniObject.SpellHyphen);

  Hunspell.UpdateAndLoadDictionaries();
end;

procedure TEditFrame.Release;
begin
  m_check.Free;
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

procedure TEditFrame.SpeedButton1Click(Sender: TObject);
begin
  m_check.show;
end;

end.
