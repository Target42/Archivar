unit fr_Formeditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.Contnrs, Vcl.AppEvnts, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TControlType = (ctNone,
    ctEdit, ctLabeledEdit,
    ctLabel,
    ctGroupBox, ctPanel,
    ctMemo, ctRichEdit,
    ctRadio, ctRadioGrp
    );

  TCtrlEntry = record
    name : String;
    typ  : TControlType;
  end;

  TEditorFrame = class(TFrame)
    ApplicationEvents1: TApplicationEvents;
    GroupBox2: TGroupBox;
    TV: TTreeView;
    Panel1: TPanel;
    EditPanel: TPanel;
    GroupBox1: TGroupBox;
    LV: TListView;
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure FrameMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TVDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TVDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TVChange(Sender: TObject; Node: TTreeNode);
    procedure LVKeyPress(Sender: TObject; var Key: Char);
    procedure LVClick(Sender: TObject);
  private

    FNodes              : TObjectList;
    FCurrentNodeControl : TControl;
    FNodePositioning    : Boolean;
    FOldPos             : TPoint;
    m_inReposition      : boolean;

    m_newType           : TControlType;

    procedure createNodes;
    procedure setNodesVisible( value : Boolean);
    procedure PositionNodes( AroundControl : TControl );
    function  getHandle( Sender : TObject ): HWND;
    function findCtrl( var pkt : TPoint  ) : TComponent;

    procedure NodeMouseDown( Sender : TObject; Button : TMouseButton ; Shift : TShiftState; X, Y : integer );
    procedure NodeMouseMove( Sender : TObject; Shift : TShiftState; X,  Y  : integer);
    procedure NodeMouseUp(   Sender : TObject; Button : TMouseButton; Shift : TShiftState ;X, Y : Integer);

    procedure ControlMouseDown( Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : integer);
    procedure ControlMouseMove( Sender : TObject; Shift  : TShiftState; X, Y : integer );
    procedure ControlMouseUp(   Sender : TObject; Button : TMouseButton ; Shift : TShiftState; X, Y : integer );

    procedure updateTree;

    procedure SelectControl( c : TControl);

    function newEdit(     parent : TWinControl; x, y : Integer) :  TControl;
    function newLabel(    parent : TWinControl; x, y : Integer) :  TControl;
    function newGroupbox( parent : TWinControl; x, y : Integer) :  TControl;

    procedure updateLV;
    procedure fillGroup( name : string; data : array of TCtrlEntry);
  public
    procedure init;
    procedure release;
  end;

implementation

uses
  System.Types;

{$R *.dfm}

const
  EditList : array[1..2] of TCtrlEntry =
  (
    (name:'TEdit';        typ:ctEdit),
    (name:'TLabledEdit';  typ:ctLabeledEdit)
  );
  ContainerList : array[1..2] of TCtrlEntry =
  (
    (name:'TPanel';         typ:ctPanel),
    (name:'TGroupbox';      typ:ctGroupBox)
  );
  TextList : array[1..1] of TCtrlEntry =
  (
    (name:'TLabel';         typ:ctLabel)
  );

  TextFieldList : array[1..2] of TCtrlEntry =
  (
    (name:'TMemo';            typ:ctMemo),
    (name:'TRichEdit';        typ:ctRichEdit)
  );
  RadioList : array[1..2] of TCtrlEntry =
  (
    (name:'TRadioBtn';          typ:ctRadio),
    (name:'TRadioGroup';        typ:ctRadioGrp)
  );


{ TFrame1 }

procedure TEditorFrame.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
var
  com : TComponent;
  win : TControl;
  p   : TPoint;
  shift : TShiftState;
begin
  if not FNodePositioning then
  begin
    Handled := false;
    exit;
  end;

  Handled := true;
  case msg.message of
    WM_LBUTTONDOWN :
    begin
      p   := ScreenToClient(Mouse.CursorPos);
      com := findCtrl( p );
      if Assigned(com) then
      begin
        if com is TControl then
        begin
          win := com as TControl;
          if win.Owner <> self then
          begin
            if win is TComboBox then
            begin
              m_inReposition := true;
              ControlMouseDown( win, mbLeft, shift, mouse.CursorPos.X, Mouse.CursorPos.Y);
            end;
          end;
        end;
      end;
    end;
    WM_LBUTTONUP :
    begin
      p := ScreenToClient(Mouse.CursorPos);
      com := findCtrl(p);
      if com is TControl then
      begin
        win := com as TControl;
        if win is TComboBox then
        begin
          ControlMouseUp( win, mbLeft, shift, Mouse.CursorPos.X, Mouse.CursorPos.Y);;
          m_inReposition := false;
        end;
      end;
    end;
    WM_MOUSEMOVE :
    begin
      if Assigned(FCurrentNodeControl) and m_inReposition then
      begin
        if FCurrentNodeControl is TComboBox then
        begin
          ControlMouseMove( FCurrentNodeControl, shift, Mouse.CursorPos.X, Mouse.CursorPos.Y);
        end;
      end;
    end
  else
    Handled := false;
  end;
