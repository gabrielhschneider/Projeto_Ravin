unit UfrmSplash;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,
  System.DateUtils,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Vcl.StdCtrls,

  UfrmLogomarca;

type
  TfrmSplash = class(TForm)
    pnlFundo: TPanel;
    tmrSplash: TTimer;
    frmLogo: TfrmLogo;
    procedure tmrSplashTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    Inicialized: Boolean;
    procedure InicializarAplicacao();
    procedure ShowPainelGestao();
    procedure ShowLogin();
  public
    { Public declarations }
    function VerificarDeveLogar(): Boolean;

    //Numero maximo de dias que o login do usuario é valido sem autenticar novamente
    const MAX_DIAS_LOGIN : Integer = 5;
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

uses UfrmPainelGestao, UfrmLogin, UiniUtils, UFormUtils;

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  Inicialized := false;
  tmrSplash.Enabled := false;
  tmrSplash.Interval := 1000;
end;

procedure TfrmSplash.FormPaint(Sender: TObject);
begin
  tmrSplash.Enabled := not Inicialized;
end;

procedure TfrmSplash.InicializarAplicacao;
var
  LLogado : String;
  LDeveLogar : Boolean;
begin

  LDeveLogar := VerificarDeveLogar();

  //Carregando login
  LLogado := TIniUtils.lerPropriedade(INFORMACOES_GERAIS, LOGADO);

  // se estiver logado e não expirado
  if (LLogado = TIniUtils.VALOR_VERDADEIRO) and (not LDeveLogar) then
  begin
    ShowPainelGestao();
  end

  // se não estiver logado e ou login expirado
  else
  begin
    ShowLogin();
  end;
end;

procedure TfrmSplash.tmrSplashTimer(Sender: TObject);
begin
  tmrSplash.Enabled := false;
  if not Inicialized then
  begin
    Inicialized := true;
    InicializarAplicacao();
  end;
end;

function TfrmSplash.VerificarDeveLogar: Boolean;
var
  LDataString : String;
  LDataUltimoLogin : TDateTime;
  LDataExpiracaoLogin : TDateTime;
  LExisteDataUltimoLogin : Boolean;
begin
  //Carregando data/hora do ultimo Login
  LDataString := TIniUtils.lerPropriedade(INFORMACOES_GERAIS,
                                               DATAHORA_ULTIMO_LOGIN);

  try
    //Convertendo de string para Date
    LDataUltimoLogin := StrToDateTime(LDataString);

    //Calculando data de expiração do login
    LDataExpiracaoLogin := IncDay(LDataUltimoLogin, MAX_DIAS_LOGIN);
    Result := LDataExpiracaoLogin < Now();
  except
    on E: Exception do
      Result := true;
  end;

end;

procedure TfrmSplash.ShowLogin;
begin
  //Verifica form criado com o Assigned
  if not Assigned(frmLogin) then
  begin
    Application.CreateForm(TfrmLogin, frmLogin);
  end;

  TFormUtils.SetarFormPrincipal(frmLogin);
  frmLogin.Show();

  Close;
end;

procedure TfrmSplash.ShowPainelGestao;
begin
  if not Assigned(frmPainelGestao) then  //Verifica form criado com o Assigned
  begin
    Application.CreateForm(TfrmPainelGestao, frmPainelGestao);
  end;

  TFormUtils.SetarFormPrincipal(frmPainelGestao);
  frmPainelGestao.Show();

  Close;

end;

end.


