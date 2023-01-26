program Ravin;

uses
  Vcl.Forms,
  UfrmCartaoPainelGestao in '..\codigo\frames\UfrmCartaoPainelGestao.pas' {frmCartaoPainelControle: TFrame},
  UfrmLogomarca in '..\codigo\frames\UfrmLogomarca.pas' {frmLogo: TFrame},
  UfrmItemMenu in '..\codigo\frames\UfrmItemMenu.pas' {frmMenuItem: TFrame},
  UdmRavin in '..\codigo\database\UdmRavin.pas' {dmRavin: TDataModule},
  UfrmSplash in '..\codigo\formularios\UfrmSplash.pas' {frmSplash},
  UfrmMesas in '..\codigo\formularios\UfrmMesas.pas' {frmMesas},
  UfrmSobre in '..\codigo\formularios\UfrmSobre.pas' {frmSobre},
  UfrmProdutos in '..\codigo\formularios\UfrmProdutos.pas' {frmProdutos},
  UfrmPainelGestao in '..\codigo\formularios\UfrmPainelGestao.pas' {frmPainelGestao},
  UfrmComandas in '..\codigo\formularios\UfrmComandas.pas' {frmComandas},
  UresourceUtils in '..\codigo\Util\UresourceUtils.pas',
  UfrmLogin in '..\codigo\formularios\UfrmLogin.pas' {frmLogin},
  UUsuario in '..\codigo\Modelos\UUsuario.pas',
  UusuarioDao in '..\codigo\Modelos\UusuarioDao.pas',
  UfrmRegistrar in '..\codigo\formularios\UfrmRegistrar.pas' {frmRegistrar},
  UfrmBotaoPrimario in '..\codigo\frames\UfrmBotaoPrimario.pas' {frmBotaoPrimario: TFrame},
  UvalidadorUsuario in '..\codigo\Validadores\UvalidadorUsuario.pas',
  UiniUtils in '..\codigo\Util\UiniUtils.pas',
  UfrmTesteBusca in '..\Testes\UfrmTesteBusca.pas' {Form1},
  UFormUtils in '..\codigo\Util\UFormUtils.pas',
  UfrmBotaoCancelar in '..\codigo\frames\UfrmBotaoCancelar.pas' {frmBotaoCancelar: TFrame},
  UfrmBotaoExcluir in '..\codigo\frames\UfrmBotaoExcluir.pas' {frmBotaoExcluir: TFrame},
  UfrmCadastroCliente in '..\codigo\formularios\UfrmCadastroCliente.pas' {frmCadastroCliente},
  UfrmListaClientes in '..\codigo\formularios\UfrmListaClientes.pas' {frmListaClientes},
  UPessoa in '..\codigo\Modelos\UPessoa.pas',
  UPessoaDao in '..\codigo\Modelos\UPessoaDao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TdmRavin, dmRavin);
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TfrmPainelGestao, frmPainelGestao);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
