:: ---------------------------------------------------------------------------------------
:: Root folder
:: ---------------------------------------------------------------------------------------

call %~dp0\variable.bat :check_folder root_folder

:: ---------------------------------------------------------------------------------------
:: Backup-tooling folder
:: ---------------------------------------------------------------------------------------

call :set_if_not_defined backup_tooling_folder %root_folder%\backup-tooling
    call :set_if_not_defined backup_functions %backup_tooling_folder%\functions

:: ---------------------------------------------------------------------------------------
:: Bulk storage folder
:: ---------------------------------------------------------------------------------------

call :set_if_not_defined bulk_folder \\spfss15\cwts_bu_db$
    call :set_if_not_defined data_bulk_folder %bulk_folder%\Data
    call :set_if_not_defined databases_bulk_folder %bulk_folder%\Databases
        call :set_if_not_defined development_databases_bulk_folder %databases_bulk_folder%\p-cwts-010260
        call :set_if_not_defined production_databases_bulk_folder %databases_bulk_folder%\p-cwts-010259
        call :set_if_not_defined temp_databases_bulk_folder %databases_bulk_folder%\temp
    call :set_if_not_defined pipelines_bulk_folder %bulk_folder%\Pipelines

:: ---------------------------------------------------------------------------------------
:: Data folder
:: ---------------------------------------------------------------------------------------

call :set_if_not_defined data_folder %root_folder%\data
    call :set_if_not_defined classification_data_folder %data_folder%\classification
    call :set_if_not_defined generated_sql_scripts_data_folder %data_folder%\generated_sql_scripts
    call :set_if_not_defined validation_data_folder %data_folder%\validation
    call :set_if_not_defined files_data_folder %data_folder%\files
        call :set_if_not_defined download_files_data_folder %files_data_folder%\download
        call :set_if_not_defined extract_files_data_folder %files_data_folder%\extract
        call :set_if_not_defined process_files_data_folder %files_data_folder%\process
    call :set_if_not_defined xml_files_data_folder %data_folder%\xml_files
        call :set_if_not_defined download_xml_files_data_folder %xml_files_data_folder%\download
        call :set_if_not_defined extract_xml_files_data_folder %xml_files_data_folder%\extract
        call :set_if_not_defined process_xml_files_data_folder %xml_files_data_folder%\process
    call :set_if_not_defined json_files_data_folder %data_folder%\json_files
        call :set_if_not_defined download_json_files_data_folder %json_files_data_folder%\download
        call :set_if_not_defined extract_json_files_data_folder %json_files_data_folder%\extract
        call :set_if_not_defined process_json_files_data_folder %json_files_data_folder%\process

:: ---------------------------------------------------------------------------------------
:: Development folder
:: ---------------------------------------------------------------------------------------

for %%i in ("%root_folder%") do set _development_folder=%%~dpi
call :set_if_not_defined development_folder %_development_folder:~0,-1%

:: ---------------------------------------------------------------------------------------
:: Doc folder
:: ---------------------------------------------------------------------------------------

call :set_if_not_defined doc_folder %root_folder%\doc
    call :set_if_not_defined generated_documentation_doc_folder %doc_folder%\generated_documentation
    call :set_if_not_defined img_doc_folder %doc_folder%\img

:: ---------------------------------------------------------------------------------------
:: ETL-tooling folder
:: ---------------------------------------------------------------------------------------

call :set_if_not_defined etl_tooling_folder %root_folder%\etl-tooling
    call :set_if_not_defined functions %etl_tooling_folder%\functions
    call :set_if_not_defined programs %etl_tooling_folder%\programs

:: ---------------------------------------------------------------------------------------
:: Process folder
:: ---------------------------------------------------------------------------------------

call :set_if_not_defined process_folder %root_folder%\process

:: ---------------------------------------------------------------------------------------
:: Log folder
:: ---------------------------------------------------------------------------------------

call :set_if_not_defined log_folder %root_folder%\log
    call :set_if_not_defined backup_log_folder %log_folder%\backup
    call :set_if_not_defined bcp_log_folder %log_folder%\bcp
        call :set_if_not_defined classification_bcp_log_folder %bcp_log_folder%\classification
        call :set_if_not_defined relational_bcp_log_folder %bcp_log_folder%\relational
        call :set_if_not_defined json_bcp_log_folder %bcp_log_folder%\json
        call :set_if_not_defined xml_bcp_log_folder %bcp_log_folder%\xml
    call :set_if_not_defined classification_log_folder %log_folder%\classification
    call :set_if_not_defined publicationclassification_log_folder %log_folder%\publicationclassification
    call :set_if_not_defined publicationclassificationlabeling_log_folder %log_folder%\publicationclassificationlabeling
    call :set_if_not_defined database_documentatie_generator_log_folder %log_folder%\database_documentatie_generator
    call :set_if_not_defined download_log_folder %log_folder%\download
    call :set_if_not_defined json_parser_log_folder %log_folder%\json_parser
    call :set_if_not_defined large_file_splitter_log_folder %log_folder%\large_file_splitter
    call :set_if_not_defined noun_phrase_extractor_log_folder %log_folder%\NPExtractorDB
    call :set_if_not_defined readdata_log_folder %log_folder%\readdata
    call :set_if_not_defined sql_log_folder %log_folder%\sql
        call :set_if_not_defined classification_sql_log_folder %sql_log_folder%\classification
        call :set_if_not_defined indicators_sql_log_folder %sql_log_folder%\indicators
        call :set_if_not_defined json_sql_log_folder %sql_log_folder%\json
        call :set_if_not_defined relational_sql_log_folder %sql_log_folder%\relational
            call :set_if_not_defined documentation_relational_sql_log_folder %relational_sql_log_folder%\documentation
        call :set_if_not_defined text_sql_log_folder %sql_log_folder%\text
        call :set_if_not_defined xml_sql_log_folder %sql_log_folder%\xml
    call :set_if_not_defined xml_file_splitter_log_folder %log_folder%\XmlFilesplitter
    call :set_if_not_defined zip_log_folder %log_folder%\7zip

:: ---------------------------------------------------------------------------------------
:: Source folder
:: ---------------------------------------------------------------------------------------

call :set_if_not_defined src_folder %root_folder%\src
    call :set_if_not_defined bat_src_folder %src_folder%\bat
    call :set_if_not_defined powershell_src_folder %src_folder%\powershell
    call :set_if_not_defined prg_src_folder %src_folder%\prg
    call :set_if_not_defined sql_src_folder %src_folder%\sql
        call :set_if_not_defined classification_sql_src_folder %sql_src_folder%\classification
        call :set_if_not_defined indicators_sql_src_folder %sql_src_folder%\indicators
        call :set_if_not_defined json_sql_src_folder %sql_src_folder%\json
        call :set_if_not_defined relational_sql_src_folder %sql_src_folder%\relational
        call :set_if_not_defined text_sql_src_folder %sql_src_folder%\text
        call :set_if_not_defined xml_sql_src_folder %sql_src_folder%\xml

:: ---------------------------------------------------------------------------------------
:: Temp folder
:: ---------------------------------------------------------------------------------------

call :set_if_not_defined temp_folder %root_folder%\temp

goto:eof

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
        echo verbose - Folder override:  %_var%=!%_var%!
    )
)
endlocal
goto:eof
