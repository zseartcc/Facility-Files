@ECHO OFF

TITLE CONTROL WORKSTATION SETUP

:version_chk

SET USER_VER=1.5.7

:HELLO

SET userselected=userselected_NotSet

CLS

echo.
echo.
echo -----------------------------------------------------------------------------
echo.
echo      You Are About To Initialize Your ZSE VATSIM Control Workstation.
echo.
echo.
echo         If You Did Not Mean To Do This, Simply Close This Window.
echo.
echo.
echo     For issues running this file or if you want more information about
echo       what it does (is it safe?) before running it, type HELP below.
echo.
echo -----------------------------------------------------------------------------
echo.
echo.

@REM IF THE USER TYPES NOTHING AT ALL, IT WILL CONTINUE ON THROUGH THE BATCH PROCESS.
@REM IF THE USER TYPES HELP, IT WILL SKIP DOWN TO THE :HELP FUNCTION.

	set /p userselected=Just Press Enter to Continue or Type HELP, Then Press Enter: 
		IF /I %userselected%==HELP GOTO HELP
		IF /I "%userselected%"=="userselected_NotSet" GOTO SET_VAR

:SET_VAR

CLS

SET DISCORD_DD_SEARCH=Discord Not Found In Default Directory
SET DISCORD_DIR=Discord Directory Not Set

SET AFV_DD_SEARCH=AFV Not Found In Default Directory
SET AFV_DIR=AFV Directory Not Set

SET VATIS_DD_SEARCH=vATIS Not Found In Default Directory
SET VATIS_DIR=vATIS Directory Not Set

SET VRC_DD_SEARCH=VRC Not Found In Default Directory
SET VRC_DIR=VRC Directory Not Set

SET VSTARS_DD_SEARCH=vSTARS Not Found In Default Directory
SET VSTARS_DIR=vSTARS Directory Not Set

SET VERAM_DD_SEARCH=vERAM Not Found In Default Directory
SET VERAM_DIR=vERAM Directory Not Set

SET ES_DD_SEARCH=EuroScope Not Found In Default Directory
SET ES_DIR=EuroScope Directory Not Set

SET RadarClient=none

:SEARCH_DEFAULT_DIR
@REM CONDUCTS A SEARCH FOR EACH PROGRAM IN ITS DEFAULT DIRECTORY.
@REM IF FOUND, IT WILL SET THE PROGRAM DIRECTORY VARIABLE AS SUCH.

CD /D "%userprofile%\AppData\Local\Discord"
	IF EXIST Update.exe set DISCORD_DD_SEARCH=Discord Found In Default Directory
	
		IF "%DISCORD_DD_SEARCH%"=="Discord Found In Default Directory" SET DISCORD_DIR=%userprofile%\AppData\Local\Discord

CD /D "C:\AudioForVATSIM"
	IF EXIST AudioForVATSIM.exe set AFV_DD_SEARCH=AFV Found In Default Directory
	
		IF "%AFV_DD_SEARCH%"=="AFV Found In Default Directory" SET AFV_DIR=C:\AudioForVATSIM

CD /D "%userprofile%\AppData\Local\vATIS"
	IF EXIST vATIS.exe set VATIS_DD_SEARCH=vATIS Found In Default Directory
	
		IF "%VATIS_DD_SEARCH%"=="vATIS Found In Default Directory" SET VATIS_DIR=%userprofile%\AppData\Local\vATIS

CD /D "C:\Program Files (x86)\VRC"
	IF EXIST VRC.exe set VRC_DD_SEARCH=VRC Found In Default Directory
	
		IF "%VRC_DD_SEARCH%"=="VRC Found In Default Directory" SET VRC_DIR=C:\Program Files (x86)\VRC

CD /D "C:\Program Files (x86)\vSTARS"
	IF EXIST vSTARS.exe set VSTARS_DD_SEARCH=vSTARS Found In Default Directory
	
		IF "%VSTARS_DD_SEARCH%"=="vSTARS Found In Default Directory" SET VSTARS_DIR=C:\Program Files (x86)\vSTARS

CD /D "%userprofile%\AppData\Local\vERAM"
	IF EXIST vERAM.exe set VERAM_DD_SEARCH=vERAM Found In Default Directory
	
		IF "%VERAM_DD_SEARCH%"=="vERAM Found In Default Directory" SET VERAM_DIR=%userprofile%\AppData\Local\vERAM

CD /D "C:\Program Files (x86)\EuroScope"
	IF EXIST EuroScope.exe set ES_DD_SEARCH=EuroScope Found In Default Directory
	
		IF "%ES_DD_SEARCH%"=="EuroScope Found In Default Directory" SET ES_DIR=C:\Program Files (x86)\EuroScope

CD /D "C:\Program Files (x86)\VATSpy"
	IF EXIST VATSpy.exe set VS_DD_SEARCH=VATSpy Found In Default Directory
	
		IF "%VS_DD_SEARCH%"=="VATSpy Found In Default Directory" SET VS_DIR=C:\Program Files (x86)\VATSpy

CLS

@REM For Troubleshooting, change the following GOTO command below to: @REM GOTO MAKE_CFG
GOTO MAKE_CFG

ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
echo RESULTS FROM A SEARCH FOR EACH PROGRAM IN THEIR DEFAULT DIRECTORIES:
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO      DISCORD:     %DISCORD_DD_SEARCH%
ECHO.
ECHO.
ECHO          AFV:     %AFV_DD_SEARCH%
ECHO.
ECHO.
ECHO        vATIS:     %VATIS_DD_SEARCH%
ECHO.
ECHO.
ECHO          VRC:     %VRC_DD_SEARCH%
ECHO.
ECHO.
ECHO       vSTARS:     %VSTARS_DD_SEARCH%
ECHO.
ECHO.
ECHO        vERAM:     %VERAM_DD_SEARCH%
ECHO.
ECHO.
ECHO    EuroScope:     %ES_DD_SEARCH%
ECHO.
ECHO.
ECHO       VATSpy:     %VS_DD_SEARCH%
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.

PAUSE

CLS

:MAKE_CFG
@REM SEARCHES FOR THE ATC WORKSATION SETUP CONFIGURATION FOLDER IN THE USERS DOCUMENTS FOLDER.
@REM IF NOT FOUND, IT WILL CREATE ONE AND CREATE A README FILE.

IF EXIST "%userprofile%\Documents\ATC Workstation Setup CFG" GOTO CFG_FOLDER_FOUND

	mkdir "%userprofile%\Documents\ATC Workstation Setup CFG"
	echo.
	echo.
	echo ------------------------------------------------------------------
	echo.
	echo   A Configuration Folder For This Batch File has Been Made Here:
	echo.
	echo               Documents\ATC Workstation Setup CFG
	echo.
	echo ------------------------------------------------------------------
	echo.
	echo.
	
	PING 127.0.0.1 -n 4 >nul

CLS

:CFG_FOLDER_FOUND

@REM ONCE THE CFG FOLDER HAS BEEN FOUND OR ONE HAS BEEN MADE, THE BATCH FILE SKIPS TO HERE.
@REM THESE REMARKS IN THE DISCORD SECTION SERVES AS THE EXPLANATION FOR THE REST OF THE "COMPARE" FUNCTIONS FOR OTHER PROGRAMS.

