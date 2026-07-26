:: =======================================================================================
:: Main
::: Report the size of each database in a comma-separated list and write the
::: results to a file in the same format as log_folder_size.bat
::: ("<name>`t<size in GB>"), so database sizes can be compared between runs.

:: Global variables
::: server

:: Input variables
::: 1. databases: comma-separated list of database names
::: 2. log_file:  file the database sizes are written to
:: =======================================================================================
setlocal

set databases=%~1
set log_file=%~2
set log_folder=%~dp2

call :check_variables 2 %*

echo Log database sizes: %databases%

type nul > "%log_file%"
for %%d in (%databases%) do (
    for /f "delims=" %%s in ('sqlcmd -S %server% -d %%d -E -m 1 -h-1 -W -Q "set nocount on; select cast(coalesce(sum(size*8.0/1024/1024), 0) as decimal(38,2)) from sys.database_files"') do (
        echo %%d	%%s>> "%log_file%"
    )
)
%powershell_exe% "$total = 0; Get-Content '%log_file%' | ForEach-Object { $total += [decimal]($_ -replace '^.*\t','') }; 'TOTAL	{0}' -f $total | Out-File -FilePath '%log_file%' -Encoding utf8 -Append"

call %functions_folder%\echo.bat :verbose "Size of databases:"
for /f "usebackq delims=" %%l in ("%log_file%") do (
    call %functions_folder%\echo.bat :verbose "%%l"
)

endlocal
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
call %functions_folder%\variable.bat :check_variable server

:: Validate input variables
call %functions_folder%\variable.bat :check_variable  databases
call %functions_folder%\variable.bat :check_variable  log_file
call %functions_folder%\variable.bat :create_folder  log_folder

goto:eof
:: =======================================================================================
