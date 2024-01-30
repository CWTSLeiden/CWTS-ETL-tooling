:: =======================================================================================
:: Main
::: Compress a folder to a single .zip file and validate the resulting .zip file.
::: The script will echo when a .zip file is corrupt, and exit with the exit code
::: from the zip program (which is 0 when the file is corrupt and 1 otherwise)
::: To capture this output and use it as a conditional in a  pipeline-script,
::: use: `if not errorlevel 0 (...)`

:: Input variables
::: 1. source_folder:  folder containing the data to be compressed
::: 2. target_file:    name for the target zip file (with path and extension)
::: 3. zip_log_folder: log folder for this function

:: Executables
::: zip_exe

:: Returns
::: zip validation error level
:: =======================================================================================
setlocal

set source_folder=%~1
set target_file=%~2
set target_folder=%~dp2
set target_file_name=%~n2
set target_file_extension=%~x2
set zip_log_folder=%~3

call :check_variables 3 %*

echo Creating %target_file%
"%zip_exe%" a "%target_file%" "%source_folder%\" -mmt=16 -mx=1 -y -bsp0 -bso0 -bse1 > "%zip_log_folder%\compress_%target_file_name%.error"

echo Validating %target_file%
"%zip_exe%" t "%target_file%" > nul 2>&1

if errorlevel 1 (
    echo ERROR: %target_file% is corrupt
)
:: Exit with errorlevel from zip validation
exit /b
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
call %functions_folder%\variable.bat :check_folder    source_folder
call %functions_folder%\variable.bat :check_variable  target_file
call %functions_folder%\variable.bat :create_folder   target_folder
call %functions_folder%\variable.bat :check_variable  target_file_name
call %functions_folder%\variable.bat :check_extension target_file zip
call %functions_folder%\variable.bat :create_folder   zip_log_folder

goto:eof
:: =======================================================================================
