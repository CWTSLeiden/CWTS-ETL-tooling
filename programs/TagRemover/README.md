# TagRemover.exe

**Date modified**: *17-02-2025*

## Purpose

This program removes HTML tags from a file and converts a string that has been HTML-encoded for HTTP transmission into a decoded string, e.g. `&Omega;` is decoded into `Ω`.


## Execute the program

Before execution of the program it needs to be configured. This is done by:

### 1.  Configuration file.

##
The name of the configuration file must be appsettings.json and it must be in the same folder as the program.
###
    Example:

    {
      "inputfile": "D:\Development\Projects\github\TestData\TagRemover\v1.2\source\_abstract_text.xxx",
      "outputfile": "D:\Development\Projects\github\TestData\TagRemover\v1.2\output\_abstract_text_cleaned.xxx",
      "logfile": "D:\Development\Projects\github\TestData\TagRemover\v1.2\output\tagremover__abstract_text_cleaned.log",
      "showoutput": "true"
    }

or by

### 2. Command line

    tagremover.exe InputFile="D:\Development\Projects\github\TestData\TagRemover\v1.2\source\_abstract_text.xxx" OutputFile="D:\Development\Projects\github\TestData\TagRemover\v1.2\output\_abstract_text_cleaned.xxx" LogFile="D:\Development\Projects\github\TestData\TagRemover\v1.2\output\tagremover__abstract_text_cleaned.log" ShowOutput 

## Parameters

### InputFile (mandatory)

Name of the file to process.

### OutputFile (mandatory)

Name of the file with the processed results.

### LogFile (optional)

Name of the log file. Only produced if ShowOutput is not set. When not specified, the log file will be written to the output folder.

### ShowOutput (optional)

Outputs log information to the screen. A log file is not written when ShowOutput is specified.