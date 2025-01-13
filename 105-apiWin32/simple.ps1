# Load the necessary .NET assemblies
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Win32API {
    // Importing MessageBox function from user32.dll
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int MessageBox(IntPtr hWnd, String text, String caption, uint type);
}
"@

# Call the MessageBox API function to display a simple message box
[Win32API]::MessageBox([IntPtr]::Zero, "Hello from PowerShell!", "APIWin32 Test", 0)
