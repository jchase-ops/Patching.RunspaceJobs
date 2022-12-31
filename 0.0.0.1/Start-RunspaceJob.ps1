# .ExternalHelp $PSScriptRoot\Start-RunspaceJob-help.xml
function Start-RunspaceJob {

    [CmdletBinding()]

    Param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [System.Int16]
        $ID,

        [Parameter(Mandatory, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.ScriptBlock]
        $ScriptBlock,

        [Parameter(Mandatory, Position = 2)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable]
        $ParameterHash,

        [Parameter(Position = 3)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.Runspaces.RunspacePool]
        $RunspacePool = $script:Config.RunspacePool
    )

    $script:Config.RunningJobs = [System.Collections.Generic.List[System.Object]]::New()

    $job = [PowerShell]::Create()
    $job.RunspacePool = $RunspacePool

    if ($ScriptBlock) {
        [void]$job.AddScript($ScriptBlock)
    }

    if ($ParameterHash) {
        [void]$job.AddParameters($ParameterHash)
    }

    [void]$script:Config.RunningJobs.Add($([PSCustomObject]@{
                ID         = $ID
                Thread     = [AppDomain]::GetCurrentThreadId()
                ProcessID  = $PID
                PowerShell = $job
                Handle     = $job.BeginInvoke()
    }))
}
