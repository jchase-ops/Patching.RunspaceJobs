# .ExternalHelp $PSScriptRoot\Initialize-RunspacePool-help.xml
function Initialize-RunspacePool {

    [CmdletBinding()]

    Param (

        [Parameter(Position = 0)]
        [ValidateRange(0, 25)]
        [System.Int16]
        $MaxRunSpaces
    )

    if ($MaxRunSpaces) {
        if ($MaxRunSpaces -eq 0) {
            $script:Config.MaximumRunspaces = $script:Config.MinimumRunspaces
        }
        else {
            $script:Config.MaximumRunspaces = $MaxRunSpaces
        }
    }

    $hash = [System.Collections.Hashtable]::New()
    $count = 0
    do {
        $hash.Add("Runspace_${count}", @{ Completed = 0; Total = $null })
        $count++
    } while ($count -lt $script:Config.MaximumRunspaces)
    $script:Config.ProgressHash = [System.Collections.Hashtable]::Synchronized($hash)
    $SessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
    $rsVariableEntry = [System.Management.Automation.Runspaces.SessionStateVariableEntry]::New('Sync', $script:Config.ProgressHash, 'Synchronized Hashtable')
    $SessionState.Variables.Add($rsVariableEntry)
    $script:Config.RunspacePool = [RunspaceFactory]::CreateRunspacePool($script:Config.MinimumRunspaces, $script:Config.MaximumRunspaces, $SessionState, $Host)
    $script:Config.RunspacePool.Open()
    $script:Config.ProgressHash
}
