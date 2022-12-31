# .ExternalHelp $PSScriptRoot\Show-RunspaceJobProgress-help.xml
function Show-RunspaceJobProgress {

    [CmdletBinding()]

    Param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [System.Int16]
        $JobCount,

        [Parameter(Mandatory, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [System.Int16]
        $TotalJobs,

        [Parameter(Mandatory, Position = 2)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Activity
    )

    $params = @{}
    $params.Id = 0
    $params.Activity = $Activity
    $params.Status = "Completed: {0}/{1}" -f $JobCount, $TotalJobs
    $params.PercentComplete = (($JobCount / $TotalJobs) * 100)
    $params.CurrentOperation = 'Checking Job Status'

    Write-Progress @params
}
