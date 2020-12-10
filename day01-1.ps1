$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
$target = 0
$lead = 0
Get-Content .\day01input |
% {
[array]$number += [int]::parse($_)
}
$number = $number | Sort-Object
$end = $number.Count
$tail = $end
While ($target -eq 0) {
$tail -= 1
switch ($number[$lead] + $number[$tail]) {
   2020 {$target = $number[$lead] * $number[$tail];$number[$lead];$number[$tail];$break}
   {$_ -lt 2020}{$tail = $end; $lead += 1; break}
}
}
$target