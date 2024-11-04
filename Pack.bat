set HOME=d:\temp\ArchivarServer

del %GITHOME%\Archivar\bin\server\www_dnl\server.zip

xcopy /S %GITHOME%\Archivar\bin\Server\*.* %HOME%\

rd /S /Q %HOME%\log
del /S %HOME%\.gitignore
del %HOME%\ArchivServer.exe.ini

powershell Compress-Archive -LiteralPath 'd:\temp\ArchivarServer' -DestinationPath "d:\temp\Server.zip"
copy d:\temp\Server.zip %GITHOME%\Archivar\bin\server\www_dnl

del d:\temp\server.zip
rd /S /Q d:\temp\ArchivarServer
