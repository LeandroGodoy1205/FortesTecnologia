program PostoABC;

uses
  Vcl.Forms,
  uMenuPrincipal in 'uMenuPrincipal.pas' {FMenuPrincipal},
  UDMSRV_Server in 'UDMSRV_Server.pas' {DMSRV_Server: TDataModule},
  uCadCombustiveis in 'uCadCombustiveis.pas' {fCadCombustiveis},
  uCadTanques in 'uCadTanques.pas' {fCadTanques},
  uCadBombas in 'uCadBombas.pas' {fCadBombas},
  uVendas in 'uVendas.pas' {fVendas},
  uRelatorioAbastecimento in 'uRelatorioAbastecimento.pas' {fRelatorioAbastecimento},
  UINT_CadBombas in 'UINT_CadBombas.pas',
  UINT_CadCombustiveis in 'UINT_CadCombustiveis.pas',
  UINT_CadTanques in 'UINT_CadTanques.pas',
  UINT_RelatorioAbastecimento in 'UINT_RelatorioAbastecimento.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMSRV_Server, DMSRV_Server);
  Application.CreateForm(TFMenuPrincipal, FMenuPrincipal);
  Application.Run;
end.
