:: =======================================================================================
:: Main
::: Archive the current pipeline to its parent directory

:: Global variables
::: root_folder
::: data_folder
::: process_folder
::: zip_log_folder

:: Executables
::: powershell_exe
:: =======================================================================================

setlocal
call :check_variables

set size_treshold_mb=200
for %%i in ("%root_folder%") do set root_folder_name=%%~ni
set pipeline_archive_file=%root_folder_name%.zip
set temp_zip_log_folder=%TEMP%\zip

call :check_folder %data_folder%\files
call :check_folder %data_folder%\json_files
call :check_folder %data_folder%\xml_files
call :check_folder %process_folder%
call :check_folder_content %root_folder%

call %functions%\zip_folder.bat ^
    %root_folder% ^
    %development_folder%\%pipeline_archive_file% ^
    %temp_zip_log_folder%

move /Y %temp_zip_log_folder%\* %zip_log_folder% > nul
rd /S /Q %temp_zip_log_folder%

call %functions%\check_errors.bat

echo Move archive to Bulk storage
move /Y "%development_folder%\%pipeline_archive_file%" "%pipeline_pipelines_bulk_folder%\%pipeline_archive_file%"

echo Archiving of %root_folder% to %pipeline_archive_file% complete

goto:eof
:: =======================================================================================


:: =======================================================================================
:check_folder
:: =======================================================================================
set _folder=%~1
call %functions_folder%\echo.bat :verbose "Checking folder:  %_folder%"
if exist "%_folder%" (
    echo error   - Please remove or archive the following folder:
    echo %_folder%
    echo To proceed with archiving, continue
    pause
)
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_folder_content
:: =======================================================================================
set _folder=%~1
call %functions_folder%\echo.bat :verbose "Checking folder size:  %_folder%"
for /f %%i in ('%powershell_exe% "(Get-ChildItem -Path %_folder% -Recurse | Measure-Object -Property Length -Sum).Sum"') do (
    set /a folder_size_mb=%%i / 1024 / 1024
)
call %functions_folder%\echo.bat :verbose "%folder_size_mb% MB"
if %folder_size_mb% GTR %size_treshold_mb% (
    echo error   - Pipeline remaining files [%folder_size_mb% MB] are larger than %size_treshold_mb% MB
    echo Please check for remaining data files. To proceed with archiving, continue.
    pause
)
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_variables
:: =======================================================================================

:: Set functions_folder to location of this script
set functions_folder=%~dp0
:: Set program_folder to relative location of this script
set programs_folder=%~dp0\..\programs

:: get executable paths
call %programs_folder%\executables.bat

:: Validate global variables
call %functions_folder%\variable.bat :check_variable data_folder
call %functions_folder%\variable.bat :check_variable process_folder
call %functions_folder%\variable.bat :create_folder  zip_log_folder
call %functions_folder%\variable.bat :check_folder   pipelines_bulk_folder

for %%i in ("%development_folder%") do set development_folder_name=%%~ni
set pipeline_pipelines_bulk_folder=%pipelines_bulk_folder%\%development_folder_name%
call %functions_folder%\variable.bat :create_folder pipeline_pipelines_bulk_folder

goto:eof
:: =======================================================================================
