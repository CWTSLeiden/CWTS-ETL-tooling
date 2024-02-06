@echo off
:: =======================================================================================
:: Main
::: Download from AWS to folder

:: Global variables
::: (optional) aws_access_key_id
::: (optional) aws_secret_access_key

:: Input variables
::: 1. remote_url:    url of the AWS bucket for the dataset
::: 2. target_folder: target folder for the downloaded files
::: 3. target_name:   name of the dataset as used in the repository
::: 4. log_folder:    log folder for this function

:: Executables
::: aws
:: =======================================================================================
setlocal

set remote_url=%~1
set target_folder=%~2
set target_name=%~3
set log_folder=%~4

call :check_variables 4 %*

echo Downloading %target_name% data

call %functions%\get_datetime.bat timestamp "datetime"

set AWS_ACCESS_KEY_ID=%aws_access_key_id%
set AWS_SECRET_ACCESS_KEY=%aws_secret_access_key%

aws s3 sync ^
    --no-progress ^
    %no_sign_request_arg% ^
    %remote_url% %target_folder% ^
    >%log_folder%\download_%target_name%_%timestamp%.log

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

:: Check number of input variables
call %functions_folder%\variable.bat :check_parameters %*

:: Validate global variables
if not defined aws_access_key_id (
   set no_sign_request_arg=--no-sign-request
)
:: Validate input variables
call %functions_folder%\variable.bat :check_variable remote_url
call %functions_folder%\variable.bat :create_folder  target_folder
call %functions_folder%\variable.bat :check_variable target_name
call %functions_folder%\variable.bat :create_folder  log_folder

goto:eof
:: =======================================================================================
