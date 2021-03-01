unit u_tree;

interface

uses
  System.Generics.Collections, System.Generics.Defaults, System.JSON;

type
  TNode = class
    private
      FChilds : TList<TNode>;
      FID: integer;
      FPID: integer;
      FTitle: string;
      FDate: TDateTime;
      Fpos: integer;
    FNr: integer;
    public
      constructor Create;
      Destructor Destroy; override;

      property ID: integer read FID write FID;
      property PID: integer read FPID write FPID;
      property Title: string read FTitle write FTitle;
      property pos: integer read Fpos write Fpos;
      property Nr: integer read FNr write FNr;
      property Date: TDateTime read FDate write FDate;

      property Childs: TList<TNode>         read FChilds;

      procedure SortChilds;

      function toJson : TJSONObject;
  end;

implementation

uses
  u_json;

{ TNode<TValue> }

constructor TNode.Create;
begin
  FChilds := TList<TNode>.create;
end;

destructor TNode.Destroy;
begin
  FChilds.Free;
  inherited;
end;

procedure TNode.SortChilds;
var
  node : TNode;
begin
  FChilds.Sort(
    TComparer<TNode>.Construct(
      function(const Left, Right: TNode): Integer
      begin
        Result := 0;


        if left.pos < right.pos then
          Result := -1
        else if left.pos > right.pos then
          Result := 1;
      end
    )
  );

  for node in FChilds do
    node.SortChilds;
end;

function TNode.toJson: TJSONObject;
var
  arr : TJSONArray;
  i   : integer;
begin
  Result := TJSONObject.Create;

  JReplace( Result, 'id',       FID);
  JReplace( Result, 'pid',      FPID);
  JReplace( Result, 'pos',      Fpos);
  JReplace( Result, 'title',    FTitle );
  JReplace( Result, 'created',  FDate );
  JReplace( Result, 'nr',       FNr);

  arr     := TJSONArray.Create;

  for i := 0 to pred(FChilds.Count) do
  begin
    arr.AddElement(FChilds[i].toJson);
  end;

  JReplace( Result, 'childs', arr);
end;

end.
