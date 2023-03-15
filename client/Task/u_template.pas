unit u_template;

interface

uses
  System.Classes;
type
  TTemplate = class
    private
      FCLID : string;
      FID   : integer;
      FTYID : integer;
      FNAME : string;
      m_st  : TMemoryStream;

      function Getst: TStream;
    public
      constructor create;
      Destructor Destroy; override;

      property Name: string read FNAME write FNAME;
      property CLID: string read FCLID write FCLID;
      property ID: integer read FID write FID;
      property TYID: integer read FTYID write FTYID;
      property st: TStream read Getst;
    end;

implementation

{ TTemplate }

constructor TTemplate.create;
begin
    m_st  := TMemoryStream.Create;
end;

destructor TTemplate.Destroy;
begin
  m_st.Free;
  inherited;
end;

function TTemplate.Getst: TStream;
begin
  Result := m_st;
end;

end.
