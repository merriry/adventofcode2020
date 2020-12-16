$ErrorActionPreference = "silentlycontinue"
Remove-Variable *

$seats = New-Object -TypeName "System.Collections.ArrayList"
$seatsworking = New-Object -TypeName "System.Collections.ArrayList"
$seatslocation = New-Object -TypeName "System.Collections.ArrayList"

function check-seat ($seatcheck, $seatslocation, $rowcheck, $colcheck)
{
	$count = 0
	$seatarray = $seatslocation[$rowcheck][$colcheck]
	if ($seatcheck[$seatarray[0][0]][$seatarray[0][1]] -eq ".") { return "." }
    1..8 | foreach { if (($seatarray[$_][0] -ge 0) -and ($seatarray[$_][1] -ge 0) -and ($seatcheck[$seatarray[$_][0]][$seatarray[$_][1]] -eq "#")) { $count += 1 } }

	if ($count -ge 5 -and ($seatcheck[$rowcheck][$colcheck] -eq "#")) { return "L" }
	if ($count -eq 0 -and ($seatcheck[$rowcheck][$colcheck] -eq "L")) { return "#" }
	return $seatcheck[$rowcheck][$colcheck]
}

function find-seat ($seatcheck, $row, $col, $rowdir, $coldir)
{
	$row += $rowdir
	$col += $coldir
	if (($row -lt 0) -or ($row -ge $seatcheck.count) -or ($col -lt 0) -or ($col -ge $seatcheck[$row].count)) { return @(-1, -1) }
	if ($seatcheck[$row][$col] -eq "L") { return @($row, $col) }
	return (find-seat $seatcheck $row $col $rowdir $coldir)
}

Get-Content .\day11input | ForEach-Object { $seats.add(@($_.tochararray())) | out-null }
$seats | ForEach-Object { $seatsworking.add(@($_)) | out-null }
$seats | ForEach-Object { $seatslocation.add(@($_)) | out-null }
ForEach ($row in 0 .. ($seats.count - 1)) {
	foreach ($col in 0 .. ($seats[$row].count - 1)) {
		$seatslocation[$row][$col] = @(@($row, $col), 
            (find-seat $seats $row $col -1 -1), 
            (find-seat $seats $row $col -1 0), 
            (find-seat $seats $row $col -1 +1), 
            (find-seat $seats $row $col 0 -1), 
            (find-seat $seats $row $col 0 +1), 
            (find-seat $seats $row $col +1 -1), 
            (find-seat $seats $row $col +1 0), 
            (find-seat $seats $row $col +1 +1))
	}
} 

do {
$changed = $false
ForEach ($row in 0..($seats.count - 1)) {
    foreach ($col in 0..($seats[$row].count -1)) {
        $seatsworking[$row][$col] = check-seat $seats $seatslocation $row $col
        if(!$changed -and $seatsworking[$row][$col] -ne $seats[$row][$col]) {$changed = $true}
        }
} 
    $seats.Clear()
    $seatsworking | ForEach-Object { $seats.add(@($_)) |out-null }

} while ($changed) 
$counts = 0
$seats |% { $_ | % {if ($_ -eq "#") {$counts +=1}}}
$counts
