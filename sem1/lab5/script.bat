@echo off
setlocal enabledelayedexpansion
chcp 1251

rem �������� �� ������� ���������
if "%~1"=="" (
    echo �� ������ ���� � �����
    exit /b 1
)

rem ���������� ���� � ����� ������� ��� ������ ��������
set "DIR=%~1"

rem �������� ������������� �����
if not exist "%DIR%" (
    echo ������ ����� ���
    exit  1
)

if exist log.txt del log.txt
if exist "%tempFile%" del "%tempFile%"
set "tempFile=%DIR%\temp_log.txt"
rem ������� ��� .txt ����� � ��������� 5-� ������
for /r "%DIR%" %%f in (*.txt) do (
    set "lineCounter=0"
    set "line="

    rem ������ ������ �� �������� ����� � ��������� 5-� ������
    for /f "usebackq delims=" %%l in ("%%f") do (
        set /a lineCounter+=1
        if !lineCounter! equ 5 (
            set "line=%%l"
            echo !line! >> "%tempFile%"
            rem ��������� ���������� ���� ����� ���������� 5-� ������
            break
        )
    )
)

        

rem ��������� ������ � ���������� � log.txt
sort "%tempFile%" /o log.txt
del "%tempFile%"
echo ��������� ������� � log.txt