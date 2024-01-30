# JsonParser.exe

**Date modified**: *23-6-2022*

## Purpose

Convert JSON files to tab separated flat files. 


## Execute the program

To execute this program it must be called from a batch file or command line. The programs must be called with parameters on the command line
or set in a configuration file. The name of the configuration file must be jsonparser.exe.config. This folder contains an example of a configuration file.

## Parameters

### DataSource (mandatory)

The name of the datasource to parse.

### DataVersion (optional)

The version of the model used for parsing the data. If the data version is omitted the most recent version is used.

### SourceFolder (mandatory)

Specifies the folder that contains the JSON files. The files a read from this folder and every sub folder. 

### SourceFileExtension (optional)

If provided only files with this extension in the source folder are parsed. Default (not provided) all files in the source folder are parsed.
- Example: SourceFileExtension=json

### OutputFolder (mandatory)

Specifies the folder where the generated files are stored. This program generates flat files with the data from the JSON (xxx files) and files to create tables
in the database (slq files) and a batch file to load the data into the database (bcpdata.bat).

### BufferSize (optional)

This is the number of JSON objects that are processed before they are saved to the output file. If not present the program will use the default value 10000.
A larger value will speed up the execution but will also fill the memory.

### OutputFileExtension (optional)

The generated tab seperated flat files will get this extension. 
If omitted the files will get the extension xxx.

- Example: OutputFileExtension=txt

### RecordIdHeader (optional)

This value is used as the column header for the record id (every line in the output file gets an unique sequence number starting at 1)

### bcpCommand (optional)

The bcp command used in the generated batch file. This can be a fully qualified path to the bcp command or just bcp if the path is in the dos path configuration.
The default value for the command is bcp.

### server (mandatory)

The name of the database server used in the generated batch file. 

### database (mandatory)

The name of the database used in the generated batch file. 

### folderfilecolumns (optional)

If value=true all created tables will contain the folder and file column. If value=false only the main table will contain 
the folder and file column. If omitted then value=false.

### firstPrefix (optional)

This is the first prefix used for the table names, e.g. value="publication" results in tables publication, publication_author,
publication_author_affiliation, etc. If this parameter is not present the value will be taken from the model.

### encoding (optional)

The encoding used for genereting the tab separated files and the bcp command. 

Possible values: 
-  unicode 
- utf8.

If encoding is not provided utf8 will be used.
From experience it is learned that using unicode is the best encoding for all datasources.

