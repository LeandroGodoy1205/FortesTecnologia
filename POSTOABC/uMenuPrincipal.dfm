object FMenuPrincipal: TFMenuPrincipal
  Left = 0
  Top = 0
  Caption = 'Posto ABC - Menu Principal'
  ClientHeight = 440
  ClientWidth = 699
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 344
    Top = 48
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Combustveis1: TMenuItem
        Caption = 'Combust'#237'veis'
        OnClick = Combustveis1Click
      end
      object Tanques1: TMenuItem
        Caption = 'Tanques'
        OnClick = Tanques1Click
      end
      object Bombas1: TMenuItem
        Caption = 'Bombas'
        OnClick = Bombas1Click
      end
    end
    object Movimentaes1: TMenuItem
      Caption = 'Movimenta'#231#245'es'
      object Vendas1: TMenuItem
        Caption = 'Vendas'
        OnClick = Vendas1Click
      end
    end
    object Relatorios1: TMenuItem
      Caption = 'Relatorios'
      object Abastecimentos1: TMenuItem
        Caption = 'Abastecimentos'
        OnClick = Abastecimentos1Click
      end
    end
  end
end
