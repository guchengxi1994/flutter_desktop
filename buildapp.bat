@echo off

set input1=%1%

if "%input1%"=="1" (
    flutter build windows
) else (
    flutter build windows
    echo "start to build repl"
    cd D:\github_repo\debug_repl\
    flutter build windows
    copy D:\github_repo\debug_repl\build\windows\runner\release\native_repl.dll  D:\github_repo\flutter_windows_desktop\build\windows\runner\Release\native_repl.dll
    echo "copied"

    cd D:\github_repo\flutter_windows_desktop
)
