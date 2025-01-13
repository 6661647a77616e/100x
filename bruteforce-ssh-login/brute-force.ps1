
# URLs to the raw text files
$usernameUrl = "https://raw.githubusercontent.com/pentestmonkey/yaptest/refs/heads/master/ssh-usernames.txt"
$passwordUrl = "https://raw.githubusercontent.com/pentestmonkey/yaptest/refs/heads/master/ssh-usernames.txt" 

# Download and store the data
$usernames = Invoke-WebRequest -Uri $usernameUrl -UseBasicParsing | Select-Object -ExpandProperty Content
$passwords = Invoke-WebRequest -Uri $passwordUrl -UseBasicParsing | Select-Object -ExpandProperty Content

# Split the content into arrays
$usernameList = $usernames -split "`n"  # Split by newline
$passwordList = $passwords -split "`n"

# Loop through usernames and passwords
foreach ($username in $usernameList) {
    foreach ($password in $passwordList) {
        # Replace this section with your logic for handling username and password
        Write-Output "Trying username: $username with password: $password"

        # Example SSH command (for testing connection, not brute-forcing!)
        # ssh $username@hostname "some-command" -Password $password
    }
}
