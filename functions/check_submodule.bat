@echo off
:: =======================================================================================
:: Main
::: Check if a git submodule exists.

:: Global variables
::: root_folder

:: Input variables
::: 1. submodule_name:        name of the submodule
::: 2. (optional) if_missing: if not set throw an error and exit
:::                           if set to continue_if_missing the script will only show a warning
:::                           if set to a string, show that message and exit
:: =======================================================================================

setlocal

set submodule_name=%~1
set if_missing=%~2

call :check_variables

if not exist "%root_folder%\%submodule_name%\.git" (
    goto:exit
) else (
    call %functions_folder%\echo.bat :verbose "Submodule available: %submodule_name%"
)
goto:eof
:: =======================================================================================


:: =======================================================================================
:exit
:: =======================================================================================

call %functions_folder%\echo.bat :error "Submodule not found: %submodule_name%"
if not defined if_missing (
    call %functions_folder%\variable.bat :exit
) else if "%if_missing%" == "continue_if_missing" (
    goto:eof
) else (
    call %functions_folder%\echo.bat :error "%if_missing%"
    call %functions_folder%\variable.bat :exit
)
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_variables
:: =======================================================================================

:: Set functions_folder to location of this script
set functions_folder=%~dp0

:: Validate global variables
call %functions_folder%\variable.bat :check_variable root_folder

:: Validate input variables
call %functions_folder%\variable.bat :check_variable submodule_name

goto:eof
:: =======================================================================================
