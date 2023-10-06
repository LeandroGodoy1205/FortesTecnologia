object DMSRV_Server: TDMSRV_Server
  OldCreateOrder = False
  Height = 194
  Width = 361
  object FDConn: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=localhost'
      'Database=C:\Sistemas\FortesTecnologia\POSTOABC.FDB'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 40
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_1_5\bin\fbclient.dll'
    Left = 152
    Top = 40
  end
end
