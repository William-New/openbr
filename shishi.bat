@echo Please follow the instructions first then press any key to continue
@echo Change the opencv folder name to "opencv", and move it to "C:\"
@echo Download "openbr" through the link and move the folder to "C:\"
pause
cd C:\opencv\sources
C:
mkdir msvc2019
cd msvc2019
cmake -G "NMake Makefiles" -DBUILD_PERF_TESTS=OFF -DBUILD_TESTS=OFF -DWITH_FFMPEG=OFF -DCMAKE_BUILD_TYPE=Debug ..
nmake
nmake install
cmake -DCMAKE_BUILD_TYPE=Release ..
nmake
nmake install
nmake clean

@echo Please ensure you have downloaded and installed Qt to "C:\"(5.15.2 MSVC 2019 64-bit is applied here). 
pause
cd C:\openbr\openbr
mkdir bin
xcopy C:\opencv\sources\msvc2019\install\x86\vc16\bin C:\openbr\openbr\bin /s /e
cd C:\openbr
mkdir msvc2019
cd msvc2019
cmake -G "Visual Studio 16 2019" -DCMAKE_PREFIX_PATH="C:/opencv/sources/msvc2019/install;C:/Qt/5.15.2/msvc2019_64" -DCMAKE_INSTALL_PREFIX="./install" -DBR_INSTALL_DEPENDENCIES=ON -DCMAKE_BUILD_TYPE=Release ..
cmake --build . --config Release
cmake --install ""

@echo Hack OpenBR: Please press any key to open the qtcreator then follow the instructions below
@echo From the Qt Creator "Tools" menu select "Options..."
@echo Under "Kits" select "Desktop (default)"
@echo For "Compiler:" select "Microsoft Visual C++ Compiler 11.0 (x86_amd64)" and click "OK"
@echo From the Qt Creator "File" menu select "Open File or Project...".
@echo Select "C:\openbr\CMakeLists.txt" then "Open".
@echo Browse to your pre-existing build directory "C:\openbr\msvc2019" then select "Next".
@echo Select "Run CMake" then "Finish".
pause
C:\Qt\Tools\QtCreator\bin\qtcreator.exe

xcopy C:\opencv\build\x64\vc15\bin C:\openbr\msvc2019\install\bin /s /e
@echo Press to open the camera
pause
cd C:\openbr\msvc2019\install\bin
br -gui -algorithm "Show(false)" -enroll 0.webcam