:DISCORD_COMPARE

@REM IF THE PROGRAM WAS FOUND EARLIER IN IT'S DEFAULT DIRECTORY, THIS PART IS SKIPPED AND MOVES TO THE NEXT PROGRAM.

IF "%DISCORD_DD_SEARCH%"=="Discord Found In Default Directory" GOTO AFV_COMPARE

@REM IF THE PROGRAM WAS NOT FOUND IN IT'S DEFAULT DIRECTORY, IT SEARCHES FOR A CONFIGURATION FILE FOR THIS PROGRAM.

CD /D "%userprofile%\Documents\ATC Workstation Setup CFG"
	IF EXIST "DISCORD_CUSTOM_DIRECTORY.txt" GOTO DISCORD_COMPARE1
	GOTO DISCORD_COMPARE2

:DISCORD_COMPARE1

@REM IF THE PROGRAM CONFIGURATION FILE WAS FOUND, IT WILL NOW SET THE PROGRAM DIRECTORY TO WHAT IS IN THE CONFIGURATION FILE.
@REM IT WILL THEN SKIP TO THE NEXT PROGRAM.
@REM IF A CONFIGURATION FILE WAS NOT FOUND IT SKIPS THIS PART AND GOES TO THE "COMPARE 2" SECTION.

	for /f "delims=" %%x in (DISCORD_CUSTOM_DIRECTORY.txt) do set DISCORD_DIR=%%x
	GOTO AFV_COMPARE

:DISCORD_COMPARE2

@REM IF THE CONFIGURATION FILE WAS NOT FOUND, IT SKIPS TO HERE TO MAKE ONE FOR FUTURE REFERENCE.

echo.
echo.
echo ---------------------------------------------------------
echo.
echo  Do You Use Discord During Any Of Your Control Sessions?
echo.
echo ---------------------------------------------------------
echo.
echo.

@REM IF THE USER SAYS THEY NEVER USE THIS PROGRAM, IT IS INDICATED AS SUCH IN THE PROGRAM CONFIGURATION FILE SO THAT IT IS SKIPPED IN FUTURE RUNS OF THIS BATCH FILE.

	set /p userselected=Type Y or N and Press Enter: 
		IF /I %userselected%==N ECHO DISCORD_NEVER_USE>"%userprofile%\Documents\ATC Workstation Setup CFG\DISCORD_CUSTOM_DIRECTORY.txt"
		IF /I %userselected%==N GOTO AFV_COMPARE

		CLS

echo.
echo.
echo --------------------------------------------------------------------
echo.
echo  Select ONLY the directory up to and including
echo  the Folder where the (Discord) Update.exe file is.
echo.
echo  Do NOT select the Update.exe file.
echo.
echo     EXAMPLE:
echo.
echo         YES = C:\Users\JSMITH\AppData\Local\Discord
echo.
echo          NO = C:\Users\JSMITH\AppData\Local\Discord\Update.exe
echo.
echo --------------------------------------------------------------------
echo.
echo.

@REM IF THE USER SAYS THEY DO USE THIS PROGRAM, IT WILL PROMPT THE USER TO SELECT THE DIRECTORY WHERE THEIR PROGRAMS .EXE FILE IS LOCATED.
@REM IT WILL THEN WRITE THAT DIRECTORY TO THE PROGRAMS CONFIGURATION FILE FOR FUTURE REFERENCE.
@REM THE BATCH FILE THEN MOVES ON TO THE NEXT PROGRAM AND REPEATS THE SAME STEPS FOR THE "COMPARE" SECTIONS.

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select The Folder That Houses The Discord Update.exe',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "DISCORD_DIR=%%I"

			echo %DISCORD_DIR%>"%userprofile%\Documents\ATC Workstation Setup CFG\DISCORD_CUSTOM_DIRECTORY.txt"

		CLS

:AFV_COMPARE

IF "%AFV_DD_SEARCH%"=="AFV Found In Default Directory" GOTO VATIS_COMPARE

CD /D "%userprofile%\Documents\ATC Workstation Setup CFG"
IF EXIST "AFV_CUSTOM_DIRECTORY.txt" GOTO AFV_COMPARE1
GOTO AFV_COMPARE2

:AFV_COMPARE1

	for /f "delims=" %%x in (AFV_CUSTOM_DIRECTORY.txt) do set AFV_DIR=%%x
	GOTO VATIS_COMPARE

:AFV_COMPARE2

CLS

echo.
echo.
echo -----------------------------------------------------
echo.
echo  Do You Use AFV During Any Of Your Control Sessions?
echo.
echo -----------------------------------------------------
echo.
echo.

	set /p userselected=Type Y or N and Press Enter: 
		IF /I %userselected%==N ECHO AFV_NEVER_USE>"%userprofile%\Documents\ATC Workstation Setup CFG\AFV_CUSTOM_DIRECTORY.txt"
		IF /I %userselected%==N GOTO VATIS_COMPARE

		CLS

echo.
echo.
echo --------------------------------------------------------------------
echo.
echo  Select ONLY the directory up to and including
echo  the Folder where the AudioForVATSIM.exe file is.
echo.
echo  Do NOT select the AudioForVATSIM.exe file.
echo.
echo     EXAMPLE:
echo.
echo         YES = C:\AudioForVATSIM
echo.
echo          NO = C:\AudioForVATSIM\AudioForVATSIM.exe
echo.
echo --------------------------------------------------------------------
echo.
echo.

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select The Folder That Houses The AudioForVATSIM.exe',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "AFV_DIR=%%I"

			echo %AFV_DIR%>"%userprofile%\Documents\ATC Workstation Setup CFG\AFV_CUSTOM_DIRECTORY.txt"

		CLS

:VATIS_COMPARE

IF "%VATIS_DD_SEARCH%"=="vATIS Found In Default Directory" GOTO VRC_COMPARE

CD /D "%userprofile%\Documents\ATC Workstation Setup CFG"
IF EXIST "VATIS_CUSTOM_DIRECTORY.txt" GOTO VATIS_COMPARE1
GOTO VATIS_COMPARE2

:VATIS_COMPARE1

	for /f "delims=" %%x in (VATIS_CUSTOM_DIRECTORY.txt) do set VATIS_DIR=%%x
	GOTO VRC_COMPARE

:VATIS_COMPARE2

CLS

echo.
echo.
echo -------------------------------------------------------
echo.
echo  Do You Use vATIS During Any Of Your Control Sessions?
echo.
echo -------------------------------------------------------
echo.
echo.

	set /p userselected=Type Y or N and Press Enter: 
		IF /I %userselected%==N ECHO VATIS_NEVER_USE>"%userprofile%\Documents\ATC Workstation Setup CFG\VATIS_CUSTOM_DIRECTORY.txt"
		IF /I %userselected%==N GOTO VRC_COMPARE

		CLS

echo.
echo.
echo --------------------------------------------------------------------
echo.
echo  Select ONLY the directory up to and including
echo  the Folder where the vATIS.exe file is.
echo.
echo  Do NOT select the vATIS.exe file.
echo.
echo     EXAMPLE:
echo.
echo         YES = C:\Users\JSMITH\AppData\Local\vATIS
echo.
echo          NO = C:\Users\JSMITH\AppData\Local\vATIS\vATIS.exe
echo.
echo --------------------------------------------------------------------
echo.
echo.

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select The Folder That Houses The vATIS.exe',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "VATIS_DIR=%%I" 

			echo %VATIS_DIR%>"%userprofile%\Documents\ATC Workstation Setup CFG\VATIS_CUSTOM_DIRECTORY.txt"

		

