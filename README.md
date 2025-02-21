# CWTS ETL tooling
Version: 8.1.1

## Description

This repository contains all reusable components for running CWTS data pipelines as well as some rudimentary error handling and function utilities for Windows CMD (`.bat`) scripts. Be aware that the code in this repository is highly dependent on the CWTS hardware infrastructure and applies settings that are specifically tuned to CWTS use cases.

## Usage

Generally, a copy of this repository should be placed at the root of a CWTS data pipeline. The scripts in the `/functions` folder can then be called relative to the current `.bat` script: `call .\etl-tooling\functions\check_errors.bat`. Alternatively calling `call .\etl-tooling\activate.bat` stores the location of the `functions` folder in the `%functions%` variable so that subsequently the scripts in the `functions` folder can be called by `call %functions%\check_errors.bat`. This script will not overwrite variables that are already set.

The executables in the `programs` folder can either be called directly or by their respective variables. Calling `call .\etl-tooling\programs\executables.bat`  or `call .\etl-tooling\activate.bat` will store the relevant executables in various variables (e.g. `%curl_exe%`). This script will not overwrite variables that are already set.

Calling `call .\etl-tooling\functions\folder.bat` or `call .\etl-tooling\activate.bat` will set many of the variables used in CWTS data pipelines (like `%sql_src_folder%`) relative to the `%root_folder%` variable. This is done to maintain a consistent project structure across different data pipelines. This script will not overwrite variables that are already set and will propagate sub folder variables relative to their parent-folder variables if they are already set.

When writing new pipeline code or ETL-tooling functions, the `functions\variable.bat` script can provide some error handling by checking the value of variables, existence of files or folders and functions parameters.

# Changelog

## Functions
| function                               | version |
|----------------------------------------|---------|
| `add_extended_properties`              | v1.0.0  |
| `apply_page_compression`               | v1.0.0  |
| `archive_pipeline`                     | v1.1.0  |
| `aws_download_folder`                  | v1.0.0  |
| `bcp_data`                             | v1.0.2  |
| `check_errors`                         | v0.4.0  |
| `classification_create_classification` | v1.0.0  |
| `classification_create_labeling`       | v1.0.0  |
| `classification_create_vosviewer_maps` | v1.0.0  |
| `classification_load_vosviewer_maps`   | v1.0.0  |
| `classification_optimize_np_labels`    | v1.0.0  |
| `clean_pipeline`                       | v1.0.0  |
| `create_database`                      | v3.0.0  |
| `credentials`                          | dev     |
| `curl_download_file`                   | v1.3.0  |
| `echo`                                 | v1.0.0  |
| `executables`                          | v1.1.1  |
| `extract_noun_phrases`                 | v1.0.0  |
| `folder`                               | v1.0.6  |
| `get_datetime`                         | v1.0.0  |
| `generate_database_documentation`      | v0.1.0  |
| `grant_access_cwts_group`              | v2.0.0  |
| `json_analyze_data`                    | v1.0.0  |
| `json_parse_data`                      | v1.1.1  |
| `load_database`                        | v1.0.0  |
| `log_runtime`                          | v0.0.1  |
| `notify`                               | v1.0.0  |
| `notify_errors`                        | v0.1.0  |
| `run_sql_folder`                       | v1.1.0  |
| `run_sql_query`                        | dev     |
| `run_sql_script`                       | v1.1.1  |
| `secret`                               | v1.0.0  |
| `set_database_file_limits`             | v1.1.0  |
| `set_database_owner`                   | dev     |
| `shrink_database`                      | v1.0.0  |
| `split_large_files`                    | v1.0.0  |
| `split_process_files`                  | v1.0.1  |
| `split_process_months`                 | v1.0.0  |
| `split_process_numbers`                | v0.1.0  |
| `unify_create_tables`                  | v1.0.0  |
| `unzip_file`                           | v2.1.1  |
| `unzip_folder`                         | v1.0.0  |
| `validate_database`                    | v3.0.0  |
| `validate_database_compare`            | v1.0.2  |
| `validate_data_types`                  | v2.0.0  |
| `validate_data_types_compare`          | v1.0.1  |
| `variable`                             | v1.0.0  |
| `wait`                                 | v2.0.0  |
| `xml_analyze_data`                     | v2.1.0  |
| `xml_analyze_data_unify`               | v1.0.0  |
| `xml_generate_prg`                     | v2.0.0  |
| `xml_parse_data`                       | v1.0.2  |
| `xml_split_data`                       | v1.0.2  |
| `zip_folder`                           | v2.0.0  |

### add_extended_properties

### apply_page_compression

### archive_pipeline
- v1.1.0
    - Fix bug in bulk folder path

### aws_download_folder

### bcp_data

- v1.0.2
    - Remove wait.bat :sleep_subprocess
- v1.0.1
    - Add wait.bat :sleep_subprocess

### check_errors
- v0.4.0
    - Add check for sql .error files
- v0.3.3
    - `%backup_log_folder%` added for backup-tooling
- v0.3.2
    - `%patstat_cvt_log_folder%` added for Patstat CVT
- v0.3.1
    - Add verbose option to output file names that contain errors.
- v0.3.0
    - `%noun_phrase_extractor_log_folder%` added for NBExtractorDB
- v0.2.0
    - Download log folder added to check errors. Download log folder will contain .log and .error files from downloading data. Some programs that can write the output to this folder are for example: AWS, Azcopy and Curl.

### classification_create_classification
- v1.0.0
    - parameters
        1. `db_name`: `classification_db_name`
        2. `log_folder`: `classification_log_folder`

### classification_create_labeling
- v1.0.0
    - parameters
        1. `db_name`: `classification_db_name`
        2. `log_folder`: `classification_log_folder`

### classification_create_vosviewer_maps
- v1.0.0
    - parameters
        1. `db_name`: `classification_db_name`
        2. `data_folder`: `classification_data_folder`
        3. `log_folder`: `classification_log_folder`

### classification_load_vosviewer_maps
- v1.0.0
    - parameters
        1. `db_name`: `classification_db_name`
        2. `data_folder`: `classification_data_folder`
        3. `sql_log_folder`: `classification_log_folder`
        4. `bcp_log_folder`: `classification_log_folder`

### classification_optimize_np_labels
- v1.0.0
    - parameters
        1. `db_name`: `classification_db_name`
        2. `data_folder`: `classification_data_folder`
        3. `log_folder`: `classification_log_folder`

### clean_pipeline

### create_database

- v3.0.0
    - function does not run `grant_developer_access.sql` automatically
- v2.0.0
    - `%db_filegrowth%` is now an optional global value which defaults to 5Gb

### credentials

### curl_download_file

- v1.3.0
    - Send signal after downloading
    - Add quotes to deal with ampersands in the URL
    - Remove check number of variables to deal with ampersands in the URL:
      The `%*` construction expands the variable, which exposes the unescaped `&`
- v1.2.0
    - Download the header files of the file by default.
- v1.1.0
    - Add optional `%curl_header%` parameter to add '-H' arguments to curl.

### echo

### executables

- v1.1.1
    - bugfix: check folder failed, so executable variables were not overwritable by settings.bat.
- v1.1.0
    - rename `%read_data_exe%` to `%readdata_exe%`

### extract_noun_phrases

- v1.0.0
    - Bugfixes
    - Tested with Scopus database.

### folder

- v1.0.6
    - add `%publicationclassification_log_folder%`
    - add `%publicationclassificationlabeling_log_folder%`
- v1.0.5
    - add `%bulk_folder%` 
    - add `%developement_folder%`
- v1.0.4
    - add `%large_file_splitter_log_folder%`
- v1.0.3
    - add `%generate_prg_file_data_folder%`
- v1.0.2
    - add `%read_json_tags_data_folder%`
- v1.0.1
    - add `%files_data_folder%`

### get_datetime

### generate_database_documentation

### grant_access_cwts_group
- v2.0.0
    - Add required global variable `%sql_cwts_group%`

### json_analyze_data

### json_parse_data

- v1.1.1
    - Remove wait.bat :sleep_subprocess
- v1.1.0
    - Add optional global variable `%json_parser_source_file_extension%` to filter the file type that the json parser uses as input
- v1.0.1
    - Add wait.bat :sleep_subprocess
- v1.0.0
    - The value of `%erase_previous%` should be set to `erase_previous` instead of `true`

### load_database

- v1.0.0
    - it is advised to change calls to `run_sql_folder`
        - be advised that `copy_identity_tables` functionality is not implemented
- v1.0.0
    - rename `:all_scripts` to `:run_all_scripts`
    - rename `:pre_processing_scripts` to `:run_pre_processing_scripts`
    - rename `:table_scripts` to `:run_table_scripts`
    - rename `:post_processing_scripts` to `:run_post_processing_scripts`
    - rename function `load_relational_database.bat` to `load_database.bat`

### log_runtime

### notify

### notify_errors

### run_sql_folder

- v1.1.0
    - By default the function will now stop running scripts when a script produces an error in its error file.
    - **add global variable `sql_interrupt_on_error`**
        - set to "false" to disable the interruption

### run_sql_query

### run_sql_script

- v1.1.0
    - properly separate error and log output: errors will be written to an .error file, messages and query results will be written to the .log file.
- v1.0.1
    - bugfix: sql variables were not being passed to script.
    
### secret

### set_database_file_limits

- v1.1.0
    - add two additional optional parameters `%mdf_file_limit%` and `%ldf_file_limit%`. If called without these parameters, the function will set the limits automatically based on file-size (previous behavior). If called with these parameters, explicit file-limits will be set.

### set_database_owner

### shrink_database

### split_large_files

### split_process_files
- v1.0.1
    - creating folder is no longer shown in terminal window
- v1.0.0
    - **add argument 'include_parent_directory'** to take over folder structure.
- v0.2.3
    - fix bug in amount of files check, which made the check run very long in case of a large number of files.
