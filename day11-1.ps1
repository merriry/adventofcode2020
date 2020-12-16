$ErrorActionPreference = "silentlycontinue"
Remove-Variable *

$seats = New-Object -TypeName "System.Collections.ArrayList"
$seatsworking = New-Object -TypeName "System.Collections.ArrayList"

function check-seat ($seatcheck, $rowcheck, $colcheck) {
    $count = 0
    if ($seatcheck[$rowcheck][$colcheck] -eq ".") {return "."}
    if (($rowcheck - 1 -ge 0) -and ($colcheck - 1 -ge 0)                                     -and ($seatcheck[$rowcheck - 1][$colcheck - 1] -eq "#")) { $count +=1} # -1 -1
    if (($rowcheck - 1 -ge 0)                                                                -and ($seatcheck[$rowcheck - 1][$colcheck] -eq "#"))     { $count +=1} # -1  0
    if (($rowcheck - 1 -ge 0) -and ($colcheck + 1 -lt $seatcheck[$row].count)                -and ($seatcheck[$rowcheck - 1][$colcheck + 1] -eq "#")) { $count +=1} # -1 +1
    if (($colcheck - 1 -ge 0)                                                                -and ($seatcheck[$rowcheck][$colcheck - 1] -eq "#"))     { $count +=1} #  0 -1
    if (($colcheck + 1 -lt $seatcheck[$row].count)                                           -and ($seatcheck[$rowcheck][$colcheck + 1] -eq "#"))     { $count +=1} #  0 +1
    if (($rowcheck + 1 -lt $seatcheck.count) -and ($colcheck - 1 -ge 0)                      -and ($seatcheck[$rowcheck + 1][$colcheck - 1] -eq "#")) { $count +=1} # +1 -1
    if (($rowcheck + 1 -lt $seatcheck.count)                                                 -and ($seatcheck[$rowcheck + 1][$colcheck] -eq "#"))     { $count +=1} # +1  0
    if (($rowcheck + 1 -lt $seatcheck.count) -and ($colcheck + 1 -lt $seatcheck[$row].count) -and ($seatcheck[$rowcheck + 1][$colcheck + 1] -eq "#")) { $count +=1} # +1 +1
    if ($count -ge 4 -and ($seatcheck[$rowcheck][$colcheck] -eq "#")) { return "L" }
    if ($count -eq 0 -and ($seatcheck[$rowcheck][$colcheck] -eq "L")) { return "#" }
    return $seatcheck[$rowcheck][$colcheck]
 
     }

Get-Content .\day11input | ForEach-Object {$seats.add(@($_.tochararray()))|out-null}
$seats | ForEach-Object { $seatsworking.add(@($_)) |out-null }
$changed = $false
do {
$changed = $false
ForEach ($row in 0..($seats.count - 1)) {
    foreach ($col in 0..($seats[$row].count -1)) {
        $seatsworking[$row][$col] = check-seat $seats $row $col
        if($seatsworking[$row][$col] -ne $seats[$row][$col]) {$changed = $true}
        }

} 
    $seats.Clear()
    $seatsworking | ForEach-Object { $seats.add(@($_)) |out-null }

} while ($changed)
$counts = 0
$seats |% { $_ | % {if ($_ -eq "#") {$counts +=1}}}
$counts
