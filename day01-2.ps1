﻿$ErrorActionPreference = "silentlycontinue"
Remove-Variable *

Get-Content .\day01input |
% {
[array]$number += [int]::parse($_)
}
$number = $number | Sort-Object -Descending
foreach ($first in $number) {
   $lead = 2020-$first
   $possnumber = $number | where {$_ -le $lead}
   foreach ($second in $possnumber) {
      if ($number.Contains((2020 - $first - $second))) {
           $target = (2020-$first -$second) * $first * $second
      }
   }
}
$target