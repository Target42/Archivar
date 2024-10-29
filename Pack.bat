set HOME=d:\temp\ArchivarServer
xcopy /S %GITHOME%\Archivar\bin\Server\*.* %HOME%\
rd /S /Q %HOME%\log
rm %HOME%\.gitignore
rm %HOME%\ArchivServer.exe.ini
attrib +H %HOME%\FDConnectionDefs.ini
attrib +H %HOME%\libeay32.dll
attrib +H %HOME%\libzmq-win32.dll
attrib +H %HOME%\ssleay32.dll
powershell Compress-Archive -LiteralPath 'd:\temp\ArchivarServer' -DestinationPath "d:\temp\Server.zip"
copy d:\temp\Server.zip %GITHOME%\Archivar\bin\server\www_dnl
del d:\temp\server.zip
rd /S /Q d:\temp\ArchivarServer