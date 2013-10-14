$drives = typeperf -qx physicaldisk | findstr /r "Idle" | select-string -pattern "[0-9]\s[a-z]:((\s[a-z]:)+(\s)?)?" -allmatches -list | select matches
#write-host $drives
#[0-9]\s[a-z]:((\s[a-z]:)+)?
write-host "{"
	write-host " `"data`":[`n"
	foreach ($perfDrives in $drives)
		{
		$line= "{ `"{#DISKNUMLET}`" : `"" + $perfDrives.matches + "`" },"
		write-host $line
		}
	write-host
	write-host " ]"
	write-host "}"
	write-host
