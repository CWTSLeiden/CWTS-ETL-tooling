:: =======================================================================================
:: Main
::: Run all sql scripts in a folder on the server

:: Global variables
::: server

:: Input variables
::: 1. db_name:           database to run script in
::: 2. sql_folder:        folder containing sql scripts to run
::: 3. log_folder:        log folder for current operation
::: 4. sqlcmd_variables:  variables to be passed to sqlcmd
:::                       (including -v, enclosed in "" because of spaces)
:: =======================================================================================
setlocal

set db_name=%~1
set sql_folder=%~2
set log_folder=%~3
set sqlcmd_variables=%~4

call :check_variables 4 %*

echo %db_name% - running all scripts in %sql_folder%

for /f %%f in ('dir /b /ON "%sql_folder%\*.sql"') do (
    call %functions_folder%\run_sql_script.bat ^
        %db_name% ^
        %sql_folder%\%%f ^
        %log_folder% ^
        "%sqlcmd_variables%"

    for %%l in ("%log_folder%\%%~nf.error") do (
        if %%~zl GTR 0 (
            call %functions_folder%\echo.bat :error "Error while running %%~nxf"
            call %functions_folder%\echo.bat :error "check error file: %%~l"
            if not "%sql_interrupt_on_error%" == "false" (goto:eof)
        )
    )
)
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_variables
:: =======================================================================================

:: Set functions_folder to location of this script
set functions_folder=%~dp0

:: Check number of input variables
call %functions_folder%\variable.bat :check_parameters %*

:: Validate global variables
call %functions_folder%\variable.bat :check_variable db_name

:: Validate input variables
call %functions_folder%\variable.bat :check_folder     sql_folder
call %functions_folder%\variable.bat :create_folder    sql_log_folder
call %functions_folder%\variable.bat :default_variable sql_interrupt_on_error true

goto:eof
:: =======================================================================================
