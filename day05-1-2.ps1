$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
$seatarray = @()

function partitionfunc ($part, $low, $high) {
    if ($part.length -eq 0) {Return $low}
    switch -regex ($part[0]) {
        "[F|L]" {partitionfunc $part.substring(1,$part.length-1) $low ([int][Math]::Floor(($high-$low)/2)+$low)}
        "[B|R]" {partitionfunc $part.substring(1,$part.length-1) ([int][Math]::Ceiling(($high-$low)/2)+$low) $high}
        }
}

Get-Content .\day05input | foreach {
$seatarray +=, ((partitionfunc $_.substring(0,7) 0 127) * 8 + (partitionfunc $_.substring(7,3) 0 7))
}
$seatarray | foreach {
if (($_ + 1 -notin $seatarray) -and ($_ + 2 -in $seatarray)) { write-host ($_+1);return}     
}
($seatarray | Measure-Object -Maximum).maximum
