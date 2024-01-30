:: =======================================================================================
:: Main
::: Optimize the tables using MatLab and the scripts in %classification_functions_folder%

:: Global variables
::: server

:: Input variables
::: 1. db_name:     name of the classification database
::: 2. data_folder: folder where output files are stored
::: 3. log_folder:  folder where this function will store its log files

:: Executables
::: matlab_exe
:: =======================================================================================
setlocal

set db_name=%~1
set data_folder=%~2
set log_folder=%~3

call :check_variables 3 %*

echo Optimize labels 1

sqlcmd -S %server% -d %db_name% -E -Q "set nocount on select * from _labels1 order by cluster_id1" -o %data_folder%\labels1a.txt -s"	" -W
findstr /R /C:"^.*[A-Za-z0-9].*$" %data_folder%\labels1a.txt > %data_folder%\labels1b.txt
"%matlab_exe%" -nodisplay -nosplash -nodesktop -minimize -r " cd('%functions_folder%\classification'); folder = '%data_folder%'; input_file = 'labels1b.txt'; output_file = 'labels1c.txt'; optimize_labels1; exit" -wait
bcp %db_name%.dbo.labels1 in "%data_folder%\labels1c.txt" -c -t"	" -S %server% -T -F2 -e %error_folder%\labels1.error >%log_folder%\labels1.log
sqlcmd -S %server% -d "%db_name%" -Q "alter table labels1 add constraint pk_labels1 primary key(cluster_id1)" > "%log_folder%\labels1.log"
sqlcmd -S %server% -d "%db_name%" -Q "drop table _labels1" > "%log_folder%\drop_labels1.log"


echo Optimize labels 2

sqlcmd -S %server% -d %db_name% -E -Q "set nocount on select * from _labels2 order by cluster_id2" -o %data_folder%\labels2a.txt -s"	" -W
findstr /R /C:"^.*[A-Za-z0-9].*$" %data_folder%\labels2a.txt > %data_folder%\labels2b.txt
"%matlab_exe%" -nodisplay -nosplash -nodesktop -minimize -r " cd('%functions_folder%\classification'); folder = '%data_folder%'; input_file = 'labels2b.txt'; output_file = 'labels2c.txt'; optimize_labels2; exit" -wait
bcp %db_name%.dbo.labels2 in "%data_folder%\labels2c.txt" -c -t"	" -S %server% -T -F2 -e %error_folder%\labels2.error >%log_folder%\labels2.log
sqlcmd -S %server% -d "%db_name%" -Q "alter table labels2 add constraint pk_labels2 primary key(cluster_id2)" > "%log_folder%\labels2.log"
sqlcmd -S %server% -d "%db_name%" -Q "drop table _labels2" > "%log_folder%\drop_labels2.log"

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

:: Check number of input variables
call %functions_folder%\variable.bat :check_parameters %*

:: Validate global variables
call %functions_folder%\variable.bat :check_variable server

:: Check parameters
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :create_folder  data_folder
call %functions_folder%\variable.bat :create_folder  log_folder

set error_folder=%log_folder%\error
call %functions_folder%\variable.bat :create_folder error_folder

:: Validate executables
call %functions_folder%\variable.bat :check_file matlab_exe

goto:eof
:: =======================================================================================
