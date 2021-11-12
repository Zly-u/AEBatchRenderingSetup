@echo off
chcp 65001
REM Include and process params
set SCRIPT_PATH=%~dp0
CALL "%SCRIPT_PATH%_config.bat" %1
set CONFIG_LOADED=True
IF "%OUTPUT_COMPILED_VIDEO_TO%"=="" (
	set OUTPUT_COMPILED_VIDEO_TO="%INPUT_FILE_PATH%"
	echo aasss
)
cscript.exe "%SCRIPT_PATH%script_getRAM.vbs"
set AMOUNT_OF_RAM=%ERRORLEVEL%
cscript.exe "%SCRIPT_PATH%script_getAvailableRAM.vbs"
set AMOUNT_OF_AVAILABLE_RAM=%ERRORLEVEL%
cls

set PRESSET_TYPE=
set RENDER_TYPE=
set MODE_TYPE=""
set RENDER_MODE_TEXT=
FOR %%A IN (%*) DO (
    IF "%%A"=="P" (
		set RENDER_TYPE=Preset
		set PRESSET_TYPE=P
	)
    IF "%%A"=="RQ" (
		set RENDER_TYPE=Render Queue
		set PRESSET_TYPE=RQ
	)
    IF "%%A"=="noAudio" ( 
		set RENDER_MODE_TEXT=│ [4mNo Audio Mode![0m
		set MODE_TYPE=noAudio
	)
	IF "%%A"=="sequenceOnly" ( 
		set RENDER_MODE_TEXT=│ [4mSequence Only Mode![0m
		set MODE_TYPE=sequenceOnly
	)
)



IF "%RENDER_TYPE%"=="" (
	echo No Render Type was specified!
	pause
	EXIT /B %ERRORLEVEL%
)
cls


REM --------------------------------------------
REM 				   2021
REM					MADE BY ZLY
REM 			zlyswork@gmail.com
REM 		 https://twitter.com/zly_u
REM --------------------------------------------
title Multi-Threaded AE Render by Zly

echo [33;4m      Multi-Threaded Render Setup for [91;4mAE[33m[4m      [0m
echo [93m----------------------------------------------[0m
echo [97m''''''''''''''''''''''''''''''''''''''''''''''[0m
echo.
echo.

echo [94m――――――――――――――――――――――――――――――――――――――――――――――[0m
echo [97mRender Type:[0m       [104;97m%RENDER_TYPE%[0m %RENDER_MODE_TEXT%
IF "%PRESSET_TYPE%"=="P" (
	echo [97mComp name:[0m         [94m%COMP_NAME%[0m
	echo [97mVideo RS template:[0m [94m%RS_TEMPLATE_VIDEO%[0m
	echo [97mVideo OM template:[0m [94m%OM_TEMPLATE_VIDEO%[0m
	echo [97mAudio OM template:[0m [94m%OM_TEMPLATE_AUDIO%[0m
) ELSE IF "%PRESSET_TYPE%"=="RQ" (
	echo [97mRQ Video index:[0m    [94m%RENDER_QUEUE_INDEX_VIDEO%[0m
	echo [97mRQ Audio index:[0m    [94m%RENDER_QUEUE_INDEX_AUDIO%[0m
)
echo [94m———―――――――――――――――――――――――――――――――――――――――――――[0m
echo [97mAmount of threads:[0m [33m%THREADS%[0m
echo [97mAmount of RAM:[0m     [96m%AMOUNT_OF_AVAILABLE_RAM%/%AMOUNT_OF_RAM%[0mGB
echo [97mImage Caching:[0m     [91m%IMAGE_CACHE_PERCENT%%%[0m ┊ [31;4mPER THREAD![0m
echo [97mMemory Usage:[0m      [91m%MAX_MEMORY_PERCENT%%%[0m ┊ [31;4mPER THREAD![0m
echo [94m――――――――――――――――――――――――――――――――――――――――――――――[0m
echo [97mInput File:[0m        [42;30m%INPUT_FILE_NAME%[0m
echo [97mFPS:[0m               %FPS%[0m
echo [97mCodec:[0m	           %CODEC%[0m
echo [97mOutput file name:[0m  %OUTPUT_COMPILED_VIDEO_NAME%[0m
echo [97mOutput to:[0m         %OUTPUT_COMPILED_VIDEO_TO%[0m
echo [94m――――――――――――――――――――――――――――――――――――――――――――――[0m
echo.
echo.



IF "%INPUT_FILE%"=="" (
	echo Project File is required!
	pause
	EXIT /B %ERRORLEVEL%
) ELSE IF "%INPUT_FILE_EXT%" NEQ ".aep" (
	echo This is not an AE Project File!
	pause
	EXIT /B %ERRORLEVEL%
)


echo [4mTo start the render - press a key.[0m
pause>nul
echo.


REM Render Images
FOR /l %%x in (1, 1, %THREADS%) DO (
	echo Executing process: %%x
	CALL :RenderSequence
)


echo.
REM Checking if any of the Render Processes running
CALL :CheckRenderPrcessesRunning "[101;30mRendering Sequence[0m" %PATH_TO_AERENDER%
echo [32mSequence is rendered![0m
echo.


REM Render Audio
IF "%MODE_TYPE%" NEQ "noAudio" (
	IF "%MODE_TYPE%" NEQ "sequenceOnly" (
	
		CALL :RenderAudio
		CALL :CheckRenderPrcessesRunning "[101;30mRendering Audio[0m" %PATH_TO_AERENDER%
		echo [32mAudio is rendered![0m
		echo.
		
		set VideoStateCompiling=Compiling Video
	) ELSE (
		goto :audioSkip
	)
) ELSE (
	:audioSkip
	echo [33mAudio is skipped![0m
	echo.
	
	set VideoStateCompiling=Compiling Video ┊ wo/ sound
)

REM Compile video
IF "%MODE_TYPE%" NEQ "sequenceOnly" (
	CALL :CompileVideo
	CALL :CheckRenderPrcessesRunning "[101;30m%VideoStateCompiling%[0m" %PATH_TO_FFMPEG%
	echo [32mVideo is compiled![0m
	echo.
) ELSE (
	echo [33mVideo is skipped![0m
	echo.
)

echo.
echo [42;97mRENDER IS DONE![0m
echo.

echo [4mPress any key to quit...[0m
pause>nul
EXIT /B %ERRORLEVEL%



:RenderSequence
	IF "%PRESSET_TYPE%"=="P" (
		CALL "%SCRIPT_PATH%util_Render_Preset_sequence.bat" "%INPUT_FILE%"
	) ELSE (
		CALL "%SCRIPT_PATH%util_Render_RenderQueue_sequence.bat" "%INPUT_FILE%"
	)
EXIT /B 0

:RenderAudio
	IF "%PRESSET_TYPE%"=="P" (
		CALL "%SCRIPT_PATH%util_Render_Preset_audio.bat" "%INPUT_FILE%"
	) ELSE (
		CALL "%SCRIPT_PATH%util_Render_RenderQueue_audio.bat" "%INPUT_FILE%"
	)
EXIT /B 0

:CompileVideo
	IF "%MODE_TYPE%"=="noAudio" (
		CALL "%SCRIPT_PATH%util_compileVideo_NoAudio.bat"
	) ELSE (
		CALL "%SCRIPT_PATH%util_compileVideo_Full.bat"
	)
EXIT /B 0

:CheckRenderPrcessesRunning
	setlocal EnableDelayedExpansion
	set aStr=^│╱―╲
	set aStrLen=4
	set text=%1
	for /f %%a in ('copy /Z "%~f0" nul') do set "CR=%%a"
	:animationLoop
		<nul set /P "=[33m!aStr:~%i%,1!!aStr:~%i%,1!!aStr:~%i%,1!!aStr:~%i%,1![0m !text:~1,-1! [33m!aStr:~%i%,1!!aStr:~%i%,1!!aStr:~%i%,1!!aStr:~%i%,1!!CR![0m"
		set /a i+=1
		if %i%==%aStrLen% (set /a i=0)
		TIMEOUT /T 1 >nul 2>nul
		QPROCESS %2 >nul 2>nul
	if %ERRORLEVEL% EQU 0 goto animationLoop
	echo.
EXIT /B 0




