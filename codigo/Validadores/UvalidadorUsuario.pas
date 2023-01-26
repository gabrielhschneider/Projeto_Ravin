unit UvalidadorUsuario;

interface

uses UUsuario;

type TValidadorUsuario = class
  private

  protected

  public
  class procedure Validar(PSenhaConfirmacao: String; PUsuario: TUsuario);
end;

implementation

uses
  System.SysUtils;

{ TValidadorUsuario }

class procedure TValidadorUsuario.Validar(PSenhaConfirmacao: String; PUsuario: TUsuario);
begin
  if PUsuario.login.IsEmpty then begin
    raise Exception.Create('O campo login não pode ser vazio');
  end;

  if PUsuario.Senha.IsEmpty then begin
    raise Exception.Create('O campo senha não pode ser vazio');
  end;

  if PSenhaConfirmacao <> PUsuario.senha then begin
    raise Exception.Create('A senha e a confirmação devem ser iguais');
  end;

end;

end.