:VRC_COMPARE

IF "%VRC_DD_SEARCH%"=="VRC Found In Default Directory" GOTO VSTARS_COMPARE

CD /D "%userprofile%\Documents\ATC Workstation Setup CFG"
IF EXIST "VRC_CUSTOM_DIRECTORY.txt" GOTO VRC_COMPARE1
GOTO VRC_COMPARE2

:VRC_COMPARE1

	for /f "delims=" %%x in (VRC_CUSTOM_DIRECTORY.txt) do set VRC_DIR=%%x
	GOTO VSTARS_COMPARE

:VRC_COMPARE2

CLS

echo.
echo.
echo -----------------------------------------------------
echo.
echo  Do You Use VRC During Any Of Your Control Sessions?
echo.
echo -----------------------------------------------------
echo.
echo.

	set /p userselected=Type Y or N and Press Enter: 
		IF /I %userselected%==N ECHO VRC_NEVER_USE>"%userprofile%\Documents\ATC Workstation Setup CFG\VRC_CUSTOM_DIRECTORY.txt"
		IF /I %userselected%==N GOTO VSTARS_COMPARE

		CLS

echo.
echo.
echo --------------------------------------------------------------------
echo.
echo  Select ONLY the directory up to and including
echo  the Folder where the VRC.exe file is.
echo.
echo  Do NOT select the VRC.exe file.
echo.
echo     EXAMPLE:
echo.
echo         YES = C:\Program Files (x86)\VRC
echo.
echo          NO = C:\Program Files (x86)\VRC\VRC.exe
echo.
echo --------------------------------------------------------------------
echo.
echo.

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select The Folder That Houses The VRC.exe',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "VRC_DIR=%%I"

			echo %VRC_DIR%>"%userprofile%\Documents\ATC Workstation Setup CFG\VRC_CUSTOM_DIRECTORY.txt"

		CLS

:VSTARS_COMPARE

IF "%VSTARS_DD_SEARCH%"=="vSTARS Found In Default Directory" GOTO VERAM_COMPARE

CD /D "%userprofile%\Documents\ATC Workstation Setup CFG"
IF EXIST "VSTARS_CUSTOM_DIRECTORY.txt" GOTO VSTARS_COMPARE1
GOTO VSTARS_COMPARE2

:VSTARS_COMPARE1

	for /f "delims=" %%x in (VSTARS_CUSTOM_DIRECTORY.txt) do set VSTARS_DIR=%%x
	GOTO VERAM_COMPARE

:VSTARS_COMPARE2

CLS

echo.
echo.
echo --------------------------------------------------------
echo.
echo  Do You Use vSTARS During Any Of Your Control Sessions?
echo.
echo --------------------------------------------------------
echo.
echo.

	set /p userselected=Type Y or N and Press Enter: 
		IF /I %userselected%==N ECHO VSTARS_NEVER_USE>"%userprofile%\Documents\ATC Workstation Setup CFG\VSTARS_CUSTOM_DIRECTORY.txt"
		IF /I %userselected%==N GOTO VERAM_COMPARE

		CLS

echo.
echo.
echo --------------------------------------------------------------------
echo.
echo  Select ONLY the directory up to and including
echo  the Folder where the vSTARS.exe file is.
echo.
echo  Do NOT select the vSTARS.exe file.
echo.
echo     EXAMPLE:
echo.
echo         YES = C:\Program Files (x86)\vSTARS
echo.
echo          NO = C:\Program Files (x86)\vSTARS\vSTARS.exe
echo.
echo --------------------------------------------------------------------
echo.
echo.

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select The Folder That Houses The vSTARS.exe',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "VSTARS=%%I"

			echo %VSTARS%>"%userprofile%\Documents\ATC Workstation Setup CFG\VSTARS_CUSTOM_DIRECTORY.txt"

		CLS

:VERAM_COMPARE

IF "%VERAM_DD_SEARCH%"=="vERAM Found In Default Directory" GOTO ES_COMPARE

CD /D "%userprofile%\Documents\ATC Workstation Setup CFG"
IF EXIST "VERAM_CUSTOM_DIRECTORY.txt" GOTO VERAM_COMPARE1
GOTO VERAM_COMPARE2

:VERAM_COMPARE1

	for /f "delims=" %%x in (VERAM_CUSTOM_DIRECTORY.txt) do set VERAM_DIR=%%x
	GOTO ES_COMPARE

:VERAM_COMPARE2

CLS

echo.
echo.
echo -------------------------------------------------------
echo.
echo  Do You Use vERAM During Any Of Your Control Sessions?
echo.
echo -------------------------------------------------------
echo.
echo.

	set /p userselected=Type Y or N and Press Enter: 
		IF /I %userselected%==N ECHO VERAM_NEVER_USE>"%userprofile%\Documents\ATC Workstation Setup CFG\VERAM_CUSTOM_DIRECTORY.txt"
		IF /I %userselected%==N GOTO ES_COMPARE

		CLS

echo.
echo.
echo --------------------------------------------------------------------
echo.
echo  Select ONLY the directory up to and including
echo  the Folder where the vERAM.exe file is.
echo.
echo  Do NOT select the vERAM.exe file.
echo.
echo     EXAMPLE:
echo.
echo         YES = C:\Users\JSMITH\AppData\Local\vERAM
echo.
echo          NO = C:\Users\JSMITH\AppData\Local\vERAM\vERAM.exe
echo.
echo --------------------------------------------------------------------
echo.
echo.

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select The Folder That Houses The vERAM.exe',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "VERAM_DIR=%%I"

			echo %VERAM_DIR%>"%userprofile%\Documents\ATC Workstation Setup CFG\VERAM_CUSTOM_DIRECTORY.txt"

		CLS

:ES_COMPARE

IF "%ES_DD_SEARCH%"=="EuroScope Found In Default Directory" GOTO VS_COMPARE

CD /D "%userprofile%\Documents\ATC Workstation Setup CFG"
	IF EXIST "ES_CUSTOM_DIRECTORY.txt" GOTO ES_COMPARE1
	GOTO ES_COMPARE2

:ES_COMPARE1

	for /f "delims=" %%x in (ES_CUSTOM_DIRECTORY.txt) do set ES_DIR=%%x
	GOTO VS_COMPARE

:ES_COMPARE2

CLS

echo.
echo.
echo -----------------------------------------------------------
echo.
echo  Do You Use EuroScope During Any Of Your Control Sessions?
echo.
echo -----------------------------------------------------------
echo.
echo.

	set /p userselected=Type Y or N and Press Enter: 
		IF /I %userselected%==N ECHO ES_NEVER_USE>"%userprofile%\Documents\ATC Workstation Setup CFG\ES_CUSTOM_DIRECTORY.txt"
		IF /I %userselected%==N GOTO VS_COMPARE

		CLS

