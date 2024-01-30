:: =======================================================================================
:: Main
::: Recursively collect all files of a specific type within the data_folder and
::: distribute them equally over a number of folders in the process_folder.

:: Input variables
::: 1. data_folder:                 source folder containing raw datafiles
::: 2. process_folder:              target folder for numbered directories
::: 3. number_of_processes:         number of process folders
::: 4. file_type:                   type of file that should be splitted (without leading dot)
::: 5. include_parent_directory:    if argument is include_parent_directory, then the folder structure is inherited in the numbered directory.
:::                                 if argument is "" the files will be placed in the numbered directory.
::: 6. order:                       if size, order by size before splitting (accurate)
:::                                 if preserve, preserve order of files across process folders (slow)
:::                                 else, do not order. (fast)

:: Executables
::: powershell_exe
:: =======================================================================================
setlocal

set data_folder=%~1
set process_folder=%~2
set number_of_processes=%~3
set file_type=%~4
set include_parent_directory=%~5
set order=%~6

call :check_variables 6 %*
call :check_files

call %powershell_exe% "& %functions_folder%\split_process_files\split_process_files.ps1" ^
    "-data_folder %data_folder%" ^
    "-process_folder %process_folder%" ^
    "-number_of_processes %number_of_processes%" ^
    "-file_type %file_type%" ^
    "-include_parent_directory %include_parent_directory%" ^
    "-order '%order%'" ^
    "%verbose_arg%"

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_variables
:: =======================================================================================

:: Set functions_folder to location of this script
set functions_folder=%~dp0
:: set program_folder to relative location of this script
set programs_folder=%~dp0\..\programs

:: get executable paths
call %programs_folder%\executables.bat

:: Check number of input variables
call %functions_folder%\variable.bat :check_parameters %*

:: Validate input variables
call %functions_folder%\variable.bat :check_folder   data_folder
call %functions_folder%\variable.bat :create_folder  process_folder
call %functions_folder%\variable.bat :check_variable number_of_processes
call %functions_folder%\variable.bat :check_variable file_type
call %functions_folder%\variable.bat :check_variable include_parent_directory


if "%verbose%" == "true" (
   set verbose_arg=-Verbose
)

goto:eof
:: =======================================================================================


:: =======================================================================================
:check_files
:: =======================================================================================
:: Error if the number of files in data_folder is smaller than number of processes.
:: For instance, when the data_folder is empty.

setlocal enabledelayedexpansion

set number_of_files=0
for /R "%data_folder%\" %%f in (*.%file_type%) do (
    set /a number_of_files+=1
    if !number_of_files! GTR %number_of_processes% (exit /b)
)
echo "Number of processes (%number_of_processes%) is bigger than number of files (%number_of_files%)"
call %functions_folder%\variable.bat :exit
:: =======================================================================================
