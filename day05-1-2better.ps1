$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
$seatarray = @()


Get-Content .\day05input | foreach {
$seatarray +=, ([convert]::ToInt32($_.substring(0,7).replace("F","0").replace("B","1"),2) * 8 + [convert]::ToInt32($_.substring(7,3).replace("L","0").replace("R","1"),2))
}

$seatarray | ForEach-Object {
if (($_ + 1 -notin $seatarray) -and ($_ + 2 -in $seatarray)) { write-host ($_+1);return}     
}
$seatarray | Measure-Object -Maximum