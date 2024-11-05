msg * "Download Firebird"
curl -L "https://github.com/FirebirdSQL/firebird/releases/download/v4.0.5/Firebird-4.0.5.3140-0-Win32.exe" --output C:\users\WDAGUtilityAccount\Downloads\Firebird.exe

C:\users\WDAGUtilityAccount\Downloads\Firebird.exe

msg * "Download Archivar"
curl -L "http://target42.de:8090/server.zip" --output C:\users\WDAGUtilityAccount\Downloads\Server.zip
tar -xf C:\users\WDAGUtilityAccount\Downloads\Server.zip -C C:\users\WDAGUtilityAccount\Desktop

cd C:\users\WDAGUtilityAccount\Desktop\ArchivarServer\

attrib +H FDConnectionDefs.ini
attrib +H libeay32.dll
attrib +H libzmq-win32.dll
attrib +H ssleay32.dll

C:\users\WDAGUtilityAccount\Desktop\ArchivarServer\Setup.exe
