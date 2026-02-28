# TruckDoc MSI Installation Guide (WiX v7)

## Overview
This guide will help you create a professional MSI (Windows Installer) package for your TruckDoc WPF application using WiX Toolset v7.0.0-rc.1.

## Prerequisites

### Required Software
1. **WiX Toolset v7.0.0-rc.1** - Download from https://wixtoolset.org/releases/
2. **Visual Studio 2019+** (optional, for Visual Studio integration)
3. **.NET 8 Runtime** - Should be installed on target machines

### WiX Toolset v7 Installation
1. Download WiX Toolset v7.0.0-rc.1 from https://wixtoolset.org/releases/
2. Install the WiX Toolset Visual Studio Extension (optional)
3. Add WiX v7 to your PATH (usually `C:\Program Files\WiX Toolset v7.0.0-rc.1\bin`)

### WiX v7 Key Changes
- **Unified CLI**: Single `wix.exe` command instead of separate `candle.exe` and `light.exe`
- **NuGet-based extensions**: Extensions are now NuGet packages
- **Updated schema**: XML namespace changed to `http://wixtoolset.org/schemas/v4/wxs`
- **Simplified project structure**: Cleaner project files with PackageReference

## MSI Project Structure

```
W:\TruckDocApp\MSI\
├── Product.wxs              # Main product definition
├── CustomActions.wxs         # Taskbar pinning custom action
├── UI.wxs                   # Custom UI with taskbar pinning option
├── PinToTaskbarCA.vbs       # VBScript for taskbar pinning
├── TruckDoc.wixproj         # MSBuild project file
├── BuildMSI.bat             # Batch build script
└── Output\                  # Build output directory
```

## Building the MSI Installer

### Method 1: Using Batch Script (Recommended for WiX v7)
1. Open Command Prompt as Administrator
2. Navigate to the MSI directory:
   ```cmd
   cd W:\TruckDocApp\MSI
   ```
3. Run the build script:
   ```cmd
   BuildMSI.bat
   ```

### Method 2: Using MSBuild with WiX v7
1. Open Developer Command Prompt for Visual Studio
2. Navigate to the MSI directory:
   ```cmd
   cd W:\TruckDocApp\MSI
   ```
3. Build the project:
   ```cmd
   msbuild TruckDoc.wixproj /p:Configuration=Release
   ```

### Method 3: Using WiX v7 Unified CLI
1. Open Command Prompt
2. Navigate to the MSI directory:
   ```cmd
   cd W:\TruckDocApp\MSI
   ```
3. Build with the unified CLI:
   ```cmd
   wix build TruckDoc.wixproj -o Output\TruckDoc.msi -dTruckDocAppDir=W:\TruckDocApp\
   ```

## MSI Features

### Standard Features
- **Professional Installer**: Standard Windows Installer interface
- **Per-Machine Installation**: Installs to `C:\Program Files\TruckDoc`
- **Start Menu Integration**: Creates shortcuts in Start Menu
- **Desktop Shortcut**: Optional desktop shortcut
- **Uninstall Support**: Clean uninstall through Apps & Features
- **Upgrade Support**: Handles version upgrades automatically
- **Repair Support**: Can repair damaged installations

### Advanced Features
- **Taskbar Pinning**: Custom action to pin application to taskbar
- **Custom UI**: Modified exit dialog with taskbar pinning option
- **64-bit Support**: Optimized for x64 systems
- **Component Organization**: Logical grouping of application files
- **Registry Management**: Proper registry entries for Windows integration

## Installation Process

### User Experience
1. **Welcome Screen**: Standard MSI welcome dialog
2. **License Agreement**: (Can be added if needed)
3. **Installation Folder**: Default `C:\Program Files\TruckDoc`
4. **Ready to Install**: Summary of installation options
5. **Progress**: Installation progress with file copying
6. **Completion**: Custom exit dialog with:
   - Launch application option
   - **Pin to taskbar** checkbox
   - Finish button

### Taskbar Pinning
- User can check "Pin to taskbar" on the final screen
- Custom action executes after installation
- Uses Windows Shell API to pin the application
- Works on Windows 10 and Windows 11

