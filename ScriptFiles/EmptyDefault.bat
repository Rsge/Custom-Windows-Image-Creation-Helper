@echo off
pushd C:\Users\Default\AppData && (
rem takeown /f local\Microsoft\WindowsApps /r /a /d J
rem icacls local\Microsoft\WindowsApps /grant Administrators:F /T /C /L
rd /q /s LocalLow
mkdir LocalLow
popd
)
pushd "C:\Users\Default\AppData\Local\Microsoft\Windows" && (
for /f "tokens=*" %%a in ('dir /A:D /b') do (
  if not "%%a" == "Shell" if not "%%a" == "WinX" (
  rd /s /q "%%a"
  )
)
del /f /q *.* 2> nul
del /f /q /ah *.* 2> nul
popd
)
pushd "C:\Users\Default\AppData\Local\Microsoft\Office" && (
for /f "tokens=*" %%b in ('dir /A:D /b') do (
  if not "%%a" == "Personalization" (
  rd /s /q "%%b"
  )
)
popd
)
pushd "C:\Users\Default\AppData\Local\Microsoft\" && (
for /f "tokens=*" %%c in ('dir /A:D /b') do (
  if not "%%c" == "Windows" if not "%%c" == "Office" if not "%%c" == "Teams" (
  rd /s /q "%%c"
  )
)
del /f /q *.* 2> nul
del /f /q /ah *.* 2> nul
popd
)
pushd "C:\Users\Default\AppData\Local\" && (
for /f "tokens=*" %%d in ('dir /A:D /b') do (
  if not "%%d" == "Microsoft" (
  rd /s /q "%%d"
  )
)
del /f /q *.* 2> nul
del /f /q /ah *.* 2> nul
popd
)
pushd "C:\Users\Default\AppData\Roaming\Microsoft\Windows" && (
for /f "tokens=*" %%e in ('dir /A:D /b') do (
  if not "%%e" == "Start Menu" if not "%%e" == "SendTo" (
  rd /s /q "%%e"
  )
)
del /f /q *.* 2> nul
del /f /q /ah *.* 2> nul
popd
)
pushd "C:\Users\Default\AppData\Roaming\Microsoft" && (
for /f "tokens=*" %%f in ('dir /A:D /b') do (
  if not "%%f" == "Windows" (
  rd /s /q "%%f"
  )
)
del /f /q *.* 2> nul
del /f /q /ah *.* 2> nul
popd
)
pushd "C:\Users\Default\AppData\Roaming" && (
for /f "tokens=*" %%i in ('dir /A:D /b') do (
  if not "%%i" == "Microsoft" if not "%%i" == "Mozilla" (
  rd /s /q "%%i"
  )
)
del /f /q *.* 2> nul
del /f /q /ah *.* 2> nul
popd
)
for /r %%j in (*.log*) do del /q /f /ah %%j del /q /f %%j
for /r %%k in (*.blf*) do del /q /f /ah %%k del /q /f %%k
for /r %%l in (*.REGTRANS-MS) do del /q /f /ah %%l del /q /f %%l

echo Default profile cleaned up.
exit