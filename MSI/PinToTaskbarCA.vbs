' Custom Action for MSI Installer - Pin to Taskbar
' This script is executed as a custom action during MSI installation

Option Explicit

Dim objShell, objFSO, scriptDir, exePath, objFolder, objFolderItem, colVerbs, objVerb

' Create objects
Set objShell = CreateObject("Shell.Application")
Set objFSO = CreateObject("Scripting.FileSystemObject")

' Get the installation directory from MSI CustomActionData
' CustomActionData should be set to the installation directory
scriptDir = CustomActionData
If scriptDir = "" Then
    ' Fallback: try to get from registry or use default path
    scriptDir = "C:\Program Files\TruckDoc"
End If

' Construct the full path to the executable
exePath = scriptDir & "\WpfTruckDoc.exe"

' Check if the executable exists
If Not objFSO.FileExists(exePath) Then
    ' Log error (could write to event log if needed)
    WScript.Quit(1) ' Return error code
End If

' Get the folder and file item
On Error Resume Next
Set objFolder = objShell.NameSpace(scriptDir)
If Err.Number <> 0 Then
    WScript.Quit(1) ' Return error code
End If

Set objFolderItem = objFolder.ParseName("WpfTruckDoc.exe")
If Err.Number <> 0 Then
    WScript.Quit(1) ' Return error code
End If

' Get the verbs (context menu options)
Set colVerbs = objFolderItem.Verbs
If Err.Number <> 0 Then
    WScript.Quit(1) ' Return error code
End If

On Error GoTo 0

' Look for the "Pin to taskbar" verb
For Each objVerb in colVerbs
    If objVerb.Name = "Pin to tas&kbar" Then
        objVerb.DoIt
        WScript.Quit(0) ' Success
    ElseIf objVerb.Name = "Unpin from tas&kbar" Then
        ' Already pinned - this is success
        WScript.Quit(0) ' Success
    End If
Next

' If we get here, the pin operation failed
WScript.Quit(1) ' Error code
