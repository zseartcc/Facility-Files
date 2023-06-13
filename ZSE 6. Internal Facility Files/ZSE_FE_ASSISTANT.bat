@ECHO OFF

TITLE ZSE FE ASSISTANT


:: Dropbox location (for ZSE PUBLIC)
IF EXIST %userprofile%\Dropbox (
	SET DROPBOX_PATH=%userprofile%\Dropbox
) ELSE (
	SET /P DROPBOX_PATH=Dropbox path: 
)

:: ZSE 6. Internal Facility Files location
IF EXIST "%userprofile%\Documents\Facility-Files\ZSE 6. Internal Facility Files" (
	SET IFF_PATH=%userprofile%\Documents\Facility-Files\ZSE 6. Internal Facility Files
) ELSE IF EXIST "%userprofile%\OneDrive\Documents\GitHub\Facility-Files\ZSE 6. Internal Facility Files" (
	SET IFF_PATH=%userprofile%\OneDrive\Documents\GitHub\Facility-Files\ZSE 6. Internal Facility Files
) ELSE IF EXIST "D:\GithubRepos\Facility-Files\ZSE 6. Internal Facility Files" (
	SET IFF_PATH=D:\GithubRepos\Facility-Files\ZSE 6. Internal Facility Files
) ELSE (
	SET /P IFF_PATH=""ZSE 6. Internal Facility Files" path: "
)


:HELLO

CLS

ECHO.
ECHO.
ECHO                   **********
ECHO                    ADVISORY
ECHO                   **********
ECHO.
ECHO This batch script requires Dropbox to be at:
ECHO.
ECHO %DROPBOX_PATH%
ECHO.
ECHO and for ZSE 6. Internal Facility Files to be at:
ECHO.
ECHO %IFF_PATH%
ECHO.
ECHO.

PAUSE

:HELLO2

CLS

ECHO.
ECHO.
ECHO  WHAT DO YOU WANT TO DO?
ECHO.
ECHO.
ECHO      A) Split a current vERAM ZSE GeoMaps.xml or vSTARS Video Maps.xml into multiple individual files.
ECHO.
ECHO.
ECHO      B) Take the export data from the FE-BUDDY parser and transfer to coorisponding EDIT files.
ECHO.
ECHO.
ECHO      C) Combine split GeoMaps or Video Maps into a single ZSE GeoMaps.xml or ___ Video Maps.xml file.
echo            - Ensure only the files that you want to combine are in the directory you select.
ECHO.
ECHO.
ECHO      D) Combine and Transfer all EDIT SCT files to the Pre-Release ZSE SECTOR.sct2 file.
ECHO.
ECHO.
ECHO      E) Combine and Transfer all EDIT ALIAS files to the Pre-Release ZSE ALIAS.txt file.
ECHO              ---REMINDER: Launch vSTARS/vERAM, load new Alias/POF/GEOMAPs as needed and
ECHO                 export the .gz to Pre-Release folder.
ECHO.
ECHO.
ECHO      F) Transfer Pre-Release Files to ZSE PUBLIC Folder.
ECHO.
ECHO.

:GOAL_CHOICE

SET /P GOAL=Type A-F and press Enter: 
	if /i %GOAL%==A GOTO SPLITMAPS
	if /i %GOAL%==B GOTO NASR2EDIT
	if /i %GOAL%==C GOTO COMBINEMAPS
	if /i %GOAL%==D GOTO SCTEDIT_2_PRERELEASE
	if /i %GOAL%==E GOTO ALIASE2PR
	if /i %GOAL%==F GOTO AUTO_TRANSFER
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %GOAL% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto GOAL_CHOICE

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:SPLITMAPS

CLS

ECHO.
ECHO.
ECHO  *** SPLIT MAPS ***
ECHO.
ECHO.
ECHO What type of map are you splitting?
ECHO.
ECHO  S) vSTARS
echo.
echo  E) vERAM
ECHO.
ECHO.

SET GOAL=-

:SPLIT_CHOICE

SET /P GOAL=Type S or E and press Enter: 
	if /i %GOAL%==S GOTO SPLITVIDEO
	if /i %GOAL%==E GOTO SPLITGEO
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %GOAL% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto SPLIT_CHOICE

:SPLITVIDEO

CLS

ECHO.
ECHO.
ECHO  *** SPLIT VIDEO MAPS ***
ECHO.
ECHO.
ECHO ASSUMES:
ECHO.
ECHO  1) Video Map "LongName" descriptions do not have any symbols that can't be used in the name of a text file.
echo            Ex: \/:*?"<>|
echo.
echo  2) The .xml to be split MUST be named like so: "SLC Video Maps.xml" "BOI Video Maps.xml" "BZN Video Maps.xml" etc...
echo.
ECHO  3) If ran before, those old files will be overwritten if the description name of the map is the same as last time.
ECHO.
ECHO.

SET /P FAC_ID=Type the three character abbreviation of the facility video map you wish to split and press Enter: 
	SET FAC_ID=%FAC_ID: =%
	
CLS

ECHO.
ECHO.
ECHO  Is this the file you wish to split?
ECHO.
ECHO  "%FAC_ID% Video Maps.xml"
ECHO.
ECHO.

SET Y_N=-

SET /P Y_N=Type Y or N and Press Enter: 
	if /i %Y_N%==Y SET VM_FILE_NAME=%FAC_ID% Video Maps.xml
	if /i %Y_N%==Y GOTO VM_SRC_DIR_CHK
	if /i %Y_N%==N GOTO SPLITVIDEO
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %Y_N% *** is NOT a recognized response. Try again...
	echo.
	echo.
	pause
	goto SPLITVIDEO

:VM_SRC_DIR_CHK

CD /D "%userprofile%\AppData\Roaming\vSTARS\Video Maps"

IF EXIST "%VM_FILE_NAME%" SET SOURCE_DIR=%userprofile%\AppData\Roaming\vSTARS\Video Maps
IF EXIST "%VM_FILE_NAME%" goto VM_TAR_DIR

:VM_SRC_DIR

CLS

ECHO.
ECHO.
ECHO Select the directory that the %VM_FILE_NAME% is in.
ECHO.
ECHO.

set SOURCE_DIR=NOTHING

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select The Folder That Houses The ZSE GeoMaps.xml',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "SOURCE_DIR=%%I"
	
	IF "%SOURCE_DIR%"=="NOTHING" EXIT /B

