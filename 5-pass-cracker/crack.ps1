# Function to test if the password matches the target
Function Test-Password {
    Param(
        [String]$Password,
        [String]$TargetPassword
    )

    # Compare the password with the target
    if ($Password -eq $TargetPassword) {
        return $true
    }
    return $false
}

# Character sets
$UpperCase = @('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z')
$LowerCase = @('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z')
$Numbers = @('1','2','3','4','5','6','7','8','9','0')
$Symbols = @('!','@','$','?','<','>','*','&')

# Combine all characters into a single set
$Charset = $UpperCase + $LowerCase + $Numbers + $Symbols

# Set maximum password length
$MaxDepth = 8

# Define the target password for comparison
$TargetPassword = "a"

# Initialize combinations
$combinations = @("")
for ($depth = 1; $depth -le $MaxDepth; $depth++) {
    $newCombinations = @()
    foreach ($combination in $combinations) {
        foreach ($char in $Charset) {
            $newCombination = $combination + $char

            # Test the new password
            if (Test-Password -Password $newCombination -TargetPassword $TargetPassword) {
                Write-Host "Password Found: $newCombination"
                Exit
            }

            $newCombinations += $newCombination
        }
    }
    $combinations = $newCombinations
}

Write-Host "Password not found within $MaxDepth characters."
