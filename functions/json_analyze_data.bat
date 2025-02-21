@echo off
:: =======================================================================================
:: Main
::: Use json_analyzer_exe to analyse json files.
::: As this is usually called as an asynchronous process using `start` this script
::: sends a signal when the process has finished.

:: Global variables
::: number_of_processes
::: json_analyzer_skip_paths
::: json_analyzer_safe
::: json_analyzer_sample_files
::: json_analyzer_sample_lines

:: Input variables
::: 1. db_name:       name of the database
::: 2. source_folder: location of the json files
::: 3. wildcard:      pattern to match files
:::                   (use '#' instead of '*' because of .bat limitations...)
:::                   (note that this pattern should not match directories!)
::: 4. read_type:     program has two options: 'file_by_file','line_by_line'
::: 5. output_file:   output file_name

:: Executables
::: json_analyzer_exe
:: =======================================================================================
setlocal

set db_name=%~1
set source_folder=%~2
set wildcard=%~3
set read_type=%~4
set output_file=%~5
set output_folder=%~dp5

call :check_variables 5 %*

echo %db_name% - analyze data
%json_analyzer_exe% ^
    --input_dir %source_folder% ^
    --wildcard %wildcard% ^
    --read_type %read_type% ^
    --output_file %output_file% ^
    --skip_paths %json_analyzer_skip_paths% ^
    --number_of_processes %number_of_processes% ^
    %json_analyzer_safe_arg% ^
    %json_analyzer_sample_files_arg% ^
    %json_analyzer_sample_lines_arg%


:: Send signal to waiting processes
call %functions_folder%\wait.bat :send %~f0

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

:: Validate input variables
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :check_folder   source_folder
call %functions_folder%\variable.bat :check_variable wildcard
call %functions_folder%\variable.bat :check_variable read_type
call %functions_folder%\variable.bat :create_folder  output_folder
call %functions_folder%\variable.bat :check_variable output_file
call %functions_folder%\variable.bat :default_variable json_analyzer_skip_paths "#"

set wildcard=%wildcard:#=*%
if "%json_analyzer_safe%" == "true" (
    set json_analyzer_safe_arg=--safe
)
if defined json_analyzer_sample_files (
    set json_analyzer_sample_files_arg=--sample_files %json_analyzer_sample_files%
)
if defined json_analyzer_sample_lines (
    set json_analyzer_sample_lines_arg=--sample_lines %json_analyzer_sample_lines%
)

goto:eof
:: =======================================================================================
