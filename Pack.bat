set HOME=d:\temp\ArchivarServer

del %GITHOME%\Archivar\bin\server\www_dnl\dnl\server.zip

xcopy /S %GITHOME%\Archivar\bin\Server\*.* %HOME%\

rd /S /Q %HOME%\log
del /S %HOME%\.gitignore
del %HOME%\ArchivServer.exe.ini

powershell Compress-Archive -LiteralPath 'd:\temp\ArchivarServer' -DestinationPath "d:\temp\Server.zip"
copy d:\temp\Server.zip %GITHOME%\Archivar\bin\server\www_dnl\dnl

del %GITHOME%\Archivar\bin\server\www_dnl\dnl\ArchivarSandbox.zip
powershell Compress-Archive -LiteralPath $Env:GITHOME\Archivar\ArchivarSandbox -DestinationPath $Env:GITHOME\Archivar\bin\server\www_dnl\dnl\ArchivarSandbox.zip

del d:\temp\server.zip
rd /S /Q d:\temp\ArchivarServer
