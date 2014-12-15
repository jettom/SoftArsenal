@echo off
rem �����������Ƃ�
if "%~1"=="" (
echo search command-path from PATH
echo usage: %0 command
exit/b
)

setlocal

rem �t�@�C�����̂��̂����݂��Ă���Ƃ�
if exist %~1 (
set f=%~f1
goto end
)

rem �G�C���A�X�̒T��
for /f "delims== tokens=1,*" %%i in ('doskey /macros') do (
if "%%i"=="%~1" set f=%%j & goto end
)

rem �g���q������Ƃ�
if not "%~x1"=="" (
set f=%~f$PATH:1
goto end
)

rem �g���q��t�^���ăJ�����g�f�B���N�g���̒T��
for %%e in (%PATHEXT%) do (
if exist %~1%%e call :full_path %~1%%e & goto end
)

rem �g���q��t�^���Ċ��ϐ�PATH�̒T��
for %%e in (%PATHEXT%) do (
call :search_path %~1%%e
if errorlevel 1 goto end
)
set f=
goto end

:full_path
set f=%~f1
exit/b

:search_path
set f=%~$PATH:1
if "%f%"=="" exit/b 0
exit/b 1

:end
echo %1=%f%
endlocal
