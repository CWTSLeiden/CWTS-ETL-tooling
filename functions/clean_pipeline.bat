:: =======================================================================================
:: Main
::: Clean the current pipeline, deleting data- and processing-files

:: Global variables
::: data_folder
::: process_folder

:: Executables
::: powershell_exe
:: =======================================================================================

setlocal
echo WARNING - Deleting the following folders:
call :check_folder %data_folder%\files
call :check_folder %data_folder%\json_files
call :check_folder %data_folder%\xml_files
call :check_folder %process_folder%

if not "%continue%" == "true" (
    echo Nothing to delete
    goto:eof
)

call :check_variables

set /p "continue=To proceed type 'continue': "
if "%continue%" == "continue" (
    call :clean_folder %data_folder%\files
    call :clean_folder %data_folder%\json_files
    call :clean_folder %data_folder%\xml_files
    call :clean_folder %process_folder%
)
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_folder
:: =======================================================================================
set _folder=%~1
if exist "%_folder%" (
    echo - %_folder%
    set continue=true
)
goto:eof
:: =======================================================================================


:: =======================================================================================
:clean_folder
::: Use powershell to remove all files before removing the folder. In cases where
::: the number of files is very large, deleting using CMD del or rd takes a very
::: long time because of windows bookkeeping the progress.
::: Get-ChildItem | Foreach-Object { Remove-Object } removes without bookkeeping
:: =======================================================================================
set _folder=%~1
call %functions_folder%\echo.bat :verbose "Cleaning folder:  %_folder%"
if exist "%_folder%" (
    call %powershell_exe% "Get-ChildItem -Path %_folder% -File -Recurse | ForEach-Object { Remove-Item $_.FullName }"
    call %powershell_exe% "Get-ChildItem -Path %_folder% -Recurse | ForEach-Object { Remove-Item -Recurse $_.FullName }"
    call %powershell_exe% "Remove-Item %_folder% -Recurse"
)
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_variables
:: =======================================================================================

:: set functions_folder to location of this script
set functions_folder=%~dp0
:: set program_folder to relative location of this script
set programs_folder=%~dp0\..\programs

:: get executable paths
call %programs_folder%\executables.bat

goto:eof
:: =======================================================================================