echo.
echo.
echo --------------------------------------------------------------------
echo.
echo  Select ONLY the directory up to and including
echo  the Folder where the EuroScope.exe file is.
echo.
echo  Do NOT select the EuroScope.exe file.
echo.
echo     EXAMPLE:
echo.
echo         YES = C:\Program Files (x86)\EuroScope
echo.
echo          NO = C:\Program Files (x86)\EuroScope\EuroScope.exe
echo.
echo --------------------------------------------------------------------
echo.
echo.

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select The Folder That Houses The EuroScope.exe',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "ES_DIR=%%I" 

			echo %ES_DIR%>"%userprofile%\Documents\ATC Workstation Setup CFG\ES_CUSTOM_DIRECTORY.txt"

:VS_COMPARE

IF "%VS_DD_SEARCH%"=="VATSpy Found In Default Directory" GOTO NAVDATA_CHOICE

CD /D "%userprofile%\Documents\ATC Workstation Setup CFG"
	IF EXIST "VS_CUSTOM_DIRECTORY.txt" GOTO VS_COMPARE1
	GOTO VS_COMPARE2

:VS_COMPARE1

	for /f "delims=" %%x in (VS_CUSTOM_DIRECTORY.txt) do set VS_DIR=%%x
	GOTO NAVDATA_CHOICE

:VS_COMPARE2

CLS

echo.
echo.
echo --------------------------------------------------------
echo.
echo  Do You Use VATSpy During Any Of Your Control Sessions?
echo.
echo --------------------------------------------------------
echo.
echo.

	set /p userselected=Type Y or N and Press Enter: 
		IF /I %userselected%==N ECHO VS_NEVER_USE>"%userprofile%\Documents\ATC Workstation Setup CFG\VS_CUSTOM_DIRECTORY.txt"
		IF /I %userselected%==N GOTO NAVDATA_CHOICE

		CLS

echo.
echo.
echo --------------------------------------------------------------------
echo.
echo  Select ONLY the directory up to and including
echo  the Folder where the VATSpy.exe file is.
echo.
echo  Do NOT select the VATSpy.exe file.
echo.
echo     EXAMPLE:
echo.
echo         YES = C:\Program Files (x86)\VATSpy
echo.
echo          NO = C:\Program Files (x86)\VATSpy\VATSpy.exe
echo.
echo --------------------------------------------------------------------
echo.
echo.

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select The Folder That Houses The VATSpy.exe',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "VS_DIR=%%I" 

			echo %VS_DIR%>"%userprofile%\Documents\ATC Workstation Setup CFG\VS_CUSTOM_DIRECTORY.txt"

:NAVDATA_CHOICE

CD /D "%userprofile%\Documents\ATC Workstation Setup CFG"
	IF EXIST "NAVDATA_UPDATE_PREF.txt" GOTO NAVDATA_CHOICE1
	GOTO NAVDATA_CHOICE2

:NAVDATA_CHOICE1

	for /f "delims=" %%x in (DB_CUSTOM_DIRECTORY.txt) do set NAV_UPDATE_PREF=%%x
	GOTO ZSE_DB_COMPARE

:NAVDATA_CHOICE2

CLS

echo.
echo.
echo ---------------------------------------------------------------------------------
echo.
echo                          *** AUTO UPDATE NAVDATA ***
echo.
echo  This Batch File has the ability to overwrite your vSTARS/vERAM NAVDATA files
echo  with the most up to date data from the FAA prior to launching the client.
echo.
echo.
echo    NOTE- You "MUST" have DROPBOX and the "ZSE PUBLIC" Dropbox folder installed
echo          on your computer. If you do not yet have these, please type N for this
echo          choice.
echo.
echo          When you do get access, access the HELP menu at the begining and then
echo          select to reset the vERAM/vSTARS Auto-Update preferences.
echo.
echo.
echo.
echo  Do you have access to the ZSE Public folder and will you allow this Workstation
echo  Setup BATCH File to ensure you have the most up to date FAA NAVDATA for
echo  vSTARS/vERAM prior to launching the client?
echo.
echo ---------------------------------------------------------------------------------
echo.
echo.

:NAVDATA_CHOICE2_1

	set /p userselected=Type Y or N and Press Enter: 
		IF /I %userselected%==N ECHO DO_NOT_UPDATE_NAVDATA>"%userprofile%\Documents\ATC Workstation Setup CFG\NAVDATA_UPDATE_PREF.txt"
		IF /I %userselected%==N set NAV_UPDATE_PREF=DO_NOT_UPDATE_NAVDATA
		IF /I %userselected%==N GOTO SITES_PREF
		IF /I %userselected%==Y ECHO UPDATE_NAVDATA>"%userprofile%\Documents\ATC Workstation Setup CFG\NAVDATA_UPDATE_PREF.txt"
		IF /I %userselected%==Y set NAV_UPDATE_PREF=UPDATE_NAVDATA
		IF /I %userselected%==Y GOTO ZSE_DB_COMPARE
		echo.
		echo.
		echo.
		echo.
		echo  %userselected% IS NOT A RECOGNIZED RESPONSE. Try again.
		echo.
		GOTO NAVDATA_CHOICE2_1

:ZSE_DB_COMPARE

CD /D "%userprofile%\Documents\ATC Workstation Setup CFG"
	IF EXIST "DB_CUSTOM_DIRECTORY.txt" GOTO ZSE_DB_COMPARE1
	GOTO ZSE_DB_COMPARE2

:ZSE_DB_COMPARE1

if exist "%userprofile%\Dropbox\ZSE PUBLIC" SET "DB_DIR=%userprofile%\Dropbox\ZSE public"
if exist "%userprofile%\Dropbox\ZSE PUBLIC" echo %DB_DIR%>"%userprofile%\Documents\ATC Workstation Setup CFG\DB_CUSTOM_DIRECTORY.txt"
if exist "%userprofile%\Dropbox\ZSE PUBLIC" GOTO SITES_PREF

	for /f "delims=" %%x in (DB_CUSTOM_DIRECTORY.txt) do set DB_DIR=%%x
	
	SET DB_DIR_CHK=%DB_DIR:~-10%

	IF NOT "%DB_DIR_CHK%"=="ZSE public" goto ZSE_DB_COMPARE2
			
	GOTO SITES_PREF

:ZSE_DB_COMPARE2

CLS

IF NOT "%DB_DIR_CHK%"=="ZSE public" ECHO *** ERROR *** THERE WAS A PROBLEM WITH YOUR SAVED "ZSE PUBLIC" DIRECTORY. Please Select it again.
echo.
echo.
echo --------------------------------------------------------------------
echo.
echo  Find and Select the "ZSE PUBLIC" Dropbox Folder
echo.
echo     EXAMPLE:
echo.
echo               %userprofile%\Dropbox\ZSE public
echo.
echo --------------------------------------------------------------------
echo.
echo.

:DB_DIR_SELECT

SET DB_DIR=DB_DIR_Not_Set

