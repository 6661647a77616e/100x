# Load .NET to interact with user32.dll
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Win32API {
    // Importing ExitWindowsEx function from user32.dll
    [DllImport("user32.dll")]
    public static extern bool ExitWindowsEx(uint uFlags, uint dwReason);
}
"@

# Shutdown the system
$uFlags = 0x00000001 # EWX_SHUTDOWN
$dwReason = 0x00000000 # SHTDN_REASON_MAJOR_OTHER
[Win32API]::ExitWindowsEx($uFlags, $dwReason)
Write-Host "System is shutting down..."
