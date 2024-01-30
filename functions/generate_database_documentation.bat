:: =======================================================================================
:: Main
::: Generate database documentation schemas from the extended properties of the
::: database and the schema images in the documentation_data_folder.

:: Global variables
::: server

:: Input variables
::: 1. db_name:                   name of the database
::: 2. documentation_data_folder: target location for database_documentatie_generator output
::: 3. documentation_img_folder:  location containing documentation images
::: 4. documentation_log_folder:  log folder for this function

:: Executables
::: database_documentatie_generator_exe
:: =======================================================================================
setlocal

set db_name=%~1
set documentation_data_folder=%~2
set documentation_img_folder=%~3
set documentation_log_folder=%~4

call :check_variables 4 %*

echo %db_name% - Generate database documentation

"%database_documentatie_generator_exe%" ^
    server=%server% ^
    database=%db_name% ^
    outputfolder="%documentation_data_folder%" ^
    logfolder="%documentation_log_folder%" ^
    imagefolder="%documentation_img_folder%"


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
call %functions_folder%\variable.bat :check_variable server
call %functions_folder%\variable.bat :check_file     database_documentatie_generator_exe

:: Validate input variables
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :create_folder  documentation_data_folder
call %functions_folder%\variable.bat :check_folder   documentation_img_folder
call %functions_folder%\variable.bat :create_folder  documentation_log_folder

goto:eof
:: =======================================================================================
