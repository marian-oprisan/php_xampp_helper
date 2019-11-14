@echo off

SET ROOTDIR=C:\xampp\htdocs\

IF NOT EXIST %ROOTDIR% ( 
    ECHO The htdocs folder cannot be found at C:\xampp\
    GOTO :EOF 
)

IF "%1"=="" (
    ECHO Selecting latest used folder.
    REM Move to the last modified folder in htdocs\
    CD %ROOTDIR%

    FOR /f "tokens=* delims=" %%i in ('dir /ad /b /o-d ^| find /v "%ROOTDIR% "') DO (
        CD %%~dpni
        FOR %%i in (.) do @ECHO %%~ni > %ROOTDIR%activedir.txt
        GOTO :EOF
    )
)

SET TARGETFOLDER=%ROOTDIR%%1

IF EXIST %TARGETFOLDER% ( GOTO :FOUND )
IF NOT EXIST %TARGETFOLDER% ( GOTO :NOTFOUND )

:FOUND
CD %TARGETFOLDER%
GOTO :SUCCESS

:NOTFOUND
ECHO No such folder.
SET /P CREATEFOLDERPROMPT=Do you want to create it (Y/[N])
IF /I "%CREATEFOLDERPROMPT%" EQU "Y" (
        MKDIR %TARGETFOLDER%
        CD %TARGETFOLDER%
        GOTO :SUCCESS
)
GOTO :EOF

:SUCCESS
ECHO %1 > %ROOTDIR%activedir.txt
GOTO :EOF

ECHO Here are your choices:
DIR /a:d /w /b %ROOTDIR%