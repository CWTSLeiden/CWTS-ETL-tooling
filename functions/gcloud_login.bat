@echo off

:: =======================================================================================
:: Main
::: Gcloud utility login checker.
::: This script checks if the user is logged into the gcloud program and prompt to login
::: if the user is not authenticated

:: Executables
::: gcloud_exe
:: =======================================================================================

call :check_variables

:validate_login
set "account="
for /f "delims=" %%a in ('gcloud auth list --filter=status:ACTIVE --format="value(account)" 2^>nul') do set "account=%%a"

if defined ACCOUNT (
    call %functions_folder%\echo.bat :verbose "Logged into Google Cloud as %account%"
    goto:eof
) else (
    call %functions_folder%\echo.bat :error "Not logged into Google Cloud"
    %gcloud_exe% auth login
    goto:validate_login
)
goto:eof

:: =======================================================================================
:check_variables
:: =======================================================================================

call %functions_folder%\variable.bat :check_variable gcloud_exe

goto:eof
:: =======================================================================================
