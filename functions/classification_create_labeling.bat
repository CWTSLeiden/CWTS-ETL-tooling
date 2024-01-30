:: =======================================================================================
:: Main
::: Generate labels for the clusters of a classification using the OpenAI GPT
::: language model.
::: The classification labeling parameter settings should be specified in the
::: global variables %classification_*%.
::: The output of publicationclassificationlabeling is logged to a time-stamped
::: log file.

:: Global variables
::: server
::: classification_openai_api_key
::: (optional) classification_pub_titles_table
::: (optional) classification_label_table
::: (optional) classification_pub_titles_table
::: (optional) classification_label_table
::: (optional) classification_openai_gpt_model
::: (optional) classification_print_labeling

:: Input variables
::: 1. db_name:    name of the classification database
::: 2. log_folder: folder where this function will store its log files

:: Executables
::: java_exe
::: publicationclassificationlabeling_exe
:: =======================================================================================
setlocal

set db_name=%~1
set log_folder=%~2

call :check_variables 2 %*

call "%java_exe%" -jar "%publicationclassificationlabeling_exe%" ^
    "%server%" ^
    "%db_name%" ^
    "%classification_pub_titles_table%" ^
    "%classification_label_table%" ^
    "%classification_openai_api_key%" ^
    "%classification_openai_gpt_model%" ^
    "%classification_print_labeling%" ^
    > %log_folder%\publicationclassificationlabeling_%timestamp%.log

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
call %functions_folder%\variable.bat :check_variable classification_openai_api_key
call %functions_folder%\variable.bat :default_variable classification_pub_titles_table classification.cluster_pub_titles
call %functions_folder%\variable.bat :default_variable classification_label_table classification.cluster_labels
call %functions_folder%\variable.bat :default_variable classification_openai_gpt_model gpt-3.5-turbo-1106
call %functions_folder%\variable.bat :default_variable classification_print_labeling false

:: Validate input variables
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :create_folder  log_folder

:: Validate executables
call %functions_folder%\variable.bat :check_file     java_exe
call %functions_folder%\variable.bat :check_file     publicationclassificationlabeling_exe

:: Validate local variables
call %functions%\get_datetime.bat timestamp datetime
call %functions_folder%\variable.bat :check_variable timestamp

goto:eof
:: =======================================================================================
