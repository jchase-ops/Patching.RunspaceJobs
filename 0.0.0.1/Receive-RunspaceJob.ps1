# .ExternalHelp $PSScriptRoot\Receive-RunspaceJob-help.xml
function Receive-RunspaceJob {

    [CmdletBinding()]

    Param (

        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[System.Object]]
        $RunningJobs = $script:Config.RunningJobs,

        [Parameter(Position = 1)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable]
        $Sync = $script:Config.ProgressHash,

        [Parameter(Position = 2)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Activity,

        [Parameter()]
        [Switch]
        $Quiet
    )

    $windowVisible = if ($(Get-Process -Id $([System.Diagnostics.Process]::GetCurrentProcess().Id)).MainWindowHandle -eq 0) { $false } else { $true }

    if ($windowVisible -and !($Quiet)) {
        Write-Host ''
        Write-Host 'Processing Jobs'
        $TotalJobs = ($Sync.Values.Total | Measure-Object -Sum).Sum
    }

    while ($RunningJobs.Count -gt 0) {
        if ($windowVisible -and !($Quiet)) {
            if ($null -eq $Activity -or $Activity -eq '') {
                $Activity = 'Receiving Jobs'
            }
            $jobCount = ($Sync.Values.Completed | Measure-Object -Sum).Sum
            Show-RunspaceJobProgress -JobCount $jobCount -TotalJobs $TotalJobs -Activity $Activity
        }
        For ($i = $RunningJobs.Count - 1; $i -ge 0; $i--) {
            $job = $RunningJobs[$i]
            if ($job.Handle.IsCompleted) {
                $job.PowerShell.EndInvoke($job.Handle)
                $job.PowerShell.Dispose()
                [void]$RunningJobs.Remove($job)
            }
        }
        Start-Sleep -Seconds 1
    }

    if ($windowVisible -and !($Quiet)) {
        if ($null -eq $Activity -or $Activity -eq '') {
            $Activity = 'Receiving Jobs'
        }
        Write-Progress -Activity $Activity -Id 0 -Completed
    }

    $script:Config.RunspacePool.Close()
}
