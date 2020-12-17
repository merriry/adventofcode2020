$ErrorActionPreference = "silentlycontinue"
Remove-Variable *


$position = @(0,0)
$waypoint = @(10,1)
Get-Content .\day12input | ForEach-Object {
    if ($_ -match "^(\w)(\d+)") {
    switch ($matches.1) {
    "N" {$waypoint[1] += $matches.2}
    "E" {$waypoint[0] += $matches.2}
    "S" {$waypoint[1] -= $matches.2}
    "W" {$waypoint[0] -= $matches.2}
    "R" {1..($($matches.2)/90) | ForEach-Object {$waypoint = @($waypoint[1],-$waypoint[0])}}
    "L" {1..($($matches.2)/90) | ForEach-Object {$waypoint = @(-$waypoint[1],$waypoint[0])}}
    "F" {$position[0] += $waypoint[0] * $matches.2; $position[1] += $waypoint[1] * $matches.2 }
    }}
    }
    [math]::Abs($position[0]) + [math]::Abs($position[1])
