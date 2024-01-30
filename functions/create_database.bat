:: =======================================================================================
:: Main
::: Create a new database on the database-server

:: Global variables
::: database_drive_letter
::: log_drive_letter
::: db_owner
::: server
::: db_filegrowth

:: Input variables
::: 1. db_name:        database to be created
::: 2. sql_src_folder: SQL Source folder for the database
::: 3. sql_log_folder: log folder for this function
:: =======================================================================================
setlocal

set db_name=%~1
set sql_src_folder=%~2
set sql_log_folder=%~3

set logical_data_filename=%db_name%
set logical_log_filename=%db_name%_log
set physical_data_filename=%logical_data_filename%.mdf
set physical_log_filename=%logical_log_filename%.ldf
set db_data_folder=%database_drive_letter%:\MSSQL\data
set db_log_folder=%log_drive_letter%:\MSSQL\log

call :check_variables 3 %*

echo %db_name% - Create database

set create_database=^
    create database %db_name% ^
    on primary (name=N'%logical_data_filename%', filename=N'%db_data_folder%\%physical_data_filename%', filegrowth=%db_filegrowth%) ^
    log on (name=N'%logical_log_filename%', filename=N'%db_log_folder%\%physical_log_filename%')

sqlcmd -S %server% -d master -E -m 1 -Q"%create_database%" -o "%sql_log_folder%\create_database.log"
sqlcmd -S %server% -E -d %db_name% -m 1 -Q"sp_changedbowner '%db_owner%'" -o "%sql_log_folder%\change_owner.log"

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
call %functions_folder%\variable.bat :check_variable database_drive_letter
call %functions_folder%\variable.bat :check_variable log_drive_letter
call %functions_folder%\variable.bat :check_variable server
call %functions_folder%\variable.bat :check_variable db_owner

:: Validate input variables
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :check_variable sql_src_folder
call %functions_folder%\variable.bat :create_folder  sql_log_folder
call %functions_folder%\variable.bat :default_variable db_filegrowth 5GB

goto:eof
:: =======================================================================================
