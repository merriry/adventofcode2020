$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
$file = Get-Content .\day13input
[System.Collections.ArrayList]$bus = $file[1].Split(",")
[int64]$time = 0
[int64]$mult = 1
$bus | ForEach-Object {
    
    if ($_ -eq "x") {return}
    $remain = ($_ - $bus.IndexOf([string]$_)) % $_
    if ($remain -lt 0) {$remain += $_}
    while ($time % $_ - $remain -ne 0) {
        $time += $mult
    }
    $mult *= $_
    }
    $time