function Get-ProcessById
{
	    param ($ProcId)

	    Invoke-Expression -Command "Get-Process -Id $ProcId"
	    }
}
