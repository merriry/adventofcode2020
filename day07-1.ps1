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
$baglist = @("shiny gold")
do {
    $containerrules = @($rules | Where-object { $_.Contained -in $baglist } ) 
    if ($containerrules.Count -gt 0) {
        $baglist = @($containerrules.Container | select -Unique )
    }
    else {
        $baglist = @()
    }
    $baglist | foreach {
        if ($_ -notin $bagcompiled) {
            $bagcompiled.Add($_) |out-null
        }
    }
} while ($baglist.Count -gt 0)

$bagcompiled.count
