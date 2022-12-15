unit f_task_assigment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, m_glob_client, u_stub,
  Vcl.StdCtrls, Vcl.ExtCtrls, fr_textblock, fr_editForm, Vcl.Buttons;

type
  TTaskAssignmentForm = class(TForm)
    BaseFrame1: TBaseFrame;
    GroupBox2: TGroupBox;
    TextBlockFrame1: TTextBlockFrame;
    GroupBox3: TGroupBox;
    EditFrame1: TEditFrame;
    GroupBox1: TPanel;
    GroupBox4: TGroupBox;
    LB: TListBox;
    Splitter1: TSplitter;
    GroupBox5: TGroupBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EditFrame1REDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure EditFrame1REDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    m_client : TdsTaskClient;

    FTA_ID: integer;
    FGremiumID: integer;
    procedure SetTA_ID( value : integer );
    function getGRName( id : integer ) : string;
  public
    property TA_ID: integer read FTA_ID write SetTA_ID;
    property GremiumID: integer read FGremiumID write FGremiumID;
  end;

var
  TaskAssignmentForm: TTaskAssignmentForm;

implementation

uses
  System.JSON, u_json, u_gremium;

{$R *.dfm}

{ TTaskAssignmentForm }


{ TTaskAssignmentForm }

procedure TTaskAssignmentForm.BitBtn1Click(Sender: TObject);
var
  req, res : TJSONObject;
  grid     : integer;
begin
  if ComboBox1.ItemIndex = -1 then begin
    ShowMessage('Es muss ein Gremium ausgewählt werden!');
    exit;
  end;
  if LB.Items.IndexOf(ComboBox1.Items[ComboBox1.ItemIndex])> -1  then begin
    ShowMessage('Diesem Gremium ist der Vorgang schon zugewiesen.');
    exit;
  end;
  if EditFrame1.IsEmpty then begin
    ShowMessage('Es muss eine Begründung eingeben werden!');
    exit;
  end;

  EditFrame1.insert(getGRName(FGremiumID)+':');
  grid := TGremium(ComboBox1.Items.Objects[ComboBox1.ItemIndex]).ID;
  req := TJSONObject.Create;

  JReplace( req, 'taid', FTA_ID);
  JReplace( req, 'grid', grid);
  setText(  req, 'rem', EditFrame1.Text);

  res := m_client.AssignToGremium(req);

  ShowMessage( JString(res, 'text'));
  if JBool( res, 'result') then begin
    ModalResult := mrOk;
    close;
  end;
end;

procedure TTaskAssignmentForm.BitBtn2Click(Sender: TObject);
  function getGRID( name : string ) : integer;
  var
    gr : TGremium;
  begin
    Result := -1;
    for gr in GM.Gremien do begin
      if SameText( name, gr.Name) then begin
        Result := gr.ID;
        break;
      end;
    end;
  end;
var
  req, res : TJSONObject;
  grid : integer;
begin
  if Lb.Items.Count = 1 then begin
    ShowMessage('Die Zuweisung zum letzten Gremium kann nicht aufgehoben werden!');
    exit;
  end;
  if Lb.Items.Count = -1 then begin
    ShowMessage('Es muss ein Gremium ausgewählt werden!');
    exit;
  end;
  if EditFrame1.IsEmpty then begin
    ShowMessage('Es muss eine Begründung eingeben werden!');
    exit;
  end;
  grid := getGRID(LB.Items[LB.ItemIndex]);
  if grid = -1 then begin
    ShowMessage('Das Gremium konnte nicht gefunden werden!');
    exit;
  end;

  EditFrame1.insert(getGRName(FGremiumID)+':');

  req := TJSONObject.Create;
  JReplace( req, 'taid', FTA_ID);
  JReplace( req, 'grid', grid);
  setText(  req, 'rem', EditFrame1.Text);

  res := m_client.AssignmentRemove(req);

  ShowMessage( JString(res, 'text'));
  if JBool( res, 'result') then begin
    ModalResult := mrOk;
    close;
  end;
end;

procedure TTaskAssignmentForm.EditFrame1REDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  text : string;
begin
  if sender = Source then
    exit;

  if (source = TextBlockFrame1.LV)  and( Sender = EditFrame1.RE) then
  begin
    if TextBlockFrame1.getContent(text) then begin
      EditFrame1.Add(text);
    end;
  end;
end;

procedure TTaskAssignmentForm.EditFrame1REDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = TextBlockFrame1.LV;
end;

procedure TTaskAssignmentForm.FormCreate(Sender: TObject);
var
  gr : TGremium;
begin
  m_client := TdsTaskClient.Create(GM.SQLConnection1.DBXConnection);
  TextBlockFrame1.init;
  EditFrame1.prepare;

  ComboBox1.Text := '';
  for gr in GM.Gremien do begin
    ComboBox1.Items.AddObject(gr.Name, gr);
  end;
  if ComboBox1.Items.Count > 0 then
    ComboBox1.ItemIndex := 0;
end;

procedure TTaskAssignmentForm.FormDestroy(Sender: TObject);
begin
  m_client.Free;
  TextBlockFrame1.release;
  EditFrame1.Release;
end;

function TTaskAssignmentForm.getGRName(id: integer): string;
var
  gr : TGremium;
begin
  Result := 'Vogonen';

  for gr in GM.Gremien do begin
    if gr.ID = id then begin
      Result := gr.Name;
      break;
    end;
  end;
end;

procedure TTaskAssignmentForm.SetTA_ID(value: integer);
var
  res : TJSONObject;
  arr : TJSONArray;
  row : TJSONObject;
  i   : integer;
begin
  FTA_ID := value;

  res := m_client.Assignments(FTA_ID);

  arr := JArray( res, 'items');
  if Assigned(arr) then begin
    for i := 0 to pred(arr.Count) do begin
      row := getRow(arr, i);
      LB.Items.AddObject(JString( row, 'name'), Pointer(JInt(row, 'id')));
    end;
  end;
end;

end.
