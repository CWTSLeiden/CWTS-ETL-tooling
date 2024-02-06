@echo off
:: =======================================================================================
:: Main
::: Use json parser to parse raw json files and generate the .bat and .sql scripts
::: needed to set up the json database.
::: As this is usually called as an asynchronous process using `start` this script
::: sends a signal when the process has finished.

:: Global variables
::: server
::: (optional) json_parser_data_version
::: (optional) json_parser_buffer_size
::: (optional) json_parser_source_file_extension
::: (optional) json_parser_output_file_extension
::: (optional) json_parser_record_id_header
::: (optional) json_parser_bcp_command
::: (optional) json_parser_folderfilecolumns
::: (optional) json_parser_first_prefix
::: (optional) json_parser_encoding

:: Input variables
::: 1. db_name:                  name of the database
::: 2. data_source:              name of the data source (passed to DataSource option for JsonParser)
::: 3. process_folder:           folder where parsing should take place
::: 4. json_data_folder:         folder containing files to parse
::: 5. generated_scripts_folder: target location for generated sql/bat scripts
::: 6. json_parser_log_folder:   log folder for this function
::: 7. erase_previous:           if set to "erase_previous" erase xxx/sql/bat files from previous runs

:: Executables
::: json_parser_exe
:: =======================================================================================
setlocal

set db_name=%~1
set data_source=%~2
set process_folder=%~3
set process_folder_name=%~n3
set json_data_folder=%~4
set generated_scripts_folder=%~5
set json_parser_log_folder=%~6
set erase_previous=%~7

call :check_variables 7 %*

cd %process_folder%

:: Erase results from previous runs.
if %erase_previous% == erase_previous (
    if exist *.xxx (
        echo Erasing previously generated .xxx files.
        erase *.xxx
    )
    if exist *.sql (
        echo Erasing previously generated .sql files.
        erase *.sql
    )
    if exist *.bat (
        echo Erasing previously generated .bat files.
        erase *.bat
    )
)

echo %db_name% - %process_folder_name% - Parsing data

"%json_parser_exe%" ^
    DataSource="%data_source%" ^
    SourceFolder="%json_data_folder%" ^
    OutputFolder="%process_folder%" ^
    server="%server%" ^
    database="%db_name%" ^
    %json_parser_data_version_arg% ^
    %json_parser_buffer_size_arg% ^
    %json_parser_source_file_extension_arg% ^
    %json_parser_output_file_extension_arg% ^
    %json_parser_record_id_header_arg% ^
    %json_parser_bcp_command_arg% ^
    %json_parser_folderfilecolumns_arg% ^
    %json_parser_first_prefix_arg% ^
    %json_parser_encoding_arg%

:: Copy generated scripts.
copy "create_primary_keys.sql" "%generated_scripts_folder%\create_primary_keys.sql" >nul
copy "create_tables.sql" "%generated_scripts_folder%\create_tables.sql" >nul
copy "delete_tables.sql" "%generated_scripts_folder%\delete_tables.sql" >nul
copy "bcpdata.bat" "%generated_scripts_folder%\bcp_data.bat" >nul

:: Move application log folder to log location
robocopy "%process_folder%" "%json_parser_log_folder%" *.log *.error /mov /e /NFL /NDL /NJH /NJS /nc /ns /np | findstr /r /v "^$"

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
call %functions_folder%\variable.bat :check_file     json_parser_exe
call %functions_folder%\variable.bat :check_variable server

:: Validate input variables
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :check_variable data_source
call %functions_folder%\variable.bat :create_folder  process_folder
call %functions_folder%\variable.bat :check_folder   json_data_folder
call %functions_folder%\variable.bat :create_folder  generated_scripts_folder
call %functions_folder%\variable.bat :create_folder  json_parser_log_folder
call %functions_folder%\variable.bat :check_variable erase_previous

:: Set json_parser optional arguments only if defined
if defined json_parser_data_version (
    set json_parser_data_version_arg=DataVersion=%json_parser_data_version%
)
if defined json_parser_buffer_size (
    set json_parser_buffer_size_arg=BufferSize=%json_parser_buffer_size%
)
if defined json_parser_output_file_extension (
    set json_parser_output_file_extension_arg=OutputFileExtension=%json_parser_output_file_extension%
)
if defined json_parser_source_file_extension (
    set json_parser_source_file_extension_arg=SourceFileExtension=%json_parser_source_file_extension%
)
if defined json_parser_record_id_header (
    set json_parser_record_id_header_arg=RecordIdHeader=%json_parser_record_id_header%
)
if defined json_parser_bcp_command (
    set json_parser_bcp_command_arg=bcpCommand=%json_parser_bcp_command%
)
if defined json_parser_folderfilecolumns (
    set json_parser_folderfilecolumns_arg=folderfilecolumns=%json_parser_folderfilecolumns%
)
if defined json_parser_first_prefix (
    set json_parser_first_prefix_arg=firstPrefix=%json_parser_first_prefix%
)
if defined json_parser_encoding (
    set json_parser_encoding_arg=encoding=%json_parser_encoding%
)

goto:eof
:: =======================================================================================
