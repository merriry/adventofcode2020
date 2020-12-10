$ErrorActionPreference = "silentlycontinue"
Remove-Variable *

$code = Get-Content .\day08input
$line = 0
$acc = 0
$target = $code.count

function runtoend ($runline, $acc) {
$lines = @()
while (!($lines + $runline | Group-Object | Where-Object {$_.count -gt 1}) -and $runline -ne $target) {
$lines += $runline
$code[$runline] -match '(.+) ([+|-]\d+)' |out-null
 switch ($Matches[1]) {
 "acc" {$acc += [int]$Matches[2];$runline += 1}
 "jmp" {$runline += [int]$Matches[2]}
 "nop" {$runline +=1}
 } 
 }
  return @($runline,$acc)
 }
 

 $test = @(0,0)
 
 while ($test[0] -ne $target) {
 $code[$line] -match '(.+) ([+|-]\d+)' |out-null
switch ($Matches[1]) {
 "acc" {$acc += [int]$Matches[2];$line += 1}
 "nop" {$test = runtoend ($line + [int]$Matches[2]) $acc;if ($test[0] -ne $target) {$line +=1}}
 "jmp" {$test = runtoend ($line + 1) $acc;if ($test[0] -ne $target) {$line += $Matches[2] }}
 }
 } 
(runtoend 0 0)[1]
$test[1]
