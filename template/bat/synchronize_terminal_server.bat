@echo off

:: =======================================================================================
:: Settings
:: =======================================================================================

set db_name=<<name>>

for /f "delims== tokens=2" %%i in ('findstr /C:"set db_version=" %~dp0\src\settings.bat') do set db_version=%%i
set destination_folder=\\spcwtts02\Development$\%db_name%\%db_version%

if not defined db_version (
	echo Cannot sync, no db_version found.
	pause
	goto:eof
)

:: =======================================================================================


:: =======================================================================================
:copy_changed_data
:: =======================================================================================
@pushd %~dp0

:: Copy to terminal server
call :robocopy "doc" "%destination_folder%\doc" *.* /XD "generated_documentation"
 	if not exist "doc" pause
call :robocopy "etl-tooling" "%destination_folder%\etl-tooling" *.*
	if not exist "etl-tooling" pause
call :robocopy "src" "%destination_folder%\src" *.*
	if not exist "src" pause

:: Copy from terminal server
call :robocopy "%destination_folder%\data\validation" "data\validation" *.*

echo Copy completed

@popd

goto:eof 
:: =======================================================================================


:: =======================================================================================
:robocopy
:: Wrapper around robocopy to reuse common options
:: =======================================================================================
if exist %1 (
	robocopy %* /E /purge /NFL /NDL /NJH /NJS /nc /ns /np | findstr /r /v "^$"	
) else (
	echo Information: %1 does not exist.
)
:: =======================================================================================