end;

procedure TEditorFrame.ControlMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if m_newType <> ctNone then
  begin
    EditPanelMouseDown(Sender, Button, Shift, X, Y );
    exit;
  end;
  if Sender is TControl then
  begin
    SelectControl(Sender as TControl);
    m_inReposition := true;
  end;
end;

procedure TEditorFrame.ControlMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: integer);
var
	newPos  : TPoint;
  win     : TControl;
begin
  if Sender is TControl then
  begin
    if m_inReposition then
    begin
      win := Sender as TControl;
      GetCursorPos(newPos);
      Screen.Cursor := crSize;
      win.Left := win.Left - FOldPos.X + newPos.X;
      win.Top  := win.Top  - FOldPos.Y + newPos.Y;
      FOldPos  := newPos;
      PositionNodes(win);
    end;
  end;

end;

procedure TEditorFrame.ControlMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  win : TControl;
begin
  if not m_inReposition then
    exit;

  if Sender is TControl then
  begin
    win := Sender as TControl;
    win.Top := (win.Top div 8 ) * 8;
    win.Left:= (win.Left div 4 ) * 4;
    PositionNodes(win);
    Screen.Cursor := crDefault;
    ReleaseCapture;
    m_inReposition := false;
  end;

end;

procedure TEditorFrame.createNodes;
var
  node  : integer;
  panel : TPanel;
begin
  for node := 0 to 7 do
    begin
      panel := TPanel.Create(self);
      FNodes.Add(panel);
      panel.Color   := clBlack;
      panel.Name    := 'Node'+IntToStr(node);
      panel.Width   := 5;
      panel.Height  := 5;
      panel.Parent  := self;
      panel.Visible := false;
      panel.ShowCaption := false;

      case node of
        0, 4 : panel.Cursor := crSizeNWSE;
        1, 5 : panel.Cursor := crSizeNS;
        2, 6 : panel.Cursor := crSizeNESW;
        3, 7 : panel.Cursor := crSizeWE;
      end;
      panel.OnMouseDown := NodeMouseDown;
      panel.OnMouseMove := NodeMouseMove;
      panel.OnMouseUp   := NodeMouseUp;
    end;
end;

procedure TEditorFrame.EditPanelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ctrl : TControl;
begin
  setNodesVisible(false);

  if (m_newType = ctNone) or not ( Sender is TWinControl) then
  begin
    TV.Selected := NIL;
    exit;
  end;

  case m_newType of
    ctEdit      : ctrl := newEdit(      Sender as TWinControl, X, y );
    ctLabel     : ctrl := newLabel(     Sender as TWinControl, X, Y );
    ctGroupBox  : ctrl := newGroupBox(  Sender as TWinControl, X, Y );
  end;

  updateTree;
  m_newType := ctNone;
end;

procedure TEditorFrame.fillGroup(name: string; data: array of TCtrlEntry);
var
  i     : integer;
  item  : TListItem;
  grp   : TListGroup;
begin
  grp := LV.Groups.Add;
  grp.GroupID := LV.Groups.Count;
  grp.Header := name;
  grp.State := [lgsNormal, lgsCollapsed, lgsCollapsible];

  for i := low(data) to High(data) do
    begin
      item := Lv.Items.Add;
      item.GroupID := grp.GroupID;
      item.Caption := data[i].name;
      item.Data    := Pointer( data[i].typ);
    end;
end;

function TEditorFrame.findCtrl(var pkt: TPoint): TComponent;
begin
  Result := NIL;
end;

procedure TEditorFrame.FrameMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FCurrentNodeControl) then
  begin
    setNodesVisible( false );
    FCurrentNodeControl := NIL;
    ReleaseCapture;
  end;
end;

function TEditorFrame.getHandle(Sender: TObject): HWND;
begin
  Result := 0;
  if Sender is TWinControl then
  begin
    Result := (Sender as TWinControl).Handle;
  end
  else if Sender is TLabel then
  begin
    Result := WindowFromDC( (Sender as TLabel).Canvas.Handle);
  end;

