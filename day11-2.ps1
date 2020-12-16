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
	if (($seatarray[1][0] -ge 0) -and ($seatarray[1][1] -ge 0) -and ($seatcheck[$seatarray[1][0]][$seatarray[1][1]] -eq "#")) { $count += 1 } # -1 -1
	if (($seatarray[2][0] -ge 0) -and ($seatarray[2][1] -ge 0) -and ($seatcheck[$seatarray[2][0]][$seatarray[2][1]] -eq "#")) { $count += 1 } # -1  0
	if (($seatarray[3][0] -ge 0) -and ($seatarray[3][1] -ge 0) -and ($seatcheck[$seatarray[3][0]][$seatarray[3][1]] -eq "#")) { $count += 1 } # -1 +1
	if (($seatarray[4][0] -ge 0) -and ($seatarray[4][1] -ge 0) -and ($seatcheck[$seatarray[4][0]][$seatarray[4][1]] -eq "#")) { $count += 1 } #  0 -1
	if (($seatarray[5][0] -ge 0) -and ($seatarray[5][1] -ge 0) -and ($seatcheck[$seatarray[5][0]][$seatarray[5][1]] -eq "#")) { $count += 1 } #  0 +1
	if (($seatarray[6][0] -ge 0) -and ($seatarray[6][1] -ge 0) -and ($seatcheck[$seatarray[6][0]][$seatarray[6][1]] -eq "#")) { $count += 1 } # +1 -1
	if (($seatarray[7][0] -ge 0) -and ($seatarray[7][1] -ge 0) -and ($seatcheck[$seatarray[7][0]][$seatarray[7][1]] -eq "#")) { $count += 1 } # +1  0
	if (($seatarray[8][0] -ge 0) -and ($seatarray[8][1] -ge 0) -and ($seatcheck[$seatarray[8][0]][$seatarray[8][1]] -eq "#")) { $count += 1 } # +1 +1
	if ($count -ge 5 -and ($seatcheck[$rowcheck][$colcheck] -eq "#")) { return "L" }
	if ($count -eq 0 -and ($seatcheck[$rowcheck][$colcheck] -eq "L")) { return "#" }
	return $seatcheck[$rowcheck][$colcheck]
	
	
}

function find-seat ($seatcheck, $row, $col, $rowdir, $coldir)
{
	$row += $rowdir
	$col += $coldir
	if (($row -lt 0) -or ($row -ge $seatcheck.count) -or ($col -lt 0) -or ($col -ge $seatcheck[$row].count))
	{
		return @(-1, -1)
	}
	if ($seatcheck[$row][$col] -eq "L")
	{
		return @($row, $col)
	}
	return (find-seat $seatcheck $row $col $rowdir $coldir)
	
}

Get-Content .\day11input | ForEach-Object { $seats.add(@($_.tochararray())) | out-null }
$seats | ForEach-Object { $seatsworking.add(@($_)) | out-null }
$seats | ForEach-Object { $seatslocation.add(@($_)) | out-null }
ForEach ($row in 0 .. ($seats.count - 1))
{
	foreach ($col in 0 .. ($seats[$row].count - 1))
	{
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
        if($seatsworking[$row][$col] -ne $seats[$row][$col]) {$changed = $true}
        }
} 
    $seats.Clear()
    $seatsworking | ForEach-Object { $seats.add(@($_)) |out-null }

} while ($changed) 
$counts = 0
$seats |% { $_ | % {if ($_ -eq "#") {$counts +=1}}}
$counts
