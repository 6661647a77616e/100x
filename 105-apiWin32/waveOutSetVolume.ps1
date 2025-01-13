# Load .NET to interact with winapi.dll
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Win32API {
    // Importing waveOutSetVolume function from winapi.dll
    [DllImport("winapi.dll", SetLastError = true)]
    public static extern uint waveOutSetVolume(IntPtr hwo, uint dwVolume);
}
"@

# Set the volume level (0 to 0xFFFF)
$volume = 0x8000 # Set volume to half
[Win32API]::waveOutSetVolume([IntPtr]::Zero, $volume)
Write-Host "System volume set to $($volume)"
