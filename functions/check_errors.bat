@echo off
:: =======================================================================================
:: Main
::: Check log and error folders for errors.
::: Only checks globally defined log/error folders.
::: No output if no errors exist.

:: Global variables
::: (optional) bcp_log_folder
::: (optional) classification_log_folder
::: (optional) database_documentatie_generator_log_folder
::: (optional) download_log_folder
::: (optional) json_parser_log_folder
::: (optional) large_file_splitter_log_folder
::: (optional) xml_file_splitter_log_folder
::: (optional) noun_phrase_extractor_log_folder
::: (optional) patstat_cvt_log_folder
::: (optional) readdata_log_folder
::: (optional) sql_log_folder
::: (optional) zip_log_folder

:: Input variables
::: 1. pause: if skip_pause, do not execute any pause commands
:::           if pause, force pause at the end
:::           if undefined, only pause at the end if there are errors

:: Returns
::: total number of errors
:: =======================================================================================
setlocal

set pause=%~1
set total_errors=0
set error_string=---------------------------------------------------------------

call :check_errors "Backup" "%backup_log_folder%" error
call :check_errors "BCP" "%bcp_log_folder%" error
call :check_errors "Bigquery" "%bigquery_log_folder%" error
call :check_errors "Classification" "%classification_log_folder%" error
call :check_errors "Documentatie Generator" "%database_documentatie_generator_log_folder%" error
call :check_errors "Download" "%download_log_folder%" error
call :check_errors "Export" "%export_log_folder%" log
call :check_errors "Json Parser" "%json_parser_log_folder%" error
call :check_errors "LargeFileSplitter" "%large_file_splitter_log_folder%" error
call :check_errors "NPExtractorDB" "%noun_phrase_extractor_log_folder%" error
call :check_errors "Patstat CVT" "%patstat_cvt_log_folder%" error
call :check_errors "ReadData" "%readdata_log_folder%" error
call :check_errors "SQL" "%sql_log_folder%" log
call :check_errors "XML File Splitter" "%xml_file_splitter_log_folder%" error
call :check_errors "Zip" "%zip_log_folder%" error

call :print_errors

exit /b %total_errors%
endlocal
goto:eof
:: =======================================================================================


:: =======================================================================================
:check_errors
::: Check the error files with a specific extension in a single log folder
::: Skip if the log folder does not exist.
::: Call generate_error_string to append the number of errors to the error string

:: Input variables
::: 1. name
::: 2. log_folder (enclosed in "")
::: 3. extension
:: =======================================================================================
set errors=0
set name=%~1
set log_folder=%2
set extension=%~3

if %log_folder% == "" (
   goto:eof
)

for /R "%log_folder%\" %%f in (*.%extension%) do (
    if %%~zf GTR 0 (
        set /a errors+=1
        if "%verbose%" == "true" (
            echo verbose - Error in file: %%f
        )
    )
)
set /a total_errors+=%errors%

call :generate_error_string "%name%" %errors%

goto:eof
:: =======================================================================================


:: =======================================================================================
:generate_error_string
::: Build the error string for output in the terminal
:::  the %errors:~-6% syntax returns the last 6 characters from the variable, combined
:::  with 6 leading spaces, this has the effect of right-aligning the string.

:: Input variables
::: 1. name
::: 2. errors
:: =======================================================================================
set "newline= & echo."
set "name=%~1"
set "errors=      %~2"
set "error_string=%error_string%%newline%%errors:~-6% ^| %name%"

goto:eof
:: =======================================================================================


:: =======================================================================================
:print_errors
::: If there are errors in any of the logfiles, output the error_string
:: =======================================================================================
if %total_errors% GTR 0 (
    echo There are %total_errors% errors in the logfiles
    echo Amount ^| Program
    echo %error_string%
    if not "%pause%" EQU "skip_pause" (pause)
) else (
    if "%pause%" EQU "pause" (
        echo There are no errors in the logfiles
        pause
    )
)
goto:eof
:: =======================================================================================
