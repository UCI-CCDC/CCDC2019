$Files = Get-ChildItem  –Recurse –File
$bytesToRead = 1500000
$hashesToRead = $bytesToRead/47
$hashesRead = 0
$Files | ForEach-Object {$_.fullname+ “`n“+(certUtil  –hashFile $_.fullname MD5)[1]+”`n” >> “Hash.txt”; $hashesRead += 1; If($hashesRead –gt $hashesToRead){break;}}
