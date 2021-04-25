#update CMakelist	     upload shishi.bat, Readme_Niu

#Preparations:
#In Cmakelist   	set(OpenCV_DIR "C:/opencv/build") 	(already done)
#Make sure you have donwloaded opencv and change its folder name to "opencv" before moving it to "C:\"
#Download the whole folder through the link and rename it to be "openbr" before moving it to "C:\"  ( Check  "C:\openbr\janus" and make sure it is not empty)
#I suggest you to put both opencv and openbr folder in the "C:\"  otherwise you need to modify some dirs in the .bat
#Open the VS2019 x64 Cross Tools Command Prompt then execute shishi.bat. All the command will run consecutively.

#1. download opencv 
cd C:\opencv\sources
c:
mkdir msvc2019
cd msvc2019
cmake -G "NMake Makefiles" -DBUILD_PERF_TESTS=OFF -DBUILD_TESTS=OFF -DWITH_FFMPEG=OFF -DCMAKE_BUILD_TYPE=Debug ..
nmake
nmake install
cmake -DCMAKE_BUILD_TYPE=Release ..
nmake
nmake install
nmake clean

#2.download and install Qt(5.15.2) to "C:\".
#Remember that MSVC 2019 64-bit compiler is applied
#copy the folder "bin" form "C:\opencv\sources\msvc2019\install\x86\vc16" to "C:\openbr\openbr"   	(already done)

#3. install openbr
cd C:\openbr
mkdir msvc2019
cd msvc2019
cmake -G "Visual Studio 16 2019" -DCMAKE_PREFIX_PATH="C:/opencv/sources/msvc2019/install;C:/Qt/5.15.2/msvc2019_64" -DCMAKE_INSTALL_PREFIX="./install" -DBR_INSTALL_DEPENDENCIES=ON -DCMAKE_BUILD_TYPE=Release ..
cmake --build . --config Release	#apply cmake build&install	 instead of nmake
cmake --install ""

#4. Hack OpenBR
C:\Qt\Tools\QtCreator\bin\qtcreator.exe # open the qtcreator
#From the Qt Creator "Tools" menu select "Options..."
#Under "Kits" select "Desktop (default)"
#For "Compiler:" select "Microsoft Visual C++ Compiler 11.0 (x86_amd64)" and click "OK"
#From the Qt Creator "File" menu select "Open File or Project...".
#Select "C:\openbr\CMakeLists.txt" then "Open".
#Browse to your pre-existing build directory "C:\openbr\msvc2019" then select "Next".
#Select "Run CMake" then "Finish".

#5. open camera
#copy opencv_world452.dll from "C:\opencv\build\x64\vc15\bin" to "C:\openbr\msvc2019\install\bin"
cd C:\openbr\msvc2019\install\bin
br -gui -algorithm "Show(false)" -enroll 0.webcam

6.Package OpenBR
cd C:\openbr\msvc2019
cpack -G ZIP      zip C:\openbr\msvc2019\install\bin



