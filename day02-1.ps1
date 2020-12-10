$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
$count = 0
Get-Content .\day02input | ForEach-Object {
    $_ -match '(\d+)-(\d+) (.): (.+)' | out-null
    $counter =($matches[4].ToCharArray() | Where-Object {$_ -eq $matches.3} | Measure-Object).Count
    if ($counter -ge [int]$matches.1 -and $counter -le [int]$matches.2) {
    $count +=1
    }
}
$count