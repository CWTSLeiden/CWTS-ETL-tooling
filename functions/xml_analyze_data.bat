@echo off
:: =======================================================================================
:: Main
::: Use xml_analyzer_exe (-mode analyze) to analyse xml files.
::: As this is usually called as an asynchronous process using `start` this script
::: sends a signal when the process has finished.

:: Input variables
::: 1. db_name:           Name of the database.
::: 2. xml_split_element: Tag on which the XML should be split, format: {Namespace schema location}tag_name
:::                       Example: {http://www.openarchives.org/OAI/2.0/}record
::: 3. input_folder:      Folder containing files to analyze.
:::                       (usually identical to process_folder)
::: 4. output_folder:     Target folder for the text files with the XML paths.
::: 5. output_file_name:  Filename for the output file. (extension is optional and ignored)

:: Executables
::: xml_analyzer_exe
:: =======================================================================================
setlocal

set db_name=%~1
set xml_split_element=%~2
set input_folder=%~3
set output_folder=%~4
set output_file_name=%~n5

call :check_variables 5 %*

echo %db_name% - analyze XML data
%xml_analyzer_exe% ^
    -mode analyze ^
    -split_element %xml_split_element% ^
    -file_dir %input_folder% ^
    -output_dir %output_folder% ^
    -output_file %output_file_name%.txt

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

:: Validate global variables
call %functions_folder%\variable.bat :check_file        xml_analyzer_exe

:: Validate input variables
call %functions_folder%\variable.bat :check_variable    db_name
call %functions_folder%\variable.bat :check_variable    xml_split_element
call %functions_folder%\variable.bat :check_folder      input_folder
call %functions_folder%\variable.bat :create_folder     output_folder
call %functions_folder%\variable.bat :check_variable    output_file_name

goto:eof
:: =======================================================================================
