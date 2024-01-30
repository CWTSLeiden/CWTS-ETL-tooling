:: =======================================================================================
:: Main
::: Store a value of datetime in a variable
::: After calling the function, the help variables are available to create custom
::: timestamps. (_year, _month, _day, _hour, _minute, _second)

:: Input variables
::: 1. variable: The variable which will contain the timestamp
::: 2. format:   The expected timestamp format
:::              datetime: YYYYMMDDThhmmss
:::              date:     YYYYMMDD
:::              time:     hhmmss
:: =======================================================================================

set _variable=%~1
set _format=%~2

call :check_variables 2 %*

for /f "tokens=2 delims==" %%G in ('wmic os get localdatetime /value') do set _dt=%%G

set _year=%_dt:~0,4%
set _month=%_dt:~4,2%
set _day=%_dt:~6,2%

set _hour=%_dt:~8,2%
set _minute=%_dt:~10,2%
set _second=%_dt:~12,2%


set _return=%_year%%_month%%_day%T%_hour%%_minute%%_second%
if "%_format%" == "datetime" (
    set _return=%_year%%_month%%_day%T%_hour%%_minute%%_second%
)
if "%_format%" == "date" (
    set _return=%_year%%_month%%_day%
)
if "%_format%" == "time" (
    set _return=%_hour%:%_minute%:%_second%
)

set "%_variable%=%_return%"

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
call %functions_folder%\variable.bat :check_variable  _variable
call %functions_folder%\variable.bat :check_variable  _format

goto:eof
:: =======================================================================================
