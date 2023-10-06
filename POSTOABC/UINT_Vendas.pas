unit UINT_Vendas;

interface

Uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uVendas;

type
  TInt_Vendas = Class(TComponent)
  Private
    gForm: TfVendas;
  Public
    Procedure FormShow;
    Procedure FormClose;
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;
    Procedure DBActionWindow(Acao:Integer);
  End;

var
  Int_Vendas: TInt_Vendas;

implementation

uses UDMSRV_Server;

//Criar e Destruir a Interface
Constructor TInt_Vendas.Create(AOwner:TComponent);
Begin
    inherited create(AOwner);
    gForm:= AOwner as TFVendas;
End;

procedure TInt_Vendas.DBActionWindow(Acao: Integer);
begin
    //A��es em Tela iniciadas por BD
    //1 = Novo
    //2 = Editar
    //3 = Gravar
    //4 = Remover
    //5 = Cancelar
    Case Acao Of
      1:Begin //inserir
          //CONFIGURA A�AO HABILITA/DESABILITA BOTOES
          gForm.btnNovo.Enabled     :=False;
          gForm.btnGravar.Enabled   :=True;
          gForm.btnEditar.Enabled   :=False;
          gForm.btnCancelar.Enabled :=True;
          gForm.btnExcluir.Enabled  :=False;

        End;
      2:Begin
          gForm.btnNovo.Enabled     :=False;
          gForm.btnGravar.Enabled   :=True;
          gForm.btnEditar.Enabled   :=False;
          gForm.btnCancelar.Enabled :=True;
          gForm.btnExcluir.Enabled  :=False;
        End;
      3:Begin
             gForm.btnNovo.Enabled     :=True;
             gForm.btnGravar.Enabled   :=False;
             gForm.btnEditar.Enabled   :=True;
             gForm.btnCancelar.Enabled :=False;
             gForm.btnExcluir.Enabled  :=True;
             Try
                gForm.FDVendas.post;
                gForm.FDTransaction.CommitRetaining;
                gForm.FDVendas.Refresh;
             Except on E:Exception Do
                Begin
                  DMSRV_Server.FDConn.Rollback;
                  MessageDlg('Problemas ao gravar o registro.'+#13#10+
                  'Erro: '+E.Message, mtError, [mbOk], 0);
                End;
             end;
        End;
      4:Begin
          if gForm.FDVendas.RecordCount <> 0 then
            begin
              If MessageDlg('Deseja remover este cadastro? (após a confirmação, a operação não poderá ser cancelada)', mtConfirmation, [mbYes, mbNo],0) = mrYes Then
                 Begin
                   Try
                     gForm.FDVendas.Delete;
                   Except on E:Exception Do
                     Begin
                        DMSRV_Server.FDConn.Rollback;
                        MessageDlg('Problemas ao remover o registro.'+#13#10+
                                   'Erro: '+E.Message, mtError, [mbOk], 0);
                      End;
                    end;
                 End;
            end;
        End;
      5:Begin
          gForm.btnNovo.Enabled     :=True;
          gForm.btnGravar.Enabled   :=False;
          gForm.btnEditar.Enabled   :=True;
          gForm.btnCancelar.Enabled :=False;
          gForm.btnExcluir.Enabled  :=True;
        End;
      6:Begin
        
        end;
    End;
end;

Destructor TInt_Vendas.Destroy;
Begin
    inherited destroy;
End;
//-----------------------------

//FormShow
Procedure TInt_Vendas.FormShow;
Begin
    With gForm Do
      Begin
          //Pagina Inicial do PageControl
          pcgMain.TabIndex:=0;
          Try
            FDVendas.open;
            FDBombas.Open;
            FDTanques.Open;
            FDCombustiveis.open;
          Except on E:Exception Do
            Begin
              MessageDlg('Erro ao Carregar as Tabelas de Combust�veis!'+#13#10+#13#10+
                         'Mensagem Erro:'+#13#10+
                         'Erro: '+E.Message,mtError,[mbOK],0);
              Exit;
            End;
          End;
      End;
End;

//FormClose
Procedure TInt_Vendas.FormClose;
Begin
    With gForm Do
      Begin
         FDVendas.Close;
         FDBombas.Close;
         FDTanques.Close;
         FDCombustiveis.Close;
      End;
End;

end.
