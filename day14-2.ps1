$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
[int64]$total = 0
$memlocations = New-Object System.Collections.Hashtable

function get-memlocations ($bitmask, $memloc, $value, $location) {
    if ($location -eq 36) {return @{([convert]::ToInt64(($memloc -join ""),2)) = $value }}
    if ($bitmask[$location] -eq "X") {
        $memloc[$location] = "0"
        get-memlocations $bitmask $memloc $value ($location + 1)
        $memloc[$location] = "1"
        get-memlocations $bitmask $memloc $value ($location + 1)
    }
    elseif ($bitmask[$location] -eq "0") {get-memlocations $bitmask $memloc $value ($location + 1)}
    else {
        $memloc[$location] = "1"
        get-memlocations $bitmask $memloc $value ($location + 1)
    }
}

Get-Content .\day14input | foreach {
    if ($_.substring(0,4) -eq "mask") {
        $currmask = $_.substring(7,36).tochararray()
        return
    }
    $memloc = New-Object System.Collections.Hashtable
    $_ -match "\w+\[(\d+)] = (\d+)" | out-null
    $currnum = [convert]::ToString($matches.1,2).padleft(36,"0").tochararray()
    get-memlocations $currmask $currnum $matches.2 0 | foreach { $memloc = $memloc + $_}
    $memloc.keys | foreach {
        if($memlocations.keys -contains $_) {$memlocations[[int64]$_] = $memloc[[int64]$_];return}
        $memlocations.Add([int64]$_,$memloc[[int64]$_]) | out-null
    }
}
$memlocations.Values | Measure-Object -Sum