unit UFormUtils;

interface

uses
  Vcl.Forms;

type
  TFormUtils = class

    private

    protected

    public

      class procedure SetarFormPrincipal(PNovoFormulario: TForm);
  end;

implementation

{ TFormUtils }

class procedure TFormUtils.SetarFormPrincipal(PNovoFormulario: TForm);
var
  tmpMain: ^TCustomForm;
begin
  tmpMain := @Application.Mainform;
  tmpMain^ := PNovoFormulario;
end;
end.
