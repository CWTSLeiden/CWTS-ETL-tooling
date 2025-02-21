:: =======================================================================================
:: Main
::: Globally set paths for executables
:: =======================================================================================
:: Set _programs_folder to location of this script
set _programs_folder=%~dp0
:: Set _functions_folder to relative location of this script
set _functions_folder=%~dp0\..\functions

call :set_if_not_defined publicationclassification_32bit_exe "%_programs_folder%\publicationclassification\publicationclassification-32bit.jar"

call :set_if_not_defined publicationclassification_64bit_exe "%_programs_folder%\publicationclassification\publicationclassification-64bit.jar"

call :set_if_not_defined publicationclassification_exe "%publicationclassification_64bit_exe%"

call :set_if_not_defined publicationclassificationlabeling_exe "%_programs_folder%\publicationclassificationlabeling\publicationclassificationlabeling.jar"

call :set_if_not_defined curl_exe "%_programs_folder%\Curl\curl.exe"

call :set_if_not_defined database_documentatie_generator_exe "%_programs_folder%\DatabaseDocumentatieGenerator\DatabaseDocumentatieGenerator.exe"

call :set_if_not_defined xml_analyzer_exe "%_programs_folder%\XmlAnalyzer\XmlAnalyzer.exe"

call :set_if_not_defined java_exe "C:\Program Files\Java\jdk1.8.0_202\bin\java.exe"

call :set_if_not_defined json_parser_exe "%_programs_folder%\JsonParser\JsonParser.exe"

call :set_if_not_defined large_file_splitter_exe "%_programs_folder%\LargeFileSplitter\LargeFileSplitter.exe"

call :set_if_not_defined matlab_exe "C:\Program Files\MATLAB\R2017b\bin\matlab.exe"

call :set_if_not_defined noun_phrase_extractor_exe "%_programs_folder%\NPExtractorDB\NPExtractorDB.jar"

call :set_if_not_defined json_analyzer_exe "%_programs_folder%\JsonAnalyzer\JsonAnalyzer.exe"

call :set_if_not_defined readdata_exe "%_programs_folder%\ReadData\ReadData.exe"

call :set_if_not_defined vosviewer_exe "%_programs_folder%\VOSviewer\VOSviewer.exe"

call :set_if_not_defined xml_file_splitter_exe "%_programs_folder%\XmlFilesplitter\XmlFilesplitter.exe"

call :set_if_not_defined zip_exe "C:\Program Files\7-Zip\7z.exe"

call :set_if_not_defined powershell_exe "Powershell.exe -NoProfile -NonInteractive -Command"

call :set_if_not_defined tag_remover_exe "%_programs_folder%\TagRemover\TagRemover.exe"

goto:eof
:: =======================================================================================


:: =======================================================================================
:set_if_not_defined
:: =======================================================================================
set _var=%~1
set _path=%~2
if not defined %_var% (
    set %_var%=%_path%
)

setlocal enabledelayedexpansion
if not "!%_var%!" == "%_path%" (
    call %_functions_folder%\echo.bat :verbose "Program override: %_var%=!%_var%!"
)
endlocal
goto:eof
:: =======================================================================================
