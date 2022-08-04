unit fr_ReportEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, i_taskEdit,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.Menus;

type
  TReportFrameEditor = class;
  TCloseFrame = procedure(sender : TReportFrameEditor) of object;


  TReportFrameEditor = class(TFrame)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
  protected
      m_tf        : ITaskFile;
      FSTyle      : ITaskStyle;
      m_tab       : TTabSheet;
      m_changed   : boolean;
      m_closeFrame: TCloseFrame;
      m_cache     : boolean;

      procedure setFileName( value : string );
      function  getfileName : string;

      procedure setStyle( value : ITaskStyle);
      procedure setDataFile( value : ITaskFile ); virtual;

      function changed : boolean; virtual;

      procedure setTab( value : TTabSheet);

  public
      property FileName     : string      read getFileName  write setFileName;
      property DataFile     : ITaskFile   read m_tf         write setDataFile;
      property Style        : ITaskStyle  read FSTyle       write setStyle;
      property Tab          : TTabSheet   read m_tab        write setTab;
      property onCloseFrame : TCloseFrame                   write m_closeFrame;
      property IsChanged    : boolean     read m_changed    write m_changed;

      property CacheFile    : boolean     read m_cache      write m_cache;

      procedure save; virtual;
      function isFile( fname : string) : boolean;

      procedure UpdateCaption;

      procedure init; virtual;
      procedure release; virtual;

      procedure insertFieldName( name : string ); virtual;
      procedure setPopup( pop : TPopupMenu ); virtual;

      procedure closeEditor; virtual;
  end;

implementation

{$R *.dfm}

{ TReportFrameEditor }

uses
  System.UITypes;


function TReportFrameEditor.changed: boolean;
begin
  Result := false;
end;

procedure TReportFrameEditor.closeEditor;
begin
  if Assigned(m_closeFrame) then
    m_closeFrame(self);
end;

function TReportFrameEditor.getfileName: string;
begin
  Result := m_tf.Name;
end;

procedure TReportFrameEditor.init;
begin
  m_tf          := NIL;
  FSTyle        := NIL;
  m_changed     := false;
  m_closeFrame  := NIL;
  m_cache       := false;
end;

procedure TReportFrameEditor.insertFieldName(name: string);
begin

end;

function TReportFrameEditor.isFile(fname: string): boolean;
begin
  Result := false;
  if Assigned(m_tf) then
    Result := SameText( fname, ExtractFileName(m_tf.Name));
end;

procedure TReportFrameEditor.release;
begin
  m_tf    := NIL;
  FSTyle  := NIL;

end;

procedure TReportFrameEditor.save;
begin
  m_changed := false;
end;

procedure TReportFrameEditor.setDataFile(value: ITaskFile);
begin
  m_tf := value;
  tab.Caption := ExtractFileName( m_tf.Name);
  UpdateCaption;
end;

procedure TReportFrameEditor.setFileName(value: string);
begin
  m_tf.Name := value;
end;

procedure TReportFrameEditor.setPopup(pop: TPopupMenu);
begin

end;

procedure TReportFrameEditor.setStyle(value: ITaskStyle);
begin
  FSTyle := value;
end;

procedure TReportFrameEditor.setTab(value: TTabSheet);
begin
  m_tab := value;
  self.Parent       := m_tab;
  m_tab.PageControl := TPageControl(self.Owner);
end;

procedure TReportFrameEditor.SpeedButton1Click(Sender: TObject);
begin
  if not m_tf.Readonly then begin
    if changed then begin
      if (MessageDlg('Sollen die Änderungen gespeichert werden?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
        save;
    end;
  end;
  release;
  m_tab.PageControl := NIL;
  m_tab.Free;

  if Assigned(m_closeFrame) then
    m_closeFrame(self);
end;

procedure TReportFrameEditor.UpdateCaption;
begin
  if Assigned(FSTyle) and Assigned( m_tf)  then
    Panel1.caption := 'Style: '+FSTyle.Name+' '+getfileName
  else if Assigned(m_tf) then
    Panel1.Caption := m_tf.Name;

end;

end.
