:: =======================================================================================
:: Main
::: Wait for multiple processes to finish.
::: This function defines 3 functions around a signal file:
::: - :receive
:::   Monitors the signal file and will only continue when the file has the specified
:::   number of lines. When the process continues the signal file is deleted.
::: - :send
:::   Writes a line to the signal file
::: - :cleanup
:::   Remove the signal file(s)
:::   Can be called with %root_dir% to clean up all signal files of the pipeline

::: The signal file is stored in the temporary directory (%TEMP%) with a *.signal filetype.
::: All functions should use the full path to a script (%~f0) as the name of the signal
::: File. This makes signals unique to pipelines and processes, but the uniform
::: for parallel processes. To use the path, the signal needs to be reformatted,
::: as a signal can only use [a-zA-Z0-9]+ as a format.

:: Input variables
::: 1. function:
:::   send:             send a signal
:::   receive:          wait for a signal
:::   sleep:            wait for %sleep_timer% seconds
:: =======================================================================================
setlocal

call %*

endlocal
goto:eof

:: =======================================================================================
:send
::: 1. signal: signal that processes emit when they are finished.
:::            (signals should be the full path to a batch file)
:: =======================================================================================
set signal=%~f1

call :check_variables 1 %*

if "%verbose%" == "true" (
    echo verbose - Sending signal: %signal%
)

:send_queue
echo 1 >> %TEMP%\%signal%.signal || goto:send_queue

goto:eof
:: =======================================================================================


:: =======================================================================================
:receive
::: 1. signal: signal that processes emit when they are finished.
:::            (signals should be the full path to a batch file)
::: 2. number: number of processes that should finish
:: =======================================================================================
set signal=%~f1
set number=%~2
set count=0
call :cleanup %signal%

call :check_variables 2 %*
call %functions_folder%\variable.bat :check_variable number

echo Waiting for %number% processes to finish
if "%verbose%" == "true" (
    echo   signal: %signal%
)

:receive_queue
if not exist %TEMP%\%signal%.signal (
    goto:receive_queue
)

for /F "tokens=3 delims= " %%L in ('find /v /c "" %TEMP%\%signal%.signal') do set newcount=%%L
if %count% NEQ %newcount% (
    echo %newcount% processes finished
)
set /a count=%newcount%
if %count% lss %number% goto:receive_queue

echo All processes done
call :cleanup %signal%
goto:eof
:: =======================================================================================


:: =======================================================================================
:sleep
::: global: sleep_timer: sleep for n seconds
::: 1. sleep_timer: sleep for n seconds, overriding global sleep_timer
:: =======================================================================================
setlocal

if "%~1" NEQ "" ( set sleep_timer=%~1 )
if defined sleep_timer (
    if "%verbose%" == "true" (
        echo verbose - Sleep seconds:  %sleep_timer%
    )
    timeout %sleep_timer% >nul
)
endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:cleanup
::: 1. signal: signal that processes emit when they are finished. The signal can also be
:::    a parent directory of the actual signal. For instance, pass %root_dir% to cleanup all
:::    signals from the current project.
:: =======================================================================================
set signal=%~1

call :check_variables 1 %*
if "%verbose%" == "true" (
    echo verbose - Clean up signal: %signal%
)
if defined TEMP (
    del /q %TEMP%\%signal%.signal 2> nul
    del /q %TEMP%\%signal%*.signal 2> nul
)

goto:eof
:: =======================================================================================


:: =======================================================================================
:check_variables
:: =======================================================================================

:: Set functions_folder to location of this script
set functions_folder=%~dp0

:: Check number of input variables
call %functions_folder%\variable.bat :check_parameters %*

:: Validate input variables
call %functions_folder%\variable.bat :check_variable signal

:: Cleanup signal name (waitfor only allows letters and numbers)
set signal=%signal:\=%
set signal=%signal:/=%
set signal=%signal: =%
set signal=%signal:-=%
set signal=%signal:_=%
set signal=%signal:.=%
set signal=%signal::=%

goto:eof
:: =======================================================================================
