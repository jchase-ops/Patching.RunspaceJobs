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
# SIG # Begin signature block
# MIIFYQYJKoZIhvcNAQcCoIIFUjCCBU4CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUKKXlm4+eDl3j9uqSHlANj98z
# 0Y+gggMAMIIC/DCCAeSgAwIBAgIQFnL4oVNG56NIRjNfzwNXejANBgkqhkiG9w0B
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
# DAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUaPxHnGsmX2XtA5CHKFBU9qfm
# hXswDQYJKoZIhvcNAQEBBQAEggEA1fxIWe4esVisupqhdW+dqcmttMnjH4r2l5R9
# 9LV9ufggQG/TVFJaOReVgMLXWu3z6AXXlOrws3j2Kskao8c3vw7fLVi+AWKweTUI
# qoLFzzwFr0XGjZgZg/GuQDxRJ9Eg4IYJhdRIj4VQ0aUTNBjLKINlDgCnZpMCYteo
# U7naKCuEtaNH/T1Zf6gvsuOxDIWVYUyuq3pEBWabqoos1LGkO9Dv8Akijb8mqTpv
# YSwxbJD4FNCebRCCeggUiKiOBzAaFV9emMnXzamVCCoXvsvbeA4OiM89ACaYSRYb
# BGZeYiC3krlkwd9e+ijxHbR0COBbh7DzR+ys5MIcFj7SSN1BCA==
# SIG # End signature block
