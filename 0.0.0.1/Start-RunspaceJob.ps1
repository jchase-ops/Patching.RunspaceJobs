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
# SIG # Begin signature block
# MIIFYQYJKoZIhvcNAQcCoIIFUjCCBU4CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUFddIXwSABGWoZo1aJJdYW1b1
# H0KgggMAMIIC/DCCAeSgAwIBAgIQFnL4oVNG56NIRjNfzwNXejANBgkqhkiG9w0B
# AQUFADAWMRQwEgYDVQQDDAtDZXJ0LTAzNDU2MDAeFw0yMTEyMDIwNDU5MTJaFw0y
# MjEyMDIwNTE5MTJaMBYxFDASBgNVBAMMC0NlcnQtMDM0NTYwMIIBIjANBgkqhkiG
# 9w0BAQEFAAOCAQ8AMIIBCgKCAQEA8daSAcUBI0Xx8sMMlSpsCV+24lY46RsxX8iC
# bB7ZM19b/GBjwMo0TCb28ssbZ/P8liNJICrSbyIkQDrIrjqtAdyAPdPAYHONTHad
# 0fuOQQT5MkO5HAxUYLz/6H/xq92lKQFxz5Wgzw+3KOyignY8V8ZZ379z/WqQbNCV
# +29zb9YWOK7eXQ9x8s4+SOizqUE3zkOuijf86I9vZmzMYhsxE7if0R0UlQsLlvTA
# kH/m4IjHem8rl/kC+O71lU7l9475XrUUR3Fxebqh9YoCEZh2eE81TLQcnvK8zgqP
# F+X4INdNPD6zO4T1Nbz0Ccev7mj37+pk/eL5R5aV+NJgqAzhvQIDAQABo0YwRDAO
# BgNVHQ8BAf8EBAMCBaAwEwYDVR0lBAwwCgYIKwYBBQUHAwMwHQYDVR0OBBYEFFNN
# e4x6JSqbcnTR354fVSEgQ0VYMA0GCSqGSIb3DQEBBQUAA4IBAQBXfA8VgaMD2c/v
# Sv8gnS/LWri51BBqcUFE9JYMxEIzlEt2ZfJsG+INaQqzBoyCDx/oMQH7wdFRvDjQ
# QsXpNTo7wH7WytFe9KJrOz2uGG0EnIYHK0dTFIMVOcM9VsWWPG40EAzD//55xX/d
# pBL+L4SSTujbR3ptni8Agu5GiRhTpxwl1L/HLC2QYYMoUKiAxL1p61+cHRj6wMzl
# jxnrMIcBhKioaXnwWdKPCN66Jk8IYdqr8afcRYiwtDi+8Hk2/9nB9HwPox3Dtf8H
# jH0O2/8NiJTeOBFSfrWPM9r4j4NWR8IuLwsqHUfXJEQa9SOxhHvxaNMR/Fhq1GVj
# qUClZiXiMYIByzCCAccCAQEwKjAWMRQwEgYDVQQDDAtDZXJ0LTAzNDU2MAIQFnL4
# oVNG56NIRjNfzwNXejAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAA
# oQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4w
# DAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQU8dXDsD24m/YpThMxpDaNPcmW
# AqEwDQYJKoZIhvcNAQEBBQAEggEAPepT2O5UoufHzmD9KXPtScP/UWrjSqG3iPbr
# 4DzVklreGvKzzUTDFaMhdvmEtg8wLA3lDoiXM1Pg1ELZOWmApREOqviZ7Emnorn/
# BBHxlhSf/4J4IBEygjDi0Cp4nhnwPau0934zNhLT4kCptZgTJEvTcGuKvTff6oYi
# jNWWPlKBcrqu/UGgMjILN4sHgfvTlu7A2XvIwlIuzgmIk5slTp8kHWo3pi3rHxu7
# vWAUvV9mkY6rzEBMsCnXHCJvApz9p4O3/ybdHuRDEsveDq4prHrve3C+bVN7gtbx
# rA1HqhR519b8Ew2iXfmFluFWcuB0cSxYOnlqEuv2u8DCKdbZ9A==
# SIG # End signature block
