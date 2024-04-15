:: =======================================================================================
:: Main
::: Export a table from sql server to a tsv file

:: global variables
::: server
::: export_table_include_header
::: export_table_include_types

:: input variables
::: 1. db_name:        name of the database to query
::: 2. table_name:     name of the table to export
::: 3. output_folder:  folder where the output files should be placed
::: 4. log_folder:     log folder for this function
:: =======================================================================================
setlocal

set db_name=%~1
set table_name=%~2
set output_folder=%~3
set output_file=%output_folder%\%table_name%.tsv
set types_file=%output_folder%\%table_name%_types.tsv
set log_folder=%~4

call :check_variables 4 %*

call %powershell_7_exe% "& %functions_folder%\export_table\export_table.ps1" ^
    "-server %server%" ^
    "-db_name %db_name%" ^
    "-table_name %table_name%" ^
    "-input_file %functions_folder%\export_table\export_table.sql" ^
    "-output_file %output_file%"

if "%export_table_include_types%" == "true" (
    call %powershell_7_exe% "& %functions_folder%\export_table\export_table.ps1" ^
        "-server %server%" ^
        "-db_name %db_name%" ^
        "-table_name %table_name%" ^
        "-input_file %functions_folder%\export_table\export_types.sql" ^
        "-output_file %types_file%"
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
call %functions_folder%\variable.bat :check_variable server

:: validate input variables
call %functions_folder%\variable.bat :check_variable   db_name
call %functions_folder%\variable.bat :check_variable   table_name
call %functions_folder%\variable.bat :check_variable   output_file
call %functions_folder%\variable.bat :create_folder    output_folder
call %functions_folder%\variable.bat :create_folder    log_folder
call %functions_folder%\variable.bat :default_variable export_table_include_header false
call %functions_folder%\variable.bat :default_variable export_table_include_types  false

goto:eof
:: =======================================================================================
