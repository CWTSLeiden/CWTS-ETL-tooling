:: =======================================================================================
:: Main
::: Use xml_analyzer_exe (-mode generate) to convert the found xml paths to a .prg file.

:: Global variables
::: (optional) generate_prg_file_additional_split_tags (comma separated list)
::: (optional) generate_prg_file_additional_split_tags_with_sequence (comma separated list)

:: Input variables
::: 1. db_name:     Name of the database.
::: 2. input_file:  File containing the found XML paths (full path and drive).
::: 3. output_file: File for the .prg file. (extension is optional and ignored)

:: Executables
::: xml_analyzer_exe
:: =======================================================================================
setlocal

set db_name=%~1
set input_file=%~2
set input_file_name=%~nx2
set input_folder=%~dp2
set output_folder=%~dp3
set output_file_name=%~n3

call :check_variables 3 %*

echo %db_name% - Generate PRG file
%xml_analyzer_exe% ^
    -mode generate ^
    -input_file %input_file_name% ^
    -file_dir %input_folder% ^
    -output_dir %output_folder% ^
    -output_file %output_file_name% ^
    %generate_prg_file_additional_split_tags_arg% ^
    %generate_prg_file_additional_split_tags_with_sequence_arg%

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
call %functions_folder%\variable.bat :check_file      xml_analyzer_exe

:: Validate input variables
call %functions_folder%\variable.bat :check_variable  db_name
call %functions_folder%\variable.bat :check_file      input_file
call %functions_folder%\variable.bat :create_folder   output_folder
call %functions_folder%\variable.bat :check_variable  output_file_name

:: Set xml_analyzer optional arguments only if defined
if defined generate_prg_file_additional_split_tags (
    set generate_prg_file_additional_split_tags_arg=-additional_split_tags %generate_prg_file_additional_split_tags%
)
if defined generate_prg_file_additional_split_tags_with_sequence (
    set generate_prg_file_additional_split_tags_with_sequence_arg=-additional_split_tags_with_sequence %generate_prg_file_additional_split_tags_with_sequence%
)

goto:eof
:: =======================================================================================
