:: =======================================================================================
:: Main
::: Collection of functions operating on variables

:: Global variables
::: (optional) verbose: if set, echo the values of the variables that are being checked.
:::                     otherwise, only echo on errors.

:: Input variables
::: 1. function: the function from this file to run
:::    (prefixed with a colon ':')
::: 2. variable: the string representation of the variable
:::    (without % delimiters: see documentation below)
::: =======================================================================================

::: ---------------------------------------------------------------------------------------
::: To eliminate some confusion regarding meta-variables:
::: this file is called with the string representation of a variable
::: So if we want to check a variable `%check_this_variable%` with the
::: value `this_is_the_value`, we call this script as following:
:::     check.bat :check_variable check_this_variable
::: in the function :check_variable %var% is set to the string
::: representation as well. Evaluation can occur in 3 layers:
:::
::: To check if %var% is defined, we would call:
:::     if defined var (...)
:::
::: to check if %check_this_variable% is defined, we would call:
:::     if defined %var% (...)
::: which is equivalent to
:::     if defined check_this_variable (...)
:::
::: to check the existence of this_is_the_value we would call:
:::     if exists !%var%! (...)
::: which is equivalent to
:::     if exists %check_this_variable% (...)
::: which is equivalent to
:::     if exists this_is_the_value (...)
:::
::: All variables in this script start with '_' to avoid collisions with other variables.
::: ---------------------------------------------------------------------------------------

call %*

goto:eof
:: =======================================================================================


:: =======================================================================================
:check_parameters
:: Check if the number of parameters provided to the script
:: Matches the actual number of parameters.

:: Input variables
::: 1. expected_n_params: expected number of parameters
::: 2. %*               : all parameters
:: =======================================================================================
setlocal enabledelayedexpansion

set _expected_n_params=%~1
set _n_params=-1
for %%a in (%*) do set /a _n_params+=1

if "%verbose%" == "true" (
    echo verbose - Parameters:     %_expected_n_params% expected, %_n_params% received
)
if not "%_expected_n_params%" == "%_n_params%" (
    echo error - Parameters: %_expected_n_params% expected, %_n_params% received
    for %%a in (%*) do if not "%%a" == "%1" echo - %%a
    call :exit
)

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_variable
:: Check if variable is defined.

:: Input variables
::: 1. var:   variable name
:: =======================================================================================
setlocal enabledelayedexpansion

set _var=%~1
if not defined %_var% (
    echo error - Variable not defined: %_var%
    call :exit
)
if "%verbose%" == "true" (
    echo verbose - Variable value: %_var%=!%_var%!
)

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:default_variable
:: Check if variable is defined, if not set it to a default value.

:: Input variables
::: 1. var:   variable name
::: 2. value: default value
:: =======================================================================================
set _var=%~1
set _value=%~2
if not defined %_var% (
    set %_var%=%_value%
)
if "%verbose%" == "true" (
    echo verbose - Variable value: %_var%=!%_var%!
)
goto:eof
:: =======================================================================================


:: =======================================================================================
:default_variable
:: Check if variable is defined, if not set it to a default value.

:: Input variables
::: 1. var:   variable name
::: 2. value: default value
:: =======================================================================================
set _var=%~1
set _value=%~2
if not defined %_var% (
    set %_var%=%_value%
)
if "%verbose%" == "true" (
    echo verbose - Variable value: %_var%=!%_var%!
)
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_folder
:: Check if folder variable is defined and if folder path exists.

:: Input variables
::: 1. folder:   folder variable name
:::    !folder!: folder path
:: =======================================================================================
setlocal enabledelayedexpansion

set _folder=%~1
call :check_variable %_folder%
if not exist "!%_folder%!" (
    echo error - Folder not found: '!%_folder%!'
    call :exit
)
if "%verbose%" == "true" (
    echo verbose - Folder exists:  %_folder%
)

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_file
:: Check if file variable is defined and if file exists.

:: Input variables
::: 1. file:   file variable name
:::    !file!: file name (including path and extension)
:: =======================================================================================
setlocal enabledelayedexpansion

set _file=%~1
call :check_variable %_file%
if not exist "!%_file%!" (
    echo error - File not found: '!%_file%!'
    call :exit
)
if "%verbose%" == "true" (
    echo verbose - File exists:    %_file%
)

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_extension
:: Check if file variable has the expected extension.

:: Input variables
::: 1. file:      file variable name
:::    !file!:    file name (including path and extension)
::: 2. extension: expected file extension (without leading dot)
:: =======================================================================================
setlocal enabledelayedexpansion

set _file=%~1
set _extension=%~2
call :check_variable %_file%
for %%f in (!%_file%!) do set _file_extension=%%~xf
if not "%_file_extension%" == ".%_extension%" (
    echo error - Wrong extension: %_file_extension%
    echo         Expected !%_file%! to have .%_extension% extension.
    call :exit
)
if "%verbose%" == "true" (
    echo verbose - File extension: %_file%=%_extension%
)

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:create_folder
:: Check if folder variable is defined and create the folder if the folder path does not exist.

:: Input variables
::: 1. folder:   folder variable name
:::    !folder!: folder path
:: =======================================================================================
setlocal enabledelayedexpansion

set _folder=%~1
call :check_variable %_folder%
if not exist "!%_folder%!" (
    md "!%_folder%!"
    echo verbose - Folder created: %_folder%
)
if "%verbose%" == "true" (
    echo verbose - Folder exists:  %_folder%
)

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:exit
:: Prompt the user to exit the script. This also exits the script that calls this function.
:: =======================================================================================
:: Prompts the user to stop the entire procedure
cmd /c exit -1073741510
goto:eof
:: =======================================================================================
