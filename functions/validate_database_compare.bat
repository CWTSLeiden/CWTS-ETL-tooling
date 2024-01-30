:: =======================================================================================
:: Main
::: Generate a comparison of the rowcounts of two different versions of the database
::: Can run either on a single parameter: db_name and the global db_version and
::: variables db_previous_version or by providing the files to be compared.
::: If %new|old_validation_file% are provided %db_version% and %previous_db_version% are not
::: required and vice versa.

:: Global variables
::: (optional) db_version
::: (optional) previous_db_version
::: (optional) validation_data_folder

:: Input variables
::: 1. db_name:         name of the database
::: 2. new_validation_file: validation file of the current version
::: 3. old_validation_file: validation file of the previous version

:: Executables
::: powershell_exe
:: =======================================================================================
setlocal

set db_name=%~1
set new_validation_file=%~2
set old_validation_file=%~3

set validation_file=%~2
set validation_file_name=%~n2
set target_folder=%~dp2

call :check_variables

call %powershell_exe% "& %functions_folder%\validate_database_compare\validate_database_compare.ps1 -new %new_validation_file% -old %old_validation_file% -out view"

endlocal
goto:eof

:: =======================================================================================
:check_variables
:: =======================================================================================

:: Set functions_folder to location of this script
set functions_folder=%~dp0
:: Set program_folder to relative location of this script
set programs_folder=%~dp0\..\programs

:: Get executable paths
call %programs_folder%\executables.bat

:: Validate global variables
call %functions_folder%\variable.bat :check_variable server

:: Validate input variables
call %functions_folder%\variable.bat :check_variable  db_name

if not defined new_validation_file (
    call %functions_folder%\variable.bat :check_folder validation_data_folder
    set new_validation_file=%validation_data_folder%\%db_name%_row_count_tables.tsv
)
call %functions_folder%\variable.bat :check_file new_validation_file

if not defined old_validation_file (
    call %functions_folder%\variable.bat :check_variable db_version
    call %functions_folder%\variable.bat :check_variable previous_db_version
    call set old_validation_file=%%new_validation_file:%db_version%=%previous_db_version%%%
)
call %functions_folder%\variable.bat :check_file old_validation_file


goto:eof
:: =======================================================================================
