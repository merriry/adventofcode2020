$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
$count = @(0,0,0,0,0)
$hloc = @(0,0,0,0,0)
$vloc = @(0,0,0,0,0)
$hmov = @(1,3,5,7,1)
$vmov = @(1,1,1,1,2)
Get-Content .\day03input | % {
    $line = $_
    0..4 | % {
        if ($vloc[$_] % $vmov[$_] -eq 0) {
            if($line[$hloc[$_]] -eq "#") {
                $count[$_] += 1
        }
        $hloc[$_] = ($hloc[$_] + $hmov[$_]) % $line.length
    }
    $vloc[$_] = ($vloc[$_] + 1) % $vmov[$_]
    }
}
$target = 1
$count | % {
    $target *= $_
    }
$target