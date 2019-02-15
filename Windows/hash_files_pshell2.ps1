$bytesToRead = 1500000
$hashesToRead = $bytesToRead/47
$hashesRead = 0
$sha1 = New-Object System.Security.Cryptography.SHA1CryptoServiceProvider
Get-ChildItem  –Recurse –Include *.* | ForEach-Object {$_.fullname+”`n”+[System.BitConverter]::ToString($sha1.ComputeHash([System.IO.File]::ReadAllBytes($_.fullname)))+”`n” >> “Hash.txt”; $hashesRead += 1; If($hashesRead –gt $hashesToRead){break;}}
