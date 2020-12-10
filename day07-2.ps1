$ErrorActionPreference = "silentlycontinue"
Remove-Variable *

$rules = Get-Content .\day07input | Foreach-Object { 
	$_ -match '^(?<bag>[a-z ]+) bags contain (?<containedbags>.+)+\.$' |out-null
	$bag = $matches.bag
	$matches.containedbags -split ', ' | Foreach-Object { 
	    if ( $_ -eq 'no other bags' ) {
	        [PSCustomObject]@{ Container = $bag; Contained = $null; NumContained = 0 }
	    }
	    else {
    		$_ -match '^(?<numbags>\d+) (?<namebag>[a-z ]+) bags?$' | out-null
		   [PSCustomObject]@{ Container = $bag; Contained = $matches.namebag; NumContained = $matches.numbags }
        }
	}
}

$bagcompiled = New-Object -TypeName "system.collections.arraylist"
$start = @("shiny gold")
$currentlayer = [System.Collections.ArrayList]@($rules | Where-object { $_.Container -in $start } )
$nextlayer = New-Object -TypeName "system.collections.arraylist"
while ($currentlayer.Count -gt 0) {
$currentlayer | ForEach-Object {
    $currbag = $_.contained
    $numbags = $_.numcontained
    if ($numbags -ne 0) {$nextrule = $rules | Where-object { $_.Container -in $currbag }
        1..$numbags | ForEach-Object {
            $bagcompiled.add($currbag) | Out-Null
            $nextrule | ForEach-Object {
            if ($_.numcontained -gt 0) {$nextlayer.add($_)|out-null }
            }
            }
        }
    }
$currentlayer = $nextlayer
$nextlayer = New-Object -TypeName "system.collections.arraylist"
}
$bagcompiled.count