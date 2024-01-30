:: =======================================================================================
:: Main
::: Load the VOSviewer map file data into the classification database.

:: Global variables
::: server

:: Input variables
::: 1. db_name:     name of the classification database
::: 2. data_folder: folder where VOSviewer output files are stored
::: 3. sql_log_folder:  folder where this function will store its sql log files
::: 4. bcp_log_folder:  folder where this function will store its bcp log files
:: =======================================================================================
setlocal

set db_name=%~1
set data_folder=%~2
set sql_log_folder=%~3
set bcp_log_folder=%~4

call :check_variables 4 %*

::Bulk copy tables
echo %db_name% - Bulk copy VOSviewer map data

::Macro_clusters
sqlcmd -S %server% -d "%db_name%" -Q "truncate table vosviewer.map_macro_clusters" > "%sql_log_folder%\truncate_table_map_macro_clusters.log"
bcp %db_name%.vosviewer.map_macro_clusters in "%data_folder%\map_macro_clusters.txt" -c -t"	" -S %server% -T -F2 -e %error_bcp_log_folder%\map_macro_clusters.error >%log_bcp_log_folder%\map_macro_clusters.log

::Meso_clusters
sqlcmd -S %server% -d "%db_name%" -Q "truncate table vosviewer.map_meso_clusters" > "%sql_log_folder%\truncate_table_map_meso_clusters.log"
bcp %db_name%.vosviewer.map_meso_clusters in "%data_folder%\map_meso_clusters.txt" -c -t"	" -S %server% -T -F2 -e %error_bcp_log_folder%\map_meso_clusters.error >%log_bcp_log_folder%\map_meso_clusters.log

::Micro_clusters
sqlcmd -S %server% -d "%db_name%" -Q "truncate table vosviewer.map_micro_clusters" > "%sql_log_folder%\truncate_table_map_micro_clusters.log"
bcp %db_name%.vosviewer.map_micro_clusters in "%data_folder%\map_micro_clusters.txt" -c -t"	" -S %server% -T -F2 -e %error_bcp_log_folder%\map_micro_clusters.error >%log_bcp_log_folder%\map_micro_clusters.log

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

:: Validate input parameters
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :check_folder   data_folder
call %functions_folder%\variable.bat :create_folder  sql_log_folder
set log_bcp_log_folder=%bcp_log_folder%\log
set error_bcp_log_folder=%bcp_log_folder%\error
call %functions_folder%\variable.bat :create_folder  log_bcp_log_folder
call %functions_folder%\variable.bat :create_folder  error_bcp_log_folder

goto:eof
:: =======================================================================================
