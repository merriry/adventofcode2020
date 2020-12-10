$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
$adapters = [system.collections.arraylist](Get-Content .\day10input | %{[double]$_})
$currjolt = 0
$onejolt = 0
$threejolt = 0
$onejoltjump = 0
$posssolutions = 1
$uses = @(1,1,2,4,7)
$adapters.Sort()
$adapters.Add($adapters[-1]) | out-null
while ($adapters.count -gt 0) {
    $jumpjolt = $adapters[0] - $currjolt
    $currjolt += $jumpjolt
    if ($jumpjolt -eq 1) {$onejolt += 1; $onejoltjump += 1}
    else {$threejolt += 1;$posssolutions *= $uses[$onejoltjump];$onejoltjump =0}
    $adapters.Remove($adapters[0])
    }
   write-host ($onejolt*$threejolt) $currjolt $posssolutions