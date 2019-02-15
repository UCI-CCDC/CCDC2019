# to change filetypes of output, change .txt to .csv or desired type
$connections = netstat –o
Note: Do not panic if 4 error messages show up after running the below script. After running it, open the output file, ProcessInventory.txt. If everything looks alright except the first 4 entries, just delete those first 4 entries.
$table = foreach($c in $connections) {$cInfoArr = $c –Split “ +”; $process = Get-Process –PID $cInfoArr[5]; $info = New-Object -TypeName PSObject; $info | Add-Member -MemberType NoteProperty -Name Process_ID -Value $process.Id; $info | Add-Member -MemberType NoteProperty -Name Process_Name -Value $process.ProcessName; $info | Add-Member -MemberType NoteProperty -Name Local_Port -Value $cInfoArr[5]; $info}
$table | Format-Table –AutoSize >> “ProcessInventory.txt”
