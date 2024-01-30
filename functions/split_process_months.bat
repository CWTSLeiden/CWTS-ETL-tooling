:: =======================================================================================
:: Main
::: Take the range of indexes between start_date (yyyymm) and end_date (yyyymm) and distribute
::: them equally over the number of processes.
::: The indexes to be processed by process %n% will be written
::: to a dates.dat file in the temp_folder.

:: Input variables
::: 1. temp_folder:         target folder for numbered directories
::: 2. number_of_processes: number of dates.dat files
::: 3. start_date:          format (yyyymm)
::: 4. end_date:            format (yyyymm)

:: Executables
::: powershell_exe
:: =======================================================================================
setlocal enabledelayedexpansion

set temp_folder=%~1
set number_of_processes=%~2
set start_date=%~3
set end_date=%~4

call :check_variables 4 %*

call :calculate_n_months
set /a number_of_dates=%n_months%+1
set /a dates_per_process=%number_of_dates%/%number_of_processes%
set /a surplus_dates=%number_of_dates% %% %number_of_processes%

echo Splice dates from %start_date% to %end_date% into %number_of_processes% folder(s) in %temp_folder%.

if %number_of_processes% GTR %number_of_dates% (
    echo Number of process is bigger than number of dates
    call %functions_folder%\variable.bat :exit
)

echo Create dates.dat files

:: Create a dates.dat file in the temp folder containing the dates
:: To be processed in that process.
set date_index=0
for /L %%i in (1,1,%number_of_processes%) do (
    call :create_date_batch %%i
)

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:create_date_batch
:: Input parameters
::: 1. process_number
:: =======================================================================================
set process_number=%~1

set current_dates_per_process=%dates_per_process%
if %process_number% LEQ %surplus_dates% (set /a current_dates_per_process+=1)

for /L %%j in (1,1,%current_dates_per_process%) do (
    if !date_index! LEQ %number_of_dates% (
        for /f "delims=" %%i in ('%powershell_exe% "& echo ((Get-Date '%start_year%/%start_month%').AddMonths(!date_index!)).ToString('yyyyMM')"') do (
            @echo %%i >> %temp_folder%\dates_%process_number%.dat
        )
    )

    set /a date_index+=1
)

goto:eof
:: =======================================================================================


:: =======================================================================================
:calculate_n_months
:: =======================================================================================

for /f "tokens=* delims=0" %%a in ("%start_date:~-2%") do set start_month=%%a
set start_year=%start_date:~,4%

for /f "tokens=* delims=0" %%a in ("%end_date:~-2%") do set end_month=%%a
set end_year=%end_date:~,4%

set /a n_months=(%start_month%-%end_month% + (12 * (%start_year%-%end_year%)))

if %n_months% LSS 0 (
    set /a n_months = %n_months%*-1
)

goto:eof
:: =======================================================================================

:: =======================================================================================
:check_variables
:: =======================================================================================

:: Set functions_folder to location of this script
set functions_folder=%~dp0
:: set program_folder to relative location of this script
set programs_folder=%~dp0\..\programs

:: get executable paths
call %programs_folder%\executables.bat

:: Check number of input variables
call %functions_folder%\variable.bat :check_parameters %*

:: Validate input variables
call %functions_folder%\variable.bat :create_folder  temp_folder
call %functions_folder%\variable.bat :check_variable number_of_processes
call %functions_folder%\variable.bat :check_variable start_date
call %functions_folder%\variable.bat :check_variable end_date

goto:eof
:: =======================================================================================