:VM_TAR_DIR

CLS

ECHO.
ECHO.
ECHO Is this where you want all of the individual .xml files to be placed.
ECHO.
ECHO  %DROPBOX_PATH%\...
ECHO   ...ZSE 6. Internal Facility Files\EDIT vSTARS Video Maps\%FAC_ID%
ECHO.
ECHO.

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y set TARGET_DIR=%IFF_PATH%\EDIT vSTARS Video Maps\%FAC_ID%
	if /i %USERSELECT%==Y GOTO STRT_VMSPLIT
	if /i %USERSELECT%==N GOTO CSE_VMTAR_DIR
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	PAUSE
	goto VM_TAR_DIR

:CSE_VMTAR_DIR

set TARGET_DIR=NOTHING

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select the you want all of the individual .xml files to be placed.',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "TARGET_DIR=%%I"
	
	IF "%TARGET_DIR%"=="NOTHING" EXIT /B

:STRT_VMSPLIT

CLS

CD "%SOURCE_DIR%"

SET SOURCE_FILE=%VM_FILE_NAME%

TYPE "%SOURCE_FILE%">"%TARGET_DIR%\TEMP_SOURCE_FILE.txt"

CD "%TARGET_DIR%"

ECHO.
ECHO.
ECHO PROCESSED:
ECHO.
ECHO.
ECHO 100000_HEADER.xml

setlocal EnableDelayedExpansion

SET /A COUNT=100000

SET PHASE=HEADER

for /f "tokens=* delims=" %%a in (TEMP_SOURCE_FILE.txt) do (
	
	SET LINE=%%a
	
	IF NOT !PHASE!==FOOTER (
	
		SET PHASE_CHK=!LINE:~3,8!
			IF "!PHASE_CHK!"=="VideoMap" SET PHASE=VideoMapSTART
		
		SET PHASE_CHK=!LINE:~2,9!
			IF "!PHASE_CHK!"=="VideoMaps" SET PHASE=FOOTER
			
		IF "!PHASE!"=="VideoMapSTART" (
		
			SET VM_LINE_CHK=!LINE:~3,1!
				IF NOT "!VM_LINE_CHK!"=="V" SET PHASE=VM_LINE
		)
	)
	
	IF !PHASE!==HEADER (
		ECHO !LINE!>>"%TARGET_DIR%\100000_HEADER.xml"
	)
	
	IF !PHASE!==VideoMapSTART (
		
		SET /A COUNT=!COUNT! + 100
		
		SET LINE_CONVERT="!LINE!"
		
		for /f "tokens=3 delims==" %%a in (!LINE_CONVERT!) do set LONGNAME=%%a

			SET LONGNAME=!LONGNAME:~1,-12!
			
		ECHO !LINE!>>"!COUNT!_!LONGNAME!.xml"
		ECHO !COUNT!_!LONGNAME!
	)
	
	IF !PHASE!==VM_LINE (
		
		ECHO !LINE!>>"!COUNT!_!LONGNAME!.xml"
	)
	
	IF !PHASE!==FOOTER (
	
		ECHO !LINE!>>"9999999_FOOTER.xml"
	)
)

endlocal

DEL /Q TEMP_SOURCE_FILE.txt>NUL

ECHO.
ECHO.
ECHO DONE
ECHO.
ECHO.

pause

GOTO HELLO2

:SPLITGEO

CLS

ECHO.
ECHO.
ECHO  *** SPLIT GEO MAPS ***
ECHO.
ECHO.
ECHO ASSUMES:
ECHO.
ECHO  1) GeoMap descriptions do not have any symbols that can't be used in the name of a text file.
echo            Ex: \/:*?"<>|
echo.
echo  2) There is only one BCG, FILTER, and GEOMAPSet and they are all labeled "ZSE".
echo.
echo  3) The .xml to be split MUST be named like so: "ZSE GeoMaps.xml".
echo.
ECHO  4) If ran before, those old files will be overwritten if the description name of the map is the same as last time.
ECHO.
ECHO.

pause

CLS

ECHO.
ECHO.
ECHO IS THE FOLLOWING DIRECTORY CORRECT FOR THE ZSE GeoMaps.xml THAT YOU WANT TO SPLIT?
ECHO.
ECHO  %userprofile%\AppData\Local\vERAM\GeoMaps
ECHO.
ECHO.

SET USERSELECT=Nothing

:CHOICE_SPLITGEO

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y set SOURCE_DIR=%userprofile%\AppData\Local\vERAM\GeoMaps
	if /i %USERSELECT%==Y GOTO TAR_DIR
	if /i %USERSELECT%==N GOTO SRC_DIR
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto CHOICE_SPLITGEO

:SRC_DIR

ECHO.
ECHO.
ECHO Select the directory that the ZSE GeoMaps.xml is in.
ECHO.
ECHO.

set SOURCE_DIR=NOTHING

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select The Folder That Houses The ZSE GeoMaps.xml',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "SOURCE_DIR=%%I"
	
	IF "%SOURCE_DIR%"=="NOTHING" EXIT /B

:TAR_DIR

CLS

ECHO.
ECHO.
ECHO Is this where you want all of the individual .xml files to be placed.
ECHO.
ECHO  %DROPBOX_PATH%\...
ECHO   ...ZSE 6. Internal Facility Files\EDIT vERAM GeoMaps\SPLIT MAPS
ECHO.
ECHO.

:TAR_DIR_CHOICE

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y set TARGET_DIR=%IFF_PATH%\EDIT vERAM GeoMaps\SPLIT MAPS
	if /i %USERSELECT%==Y GOTO STRT_GEOSPLIT
	if /i %USERSELECT%==N GOTO CSE_TAR_DIR
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto TAR_DIR_CHOICE

:CSE_TAR_DIR

set TARGET_DIR=NOTHING

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select the you want all of the individual .xml files to be placed.',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "TARGET_DIR=%%I"
	
	IF "%TARGET_DIR%"=="NOTHING" EXIT /B

:STRT_GEOSPLIT

CLS

CD "%SOURCE_DIR%"

SET SOURCE_FILE=ZSE GeoMaps.xml

TYPE "%SOURCE_FILE%">"%TARGET_DIR%\TEMP_SOURCE_FILE.txt"

CD "%TARGET_DIR%"

