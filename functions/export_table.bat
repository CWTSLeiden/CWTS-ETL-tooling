:: =======================================================================================
:: Main
::: Export a table from sql server to a tsv file

:: global variables
::: server
::: export_table_include_header
::: export_table_include_types
::: export_table_types_only
::: export_table_sqlcmd_variables (excluding -v, enclosed in "" because of spaces)

:: input variables
::: 1. db_name:        name of the database to query
::: 2. table_or_file:  name of the table to export
:::                    or a query file with the sql statement that outputs a single table
::: 3. output_folder:  folder where the output files should be placed
::: 4. log_folder:     log folder for this function
:: =======================================================================================
setlocal

set db_name=%~1
set table_or_file=%~2
set output_folder=%~3
set log_folder=%~4

call :check_variables 4 %*

if "%export_table_types_only%" == "true" (
    call :export_types
    goto:eof
)

if exist %table_or_file% (
    call :export_script_mode
) else (
    call :export_table_mode
)

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:export_table_mode
:: =======================================================================================
set table_name=%table_or_file%

call %functions_folder%\variable.bat :check_variable table_name

echo Export table %db_name%..%table_name%
call %csv_exe% export ^
    --server %server% ^
    --database %db_name% ^
    --table %table_name% ^
    --outputFile %output_folder%\%table_name%.tsv ^
    --removeCR ^
    --removeLF ^
    --removeTab ^
    %no_header_arg% ^
    %verbose_arg% ^
    --logFile %log_folder%\%table_name%.log

if "%export_table_include_types%" == "true" (
    call :export_types
)
goto:eof
:: =======================================================================================


:: =======================================================================================
:export_types
:: =======================================================================================
set table_name=%table_or_file%

call %functions_folder%\variable.bat :check_variable table_name

echo Export table %db_name%..%table_name% types
call %csv_exe% export_query ^
    --server %server% ^
    --database %db_name% ^
    --queryFile %functions_folder%\export_table\export_types.sql ^
    --outputFile %types_output_folder%\%table_name%_types.tsv ^
    --var "table_name=%table_name%" ^
    --removeHeaderRecord false ^
    %verbose_arg% ^
    --logFile %log_folder%\%table_name%_types.log

goto:eof
:: =======================================================================================


:: =======================================================================================
:export_script_mode
:: =======================================================================================
set table_query_file=%table_or_file%
for %%f in (%table_or_file%) do set table_name=%%~nf

call %functions_folder%\variable.bat :check_variable table_name
call %functions_folder%\variable.bat :check_file     table_query_file

echo Export table %db_name%..%table_name% using script %table_query_file%
call %csv_exe% export_query ^
    --server %server% ^
    --database %db_name% ^
    --queryFile %table_query_file% ^
    --var "table_name=%table_name%" ^
    --outputFile %output_folder%\%table_name%.tsv ^
    --removeCR ^
    --removeLF ^
    --removeTab ^
    %vars_arg% ^
    %no_header_arg% ^
    %verbose_arg% ^
    --logFile %log_folder%\%table_name%.log
    
if "%export_table_include_types%" == "true" (
    echo Analyze %table_name%.tsv types
    set csv_analyzer_output_columns='%table_name%' as table_name, column_name, mssql_type as data_type, max_length, is_nullable
    call %functions_folder%\csv_analyze_data.bat ^
        "%output_folder%\%table_name%.tsv" ^
        "%types_output_folder%\%table_name%_types.tsv"
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
call %functions_folder%\variable.bat :check_variable   table_or_file
call %functions_folder%\variable.bat :create_folder    output_folder
call %functions_folder%\variable.bat :create_folder    log_folder
call %functions_folder%\variable.bat :default_variable export_table_include_header false
call %functions_folder%\variable.bat :default_variable export_table_include_types  false
call %functions_folder%\variable.bat :default_variable export_table_sqlcmd_variables ""
call %functions_folder%\variable.bat :check_file       csv_exe

set types_output_folder=%output_folder%\types
if "%export_table_include_types%" == "true" (
    call %functions_folder%\variable.bat :create_folder types_output_folder
)

if defined export_table_sqlcmd_variables (
    set "vars_arg=--var %export_table_sqlcmd_variables: = --var %"
)

if "%verbose%" == "true" (
    set verbose_arg=--verbose
)
if "%export_table_include_header%" == "false" (
    set no_header_arg=--removeHeaderRecord true
) else (
    set no_header_arg=--removeHeaderRecord false
)

goto:eof
:: =======================================================================================
