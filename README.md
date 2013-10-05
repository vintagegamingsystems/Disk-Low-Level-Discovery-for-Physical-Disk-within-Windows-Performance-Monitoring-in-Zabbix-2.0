DiskDiscoveryWindowsZabbix
==========================

Powershell script returns JSON for Windows Perfomance Monitoring within Zabbix.

This powershell script discovers the logical disks letters and partition index number for a windows machine. The returned values can be used to enable Zabbix to autodiscover all the individual disks in the following format: 

<partition number> <drive letter>: 

0 C:

In order to monitor the physical disks for Windows performance monitoring within Zabbix as user must set up items for each individual disk. This is cumbersome as you must know the drive letter and index number for each Windows machine. Normal item syntax for physical disks within the Windows performance monitor in Zabbix looks like the following:

perf_counter[\234(0 C:)\208]

Our script returns JSON (JavaScript Object Notation) it will look like this.



For addional Zabbix Windows Performance Monitoring, please visit the following website:

https://www.zabbix.com/documentation/2.0/manual/config/items/perfcounters

For more information about the Zabbix API visit this site:

