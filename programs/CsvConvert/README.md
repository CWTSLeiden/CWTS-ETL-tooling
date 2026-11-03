# application
```
Description:
  CSV Converter

Usage:
  cc [command] [options]

Options:
  --logFile <logFile>  Path to the log file [default: logs\app.log]
  --verbose            Enable verbose logging
  -?, -h, --help       Show help and usage information
  --version            Show version information

Commands:
  convert        Read a csv file and clean it for bcp.
  table          Generate a SQL create table statement for a csv file.
  batch_convert  Read all csv files in a folder and clean them for bcp.
  export         Exports the contents of a MSSQL database table to a csv file.
  export_query   Exports the results of a T-SQL query to a csv file.
  import         Imports the contents of a csv file to a MSSQL database table.
  batch_import   Read all csv files in a folder and import them To SQL Server.
```

## convert command
```
Description:
  Read a csv file and clean it for bcp.

Usage:
  cc convert [options]

Options:
  --inputFile <inputFile>              Full path of the file to convert
  --outputFile <outputFile>            Full path of the resulting output file
  --delimiter <delimiter>              Specify the delimiter used in the input file [default: ,]
  --quote <quote>                      Specify the character used for quoted input values [default: "]
  --hasHeaderRecord                    Indicate first line contains header information
  --outputDelimiter <outputDelimiter>  Specify the delimiter used in the output file
  --removeHeaderRecord                 Leave out header line if present
  --outputRowTerminator <cr|crlf|lf>   Specify the row terminator used in the output file [default: crlf]
  --removeCR                           Leave out \r characters
  --removeLF                           Leave out \n characters
  --removeTab                          Leave out \t characters
  --preset <big_query|sql_server>      The outputformat of the csv. [default: sql_server]
  --generateSQL                        Generate a .sql file with a create table statement for the csv file
  --ignoreQuoting                      This will ignore quoting and escape characters.
  --logFile <logFile>                  Path to the log file [default: logs\app.log]
  --verbose                            Enable verbose logging
  -?, -h, --help                       Show help and usage information
```

## table command
```
Description:
  Generate a SQL create table statement for a csv file.

Usage:
  cc table [options]

Options:
  --inputFile <inputFile>          Full path of the file to convert
  --outputFile <outputFile>        Full path of the resulting output file
  --delimiter <delimiter>          Specify the delimiter used in the input file [default: ,]
  --quote <quote>                  Specify the character used for quoted input values [default: "]
  --hasHeaderRecord                Indicate first line contains header information
  --preset <big_query|sql_server>  The outputformat of the csv. [default: sql_server]
  --bqDataset <bqDataset>          Name of the Big Query dataset [default: mydataset]
  --ignoreQuoting                  This will ignore quoting and escape characters.
  --logFile <logFile>              Path to the log file [default: logs\app.log]
  --verbose                        Enable verbose logging
  -?, -h, --help                   Show help and usage information
```

## batch_convert command
```
Description:
  Read all csv files in a folder and clean them for bcp.

Usage:
  cc batch_convert [options]

Options:
  --inputFolder <inputFolder>                      Full path to folder with csv files to convert
  --inputFolderExtension <inputFolderExtension>    Extension of the files to process in the input folder [default: csv]
  --outputFolder <outputFolder>                    Full path to folder for writing output files
  --outputFolderExtension <outputFolderExtension>  Extension of the batch converted files in the output folder
                                                   [default: xxx]
  --delimiter <delimiter>                          Specify the delimiter used in the input file [default: ,]
  --quote <quote>                                  Specify the character used for quoted input values [default: "]
  --hasHeaderRecord                                Indicate first line contains header information
  --outputDelimiter <outputDelimiter>              Specify the delimiter used in the output file
  --removeHeaderRecord                             Leave out header line if present
  --outputRowTerminator <cr|crlf|lf>               Specify the row terminator used in the output file [default: crlf]
  --removeCR                                       Leave out \r characters
  --removeLF                                       Leave out \n characters
  --removeTab                                      Leave out \t characters
  --preset <big_query|sql_server>                  The outputformat of the csv. [default: sql_server]
  --generateSQL                                    Generate a .sql file with a create table statement for the csv file
  --ignoreQuoting                                  This will ignore quoting and escape characters.
  --logFile <logFile>                              Path to the log file [default: logs\app.log]
  --verbose                                        Enable verbose logging
  -?, -h, --help                                   Show help and usage information
```

