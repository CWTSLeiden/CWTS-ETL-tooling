:: =======================================================================================
:: Main
::: Read variables into memory from outside the pipeline

:: Global variables
::: (optional) verbose

:: Input variables
::: 1. (optional) file: the file to read the secret from
:::    filename.txt - read the first line from the file
:::                   if %variable% is not set, read into %filename%
:::    filename.bat - read all the 'set' statements from the file
:::    if file is not set, search for the first secrets.bat file up the directory tree
::: 2. (optional) variable: the variable to read the secret into (without % delimiters)
:: =======================================================================================

set _file=%~1
set _file_extension=%~x1
set _file_name=%~n1
set _var=%~2

call :check_variables
if not defined _file (goto:eof)

if "%verbose%" == "true" (
    echo verbose - Read secrets from %_file%
)

if "%_file_extension%" == ".txt" (
    call :secret_txt "%_file%" "%_file_name%" %_var%
) else if "%_file_extension%" == ".bat" (
    call :secret_bat "%_file%"
) else (
    echo error   - File type %_file_extension% unsupported.
)

goto:eof
:: =======================================================================================


:: =======================================================================================
:secret_txt
:: =======================================================================================
set __file=%~1
set __file_name=%~2
set __var=%~3
call "%functions_folder%\variable.bat" :check_file __file
call "%functions_folder%\variable.bat" :check_variable __file_name
if not defined __var (
    set __var=%__file_name%
)

set /p %__var%=<"%__file%"

setlocal enabledelayedexpansion
if "%verbose%" == "true" (
    echo verbose - Secret variable: set %__var%=!%__var%!
)
endlocal

goto:eof
:: =======================================================================================


:: =======================================================================================
:secret_bat
:: =======================================================================================
set __file=%~1
call "%functions_folder%\variable.bat" :check_file __file

for /f "tokens=*" %%s in ('findstr /r "^set " "%__file%"') do (
    if "%verbose%" == "true" (
        echo verbose - Secret variable: %%s
    )
    call %%s
)

goto:eof
:: =======================================================================================


:: =======================================================================================
:find_secrets_file
:: =======================================================================================
set __dir=.
set n=10

:loop_start
set __dir=%__dir%\..
set /a n=%n%-1
if exist "%__dir%\secrets.bat" (
    set _file=%__dir%\secrets.bat
    set _file_extension=.bat
    goto:eof
)
if %n% LEQ 0 (
    goto:eof
)
goto:loop_start
:: =======================================================================================


:: =======================================================================================
:check_variables
:: =======================================================================================

:: Set functions_folder to location of this script
set functions_folder=%~dp0

if not defined _file (
    call :find_secrets_file
)
if not defined _file (
    if "%verbose%" == "true" (
        echo verbose - No secrets file found
    )
)

goto:eof
:: =======================================================================================