if exist "%userprofile%\Dropbox\ZSE PUBLIC" SET "DB_DIR=%userprofile%\Dropbox\ZSE public"
if exist "%userprofile%\Dropbox\ZSE PUBLIC" echo %DB_DIR%>"%userprofile%\Documents\ATC Workstation Setup CFG\DB_CUSTOM_DIRECTORY.txt"
if exist "%userprofile%\Dropbox\ZSE PUBLIC" GOTO SITES_PREF

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select the ZSE PUBLIC Dropbox Folder',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "DB_DIR=%%I"

	if "%DB_DIR%"=="DB_DIR_Not_Set" (
	ECHO.
	ECHO.
	ECHO   *** YOU DID NOT SELECT A DIRECTORY ***
	ECHO.
	ECHO   Press any key to try again or close this window.
	ECHO.
	ECHO.
	PAUSE>NUL
	GOTO ZSE_DB_COMPARE2
	)
	
	SET DB_DIR_CHK=%DB_DIR:~-10%

	IF NOT "%DB_DIR_CHK%"=="ZSE public" (
			ECHO.
			ECHO.
			ECHO   *** WARNING ***
			ECHO.
			ECHO.
			ECHO    YOU SELECTED --- %DB_DIR% ---
			ECHO.
			ECHO    Locate your "DROPBOX" folder.
			ECHO    In there should be a "ZSE PUBLIC" folder.
			ECHO.
			ECHO    The "ZSE PUBLIC" folder is what you are required to select.
			ECHO.
			ECHO Press any key to try again...
			ECHO.
			ECHO.
			pause>nul
			goto ZSE_DB_COMPARE2
			)

	echo %DB_DIR%>"%userprofile%\Documents\ATC Workstation Setup CFG\DB_CUSTOM_DIRECTORY.txt"

:SITES_PREF

CD /d "%userprofile%\Documents\ATC Workstation Setup CFG"

(
ECHO https://docs.google.com/document/d/19gwgsfu63_h7yDh98o9fZ-LsaSnijRXGbTWhqg0R56s/edit?usp=sharing
ECHO https://www.vatusa.net/tmu/notices
ECHO https://www.faa.gov/documentLibrary/media/Order/2019-10-10_Order_JO_7360.1E_Aircraft_Type_Designators_FINAL.pdf
ECHO https://www.aviationweather.gov/taf/data?ids=KSEA+KPDX+KGEG+KBLI+KEUG+KHIO+KLMT+KMFR+KMSO+KMWH+KOLM+KOTH+KPDT+KPSC+KRDM+KSFF+KSLE+KUAO+KYKM+CYVR
ECHO https://www.weather.gov/ZSE/predutyweatherbriefing
ECHO https://zseartcc.org/info/prefroutes
)>ZSE_DEFAULT_SITES.txt

IF EXIST USER_SITES_PREF.txt GOTO CHOICE

CLS

echo.
echo.
echo --------------------------------------------------------------------
echo.
echo  The following sites open by default for vZSE ARTCC.
echo.
echo  Do you wish to use this as the sites to be opened every time you
echo  start your workstation or do you wish to use custom sites?
echo.

setlocal EnableDelayedExpansion

for /f "delims=" %%a in (ZSE_DEFAULT_SITES.txt) do (

	SET LINE=%%a
	
	ECHO !LINE!
)

endlocal

echo.
echo.
echo.
echo --------------------------------------------------------------------
echo.
echo.

set /p USE_ZSE_SITES=Type CUSTOM or ZSE and press Enter: 

	IF /I "%USE_ZSE_SITES%"=="CUSTOM" GOTO CUSTOM_SITE_SETUP
	IF /I "%USE_ZSE_SITES%"=="ZSE" GOTO ZSE_SITE_PREF
		ECHO.
		ECHO.
		ECHO.
		ECHO "%USE_ZSE_SITES%" IS NOT A RECOGNIZED RESPONSE. TRY AGAIN.
		PAUSE
		CLS
		GOTO SITES_PREF

:CUSTOM_SITE_SETUP

CLS

echo.
echo.
echo --------------------------------------------------------------------
echo.
echo   PASTE THE FIRST LINK YOU WISH TO OPEN AND PRESS ENTER.
echo.
echo --------------------------------------------------------------------
echo.
echo.

setlocal EnableDelayedExpansion

SET /P "USER_URL=LINK: "
	ECHO !USER_URL!>CUSTOM_SITES.txt
	ECHO USE_CUSTOM_SITES>USER_SITES_PREF.txt
endlocal

:MORE_SITES

SET /P MORE_SITES=Are there more sites you wish to open? Type Y or N and press Enter: 
	if /i "%MORE_SITES%"=="Y" GOTO ADD_SITE
	if /i "%MORE_SITES%"=="N" GOTO CHOICE
		ECHO.
		ECHO.
		ECHO.
		ECHO "%MORE_SITES%" IS NOT A RECOGNIZED RESPONSE. TRY AGAIN.
		PAUSE
		CLS
		GOTO MORE_SITES

:ADD_SITE

setlocal EnableDelayedExpansion

SET /P "USER_URL=Paste the link to the next site and press Enter: "
	ECHO !USER_URL!>>CUSTOM_SITES.txt
endlocal
	goto MORE_SITES

:ZSE_SITE_PREF

ECHO USE_ZSE_SITES>USER_SITES_PREF.txt

:CHOICE

CD /D "%userprofile%\Documents\ATC Workstation Setup CFG"
	ECHO LAST VERSION RAN: %USER_VER% @ %date% %time%>LAST_VER_RAN.txt

@REM HERE THE USER SELECTS WHICH RADAR CLIENT THEY WISH TO USE FOR THIS SESSION.
@REM IF THE USER SELECTS AN INVALID RESPONSE, IT PROMPTS THEM TO CHOOSE AGAIN.

CLS

echo.
echo.
echo ---------------------------------------------------
echo.
echo   Select The Radar Client You Will Be Using:
echo.
echo                  A)  VRC
echo                  B)  vSTARS
echo                  C)  vERAM
echo                  D)  EUROSCOPE
echo.
echo ---------------------------------------------------
echo.
echo.

	set /p RadarClient=Type Your Choice (A, B, C, or D) and press Enter: 

	IF /I %RadarClient%==A GOTO STDSTUP
	IF /I %RadarClient%==B GOTO STDSTUP
	IF /I %RadarClient%==C GOTO STDSTUP
	IF /I %RadarClient%==D GOTO STDSTUP
	echo.
	echo.
	echo.
	echo.
	echo  %RadarClient% IS NOT A RECOGNIZED RESPONSE. Try again.
	echo.
	GOTO Choice

:STDSTUP

@REM AFTER THE USER SELECTS THEIR DESIRED RADAR CLIENT, THE STARTUP (STDSTUP) PROCESS STARTS HERE.

IF EXIST "%userprofile%\Dropbox\ZSE public\Other Downloads\ZSE_LUFL.bat" GOTO LUFL_START
	GOTO VATSPY_STRT

:LUFL_START

CD /d "%userprofile%\Dropbox\ZSE public\Other Downloads"
	START /MAX ZSE_LUFL.bat

:VATSPY_STRT

if "%VS_DIR%"=="VS_NEVER_USE" GOTO SITES

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
echo     LAUNCHING VATSPY
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

PING 127.0.0.1 -n 2 >nul
CD /D %VS_DIR%
START "" "VATSpy.exe"
PING 127.0.0.1 -n 2 >nul

CLS

:SITES

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
echo     OPENING WEBSITES
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

@REM THE PING BETWEEN SITES ARE INTENDED TO ALLOW THE SITES TO BE OPENED IN THE ORDER LISTED.

