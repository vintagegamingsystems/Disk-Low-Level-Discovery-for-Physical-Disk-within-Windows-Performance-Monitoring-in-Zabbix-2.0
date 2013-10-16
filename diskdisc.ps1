#$drives = typeperf -qx physicaldisk | findstr /r "Idle" | select-string -pattern "[0-9]\s[a-z]:((\s[a-z]:)+(\s)?)?" -allmatches -list | select matches
$drives = Get-WmiObject win32_PerfFormattedData_PerfDisk_PhysicalDisk |?{$_.name -ne "_Total"} | Select Name
write-host "{"
	write-host " `"data`":[`n"
	foreach ($perfDrives in $drives)
		{
		$line= "{ `"{#DISKNUMLET}`" : `"" + $perfDrives.Name + "`" },"
		write-host $line
		}
	write-host
	write-host " ]"
	write-host "}"
	write-host
