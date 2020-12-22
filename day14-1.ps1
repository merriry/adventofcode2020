$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
[int64]$total = 0
$currmask
$memlocations = New-Object System.Collections.Hashtable
Get-Content .\day14input | foreach {
    if ($_.substring(0,4) -eq "mask") {
        $currmask = $_.substring(7,36).tochararray()
        return
        }
    $_ -match "\w+\[(\d+)] = (\d+)" | out-null
    $currnum = [convert]::ToString($matches.2,2).padleft(36,"0").tochararray()
    0..35 | foreach {
        if ($currmask[$_] -eq "X") {return}
        $currnum[$_] = $currmask[$_]
        }
        if ($memlocations.ContainsKey([int64]$matches.1)) {
            $memlocations[[int64]$matches.1] = [convert]::ToInt64(($currnum -join ""),2)
            return
            }
        $memlocations.Add([convert]::ToInt64($matches.1),([convert]::ToInt64(($currnum -join ""),2)))
        }
        $memlocations.values | Measure-Object -sum