@ECHO OFF
chcp 65001 >nul
mode con: cols=80 lines=35

rem IF YOU WANT TO USE THIS SCRIPT IN YOUR TRANSLATION, JUST KEEP THE COPYRIGHT IN THE WELCOME SECTION;
rem  - SOYKA; WITH LOVE FROM RUSSIA! :>

TITLE Watch Dogs 2 Extended - Russian Language packer
FOR /F "delims=#" %%E IN ('"PROMPT #$E# & FOR %%E IN (1) DO REM"') DO SET "ESC=%%E"
SET currentDir=%~dp0

SET locFile=main_russian.loc
SET patchFile=patch3.fat

SET locFilePath=%currentDir%\%locFile%
set tempOutputDir=%currentDir%\temp

set WD2Extract=%currentDir%\tools\WD2Extract.exe
set WD2Pack=%currentDir%\tools\WD2Pack.exe

:welcome
ECHO                     ┌───────────────────────────────────┐
ECHO                     │        ┌──────────────┐           │
ECHO                     │        │ %ESC%[32mWATCH_DOGS 2%ESC%[0m │           │
ECHO                     │        └────────┌────────┐        │
ECHO                     │                 │%ESC%[36mEXTENDED%ESC%[0m│        │
ECHO                     │                 └────────┘        │
ECHO                     │    RUSSIAN LOCALIZATION PACKER    │
ECHO                     │      FOR %ESC%[94m2.5.0.0 Public Test%ESC%[0m      │
ECHO                     │                                   │
ECHO                     │      Soyka In The Cup © 2026      │
ECHO                     │        %ESC%[94mt.me/soykainthecup%ESC%[0m         │
ECHO                     └───────────────────────────────────┘
ECHO:
ECHO:
TIMEOUT 10

:prepare
IF EXIST "%tempOutputDir%" RMDIR /s /q "%tempOutputDir%"
IF EXIST "%locFilePath%" GOTO tools

ECHO %ESC%[31mERROR%ESC%[0m: loc file was not found!
TIMEOUT 10
EXIT

:tools
IF EXIST "%WD2Extract%" IF EXIST "%WD2Pack%" GOTO wd2efilequestion

ECHO %ESC%[31mERROR%ESC%[0m: %ESC%[94mWD2Extract%ESC%[0m or %ESC%[94mWD2Pack%ESC%[0m was not found in tools dir!
TIMEOUT 10
EXIT

:wd2efilequestion
CLS
SET /P wd2ePatchFilePath=Provide the file patch to the WD2E %ESC%[94m%patchFile%%ESC%[0m: 
FOR %%I IN ("%wd2ePatchFilePath%") DO SET "wd2ePatchFileName=%%~nxI"

IF /I "%wd2ePatchFileName%" == "%patchFile%" IF EXIST "%wd2ePatchFilePath%" GOTO extract

CLS
ECHO Wrong file path!
TIMEOUT 3

GOTO wd2efilequestion

:extract
CLS
ECHO Extracting...

"%WD2Extract%" "%wd2ePatchFilePath%" "%tempOutputDir%"

ECHO Extracted!
TIMEOUT 2

:copylocfile
CLS
ECHO Copying a localization file...

copy /y "%locFilePath%" "%tempOutputDir%\languages\%locFile%"

IF %ERRORLEVEL% NEQ 0 (
	ECHO %ESC%[31mERROR%ESC%[0m: Copying error! %ERRORLEVEL%
	TIMEOUT 10
	EXIT
) ELSE (
	ECHO Copied!
	TIMEOUT 2
)

:pack
CLS
ECHO Packing...

"%WD2Pack%" "%tempOutputDir%" "%currentDir%\%patchFile%"

ECHO Done!
TIMEOUT 2

:cleanup
CLS
ECHO Cleaning...

IF EXIST "%tempOutputDir%" RMDIR /s /q "%tempOutputDir%"

IF %ERRORLEVEL% NEQ 0 (
	ECHO %ESC%[31mERROR%ESC%[0m: Cleanup error! Don't worry, just delete the %ESC%[94mtemp%ESC%[0m folder by yourself! %ERRORLEVEL%
	TIMEOUT 2
)

ECHO Done!
TIMEOUT 2

:end
CLS
ECHO File was repacked! Now just copy %ESC%[94m%patchFile%%ESC%[0m to the game's %ESC%[94mdata_win64%ESC%[0m dir!
PAUSE