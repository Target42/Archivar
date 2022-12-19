unit u_IWindowHandler;

interface

uses
  Vcl.Forms;

type
  IWindowHandler = interface
    ['{B51365B9-6593-4BE4-B6D7-C4727BB4D5A1}']

    procedure registerForm(   frm : TForm );
    procedure unregisterForm( frm : TForm );

  end;

implementation

end.
