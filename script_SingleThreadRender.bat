@echo off
REM --------------------------------------------
REM 				    2021
REM					MADE BY ZLY
REM 			zlyswork@gmail.com
REM 		 https://twitter.com/zly_u
REM --------------------------------------------

set THIS_SCRIPT_PATH=%~dp0

set RENDER_TYPE=""
set RENDER_MODE=""
FOR %%A IN (%*) DO (
	IF "%%A"=="P" (
		set RENDER_TYPE=Preset
	)
	IF "%%A"=="RQ" (
		set RENDER_TYPE=RQ
	)
	
	IF "%%A"=="Audio" (
		set RENDER_MODE=Audio
	)
	IF "%%A"=="Sequence" (
		set RENDER_MODE=Sequence
	)
)

IF "%CONFIG_LOADED%"=="" CALL "%THIS_SCRIPT_PATH%_config.bat" %1
IF "%CONFIG_LOADED%"=="" (
	chcp 65001
	cls
)
IF "%CONFIG_LOADED%"=="" (
	echo [33;4m     Single-Threaded Render Setup for [91;4mAE[33m[4m      [0m
	echo [93m----------------------------------------------[0m
	echo [97m''''''''''''''''''''''''''''''''''''''''''''''[0m
	echo.
	echo.
	echo [94m――――――――――――――――――――――――――――――――――――――――――――――[0m
	IF "%RENDER_TYPE%"=="Preset" (
		IF "%RENDER_MODE%"=="Sequence" (
			title [Preset] Rendering Sequence
			echo [97mRender Type:[0m       [104;97m%RENDER_TYPE%[0m
			echo [97mComp name:[0m         [94m%COMP_NAME%[0m
			echo [97mVideo RS template:[0m [94m%RS_TEMPLATE_VIDEO%[0m
			echo [97mVideo OM template:[0m [94m%OM_TEMPLATE_VIDEO%[0m
			echo [94m――――――――――――――――――――――――――――――――――――――――――――――[0m
			echo [97mImage Caching:[0m     [91m%IMAGE_CACHE_PERCENT%%%[0m ┊ [31;4mPER THREAD![0m
			echo [97mMemory Usage:[0m      [91m%MAX_MEMORY_PERCENT%%%[0m ┊ [31;4mPER THREAD![0m
			echo [94m――――――――――――――――――――――――――――――――――――――――――――――[0m
			echo [97mInput File:[0m        [42;30m%INPUT_FILE_NAME%[0m
			echo Output sequence:   "%OUTPUT_VIDEO%"
			echo [94m――――――――――――――――――――――――――――――――――――――――――――――[0m
			echo.
			echo.
			
			TIMEOUT /T 1 >nul 2>nul
			echo -project "%INPUT_FILE%" -output "%OUTPUT_VIDEO%" -comp "%COMP_NAME%" -RStemplate "%RS_TEMPLATE_VIDEO%" -OMtemplate "%OM_TEMPLATE_AUDIO%" -sound OFF -mem_usage %IMAGE_CACHE_PERCENT% %MAX_MEMORY_PERCENT%
			aerender.exe -project "%INPUT_FILE%" -output "%OUTPUT_VIDEO%" -comp "%COMP_NAME%" -RStemplate "%RS_TEMPLATE_VIDEO%" -OMtemplate "%OM_TEMPLATE_AUDIO%" -sound OFF -mem_usage %IMAGE_CACHE_PERCENT% %MAX_MEMORY_PERCENT%
		) ELSE IF "%RENDER_MODE%"=="Audio" (
			title [Preset] Rendering Audio
			echo [97mRender Type:[0m       [104;97m%RENDER_TYPE%[0m
			echo [97mAudio OM template:[0m [94m%OM_TEMPLATE_AUDIO%[0m
			echo [94m――――――――――――――――――――――――――――――――――――――――――――――[0m
			echo [97mImage Caching:[0m     [91m%IMAGE_CACHE_PERCENT%%%[0m ┊ [31;4mPER THREAD![0m
			echo [97mMemory Usage:[0m      [91m%MAX_MEMORY_PERCENT%%%[0m ┊ [31;4mPER THREAD![0m
			echo [94m――――――――――――――――――――――――――――――――――――――――――――――[0m
			echo [97mInput File:[0m        [42;30m%INPUT_FILE_NAME%[0m
			echo Output audio:   "%OUTPUT_AUDIO%"
			echo [94m――――――――――――――――――――――――――――――――――――――――――――――[0m
			echo.
			echo.
			
			TIMEOUT /T 1 >nul 2>nul
			aerender.exe -project "%INPUT_FILE%" -comp "%COMP_NAME%" -s 0 -e 100 -RStemplate "Best Settings" -OMtemplate "%OM_TEMPLATE_AUDIO%" -sound ON -output "%OUTPUT_AUDIO%"
		) ELSE (
			echo Specify the Mode!
		)
	) ELSE IF "%RENDER_TYPE%"=="RQ" (
		IF "%RENDER_MODE%"=="Sequence" (
			title [Render Queue] Rendering Sequence
			echo [97mRender Type:[0m       [104;97m%RENDER_TYPE%[0m
			echo [97mRQ Video index:[0m    [94m%RENDER_QUEUE_INDEX_VIDEO%[0m
			echo [94m――――――――――――――――――――――――――――――――――――――――――――――[0m
			echo [97mImage Caching:[0m     [91m%IMAGE_CACHE_PERCENT%%%[0m ┊ [31;4mPER THREAD![0m
			echo [97mMemory Usage:[0m      [91m%MAX_MEMORY_PERCENT%%%[0m ┊ [31;4mPER THREAD![0m
			echo [94m――――――――――――――――――――――――――――――――――――――――――――――[0m
			echo [97mInput File:[0m        [42;30m%INPUT_FILE_NAME%[0m
			echo Output sequence:   "%OUTPUT_VIDEO%"
			echo [94m――――――――――――――――――――――――――――――――――――――――――――――[0m
			echo.
			echo.
			
			TIMEOUT /T 1 >nul 2>nul
			aerender.exe -project "%INPUT_FILE%" -output "%OUTPUT_VIDEO%" -rqindex %RENDER_QUEUE_INDEX_VIDEO% -sound OFF -mem_usage %IMAGE_CACHE_PERCENT% %MAX_MEMORY_PERCENT% -mp
		) ELSE IF "%RENDER_MODE%"=="Audio" (
			title [Render Queue] Rendering Audio
			echo [97mRender Type:[0m       [104;97m%RENDER_TYPE%[0m
			echo [97mRQ Audio index:[0m    [94m%RENDER_QUEUE_INDEX_AUDIO%[0m
			echo [94m――――――――――――――――――――――――――――――――――――――――――――――[0m
			echo [97mImage Caching:[0m     [91m%IMAGE_CACHE_PERCENT%%%[0m ┊ [31;4mPER THREAD![0m
			echo [97mMemory Usage:[0m      [91m%MAX_MEMORY_PERCENT%%%[0m ┊ [31;4mPER THREAD![0m
			echo [94m――――――――――――――――――――――――――――――――――――――――――――――[0m
			echo [97mInput File:[0m        [42;30m%INPUT_FILE_NAME%[0m
			echo Output audio:   "%OUTPUT_AUDIO%"
			echo [94m――――――――――――――――――――――――――――――――――――――――――――――[0m
			echo.
			echo.
			
			TIMEOUT /T 1 >nul 2>nul
			aerender.exe -project "%INPUT_FILE%" -output "%OUTPUT_AUDIO%" -rqindex %RENDER_QUEUE_INDEX_AUDIO% -sound ON
		) ELSE (
			echo Specify the Mode!
		)
	) ELSE (
		echo Specify the Render Type!
	)
	pause
) ELSE (
	IF "%RENDER_TYPE%"=="Preset" (
		IF "%RENDER_MODE%"=="Sequence" (
			start aerender.exe -project "%INPUT_FILE%" -output "%OUTPUT_VIDEO%" -comp "%COMP_NAME%" -RStemplate "%RS_TEMPLATE_VIDEO%" -OMtemplate "%OM_TEMPLATE_AUDIO%" -sound OFF -mem_usage %IMAGE_CACHE_PERCENT% %MAX_MEMORY_PERCENT%
		) ELSE IF "%RENDER_MODE%"=="Audio" (
			start aerender.exe -project "%INPUT_FILE%" -comp "%COMP_NAME%" -RStemplate "Best Settings" -OMtemplate "%OM_TEMPLATE_AUDIO%" -sound ON -output "%OUTPUT_AUDIO%"
		)
	) ELSE IF "%RENDER_TYPE%"=="RQ" (
		IF "%RENDER_MODE%"=="Sequence" (
			start aerender.exe -project "%INPUT_FILE%" -output "%OUTPUT_VIDEO%" -rqindex %RENDER_QUEUE_INDEX_VIDEO% -sound OFF -mem_usage %IMAGE_CACHE_PERCENT% %MAX_MEMORY_PERCENT%
		) ELSE IF "%RENDER_MODE%"=="Audio" (
			start aerender.exe -project "%INPUT_FILE%" -output "%OUTPUT_AUDIO%" -rqindex %RENDER_QUEUE_INDEX_AUDIO% -sound ON
		)
	)
)