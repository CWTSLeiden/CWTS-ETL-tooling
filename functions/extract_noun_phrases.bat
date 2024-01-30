:: =======================================================================================
:: Main
::: Use NPExtractorDB to extract noun phrases from text fields in the database and store
::: them to that same database after extracting.

:: Global variables
::: server
::: (optional) noun_phrase_extractor_memory_limit

:: Input variables
::: 1. db_name:    name of the database where the extracted noun phrases should be inserted.
::: 2. log_folder: log folder for this function.

:: Executables
::: java_exe
::: noun_phrase_extractor_exe
:: =======================================================================================
setlocal

set db_name=%~1
set log_folder=%~2

call :check_variables 2 %*

echo %db_name% - Extracting noun phrases

"%java_exe%" -Xmx%noun_phrase_extractor_memory_limit_arg% ^
    -jar %noun_phrase_extractor_exe% %server% %db_name% 24 ^
    > %log_folder%\noun_phrase_extraction.log ^
    2> %log_folder%\noun_phrase_extraction.error

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
call %functions_folder%\variable.bat :check_file     java_exe
call %functions_folder%\variable.bat :check_variable noun_phrase_extractor_exe
call %functions_folder%\variable.bat :check_variable server

:: Validate input variables
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :create_folder  log_folder

if defined noun_phrase_extractor_memory_limit (
    set noun_phrase_extractor_memory_limit_arg=%noun_phrase_extractor_memory_limit%
) else (
    set noun_phrase_extractor_memory_limit_arg=128G
)
call %functions_folder%\variable.bat :check_variable noun_phrase_extractor_memory_limit_arg

goto:eof
:: =======================================================================================
