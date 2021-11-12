REM --------------------------------------------
REM 				    2021
REM					MADE BY ZLY
REM 			zlyswork@gmail.com
REM 		 https://twitter.com/zly_u
REM --------------------------------------------



REM How many threads to use
	REM %NUMBER_OF_PROCESSORS% is a OS's Env Variable that stores a number of your CPU's Threads
	REM set /A THREADS=%NUMBER_OF_PROCESSORS%/2
	set /A THREADS=12

REM Memory control per thread
	set IMAGE_CACHE_PERCENT=5
	set MAX_MEMORY_PERCENT=5

REM --------------------------------------------

REM Render Prefs
	REM For Template Based Render
		REM Name for your composition you want to render
		set COMP_NAME=FINAL
		REM Name for your Render Settings Template for video
		set RS_TEMPLATE_VIDEO=Multi-Machine Settings PNG
		REM Name for your Output Module Template for video
		set OM_TEMPLATE_VIDEO=Multi-Machine Sequence PNG
		REM Name for your Output Module Template for audio
		set OM_TEMPLATE_AUDIO=AIFF 48kHz

	REM For Render Queue Based Render
		REM Queue index for your video render
		set RENDER_QUEUE_INDEX_VIDEO=1
		REM Queue index for your audio render
		set RENDER_QUEUE_INDEX_AUDIO=2

	REM ffmpeg prefs
		REM FPS Per Second xd
		set FPS=60
		REM Your desirable codec format for rendering
		set CODEC=h264

REM --------------------------------------------

REM Output Prefs
	REM %~dp0 means "current script's path"
	REM You can write a full path just into RENDER_FOLDER variable
	REM Example: D:\AftirEffehs\Renderings\render
	set RENDER_FOLDER=%~dp0AE_Rendered
	REM AE related naming convention for frames.
	set OUTPUT_VIDEO_FILE_NAME_AE=frame_[####].png
	REM AE related naming for audio export.
	set OUTPUT_AUDIO_FILE_NAME_AE=audio
	REM The digit in "%%04d" should match amount of '#' in "[####]" of OUTPUT_VIDEO_FILE_NAME_AE
	REM e.g. [#####] = "%%05d", [###] = "%%03d" and etc.
	set OUTPUT_VIDEO_FILE_NAME_FFMPEG=frame_%%04d.png
	REM Name for a compiled video, you have to specify the extension format at the end of the name e.g. .mp4/.mov/.avi and etc
	set OUTPUT_COMPILED_VIDEO_NAME=out_vid.mp4
	REM Where to ouptut a compiled video
	REM Leave empty if you want your video to output to the project's folder
	set OUTPUT_COMPILED_VIDEO_TO=%~dp0rendered_videos

REM --------------------------------------------
IF "%RENDER_FOLDER:~-1%" NEQ "\" (
	set RENDER_FOLDER=%RENDER_FOLDER%\
)
IF "%OUTPUT_COMPILED_VIDEO_TO:~-1%" NEQ "\" (
	set OUTPUT_COMPILED_VIDEO_TO=%OUTPUT_COMPILED_VIDEO_TO%\
)

mkdir "%RENDER_FOLDER%">NUL
mkdir "%OUTPUT_COMPILED_VIDEO_TO%">NUL
REM --------------------------------------------

REM Paths related
	REM add a folder, where your "aerender.exe" at, into system's enviroment variable "PATH", same with "ffmpeg.exe"
	REM if you can't then put a full path to those executables into variables below
	set PATH_TO_AERENDER="aerender.exe"
	set PATH_TO_FFMPEG="ffmpeg.exe"
	
	REM Don't touch these unless you know what you are doing
	set OUTPUT_VIDEO=%RENDER_FOLDER%%OUTPUT_VIDEO_FILE_NAME_AE%
	set OUTPUT_AUDIO=%RENDER_FOLDER%%OUTPUT_AUDIO_FILE_NAME_AE%
	set INPUT_FFMPEG_SEQUENCE=%RENDER_FOLDER%%OUTPUT_VIDEO_FILE_NAME_FFMPEG%
	set INPUT_FILE=%~1
	set INPUT_FILE_PATH=%~dp1
	set INPUT_FILE_NAME=%~nx1
	set INPUT_FILE_EXT=%~x1




