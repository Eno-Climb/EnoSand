@echo off
echo DevHubから取り出したMetaデータをコンバートします。
powershell -NoProfile -ExecutionPolicy Unrestricted .\confirmMeta.ps1
echo 完了しました！
pause > nul
exit