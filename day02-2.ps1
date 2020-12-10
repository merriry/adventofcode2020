$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
$count = 0
Get-Content .\day02input | ForEach-Object {
    $_ -match '(\d+)-(\d+) (.): (.+)' | out-null
    if (($matches[4][[int]$matches[1]-1] -eq $matches.3) -xor ($matches[4][[int]$matches[2]-1] -eq $matches.3)) {
    $count +=1
    }
}
$count