ECHO.
ECHO.
ECHO PROCESSED:
ECHO.
ECHO.
ECHO 100000_HEADER.xml


setlocal EnableDelayedExpansion

SET /A COUNT=100000

SET PHASE=HEADER

for /f "tokens=* delims=" %%a in (TEMP_SOURCE_FILE.txt) do (
	
	SET LINE=%%a
		
		SET LINE_CONVERT="!LINE!"
	
	IF NOT !PHASE!==FOOTER (
	
		SET PHASE_CHK=!LINE:~9,12!
			IF !PHASE_CHK!==GeoMapObject SET PHASE=GeoMapObject
		
		ECHO !LINE_CONVERT! | findstr /L /C:"Defaults Bcg" >nul
				if !errorlevel!==0 set PHASE=Defaults

		SET PHASE_CHK=!LINE:~11,8!
			IF !PHASE_CHK!==Elements SET PHASE=Elements

		SET PHASE_CHK=!LINE:~13,7!
			IF !PHASE_CHK!==Element SET PHASE=Element
		
		SET PHASE_CHK=!LINE:~12,8!
			IF !PHASE_CHK!==Elements SET PHASE=Elements_END
			
		SET PHASE_CHK=!LINE:~10,12!
			IF !PHASE_CHK!==GeoMapObject SET PHASE=GeoMapObject_END
		
		SET PHASE_CHK=!LINE:~8,7!
			IF !PHASE_CHK!==Objects SET PHASE=FOOTER
	)
		
	IF !PHASE!==HEADER (
		ECHO !LINE!>>"%TARGET_DIR%\100000_HEADER.xml"
	)
	
	IF !PHASE!==GeoMapObject (
		
		SET /A COUNT=!COUNT! + 100
		
		for /f "tokens=2 delims==" %%a in (!LINE_CONVERT!) do set DESCRIPTION=%%a

			SET DESCRIPTION=!DESCRIPTION:~1,-9!
			
		ECHO !LINE!>"!COUNT!_!DESCRIPTION!.xml"
	)
	
	IF NOT !PHASE!==HEADER IF NOT !PHASE!==GeoMapObject IF NOT !PHASE!==FOOTER (
		
		ECHO !LINE!>>"!COUNT!_!DESCRIPTION!.xml"
	)
	
	IF !PHASE!==GeoMapObject_END (
	
		ECHO !COUNT!_!DESCRIPTION!.xml
	)
	
	IF !PHASE!==FOOTER (
	
		ECHO !LINE!>>"9999999_FOOTER.xml"
	)
)

endlocal

DEL /Q TEMP_SOURCE_FILE.txt>NUL

ECHO.
ECHO.
ECHO DONE
ECHO.
ECHO.

pause

GOTO HELLO2

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:COMBINEMAPS

CLS

ECHO.
ECHO.
ECHO  *** COMBINE MAPS ***
ECHO.
ECHO.
ECHO What type of map are you combining?
ECHO.
ECHO  S) vSTARS
echo.
echo  E) vERAM
ECHO.
ECHO.

SET GOAL=-

:COMB_CHOICE

SET /P GOAL=Type S or E and press Enter: 
	if /i %GOAL%==S GOTO COMBINEVM
	if /i %GOAL%==E GOTO COMBINEGEO
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %GOAL% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto COMB_CHOICE

:COMBINEVM

CLS

CD /D "%IFF_PATH%\EDIT vSTARS Video Maps"

ECHO.
ECHO.
SET /P FAC_ID=Type the three character abbreviation of the facility video maps you wish to combine and press Enter: 
	SET FAC_ID=%FAC_ID: =%

IF NOT EXIST %FAC_ID% (
ECHO.
ECHO.
ECHO **********  ERROR  **********
ECHO.
ECHO  DIRECTORY NOT FOUND:
ECHO.
ECHO  %DROPBOX_PATH%\...
ECHO   ...ZSE 6. Internal Facility Files\EDIT vSTARS Video Maps\%FAC_ID%
ECHO.
ECHO  TRY AGAIN...
ECHO.
PAUSE
GOTO COMBINEVM
)

CLS

ECHO.
ECHO.
ECHO  *** COMBINE VIDEO MAPS ***
ECHO.
ECHO.
ECHO.
ECHO.
ECHO Is this where all of the .xml files that you want to combine are located?
ECHO.
ECHO  %DROPBOX_PATH%\...
ECHO   ...ZSE 6. Internal Facility Files\EDIT vSTARS Video Maps\%FAC_ID%
ECHO.
ECHO.

:VM-DIR_CHOICE

set USERSELECT=Not_set

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y set SOURCE_DIR=%IFF_PATH%\EDIT vSTARS Video Maps\%FAC_ID%
	if /i %USERSELECT%==Y GOTO STRT_COMBVM
	if /i %USERSELECT%==N GOTO VM-SRC_DIR
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto VM-DIR_CHOICE

:VM-SRC_DIR

CLS

ECHO.
ECHO.
ECHO Select the directory that hosts the individual .xml files.
ECHO.
ECHO.

SET SOURCE_DIR=NOTHING

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select the directory that hosts the individual .xml files',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "SOURCE_DIR=%%I"
	
	IF "%SOURCE_DIR%"=="NOTHING" EXIT /B

:STRT_COMBVM

CLS

CD "%SOURCE_DIR%"

IF EXIST COMBINED RD /Q /S COMBINED
MD COMBINED

TYPE *.xml>"%SOURCE_DIR%\COMBINED\%FAC_ID% Video Maps.xml"

:COMBVM_DONE

CLS

ECHO.
ECHO.
ECHO DONE
ECHO.
ECHO.
ECHO You may find %FAC_ID% Video Maps.xml HERE:
ECHO.
ECHO   %SOURCE_DIR%\COMBINED
ECHO.
ECHO.
ECHO.
ECHO.
ECHO ---------------------------------------------------------
ECHO.
ECHO Do you want to have the new combined file replace
ECHO the %FAC_ID% Video Maps.xml that should be located here?:
ECHO.
ECHO %AppData%\vSTARS\Video Maps
ECHO.
ECHO.

:VM_DONE_CH
	
set USERSELECT=Not_set

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y GOTO REPLACE_VM
	if /i %USERSELECT%==N GOTO HELLO2
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto VM_DONE_CH

:REPLACE_VM

COPY "%SOURCE_DIR%\COMBINED\%FAC_ID% Video Maps.xml" "%AppData%\vSTARS\Video Maps"