- v0.2.2
    - use `write-verbose` powershell option to provide more information during splitting.
- v0.2.1
    - order variable is optional
- v0.2.0
    - order`size` and `none` tested.
    - functions from functions\split_process_files_size.bat ported to functions\split_process_files\split_process_files.ps1.
    - **add argument 'order'** to pick processing method.
    - update functions\split_process_files.bat to function as a wrapper for functions\split_process_files\split_process_files.ps1.

### split_process_months

### split_process_numbers

### unify_create_tables

### unzip_file

- v2.1.1
    - create `target_folder`
- v2.1.0
    - add optional global parameter 'zip_args'
    - replace 7zip '-y' parameter with '-aou' to not ever overwrite conflicting files.
- v2.0.0
    - **add argument 'zip_log_folder'**
- v1.0.0
    - **add argument 'keep_folder_structure'**

### unzip_folder

### validate_database

- v3.0.0
    - remove `%target_file%` parameter, now auto-generated from `%db_name%` and `%validation_data_folder%`
- v2.0.0
    - change `;` separator to `<tab>` separator.
    - change output file to `.tsv` instead of `.csv`
- v1.0.0
    - rename function `validation_database.bat` to `validate_database.bat`

### validate_database_compare
- v1.0.2
    - add file picker if validation files cannot be found

### validate_data_types

- v2.0.0
    - remove `%target_file%` parameter, now auto-generated from `%db_name%` and `%validation_data_folder%`

### validate_data_types_compare
- v1.0.1
    - add file picker if validation files cannot be found

### variable

### wait
- v2.0.0
    - Remove :sleep_subprocess subfunction
    - Refactor ro remove dependency on `waitfor`
      - The new system uses a signal file instead of `waitfor` signals. Subprocesses write a line to the file, the main process counts the number of lines.
      - More robust, quicker, no more need for `:sleep_subprocess`, `:sleep`, or `%sleep_timer%`
      - `:sleep` is retained for backwards compatibility.
- v1.1.1
    - Fix bug where '%number_of_processes%' did not get checked
- v1.1.0
    - Add :sleep and :sleep_subprocess sub-functions

### xml_analyze_data

- v2.1.0
    - rename variables and modify documentation for xml_analyzer 0.2.0
    - `frequency_` prefix removed

### xml_analyze_data_unify

### xml_generate_prg

- v2.0.0
    - changes for xml_analyzer 0.2.0
    - now takes a single input file
    - `program_output_folder` and `program_output_file_name` replaced by `output_file`

### xml_parse_data

- v1.0.2
    - Remove wait.bat :sleep_subprocess
- v1.0.1
    - Add wait.bat :sleep_subprocess
- v1.0.0
    - The value of `%erase_previous%` should be set to `erase_previous` instead of `true`.
    - The value of `%erase_xml%` should be set to `erase_xml` instead of `true`.

### xml_split_data

- v1.0.2
    - Remove wait.bat :sleep_subprocess
- v1.0.1
    - Add wait.bat :sleep_subprocess
- v1.0.0
    - Replace `erase_split` argument with `xml_file_splitter_remove_original_files` global variable.
- v0.1.0
    - Add missing parameters
        - `%xml_file_splitter_find_files_recursive%`
        - `%xml_file_splitter_fix_crossref_namespaces%`
        - `%xml_file_splitter_order_mixed_values%`
        - `%xml_file_splitter_include_xml_prolog%`
        - `%xml_file_splitter_remove_original_files%`
        - `%xml_file_splitter_showoutput%`

### zip_folder

- v2.0.0
    - **add argument 'zip_log_folder'**

## Deprecated Functions

### classification
- split up into functions
    - `classification_create_classification`
    - `classification_create_labeling`
    - `classification_create_vosviewer_maps`
    - `classification_load_vosviewer_maps`
    - `classification_optimize_np_labels`
### split_process_size
- Deprecated in favor of `split_process_files` with `order=preserve`
### xml_generate_sql_bcp_scripts
- Merged function into `xml_parse_data`

## Programs

| program                               | version    |
|---------------------------------------|------------|
| 7z.exe                                | system     |
| Curl.exe                              | 7.76.1     |
| DatabaseDocumentatieGenerator.exe     | 2.1.0.0    |
| JsonAnalyzer.exe                      | 1.1.0.0    |
| JsonParser.exe                        | 1.43.0.0   |
| LargeFileSplitter.exe                 | 1.0.0.0    |
| NPExtractorDB.jar                     | 21-07-2021 |
| ReadData.exe                          | 4.8.0.0    |
| VOSviewer.exe                         | 1.6.20     |
| XmlAnalyzer.exe                       | 0.2.0      |
| XmlFilesplitter.exe                   | v1.0.0.7   |
| java.exe                              | system     |
| matlab.exe                            | system     |
| publicationclassification-32bit.jar   | 1.0.0      |
| publicationclassification-64bit.jar   | 1.1.0      |
| publicationclassificationlabeling.jar | 1.0.0      |
