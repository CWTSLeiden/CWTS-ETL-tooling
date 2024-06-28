@echo off

:: =======================================================================================
:: Main
::: Utilities to store or read credentials.
::: This function is a direct copy from etl-tooling/functions/credentials.bat
::: This script should run standalone, do not use functions from variable.bat

:: Functions
::: write_sa_credentials
::: write_vuw_credentials
::: read_sa_credentials
::: read_vuw_credentials
::: read_credentials
::: az_login

:: Input variables
::: 1. (prompt) function: Run function from this file

:: Executables
::: powershell_exe

:: Returns
::: :read function sets %user% and %pass% variables
:: =======================================================================================

set function=%~1
set credentials_file=%~2
set credentials_folder=%~dp2

call :check_variables

if defined function (
    call %function%
    goto:eof
) else (
    call :choose_function
)
goto:eof

:: =======================================================================================
:write_vuw_credentials
:: Prompt for a username and store it in an unencrypted text file.
:: If no name is provided vuw\%USERNAME% is used.
:: Use to run functions under a different user account (not recommended).
:: =======================================================================================
set default_user=vuw\%USERNAME%
set /p "user=Set user name [%default_user%]: "
echo.
if "%user%" == "" (
    echo %default_user% > "%vuw_credentials%"
) else (
    echo %user% > "%vuw_credentials%"
)

echo Credentials saved as %vuw_credentials%
call :read_vuw_credentials

goto:eof
:: =======================================================================================

:: =======================================================================================
:read_vuw_credentials
:: Read vuw credentials from file and store them in %user% and %backup_credentials%.
:: Use vuw\%USERNAME% if no file exists.
:: =======================================================================================
set user=vuw\%USERNAME%
if exist "%vuw_credentials%" (
    set /p user=<"%vuw_credentials%"
    call :verbose "Using VUW credentials from %vuw_credentials%"
) else (
    call :verbose "Using login username"
)
if not "%user:~0,3%" == "vuw" (
    call :exit "Credentials in %vuw_credentials% not valid"
)
set backup_credentials=%user%
goto:eof
:: =======================================================================================

:: =======================================================================================
:write_sa_credentials
:: Prompt for a username and password and store it in an encrypted text file.
:: Can only be decrypted on the same machine.
:: =======================================================================================
call %powershell_exe% "Get-Credential | Export-CliXml" "%sa_credentials%"

echo.
echo Credentials saved as %sa_credentials%

call :read_sa_credentials

goto:eof
:: =======================================================================================

:: =======================================================================================
:read_sa_credentials
:: Read sa credentials from file and store them in %user%, %pass% and %backup_credentials%.
:: =======================================================================================
if not exist "%sa_credentials%" (
    call :exit "Credentials file %sa_credentials% does not exist"
)
for /f %%i in ('%powershell_exe% "( Import-CliXml '%sa_credentials%' ).UserName"') do set user=%%i
for /f %%i in ('%powershell_exe% "( Import-CliXml '%sa_credentials%' ).GetNetworkCredential().Password"') do set pass=%%i
call :verbose "Using sa credentials from %sa_credentials%"
if not "%user:~0,2%" == "sa" (
    call :exit "Credentials in %sa_credentials% not valid"
)
set backup_credentials=%user%:%pass%
goto:eof
:: =======================================================================================

:: =======================================================================================
:read_credentials
:: Read sa credentials if the file exists, otherwise read vuw credentials.
:: =======================================================================================
if exist "%sa_credentials%" (
    call :read_sa_credentials
) else (
    call :read_vuw_credentials
)
goto:eof
:: =======================================================================================

:: =======================================================================================
:az_login
:: Try to login using the Powershell Az module
:: =======================================================================================
call %powershell_exe% "Import-Module %~dp0azcopy; AzLogin"
call %powershell_exe% "Import-Module %~dp0azcopy; $auth = AzTestAuth"
if %errorlevel% GTR 0 (
    call :exit "error   - Not logged into Azure"
)
goto:eof
:: =======================================================================================

:: =======================================================================================
:choose_function
:: =======================================================================================
echo Choose step to run
echo Option 1: write vuw credentials
echo Option 2: read vuw credentials
echo Option 3: write sa credentials
echo Option 4: read sa credentials
echo Option 5: read any credentials
echo.
set /p choice="Enter option: "
echo.
if "%choice%" == "1" ( set run=1 && call :write_vuw_credentials )
if "%choice%" == "2" ( set run=1 && call :read_vuw_credentials )
if "%choice%" == "3" ( set run=1 && call :write_sa_credentials )
if "%choice%" == "4" ( set run=1 && call :read_sa_credentials )
if "%choice%" == "5" ( set run=1 && call :read_credentials )
if not defined run (
    goto:choose_function
)
echo User: %user%
echo.
goto:eof
:: =======================================================================================

:: =======================================================================================
:check_variables
:: =======================================================================================
set "powershell_exe=Powershell.exe -NoProfile -Command"

if defined "%credentials_file%" (
    set "sa_credentials=%credentials_file%"
    set "vuw_credentials=%credentials_file%"
)

if not defined credentials_folder (
    set "credentials_folder=%userprofile%\auth"
)
if not defined vuw_credentials (
    set "vuw_credentials=%credentials_folder%\vuw.txt"
)
if not defined sa_credentials (
    set "sa_credentials=%credentials_folder%\sa.xml"
)

goto:eof
:: =======================================================================================


:: =======================================================================================
:verbose
:: =======================================================================================
set message=%~1
echo [93m%message%[0m
goto:eof
:: =======================================================================================

:: =======================================================================================
:exit
:: Prompt the user to exit the script. This also exits the script that calls this function.
:: =======================================================================================
:: prompts the user to stop the entire procedure
setlocal
set error_message=%~1
if defined error_message (
    echo error   - %error_message%
)
cmd /c exit -1073741510
endlocal
goto:eof
:: =======================================================================================
