@echo off
echo Building TruckDoc MSI Installer with WiX v7...
echo.

REM Set variables
set TRUCKDOC_DIR="W:\TruckDocApp"
set MSI_DIR="W:\TruckDocApp\MSI"
set OUTPUT_DIR="W:\TruckDocApp\MSI\Output"

REM Accept EULA first
echo Accepting WiX v7 EULA...
wix eula --accept-osmf

REM Check if WiX Toolset v7 is installed
where wix >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: WiX Toolset v7 (wix.exe) not found in PATH.
    echo Please install WiX Toolset v7.0.0-rc.1 and add it to your PATH.
    echo Download from: https://wixtoolset.org/releases/
    pause
    exit /b 1
)

REM Create output directory
if not exist %OUTPUT_DIR% (
    echo Creating output directory...
    mkdir %OUTPUT_DIR%
)

echo.
echo Building with WiX v7...
echo.

REM Build using wix.exe (WiX v7 unified CLI) - removed extension reference
wix build %MSI_DIR%\TruckDoc.wixproj -o %OUTPUT_DIR%\TruckDoc.msi -dTruckDocAppDir=%TRUCKDOC_DIR%\
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to build MSI with WiX v7
    echo.
    echo Troubleshooting:
    echo 1. Ensure WiX Toolset v7.0.0-rc.1 is properly installed
    echo 2. Check that all .wxs files are valid
    echo 3. Verify the TruckDoc application files exist
    pause
    exit /b 1
)

echo.
echo ========================================
echo MSI Build Completed Successfully!
echo ========================================
echo.
echo Output file: %OUTPUT_DIR%\TruckDoc.msi
echo File size:
dir %OUTPUT_DIR%\TruckDoc.msi | findstr TruckDoc.msi
echo.
echo You can now install TruckDoc using the MSI file.
echo.
echo To test the installation:
echo 1. Double-click TruckDoc.msi
echo 2. Follow the installation wizard
echo 3. Choose "Pin to taskbar" option on the final screen
echo.
pause