end;

procedure TEditorFrame.init;
begin
  FNodes := TObjectList.create(false);
  FCurrentNodeControl := NIL;
  FNodePositioning    := false;
  m_inReposition      := falsE;

  m_newType := ctNone;

  createNodes;
  updateLV;

  updateTree;
end;

procedure TEditorFrame.LVClick(Sender: TObject);
begin
  if not Assigned(LV.Selected) then
    exit;

  m_newType := TControlType(LV.Selected.Data);

end;

procedure TEditorFrame.LVKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
  begin
    m_newType := ctNone;
    LV.Selected := NIL;
  end;
end;

function TEditorFrame.newEdit(parent: TWinControl; x, y: Integer): TControl;
var
  ed : TEdit;
begin
  ed := TEdit.Create(parent as TComponent);
  ed.Parent := parent as TWinControl;
  ed.Name := 'Edit'+intToStr(GetTickCount);
  ed.Top  := y;
  ed.Left := X;

  ed.OnMouseDown := ControlMouseDown;
  ed.OnMouseMove := ControlMouseMove;
  ed.OnMouseUp   := ControlMouseUp;

  Result := ed;
end;

function TEditorFrame.newGroupbox(parent: TWinControl; x, y: Integer): TControl;
var
  grp : TGroupBox;
begin
  grp := TGroupBox.Create(Parent as TComponent);
  grp.Parent := Parent as TWinControl;
  grp.Name := 'GroupBox'+intToStr(GetTickCount);
  grp.Top  := y;
  grp.Left := X;

  grp.OnMouseDown := ControlMouseDown;
  grp.OnMouseMove := ControlMouseMove;
  grp.OnMouseUp   := ControlMouseUp;

  Result := grp;
end;

function TEditorFrame.newLabel(parent: TWinControl; x, y: Integer): TControl;
var
  lab : TLabel;
begin
  lab := TLabel.Create(parent as TComponent);
  lab.Parent := parent as TWinControl;
  lab.Name := 'Label'+intToStr(GetTickCount);
  lab.Top  := y;
  lab.Left := X;

  lab.OnMouseDown := ControlMouseDown;
  lab.OnMouseMove := ControlMouseMove;
  lab.OnMouseUp   := ControlMouseUp;

  Result := lab;
end;

procedure TEditorFrame.NodeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if (sender is TWinControl) then
  begin
    FNodePositioning := true;
    SetCapture(getHandle(Sender));
    GetCursorPos(FOldPos)
  end;

end;

procedure TEditorFrame.NodeMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: integer);
var
	newPos    : TPoint;
	frmPoint  : TPoint;
	OldRect   : TRect;
	AdjL, AdjR, AdjT, AdjB : boolean;
  win       : TControl;
begin
  if FNodePositioning then
  begin
    win := Sender as TControl;
    frmPoint := FCurrentNodeControl.Parent.ScreenToClient(Mouse.CursorPos);
    OldRect  := FCurrentNodeControl.BoundsRect;
    AdjL := false;
    AdjR := false;
    AdjT := false;
    AdjB := false;

    case FNodes.IndexOf(win) of
      0 : begin AdjL := true; AdjT := true; end;
      1 : begin AdjT := true;               end;
      2 : begin AdjR := true; AdjT := true; end;
      3 : begin AdjR := true;               end;
      4 : begin AdjR := true; AdjB := true; end;
      5 : begin AdjB := true;               end;
      6 : begin AdjL := true; AdjB := true; end;
      7 : begin AdjL := true;               end;
    end;
    if AdjL then OldRect.Left := frmPoint.X;
    if AdjR then OldRect.Right:= frmPoint.X;
    if AdjT then OldRect.Top  := frmPoint.Y;
    if AdjB then OldRect.Bottom:= frmPoint.Y;

    FCurrentNodeControl.SetBounds(OldRect.Left, OldRect.Top,
      OldRect.Right - OldRect.Left,
      OldRect.Bottom - OldRect.Top);

    win.Left := win.Left - FOldPos.X + newPos.X;
    win.Top  := win.Top  - FOldPos.Y + newPos.Y;

    FOldPos := newPos;
  end;
  PositionNodes(FCurrentNodeControl);

end;

procedure TEditorFrame.NodeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if FNodePositioning then
  begin
    Screen.Cursor := crDefault;
    ReleaseCapture;
    FNodePositioning := false;
  end;
end;

