:: =======================================================================================
:: Main
::: Read or write credentials from an encrypted file

:: Input variables
::: 1. function:         can be :read or :write
::: 2. credentials_file: file to read from or write to

:: Executables
::: powershell_exe

:: Returns
::: :read function sets %user% and %pass% variables
:: =======================================================================================

set function=%~1
set credentials_file=%~2

call :check_variables 2 %*

call %function%

goto:eof
:: =======================================================================================


:: =======================================================================================
:write
:: =======================================================================================
call %powershell_exe% "Get-Credential | Export-CliXml" "%credentials_file%"

echo.
echo Credentials saved as %credentials_file%

goto:eof
:: =======================================================================================


:: =======================================================================================
:read
:: =======================================================================================
for /f %%i in ('%powershell_exe% "( Import-CliXml '%credentials_file%' ).UserName"') do set user=%%i
for /f %%i in ('%powershell_exe% "( Import-CliXml '%credentials_file%' ).GetNetworkCredential().Password"') do set pass=%%i
if not defined user (
    echo error   - credentials not read
    call %functions_folder%\variable.bat :exit
)
call %functions_folder%\echo.bat :verbose "credentials user read: %user%"
if defined pass (
        call %functions_folder%\echo.bat :verbose "credentials password read"
) else (
        call %functions_folder%\echo.bat :verbose "credentials have no password"
)
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_variables
:: =======================================================================================

:: set functions_folder to location of this script
set functions_folder=%~dp0
:: set program_folder to relative location of this script
set programs_folder=%~dp0\..\programs

:: get executable paths
call %programs_folder%\executables.bat

:: check number of input parameters
call %functions_folder%\variable.bat :check_parameters %*

:: validate input variables
call %functions_folder%\variable.bat :check_variable credentials_file
call %functions_folder%\variable.bat :check_variable function

goto:eof
:: =======================================================================================
