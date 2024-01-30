set server=p-cwts-010260
set db_name=openalex_2023feb
set sql_script=.\openalex-test.sql
set results_file=.\openalex-test.tsv
set project=leiden-ranking-open-edition
set dataset=staging
set table=openalex-test

:: Get results from query file
sqlcmd -S %server% -d %db_name% -E -m 1 -i"%sql_script%" -o "%results_file%" -h-1 -W -w 500 -s"	"

:: Create table (if necessary)
:: TODO Get schema from results-file (powershell? visidata?)
set schema=work_id:INTEGER,pub_date:DATE,pub_year:INTEGER,is_oa:BOOLEAN,n_refs:INTEGER,n_cits:INTEGER,title:STRING,abstract:STRING
bq mk --table --schema=%schema% %project%:%dataset%.%table%

:: Load data
bq load --source_format=CSV --field_delimiter=tab --skip_leading_rows=0 %project%:%dataset%.%table% %results_file%

:: Remove results file
del %results_file%
