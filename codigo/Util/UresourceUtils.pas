unit UresourceUtils;

interface

uses
  System.IOUtils,
  System.SysUtils,
  System.Classes;

type TResourceUtils = class(TObject)
  private

  protected

  public
    class function carregarArquivoResource(PNomeArquivo: String;
                   PNomeAplicacao: String) : String;

end;

implementation

{ TResourceUtils }

class function TResourceUtils.carregarArquivoResource(PNomeArquivo: String;
  PNomeAplicacao: String): String;
var
  LConteudoArquivo      : TStringList;
  LCaminhoArquivo       : String;
  LCaminhoPastaAplicacao: String;
  LConteudoTexto        : String;
begin
  LConteudoTexto := '';
  LConteudoArquivo := TStringList.Create();
  try
    try
      LCaminhoPastaAplicacao := TPath.Combine(
                              TPath.GetDocumentsPath, PNomeAplicacao);
      LCaminhoArquivo := TPath.Combine(LCaminhoPastaAplicacao, PNomeArquivo); //Pega pasta Documentos
      LConteudoArquivo.LoadFromFile(LCaminhoArquivo);
      LConteudoTexto := LConteudoArquivo.Text;
    except
      on E: Exception do
        raise Exception.Create('Erro ao carregar arquivos de resource.' +
                               'Arquivo: ' + PNomeArquivo);
    end;
  Finally
    LConteudoArquivo.Free;
  end;

  Result := LConteudoTexto;
end;
end.
