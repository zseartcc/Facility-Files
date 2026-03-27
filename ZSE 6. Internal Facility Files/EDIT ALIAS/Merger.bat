@echo off

for /f %%A in ('powershell -NoProfile -Command ^
  "(Invoke-RestMethod 'https://airac.net/api/v1/airac/current').data.cycle"') do set AIRAC=%%A

copy *.txt "..\ZSE_ALIASES_%AIRAC%.txt"