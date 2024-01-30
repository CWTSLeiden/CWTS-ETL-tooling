:: =======================================================================================
:: Main
::: Take the range of indexes between start_index and end_index and distribute them
::: equally over the number of processes.
::: The indexes to be processed by process %n% will be written
::: to a process_%n%.dat file in the temp_folder.

:: Input variables
::: 1. temp_folder:         target folder for numbered directories
::: 2. number_of_processes: number of process.dat files
::: 3. start_index:         the start index
::: 4. end_index:           the end index
:: =======================================================================================
setlocal enabledelayedexpansion

set temp_folder=%~1
set number_of_processes=%~2
set start_index=%~3
set end_index=%~4

call :check_variables 4 %*

set /a number_of_indexes=(%end_index%-%start_index%)+1
set /a indexes_per_process=%number_of_indexes%/%number_of_processes%
set /a surplus_indexes=%number_of_indexes% %% %number_of_processes%

echo Splice indexes from %start_index% to %end_index% into %number_of_processes% subfolders in %temp_folder%.

:: Error if the number of files in data_folder is smaller than number of processes.
:: For instance, when the data_folder is empty.
if %number_of_processes% GTR %number_of_files% (
    echo Number of process is bigger than number of indexes
    call %functions_folder%\variable.bat :exit
)

echo Create indexes.dat files

:: Create a process_n.dat file in each process folder containing the indexes
:: To be processed in that process.
set target_index=%start_index%
for /L %%i in (1,1,%number_of_processes%) do (
    call :create_indexes_batch %%i
)

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:create_indexes_batch
:: Input parameters
::: 1. process_number
:: =======================================================================================
set process_number=%~1

set current_indexes_per_process=%indexes_per_process%
if %process_number% LEQ %surplus_indexes% (set /a current_indexes_per_process+=1)

for /L %%j in (1,1,%current_indexes_per_process%) do (
    if !target_index! LEQ %end_index% (
        @echo !target_index! >> %temp_folder%\process_%process_number%.dat
    )
    set /a target_index+=1
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
call %functions_folder%\variable.bat :create_folder  temp_folder
call %functions_folder%\variable.bat :check_variable number_of_processes
call %functions_folder%\variable.bat :check_variable start_index
call %functions_folder%\variable.bat :check_variable end_index

goto:eof
:: =======================================================================================
