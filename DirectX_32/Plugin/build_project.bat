@ECHO OFF
SETLOCAL
IF NOT "%VCINSTALLDIR%" == "" GOTO do_process
IF "%VS90COMNTOOLS%" == "" GOTO show_err

:do_process
CALL "%VS90COMNTOOLS%\..\..\VC\vcvarsall.bat" x86
IF "%VS90COMNTOOLS%" == "" GOTO err_cantsetupvs_x86
DEVENV MyRegistryPlugin.sln /rebuild "Release|Win32"
IF NOT %ERRORLEVEL% == 0 goto bad_compile
ENDLOCAL

SETLOCAL
CALL "%VS90COMNTOOLS%\..\..\VC\vcvarsall.bat" x64
IF "%VS90COMNTOOLS%" == "" GOTO err_cantsetupvs_x64
DEVENV MyRegistryPlugin.sln /rebuild "Release|x64"
IF NOT %ERRORLEVEL% == 0 goto bad_compile
GOTO end

:show_err
ECHO Please execute this batch file inside a Visual Studio x86 Command Prompt
GOTO end

:err_cantsetupvs_x86
ECHO Cannot initialize Visual Studio x86 Command Prompt environment
GOTO end

:err_cantsetupvs_x64
ECHO Cannot initialize Visual Studio x64 Command Prompt environment
GOTO end

:bad_compile
ECHO Errors detected while compiling headers file
GOTO end

:end
ENDLOCAL
