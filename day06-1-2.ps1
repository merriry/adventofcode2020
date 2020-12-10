$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
$ErrorActionPreference = "stop"
$grouptotal = 0
$sameyes
(Get-Content .\day06input -raw) -Split "`n`n" | % {
    $same = [char[]]([char]'a'..[char]'z')
    $_ -split "\n" | % {$same = ($_.ToCharArray() | where {$same -contains $_})}
    $sameyes += ($same | sort-object | get-unique | measure-object).count
    $grouptotal +=  ($_.replace("`n","").tochararray() | sort-object | get-unique |Measure-Object).count
    }
    $grouptotal
    $sameyes