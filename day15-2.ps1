$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
$totalrounds = 30000000
$nums = @(-1) * $totalrounds
$round = 0
$last = 0
[int[]](Get-Content .\day15input).Split(",") | foreach { $nums[$_] = $round; $last = $_; $round +=1}
$nums[$last] = -1
$round -= 1
do {
    if ($nums[$last] -eq -1) { $newlast = 0}
    else { $newlast = $round - $nums[$last]}
    $nums[$last] = $round
    $last = $newlast
    $round += 1
} while ($round -lt $totalrounds)
[array]::IndexOf($nums, $round-1)
