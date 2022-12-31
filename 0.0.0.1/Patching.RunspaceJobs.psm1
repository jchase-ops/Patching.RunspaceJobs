# Patching.RunspaceJobs Module

#region Classes
################################################################################
#                                                                              #
#                                 CLASSES                                      #
#                                                                              #
################################################################################
# . "$PSScriptRoot\$(Split-Path -Path $(Split-Path -Path $PSScriptRoot -Parent) -Leaf).Classes.ps1"
#endregion

#region Variables
################################################################################
#                                                                              #
#                               VARIABLES                                      #
#                                                                              #
################################################################################
try {
    $script:Config = Import-Clixml -Path "$PSScriptRoot\config.xml" -ErrorAction Stop
}
catch {
    $script:Config = [ordered]@{
        MinimumRunspaces = 1
        MaximumRunspaces = 5
        ProgressHash = $null
        RunningJobs = [System.Collections.Generic.List[System.Object]]::New()
        RunspacePool = $null
    }
    $script:Config | Export-Clixml -Path "$PSScriptRoot\config.xml" -Depth 100
}
#endregion

#region DotSourcedScripts
################################################################################
#                                                                              #
#                           DOT-SOURCED SCRIPTS                                #
#                                                                              #
################################################################################
. "$PSScriptRoot\Initialize-RunspacePool.ps1"
. "$PSScriptRoot\Start-RunspaceJob.ps1"
. "$PSScriptRoot\Receive-RunspaceJob.ps1"
. "$PSScriptRoot\Show-RunspaceJobProgress.ps1"
#endregion

#region ModuleMembers
################################################################################
#                                                                              #
#                              MODULE MEMBERS                                  #
#                                                                              #
################################################################################
Export-ModuleMember -Function Initialize-RunspacePool
Export-ModuleMember -FUnction Start-RunspaceJob
Export-ModuleMember -Function Receive-RunspaceJob
Export-ModuleMember -Function Show-RunspaceJobProgress
#endregion
