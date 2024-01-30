:: =======================================================================================
:: Main
::: Set access permissions for all users in the cwts permissions group.

:: Global variables
::: server
::: sql_cwts_group

:: Input variables
::: 1. db_name
::: 2. sql_log_folder
:: =======================================================================================
setlocal

set db_name=%~1
set sql_log_folder=%~2

set sql_scripts_folder=%~dp0\grant_access_cwts_group

call :check_variables 2 %*

echo %db_name% - Grant access to CWTS group

sqlcmd -S %server% -d %db_name% -m 1 -E ^
    -i "%sql_scripts_folder%\add_datareader.sql" ^
    -o "%sql_log_folder%\add_datareader.log" ^
    -v login=%sql_cwts_group%

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
call %functions_folder%\variable.bat :check_variable sql_cwts_group

:: Validate input variables
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :create_folder  sql_log_folder

goto:eof
:: =======================================================================================
