$ErrorActionPreference = "silentlycontinue"
Remove-Variable *

$fullcode = (Get-Content .\day09input | ForEach-Object{[int64]$_})
$preamble = $fullcode[0..24]
$code = $fullcode[25..$($fullcode.length)]
do {
    $found=$false
    $preamble | ForEach-Object {
    if(($code[0] - $_) -in ($preamble -ne $_)) {
        $found = $true
            $preamble = $preamble[1..24] + $code[0]
    $code = $code[1..$($code.length)]
        return
        }

    }

    } while ($found -eq $true)

    $target = $code[0]
    $target
$search = @()
$results = 0
$fullcode | ForEach-Object {
    $adder = $_
    $search = @($search | ForEach-Object{$_ + $adder})
    $search += ,$adder
    if ($target -in $search) {
    $results = ($fullcode[$fullcode.IndexOf([int64]$adder)..$search.IndexOf([int64]$target)] | Measure-Object -Maximum -Minimum)
$results.maximum + $results.minimum
exit
    }     
}


    
    