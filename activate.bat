@echo off

set functions=%~dp0\functions
set programs=%~dp0\programs

call %functions%\folder.bat
call %programs%\executables.bat
call %functions%\check_errors.bat
