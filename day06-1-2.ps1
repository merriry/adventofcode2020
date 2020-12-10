$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
$ErrorActionPreference = "stop"
$grouptotal = 0
$sameyes
(Get-Content .\day06input -raw) -Split "`n`n" | ForEach-Object {
    $same = [char[]]([char]'a'..[char]'z')
    $_ -split "\n" | ForEach-Object {$same = ($_.ToCharArray() | Where-Object {$same -contains $_})}
    $sameyes += ($same | sort-object | get-unique | measure-object).count
    $grouptotal +=  ($_.replace("`n","").tochararray() | sort-object | get-unique |Measure-Object).count
    }
    $grouptotal
    $sameyes