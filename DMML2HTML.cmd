@echo off
setlocal enabledelayedexpansion

set j=0
for /r "Floppy" %%f in (MAVICA.HTM) do (
  if exist %%f (
    set i=!j!
    call :inner "%%f"
    set /a j=!i!
  )
)
echo var floppy = { > Floppy.js
set /a j-=1
set next=
for /l %%a in (0,1,!j!) do (
  if not "x!name[%%a]!==x" (
    echo   !next!'!name[%%a]!': [ >> Floppy.js
    echo     new Date^( >> Floppy.js
    echo       Date.UTC^(!day[%%a]!, !month[%%a]!, !year[%%a]!, >> Floppy.js
    echo                !hour[%%a]!, !minute[%%a]!, !second[%%a]!, 0^) >> Floppy.js
    echo     ^), >> Floppy.js
    echo     !size[%%a]!] >> Floppy.js
    set next=,
  )
)
echo }; >> Floppy.js
goto html

:inner
set dirp=%~p1
set dirp=%dirp:\=/%
set dirp=%dirp:~1%
pushd %~dp1

for /f "tokens=3 delims=><" %%g in (%~f1) do (
  for /f "delims=" %%a in ('echo %%g^| find /v "MVC-FD81" ^| findstr MVC') do (
    set name[!i!]=%dirp%%%a
    set size[!i!]=%%~za
    set /a i+=1
  )
)

echo.>B
set i=!j!
for /f "tokens=3,4,5,6" %%g in (%~f1) do (
  if not "x%%j==x" (
    echo.'%%j'|findstr /c:":" >nul
    if not errorlevel 1 (
      for /f "tokens=1,2,3 delims=:" %%k in ("%%j") do (
        set day[!i!]=%%g
        set /a month[!i!]=%%h-1
        set year[!i!]=%%i
        set /a hour[!i!]=%%k+0
        set /a minute[!i!]=%%l+0
        set /a second[!i!]=%%m+0
      )
      set /a i+=1
    )
  )
)
del B
del '

popd
goto eof

:html
java ^
  -cp xalan.jar;xerces.jar ^
  org.apache.xalan.xslt.Process ^
    -IN "Album.xml" ^
    -XSL "Album-files/Album.xsl" ^
    -OUT "Album.html"
start Album.html

:eof
