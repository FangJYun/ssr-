@echo off
setlocal enabledelayedexpansion

:: ����˿ں�
echo ����Ҫ��ѯ�Ķ˿ں�:
set /p port=

:: ���Ҷ˿ڶ�Ӧ��PID
for /f "tokens=5" %%i in ('netstat -ano ^| findstr :%port%') do (
    set pid=%%i
    goto :FoundPID
)

echo û���ҵ���˿� %port% ��Ӧ�Ľ���!
pause
exit /b

:FoundPID
echo �˿� %port% ��Ӧ�Ľ���PID: %pid%

:: ����PID��Ӧ�Ľ�������
for /f "tokens=1 delims=," %%a in ('tasklist /FI "PID eq %pid%" /FO CSV ^| findstr /V "Image Name"') do (
    set processName=%%~a
)

echo PID: %pid% ��Ӧ�Ľ�������: %processName%


:: �Ƿ���ֹ����
echo �Ƿ���ֹ�ý��� (y/n):
set /p kill=

if /i "%kill%"=="y" (
	taskkill /F /PID %pid%
	echo ����ֹ����:%pid%-%processName%
) else (
    echo δ��ֹ����:%pid%-%processName%
)

pause
exit /b