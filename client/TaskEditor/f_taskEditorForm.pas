unit f_taskEditorForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Contnrs, Vcl.StdCtrls,
  Vcl.AppEvnts;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    ApplicationEvents1: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
  private
    FNodes              : TObjectList;
    FCurrentNodeControl : TControl;
    m_PositionRunTime   : boolean;
    m_inReposition      : boolean;
    FNodePositioning    : Boolean;
    FOldPos             : TPoint;

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


  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses
  Vcl.ExtCtrls;

{$R *.dfm}

{ TForm1 }

procedure TForm1.ApplicationEvents1Message(var Msg: tagMSG;
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

procedure TForm1.ControlMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  win : TControl;
begin
  if Sender is TControl then
  begin
    win := Sender as TControl;
    // SelectCtrl( win );
    GetCursorPos(FOldPos);
    m_inReposition := true;
    SetCapture(getHandle(Sender));
    PositionNodes(win);
  end;
end;

procedure TForm1.ControlMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: integer);
var
	newPos  : TPoint;
	frmPoint: TPoint;
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

procedure TForm1.ControlMouseUp(Sender: TObject; Button: TMouseButton;
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

procedure TForm1.createNodes;
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

function TForm1.findCtrl(var pkt: TPoint): TComponent;
begin
  Result := NIL;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FNodes := TObjectList.create(false);
  FCurrentNodeControl := NIL;
  FNodePositioning    := false;
  m_inReposition      := falsE;

  createNodes;

  Edit1.OnMouseMove := self.ControlMouseMove;
  Edit1.OnMouseDown := self.ControlMouseDown;
  Edit1.OnMouseUp   := Self.ControlMouseUp;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FNodes.Free;
end;

function TForm1.getHandle(Sender: TObject): HWND;
var
  win : TWinControl;
  lab : TLabel;
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

procedure TForm1.NodeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  win : TWinControl;
begin
  if (sender is TWinControl) then
  begin
    FNodePositioning := true;
    SetCapture(getHandle(Sender));
    GetCursorPos(FOldPos)
  end;

end;

procedure TForm1.NodeMouseMove(Sender: TObject; Shift: TShiftState; X,
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

procedure TForm1.NodeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if FNodePositioning then
  begin
    Screen.Cursor := crDefault;
    ReleaseCapture;
    FNodePositioning := false;
  end;
end;

procedure TForm1.PositionNodes(AroundControl: TControl);
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
    TopLeft := pan.Parent.ScreenToClient(TopLeft);
    pan.Top := TopLeft.Y;
    pan.Left:= TopLeft.X;
  end;
  FCurrentNodeControl := AroundControl;
  setNodesVisible(true);
end;

procedure TForm1.setNodesVisible(value: Boolean);
var
  i : integer;
begin
  for i := 0 to 7 do
    (FNodes.Items[i] as TWinControl).Visible := value;
end;

end.
