unit UfrmTesteBusca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UusuarioDao,UUsuario,
  System.Generics.Collections, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    mmListaUsuarios: TMemo;
    btnTestar: TButton;
    procedure btnTestarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Teste_BucarTodosUsuarios(ListaUsuarios : TList<TUsuario>): String;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnTestarClick(Sender: TObject);
var
  LUsuarioDao : TUsuarioDao;
begin
  LUsuarioDao := TUsuarioDao.Create();
  Teste_BucarTodosUsuarios(LUsuarioDao.BuscarTodosUsuarios());
end;


function TForm1.Teste_BucarTodosUsuarios(ListaUsuarios: TList<TUsuario>): string;
var
  LPosicao : Integer;
begin
  for LPosicao := 0 to ListaUsuarios.Count - 1 do begin
    mmListaUsuarios.Lines.Add(ListaUsuarios[LPosicao].login);
  end;

end;



end.
