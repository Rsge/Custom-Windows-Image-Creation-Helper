@echo off
pushd "C:\Users" && (
for /f "tokens=*" %%a in ('dir /A:D /b') do (
  if not "%%a" == "Public" if not "%%a" == "All Users" if not "%%a" == "Default User" (
    pushd "C:\Users\%%a\AppData\Local\Microsoft\Windows" && (
      rd /s /q WebCache
      del /q /f WebCacheLock.dat
    )
    popd
  )
)
popd
)
pause
exit
