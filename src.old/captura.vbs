Set WshNetwork = CreateObject("WScript.Network")
WshNetwork.AddWindowsPrinterConnection "\\10.0.0.80\SAMSUNG"
WshNetwork.SetDefaultPrinter "\\10.0.0.80\SAMSUNG"
msgbox "Sucesso"