CD /d "%userprofile%\Documents\ATC Workstation Setup CFG"

for /f "delims=" %%x in (USER_SITES_PREF.txt) do set USER_SITES_PREF=%%x

IF "%USER_SITES_PREF%"=="USE_ZSE_SITES" SET SITE_SOURCE=ZSE_DEFAULT_SITES.txt
IF "%USER_SITES_PREF%"=="USE_CUSTOM_SITES" SET SITE_SOURCE=CUSTOM_SITES.txt

setlocal EnableDelayedExpansion

SET /A COUNT=0

for /f "delims=" %%a in (%SITE_SOURCE%) do (
	
	SET /A COUNT=!COUNT! + 1

	IF !COUNT!==1 (
		
		SET URL=%%a
		
		START "" !URL!
	
		PING 127.0.0.1 -n 3 >nul
	)
	
	IF NOT !COUNT!==1 (
		
		SET URL=%%a
	
		START "" !URL!
		
		PING 127.0.0.1 -n 1 >nul
	)
)

endlocal

:STUP_DISCORD

@REM THESE REMARKS IN THE DISCORD STARTUP SECTION SERVES AS THE EXPLANATION FOR THE REST OF THE "STARTUP" FUNCTIONS FOR OTHER PROGRAMS.

CLS

@REM IF DISCORD IS NOT SET TO "NEVER USE" OR WAS NEVER FOUND FOR WHATEVER REASON, IT WILL SKIP THIS PART AND GO TO THE NEXT PROGRAM.

IF "%DISCORD_DIR%"=="Discord Directory Not Set" GOTO STUP_AFV
IF "%DISCORD_DIR%"=="DISCORD_NEVER_USE" GOTO STUP_AFV

tasklist /FI "IMAGENAME eq Discord.exe" 2>NUL | find /I /N "Discord.exe">NUL
if "%ERRORLEVEL%"=="0" goto STUP_AFV

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
echo     OPENING DISCORD VOICE COMMUNICATIONS APPLICATION
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

@REM THIS 2 SECOND DELAY ALONG WITH MANY OTHERS THROUGHOUT THIS FILE IS INTENDED TO KEEP FROM OVERLOADING OLDER MACHINE PROCESSORS.

PING 127.0.0.1 -n 2 >nul

@REM THE BATCH FILE CALLS THE DIRECTORY SET FOR DISCORD AND THEN STARTS THE .EXE.
@REM THE DISCORD APPLICATION IS UNIQUE IN THAT IT REQUIRES THE " --processStart Discord.exe" AFTER "Update.exe" IN ORDER TO START.
@REM AFTER DISCORD IS LAUNCHED, THE BATCH FILE MOVES ON TO THE NEXT PROGRAM AFTER 2 SECONDS.

CD /D %DISCORD_DIR%
START "" "Update.exe" --processStart Discord.exe
PING 127.0.0.1 -n 2 >nul

:STUP_AFV

CLS

IF "%AFV_DIR%"=="AFV Directory Not Set" GOTO STUP_VATIS
IF "%AFV_DIR%"=="AFV_NEVER_USE" GOTO STUP_VATIS

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
echo     OPENING AUDIO FOR VATSIM (AFV) STANDALONE CLIENT
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

PING 127.0.0.1 -n 2 >nul
CD /D %AFV_DIR%
START "" "AudioForVATSIM.exe"
PING 127.0.0.1 -n 2 >nul

:STUP_VATIS

CLS

IF "%VATIS_DIR%"=="vATIS Directory Not Set" GOTO RunRadarClient
IF "%VATIS_DIR%"=="vATIS_NEVER_USE" GOTO RunRadarClient

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
echo     OPENING VIRTUAL AUTOMATIC TERMINAL INFORMATION SERVICE (vATIS)
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

PING 127.0.0.1 -n 2 >nul
CD /D %VATIS_DIR%
START "" "vATIS.exe"
PING 127.0.0.1 -n 2 >nul

CLS

:RunRadarClient

	If /I %RadarClient%==A goto STVRC
	If /I %RadarClient%==B goto STVSTARS
	If /I %RadarClient%==C goto STVERAM
	If /I %RadarClient%==D goto STES

:STVRC

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
echo     OPENING VIRTUAL RADAR CLIENT (VRC)
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

PING 127.0.0.1 -n 2 >nul
CD /D %VRC_DIR%
START "" "VRC.exe"
PING 127.0.0.1 -n 2 >nul
GOTO DONE

:STVSTARS

IF "%DB_DIR%"=="DB_NEVER_USE" GOTO STVSTARS2

IF "%NAV_UPDATE_PREF%"=="DO_NOT_UPDATE_NAVDATA" GOTO STVSTARS2

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
echo     UPDATING vSTARS AIRAC NAVDATA
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

CD /D "%APPDATA%\vSTARS"
	DEL /Q "%APPDATA%\vSTARS\Airports.xml" "%APPDATA%\vSTARS\Waypoints.xml"

CD /D "%DB_DIR%\ZSE Facility Files (Live Update)\vSTARS"

	TYPE Airports.xml>"%APPDATA%\vSTARS\Airports.xml"
	TYPE Waypoints.xml>"%APPDATA%\vSTARS\Waypoints.xml"

:STVSTARS2

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
echo     OPENING VIRTUAL TERMINAL AUTOMATION REPLACEMENT SYSTEM (vSTARS)
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

PING 127.0.0.1 -n 2 >nul
CD /D %VSTARS_DIR%
START "" "vSTARS.exe"
PING 127.0.0.1 -n 2 >nul
GOTO DONE

:STVERAM

IF "%DB_DIR%"=="DB_NEVER_USE" GOTO STVERAM2

IF "%NAV_UPDATE_PREF%"=="DO_NOT_UPDATE_NAVDATA" GOTO STVERAM2

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
echo     UPDATING vERAM AIRAC NAVDATA
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

CD /D "%USERPROFILE%\AppData\Local\vERAM"
	DEL /Q Airports.xml Waypoints.xml

CD /D "%DB_DIR%\ZSE Facility Files (Live Update)\vERAM"

	TYPE Airports.xml>"%USERPROFILE%\AppData\Local\vERAM\Airports.xml"
	TYPE Waypoints.xml>"%USERPROFILE%\AppData\Local\vERAM\Waypoints.xml"

:STVERAM2

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
echo     OPENING VIRTUAL EN ROUTE AUTOMATION MODERNIZATION (vERAM)
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

PING 127.0.0.1 -n 2 >nul
CD /D %VERAM_DIR%
START "" "vERAM.exe"
PING 127.0.0.1 -n 2 >nul
GOTO DONE

:STES

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
echo     OPENING EUROSCOPE
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

PING 127.0.0.1 -n 2 >nul
CD /D %ES_DIR%
START "" "EuroScope.exe"
PING 127.0.0.1 -n 2 >nul
GOTO DONE

CLS

:DONE

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
echo -----------------------------------------------------------------------------
echo.
echo.
echo             Your ZSE VATSIM Control Work Station Has Been Setup              
echo.
echo             Original Authors:
echo.
echo                            Kyle Sanders (VATSIM CID 1187147)
echo                            Nikolas Boling (VATSIM CID 1474952)
echo.
echo -----------------------------------------------------------------------------
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

