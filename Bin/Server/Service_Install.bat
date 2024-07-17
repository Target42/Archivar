@echo "Installiere den Service"
@powershell Start -File "ArchivServer.service.exe /install" -Verb RunAs -Wait
pause