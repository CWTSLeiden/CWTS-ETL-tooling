:: =======================================================================================
:: Main
::: Notify a user about a database process via email or optionally via a Teams channel.

:: Global variables
::: db_owner
::: (optional) teams_channel_email
::: (optional) notifications

:: Input variables
::: 1. db_name: name of the database that that the operation is linked to.
::: 2. process_name: name of the process that the notification is about.

:: Executables
::: powershell_exe
:: =======================================================================================
setlocal

set db_name=%~1
set process_name=%~2

if not "%notifications%" == "true" (
    echo E-mail notifications are off
    goto:eof
)

call :check_variables 2 %*

:: Notify db_owner
call %powershell_exe% "& %functions_folder%\notify\notify.ps1" ^
    "-db '%db_name%'" ^
    "-user '%db_owner%'" ^
    "-process '%process_name%'" ^
    "-only_on_error" ^
    "%teams_channel_email_arg%" ^
    "%verbose_arg%"

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_variables
:: =======================================================================================

:: Set functions_folder to location of this script
set functions_folder=%~dp0
:: set program_folder to relative location of this script
set programs_folder=%~dp0\..\programs

:: get executable paths
call %programs_folder%\executables.bat

:: Check number of input variables
call %functions_folder%\variable.bat :check_parameters %*

:: Validate global variables
call %functions_folder%\variable.bat :check_variable db_owner

:: Validate input variables
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :check_variable process_name

if defined teams_channel_email (
    set teams_channel_email_arg=-teams_channel_email %teams_channel_email%
)
if "%verbose%" == "true" (
   set verbose_arg=-Verbose
)

goto:eof
:: =======================================================================================
