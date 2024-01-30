LargeFileSplitter.exe

Purpose:

Split a large file into multiple smaller files.

Execute:

To execute this program is must be called from a batch file or command line. The programs must be called with parameters on the command line
or set in a configuration file. The name of the configuration file must be largefilesplitter.exe.config. This folder contains an example of a configuration file.

Parameters:

FileToSplit
The fully qualified name of the file to split.

OutpuFolder
The fully qualiefied name of the folder where the resulting files are saved. The log and error file are also saved to this folder. There will only be an error file
if an error has occurred during exectuion of the program.

LogFolder
The fully qualiefied name of the folder where the log and error files are saved. If the logfolder is not provided or does noet exist an error is shown in the console.

BlockSize
The number of lines in each splitted file.

OutputFirstNBlocks
The number of split files to create. Default all the blocks are created.

OutputFileExtension
The extension of the split files. The default is the same as the extension of the original file.