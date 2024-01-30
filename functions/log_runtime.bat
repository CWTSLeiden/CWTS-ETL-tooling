:: =======================================================================================
:: Main
::: Log the duration of a running process.

:: Global variables
::: runtime_log_folder

:: Input variables
::: 1. function:     begin or end
::: 2. process_name: name of process to log the runtime of.
:: =======================================================================================
setlocal

if not defined runtime_log_folder (goto:eof)

set function=%~1
set process_name=%~2

call :check_variables 2 %*

call %functions_folder%\get_datetime.bat _date date
call %functions_folder%\get_datetime.bat _time time

set runtime_log_file=%runtime_log_folder%\%process_name%.log

call %function%

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:begin
:: =======================================================================================
echo %process_name%> %runtime_log_file%
echo Started - %_date% - %_time%>> %runtime_log_file%

goto:eof
:: =======================================================================================


:: =======================================================================================
:end
:: =======================================================================================
echo Ended   - %_date% - %_time%>> %runtime_log_file%

goto:eof
:: =======================================================================================


:: =======================================================================================
:check_variables
:: =======================================================================================
:: Set functions_folder to location of this script
set functions_folder=%~dp0

:: Check number of input variables
call %functions_folder%\variable.bat :check_parameters %*

:: Validate global variables
call %functions_folder%\variable.bat :create_folder  runtime_log_folder

:: Validate input variables
call %functions_folder%\variable.bat :check_variable function
call %functions_folder%\variable.bat :check_variable process_name

goto:eof
:: =======================================================================================
