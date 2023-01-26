unit UdmRavin;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Dialogs;

type
  TdmRavin = class(TDataModule)
    cnxBancoDeDados: TFDConnection;
    drvBancoDeDados: TFDPhysMySQLDriverLink;
    wtcBancoDeDados: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure cnxBancoDeDadosBeforeConnect(Sender: TObject);
    procedure cnxBancoDeDadosAfterConnect(Sender: TObject);
  private
    { Private declarations }
    procedure CriarTabelas();
    procedure InserirDados();
  public
    { Public declarations }
  end;

var
  dmRavin: TdmRavin;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UresourceUtils, UiniUtils;
{$R *.dfm}

procedure TdmRavin.cnxBancoDeDadosAfterConnect(Sender: TObject);
Var
  LCaminhoBaseDados : String;
  LcriarBaseDados   : Boolean;
begin
  LCaminhoBaseDados := (TIniUtils.lerPropriedade(DATABASE, CAMINHO_BASE_DADOS));
  LCriarBaseDados := not FileExists(LCaminhoBaseDados, True);

  if LCriarBaseDados then
  begin
    CriarTabelas();
    InserirDados();
  end;
end;

procedure TdmRavin.cnxBancoDeDadosBeforeConnect(Sender: TObject);
var
  LCaminhoBaseDados : String;
  LCriarBaseDados: Boolean;
begin
  LCaminhoBaseDados := (TIniUtils.lerPropriedade(DATABASE, CAMINHO_BASE_DADOS));
  LCriarBaseDados := not FileExists(LCaminhoBaseDados, True);
  with cnxBancoDeDados do
  begin
    Params.Values['Server']    := TIniUtils.lerPropriedade(DATABASE, SERVER);
    Params.Values['User_Name'] := TIniUtils.lerPropriedade(DATABASE, USER_NAME);
    Params.Values['Password']  := TIniUtils.lerPropriedade(DATABASE, PASSWORD);
    Params.Values['DriverID']  := TIniUtils.lerPropriedade(DATABASE, DRIVER_ID);
    Params.Values['Port']      := TIniUtils.lerPropriedade(DATABASE, PORT);

    if not LCriarBaseDados then begin
      Params.Values['DataBase']  := TIniUtils.lerPropriedade(DATABASE, DATA_BASE);
    end;

  end;

end;

procedure TdmRavin.CriarTabelas;
begin
  try
    cnxBancoDeDados.ExecSQL(TResourceutils.carregarArquivoResource
                           (TIniUtils.lerPropriedade(DATABASE, ARQUIVO_CREATE),
                           (TIniUtils.lerPropriedade(DATABASE, NOME_APLICACAO))));
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;

end;

procedure TdmRavin.InserirDados;
begin
  try
    cnxBancoDeDados.StartTransaction();
    cnxBancoDeDados.ExecSQL(TResourceutils.carregarArquivoResource
                           (TIniUtils.lerPropriedade(DATABASE, ARQUIVO_INSERT),
                           (TIniUtils.lerPropriedade(DATABASE, NOME_APLICACAO))));
    cnxBancoDeDados.Commit();
  except
    on E: Exception do begin
      cnxBancoDeDados.Rollback();
      showMessage(E.Message);
    end;

  end;

end;

procedure TdmRavin.DataModuleCreate(Sender: TObject);
begin
  if not cnxBancoDeDados.Connected then begin
    cnxBancoDeDados.Connected := true;
  end;

end;
end.
