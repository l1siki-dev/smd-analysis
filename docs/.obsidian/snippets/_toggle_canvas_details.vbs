Set fso = CreateObject("Scripting.FilesystemObject")
Set shell = CreateObject("WScript.Shell")

' Set working directory to script location
scriptPath = fso.GetParentFolderName(WScript.ScriptFullName)
shell.CurrentDirectory = scriptPath

targetFile = "canvas-toggle.css"

' Check current state: If file doesn't exist or is small, we assume "Show" mode
isShowing = True
If fso.FileExists(targetFile) Then
    If fso.GetFile(targetFile).Size > 50 Then
        isShowing = False
    End If
End If

If isShowing Then
    ' --- SWITCH TO HIDE MODE ---
    cssContent = "/* 1. Kill the body content */ " & vbCrLf & _
                 ".canvas-node-content-block, .canvas-node-content.markdown-embed, .markdown-preview-view { " & vbCrLf & _
                 "    display: none !important; " & vbCrLf & _
                 "} " & vbCrLf & _
                 "/* 2. Center title, wrap text, and fix color */ " & vbCrLf & _
                 ".canvas-node-label { " & vbCrLf & _
                 "    position: absolute !important; " & vbCrLf & _
                 "    top: 50% !important; " & vbCrLf & _
                 "    left: 50% !important; " & vbCrLf & _
                 "    transform: translate(-50%, -50%) !important; " & vbCrLf & _
                 "    width: 90% !important; " & vbCrLf & _
                 "    display: flex !important; " & vbCrLf & _
                 "    justify-content: center !important; " & vbCrLf & _
                 "    align-items: center !important; " & vbCrLf & _
                 "    text-align: center !important; " & vbCrLf & _
                 "    white-space: normal !important; " & vbCrLf & _
                 "    font-size: 2.2em !important; " & vbCrLf & _
                 "    font-weight: bold !important; " & vbCrLf & _
                 "    color: var(--text-normal) !important; " & vbCrLf & _
                 "    opacity: 1 !important; " & vbCrLf & _
                 "    background: transparent !important; " & vbCrLf & _
                 "    margin: 0 !important; " & vbCrLf & _
                 "    padding: 0 !important; " & vbCrLf & _
                 "} " & vbCrLf & _
                 "/* 3. Remove icons */ " & vbCrLf & _
                 ".canvas-node-label-icon { display: none !important; }"
Else
    ' --- SWITCH TO SHOW MODE ---
    cssContent = "/* Details Shown */"
End If

' Write the chosen state to the file
Set outFile = fso.CreateTextFile(targetFile, True)
outFile.Write cssContent
outFile.Close