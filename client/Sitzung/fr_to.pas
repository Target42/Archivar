unit fr_to;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DBXCommon,
  VirtualTrees, System.JSON;

type
  TTOFrame = class(TFrame)
    VST: TVirtualStringTree;
    procedure VSTDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; const Text: string;
      const CellRect: TRect; var DefaultDraw: Boolean);
    procedure VSTFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTGetCellText(Sender: TCustomVirtualStringTree;
      var E: TVSTGetCellTextEventArgs);
  private
    type
      PTData = ^TData;
      TData  = record
        Title : string;
        date  : string;
        style : TFontStyles;
        color : TColor;
      end;
  private
    m_prid : integer;
    m_dbx  : TDBXConnection;

    function GetPR_ID: integer;
    procedure SetPR_ID(const Value: integer);

    procedure ShowContent( data : TJSONObject );
  public
    { Public-Deklarationen }
    procedure init;

    procedure release;

    property PR_ID: integer read GetPR_ID write SetPR_ID;
    property Connection : TDBXConnection write m_dbx;

    procedure updateContent;
  end;

implementation

uses
  u_stub, u_json, system.DateUtils;

{$R *.dfm}

{ TTOFrame }

function TTOFrame.GetPR_ID: integer;
begin
  Result := m_prid;
end;

procedure TTOFrame.init;
begin
  VST.NodeDataSize := SizeOf(Tdata);
end;

procedure TTOFrame.release;
begin
  VST.Clear;
end;

procedure TTOFrame.SetPR_ID(const Value: integer);
begin
  m_prid := Value;
end;

procedure TTOFrame.ShowContent(data: TJSONObject);
var
  line : string;
  late : TStringList;

  function add( root : PVirtualNode; text : string ) : PVirtualNode;
  var
    data: PTData;
  begin
    Result := VST.AddChild(root);
    data := PTdata(Result.GetData);

    data^.Title := text;
    data^.color := clBlack;
  end;

  procedure AddChilds( root: PVirtualNode; arr : TJSONArray; pre : string);
  var
    nr  : integer;
    i   : integer;
    p   : string;
    row : TJSONObject;
    sub : PVirtualNode;
    da  : TDateTime;
  begin
    if not Assigned(arr) then
      exit;

    for i := 0 to pred(arr.Count) do
    begin
      row := getRow( arr, i);
      nr  := JInt(row, 'nr');
      p   := format('%s.%d', [pre, nr]);

      if nr > 0 then
      begin
        sub := add(root, Format('%s %s', [p, JString(row, 'title')]));
        PTData(sub.GetData)^.date := JString( row, 'created', 'Hallo');

        if TryStrToDateTime(PTData(sub.GetData)^.date, da ) then
        begin
          if DaysBetween( now, da) <= 1 then
          begin
            PTData(sub.GetData)^.color := clRed;
            late.Add(Format('%s %s', [p, JString(row, 'title')]) );
          end
          else
            PTData(sub.GetData)^.color := clGreen;
        end;
        AddChilds(sub, JArray(row, 'childs'), '  '+p);
      end;
    end;
  end;

var
  titles  : TJSONArray;
  row     : TJSONObject;
  i       : integer;
  obj     : TJSONObject;
  nr      : integer;
  ptr     : PVirtualNode;
  sub     : PVirtualNode;
begin
  VST.Clear;

  late := TStringList.Create;;

  ptr := add( NIL, JString( data, 'name') );
  PTData(ptr.GetData)^.Style := [fsBold];

  titles := JArray( data, 'titles');
  if not Assigned(titles) then
    exit;

  for i := 0 to pred(titles.Count) do
  begin
    row := getRow( titles, i);
    nr := JInt(row, 'nr');

    line := Format('%d %s', [nr, JString( row, 'title')]);
    sub := add(ptr, line);

    obj := JObject( row, 'childs');
    AddChilds( sub, JArray( obj, 'childs'), '  '+IntToStr(nr));
  end;


  if late.Count > 0  then
  begin
    ptr := add(NIL, 'Tagesordnungsänderung');
    PTData(ptr.GetData)^.Style := [fsBold];
    PTData(ptr.GetData)^.color := clRed;

    for i := 0 to pred(late.Count) do
    begin
      add( ptr, late[i]);
    end;
  end;
  late.Free;

  VST.FullExpand();
end;

procedure TTOFrame.updateContent;
var
  client : TdsMeeingClient;
  req    : TJSONObject;
  res    : TJSONObject;
begin
  if m_prid = 0 then
    exit;

  Screen.Cursor := crSQLWait;

  req := TJSONObject.create;
  JReplace( req, 'prid', m_prid);

  client := TdsMeeingClient.Create(m_dbx);
  try
    res := client.GetTree(req);
    ShowContent( res );

  finally
    client.Free;
  end;
  Screen.Cursor := crDefault;
end;

procedure TTOFrame.VSTDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; const Text: string;
  const CellRect: TRect; var DefaultDraw: Boolean);
var
  ptr : PTData;
  s   : string;
  re  : TRect;
begin
  DefaultDraw := false;

  ptr := PTData(Node.GetData);

  s   := text;
  re  := CellRect;
  with TargetCanvas do
  begin
    Font.Style  := ptr^.style;
    Font.Color  := ptr^.color;
    TextRect(re, s);
  end;
end;

procedure TTOFrame.VSTFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  ptr : PTData;
begin
  ptr := PTData(node.GetData);

  SetLength(ptr^.Title, 0);
  SetLength(ptr^.date,  0);
end;

procedure TTOFrame.VSTGetCellText(Sender: TCustomVirtualStringTree;
  var E: TVSTGetCellTextEventArgs);
var
  ptr : PTData;
begin
  ptr := PTdata(e.Node.GetData);
  case e.Column of
    0 : e.CellText  := ptr^.Title;
    1 : e.CellText  := ptr^.date;
  end;
end;

end.
