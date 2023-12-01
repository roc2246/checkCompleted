Set objShell = CreateObject("Wscript.Shell")

objShell.Run "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File ""C:\PowershellScripts\checkCompleted.ps1""", 0, True