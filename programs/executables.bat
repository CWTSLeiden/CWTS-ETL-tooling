:: =======================================================================================
:: Main
::: Globally set paths for executables
:: =======================================================================================
:: Set _programs to current directory
set _programs=%~dp0

call :set_if_not_defined publicationclassification_32bit_exe "%_programs%\publicationclassification\publicationclassification-32bit.jar"

call :set_if_not_defined publicationclassification_64bit_exe "%_programs%\publicationclassification\publicationclassification-64bit.jar"

call :set_if_not_defined publicationclassification_exe "%publicationclassification_64bit_exe%"

call :set_if_not_defined publicationclassificationlabeling_exe "%_programs%\publicationclassificationlabeling\publicationclassificationlabeling.jar"

call :set_if_not_defined curl_exe "%_programs%\Curl\curl.exe"

call :set_if_not_defined database_documentatie_generator_exe "%_programs%\DatabaseDocumentatieGenerator\DatabaseDocumentatieGenerator.exe"

call :set_if_not_defined xml_analyzer_exe "%_programs%\XmlAnalyzer\XmlAnalyzer.exe"

call :set_if_not_defined java_exe "C:\Program Files\Java\jdk1.8.0_202\bin\java.exe"

call :set_if_not_defined json_parser_exe "%_programs%\JsonParser\JsonParser.exe"

call :set_if_not_defined large_file_splitter_exe "%_programs%\LargeFileSplitter\LargeFileSplitter.exe"

call :set_if_not_defined matlab_exe "C:\Program Files\MATLAB\R2017b\bin\matlab.exe"

call :set_if_not_defined noun_phrase_extractor_exe "%_programs%\NPExtractorDB\NPExtractorDB.jar"

call :set_if_not_defined json_analyzer_exe "%_programs%\JsonAnalyzer\JsonAnalyzer.exe"

call :set_if_not_defined readdata_exe "%_programs%\ReadData\ReadData.exe"

call :set_if_not_defined vosviewer_exe "%_programs%\VOSviewer\VOSviewer.exe"

call :set_if_not_defined xml_file_splitter_exe "%_programs%\XmlFilesplitter\XmlFilesplitter.exe"

call :set_if_not_defined zip_exe "C:\Program Files\7-Zip\7z.exe"

call :set_if_not_defined powershell_exe "Powershell.exe -NoProfile -NonInteractive -Command"

call :set_if_not_defined powershell_7_exe "C:\Program Files\PowerShell\7\pwsh.exe -NoProfile -NonInteractive -Command"

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
if "%verbose%" == "true" (
    if not "!%_var%!" == "%_path%" (
        echo verbose - Program override: %_var%=!%_var%!
    )
)
endlocal
goto:eof
:: =======================================================================================
