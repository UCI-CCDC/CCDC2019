$connections = Get-NetTCPConnection | Where-Object {$_.State -eq "Listen"}
$table = foreach($c in $connections) {$process = Get-Process -PID $c.OwningProcess; $info = New-Object -TypeName PSObject; $info | Add-Member -MemberType NoteProperty -Name Process_ID -Value $process.ID; $info | Add-Member -MemberType NoteProperty -Name Process_Name -Value $process.ProcessName; $info | Add-Member -MemberType NoteProperty -Name Local_Port -Value $c.LocalPort; $info}
$table | Format-Table -AutoSize >> "ProcessInventory.txt"
