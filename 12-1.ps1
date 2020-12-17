$ErrorActionPreference = "silentlycontinue"
Remove-Variable *


$position = @(0,0)
$facing = 1
$facings = @(@(-1,0), @(0,1), @(1,0), @(0,-1))
Get-Content .\day12input | ForEach-Object {
    if ($_ -match "^(\w)(\d+)") {
    switch ($matches.1) {
    "N" {$position[0] -= $matches.2}
    "E" {$position[1] += $matches.2}
    "S" {$position[0] += $matches.2}
    "W" {$position[1] -= $matches.2}
    "R" {$facing = ($facing + $($matches.2)/90) % 4}
    "L" {$facing = (($facing - $($matches.2)/90) % 4 + 4) % 4}
    "F" {$position[0] += $facings[$facing][0] * $matches.2; $position[1] += $facings[$facing][1] * $matches.2 }
    }}
    }
    [math]::Abs($position[0]) + [math]::Abs($position[1])
