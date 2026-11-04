:: =======================================================================================
:: Main
::: Generate a validation file for the database with the rowcounts for all tables
::: and columns for that database.

:: Global variables
::: validation_data_folder
::: (optional) bigquery_service_account_key

:: Input variables
::: 1. bigquery_path:  the path of the bigquery dataset (%project%:%dataset%)
:: =======================================================================================
setlocal

set bigquery_path=%~1

call :check_variables 1 %*

set target_file_name=%bigquery_dataset%_row_count_tables_biquery.tsv
set target_file=%validation_data_folder%\%target_file_name%

echo %bigquery_path% - Row count of tables
call %bq_exe% query ^
    --project_id=%bigquery_project% ^
    --format=csv ^
    --max_rows=10000 ^
    "select concat(table_id, '\t', cast(row_count as STRING)) from `%bigquery_path%.__TABLES__`" ^
    1> %target_file%.tmp

call %powershell_exe% "Get-Content %target_file%.tmp | select-object -skip 1 | Out-File %target_file%" -Encoding utf8
del %target_file%.tmp >nul

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_variables
:: =======================================================================================

:: set functions_folder to location of this script
set functions_folder=%~dp0
:: set program_folder to relative location of this script
set programs_folder=%~dp0\..\programs

:: get executable paths
call %programs_folder%\executables.bat

:: Check number of input variables
call %functions_folder%\variable.bat :check_parameters %*

:: Validate global variables
call %functions_folder%\variable.bat :create_folder  validation_data_folder

:: Validate input variables
call %functions_folder%\variable.bat :check_variable bigquery_path

for /f "tokens=1 delims=:" %%s in ("%bigquery_path%") do set bigquery_project=%%s
for /f "tokens=2 delims=:" %%s in ("%bigquery_path%") do set bigquery_dataset=%%s

if defined bigquery_service_account_key (
    call %gcloud_exe% auth activate-service-account --key-file=%bigquery_service_account_key%
)

goto:eof
:: =======================================================================================
