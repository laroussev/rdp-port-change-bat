@echo off
title RDP Port Change

set /p PORT=New RDP Port:

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"$p=%PORT%; ^
if($p -lt 1 -or $p -gt 65535){Write-Host 'Invalid port'; exit 1}; ^
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name PortNumber -Value ([int]$p); ^
New-NetFirewallRule -DisplayName ('RDP Port ' + $p) -Direction Inbound -Protocol TCP -LocalPort $p -Action Allow -ErrorAction SilentlyContinue; ^
Restart-Service TermService -Force"

echo.
echo New Port %PORT% 
pause
