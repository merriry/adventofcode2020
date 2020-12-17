$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
[System.Collections.ArrayList]$bus = (Get-Content .\day13input)[1].Split(",")
[int64]$time = 0
[int64]$mult = 1
$bus | ForEach-Object {
    if ($_ -eq "x") {return}
    $remain = ($_ - $bus.IndexOf([string]$_)) % $_ + $(if ($_ - $bus.IndexOf([string]$_) -lt 0) {$_})
    while ($time % $_ - $remain -ne 0) { $time += $mult }
    $mult *= $_
    }
    $time