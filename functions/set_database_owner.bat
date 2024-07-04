:: =======================================================================================
:: Main
::: Set the owner of the database

:: Global variables
::: server
::: user: username of an sql sa account
::: pass: password of an sql sa account

:: Input variables
::: 1. db_name
::: 2. owner
::: 3. sql_log_folder: log folder for this function
:: =======================================================================================
setlocal

set db_name=%~1
set owner=%~2
set sql_log_folder=%~3

call :check_variables 3 %*

echo %db_name% - Set database owner to [%owner%]

if defined pass (
    sqlcmd -S %server% -d %db_name% -U %user% -P %pass% -m 1 -Q"exec sp_changedbowner [%owner%]" -o "%sql_log_folder%\set_database_owner.log"
) else (
    sqlcmd -S %server% -d %db_name% -E -m 1 -Q"exec sp_changedbowner [%owner%]" -o "%sql_log_folder%\set_database_owner.log"
)

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
call %functions_folder%\variable.bat :check_variable user

:: Validate input variables
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :check_variable owner
call %functions_folder%\variable.bat :create_folder  sql_log_folder

goto:eof
:: =======================================================================================
