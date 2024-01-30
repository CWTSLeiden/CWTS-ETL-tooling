:: =======================================================================================
:: Main
::: Expand a folder of zip files to a directory

:: Input variables
::: 1. source_folder:         folder containing the files to be extracted
:::                           (at any depth)
::: 2. extension:             file extension to extract
::: 3. target_folder:         target folder for the extracted files
::: 4. zip_log_folder:        log folder for this function
::: 5. keep_folder_structure: if set to "keep_folder_structure",
:::                           keep the folder/file structure from the zip
:::                           else, flatten the structure.
:: =======================================================================================
setlocal

set source_folder=%~1
set extension=%~2
set target_folder=%~3
set zip_log_folder=%~4
set keep_folder_structure=%~5

call :check_variables 5 %*

for /R %source_folder% %%f in (*.%extension%) do (
    call %functions_folder%\unzip_file.bat ^
         "%%~ff" ^
         "%target_folder%" ^
         "%zip_log_folder%" ^
         %keep_folder_structure%
)

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
call %functions_folder%\variable.bat :check_file     source_folder
call %functions_folder%\variable.bat :check_variable extension
call %functions_folder%\variable.bat :create_folder  target_folder
call %functions_folder%\variable.bat :create_folder  zip_log_folder
call %functions_folder%\variable.bat :check_variable keep_folder_structure

goto:eof
:: =======================================================================================
