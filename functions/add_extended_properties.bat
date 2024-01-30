:: =======================================================================================
:: Main
::: Generate extended properties for tables and columns from a .csv file
::: The values from the .csv file get loaded into a table, which is a parameter
::: for the stored procedure `add_extended_properties` in the [cwtsdb_etl] database.
::: This stored procedure loads the documentation strings as extended properties in the
::: database after performing some checks.

:: Global variables
::: server
::: etl_db_name

:: Input variables
::: 1. db_name:            name of the database
::: 2. documentation_file: tsv file containing the extended property strings
:::                        (full path including extension)
::: 3. sql_log_folder:     log folder for this function
::: 4. bcp_log_folder:     log folder for bcp operations
::: 5. erase_previous:     if set to "erase_previous" drop existing extended properties
:: =======================================================================================

setlocal

set db_name=%~1
set documentation_file=%~2
set sql_log_folder=%~3
set bcp_log_folder=%~4
set erase_previous=%~5

set error_bcp_log_folder=%bcp_log_folder%\error
set log_bcp_log_folder=%bcp_log_folder%\log
set sql_scripts_folder=%~dp0\add_extended_properties

call :check_variables 5 %*

if %erase_previous% == erase_previous (
    echo %db_name% - Remove old extended properties

    :: Remove existing extended properties
    sqlcmd -S %server% -d %db_name% -E -m 1 -Q"exec %etl_db_name%.dbo.drop_extended_properties '%db_name%'" -o "%sql_log_folder%\drop_extended_properties.log"
)

echo %db_name% - Add extended properties

:: Create _documentation help table
sqlcmd -S %server% -d %db_name% -E -m 1 -i "%sql_scripts_folder%\step_01_create_documentation_table.sql" -o "%sql_log_folder%\step_01_create_documentation_table.log"

:: Load documentation file into _documentation table
bcp %db_name%.dbo._documentation in "%documentation_file%" -c -t\t -S %server% -T -F2 -e "%error_bcp_log_folder%\documentation.error" >"%log_bcp_log_folder%\documentation.log"

:: Load documentation into database
::: This sqlcmd operates on the etl_db_name because the table-type that the script
::: uses is defined in that database, and table-types cannot be called from
::: a different database.
sqlcmd -S %server% -d %etl_db_name% -E -m 1 -i "%sql_scripts_folder%\step_02_load_documentation.sql" -o "%sql_log_folder%\step_02_load_documentation.log" -v db_name=%db_name%

:: Drop _documentation help table
sqlcmd -S %server% -d %db_name% -E -m 1 -i "%sql_scripts_folder%\step_03_drop_documentation_table.sql" -o "%sql_log_folder%\step_03_drop_documentation_table.log"

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
call %functions_folder%\variable.bat :check_variable  db_name
call %functions_folder%\variable.bat :check_file      documentation_file
call %functions_folder%\variable.bat :check_extension documentation_file tsv
call %functions_folder%\variable.bat :create_folder   sql_log_folder
call %functions_folder%\variable.bat :create_folder   bcp_log_folder
call %functions_folder%\variable.bat :create_folder   error_bcp_log_folder
call %functions_folder%\variable.bat :create_folder   log_bcp_log_folder
call %functions_folder%\variable.bat :check_variable  erase_previous

goto:eof
:: =======================================================================================
