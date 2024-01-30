:: =======================================================================================
:: Main
::: 1. Drop all tables in the database
::: 2. Collect table/type information from multiple create_table.sql scripts
:::    by running the create_table.sql script and calling the stored procedure
:::    `create_tables_based_on_multiple_definitions` with a `0` parameter
::: 3. Run the unified create table statements that were collected from the previous step
:::    by calling the `create_tables_based_on_multiple_definitions` procedure with a `1`
:::    parameter to finish the process.

:: Global variables
::: server

:: Input variables
::: 1. db_name:        Name of the database.
::: 2. process_folder: Parent folder with multiple subfolders that
:::                    contain a create_table.sql script.
::: 3. sql_log_folder: Log folder for this script.
:: =======================================================================================
setlocal

set db_name=%~1
set process_folder=%~2
set sql_log_folder=%~3

call :check_variables 3 %*

echo %db_name% - dropping tables
sqlcmd -S %server% -d %db_name% -E -m 1 -Q"exec %etl_db_name%.dbo.drop_tables '%db_name%'" -o "%sql_log_folder%\unify_drop_tables.log"

echo %db_name% - start unify create tables

for /F %%d in ('dir /b /A:D %process_folder%') do (
    if exist %process_folder%\%%d\create_tables.sql (
        echo %db_name% - %%d - get table information
        sqlcmd -S %server% -d %db_name% -E -m 1 -i"%process_folder%\%%d\create_tables.sql" -o "%sql_log_folder%\unify_get_table_information_create_tables_%%d.log"
        sqlcmd -S %server% -d %db_name% -E -m 1 -Q"exec %etl_db_name%.dbo.create_tables_based_on_multiple_definitions '%db_name%', 0" -o "%sql_log_folder%\unify_get_table_information_%%d.log"
    ) else (
        echo No create_tables.sql found in %process_folder%\%%d !
    )
)

echo %db_name% - create unified tables
sqlcmd -S %server% -d %db_name% -E -m 1 -Q"exec %etl_db_name%.dbo.create_tables_based_on_multiple_definitions '%db_name%', 1" -o "%sql_log_folder%\unify_create_tables.log"

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
call %functions_folder%\variable :check_variable server

:: Validate input variables
call %functions_folder%\variable :check_variable db_name
call %functions_folder%\variable :check_folder   process_folder
call %functions_folder%\variable :create_folder  sql_log_folder

goto:eof
:: =======================================================================================
