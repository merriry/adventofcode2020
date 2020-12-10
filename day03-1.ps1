$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
$count = 0
$hloc = 0
Get-Content .\day03input | ForEach-Object {
    if($_[$hloc] -eq "#") {
    $count +=1
    }
    $hloc = ($hloc + 3) % $_.length
}
$count