@echo off
:: =======================================================================================
:: Main
::: Check if a git submodule exists.

:: Global variables
::: root_folder

:: Input variables
::: 1. submodule_name:        name of the submodule
::: 2. (optional) if_missing: if not set throw a warning and continue
:::                           if set to exit_if_missing the script will throw a fatal exeption
:::                           if set to a string, show that message and continue
:: =======================================================================================

setlocal

set submodule_name=%~1
set if_missing=%~2

call :check_variables

if not exist "%root_folder%\%submodule%\.git" (
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
if %if_missing% == exit_if_missing (
    call %functions_folder%\variable.bat :exit
if defined if_missing (
    echo %if_missing%
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
