:: =======================================================================================
:: Main
::: Run a sql script on the server
::: The advantage of running this instead of calling sqlcmd directly is to check variables
::: and automatically create the necessary folders.

:: Global variables
::: server

:: Input variables
::: 1. db_name:           database to run script in
::: 2. sql_file:              sql script to run (including path and extension)
::: 3. db_sql_log_folder: log folder for current operation
::: 4. sqlcmd_variables:  variables to be passed to sqlcmd
:::                       (including -v, enclosed in "" because of spaces)
:: =======================================================================================
setlocal

set db_name=%~1
set sql_file=%~2
set sql_file_name=%~n2
set db_sql_log_folder=%~3
set sqlcmd_variables=%~4

call :check_variables 4 %*

echo %db_name% - running %sql_file_name% sql script

sqlcmd -S %server% -d %db_name% -E -m 1 -i"%sql_file%" -o "%db_sql_log_folder%\%sql_file_name%.log" %sqlcmd_variables%

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
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :check_file sql_file
call %functions_folder%\variable.bat :check_extension sql_file sql
call %functions_folder%\variable.bat :create_folder db_sql_log_folder

goto:eof
:: =======================================================================================
