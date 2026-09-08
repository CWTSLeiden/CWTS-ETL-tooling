:: =======================================================================================
:: Main
::: Runs the crossref sbmv citation matching algorithm
::: The function takes a function name which signifies whether the structured or
::: unstructured version will be run.

:: Global variables
::: server
::: number_of_processes
::: citation_matching_crossref_api_key
::: citation_matching_threshold   (default 0.4)
::: citation_matching_batch_size  (default 1000)
::: citation_matching_continue    (default false)
::: verbose

:: Input variables
::: 1. matching_type:        structured or unstructured
::: 2. input_db_table:       name of the input table (db_name.schema.table_name)
::: 3. input_db_id_column:   name of the column containing the unique reference identifier
::: 4. input_db_ref_column:  name of the colunn containing the unstrucutred reference
::: 5. output_db_table:      name of the output table (db_name.schema.table_name)
::: 6. output_file:          filename of the jsonl file to output the data to
::: 7. log_folder:           log folder for this function
:: =======================================================================================
setlocal

set matching_type=%~1
set input_db_table=%~2
set input_db_id_column=%~3
set input_db_ref_column=%~4
set output_db_table=%~5
set output_file=%~6
set log_folder=%~7

call :check_variables 7 %*

call %functions_folder%\echo.bat :verbose "Starting citation matching for %input_db_table%"
if defined output_table (
    call %functions_folder%\echo.bat :verbose "Writing results to %output_db_table%"
)
if defined output_file (
    call %functions_folder%\echo.bat :verbose "Writing results to %output_file%"
)

call %citationmatching_exe% ^
    --api_key %citation_matching_crossref_api_key% ^
    --email %email% ^
    --threshold %citation_matching_threshold% ^
    --number_of_processes %number_of_processes% ^
    --batch_size %citation_matching_batch_size% ^
    --server %server% ^
    --input_table %input_db_table% ^
    --input_columns %input_db_id_column%,%input_db_ref_column% ^
    --output_table %output_db_table% ^
    --output_file %output_file% ^
    --log_file %log_folder%/citation_matching.log ^
    --error_file %log_folder%/citation_matching.error ^
    %continue_process_arg% ^
    %verbose_arg%

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_variables
:: =======================================================================================

:: Set functions_folder to location of this script
set functions_folder=%~dp0
:: Set program_folder to relative location of this script
set programs_folder=%~dp0\..\programs

:: Get executable paths
call %programs_folder%\executables.bat

:: Check number of input variables
call %functions_folder%\variable.bat :check_parameters %*

:: Validate global variables
call %functions_folder%\variable.bat :check_variable server
call %functions_folder%\variable.bat :check_variable number_of_processes
call %functions_folder%\variable.bat :check_variable db_owner
call %functions_folder%\variable.bat :check_variable citation_matching_crossref_api_key
call %functions_folder%\variable.bat :default_variable citation_matching_threshold 0.4
call %functions_folder%\variable.bat :default_variable citation_matching_batch_size 1000
call %functions_folder%\variable.bat :default_variable citation_matching_continue false

for /f "tokens=2 delims=\" %%a in ("%db_owner%") do set username=%%a
set email=%username%@vuw.leidenuniv.nl

:: Validate input variables
call %functions_folder%\variable.bat :check_variable matching_type
if not "%matching_type%"=="structured" if not "%matching_type%"=="unstructured" (
    echo error - wrong matching type: %matching_type%
    call :exit
)
call %functions_folder%\variable.bat :check_variable input_db_table
call %functions_folder%\variable.bat :check_variable input_db_id_column
call %functions_folder%\variable.bat :check_variable input_db_ref_column
call %functions_folder%\variable.bat :check_variable output_db_table
call %functions_folder%\variable.bat :check_variable output_file
call %functions_folder%\variable.bat :create_folder  log_folder

if "%verbose%"=="true" (
    set "verbose_arg=--verbose"
)
if "%citation_matching_continue%"=="true" (
    set "continue_process_arg=--continue_process"
)

:: Validate executables
set "citationmatching_exe="
if "%matching_type%"=="structured" (
    set citationmatching_exe=%citationmatching_structured_exe%
)
if "%matching_type%"=="unstructured" (
    set citationmatching_exe=%citationmatching_unstructured_exe%
)
call %functions_folder%\variable.bat :check_file     citationmatching_exe

goto:eof
:: =======================================================================================
