@echo off

set THIS_SCRIPT_PATH=%~dp0
set CV_ARG=
FOR %%A IN (%*) DO (
    IF "%%A"=="noAudio" (
		set CV_ARG=noAudio
	)
)

IF "%CONFIG_LOADED%"=="" CALL "%THIS_SCRIPT_PATH%_config.bat"
IF "%CONFIG_LOADED%"=="" (
	title Compiling Video
	
	echo [97mFFMPEG Sequence:[0m    %INPUT_FFMPEG_SEQUENCE%[0m
	echo [97mFPS:[0m               %FPS%[0m
	echo [97mCODEC:[0m	           %CODEC%[0m
	echo [97mOutput file name:[0m  %OUTPUT_COMPILED_VIDEO_NAME%[0m
	echo [97mOutput to:[0m         %OUTPUT_COMPILED_VIDEO_TO%[0m
	echo.
)	

TIMEOUT /T 1 >nul 2>nul

IF "%CONFIG_LOADED%"=="True" (
	cd "%RENDER_FOLDER%"
)
FOR /r %%x in (%OUTPUT_AUDIO_FILE_NAME_AE%.*) DO (
	set FOUND_AUDIO=%%x
	if exist "%%x" goto :_break
)
:_break

IF "%CV_ARG%"=="noAudio" (
	IF "%CONFIG_LOADED%"=="" (
		ffmpeg.exe -y -framerate %FPS% -i "%INPUT_FFMPEG_SEQUENCE%" -vcodec "%CODEC%" "%OUTPUT_COMPILED_VIDEO_TO%\%OUTPUT_COMPILED_VIDEO_NAME%"
		pause
	) ELSE (
		start ffmpeg.exe -y -framerate %FPS% -i "%INPUT_FFMPEG_SEQUENCE%" -vcodec "%CODEC%" "%OUTPUT_COMPILED_VIDEO_TO%\%OUTPUT_COMPILED_VIDEO_NAME%"
	)
) ELSE (
	IF "%CONFIG_LOADED%"=="" (
		ffmpeg.exe -y -framerate %FPS% -i "%INPUT_FFMPEG_SEQUENCE%" -i "%FOUND_AUDIO%" -vcodec "%CODEC%" "%OUTPUT_COMPILED_VIDEO_TO%\%OUTPUT_COMPILED_VIDEO_NAME%"
		pause
	) ELSE (
		start ffmpeg.exe -y -framerate %FPS% -i "%INPUT_FFMPEG_SEQUENCE%" -i "%FOUND_AUDIO%" -vcodec "%CODEC%" "%OUTPUT_COMPILED_VIDEO_TO%\%OUTPUT_COMPILED_VIDEO_NAME%"
	)
)

EXIT /B %ERRORLEVEL%













