@echo off
echo.
echo.
echo.
echo   Compactando pasta Exemplo 02...
echo.
echo.
echo.
IF EXIST C:\Users\hquinteiro\Downloads\dashLograsterio.zip DEL C:\Users\hquinteiro\Downloads\PILL_TABLE.zip 
echo.
echo.
echo.
"C:\Program Files\WinRAR\winrar" a -r -afzip C:\Users\hquinteiro\Downloads\PILL_TABLE.zip  *.*
echo.
echo.
echo.
dir C:\Users\hquinteiro\Downloads\dashLograsterio.zip