@REM THIS TIMEOUT IS PUT HERE WITH THE SOLE PURPOSE OF GIVING CREDIT TO THE ORGINIAL DEVELOPERS.
@REM AFTER THE TIMEOUT IS COMPLETE, THIS BATCH FILE WILL QUIT COMMAND PROMPT.

TIMEOUT 20
EXIT /B

:HELP

@REM IF THE USER TYPED HELP IN THE :HELLO FUNCTION, THE BATCH FILE SKIPS TO HERE.

CLS

ECHO.
ECHO.
ECHO   CHOOSE YOUR ISSUE:
ECHO.
ECHO         A)   HOW DO I RUN THIS BATCH FILE IN ADMINISTRATOR MODE?
ECHO.
ECHO         B)   MY ANTI-VIRUS/MALWARE SOFTWARE IS BLOCKING THIS BATCH FILE
ECHO.
ECHO         C)   WINDOWS WON'T ALLOW THE BATCH FILE TO RUN
ECHO.
ECHO         D)   I HAVE CHANGED THE LOCATION OF ONE OF MY PROGRAMS
ECHO.
ECHO         E)   I WANT TO RESET MY ENTIRE SAVED SETUP CONFIGURATION
ECHO.
ECHO         F)   I WANT TO SET UP DIFFERENT WEBSITES/PROGRAMS TO OPEN
ECHO.
ECHO         G)   IS THIS FILE SAFE TO RUN? WHAT DOES IT DO?
ECHO.
ECHO         H)   I CAN'T SEE THE FOLDERS MY .EXE IS SUPPOSED TO BE STORED IT
ECHO.
ECHO         I)   I WANT TO START/STOP THIS BATCH FILE AUTO-UPDATING MY vSTARS/vERAM NAVDATA
ECHO.
ECHO         J)   OTHER/STILL HAVING ISSUES/CONTACT ORIGINAL AUTHORS
ECHO.
ECHO         K)   NEVERMIND
ECHO.
ECHO.

@REM USER SELECTS THE LETTER OF THEIR ISSUE AND THE BATCH FILE SKIPS TO THAT FUNCTION.

	set /p userselected=Type Your Response (A - I) and Press Enter: 
		IF /I %userselected%==A GOTO ADMIN_MODE
		IF /I %userselected%==B GOTO ANTI_VIRUS
		IF /I %userselected%==C GOTO WDS_EXCLUSION
		IF /I %userselected%==D GOTO DIR_CHG
		IF /I %userselected%==E GOTO RESET_CFG
		IF /I %userselected%==F GOTO CREATE_BAT
		IF /I %userselected%==G GOTO SAFE_ABOUT
		IF /I %userselected%==H GOTO HIDDEN_FOLDERS
		IF /I %userselected%==I GOTO RESET_NAV_UPDATES
		IF /I %userselected%==J GOTO CONTACT_AUTHOR
		IF /I %userselected%==K GOTO HELLO
		
		echo.
		echo.
		echo.
		echo.
		echo  %userselected% IS NOT A RECOGNIZED RESPONSE. Try again.
		echo.
		
		PAUSE
		CLS
		GOTO HELP

:ADMIN_MODE

CLS

START "" https://fossbytes.com/batch-file-run-as-administrator-windows/

ECHO.
ECHO.
ECHO   This is done by simply right clicking the BAT file and selecting:
ECHO   "Run as Administrator"
ECHO.
ECHO   However, this BATCH File should have opened the link just now to
ECHO   the instructions for opening this BATCH file in ADMIN MODE automatically.
ECHO.
ECHO.

PAUSE
CLS
GOTO HELLO

:ANTI_VIRUS

CLS

ECHO.
ECHO.
ECHO What ANTI-VIRUS/MALWARE SOFTWARE DO YOU USE?
ECHO.
ECHO.

@REM THE USER TYPES THE SOFTWARE THEY USE AND THE RESPONSE IS INPUT INTO THE GOOGLE LINK APPROPRIATELY.

	set /p userselected=Type Your Response and Press Enter: 

START "" "https://www.google.com/?gws_rd=ssl#q=ADD+BATCH+FILE+TO+%USERSELECTED%+EXCLUSION+LIST"

CLS

ECHO.
ECHO.
ECHO   This BATCH File should have opened the link just now to
ECHO   the instructions for adding a BATCH file to your
ECHO   anti-virus/malware software exlcusion list.
ECHO.
ECHO.

PAUSE
CLS
GOTO HELLO

:WDS_EXCLUSION

CLS

START "" https://winaero.com/blog/exclusions-windows-defender-windows-10/

ECHO.
ECHO   This BATCH File should have opened the link just now to
ECHO   the instructions for adding a BATCH file to your Windows
ECHO   exclusion list.
ECHO.
ECHO.

PAUSE
CLS
GOTO HELLO

:DIR_CHG

CLS

ECHO.
ECHO.
ECHO   If you previously had a program in a location (directory) that was not
ECHO   that programs default directory, and you have now moved it to another
ECHO   location, this BATCH File will delete the old configuration file it made
ECHO   for it.
ECHO.
ECHO   This will allow you to run the BATCH File again
ECHO   and select the new location for the program.
ECHO.
ECHO   If you are doing this with the intention of troubleshooting a problem
ECHO   and that problem still persists, try the RESET ENTIRE SAVED SETUP CONFIGURATION
ECHO   option or contact the original authors.
ECHO.
ECHO.
ECHO   SELECT THE PROGRAM THAT HAS CHANGED LOCATIONS:
ECHO.
ECHO.
ECHO         A)   DISCORD
ECHO.
ECHO         B)   AUDIO FOR VATSIM CLIENT
ECHO.
ECHO         C)   vATIS
ECHO.
ECHO         D)   VRC
ECHO.
ECHO         E)   vSTARS
ECHO.
ECHO         F)   vERAM
ECHO.
ECHO         G)   EUROSCROPE
ECHO.
ECHO         H)   ZSE DROPBOX
ECHO.
ECHO.

@REM THE USER SELECTS THE PROGRAM THAT HAS CHANGED DIRECTORIES OR IS NEW AND THE BATCH FILE SKIPS TO THE APPROPRIATE FUNCTION.
@REM EACH FUNCTION WILL DELETE THE SAVED CONFIGURATION FILE FOR THAT PROGRAM AND WILL SEND THE USER BACK TO :HELLO
@REM IF THE PROGRAM IS SAVED IN THE DEFAULT DIRECTORY, NO FURTHER INPUT IS NEEDED FROM THE USER.
@REM IF THE PROGRAM IS NOT SAVED IN THE DEFAULT DIRECTORY, THEY WILL BE PROMPTED FOR THE PROGRAMS NEW DIRECTORY AND SAVED TO THE CONFIGURATION FILE.

	set /p userselected=Type Your Response (A - H) and Press Enter: 
		IF /I %userselected%==A GOTO DC_DIR_CHG
		IF /I %userselected%==B GOTO AFV_DIR_CHG
		IF /I %userselected%==C GOTO VATIS_DIR_CHG
		IF /I %userselected%==D GOTO VRC_DIR_CHG
		IF /I %userselected%==E GOTO VSTARS_DIR_CHG
		IF /I %userselected%==F GOTO VERAM_DIR_CHG
		IF /I %userselected%==G GOTO ES_DIR_CHG
		IF /I %userselected%==H GOTO DB_DIR_CHG
		
		echo.
		echo.
		echo.
		echo.
		echo  %userselected% IS NOT A RECOGNIZED RESPONSE. Try again.
		echo.
		
		PAUSE
		CLS
		GOTO DIR_CHG
		
