@echo off
:: =======================================================================================
:: Main
::: Use csv_analyzer_exe to analyse csv files.
::: As this is usually called as an asynchronous process using `start` this script
::: sends a signal when the process has finished.

:: Global variables
::: csv_analyzer_sample_lines:   Number of csv lines to use for type detection
::: csv_analyzer_output_columns: select string for types file output

:: Input variables
::: 1. input_file: location of the csv files
::: 2. output_file: output folder for types files.

:: Executables
::: csv_analyzer_exe
:: =======================================================================================
setlocal

set input_file=%~1
set output_file=%~2
set output_folder=%~dp2

call :check_variables 2 %*

echo analyze csv file: %input_file%
%csv_analyzer_exe% ^
    --input_file %input_file% ^
    --output_file %output_file% ^
    %csv_analyzer_sample_lines_arg% ^
    %csv_analyzer_output_columns_arg%

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
call %functions_folder%\variable.bat :check_file     input_file
call %functions_folder%\variable.bat :check_variable output_file
call %functions_folder%\variable.bat :create_folder  output_folder

if defined csv_analyzer_sample_lines (
    set csv_analyzer_sample_lines_arg=--sample_size %csv_analyzer_sample_lines%
)
if defined csv_analyzer_output_columns (
    set csv_analyzer_output_columns_arg=--output_columns "%csv_analyzer_output_columns%"
)

goto:eof
:: =======================================================================================
