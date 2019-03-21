@echo off
echo Go convert DevHub to Git Repository.
powershell -NoProfile -ExecutionPolicy Unrestricted .\confirmMeta.ps1
echo Finish!
pause > nul
exit