procedure TEditorFrame.PositionNodes(AroundControl: TControl);
var
  Node, T, L, CT, CL, FR, FB, FT, FL : Integer;
  TopLeft : TPoint;
	pan     : TPanel;
begin
  FCurrentNodeControl := NIL;
  for node := 0 to 7 do
  begin
		CL := trunc((AroundControl.Width / 2.0) + AroundControl.Left - 2);
		CT := trunc((AroundControl.Height / 2.0) + AroundControl.Top - 2.0);
		FR := AroundControl.Left + AroundControl.Width - 2;
		FB := AroundControl.Top + AroundControl.Height - 2;
		FT := AroundControl.Top - 2;
		FL := AroundControl.Left - 2;

    case node of
      0 : begin T:= FT;   L := FL;  end;
      1 : begin T:= FT;   L := CL;  end;
      2 : begin T:= FT;   L := FR;  end;
      3 : begin T:= CT;   L := FR;  end;
      4 : begin T:= FB;   L := FR;  end;
      5 : begin T:= FB;   L := CL;  end;
      6 : begin T:= FB;   L := FL;  end;
      7 : begin T:= CT;   L := FL;  end;
      else
        T := 0;
        L := 0;
    end;
    TopLeft := AroundControl.Parent.ClientToScreen(Point(L, T));

    pan := FNodes.Items[Node] as TPanel;
    pan.Parent := AroundControl.Parent;
    TopLeft := pan.Parent.ScreenToClient(TopLeft);
    pan.Top := TopLeft.Y;
    pan.Left:= TopLeft.X;
  end;
  FCurrentNodeControl := AroundControl;
  setNodesVisible(true);
end;

procedure TEditorFrame.release;
begin
  FNodes.Free;
end;

procedure TEditorFrame.SelectControl(c: TControl);
begin
  setNodesVisible(false);
  FCurrentNodeControl := c;

  GetCursorPos(FOldPos);
  SetCapture(getHandle(c));
  PositionNodes(c);
end;

procedure TEditorFrame.setNodesVisible(value: Boolean);
var
  i : integer;
begin
  for i := 0 to 7 do
    (FNodes.Items[i] as TWinControl).Visible := value;
end;

procedure TEditorFrame.TVChange(Sender: TObject; Node: TTreeNode);
begin
  if not Assigned(node) then
    exit;

  if Assigned(FCurrentNodeControl) then
    ReleaseCapture;

  SelectControl( TControl(Node.Data));
end;

procedure TEditorFrame.TVDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  src, dest : TTreeNode;

begin
  FCurrentNodeControl := NIL;
  setNodesVisible(false);

  src := TV.Selected;
  dest := TV.GetNodeAt(X, Y);

  if not Assigned(TV.Selected) or ( src = dest )then
   exit;

   if Assigned(dest) and Assigned(src) then
      TWinControl(src.data).parent := TWinControl(dest.Data)
   else
     TWinControl(src.data).parent :=EditPanel;
  updateTree;
end;

procedure TEditorFrame.TVDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  cmp : TControl;
  dest : TTreeNode;
begin
  Accept := false;

  dest := TV.GetNodeAt(X, Y);
  if not Assigned(TV.Selected) or  (dest = TV.Selected) then
    exit;

  if not Assigned(dest) then
    Accept := true
  else
  begin
    cmp := TControl(dest.Data);

    Accept := (cmp is TGroupBox) or ( cmp is TPanel);
  end;
end;

procedure TEditorFrame.updateLV;
begin
  LV.Items.BeginUpdate;
  LV.Items.Clear;

  fillGroup('Container',  ContainerList);
  fillGroup('Edit',       EditList);
  fillGroup('Label',      TextList);
  fillGroup('Text',       TextFieldList);
  fillGroup('TextFields', TextFieldList);

  LV.Items.EndUpdate;
end;

procedure TEditorFrame.updateTree;

  procedure add( root :  TTreeNode; cmp :  TWinControl );
  var
    node : TTreeNode;
    i : integer;
  begin
    for I := 0 to pred( cmp.ControlCount) do
    begin
      if FNodes.IndexOf(cmp.Controls[i]) = -1 then
      begin
        node := TV.items.AddChildObject( root, cmp.Controls[i].Name, cmp.Controls[i] );
        if cmp.Controls[i] is TWinControl then
          add( node, cmp.Controls[i] as TWinControl );

        if not Assigned(root) then
          node.expand(true);
      end;
    end;
  end;
begin
  TV.Items.beginUpdate;
  TV.Items.Clear;
  add( Nil, EditPanel );
  TV.Items.EndUpdate;
end;

end.
