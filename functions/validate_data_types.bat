:: =======================================================================================
:: Main
::: Generate a validation file for the database with the data types for all columns.

:: Global variables
::: server
::: etl_db_name

:: Input variables
::: 1. db_name:     name of the database
:: =======================================================================================
setlocal

set db_name=%~1

call :check_variables 1 %*

set target_file_name=%db_name%_data_types.tsv

echo %db_name% - Data types of columns
sqlcmd -S %server% -d %db_name% -E -m 1 -Q"exec %etl_db_name%.dbo.get_data_type_columns '%db_name%'" -o "%validation_data_folder%\%target_file_name%" -h-1 -W -w 500 -s"	"

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
call %functions_folder%\variable.bat :create_folder   validation_data_folder

goto:eof
:: =======================================================================================
