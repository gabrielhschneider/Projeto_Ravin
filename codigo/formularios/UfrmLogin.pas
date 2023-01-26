unit UfrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, UfrmBotaoPrimario;

type
  TfrmLogin = class(TForm)
    pnlFundo: TPanel;
    edtLogin: TEdit;
    edtSenha: TEdit;
    ImageLogo: TImage;
    lblTitulo: TLabel;
    lblSubTitulo: TLabel;
    lblTituloRegistrar: TLabel;
    lblSubTituloRegistrar: TLabel;
    frmBotaoPrimario1: TfrmBotaoPrimario;
    procedure frmBotaoPrimario1spbBotaoPrimarioClick(Sender: TObject);
    procedure lblTituloRegistrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  UfrmPainelGestao, UUsuario, UusuarioDao, UfrmRegistrar, UiniUtils, UFormUtils;

{$R *.dfm}


procedure TfrmLogin.frmBotaoPrimario1spbBotaoPrimarioClick(Sender: TObject);
var
  Ldao : TUsuarioDao;
  LUsuario : TUsuario;

  LLogin, LSenha : String;
begin
  LDao := TUsuarioDao.Create();

  LLogin := edtLogin.Text;
  LSenha := edtSenha.Text;

  LUsuario := LDao.BuscarUsuarioPorLoginSenha(LLogin, LSenha);

  if Assigned(LUsuario) then
  begin
    // Conseguiu Logar

    //Registrando data/hora do ultimo login
    TIniUtils.gravarPropriedade(INFORMACOES_GERAIS,
      DATAHORA_ULTIMO_LOGIN, DateTimeToStr(Now()));

    //Registrar que o usuario efetuou login com sucesso
    TIniUtils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADO,
                                TIniUtils.VALOR_VERDADEIRO);



    if not Assigned(frmPainelGestao) then
    begin
      Application.CreateForm(TfrmPainelGestao, frmPainelGestao);
    end;

    TFormUtils.SetarFormPrincipal(frmPainelGestao);
    frmPainelGestao.Show();

    Close();
  end else begin
    FreeAndNil(LDao);
    ShowMessage('Login e/ou Senha inválidos');
  end;

  FreeAndNil(LDao);
  FreeAndNil(LUsuario);
end;


procedure TfrmLogin.lblTituloRegistrarClick(Sender: TObject);
begin
  if not Assigned(frmRegistrar) then
  begin
    Application.CreateForm(TfrmRegistrar, frmRegistrar);
  end;

  TFormUtils.SetarFormPrincipal(frmRegistrar);
  frmRegistrar.Show();

  Close();
end;

end.
