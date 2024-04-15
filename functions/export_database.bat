:: =======================================================================================
:: Main
::: Export a database from sql server to tsv files

::: First run all scripts in export_sql_folder using the file name as table name
::: Then run the default export for all tables in the database for which there is
::: no exported tsv file yet.

:: global variables
::: server
::: export_table_include_header
::: export_table_include_types

:: input variables
::: 1. db_name:           name of the database to export
::: 2. export_sql_folder: sql folder containing sql files corresponding to table names
:::                       which contain sql code to export the table
::: 3. output_folder:     folder where the output files should be placed
::: 4. log_folder:        log folder for this function
:: =======================================================================================
setlocal

set db_name=%~1
set export_sql_folder=%~2
set output_folder=%~3
set log_folder=%~4

call :check_variables 4 %*

set sqlcmd_exe=sqlcmd -S %server% -E -m 1 -y0

echo Export database %db_name%

set "table_query=select table_name from information_schema.tables"
call %sqlcmd_exe% -Q "set nocount on; %table_query%" -o "%output_folder%\table_export.conf"
if exist "%export_sql_folder%" (
    for /f %%f in ('dir /b /ON "%export_sql_folder%\*.sql"') do (
        call :export_table %export_sql_folder%\%%f
    )
)
for /f %%t in (%output_folder%\table_export.conf) do (
    call :export_table %%t
)

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:export_table
::: export the table if the exported table does not already exist
:: =======================================================================================
set table_or_file=%~1

if exist %table_or_file% (
    for %%f in (%table_or_file%) do set table_name=%%~nf
) else (
    set table_name=%table_or_file%
)
set output_file=%output_folder%\%table_name%.tsv

if not exist %output_file% (
    call %functions_folder%\export_table.bat ^
        "%db_name%" ^
        "%table_or_file%" ^
        "%output_folder%" ^
        "%log_folder%"
)
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

:: check number of input parameters
call %functions_folder%\variable.bat :check_parameters %*

:: validate global variables
call %functions_folder%\variable.bat :check_variable server

:: validate input variables
call %functions_folder%\variable.bat :check_variable   db_name
call %functions_folder%\variable.bat :check_variable   export_sql_folder
call %functions_folder%\variable.bat :create_folder    output_folder
call %functions_folder%\variable.bat :create_folder    log_folder
call %functions_folder%\variable.bat :default_variable export_table_include_header false
call %functions_folder%\variable.bat :default_variable export_table_include_types  false

goto:eof
:: =======================================================================================