:DC_DIR_CHG

CD /d "%userprofile%\Documents\ATC Workstation Setup CFG"
DEL /Q "%userprofile%\Documents\ATC Workstation Setup CFG\DISCORD_CUSTOM_DIRECTORY.txt"
GOTO HELLO

:AFV_DIR_CHG

CD /d "%userprofile%\Documents\ATC Workstation Setup CFG"
DEL /Q "%userprofile%\Documents\ATC Workstation Setup CFG\AFV_CUSTOM_DIRECTORY.txt"
GOTO HELLO

:VATIS_DIR_CHG

CD /d "%userprofile%\Documents\ATC Workstation Setup CFG"
DEL /Q "%userprofile%\Documents\ATC Workstation Setup CFG\VATIS_CUSTOM_DIRECTORY.txt"
GOTO HELLO

:VRC_DIR_CHG

CD /d "%userprofile%\Documents\ATC Workstation Setup CFG"
DEL /Q "%userprofile%\Documents\ATC Workstation Setup CFG\VRC_CUSTOM_DIRECTORY.txt"
GOTO HELLO

:VSTARS_DIR_CHG

CD /d "%userprofile%\Documents\ATC Workstation Setup CFG"
DEL /Q "%userprofile%\Documents\ATC Workstation Setup CFG\VSTARS_CUSTOM_DIRECTORY.txt"
GOTO HELLO

:VERAM_DIR_CHG

CD /d "%userprofile%\Documents\ATC Workstation Setup CFG"
DEL /Q "%userprofile%\Documents\ATC Workstation Setup CFG\VERAM_CUSTOM_DIRECTORY.txt"
GOTO HELLO

:ES_DIR_CHG

CD /d "%userprofile%\Documents\ATC Workstation Setup CFG"
DEL /Q "%userprofile%\Documents\ATC Workstation Setup CFG\ES_CUSTOM_DIRECTORY.txt"
GOTO HELLO

:DB_DIR_CHG

CD /d "%userprofile%\Documents\ATC Workstation Setup CFG"
DEL /Q "%userprofile%\Documents\ATC Workstation Setup CFG\DB_CUSTOM_DIRECTORY.txt"
GOTO HELLO

:RESET_CFG

CLS

ECHO.
ECHO.
ECHO   If you wish to completely delete all saved directories and reset the
ECHO   BATCH File to new, press any key to continue. 
ECHO.
ECHO.

@REM THIS PAUSE IS HERE TO ENSURE THE USER HAS TIME TO READ THE PROMPT AND MAKE SURE THEY WANT TO RESET THE CONFIGURATION FILES.

PAUSE

CD /d "%userprofile%\Documents"
RD /S /Q "%userprofile%\Documents\ATC Workstation Setup CFG"

GOTO HELLO

:CREATE_BAT

CLS

ECHO.
ECHO.
ECHO  NAVIGATE TO:
ECHO   "%userprofile%\...
ECHO                  ...Documents\ATC Workstation Setup CFG"
ECHO.
ECHO.
ECHO  IF YOU USE CUSTOM SITES:
ECHO       -Open the "CUSTOM_SITES.txt" and make changes manually.
ECHO       -Save the file and restart this BATCH File.
ECHO.
ECHO.
ECHO  IF YOU USE ZSE STANDARD SITES:
ECHO       -Delete the USER_SITES_PREF.txt file.
ECHO       -Run this batch file again and follow the prompts.
ECHO.
ECHO.

PAUSE
CLS
GOTO HELLO

:SAFE_ABOUT

CLS

START "" "https://docs.google.com/presentation/d/e/2PACX-1vTTbx5Szs5I8oveHofFnDDkJxYIWHcb7GqfyQYNXE-JtG2BX6_R0BTyj3DwOqFIRNoco1x8_XwgSc0Z/embed"

ECHO.
ECHO.
ECHO This is what is called a BATCH File.
ECHO For more information, read/watch the material in the google search
ECHO launched in your default internet browser.
ECHO.
ECHO This BATCH File will do the following:
ECHO.
ECHO     Create a folder in your Documents folder.
ECHO     This will help those that have any programs are not
ECHO     stored in their default directories (locations).
ECHO.
ECHO     If this BATCH File could not locate a program in its
ECHO     default directory, it will prompt you to see if you
ECHO     even use that program while controlling.
ECHO.
ECHO     If you do use the program on a normal basis, it will
ECHO     ask you for the directory of that program.
ECHO.
ECHO     All of the above steps are skipped for future uses
ECHO     of the BATCH File.
ECHO.
ECHO     Now it will ask you what radar client you will be
ECHO     using for your controlling session today.
ECHO.
ECHO     You select your radar client and it will then attempt
ECHO     to open all of the appropriate programs and websites
ECHO     needed for your controlling session based on your
ECHO     previous responses.
ECHO.
ECHO     This BATCH File does not modify ANY of your core computer
ECHO     files or programs. It never touches the registry or any
ECHO     core compentents of your OS.
ECHO.
ECHO     With that being said, there are times that the BATCH File
ECHO     will not work correctly if not ran as "Administrator" and
ECHO     not given exclusions to your windows/custom
ECHO     anti-virus/malware software.
ECHO.
ECHO     If you have any further questions, you may right click on
ECHO     the BATCH File and select "Edit" to read the code yourself,
ECHO     have a knowledgable friend look at it first or contact the
ECHO     original authors with any questions.
ECHO.
ECHO.

PAUSE
CLS
GOTO HELLO

:HIDDEN_FOLDERS

START "" "https://support.microsoft.com/en-us/help/14201/windows-show-hidden-files"

ECHO.
ECHO.
ECHO  Chances are that your windows setup is set to hide
ECHO  certain files and folders for use.
ECHO.
ECHO  Follow the steps provided on the webpage
ECHO  that has been opened for you.
ECHO.
ECHO.

PAUSE
CLS
GOTO HELLO

:RESET_NAV_UPDATES

CLS

ECHO.
ECHO.
ECHO  Press any key and your NAVDATA AUTO-UPDATE Preferences
ECHO  will be cleared and you may then set it up the way you would like.
ECHO.
ECHO.

PAUSE

CD /d "%userprofile%\Documents\ATC Workstation Setup CFG"
DEL /Q NAVDATA_UPDATE_PREF.txt DB_CUSTOM_DIRECTORY.txt
CLS
GOTO HELLO

:CONTACT_AUTHOR

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo   STILL HAVING ISSUES OR HAVE FURTHER QUESTIONS?
echo.
echo   Contact the original authors of this BATCH File.
echo.
echo.
echo.
echo -----------------------------------------------------------------------------
echo.
echo         Original Authors:
echo.
echo                            Kyle Sanders (VATSIM CID 1187147)
echo                            Nikolas Boling (VATSIM CID 1474952)
echo.
echo -----------------------------------------------------------------------------
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

PAUSE
CLS
GOTO HELLO
