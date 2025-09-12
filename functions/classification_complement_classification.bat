:: =======================================================================================
:: Main
::: Add publications to a classification of scientific publications based on 
::: their citation links.
::: The classification complement parameter settings should be specified in the
::: global variables %classification_*%.
::: The output of publicationclassificationcomplement is logged to a time-stamped
::: log file.

:: Global variables
::: server
::: classification_n_iterations
::: classification_resolution_micro_level
::: (optional) classification_schema
::: (optional) classification_pub_complement_table
::: (optional) classification_cit_link_complement_table
::: (optional) classification_classification_complement_table

:: Input variables
::: 1. db_name:    name of the classification database
::: 2. log_folder: folder where this function will store its log files

:: Executables
::: publicationclassificationcomplement_exe
:: =======================================================================================
setlocal

set db_name=%~1
set log_folder=%~2

call :check_variables 2 %*

call "%publicationclassificationcomplement_exe%" ^
    --server "%server%" ^
    --database "%db_name%" ^
	--schema "%classification_schema%" ^
	--pub_table "%classification_pub_complement_table%" ^
	--cit_link_table "%classification_cit_link_complement_table%" ^
	--classification_table "%classification_classification_complement_table%" ^
	--resolution "%classification_resolution_micro_level%" ^
	--n_iterations "%classification_n_iterations%" ^
	> %log_folder%\publicationclassificationcomplement_%timestamp%.log

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
call %functions_folder%\variable.bat :check_variable classification_n_iterations
call %functions_folder%\variable.bat :check_variable classification_resolution_micro_level
call %functions_folder%\variable.bat :default_variable classification_schema classification
call %functions_folder%\variable.bat :default_variable classification_pub_complement_table pub_complement
call %functions_folder%\variable.bat :default_variable classification_cit_link_complement_table cit_link_complement
call %functions_folder%\variable.bat :default_variable classification_classification_complement_table pub_cluster_complement

:: Validate input variables
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :create_folder  log_folder

:: Validate executables
call %functions_folder%\variable.bat :check_file     publicationclassificationcomplement_exe

:: Validate local variables
call %functions%\get_datetime.bat timestamp datetime
call %functions_folder%\variable.bat :check_variable timestamp

goto:eof
:: =======================================================================================
