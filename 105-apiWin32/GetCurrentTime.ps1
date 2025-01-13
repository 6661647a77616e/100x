# Load .NET to interact with kernel32.dll
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Win32API {
    // Importing GetSystemTime function from kernel32.dll
    [DllImport("kernel32.dll")]
    public static extern void GetSystemTime(ref SYSTEMTIME systemTime);

    // Define SYSTEMTIME structure
    [StructLayout(LayoutKind.Sequential)]
    public struct SYSTEMTIME {
        public ushort wYear;
        public ushort wMonth;
        public ushort wDayOfWeek;
        public ushort wDay;
        public ushort wHour;
        public ushort wMinute;
        public ushort wSecond;
        public ushort wMilliseconds;
    }
}
"@

# Get current system time
$systemTime = New-Object Win32API+SYSTEMTIME
[Win32API]::GetSystemTime([ref]$systemTime)

Write-Host "Current system time: $($systemTime.wYear)-$($systemTime.wMonth)-$($systemTime.wDay) $($systemTime.wHour):$($systemTime.wMinute):$($systemTime.wSecond)"
