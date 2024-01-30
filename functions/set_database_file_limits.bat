:: =======================================================================================
:: Main
::: Based on the size of the database, set the appropriate file limits on the database.

:: Global variables
::: server
::: etl_db_name

:: Input variables
::: 1. db_name
::: 2. sql_log_folder: log folder for this function
::: 3. (optional) mdf_file_limit: limit for the data-file of the database
:::    valid options are: unlimited, nGB, nMB, nKB
::: 4. (optional) ldf_file_limit: limit for the log-file of the database
:::    valid options are: unlimited, nGB, nMB, nKB
:: =======================================================================================
setlocal

set _n_params=0
for %%a in (%*) do set /a _n_params+=1

if "%_n_params%" == "2" (
    call :set_auto_limits %*
) else (
    call :set_explicit_limits %*
)
goto:eof
:: =======================================================================================


:: =======================================================================================
:set_auto_limits
:: Set database file limits based on current size
:: =======================================================================================
set db_name=%~1
set sql_log_folder=%~2

call :check_variables 2 %*

echo %db_name% - Set database auto file limits

sqlcmd -S %server% -d %db_name% -E -m 1 -Q"exec %dba_db_name%.dbo.set_database_file_limits '%db_name%'" -o "%sql_log_folder%\set_database_file_limits.log"

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:set_explicit_limits
:: Set database file limits based on explicit parameters
:: =======================================================================================
set db_name=%~1
set sql_log_folder=%~2
set mdf_file_limit=%~3
set ldf_file_limit=%~4

call :check_variables 4 %*
call %functions_folder%\variable.bat :check_variable mdf_file_limit
call %functions_folder%\variable.bat :check_variable ldf_file_limit

echo %db_name% - Set database file limits (mdf: %mdf_file_limit% - ldf: %ldf_file_limit%)

set _sql_set_mdf_limit=alter database %db_name% modify file (name = %db_name%, maxsize = %mdf_file_limit%)
set _sql_set_ldf_limit=alter database %db_name% modify file (name = %db_name%_log, maxsize = %ldf_file_limit%)
sqlcmd -S %server% -d %db_name% -E -m 1 -Q"%_sql_set_mdf_limit%; %_sql_set_ldf_limit%" -o "%sql_log_folder%\set_database_file_limits.log"

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
call %functions_folder%\variable.bat :check_variable etl_db_name

:: Validate input variables
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :create_folder  sql_log_folder

goto:eof
:: =======================================================================================
