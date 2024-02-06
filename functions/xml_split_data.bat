@echo off
:: =======================================================================================
:: Main
::: Use the xml file splitter to split xml files into manageable chunks.

:: Global variables
::: xml_file_splitter_find_files_recursive
::: (optional) xml_file_splitter_block_size
::: (optional) xml_file_splitter_clean_cdata
::: (optional) xml_file_splitter_clean_tags (enclosed in "" because of spaces)
::: (optional) xml_file_splitter_fix_crossref_namespaces_arg
::: (optional) xml_file_splitter_include_xml_prolog_arg
::: (optional) xml_file_splitter_order_mixed_values_arg
::: (optional) xml_file_splitter_remove_namespaces
::: (optional) xml_file_splitter_remove_original_files
::: (optional) xml_file_splitter_showoutput_arg
::: (optional) xml_file_splitter_split_tag

:: Input variables
::: 1. db_name:                      name of the database
::: 2. process_folder:               folder where parsing should take place
::: 3. xml_data_folder:              folder containing files to parse
:::                                  (usually identical to process_folder)
::: 4. xml_file_splitter_log_folder: log folder for this function

:: Executables
::: xml_filesplitter_exe
:: =======================================================================================
setlocal

set db_name=%~1
set process_folder=%~2
set process_folder_name=%~n2
set xml_data_folder=%~3
set xml_file_splitter_log_folder=%~4

call :check_variables 4 %*

cd /d %process_folder%

echo %db_name% - %process_folder_name% - Split XML-files.

"%xml_file_splitter_exe%" ^
    XmlFolder=%xml_data_folder% ^
    FindfilesRecursive=%xml_file_splitter_find_files_recursive% ^
    LogFolder="%xml_file_splitter_log_folder%" ^
    %xml_file_splitter_split_tag_arg% ^
    %xml_file_splitter_clean_tags_arg% ^
    %xml_file_splitter_block_size_arg% ^
    %xml_file_splitter_clean_cdata_arg% ^
    %xml_file_splitter_remove_namespaces_arg% ^
    %xml_file_splitter_fix_crossref_namespaces_arg% ^
    %xml_file_splitter_order_mixed_values_arg% ^
    %xml_file_splitter_include_xml_prolog_arg% ^
    %xml_file_splitter_remove_original_files_arg% ^
    %xml_file_splitter_showoutput_arg% ^

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
call %functions_folder%\variable.bat :check_file     xml_file_splitter_exe
call %functions_folder%\variable.bat :check_variable xml_file_splitter_find_files_recursive

:: Validate input variables
call %functions_folder%\variable.bat :create_folder  process_folder
call %functions_folder%\variable.bat :check_folder   xml_data_folder
call %functions_folder%\variable.bat :create_folder  xml_file_splitter_log_folder

:: Set xml_file_splitter optional arguments only if defined
if defined xml_file_splitter_remove_original_files (
    set xml_file_splitter_remove_original_files_arg=Remove_original_files=%xml_file_splitter_remove_original_files%
)
if defined xml_file_splitter_split_tag (
    set xml_file_splitter_split_tag_arg=SplitTag=%xml_file_splitter_split_tag%
)
if defined xml_file_splitter_clean_tags (
    set xml_file_splitter_clean_tags_arg=CleanTags=%xml_file_splitter_clean_tags%
)
if defined xml_file_splitter_block_size (
    set xml_file_splitter_block_size_arg=BlockSize=%xml_file_splitter_block_size%
)
if defined xml_file_splitter_clean_cdata (
    set xml_file_splitter_clean_cdata_arg=clean_cdata=%xml_file_splitter_clean_cdata%
)
if defined xml_file_splitter_remove_namespaces (
    set xml_file_splitter_remove_namespaces_arg=remove_namespaces=%xml_file_splitter_remove_namespaces%
)
if defined xml_file_splitter_fix_crossref_namespaces (
    set xml_file_splitter_fix_crossref_namespaces_arg=fix_crossref_namespaces=%xml_file_splitter_fix_crossref_namespaces%
)
if defined xml_file_splitter_order_mixed_values (
    set xml_file_splitter_order_mixed_values_arg=OrderMixedValues=%xml_file_splitter_order_mixed_values%
)
if defined xml_file_splitter_include_xml_prolog (
    set xml_file_splitter_include_xml_prolog_arg=Include_xml_prolog=%xml_file_splitter_include_xml_prolog%
)
if defined xml_file_splitter_remove_original_files (
    set xml_file_splitter_remove_original_files_arg=Remove_original_files=%xml_file_splitter_remove_original_files%
)
if "%verbose%" == "true" (
    set xml_file_splitter_showoutput_arg=showoutput=true
)

goto:eof
:: =======================================================================================
