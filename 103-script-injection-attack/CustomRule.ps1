# CustomRules.ps1

# Define a custom rule
$Rule = @{
    # Rule name (should be unique)
    RuleName = 'AvoidUsingWriteHost'
    
    # Rule description
    Description = 'Using Write-Host is not recommended. Use Write-Output instead.'

    # Rule severity (can be Warning or Error)
    Severity = 'Warning'  
    
    # ScriptBlock to define the rule
    ScriptBlock = {
        param($Ast)

        # Find all Write-Host usages
        $WriteHostCalls = $Ast.FindAll({$_.Type -eq 'Command' -and $_.CommandName -eq 'Write-Host'}, $true)

        foreach ($Call in $WriteHostCalls) {
            # Create a diagnostic message for each instance
            New-Diagnostic -Message "Avoid using Write-Host." -Severity $Severity -Line $Call.Extent.StartLineNumber
        }
    }
}

# Add the rule to the rules collection
$Rules += $Rule

# You can add more rules in the same way