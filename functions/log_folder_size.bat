:: =======================================================================================
:: Main
::: Report the size of each subfolder within target_folder and write the
::: results to a file, so the sizes of the data processed in a run
::: can be compared between runs.

:: Executables
::: powershell_exe

:: Input variables
::: 1. target_folder: folder whose subfolders are measured
::: 2. log_file:      file the folder sizes are written to
:: =======================================================================================
setlocal

set target_folder=%~1
set log_file=%~2
set log_folder=%~dp2

call :check_variables 2 %*

echo Log folder sizes: %target_folder%

%powershell_exe% ^
    "$sizes = Get-ChildItem -Path '%target_folder%' -Directory | Sort-Object -Property Name | ForEach-Object { $size = (Get-ChildItem -Path $_.FullName -Recurse -File -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum; if ($null -eq $size) { $size = 0 }; [PSCustomObject]@{ Name = $_.Name; Bytes = $size } }; $total = ($sizes | Measure-Object -Property Bytes -Sum).Sum; $lines = @(); $sizes | ForEach-Object { $lines += ('{0}	{1}Gb' -f $_.Name, [math]::Round($_.Bytes / 1GB, 2)) }; $lines += 'TOTAL	{0}Gb' -f [math]::Round($total / 1GB, 2); $lines | Out-File -FilePath '%log_file%' -Encoding utf8"

call %functions_folder%\echo.bat :verbose "Size of folders in %target_folder%:"
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
:: Set program_folder to relative location of this script
set programs_folder=%~dp0\..\programs

:: Get executable paths
call %programs_folder%\executables.bat

:: Check number of input variables
call %functions_folder%\variable.bat :check_parameters %*

:: Validate input variables
call %functions_folder%\variable.bat :check_folder    target_folder
call %functions_folder%\variable.bat :check_variable  log_file
call %functions_folder%\variable.bat :create_folder   log_folder

goto:eof
:: =======================================================================================
