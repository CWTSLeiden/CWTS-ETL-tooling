:: =======================================================================================
:: Main
::: Apply page compression for a given database

:: Global variables
::: server
::: dba_db_name

:: Input variables
::: 1. db_name:        name of the database
::: 2. sql_log_folder: log folder for this function
:: =======================================================================================

setlocal

set db_name=%~1
set sql_log_folder=%~2

call :check_variables 2 %*

echo %db_name% - Apply page compression

sqlcmd -S %server% -d %db_name% -E -m 1 -Q"exec %dba_db_name%.dbo.apply_page_compression '%db_name%'" -o "%sql_log_folder%\apply_page_compression.log"

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
call %functions_folder%\variable.bat :check_variable dba_db_name

:: Validate input variables
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :create_folder sql_log_folder

goto:eof
:: =======================================================================================
