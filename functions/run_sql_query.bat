:: =======================================================================================
:: Main
::: Run a sql query on the server

::: The advantage of running this instead of calling sqlcmd directly is to check variables
::: and automatically create the necessary folders.

:: Global variables
::: server

:: Input variables
::: 1. db_name:  database to run script in
::: 2. log_file: log file for current operation
::: 3. query:    query to run (enclosed in "")
:: =======================================================================================
setlocal

set db_name=%~1
set log_file=%~2
set log_folder=%~dp2
set query=%~3

call :check_variables 3 %*

echo %db_name% - running query
if "%verbose%" == "true" ( echo   %query% )

sqlcmd -S %server% -d %db_name% -E -m 1 -Q"%query%" -o "%log_file%"

endlocal
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
call %functions_folder%\variable.bat :check_variable server

:: Validate input variables
call %functions_folder%\variable.bat :check_variable  db_name
call %functions_folder%\variable.bat :check_extension log_file log
call %functions_folder%\variable.bat :create_folder   log_folder
call %functions_folder%\variable.bat :check_variable  query

goto:eof
:: =======================================================================================
