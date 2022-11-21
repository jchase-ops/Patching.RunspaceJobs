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
# SIG # Begin signature block
# MIIFYQYJKoZIhvcNAQcCoIIFUjCCBU4CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUz7jvHKW0GvSzhxJAYR3A4kxX
# hbqgggMAMIIC/DCCAeSgAwIBAgIQFnL4oVNG56NIRjNfzwNXejANBgkqhkiG9w0B
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
# DAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUvfSKTVzVZbiWrkwVvEBRqM8Q
# 6AkwDQYJKoZIhvcNAQEBBQAEggEAh/BNwVg/2HvpgpjCLshmbhlyb79gjRDxfcE9
# n3vxfkH4A1difbwGRPhf5RX0QsXSm4P1EfcZHsiV7r3fJh69I5GRNsiE/4DK7yHy
# qTwT7C/Hajz0hWolSlsJ0cBH5/nhmbxnICKZ3/QkSfxfepvmNJberW1KCySjdyta
# bjqK/15orNhKDHmFv93HySPFx/9FZNNU61SXNatN19A/oAW5cRQxVZlHyAWy8xsX
# N13oINkfWukj8UKP9FONPEskcQfAYzD1kB0grVWhqkj7Q7Tbhk+CBael0RHYsz5a
# Tru5t4nEZqUXTP7gVq6eaX6vnFWfjCq57RL2LD9X5GzMkJWoBg==
# SIG # End signature block
