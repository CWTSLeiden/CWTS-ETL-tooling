:: =======================================================================================
:: Main
::: Use BCP to load all parsed data into the database by calling a bcpdata.bat script
::: generated in the parsing step.
::: As this is usually called as an asynchronous process using `start` this script
::: sends a signal when the process has finished.

:: Input variables
::: 1. db_name:        name of the target database
::: 2. process_folder: location where parsed files are located
::: 3. bcp_log_folder: location of the bcp log folder
:: =======================================================================================

setlocal

set db_name=%~1
set process_folder=%~2
set process_folder_name=%~n2
set bcp_log_folder=%~3

set log_bcp_log_folder=%bcp_log_folder%\log
set error_bcp_log_folder=%bcp_log_folder%\error

call :check_variables 3 %*

echo %db_name% - %process_folder_name% - Loading data into database

:: Change current path to processing folder
cd /d "%process_folder%"

call bcpdata.bat
call :check_bcp_logfiles

robocopy "%process_folder%" "%error_bcp_log_folder%" *.error /mov /NFL /NDL /NJH /NJS /nc /ns /np | findstr /r /v "^$"
robocopy "%process_folder%" "%log_bcp_log_folder%" *.log /mov /NFL /NDL /NJH /NJS /nc /ns /np | findstr /r /v "^$"

:: Send signal to waiting processes
call %functions_folder%\wait.bat :send %~f0
endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_bcp_logfiles
::: Check all logfiles for lines containing the string "error" and move those to their
::: respective .error file
:: =======================================================================================
echo %db_name% - %process_folder_name% - Check BCP logfiles

for %%f in (*.log) do (
    findstr /I "error" %%f >nul
    if errorlevel 1 (
        rem
    ) else (
        (@echo Error exists in the log file %%f) >>%%~nf_log.error
    )
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
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :create_folder process_folder
call %functions_folder%\variable.bat :create_folder bcp_log_folder
call %functions_folder%\variable.bat :create_folder log_bcp_log_folder
call %functions_folder%\variable.bat :create_folder error_bcp_log_folder

goto:eof
:: =======================================================================================
