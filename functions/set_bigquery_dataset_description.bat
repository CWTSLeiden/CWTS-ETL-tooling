:: =======================================================================================
:: Main
::: Set the description of a bigquery dataset to the database description
::: from a documentation.tsv file

:: input variables
::: 1. bigquery_path:      the path of the bigquery dataset (%project%:%dataset%)
::: 2. documentation_file: tsv file containing database documentation
::: 3. log_folder:         log folder for this function

:: executables
::: bq_exe
::: powershell_exe
:: =======================================================================================
setlocal

set bigquery_path=%~1
set documentation_file=%~2
set log_folder=%~3

call :check_variables 3 %*

:: Get database description
set "get_description=Import-Csv %documentation_file% -Delimiter `t | Where { $_.description_type -eq 'database' } | Select -Expand description"
for /f "delims=" %%t in ('%powershell_exe% "%get_description%"') do set db_description=%%t

:: Set dataset description
if defined db_description (
    call %bq_exe% update ^
        --description="%db_description" ^
        %bigquery_path% ^
        > %log_folder%\bq_set_database_description.log
) else (
    call %functions_folder%\echo.bat :error "Dataset description not found in %documentation_file%"
)

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

:: check number of input parameters
call %functions_folder%\variable.bat :check_parameters %*

:: validate global variables
call %functions_folder%\variable.bat :check_variable   bq_exe
call %functions_folder%\variable.bat :check_variable   powershell_exe

:: validate input variables
call %functions_folder%\variable.bat :check_variable   bigquery_path
call %functions_folder%\variable.bat :check_file       documentation_file
call %functions_folder%\variable.bat :create_folder    log_folder

goto:eof
:: =======================================================================================
