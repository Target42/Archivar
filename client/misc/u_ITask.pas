unit u_ITask;

interface


type
  ITask = interface
    ['{AFEF769A-D577-4AAA-8E36-313E880FA16B}']
    procedure setID( value : integer );
    function  getID : integer;

    procedure setRO( value : boolean );
    function  getRO : boolean;

    property ID : integer read getID write setID;
    property RO : Boolean read getRO write setRO;
    procedure Post;
    procedure cancel;

    procedure fillBookMark;
    function changed : boolean;
    procedure release;


  end;

implementation

end.
