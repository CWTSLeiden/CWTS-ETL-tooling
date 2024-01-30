:: =======================================================================================
:: Main
::: Use xml_analyzer_exe (-mode generate) to convert the found xml paths to a .prg file.

:: Global variables
::: (optional) generate_prg_file_additional_split_tags (comma separated list)
::: (optional) generate_prg_file_additional_split_tags_with_sequence (comma separated list)

:: Input variables
::: 1. db_name:                     Name of the database.
::: 2. xml_paths_folder:            Folder containing the found XML paths (file extension must be .txt).
::: 3. program_output_folder:       Target folder for the .prg file.
::: 4. program_output_file_name:    Filename for the .prg file. program gives a default prefix of [frequency_] to the file.

:: Executables
::: xml_analyzer_exe
:: =======================================================================================
setlocal

set db_name=%~1
set xml_paths_folder=%~2
set program_output_folder=%~3
set program_output_file_name=%~4

call :check_variables 4 %*

echo %db_name% - Generate PRG file
%xml_analyzer_exe% ^
    -mode generate ^
    -file_dir %xml_paths_folder% ^
    -output_dir %program_output_folder% ^
    -output_file %program_output_file_name%.prg ^
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
call %functions_folder%\variable.bat :check_file        xml_analyzer_exe

:: Validate input variables
call %functions_folder%\variable.bat :check_variable    db_name
call %functions_folder%\variable.bat :check_folder      xml_paths_folder
call %functions_folder%\variable.bat :create_folder     program_output_folder
call %functions_folder%\variable.bat :check_variable    program_output_file_name

:: Set xml_analyzer optional arguments only if defined
if defined generate_prg_file_additional_split_tags (
    set generate_prg_file_additional_split_tags_arg=-additional_split_tags %generate_prg_file_additional_split_tags%
)
if defined generate_prg_file_additional_split_tags_with_sequence (
    set generate_prg_file_additional_split_tags_with_sequence_arg=-additional_split_tags_with_sequence %generate_prg_file_additional_split_tags_with_sequence%
)

goto:eof
:: =======================================================================================
