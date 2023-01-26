unit UPessoaDao;

interface

uses
  UPessoa,
  FireDAC.Comp.Client,
  UdmRavin,
  System.SysUtils,
  System.Generics.Collections;

type TPessoaDAO = class
  private

  protected

  public
  {FUNCTIONS
  BUSCAR PESSOA POR ID
  EXCLUIR PESSOA
  EXCLUIR TODAS PESSOAS }

  function BuscarTodasPessoas(): TList<TPessoa>;
  procedure InserirPessoa(PPessoa: TPessoa);
end;

implementation

{ TUsuarioDAO }

function  TPessoaDAO.BuscarTodasPessoas(): TList<TPessoa>;
var
  LQuery : TFDQuery;
  LPessoa : TPessoa;
  LListaUsuarios : TList<TPessoa>;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text := 'SELECT * FROM ravin.pessoa;';
  LQuery.Open();
  LQuery.First();

  LListaUsuarios := TList<TPessoa>.Create;
  if not LQuery.isEmpty then begin
    while not LQuery.Eof do begin
      LPessoa := TPessoa.Create();

      LPessoa.nome := LQuery.FieldByName('nome').AsString;
      LPessoa.email := LQuery.FieldByName('email').AsString;
      LPessoa.dataDeNascimento := LQuery.FieldByName('dataDeNascimento').AsDateTime;
      LPessoa.dataDeNascimento := LQuery.FieldByName('id').AsInteger;
      LPessoa.tipoPessoa := LQuery.FieldByName('tipoPessoa').AsString;
      LPessoa.telefone := LQuery.FieldByName('telefone').AsInteger;
      LPessoa.ativo := LQuery.FieldByName('ativo').AsBoolean;
      LPessoa.criadoEm := LQuery.FieldByName('criadoEm').AsDateTime;
      LPessoa.criadoPor := LQuery.FieldByName('criadoPor').AsString;
      LPessoa.alteradoEm := LQuery.FieldByName('alteradoEm').AsDateTime;
      LPessoa.alteradoPor := LQuery.FieldByName('alteradoPor').AsString;

      LListaUsuarios.Add(LPessoa);
      LQuery.Next;

    end;
  end;

  Result := LListaUsuarios;

end;

procedure TPessoaDAO.InserirPessoa(PPessoa: TPessoa);
var
  LQuery : TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Add('INSERT INTO pessoa ');
  LQuery.SQL.Add(' (nome, email, dataDeNascimento, tipoPessoa, cpf, telefone, ');
  LQuery.SQL.Add(' ativo, criadoEm, criadoPor, alteradoEm, alteradoPor');
  LQuery.SQL.Add(' VALUES (:nome, :email, :datadenascimento, :tipoPessoa, :cpf, ');
  LQuery.SQL.Add(':telefone, :ativo, :criadoEm, :criadoPor, :alteradoEm, :alteradoPor');

  LQuery.ParamByName('nome').AsString := PPessoa.nome;
  LQuery.ParamByName('email').AsString := PPessoa.email;
  LQuery.ParamByName('dataDeNascimento').AsDateTime := PPessoa.dataDeNascimento;
  LQuery.ParamByName('tipoPessoa').AsString := PPessoa.tipoPessoa;
  LQuery.ParamByName('cpf').AsString := PPessoa.cpf;
  LQuery.ParamByName('telefone').AsInteger := PPessoa.telefone;
  LQuery.ParamByName('ativo').AsBoolean := PPessoa.ativo;
  LQuery.ParamByName('criadoEm').AsDateTime := PPessoa.criadoEm;
  LQuery.ParamByName('criadoPor').AsString := PPessoa.criadoPor;
  LQuery.ParamByName('alteradoEm').AsDateTime := PPessoa.alteradoEm;
  LQuery.ParamByName('alteradoPor').AsString := PPessoa.alteradoPor;
  LQuery.ExecSQL();

  FreeAndNil(LQuery);
end;
end.
