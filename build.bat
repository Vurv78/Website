@echo off


for /R %%F in (*.hx) do (
	if %%~nF == Main (
		:: Only build files named Main
		echo Building file %%~fF with size of %%~zF bytes
		haxe -dce full -p %%~dF%%~pF --python "%%~dF%%~pF%%~nF.py" -main "%%~nF"
	)
)
pause
