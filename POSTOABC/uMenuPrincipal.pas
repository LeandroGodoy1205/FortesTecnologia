unit uMenuPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.Menus;

type
  TFMenuPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Combustveis1: TMenuItem;
    Tanques1: TMenuItem;
    Bombas1: TMenuItem;
    Movimentaes1: TMenuItem;
    Vendas1: TMenuItem;
    Relatorios1: TMenuItem;
    Abastecimentos1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure Combustveis1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Tanques1Click(Sender: TObject);
    procedure Bombas1Click(Sender: TObject);
    procedure Vendas1Click(Sender: TObject);
    procedure Abastecimentos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure RegistrarClasses;
  end;

var
  FMenuPrincipal: TFMenuPrincipal;

implementation

uses
  UDMSRV_Server, uCadCombustiveis, uCadTanques, uCadBombas, uVendas, uRelatorioAbastecimento;

{$R *.dfm}

procedure TFMenuPrincipal.Tanques1Click(Sender: TObject);
begin
  Application.CreateForm(TFCadTanques, FCadTanques);
  FCadTanques.show;
end;

procedure TFMenuPrincipal.Vendas1Click(Sender: TObject);
begin
  Application.CreateForm(TFVendas, FVendas);
  FVendas.show;
end;

procedure TFMenuPrincipal.Abastecimentos1Click(Sender: TObject);
begin
  Application.CreateForm(TfRelatorioAbastecimento, FRelatorioAbastecimento);
  FRelatorioAbastecimento.show;
end;

procedure TFMenuPrincipal.Bombas1Click(Sender: TObject);
begin
  Application.CreateForm(TFCadBombas, FCadBombas);
  FCadBombas.show;
end;

procedure TFMenuPrincipal.Combustveis1Click(Sender: TObject);
begin
  Application.CreateForm(TFCadCombustiveis, FCadCombustiveis);
  FCadCombustiveis.show;
end;

procedure TFMenuPrincipal.FormCreate(Sender: TObject);
begin
  RegistrarClasses();
end;

procedure TFMenuPrincipal.FormShow(Sender: TObject);
begin
  DMSRV_SERVER.VerificarConexao(1,Self);
end;

Procedure TFMenuPrincipal.RegistrarClasses;
Begin
  // Tela de Cadastro de Combustiveis
  RegisterClass(TFCadCombustiveis);
  // Tela de Cadastro de Tanques
  RegisterClass(TFCadTanques);
  // Tela de Cadastro de Bombas
  RegisterClass(TFCadBombas);
  // Tela de Cadastro de Vendas
  RegisterClass(TFVendas);
  // Tela de Filtro/Relatorio abastecimento
  RegisterClass(TfRelatorioAbastecimento);
end;

end.