CLS

ECHO.
ECHO.
ECHO MOVED THE COMBINED %FAC_ID% Video Maps.xml to:
ECHO.
ECHO %AppData%\vSTARS\Video Maps
ECHO.
ECHO.

PAUSE

GOTO HELLO2

:COMBINEGEO

CLS

ECHO.
ECHO.
ECHO  *** COMBINE GEO MAPS ***
ECHO.
ECHO.
ECHO.
ECHO.
ECHO Is this where all of the .xml files that you want to combine are located?
ECHO.
ECHO  %DROPBOX_PATH%\...
ECHO   ...ZSE 6. Internal Facility Files\EDIT vERAM GeoMaps\SPLIT MAPS
ECHO.
ECHO.

:SRC_DIR_CHOICE

set USERSELECT=Not_set

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y set SOURCE_DIR=%IFF_PATH%\EDIT vERAM GeoMaps\SPLIT MAPS
	if /i %USERSELECT%==Y GOTO STRT_COMBGEO
	if /i %USERSELECT%==N GOTO CSE_SRC_DIR
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto SRC_DIR_CHOICE

:CSE_SRC_DIR

CLS

ECHO.
ECHO.
ECHO Select the directory that hosts the individual .xml files.
ECHO.
ECHO.

SET SOURCE_DIR=NOTHING

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select the directory that hosts the individual .xml files',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "SOURCE_DIR=%%I"
	
	IF "%SOURCE_DIR%"=="NOTHING" EXIT /B

:STRT_COMBGEO

CLS

CD "%SOURCE_DIR%"

IF EXIST COMBINED RD /Q /S COMBINED
MD COMBINED

TYPE *.xml>"%SOURCE_DIR%\COMBINED\ZSE GeoMaps.xml"

:COMBGEO_DONE

CLS

ECHO.
ECHO.
ECHO DONE
ECHO.
ECHO.
ECHO You may find your ZSE GeoMaps.xml here:
ECHO.
ECHO   %SOURCE_DIR%\COMBINED
ECHO.
ECHO.
ECHO.
ECHO.
ECHO -------------------------------------------------
ECHO.
ECHO Do you want to have the new combined file replace
ECHO the ZSE GeoMaps.xml that should be located here?:
ECHO.
ECHO %userprofile%\AppData\Local\vERAM\GeoMaps
ECHO.
ECHO.

:CBGEO_DONE_CH
	
set USERSELECT=Not_set

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y GOTO REPLACE_GEO
	if /i %USERSELECT%==N GOTO HELLO2
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto CBGEO_DONE_CH

:REPLACE_GEO

COPY "%SOURCE_DIR%\COMBINED\ZSE GeoMaps.xml" "%userprofile%\AppData\Local\vERAM\GeoMaps"

CLS

ECHO.
ECHO.
ECHO MOVED THE COMBINED ZSE GeoMaps.xml to:
ECHO.
ECHO %userprofile%\AppData\Local\vERAM\GeoMaps
ECHO.
ECHO.

PAUSE

GOTO HELLO2

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:NASR2EDIT

ECHO.
ECHO.
ECHO  *** FE-BUDDY Output to EDIT FOLDERS ***
ECHO.
ECHO.
ECHO  This BATCH File will take the export data from the FE-BUDDY parser and
ECHO  transfer the following to the coorisponding files:
ECHO.
ECHO.
ECHO         ALIAS:                                  EDIT ALIAS:
ECHO.
ECHO         ISR_APT.txt                   ---       *_AIRPORT ISR.txt
ECHO.
ECHO         ISR_NAVAID.txt                ---       *_NAVAID ISR.txt
ECHO.
ECHO         AWY_ALIAS.txt                 ---       *_AIRWAY FIXES ALIAS.txt
ECHO.
ECHO         STAR_DP_Fixes_Alias.txt       ---       *_STAR DP FIXES ALIAS.txt
ECHO.
ECHO         FAA_CHART_RECALL.txt          ---       *_FAA CHART RECALL.txt
ECHO.
ECHO     -------------------------------------------------------------------------------
ECHO.
ECHO         VRC:                                    EDIT SCT:
ECHO.
ECHO         [AIRPORT].sct2                ---       05_AIRPORT\[AIRPORT].txt
ECHO.           
ECHO         [ARTCC HIGH].sct2             ---       09_ARTCC_HIGH\[ARTCC HIGH].txt
ECHO.           
ECHO         [ARTCC LOW].sct2              ---       10_ARTCC_LOW\[ARTCC LOW].txt
ECHO.           
ECHO         [HIGH AIRWAY].sct2            ---       14_HIGH_AIRWAY\[HIGH AIRWAY].txt
ECHO.           
ECHO         [LOW AIRWAY].sct2             ---       13_LOW_AIRWAY\[LOW AIRWAY].txt
rem ECHO.           
rem ECHO         [LABELS].sct2                 ---       17_LABELS\[LABELS].txt
ECHO.           
ECHO         [NDB].sct2                    ---       04_NDB\[NDB].txt
ECHO.           
ECHO         [VOR].sct2                    ---       03_VOR\[VOR].txt
ECHO.           
ECHO         [RUNWAY].sct2                 ---       06_RUNWAY\[RUNWAY].txt
ECHO.           
ECHO         [FIXES].sct2                  ---       07_FIXES\[FIXES].txt
ECHO.           
ECHO         000_All_DP_Combined.sct2      ---       11_SID\*_All_DP_Combined.sct2
ECHO.           
ECHO         000_All_STAR_Combined.sct2    ---       11_SID\*_All_STAR_Combined.sct2
ECHO.
ECHO     -------------------------------------------------------------------------------
ECHO.
ECHO         vERAM:                                  EDIT vERAM GeoMaps\SPLIT MAPS:
ECHO.           
ECHO         AIRPORTS_GEOMAP.xml           ---       *_APT.xml
ECHO.           
ECHO         NAVAID_GEOMAP.xml             ---       *_NAVAIDS.xml
ECHO.
ECHO         AWY_GEOMAP.xml                ---       *_AIRWAYS.xml
ECHO.
ECHO         ALL_DP_GEOMAP.xml             ---       *_ALL_DPs.xml
ECHO.
ECHO         ALL_STAR_GEOMAP.xml           ---       *_ALL_STARs.xml
ECHO.
ECHO         AIRPORT_TEXT_GEOMAP.xml       ---       *_AIRPORT_TEXT.xml
ECHO.
ECHO         NAVAID_TEXT_GEOMAP.xml        ---       *_NAVAID_TEXT.xml
ECHO.
ECHO     -------------------------------------------------------------------------------
ECHO.     
ECHO            It will then move the following two files to the
echo            Pre-Release\ZSE Facility Files WIP\
echo            vERAM and vSTARS folders.
ECHO.
ECHO            Airports.xml ^& Waypoints.xml
ECHO.
ECHO.
ECHO.
ECHO.

