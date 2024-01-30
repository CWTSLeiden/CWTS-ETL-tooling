:: =======================================================================================
:: Main
::: Generate the VOSviewer map and network file data and load it into the
::: classification database.

:: Global variables
::: classification_min_pub_year_core_pub_set
::: classification_max_pub_year_core_pub_set

:: Input variables
::: 1. db_name:     name of the classification database
::: 2. data_folder: folder where VOSviewer input and output files will be stored
::: 3. log_folder:  folder where this function will store its log files

:: Executables
::: java_exe
::: vosviewer_exe
:: =======================================================================================
setlocal

set db_name=%~1
set data_folder=%~2
set log_folder=%~3

call :check_variables 3 %*

call :create_vosviewer_map macro
call :create_vosviewer_map meso
call :create_vosviewer_map micro

endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:create_vosviewer_map
:: =======================================================================================
setlocal

set level=%~1

echo %db_name% - Creating VOSviewer %level% clusters map

:: Obtain the clusters from the classification database
sqlcmd -S %server% -d %db_name% -E -s"	" -y0 ^
    -i %functions_folder%\classification\vosviewer_map.sql ^
    -o %data_folder%\map_%level%_clusters_raw.txt ^
    -v level=%level% classification_min_pub_year_core_pub_set=%classification_min_pub_year_core_pub_set% classification_max_pub_year_core_pub_set=%classification_max_pub_year_core_pub_set%

:: Obtain the network from the classification database
sqlcmd -S %server% -d %db_name% -E -s"	" -y0 ^
    -i %functions_folder%\classification\vosviewer_network.sql ^
    -o %data_folder%\network_%level%_clusters.txt ^
    -v level=%level%

:: Process the clusters using VOSviewer
"%vosviewer_exe%" ^
    -map %data_folder%\map_%level%_clusters_raw.txt ^
    -network %data_folder%\network_%level%_clusters.txt ^
    -attraction 1 ^
    -repulsion 0 ^
    -save_map %data_folder%\map_%level%_clusters.txt

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
call %functions_folder%\variable.bat :check_variable classification_min_pub_year_core_pub_set
call %functions_folder%\variable.bat :check_variable classification_max_pub_year_core_pub_set

:: Validate input variables
call %functions_folder%\variable.bat :check_variable db_name
call %functions_folder%\variable.bat :create_folder  data_folder
call %functions_folder%\variable.bat :create_folder  log_folder

:: Validate executables
call %functions_folder%\variable.bat :check_file     java_exe
call %functions_folder%\variable.bat :check_file     vosviewer_exe

goto:eof
:: =======================================================================================
