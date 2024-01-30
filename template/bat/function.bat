:: =======================================================================================
:: Main
::: TODO Description of the main function.

:: parameters

:: global variables
::: TODO global_variable_1
::: TODO global_variable_2

:: executables
::: TODO program_exe

:: input variables
::: 1. TODO input_variable_1: description of input_variable_1
::: 2. TODO input_variable_2: description of input_variable_2
:: =======================================================================================

setlocal

set input_variable_1=%~1
set input_variable_2=%~2

call :check_variables N %*

echo %db_name% - TODO Description of current action

:: TODO main function

endlocal
goto:eof

:: =======================================================================================
:check_variables
:: =======================================================================================

:: set functions_folder to location of this script
set functions_folder=%~dp0
:: set program_folder to relative location of this script
set programs_folder=%~dp0\..\programs

:: get executable paths
call %programs_folder%\executables.bat

:: check number of input parameters
call %functions_folder%\variable.bat :check_parameters %*

:: validate global variables
call %functions_folder%\variable.bat :check_variable global_variable_1
call %functions_folder%\variable.bat :check_variable global_variable_1

:: validate input variables
call %functions_folder%\variable.bat :check_variable local_variable_1
call %functions_folder%\variable.bat :check_variable local_variable_2

goto:eof
:: =======================================================================================
