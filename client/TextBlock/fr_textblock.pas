unit fr_textblock;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, xsd_TextBlock;

type
  TTextBlockFrame = class(TFrame)
    Panel1: TPanel;
    LV: TListView;
    LabeledEdit1: TLabeledEdit;
    DSProviderConnection1: TDSProviderConnection;
    TBTab: TClientDataSet;
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure LVDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
  private
    m_noTags : boolean;
    procedure FilterContent;
    function GetLogFilter: string;
    procedure SetLogFilter(const Value: string);
  public
    property TagFilter: string read GetLogFilter write SetLogFilter;
    procedure init( noTags : boolean = true);

    function getBlock : IXMLblock;

    function getContent( var text : string ) : boolean;

    procedure release;


  end;

implementation

uses
  m_glob_client, Xml.XMLIntf, Xml.XMLDoc, f_textblock_param;

{$R *.dfm}

{ TFrame1 }

procedure TTextBlockFrame.FilterContent;
var
  list    : TStringList;
  filter  : TStringList;
  found   : boolean;
  item    : TListItem;
  i       : integer;
begin
  list := TStringList.Create;
  list.StrictDelimiter := true;
  list.Delimiter := ' ';


  filter := TStringList.Create;
  filter.StrictDelimiter := true;
  filter.Delimiter := ' ';
  filter.DelimitedText := trim(LabeledEdit1.Text);


  LV.Items.BeginUpdate;
  LV.Items.Clear;
  TBTab.First;
  while not TBTab.Eof do
  begin
    list.DelimitedText := trim(TBTab.FieldByName('TB_TAGS').AsString);
    found := filter.Count = 0;
    if not found then
    begin
      for i := 0 to pred(filter.Count) do
      begin
        found := list.IndexOf(filter.Strings[i]) <> -1;
        if found then
          break;
      end;
    end;

    if found then
    begin
      item := LV.Items.Add;
      item.Caption :=       TBTab.FieldByName('TB_NAME').AsString;
      item.SubItems.Add(    TBTab.FieldByName('TB_TAGS').AsString);
      item.Data := Pointer( TBTab.FieldByName('TB_ID').AsInteger);
    end;

    TBTab.Next;
  end;
  filter.Free;

  LV.Items.EndUpdate;
  list.Free;
end;

function TTextBlockFrame.getBlock: IXMLblock;
var
  st : TStream;
  xml : IXMLDocument;
  tbid : integer;
begin
  Result := NewBlock;

  if TBTab.IsEmpty or not Assigned(LV.Selected) then
    exit;

  tbid := integer(LV.Selected.Data);
  if TBTab.Locate('TB_ID', VarArrayOf([tbid]), []) then begin
    st := TBtab.CreateBlobStream(TBtab.FieldByName('TB_TEXT'), bmRead);
    xml := NewXMLDocument;
    xml.LoadFromStream(st);
    Result := xml.GetDocBinding('Block', TXMLBlock, TargetNamespace) as IXMLBlock;
    st.Free;
  end;
end;

function TTextBlockFrame.getContent(var text: string): boolean;
var
  blk : IXMLBlock;
begin
  Result := false;
  blk := self.getBlock;
  if not Assigned(blk) then exit;


  if blk.Fields.Count = 0 then begin
    text:= blk.Content;
    Result := true;
  end
  else
  begin
    Application.CreateForm(TTextBlockParameterForm, TextBlockParameterForm);
    TextBlockParameterForm.Xblock := blk;
    if TextBlockParameterForm.ShowModal = mrOk then
    begin
      text := TextBlockParameterForm.getContext;
      Result := true;
    end;
    TextBlockParameterForm.free;
  end;
end;

function TTextBlockFrame.GetLogFilter: string;
begin
  Result := Trim(LabeledEdit1.Text);
end;

procedure TTextBlockFrame.init( noTags : boolean);
var
  col : TListColumn;
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_noTags  := noTags;

  if not noTags then
  begin
    col := LV.Columns.Add;
    col.Caption := 'Tags';
  end;

  TBTab.Open;
  FilterContent;
end;

procedure TTextBlockFrame.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    FilterContent;
end;

procedure TTextBlockFrame.LVDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := false;
end;

procedure TTextBlockFrame.release;
begin
  TBTab.Close;
end;

procedure TTextBlockFrame.SetLogFilter(const Value: string);
begin
  LabeledEdit1.Text := Value;
  FilterContent;
end;

end.