pause

:DIR_CHOICE

CLS

ECHO.
ECHO.
ECHO Select the FE-BUDDY_Output Folder
ECHO.
ECHO.

set SOURCE_DIR=NOTHING

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select the FE-BUDDY_Output Folder',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "SOURCE_DIR=%%I"
	
	IF "%SOURCE_DIR%"=="NOTHING" EXIT /B
		
		SET SOURCE_DIR_CHK=%SOURCE_DIR:~-15%
		
		IF NOT "%SOURCE_DIR_CHK%"=="FE-BUDDY_Output" (
			ECHO.
			ECHO.
			ECHO.
			ECHO The expected "Source" folder is "FE-BUDDY_Output"
			ECHO.
			ECHO You selected:
			echo    %SOURCE_DIR%
			echo.
			echo.
			echo  Try again...
			echo.
			echo.
			PAUSE
			goto DIR_CHOICE
		)

CLS

ECHO.
ECHO.
ECHO TRANSFERRED:
ECHO.
ECHO.

:ALIAS

SET TARGET_DIR=%IFF_PATH%\EDIT ALIAS
SET FILE_NAME_ENDING=_AIRPORT ISR.txt

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\ALIAS"
	TYPE "ISR_APT.txt">"%TARGET_DIR%\%file_name%"
	ECHO ALIAS - ISR_APT

SET FILE_NAME_ENDING=_NAVAID ISR.txt

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\ALIAS"
	TYPE "ISR_NAVAID.txt">"%TARGET_DIR%\%file_name%"
	ECHO ALIAS - ISR_NAVAID

SET FILE_NAME_ENDING=_AIRWAY FIXES ALIAS.txt

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\ALIAS"
	TYPE "AWY_ALIAS.txt">"%TARGET_DIR%\%file_name%"
	ECHO ALIAS - AWY Fixes

SET FILE_NAME_ENDING=_STAR DP FIXES ALIAS.txt

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\ALIAS"
	TYPE "STAR_DP_Fixes_Alias.txt">"%TARGET_DIR%\%file_name%"
	ECHO ALIAS - STAR and DP Fixes
	
SET FILE_NAME_ENDING=_FAA CHART RECALL.txt

	CD "%TARGET_DIR%"
		for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G
		
	CD "%SOURCE_DIR%\ALIAS"
	IF EXIST "%SOURCE_DIR%\ALIAS\FAA_CHART_RECALL.txt" TYPE "FAA_CHART_RECALL.txt">"%TARGET_DIR%\%file_name%"
	IF EXIST "%SOURCE_DIR%\ALIAS\FAA_CHART_RECALL.txt" ECHO ALIAS - FAA CHART RECALL Commands

:VRC_APT

SET TARGET_DIR=%IFF_PATH%\EDIT SCT\05_AIRPORT

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[AIRPORT].sct2">"%TARGET_DIR%\[AIRPORT].txt"
	ECHO VRC - AIRPORTS

:VRC_ARTCC_HI

SET TARGET_DIR=%IFF_PATH%\EDIT SCT\09_ARTCC_HIGH

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[ARTCC HIGH].sct2">"%TARGET_DIR%\[ARTCC HIGH].txt"
	ECHO VRC - ARTCC HIGH

:VRC_ARTCC_LO

SET TARGET_DIR=%IFF_PATH%\EDIT SCT\10_ARTCC_LOW

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[ARTCC LOW].sct2">"%TARGET_DIR%\[ARTCC LOW].txt"
	ECHO VRC - ARTCC LOW

:VRC_AWY_HI

SET TARGET_DIR=%IFF_PATH%\EDIT SCT\14_HIGH_AIRWAY

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[HIGH AIRWAY].sct2">"%TARGET_DIR%\[HIGH AIRWAY].txt"
	ECHO VRC - HIGH AIRWAYS

:VRC_AWY_LO

SET TARGET_DIR=%IFF_PATH%\EDIT SCT\13_LOW_AIRWAY

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[LOW AIRWAY].sct2">"%TARGET_DIR%\[LOW AIRWAY].txt"
	ECHO VRC - LOW AIRWAYS

rem :VRC_LABELS

rem SET TARGET_DIR=%IFF_PATH%\EDIT SCT\17_LABELS

rem CD "%TARGET_DIR%"
rem 	DEL /Q *.txt>nul

rem CD "%SOURCE_DIR%\VRC"
rem 	TYPE "[LABELS].sct2">"%TARGET_DIR%\[LABELS].txt"
rem 	ECHO VRC - LABELS

:VRC_NDB

SET TARGET_DIR=%IFF_PATH%\EDIT SCT\04_NDB

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[NDB].sct2">"%TARGET_DIR%\[NDB].txt"
	ECHO VRC - NDB

:VRC_VOR

SET TARGET_DIR=%IFF_PATH%\EDIT SCT\03_VOR

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[VOR].sct2">"%TARGET_DIR%\[VOR].txt"
	ECHO VRC - VOR

:VRC_RWY

SET TARGET_DIR=%IFF_PATH%\EDIT SCT\06_RUNWAY

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[RUNWAY].sct2">"%TARGET_DIR%\[RUNWAY].txt"
	ECHO VRC - RUNWAY

:VRC_FIX

SET TARGET_DIR=%IFF_PATH%\EDIT SCT\07_FIXES

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[FIXES].sct2">"%TARGET_DIR%\[FIXES].txt"
	ECHO VRC - FIXES

:VRC_SID

SET TARGET_DIR=%IFF_PATH%\EDIT SCT\11_SID
SET FILE_NAME_ENDING=_All_DP_Combined.txt

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VRC\[SID]"
	findstr /L /V "[SID]" 000_All_DP_Combined.sct2>>000_All_DP_Combined_temp.sct2
	TYPE "000_All_DP_Combined_temp.sct2">"%TARGET_DIR%\%file_name%"
	DEL /Q 000_All_DP_Combined_temp.sct2>NUL
	ECHO VRC - ALL DPs COMBINED

