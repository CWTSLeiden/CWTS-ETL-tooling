:: =======================================================================================
:: Main
::: Load a tsv file into a bigquery table

:: input variables
::: 1. input_file:     the tsv file to be loaded
::: 2. bigquery_path:  the path of the bigquery table (%project%:%dataset%.%table%)
::: 3. schema_file:    file containing the bigquery schema for the table
:::                    (either a .json schema file or a .tsv file from which
:::                    to generate the .json schema file)
::: 4. log_folder:     log folder for this function
::: https://cloud.google.com/bigquery/docs/schemas#specifying_a_json_schema_file

:: executables
::: bq_exe
::: powershell_exe
:: =======================================================================================
setlocal

set input_file=%~1
set file_name=%~n1
set bigquery_path=%~2
set schema_file=%~3
set schema_file_extension=%~x3
set log_folder=%~4

call :check_variables 4 %*

if "%schema_file_extension%" == ".tsv" (
    call :generate_json_schema %schema_file%
)

:: Load data
call %bq_exe% load ^
    --source_format=CSV ^
    --field_delimiter=tab ^
    --skip_leading_rows=%load_bigquery_skip_leading_rows% ^
    --null_marker="" ^
    --allow_jagged_rows=false ^
    --apilog %log_folder%\%file_name%.log ^
    %bigquery_path% ^
    %input_file% ^
    %schema_file%

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:generate_json_schema
:: =======================================================================================
set schema_tsv_file=%~1
set schema_file=%schema_tsv_file:tsv=json%
set log_file=%log_folder%\load_bigquery_table_%file_name%.log

echo Generate schema for %file_name% from %schema_tsv_file% > %log_file%

call %powershell_exe% "& %functions_folder%\load_bigquery_table\generate_bigquery_schema.ps1" ^
    "-InputFile %schema_tsv_file%" ^
    "-OutputFile %schema_file%" ^
    "-LogFile %log_file%" ^
    "%powershell_verbose_arg%"

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
call %functions_folder%\variable.bat :check_variable   bq_exe
call %functions_folder%\variable.bat :check_variable   powershell_exe

:: validate input variables
call %functions_folder%\variable.bat :check_file       input_file
call %functions_folder%\variable.bat :check_variable   bigquery_path
call %functions_folder%\variable.bat :check_file       schema_file
call %functions_folder%\variable.bat :create_folder    log_folder
call %functions_folder%\variable.bat :default_variable load_bigquery_skip_leading_rows 0

if "%export_table_include_header%" == "true" (
    set load_bigquery_skip_leading_rows=1
)

for /f "tokens=1 delims=:" %%s in ("%bigquery_path%") do set bigquery_project=%%s
for /f "tokens=2 delims=:" %%s in ("%bigquery_path%") do set bigquery_dataset_table=%%s
for /f "tokens=1 delims=." %%s in ("%bigquery_dataset_table%") do set bigquery_dataset=%%s
for /f "tokens=2 delims=." %%s in ("%bigquery_dataset_table%") do set bigquery_table=%%s

call %functions_folder%\variable.bat :check_variable bigquery_project
call %functions_folder%\variable.bat :check_variable bigquery_dataset
call %functions_folder%\variable.bat :check_variable bigquery_table

if "%verbose%" == "true" (set powershell_verbose_arg="-Verbose")

goto:eof
:: =======================================================================================
