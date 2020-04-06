unit u_misc;

interface

uses
  Data.DB, System.Classes, IBX.IBTable;

function doFileUpload( tab : TIBTable ; blob : TBlobField ; st : TStream ) : integer;

implementation

const BufferSize : integer = 1048576;


function doFileUpload( tab : TIBTable ; blob : TBlobField ; st : TStream ) : integer;
var
  bytes  : integer;
  buffer : array of byte;
  bs     : TStream;
begin
  Result := 0;

  SetLength( buffer, BufferSize);
  bs := tab.CreateBlobStream( blob, bmWrite);
  repeat
    bytes := st.Read( buffer[0], BufferSize);
    inc( Result, bytes );
    bs.Write(buffer[0], bytes)
  until bytes <> BufferSize;
  bs.Free;
end;

end.
