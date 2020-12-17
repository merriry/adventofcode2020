$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
$file = Get-Content .\day13input
$minstart = $time = [int]$file[0]
[System.Collections.ArrayList]$bus = $file[1].Split(",") |where {$_ -ne "x"}
$bus | ForEach-Object { if ($_ - ($minstart % $_) -lt $time) {$time = $_ - ($minstart % $_); $busno = $_ }}
$time * $busno