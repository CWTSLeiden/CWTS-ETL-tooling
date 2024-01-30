:: =======================================================================================
:: Main
::: Loads all sql scripts from a folder containing the following folders
::: - pre_processing_scripts
::: - table_scripts
::: - post_processing_scripts
::: The function takes a function name which signifies which folder to run all scripts for.
::: When this function name is ":all_scripts" all scripts will be run.

:: Global variables
::: server
::: copy_identity_tables

:: Input variables
::: 1. function:          name of the function to be called
::: 2. db_name:           name of the relational database
::: 3. db_sql_src_folder: folder containing pre-/post-processing and table scripts
::: 4. db_sql_log_folder: log folder for this function
::: 5. sqlcmd_variables:  variables to be passed to sqlcmd
:::                       (including -v, enclosed in "" because of spaces)
:: =======================================================================================
setlocal

set function=%~1
set db_name=%~2
set db_sql_src_folder=%~3
set db_sql_log_folder=%~4
set sqlcmd_variables=%~5

set pre_processing_scripts_db_sql_src_folder=%db_sql_src_folder%\pre_processing_scripts
set table_scripts_db_sql_src_folder=%db_sql_src_folder%\table_scripts
set post_processing_scripts_db_sql_src_folder=%db_sql_src_folder%\post_processing_scripts

call :check_variables 5 %*

call %function%

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:run_all_scripts
call %functions_folder%\variable.bat :check_folder pre_processing_scripts_db_sql_src_folder
call %functions_folder%\variable.bat :check_folder table_scripts_db_sql_src_folder
call %functions_folder%\variable.bat :check_folder post_processing_scripts_db_sql_src_folder
:: =======================================================================================

call :run_pre_processing_scripts
call :run_table_scripts
call :run_post_processing_scripts
goto:eof
:: =======================================================================================


:: =======================================================================================
:run_pre_processing_scripts
call %functions_folder%\variable.bat :check_folder pre_processing_scripts_db_sql_src_folder
:: =======================================================================================
setlocal enabledelayedexpansion
for /f %%f in ('dir /b /ON "%pre_processing_scripts_db_sql_src_folder%\*.sql"') do (
    set file=%%f
    set skip=false
    :: If copy_identity_tables is in the file name
    if /I not "!file:copy_identity_tables=!"=="!file!" (
        if not "%copy_identity_tables%" == "true" ( set skip=true )
    )
    call :run_sql_script "%pre_processing_scripts_db_sql_src_folder%\%%f" !skip!
)
endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:run_table_scripts
call %functions_folder%\variable.bat :check_folder table_scripts_db_sql_src_folder
:: =======================================================================================
for /f %%f in ('dir /b /ON "%table_scripts_db_sql_src_folder%\*.sql"') do (
    call :run_sql_script "%table_scripts_db_sql_src_folder%\%%f"
)
goto:eof
:: =======================================================================================


:: =======================================================================================
:run_post_processing_scripts
call %functions_folder%\variable.bat :check_folder post_processing_scripts_db_sql_src_folder
:: =======================================================================================
for /f %%f in ('dir /b /ON "%post_processing_scripts_db_sql_src_folder%\*.sql"') do (
    call :run_sql_script "%post_processing_scripts_db_sql_src_folder%\%%f"
)
goto:eof
:: =======================================================================================


:: =======================================================================================
:run_sql_script
:: =======================================================================================
setlocal enabledelayedexpansion

set file=%~1
set file_name=%~n1
set long_file_name=!file:%db_sql_src_folder%\=!
set skip=%~2
if "%skip%" == "true" ( goto:eof )

echo %db_name% - running script - %long_file_name%
sqlcmd -S %server% -d %db_name% -E -m 1 -i "%file%" -o "%db_sql_log_folder%\%file_name%.log" %sqlcmd_variables%

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
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :check_variable copy_identity_tables

:: Validate input variables
call %functions_folder%\variable.bat :check_variable function
call %functions_folder%\variable.bat :check_folder   db_sql_src_folder
call %functions_folder%\variable.bat :create_folder  db_sql_log_folder

goto:eof
:: =======================================================================================
