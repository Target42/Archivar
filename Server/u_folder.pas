unit u_folder;

interface

uses
  System.Generics.Collections;

type
  TFolder = class
    private
      m_childs  : TList<TFolder>;
      FID       : integer;
      FPID      : integer;
    public
      constructor create;
      Destructor Destroy; override;

      property ID     : integer         read FID        write FID;
      property PID    : integer         read FPID       write FPID;
      property Childs : TList<TFolder>  read m_childs;

      procedure add( fld : TFolder );
  end;

implementation

{ TFolder }

procedure TFolder.add(fld: TFolder);
begin
  if not Assigned(fld) then exit;

  if not m_childs.Contains(fld) then
    m_childs.Add(fld);
end;

constructor TFolder.create;
begin
  FID       := 0;
  PID       := 0;
  m_childs  := TList<TFolder>.create;
end;

destructor TFolder.Destroy;
begin
  m_childs.free;
  inherited;
end;

end.
