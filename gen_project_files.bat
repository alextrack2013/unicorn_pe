@echo off
setlocal
set "currentdir=%~dp0"
set "ORIGINAL_PATH=%PATH%"
set "PATH=C:\Windows\System32;%ProgramFiles%\Microsoft Visual Studio\2022\Community\Common7\Tools;%ProgramFiles%\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin"

call "%ProgramFiles%\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" || (
    echo Failed to set up Visual Studio environment.
    set "PATH=%ORIGINAL_PATH%"
    exit /b 1
)

set "PATH=%ORIGINAL_PATH%"

cd /d "%currentdir%\unicorn" || (
    echo Unicorn directory not found.
    exit /b 1
)

cmake . || (
    echo CMake configuration failed.
    exit /b 1
)

cd ..

cd /d "%currentdir%\capstone" || (
    echo Capstone directory not found.
    exit /b 1
)

cmake -B build || (
    echo CMake configuration failed.
    exit /b 1
)

exit /b 0
