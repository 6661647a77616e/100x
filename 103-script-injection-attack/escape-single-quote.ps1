function Get-ProcessById
{
	    param ($ProcId)

	    $ProcIdClean = [System.Management.Automation.Language.CodeGeneration]::
	            EscapeSingleQuotedStringContent("$ProcId")
	                Invoke-Expression -Command "Get-Process -Id '$ProcIdClean'"
	                }
	                Get-ProcessById "$pid'; Write-Host 'pwnd!';'""'"
}
