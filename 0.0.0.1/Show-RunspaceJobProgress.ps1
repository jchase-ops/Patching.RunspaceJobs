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
# SIG # Begin signature block
# MIIFYQYJKoZIhvcNAQcCoIIFUjCCBU4CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUXXdpXXe7a136nNBHFYlKAWkQ
# g1KgggMAMIIC/DCCAeSgAwIBAgIQFnL4oVNG56NIRjNfzwNXejANBgkqhkiG9w0B
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
# DAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUPQ1Ackws2We4TDXNJigq7sLc
# rQkwDQYJKoZIhvcNAQEBBQAEggEAd0JbGjOXr2nh/fTBfXSG0BBWA1RwxEkPdV7M
# MOmnP+m3Zc/Adt6ko10kmQ89MSAc6UySMa/u6aK4WHFlGmFOhPUF/CBn/bxeJul4
# z676RViP/T89cvVVtAncz8qMvZUM9Mq2KcWBJQLumUnVoz6lCkbMpON95eqBeKzW
# bMb5B+Tgwm/EjUafCulihmqdWATK9NxUKdkdn8kRuX5Bc8tbF0o/PW7Pnq7Tw6zz
# 7lW9CZ3/3Rxvc2dxRM7AkDAn4T9pq9VzLScyGdFDkAHd88CyzT3NPENsmPVVgpFm
# BHd+rrqf5GUOobOmAOW2GY3DGfAuGIT4IfprMhDn//jRWkGPHA==
# SIG # End signature block
