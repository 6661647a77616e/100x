# Load .NET to interact with kernel32.dll
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Win32API {
    // Importing GetVersionEx function from kernel32.dll
    [DllImport("kernel32.dll")]
    public static extern bool GetVersionEx(ref OSVERSIONINFO osvi);

    // Define OSVERSIONINFO structure
    [StructLayout(LayoutKind.Sequential)]
    public struct OSVERSIONINFO {
        public int dwOSVersionInfoSize;
        public int dwMajorVersion;
        public int dwMinorVersion;
        public int dwBuildNumber;
        public int dwPlatformId;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 128)]
        public string szCSDVersion;
    }
}
"@

# Get Windows OS version
$osVersionInfo = New-Object Win32API+OSVERSIONINFO
$osVersionInfo.dwOSVersionInfoSize = [System.Runtime.InteropServices.Marshal]::SizeOf($osVersionInfo)

[Win32API]::GetVersionEx([ref]$osVersionInfo)

Write-Host "Operating System: Windows $($osVersionInfo.dwMajorVersion).$($osVersionInfo.dwMinorVersion)"
Write-Host "Build Number: $($osVersionInfo.dwBuildNumber)"
Write-Host "Service Pack: $($osVersionInfo.szCSDVersion)"
