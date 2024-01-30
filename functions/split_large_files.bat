:: =======================================================================================
:: Main
::: Split large files into smaller files based on a maximum number of lines using
::: LargeFileSplitter.exe.

:: Global variables:
::: large_file_splitter_block_size
::: (optional) large_file_splitter_OutputFirstNBlocks
::: (optional) large_file_splitter_OutputFileExtension

:: Input variables
::: 1. source_folder:    folder where the files to be split are located
::: 2. source_extension: extensions of the files to be split
::: 3. target_folder:    folder where the splitted files should be placed
::: 4. log_folder:       log folder for this function

:: Executables
::: large_file_splitter_exe
:: =======================================================================================
setlocal

set source_folder=%~1
set source_extension=%~2
set target_folder=%~3
set log_folder=%~4

call :check_variables 4 %*

echo Splitting %source_extension% files in %source_folder%
for /R "%source_folder%\" %%f in (*.%source_extension%) do (
    echo Splitting file: %%f
    "%large_file_splitter_exe%" ^
        FileToSplit=%%f ^
        OutputFolder=%target_folder% ^
        BlockSize=%large_file_splitter_block_size% ^
        LogFolder=%log_folder% ^
        %large_file_splitter_ouput_first_n_blocks_arg% ^
        %large_file_splitter_output_file_extension_arg%
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

:: Validate global variables
call %functions_folder%\variable.bat :check_file     large_file_splitter_exe
call %functions_folder%\variable.bat :check_variable large_file_splitter_block_size

:: Validate input variables
call %functions_folder%\variable.bat :check_folder   source_folder
call %functions_folder%\variable.bat :check_variable source_extension
call %functions_folder%\variable.bat :create_folder  target_folder
call %functions_folder%\variable.bat :create_folder  log_folder

:: Set large_file_splitter optional arguments only if defined
if defined large_file_splitter_output_first_n_blocks (
    set large_file_splitter_output_first_n_blocks_arg=OutputFirstNBlocks=%large_file_splitter_output_first_n_blocks%
)
if defined large_file_splitter_output_file_extension (
    set large_file_splitter_output_file_extension_arg=OutputFileExtension=%large_file_splitter_output_file_extension%
)

goto:eof
:: =======================================================================================
