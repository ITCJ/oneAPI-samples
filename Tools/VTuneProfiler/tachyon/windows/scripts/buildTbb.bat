@echo off

if ""%1"" == ""clean"" goto clean

echo Building build_with_tbb project 
rem for building win32 release config only
rem build "build_with_tbb" program
rem output is created in "tachyon_release" directory
if exist "tachyon_release" goto build_start
mkdir tachyon_release
goto build_start

:clean
echo cleaning tbb build files
if exist "tachyon_release" goto clean2
exit /b

:clean2
del /F /Q tachyon_release\*.*
exit /b

:build_start
if ""%1"" == ""optimized"" goto build_optimized
set CFLAGS=/c /O2 /Oi /Ot /Qipo /EHsc /MD /GS /arch:SSE2 /fp:fast /W2 /Zi /Qtbb /I src
set DefFlags=/D "WIN32" /D "_WINDOWS" /D "NDEBUG" /D "_MBCS" 
set OutDir=.\tachyon_release\\
set OutFlags=/Fo"%OutDir%" 
set outFName=tachyon.tbb
set srcDir=.\src\%outFName%\

echo icl %CFLAGS% %DefFlags% %OutFlags% %srcDir%%outFName%.cpp
icl %CFLAGS% %DefFlags% %OutFlags% %srcDir%%outFName%.cpp

echo xilink.exe /OUT:"%OutDir%%outFName%.exe" /INCREMENTAL:NO /MANIFEST /MANIFESTFILE:"%OutDir%%outFName%.exe.intermediate.manifest" /TLBID:1 /DEBUG /PDB:"%OutDir%%outFName%.pdb" /SUBSYSTEM:WINDOWS /OPT:REF /OPT:ICF  /IMPLIB:"%OutDir%%outFName%.lib" /FIXED:NO %OutDir%tachyon.common.lib %OutDir%%outFName%.obj
xilink.exe /OUT:"%OutDir%%outFName%.exe" /INCREMENTAL:NO /MANIFEST /MANIFESTFILE:"%OutDir%%outFName%.exe.intermediate.manifest" /TLBID:1 /DEBUG /PDB:"%OutDir%%outFName%.pdb" /SUBSYSTEM:WINDOWS /OPT:REF /OPT:ICF  /IMPLIB:"%OutDir%%outFName%.lib" /FIXED:NO %OutDir%tachyon.common.lib %OutDir%%outFName%.obj

echo mt.exe /outputresource:"%OutDir%%outFName%.exe;#1" /manifest %OutDir%%outFName%.exe.intermediate.manifest
mt.exe /outputresource:"%OutDir%%outFName%.exe;#1" /manifest %OutDir%%outFName%.exe.intermediate.manifest
exit /b

:build_optimized
echo Building TBB Optimized
set CFLAGS=/c /O2 /Oi /Ot /Qipo /EHsc /MD /GS /arch:SSE2 /fp:fast /W2 /Zi /Qtbb /I src
set DefFlags=/D "WIN32" /D "_WINDOWS" /D "NDEBUG" /D "_MBCS" 
set OutDir=.\tachyon_release\\
set OutFlags=/Fo"%OutDir%" 
set outFName=tachyon.tbb_optimized
set outFDir=tachyon.tbb
set srcDir=.\src\%outFDir%\

echo icl %CFLAGS% %DefFlags% %OutFlags% %srcDir%%outFName%.cpp
icl %CFLAGS% %DefFlags% %OutFlags% %srcDir%%outFName%.cpp

echo xilink.exe /OUT:"%OutDir%%outFName%.exe" /INCREMENTAL:NO /MANIFEST /MANIFESTFILE:"%OutDir%%outFName%.exe.intermediate.manifest" /TLBID:1 /DEBUG /PDB:"%OutDir%%outFName%.pdb" /SUBSYSTEM:WINDOWS /OPT:REF /OPT:ICF  /IMPLIB:"%OutDir%%outFName%.lib" /FIXED:NO %OutDir%tachyon.common.lib %OutDir%%outFName%.obj
xilink.exe /OUT:"%OutDir%%outFName%.exe" /INCREMENTAL:NO /MANIFEST /MANIFESTFILE:"%OutDir%%outFName%.exe.intermediate.manifest" /TLBID:1 /DEBUG /PDB:"%OutDir%%outFName%.pdb" /SUBSYSTEM:WINDOWS /OPT:REF /OPT:ICF  /IMPLIB:"%OutDir%%outFName%.lib" /FIXED:NO %OutDir%tachyon.common.lib %OutDir%%outFName%.obj

echo mt.exe /outputresource:"%OutDir%%outFName%.exe;#1" /manifest %OutDir%%outFName%.exe.intermediate.manifest
mt.exe /outputresource:"%OutDir%%outFName%.exe;#1" /manifest %OutDir%%outFName%.exe.intermediate.manifest
