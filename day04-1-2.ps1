$ErrorActionPreference = "silentlycontinue"
Remove-Variable *
$ErrorActionPreference = "stop"
$currentpassport = @{}
$validpp = 0
$validbase = 0

function validate-params ($passport) {
if ([int]$passport["byr"] -notin 1920..2002) {return $false}
if ([int]$passport["iyr"] -notin 2010..2020) {return $false}
if ([int]$passport["eyr"] -notin 2020..2030) {return $false}
if ($passport["hgt"] -match "^(\d+)([i|c])") {
    switch ($matches.2) {
    "i" {if ([int]$matches.1 -notin 59..76) {return $false}}
    "c" {if ([int]$matches.1 -notin 150..193) {return $false}}
    }}
    else {return $false}
if ($passport["hcl"] -notmatch "^#[0-9a-f]{6}\b") {return $false}
if ($passport["ecl"] -notin @("amb", "blu", "brn", "gry", "grn", "hzl", "oth")) {return $false}
if ($passport["pid"] -notmatch '^\d{9}\b') {return $false}
return $true
}


Get-Content .\day04input | ForEach-Object {

if ($_.length -eq 0) {$currentpassport = @{};return}
$_.split(" ") | ForEach-Object { 
    $currentpassport.add(($_.split(":"))[0],($_.split(":"))[1])

if ($currentpassport.containskey("byr") -and
    $currentpassport.containskey("iyr") -and
    $currentpassport.containskey("eyr") -and
    $currentpassport.containskey("hgt") -and
    $currentpassport.containskey("hcl") -and
    $currentpassport.containskey("ecl") -and
    $currentpassport.containskey("pid")) {
        $validbase += 1
        if (validate-params($currentpassport)) {$validpp +=1}
    $currentpassport = @{}
    }
}
}
write-host "Part 2: $validpp"
write-host "Part 1: $validbase"