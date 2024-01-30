:: =======================================================================================
:: Main
::: Use curl to download a single file.

:: Global variables
::: (optional) curl_header

:: Input variables
::: 1. remote_url:  url of the file to download
::: 2. target_file: target file for the downloaded file (including path and extension)

:: Executables
::: curl_exe
:: =======================================================================================
setlocal

set "remote_url=%~1"
set target_file=%~2
set target_file_name=%~n2
set target_folder=%~dp2
set header_target_folder=%target_folder%\headers

call :check_variables

echo Downloading data to %target_file%

:: Write information headers for the target file
"%curl_exe%" -I -R --silent --insecure -L %curl_header_arg% ^
    "%remote_url%" >%header_target_folder%\%target_file_name%_header_information.txt

:: Download the target file
"%curl_exe%" --silent --insecure -L %curl_header_arg% ^
    "%remote_url%" ^
    -o "%target_file%"

:: Send signal to waiting processes
call %functions_folder%\wait.bat :send %~f0

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

:: Validate global variables
call %functions_folder%\variable.bat :check_file     curl_exe

:: Validate input variables
call %functions_folder%\variable.bat :check_variable remote_url
call %functions_folder%\variable.bat :check_variable target_file
call %functions_folder%\variable.bat :check_variable target_file_name
call %functions_folder%\variable.bat :create_folder  target_folder
call %functions_folder%\variable.bat :create_folder  header_target_folder

if defined curl_header (
    set curl_header_arg=-H %curl_header%
)

goto:eof
:: =======================================================================================