## File Components

### Application Files
- `WpfTruckDoc.exe` - Main executable
- `*.dll` - All required assemblies
- `*.json` - Configuration files
- `*.config` - .NET configuration
- `runtimes\*` - Native runtime libraries

### Installation Components
- **MainExecutable**: Core application component
- **DataAccessInterfaceDLL**: Data access interface
- **DataAccessLayerDLL**: Data access layer
- **DataDomainDLL**: Domain model
- **LogicLayerDLL**: Business logic
- **LogicLayerInterfaceDLL**: Logic interface
- **SystemDataSqlClientDLL**: SQL Server client
- **ConfigFiles**: Configuration files
- **RuntimeFiles**: Native runtime components

## Customization

### Modifying Product Information
Edit `Product.wxs` to change:
- Product name and version
- Manufacturer information
- Upgrade code
- Installation directory

### Adding License Agreement
1. Add license file to project
2. Include in `Product.wxs`:
   ```xml
   <WixVariable Id="WixUILicenseRtf" Value="license.rtf" />
   ```

### Modifying UI Elements
Edit `UI.wxs` to customize:
- Dialog text and layout
- Checkbox options
- Button behavior
- Visual elements

### Adding Custom Actions
1. Create VBScript or C# custom action
2. Define in `CustomActions.wxs`
3. Add to installation sequence

## Testing the MSI

### Pre-Installation Testing
1. **Clean System Test**: Test on fresh Windows installation
2. **Upgrade Testing**: Test upgrading from previous versions
3. **Repair Testing**: Test repair functionality
4. **Uninstall Testing**: Verify clean removal

### Validation Testing
1. **Install**: Verify installation completes successfully
2. **Launch**: Confirm application starts from shortcuts
3. **Taskbar**: Verify pinning functionality
4. **Repair**: Test repair from Apps & Features
5. **Uninstall**: Confirm clean removal

### Common Issues and Solutions

#### Build Issues
- **"wix.exe not found"**: Add WiX v7 to PATH
- **"Extension not found"**: Ensure WixToolset.UI.wixext package is installed
- **"Schema validation failed"**: Check XML namespace is `http://wixtoolset.org/schemas/v4/wxs`
- **"Missing .NET Runtime": Include .NET 8 Runtime
- **"Custom Action Failed"**: Check VBScript permissions

#### Installation Issues
- **"Access Denied"**: Run installer as administrator
- **"Missing .NET Runtime": Include .NET 8 Runtime
- **"Custom Action Failed"**: Check VBScript permissions

#### Taskbar Pinning Issues
- **"Pin option not available"**: Windows version compatibility
- **"Permission denied"**: User context issues
- **"Already pinned"**: Normal behavior, not an error

## Deployment

### Distribution
1. **Sign the MSI** (recommended for enterprise deployment)
2. **Test on target systems**
3. **Create installation documentation**
4. **Consider Group Policy deployment** for enterprise

### Enterprise Features
- **Silent Installation**: `msiexec /i TruckDoc.msi /quiet`
- **Transform Files**: For custom configurations
- **System Center Integration**: SCCM deployment
- **Active Directory**: Group Policy deployment

## Troubleshooting

### Log Files
Enable verbose logging:
```cmd
msiexec /i TruckDoc.msi /l*v install.log
```

### Common Error Codes
- **1603**: Fatal installation error
- **1722**: Custom action failed
- **1903**: System restart required
- **2755**: Invalid MSI package

### Debug Information
- Check Windows Event Viewer
- Review MSI log files
- Verify file permissions
- Test custom actions separately

## Support Files Location
All MSI-related files are located in:
- `W:\TruckDocApp\MSI\` - Source files
- `W:\TruckDocApp\MSI\Output\` - Built MSI file
- `W:\TruckDocApp\MSI\BuildMSI.bat` - Build script

## Next Steps
1. Install WiX Toolset
2. Test the build process
3. Customize as needed
4. Test on clean systems
5. Deploy to users
