# Load .NET to interact with comdlg32.dll
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Win32API {
    // Importing GetOpenFileName function from comdlg32.dll
    [DllImport("comdlg32.dll", CharSet = CharSet.Auto)]
    public static extern bool GetOpenFileName([In, Out] OPENFILENAME ofn);

    // Define OPENFILENAME structure
    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Auto)]
    public struct OPENFILENAME {
        public int lStructSize;
        public IntPtr hwndOwner;
        public IntPtr hInstance;
        public string lpstrFilter;
        public string lpstrCustomFilter;
        public int nMaxCustFilter;
        public int nFilterIndex;
        public string lpstrFile;
        public int nMaxFile;
        public string lpstrFileTitle;
        public int nMaxFileTitle;
        public string lpstrInitialDir;
        public string lpstrTitle;
        public int Flags;
        public short nFileOffset;
        public short nFileExtension;
        public string lpstrDefExt;
        public IntPtr lCustData;
        public IntPtr lpfnHook;
        public string lpTemplateName;
    }
}
"@

# Show Open File Dialog
$fileDialog = New-Object Win32API+OPENFILENAME
$fileDialog.lStructSize = [System.Runtime.InteropServices.Marshal]::SizeOf($fileDialog)
$fileDialog.nMaxFile = 256
$fileDialog.lpstrFile = New-Object -TypeName "System.Text.StringBuilder" -ArgumentList 256
$fileDialog.lpstrFilter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"

$success = [Win32API]::GetOpenFileName([ref]$fileDialog)

if ($success) {
    Write-Host "Selected file: $($fileDialog.lpstrFile)"
} else {
    Write-Host "No file selected."
}
