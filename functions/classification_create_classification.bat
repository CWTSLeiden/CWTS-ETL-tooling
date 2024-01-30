:: =======================================================================================
:: Main
::: Create a multi-level classification of scientific publications based on
::: citation links between publications using the publicationclassification
::: Java package.
::: The classification parameter settings should be specified in the
::: global variables %classification_*%.
::: The classification parameter settings and the output of
::: publicationclassification are logged to time-stamped log files.

:: Global variables
::: server
::: classification_memory
::: classification_n_iterations
::: classification_resolution_micro_level
::: classification_threshold_micro_level
::: classification_resolution_meso_level
::: classification_threshold_meso_level
::: classification_resolution_macro_level
::: classification_threshold_macro_level
::: (optional) classification_pub_table
::: (optional) classification_cit_link_table
::: (optional) classification_classification_table

:: Input variables
::: 1. db_name:    name of the classification database
::: 2. log_folder: folder where this function will store its log files

:: Executables
::: java_exe
::: powershell_exe
::: publicationclassification_exe
:: =======================================================================================
setlocal

set db_name=%~1
set log_folder=%~2

call :check_variables 2 %*

echo ! IMPORTANT Check the classification parameter settings in settings.bat!
echo database: %db_name%
echo - n_iterations:            %classification_n_iterations%
echo - resolution_micro_level:  %classification_resolution_micro_level%
echo - threshold_micro_level:   %classification_threshold_micro_level%
echo - resolution_meso_level:   %classification_resolution_meso_level%
echo - threshold_meso_level:    %classification_threshold_meso_level%
echo - resolution_macro_level:  %classification_resolution_macro_level%
echo - threshold_macro_level:   %classification_threshold_macro_level%
pause

echo %db_name% - Create classification parameters log file.
(
    @echo publicationclassification - %timestamp%
    @echo.
    @echo Parameter               value
    @echo ---------------------------------------
    @echo n_iterations:           %classification_n_iterations%
    @echo resolution_micro_level: %classification_resolution_micro_level%
    @echo threshold_micro_level:  %classification_threshold_micro_level%
    @echo resolution_meso_level:  %classification_resolution_meso_level%
    @echo threshold_meso_level:   %classification_threshold_meso_level%
    @echo resolution_macro_level: %classification_resolution_macro_level%
    @echo threshold_macro_level:  %classification_threshold_macro_level%
) >> %log_folder%\publicationclassification_parameters_%timestamp%.log

set classification_log_file=%log_folder%\publicationclassification_%timestamp%.log
echo %db_name% - Creating classification
call "%java_exe%" -Xmx%classification_memory% -jar ^
    "%publicationclassification_exe%" ^
    "%server%" ^
    "%db_name%" ^
    "%classification_pub_table%" ^
    "%classification_cit_link_table%" ^
    "%classification_classification_table%" ^
    "true" ^
    %classification_n_iterations% ^
    %classification_resolution_micro_level% ^
    %classification_threshold_micro_level% ^
    %classification_resolution_meso_level% ^
    %classification_threshold_meso_level% ^
    %classification_resolution_macro_level% ^
    %classification_threshold_macro_level% ^
    > "%classification_log_file%"

echo Check log for values and errors.
echo - %classification_log_file%
:: List the number of clusters from the output
if "%verbose%" == "true" (
    call %powershell_exe% "Select-String -Path %classification_log_file% -Pattern '^(Micro|Meso|Macro)-level classification:' -Context 0,4 | ForEach-Object { $_.line; $_.Context.PostContext }"
)

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
call %functions_folder%\variable.bat :check_variable classification_memory
call %functions_folder%\variable.bat :check_variable classification_n_iterations
call %functions_folder%\variable.bat :check_variable classification_resolution_micro_level
call %functions_folder%\variable.bat :check_variable classification_threshold_micro_level
call %functions_folder%\variable.bat :check_variable classification_resolution_meso_level
call %functions_folder%\variable.bat :check_variable classification_threshold_meso_level
call %functions_folder%\variable.bat :check_variable classification_resolution_macro_level
call %functions_folder%\variable.bat :check_variable classification_threshold_macro_level
call %functions_folder%\variable.bat :default_variable classification_pub_table classification.pub
call %functions_folder%\variable.bat :default_variable classification_cit_link_table classification.cit_link
call %functions_folder%\variable.bat :default_variable classification_classification_table classification.pub_cluster

:: Validate input variables
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :create_folder  log_folder

:: Validate executables
if "%classification_32bit%" == "true" ( set publicationclassification_exe=%publicationclassification_32bit_exe% )
call %functions_folder%\variable.bat :check_file     java_exe
call %functions_folder%\variable.bat :check_file     publicationclassification_exe

:: Validate local variables
call %functions%\get_datetime.bat timestamp datetime
call %functions_folder%\variable.bat :check_variable timestamp

goto:eof
:: =======================================================================================