:VRC_STAR

SET TARGET_DIR=%IFF_PATH%\EDIT SCT\11_SID
SET FILE_NAME_ENDING=_All_STAR_Combined.txt

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VRC\[STAR]"
	findstr /L /V "[STAR]" 000_All_STAR_Combined.sct2>>000_All_STAR_Combined_temp.sct2
	TYPE "000_All_STAR_Combined_temp.sct2">"%TARGET_DIR%\%file_name%"
	DEL /Q 000_All_STAR_Combined_temp.sct2>NUL
	ECHO VRC - ALL STARs COMBINED

:vERAM_APT_GEOMAP

SET TARGET_DIR=%IFF_PATH%\EDIT vERAM GeoMaps\SPLIT MAPS
SET FILE_NAME_ENDING=_APT.xml

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VERAM"
	TYPE "AIRPORTS_GEOMAP.xml">"%TARGET_DIR%\%file_name%"
	ECHO vERAM - APT GEOMAP

:vERAM_NAV_GEOMAP

SET TARGET_DIR=%IFF_PATH%\EDIT vERAM GeoMaps\SPLIT MAPS
SET FILE_NAME_ENDING=_NAVAIDS.xml

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VERAM"
	TYPE "NAVAID_GEOMAP.xml">"%TARGET_DIR%\%file_name%"
	ECHO vERAM - NAV GEOMAP

:vERAM_WX_GEOMAP

SET TARGET_DIR=%IFF_PATH%\EDIT vERAM GeoMaps\SPLIT MAPS
SET FILE_NAME_ENDING=_WX STATIONS

CD "%TARGET_DIR%"

	IF EXIST changed.txt del /q changed.txt>NUL
	IF EXIST Temp_file.txt del /q Temp_file.txt>NUL

	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VERAM"

	TYPE "WX_STATIONS_GEOMAP.xml">"%TARGET_DIR%\Temp_file.txt"

CD "%TARGET_DIR%"

powershell -Command "(gc "Temp_file.txt") -replace '"false"', '"true"' | Out-File -encoding ASCII changed.txt"

TYPE "changed.txt">"%file_name%"

del /q changed.txt Temp_file.txt>NUL

ECHO vERAM - WX STATIONS GEOMAP    ***Changed TDM from False to True***

:vERAM_AWY_GEOMAP

SET TARGET_DIR=%IFF_PATH%\EDIT vERAM GeoMaps\SPLIT MAPS
SET FILE_NAME_ENDING=_AIRWAYS.xml

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VERAM"
	TYPE "AWY_GEOMAP.xml">"%TARGET_DIR%\%file_name%"
	ECHO vERAM - AWY GEOMAP

:vERAM_DP_GEOMAP

SET TARGET_DIR=%IFF_PATH%\EDIT vERAM GeoMaps\SPLIT MAPS
SET FILE_NAME_ENDING=_ALL_DPs.xml

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VERAM"
	TYPE "ALL_DP_GEOMAP.xml">"%TARGET_DIR%\%file_name%"
	ECHO vERAM - ALL DPs GEOMAP

:vERAM_STAR_GEOMAP

SET TARGET_DIR=%IFF_PATH%\EDIT vERAM GeoMaps\SPLIT MAPS
SET FILE_NAME_ENDING=_ALL_STARs.xml

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VERAM"
	TYPE "ALL_STAR_GEOMAP.xml">"%TARGET_DIR%\%file_name%"
	ECHO vERAM - ALL STARs GEOMAP

:vERAM_APT_TXT_GEOMAP

SET TARGET_DIR=%IFF_PATH%\EDIT vERAM GeoMaps\SPLIT MAPS
SET FILE_NAME_ENDING=_AIRPORT_TEXT.xml

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VERAM"
	TYPE "AIRPORT_TEXT_GEOMAP.xml">"%TARGET_DIR%\%file_name%"
	ECHO vERAM - APT TXT GEOMAP

:vERAM_NAV_TXT_GEOMAP

SET TARGET_DIR=%IFF_PATH%\EDIT vERAM GeoMaps\SPLIT MAPS
SET FILE_NAME_ENDING=_NAVAID_TEXT.xml

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VERAM"
	TYPE "NAVAID_TEXT_GEOMAP.xml">"%TARGET_DIR%\%file_name%"
	ECHO vERAM - NAV TXT GEOMAP

:ERAM_NAVDATA

SET TARGET_DIR=%IFF_PATH%\Pre-Release\ZSE Facility Files WIP\vERAM

CD "%SOURCE_DIR%\VERAM"
	TYPE "Airports.xml">"%TARGET_DIR%\Airports.xml"
	TYPE "Waypoints.xml">"%TARGET_DIR%\Waypoints.xml"
	ECHO vERAM - NAVDATA

:STARS_NAVDATA

SET TARGET_DIR=%IFF_PATH%\Pre-Release\ZSE Facility Files WIP\vSTARS

CD "%SOURCE_DIR%\VSTARS"
	TYPE "Airports.xml">"%TARGET_DIR%\Airports.xml"
	TYPE "Waypoints.xml">"%TARGET_DIR%\Waypoints.xml"
	ECHO vSTARS - NAVDATA

:DONE_NASR2EDIT

ECHO.
ECHO.
ECHO *** DONE ***
ECHO.
ECHO.

PAUSE

GOTO HELLO2

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:SCTEDIT_2_PRERELEASE

ECHO.
ECHO.
ECHO  *** EDIT SCT Files to ZSE Pre-Release Folder ***
ECHO.
ECHO.
ECHO -----------------------------------------------
ECHO  PRESS ANY KEY TO REPLACE THE CONTENTS OF THE
ECHO  ZSE PRE-RELEASE SECTOR FILE WITH THE CONTENTS
ECHO  OF EVERYTHING IN THE "EDIT SCT" FOLDER.
ECHO -----------------------------------------------
ECHO.
ECHO.
ECHO.
ECHO.
ECHO * * * PREREQUISITES: * * * 
ECHO.
ECHO.
ECHO   1) All files must be .txt
ECHO.
ECHO   2) All files must have at least two empty lines
ECHO      at the bottom of the contents.
ECHO.
ECHO   3) All files must be named alphanumerically to
ECHO      determine the order in which it writes to
ECHO      the SCT file.
ECHO.
ECHO.