## export command
```
Description:
  Exports the contents of a MSSQL database table to a csv file.

Usage:
  cc export [options]

Options:
  --server <server>                    Name of the MSSQL database server
  --database <database>                Name of the MSSQL database
  --table <table>                      Name of the table in the MSSQL database to export
  --limit <limit>                      Maximum number of records to export from the table
  --outputFile <outputFile>            Full path of the resulting output file
  --removeHeaderRecord                 Leave out header line if present
  --removeCR                           Leave out \r characters
  --removeLF                           Leave out \n characters
  --removeTab                          Leave out \t characters
  --outputRowTerminator <cr|crlf|lf>   Specify the row terminator used in the output file [default: crlf]
  --outputDelimiter <outputDelimiter>  Specify the delimiter used in the output file
  --quote <quote>                      Specify the character used for quoted input values [default: "]
  --outputQuotes                       Quote output values
  --preset <big_query|sql_server>      The outputformat of the csv. [default: sql_server]
  --generateSQL                        Generate a .sql file with a create table statement for the csv file
  --logFile <logFile>                  Path to the log file [default: logs\app.log]
  --verbose                            Enable verbose logging
  -?, -h, --help                       Show help and usage information
```

## export_query command
```
Description:
  Exports the results of a T-SQL query to a csv file.

Usage:
  cc export_query [options]

Options:
  --server <server>                    Name of the MSSQL database server
  --database <database>                Name of the MSSQL database
  --queryFile <queryFile>              Path of the file containing the query
  --var <var>                          Variables in the form name=value
  --outputFile <outputFile>            Full path of the resulting output file
  --removeHeaderRecord                 Leave out header line if present
  --removeCR                           Leave out \r characters
  --removeLF                           Leave out \n characters
  --removeTab                          Leave out \t characters
  --outputRowTerminator <cr|crlf|lf>   Specify the row terminator used in the output file [default: crlf]
  --outputDelimiter <outputDelimiter>  Specify the delimiter used in the output file
  --quote <quote>                      Specify the character used for quoted input values [default: "]
  --outputQuotes                       Quote output values
  --preset <big_query|sql_server>      The outputformat of the csv. [default: sql_server]
  --generateSQL                        Generate a .sql file with a create table statement for the csv file
  --logFile <logFile>                  Path to the log file [default: logs\app.log]
  --verbose                            Enable verbose logging
  -?, -h, --help                       Show help and usage information
```

## import command
```
Description:
  Imports the contents of a csv file to a MSSQL database table.

Usage:
  cc import [options]

Options:
  --inputFile <inputFile>  Full path of the file to convert
  --server <server>        Name of the MSSQL database server
  --database <database>    Name of the MSSQL database
  --table <table>          Name of the table in the MSSQL database to export
  --dropTable              Drop the table if it already exists before import
  --createTable            Create the table in the MSSQL database before import
  --delimiter <delimiter>  Specify the delimiter used in the input file [default: ,]
  --quote <quote>          Specify the character used for quoted input values [default: "]
  --hasHeaderRecord        Indicate first line contains header information
  --removeCR               Leave out \r characters
  --removeLF               Leave out \n characters
  --removeTab              Leave out \t characters
  --noTablock              Bulk insert csv to SQL Server without the tablock hint on.
  --ignoreQuoting          This will ignore quoting and escape characters.
  --logFile <logFile>      Path to the log file [default: logs\app.log]
  --verbose                Enable verbose logging
  -?, -h, --help           Show help and usage information
```

## batch_import command
```
Description:
  Read all csv files in a folder and import them To SQL Server.

Usage:
  cc batch_import [options]

Options:
  --inputFolder <inputFolder>                    Full path to folder with csv files to convert
  --inputFolderExtension <inputFolderExtension>  Extension of the files to process in the input folder [default: csv]
  --server <server>                              Name of the MSSQL database server
  --database <database>                          Name of the MSSQL database
  --dropTable                                    Drop the table if it already exists before import
  --createTable                                  Create the table in the MSSQL database before import
  --delimiter <delimiter>                        Specify the delimiter used in the input file [default: ,]
  --quote <quote>                                Specify the character used for quoted input values [default: "]
  --hasHeaderRecord                              Indicate first line contains header information
  --removeCR                                     Leave out \r characters
  --removeLF                                     Leave out \n characters
  --removeTab                                    Leave out \t characters
  --noTablock                                    Bulk insert csv to SQL Server without the tablock hint on.
  --ignoreQuoting                                This will ignore quoting and escape characters.
  --logFile <logFile>                            Path to the log file [default: logs\app.log]
  --verbose                                      Enable verbose logging
  -?, -h, --help                                 Show help and usage information
```