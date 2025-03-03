' Run install-scripts.bat file without elevated privileges
Set objShell = CreateObject("WScript.Shell")
objShell.Run "test2.bat", 0, False

' Wait for a few seconds to ensure the first batch file has started
WScript.Sleep 2000

' Run finish.bat file as administrator
Set objShell = CreateObject("Shell.Application")
objShell.ShellExecute "finish.bat", "", "", "runas", 1
