# Specify the path to the binary file
$binaryFilePath = "C:\Users\fadzw\Downloads\ICE\100x\binary.txt"

# Check if the file exists
if (Test-Path $binaryFilePath) {
    # Read the binary content
    $binaryContent = [System.IO.File]::ReadAllBytes($binaryFilePath)

    # Convert the binary content to a string
    $commandString = [System.Text.Encoding]::UTF8.GetString($binaryContent)

    Write-Host "Command String: $commandString"

    # Convert binary strings to actual characters
    $binaryCommands = $commandString -split ' ' | ForEach-Object {
        [char]([convert]::ToInt32($_, 2))
    }

    # Join the characters into a single command string
    $finalCommandString = -join $binaryCommands

    # Output the final command for verification
    Write-Host "Final Command String: $finalCommandString"

    # Execute the command string (make sure it is safe to execute)
    Invoke-Expression $finalCommandString
} else {
    Write-Host "File not found: $binaryFilePath"
}