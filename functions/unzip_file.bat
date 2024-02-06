@echo off
:: =======================================================================================
:: Main
::: Expand a zip file to a directory

:: Global variables
::: zip_args: extra arguments for 7zip

:: Input variables
::: 1. source_file:           zip file containing the data to be extracted
:::                           (with path and extension)
::: 2. target_folder:         target folder for the extracted files
::: 3. zip_log_folder:        log folder for this function
::: 4. keep_folder_structure: if set to "keep_folder_structure",
:::                           keep the folder/file structure from the zip
:::                           else, flatten the structure.

:: Executables
::: zip_exe
:: =======================================================================================
setlocal

set source_file=%~1
set source_file_name=%~n1
set source_file_name_ext=%~nx1
set target_folder=%~2
set zip_log_folder=%~3
set keep_folder_structure=%~4

call :check_variables 4 %*

set zip_action=e
if %keep_folder_structure% == keep_folder_structure (set zip_action=x)

echo Unzip %source_file_name_ext% to %target_folder%

"%zip_exe%" %zip_action% "%source_file%" -o"%target_folder%" %zip_args% -aou -y -bsp0 -bso0 -bse1 > "%zip_log_folder%\extract_%source_file_name%.error"

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
call %functions_folder%\variable.bat :check_file zip_exe

:: Validate input variables
call %functions_folder%\variable.bat :check_file     source_file
call %functions_folder%\variable.bat :check_variable source_file_name_ext
call %functions_folder%\variable.bat :check_folder   target_folder
call %functions_folder%\variable.bat :create_folder  zip_log_folder
call %functions_folder%\variable.bat :check_variable keep_folder_structure

:: Check target_folder size
for /f "tokens=3 delims= " %%s in ('robocopy "%target_folder%" "%TEMP%" /S /L /BYTES /XJ /NFL /NDL /NJH /R:0 ^| find "Bytes"') do set target_folder_size=%%s
if not "%target_folder_size%" == "0" (
    echo Target folder is not empty, file duplication might occur because of the 7zip -aou option.
    echo Please check %target_folder% for files ending in _1, _2, etc.
)

goto:eof
:: =======================================================================================
