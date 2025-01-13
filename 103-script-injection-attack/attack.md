https://learn.microsoft.com/en-us/powershell/scripting/security/preventing-script-injection?view=powershell-7.4

function Get-ProcessById
{
    param ($ProcId)

Invoke-Expression -Command "Get-Process -Id $ProcId"
}


Get-ProcessById $pid


Get-ProcessById "$pid; Write-Host 'pwnd!'"

used typed input to  prevent injection attack

function Get-ProcessById
{
    param ([int] $ProcId)

Invoke-Expression -Command "Get-Process -Id $ProcId"
}
Get-ProcessById "$pid; Write-Host 'pwnd!'"


```powershell
$RulePath = "C:\Path\To\Your\CustomRules.ps1"
```


Example CustomRule
```powershell
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
```

another example
```powershell
# Enforce Cmdlet Usage
$Rule = @{
    RuleName = 'AvoidUsingAliases'
    Description = 'Use full cmdlet names instead of aliases.'
    Severity = 'Warning'
    ScriptBlock = {
        param($Ast)

        # Find all alias usages
        $AliasCalls = $Ast.FindAll({$_.Type -eq 'Command' -and $_.CommandName -in @('ls', 'dir', 'gc')}, $true)

        foreach ($Call in $AliasCalls) {
            New-Diagnostic -Message "Avoid using aliases like $($Call.CommandName)." -Severity $Severity -Line $Call.Extent.StartLineNumber
        }
    }
}

$Rules += $Rule
```




PS C:\Users\fadzw\Downloads\ICE\100x\4-script-injection-attack> Invoke-ScriptAnalyzer -CustomRulePath $RulePath -Path .\Invoke-Dangerous.ps1

here are some output

```powershell
WARNING: Cannot find rule extension
'C:\Users\fadzw\Downloads\ICE\100x\4-script-injection-attack\CustomRule.ps1'.
Invoke-ScriptAnalyzer : Exception of type 'System.Exception' was thrown.
At line:1 char:1
+ Invoke-ScriptAnalyzer -CustomRulePath $RulePath -Path .\Invoke-Danger ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ResourceExists: (Microsoft.Windo....ScriptAnalyzer:S
   criptAnalyzer) [Invoke-ScriptAnalyzer], Exception
    + FullyQualifiedErrorId : Cannot find ScriptAnalyzer rules in the specified pa
   th,Microsoft.Windows.PowerShell.ScriptAnalyzer.Commands.InvokeScriptAnalyzerCo
  mmand
```


Here are output for other code 

```powershell
PS C:\Users\fadzw\Downloads\ICE\100x\4-script-injection-attack> .\wrap-strings.ps1
At C:\Users\fadzw\Downloads\ICE\100x\4-script-injection-attack\wrap-strings.ps1:9
char:1
+ }
+ ~
Unexpected token '}' in expression or statement.
    + CategoryInfo          : ParserError: (:) [], ParseException
    + FullyQualifiedErrorId : UnexpectedToken

PS C:\Users\fadzw\Downloads\ICE\100x\4-script-injection-attack> .\Invoke-Dangerous.ps1
At
C:\Users\fadzw\Downloads\ICE\100x\4-script-injection-attack\Invoke-Dangerous.ps1:7
char:1
+ }
+ ~
Unexpected token '}' in expression or statement.
    + CategoryInfo          : ParserError: (:) [], ParseException
    + FullyQualifiedErrorId : UnexpectedToken

PS C:\Users\fadzw\Downloads\ICE\100x\4-script-injection-attack> .\escape-single-quote.ps1
At C:\Users\fadzw\Downloads\ICE\100x\4-script-injection-attack\escape-single-quote.
ps1:10 char:1
+ }
+ ~
Unexpected token '}' in expression or statement.
    + CategoryInfo          : ParserError: (:) [], ParseException
    + FullyQualifiedErrorId : UnexpectedToken
```
