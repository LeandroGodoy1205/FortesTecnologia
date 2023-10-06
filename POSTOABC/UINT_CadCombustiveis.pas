unit UINT_CadCombustiveis;

interface

Uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadCombustiveis;

type
  TInt_CadCombustiveis = Class(TComponent)
  Private
    gForm: TfCadCombustiveis;
  Public
    Procedure FormShow;
    Procedure FormClose;
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;
    Procedure DBActionWindow(Acao:Integer);
  End;

var
  Int_CadCombustiveis: TInt_CadCombustiveis;

implementation

uses UDMSRV_Server;

//Criar e Destruir a Interface
Constructor TInt_CadCombustiveis.Create(AOwner:TComponent);
Begin
    inherited create(AOwner);
    gForm:= AOwner as TFCadCombustiveis;
End;

procedure TInt_CadCombustiveis.DBActionWindow(Acao: Integer);
begin
    //Ações em Tela iniciadas por BD
    //1 = Novo
    //2 = Editar
    //3 = Gravar
    //4 = Remover
    //5 = Cancelar
    Case Acao Of
      1:Begin //inserir
          //CONFIGURA AÇAO HABILITA/DESABILITA BOTOES
          gForm.btnNovo.Enabled    :=False;
          gForm.btnGravar.Enabled   :=True;
          gForm.btnEditar.Enabled   :=False;
          gForm.btnCancelar.Enabled :=True;
          gForm.btnExcluir.Enabled  :=False;

        End;
      2:Begin
          gForm.btnNovo.Enabled    :=False;
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
                gForm.FDCombustivel.post;
                gForm.FDTransaction.CommitRetaining;
                gForm.FDCombustivel.Refresh;
             Except on E:Exception Do
                Begin
                  DMSRV_Server.FDConn.Rollback;
                  MessageDlg('Problemas ao gravar o registro.'+#13#10+
                  'Erro: '+E.Message, mtError, [mbOk], 0);
                End;
             end;

        End;
      4:Begin
          if gForm.FDCombustivel.RecordCount <> 0 then
            begin
              If MessageDlg('Deseja remover esta cadastro? (após a confirmação, a operação não poderá ser cancelada)', mtConfirmation, [mbYes, mbNo],0) = mrYes Then
                 Begin
                   Try
                     gForm.FDCombustivel.Delete;
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

Destructor TInt_CadCombustiveis.Destroy;
Begin
    inherited destroy;
End;
//-----------------------------

//FormShow
Procedure TInt_CadCombustiveis.FormShow;
Begin
    With gForm Do
      Begin
          //Pagina Inicial do PageControl
          pcgMain.TabIndex:=0;
          Try
            FDCombustivel.open;
          Except on E:Exception Do
            Begin
              MessageDlg('Erro ao Carregar as Tabelas de Combustíveis!'+#13#10+#13#10+
                         'Mensagem Erro:'+#13#10+
                         'Erro: '+E.Message,mtError,[mbOK],0);
              Exit;
            End;
          End;
      End;
End;

//FormClose
Procedure TInt_CadCombustiveis.FormClose;
Begin
    With gForm Do
      Begin
         { With Int_GenERP Do
            Begin
              //Fechar Tabelas
              //FecharTabelas(DM_CadBancos);
            End;}
      End;
End;

end.
