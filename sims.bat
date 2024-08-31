@echo off

::admin getter code from https://stackoverflow.com/questions/1894967/how-to-request-administrator-access-inside-a-batch-file
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:-------------------------------------- 
    
echo Downloading the modified sims exe from http://www.awesomeexpression.com/sims-1-no-cdplay-sims-1-on-windows-10.html
powershell "Import-Module BitsTransfer; Start-BitsTransfer 'http://www.awesomeexpression.com/uploads/2/0/6/0/20609372/sims.exe' '%USERPROFILE%'"
echo copying the modified exe to the sims directory
xcopy /y "%USERPROFILE%\sims.exe" "C:\Program Files (x86)\Maxis\The Sims\sims.exe"
echo adding registry keys to set compatibily mode and set the 16 bit color compatibily mode
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files (x86)\Maxis\The Sims\sims.exe" /t REG_SZ /d "WINXPSP3 16BITCOLOR RUNASADMIN" /f
echo Done! you may now launch the sims with (hopefully) no problems
echo You may now close this window
cmd /k