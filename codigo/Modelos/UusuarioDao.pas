unit UusuarioDao;

interface

uses
  UUsuario,
  FireDAC.Comp.Client,
  UdmRavin,
  System.SysUtils,
  System.Generics.Collections;

type TUsuarioDAO = class
  private

  protected

  public
  function BuscarTodosUsuarios(): TList<TUsuario>;
  function BuscarUsuarioPorLoginSenha(
    PLogin: String; PSenha: String): TUsuario;
  procedure InserirUsuario(PUsuario: TUsuario);
end;

implementation

{ TUsuarioDAO }

function  TUsuarioDAO.BuscarTodosUsuarios(): TList<TUsuario>;
var
  LQuery : TFDQuery;
  LUsuario : TUsuario;
  LListaUsuarios : TList<Tusuario>;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text := 'SELECT * FROM ravin.usuario;';
  LQuery.Open();
  LQuery.First();

  LListaUsuarios := TList<Tusuario>.Create;
  if not LQuery.isEmpty then begin
    while not LQuery.Eof do begin
      LUsuario := TUsuario.Create();

      LUsuario.id := LQuery.FieldByName('id').AsInteger;
      LUsuario.login := LQuery.FieldByName('login').AsString;
      LUsuario.senha := LQuery.FieldByName('senha').AsString;
      LUsuario.pessoaId := LQuery.FieldByName('pessoaId').AsInteger;
      LUsuario.criadoEm := LQuery.FieldByName('criadoEm').AsDateTime;
      LUsuario.criadoPor := LQuery.FieldByName('criadoPor').AsString;
      LUsuario.alteradoEm := LQuery.FieldByName('alteradoEm').AsDateTime;
      LUsuario.alteradoPor := LQuery.FieldByName('alteradoPor').AsString;

      LListaUsuarios.Add(LUsuario);
      LQuery.Next;

    end;
  end;

  Result := LListaUsuarios;

end;

function TUsuarioDAO.BuscarUsuarioPorLoginSenha(PLogin,
  PSenha: String): TUsuario;
var
  LQuery : TFDQuery;
  LUsuario : TUsuario;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text := 'SELECT * FROM usuario ' +
                     'WHERE login = :login AND senha = :senha';
  LQuery.ParamByName('login').AsString := PLogin;
  LQuery.ParamByName('senha').AsString := PSenha;
  LQuery.Open();

  LUsuario := nil;

  if not LQuery.isEmpty then begin
    LUsuario := TUsuario.Create();
    LUsuario.id := LQuery.FieldByName('id').AsInteger;
    LUsuario.login := LQuery.FieldByName('login').AsString;
    LUsuario.senha := LQuery.FieldByName('senha').AsString;
    LUsuario.pessoaId := LQuery.FieldByName('pessoaId').AsInteger;
    LUsuario.criadoEm := LQuery.FieldByName('criadoEm').AsDateTime;
    LUsuario.criadoPor := LQuery.FieldByName('criadoPor').AsString;
    LUsuario.alteradoEm := LQuery.FieldByName('alteradoEm').AsDateTime;
    LUsuario.alteradoPor := LQuery.FieldByName('alteradoPor').AsString;
  end;

  LQuery.Close();
  FreeAndNil(LQuery);
  Result := LUsuario;
end;

procedure TUsuarioDAO.InserirUsuario(PUsuario: TUsuario);
var
  LQuery : TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Add('INSERT INTO usuario ');
  LQuery.SQL.Add(' (login, senha, pessoaId, criadoEm, ');
  LQuery.SQL.Add(' criadoPor, alteradoEm, alteradoPor');
  LQuery.SQL.Add(' VALUES (:login, :senha, :pessoaId, :criadoEm, ');
  LQuery.SQL.Add(' :criadoPor, :alteradoEm, :alteradoPor');

  LQuery.ParamByName('login').AsString := PUsuario.login;
  LQuery.ParamByName('senha').AsString := PUsuario.senha;
  LQuery.ParamByName('pessoaId').AsInteger := PUsuario.pessoaId;
  LQuery.ParamByName('criadoEm').AsDateTime := PUsuario.criadoEm;
  LQuery.ParamByName('criadoPor').AsString := PUsuario.criadoPor;
  LQuery.ParamByName('alteradoEm').AsDateTime := PUsuario.alteradoEm;
  LQuery.ParamByName('alteradoPor').AsString := PUsuario.alteradoPor;
  LQuery.ExecSQL();

  FreeAndNil(LQuery);
end;
end.