PAUSE

SET PR_SCT_DIR=%IFF_PATH%\Pre-Release\ZSE Facility Files WIP\SECTOR FILES

SET EDIT_DIR=%IFF_PATH%\EDIT SCT


:CLEAR_PRE-RELEASE_SCT2

CD "%PR_SCT_DIR%"

break>"ZSE SECTOR.SCT2"

CLS

PING 127.0.0.1 -n 2 >nul

ECHO.
ECHO.
ECHO ----------------------------------------------
ECHO.
ECHO  EXPORTING ALL FILES TO: ZSE SECTOR.SCT2
ECHO.
ECHO  ZSE 6. Internal Facility Files
ECHO     -Pre-Release
ECHO         -ZSE Facility Files WIP
ECHO             -SECTOR FILES
ECHO.
ECHO ----------------------------------------------
ECHO.
ECHO.

ECHO --- COMPLETED: ---
ECHO.

CD "%EDIT_DIR%\01_COLORS"
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

CD "%EDIT_DIR%\02_INFO
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

CD "%EDIT_DIR%\03_VOR
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

CD "%EDIT_DIR%\04_NDB
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

CD "%EDIT_DIR%\05_AIRPORT
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

CD "%EDIT_DIR%\06_RUNWAY
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

CD "%EDIT_DIR%\07_FIXES
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

CD "%EDIT_DIR%\08_ARTCC
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

CD "%EDIT_DIR%\09_ARTCC_HIGH
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

CD "%EDIT_DIR%\10_ARTCC_LOW
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

CD "%EDIT_DIR%\11_SID
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

CD "%EDIT_DIR%\12_STAR
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

CD "%EDIT_DIR%\13_LOW_AIRWAY
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

CD "%EDIT_DIR%\14_HIGH_AIRWAY
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

CD "%EDIT_DIR%\15_GEO
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

CD "%EDIT_DIR%\16_REGIONS
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

CD "%EDIT_DIR%\17_LABELS
type "*.txt" >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZSE SECTOR.SCT2"

ECHO.
ECHO.
ECHO --------------------------------------------------------------
ECHO.
ECHO  ALL FILES COMBINED INTO THE PRE-RELEASE: ZSE SECTOR.SCT2
ECHO.
ECHO --------------------------------------------------------------
ECHO.
ECHO.

PAUSE

GOTO HELLO2

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:ALIASE2PR

CLS

ECHO.
ECHO.
ECHO  *** EDIT ALIAS Files to ZSE Pre-Release Folder ***
ECHO.
ECHO.
ECHO  Has there been a change in AIRAC CYLCE?
ECHO.
ECHO.

set AIRAC_STATUS=AIRAC_STATUS_Not_Set

SET /P USERSELECT=Type Y or N and press Enter: 
	SET USERSELECT=%USERSELECT: =%
	
	if /i %USERSELECT%==Y SET AIRAC_STATUS=CHG
	if /i %USERSELECT%==N SET AIRAC_STATUS=NO_CHG

	if /i NOT %USERSELECT%==Y if /i NOT %USERSELECT%==N (
		
		ECHO.
		ECHO.
		ECHO %USERSELECT% is not a recognized response. Try again...
		pause
		goto ALIASE2PR
	)

ECHO.
ECHO.

IF "%AIRAC_STATUS%"=="CHG" (
	
SET /P OLD_AIRAC_CYCLE=Type the OLD AIRAC CYCLE NUMBER AND PRESS ENTER: 
SET /P NEW_AIRAC_CYCLE=Type the NEW AIRAC CYCLE NUMBER AND PRESS ENTER: 
)

CLS

ECHO -----------------------------------------------
ECHO  PRESS ANY KEY TO REPLACE THE CONTENTS OF THE
ECHO  ZSE PRE-RELEASE ALIAS FILE WITH THE CONTENTS
ECHO  OF EVERYTHING IN THE "EDIT ALIAS" FOLDER.
IF "%AIRAC_STATUS%"=="CHG" (
	ECHO.
	ECHO  PRIOR TO TRANSFER, THE AIRAC CYCLES WILL
	ECHO  BE CHANGED WITHIN THE APPROPRIATE ALIAS
	ECHO  COMMANDS AUTOMATICALLY.
)
ECHO -----------------------------------------------
ECHO.
ECHO.
ECHO.
ECHO.
ECHO * * * PREREQUISITES: * * * 
ECHO.
ECHO.
ECHO   1) All files must be .txt
ECHO.
ECHO   2) All files must have at least one empty line
ECHO      at the bottom of the contents.
ECHO.
ECHO   3) All files must be named alphanumerically to
ECHO      determine the order in which it writes to
ECHO      the Alias file.
ECHO.
ECHO.

PAUSE

SET PR_ALIAS_DIR=%IFF_PATH%\Pre-Release\ZSE Facility Files WIP\ALIAS FILES

SET EDIT_DIR=%IFF_PATH%\EDIT ALIAS

CD "%EDIT_DIR%"

setlocal enabledelayedexpansion

IF "%AIRAC_STATUS%"=="CHG" (
	
	SET FILE_NAME_ENDING=_AIRPORT_SPECIFIC_ISR

	for /f "delims=" %%G in ('dir /b ^| findstr "!FILE_NAME_ENDING!"') do SET file_name=%%G

	powershell -Command "(gc !file_name!) -replace '/%OLD_AIRAC_CYCLE%/', '/%NEW_AIRAC_CYCLE%/' | Out-File -encoding ASCII !file_name!"

)
endlocal

CD "%PR_ALIAS_DIR%"

break>"ZSE ALIAS.txt"

CLS

ECHO.
ECHO.
ECHO ----------------------------------------------
ECHO.
ECHO  EXPORTING ALL FILES TO: ZSE ALIAS.txt
ECHO.
ECHO  ZSE 6. Internal Facility Files
ECHO     -Pre-Release
ECHO         -ZSE Facility Files WIP
ECHO             -ALIAS FILES
ECHO.
ECHO ----------------------------------------------
ECHO.
ECHO.

ECHO --- COMPLETED: ---
ECHO.

CD "%EDIT_DIR%"

