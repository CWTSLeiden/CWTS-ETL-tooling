@echo off
:: =======================================================================================
:: Main
::: Use readdata to parse raw xml files to a flat-file format and generate the SQL and BCP
::: commands to load the raw data into an xml database.
::: As this is usually called as an asynchronous process using `start` this script
::: sends a signal when the process has finished.

:: Global variables
::: server
::: (optional) readdata_options

:: Input variables
::: 1. db_name:             name of the database
::: 2. process_folder:      folder where parsing should take place
::: 3. xml_data_folder:     folder containing files to parse
:::                         (usually identical to process_folder)
::: 4. prg_src_file:        PRG file containing parsing instructions
:::                         (including path)
::: 5. exported_scripts_folder: target location for generated scripts
::: 6. readdata_log_folder: log folder for this function
::: 7. erase_previous:      if set to "erase_previous" erase xxx files from previous runs
::: 8. erase_xml:           if set to "erase_xml" erase xml files after parsing

:: Executables
::: readdata_exe
:: =======================================================================================
setlocal

set db_name=%~1
set process_folder=%~2
set process_folder_name=%~n2
set xml_data_folder=%~3
set prg_src_file=%~4
set exported_scripts_folder=%~5
set readdata_log_folder=%~6
set erase_previous=%~7
set erase_xml=%~8

call :check_variables 8 %*

cd /d %process_folder%

:: Erase results from previous runs.
if %erase_previous% == erase_previous (
    if exist *.xxx (
        echo Erasing previously generated .xxx files.
        erase *.xxx
    )
)

:: Parse .xml files in xml_data_folder (recursively)
echo %db_name% - %process_folder_name% - Parsing data
"%readdata_exe%" "%prg_src_file%" "%xml_data_folder%" %readdata_options%

:: Create sql and bcp scripts from the parsed files
echo %db_name% - %process_folder_name% - Creating SQL en BCP commands.
"%readdata_exe%" "%prg_src_file%" -files server=%server% database=%db_name% %readdata_options%

:: Copy src files.
copy "createtables.sql" "%exported_scripts_folder%\create_tables.sql" >nul
copy "droptables.sql" "%exported_scripts_folder%\drop_tables.sql" >nul
copy "bcpdata.bat" "%exported_scripts_folder%\bcp_data.bat" >nul

:: Move log files.
robocopy "readdata logs" "%readdata_log_folder%" /move /NFL /NDL /NJH /NJS /nc /ns /np | findstr /r /v "^$"

:: Erase processed xml files.
if %erase_xml% == erase_xml (
    if exist "*.xml" (
        echo Erasing processed .xml files.
        erase "*.xml"
    )
)

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
call %functions_folder%\variable.bat :check_file readdata_exe
call %functions_folder%\variable.bat :check_variable server

:: Validate input variables
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :create_folder  process_folder
call %functions_folder%\variable.bat :check_folder   xml_data_folder
call %functions_folder%\variable.bat :check_file     prg_src_file
call %functions_folder%\variable.bat :create_folder  exported_scripts_folder
call %functions_folder%\variable.bat :create_folder  readdata_log_folder
call %functions_folder%\variable.bat :check_variable erase_previous
call %functions_folder%\variable.bat :check_variable erase_xml

goto:eof
:: =======================================================================================
