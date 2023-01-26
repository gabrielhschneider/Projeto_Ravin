unit UfrmRegistrar;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,

  FireDAC.Phys.MySQLWrapper,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  UfrmBotaoPrimario,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  System.Actions, Vcl.ActnList, Vcl.ExtActns;

type
  TfrmRegistrar = class(TForm)
    imgFundo: TImage;
    pnlRegistrar: TPanel;
    lblTituloRegistrar: TLabel;
    lblSubTituloRegistrar: TLabel;
    lblTituloAutenticar: TLabel;
    lblSubTituloAutenticar: TLabel;
    edtNome: TEdit;
    edtCpf: TEdit;
    edtLogin: TEdit;
    edtSenha: TEdit;
    edtConfirmarSenha: TEdit;
    frmBotaoPrimario1: TfrmBotaoPrimario;
    procedure lblSubTituloAutenticarClick(Sender: TObject);
    procedure frmBotaoPrimario1spbBotaoPrimarioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRegistrar: TfrmRegistrar;

implementation

uses
  UusuarioDao,
  Uusuario,
  UfrmLogin,
  UvalidadorUsuario,
  UFormUtils;

{$R *.dfm}


procedure TfrmRegistrar.frmBotaoPrimario1spbBotaoPrimarioClick(Sender: TObject);
var
  LUsuario : TUsuario;
  LDao : TUsuarioDAO;
begin
  try
    try
    LUsuario := TUsuario.Create();
    LUsuario.login := edtLogin.Text;
    LUsuario.senha := edtLogin.Text;
    LUsuario.pessoaId := 2;
    LUsuario.criadoEm := Now();
    LUsuario.criadoPor := 'admin';
    LUsuario.alteradoEm := Now();
    LUsuario.alteradoPor := 'admin';

    TValidadorUsuario.Validar(edtConfirmarSenha.text, LUsuario);

    LDao := TUsuarioDAO.Create();
    LDao.InserirUsuario(LUsuario);

  except
    on E: EMySQLNativeException do begin
      ShowMessage('Erro ao inserir usuario no banco');
    end;
    on E: Exception do begin
      ShowMessage(E.Message);
    end;
  end;



  finally
    if Assigned(LDao) then
    begin
      FreeAndNil(LDao);
    end;

    FreeAndNil(LUsuario)
  end;
end;

procedure TfrmRegistrar.lblSubTituloAutenticarClick(Sender: TObject);
begin
  if not Assigned(frmLogin) then
  begin
    Application.CreateForm(TfrmLogin, frmLogin);
  end;

  TFormUtils.SetarFormPrincipal(frmLogin);
  frmLogin.Show();

  Close();
end;

end.