type "*.txt">>"%PR_ALIAS_DIR%\ZSE ALIAS.txt"
echo.>>"%PR_ALIAS_DIR%\ZSE ALIAS.txt"
echo.>>"%PR_ALIAS_DIR%\ZSE ALIAS.txt"

ECHO.
ECHO.
ECHO --------------------------------------------------------------
ECHO.
ECHO  ALL FILES COMBINED INTO THE PRE-RELEASE: ZSE ALIAS.txt
ECHO.
ECHO --------------------------------------------------------------
ECHO.
ECHO.

PAUSE

GOTO HELLO2

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:AUTO_TRANSFER

ECHO.
ECHO.
ECHO  *** AUTO-TRANSFER Pre-Release Files to ZSE PUBLIC Folder ***
echo.
echo.
echo    You Are About To Move The Following Contents From The Pre-Release Folder
echo    To The Appropriate ZSE PUBLIC Folder.
echo.
echo.
echo    If You Do Not Wish To Do This, Please Close This Window Now.
echo.
echo.
echo    Select The Appropriate Contents To Move:
echo.
echo        ALL)   All Files
echo.
echo        APS)   Alias / POF / Sector Files
echo.
echo         AS)   Alias / Sector Files
echo.
echo         SE)   vSTARS / vERAM NAVDATA
echo.
echo          O)   ZSE "Other Downloads" Folder
echo          A)   Alias File(s)
echo          P)   POF Files(s)
echo          S)   Sector Files(s)
echo          T)   vATIS Files
echo.
echo.

:CHOICE_AUTO_TRANSFER

	set /p MOVE=Type Your Choice and press Enter: 
	IF /I %MOVE%==ALL GOTO OTHER
	IF /I %MOVE%==APS GOTO ALIAS
	IF /I %MOVE%==AS GOTO ALIAS
	IF /I %MOVE%==SE GOTO vSTARS_vERAM
	IF /I %MOVE%==O GOTO OTHER
	IF /I %MOVE%==A GOTO ALIAS
	IF /I %MOVE%==P GOTO POF
	IF /I %MOVE%==S GOTO SECTOR
	IF /I %MOVE%==T GOTO vATIS
	echo.
	echo.
	echo  I Cannot Do Anything With An Entry Of "%MOVE%". Try Another Option Or Seek Guidance.
	echo.
	echo.
	
	PAUSE
	CLS
	GOTO CHOICE_AUTO_TRANSFER

:OTHER

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo MOVING CONTENTS OF "OTHER DOWNLOADS" TO ZSE PUBLIC FOLDER
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

CD "%IFF_PATH%\Pre-Release\Other Downloads WIP"
copy "%IFF_PATH%\Pre-Release\Other Downloads WIP\*.*" "%DROPBOX_PATH%\ZSE PUBLIC\Other Downloads"

	IF /I %MOVE%==O GOTO DONE_AUTO_TRANSFER

:ALIAS

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo MOVING CONTENTS OF "ALIAS FILES" TO ZSE PUBLIC FOLDER
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

CD "%IFF_PATH%\Pre-Release\ZSE Facility Files WIP\ALIAS FILES"
copy "%IFF_PATH%\Pre-Release\ZSE Facility Files WIP\ALIAS FILES\*.*" "%DROPBOX_PATH%\ZSE PUBLIC\ZSE Facility Files (Live Update)\ALIAS FILES"

	IF /I %MOVE%==A GOTO DONE_AUTO_TRANSFER
	IF /I %MOVE%==AS GOTO SECTOR

:vSTARS_vERAM

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo MOVING CONTENTS OF "ALIAS FILES" TO ZSE PUBLIC FOLDER
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

CD "%IFF_PATH%\Pre-Release\ZSE Facility Files WIP\vSTARS"
copy "%IFF_PATH%\Pre-Release\ZSE Facility Files WIP\vSTARS\*.*" "%DROPBOX_PATH%\ZSE PUBLIC\ZSE Facility Files (Live Update)\vSTARS"

CD "%IFF_PATH%\Pre-Release\ZSE Facility Files WIP\vERAM"
copy "%IFF_PATH%\Pre-Release\ZSE Facility Files WIP\vERAM\*.*" "%DROPBOX_PATH%\ZSE PUBLIC\ZSE Facility Files (Live Update)\vERAM"

	IF /I %MOVE%==SE GOTO DONE_AUTO_TRANSFER

:POF

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo MOVING CONTENTS OF "POF FILE" TO ZSE PUBLIC FOLDER
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

CD "%IFF_PATH%\Pre-Release\ZSE Facility Files WIP\POF FILE"
copy "%IFF_PATH%\Pre-Release\ZSE Facility Files WIP\POF FILE\*.*" "%DROPBOX_PATH%\ZSE PUBLIC\ZSE Facility Files (Live Update)\POF FILE"

	IF /I %MOVE%==P GOTO DONE_AUTO_TRANSFER

:SECTOR

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo MOVING CONTENTS OF "SECTOR FILES" TO ZSE PUBLIC FOLDER
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

CD "%IFF_PATH%\Pre-Release\ZSE Facility Files WIP\SECTOR FILES"
copy "%IFF_PATH%\Pre-Release\ZSE Facility Files WIP\SECTOR FILES\*.*" "%DROPBOX_PATH%\ZSE PUBLIC\ZSE Facility Files (Live Update)\SECTOR FILES"

	IF /I %MOVE%==S GOTO DONE_AUTO_TRANSFER
	IF /I %MOVE%==APS GOTO DONE_AUTO_TRANSFER
	IF /I %MOVE%==AS GOTO DONE_AUTO_TRANSFER

:vATIS

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo MOVING CONTENTS OF "ZSE vATIS" TO ZSE PUBLIC FOLDER
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

CD "%IFF_PATH%\Pre-Release\ZSE vATIS WIP"
copy "%IFF_PATH%\Pre-Release\ZSE vATIS WIP\*.*" "%DROPBOX_PATH%\ZSE PUBLIC\ZSE vATIS"
copy "%IFF_PATH%\Pre-Release\ZSE vATIS WIP\v4\*.*" "%DROPBOX_PATH%\ZSE PUBLIC\ZSE vATIS\v4"

:DONE_AUTO_TRANSFER

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo ALL FILES MOVED AND ARE NOW PUBLISHED TO THE LIVE UPDATE SYSTEM
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

PAUSE

GOTO HELLO2
