DiskDiscoveryWindowsZabbix
==========================

Powershell script returns JSON for Windows Perfomance Monitoring within Zabbix.

This powershell script discovers the logical disks letters and partition index number for a windows machine. The returned values can be used to enable Zabbix to autodiscover all the individual disks in the following format: 

<partition number> <drive letter>: 

0 C:

In order to monitor the physical disks for Windows performance monitoring within Zabbix as user must set up items for each individual disk. This is cumbersome as you must know the drive letter and index number for each Windows machine. Normal item syntax for physical disks within the Windows performance monitor in Zabbix looks like the following:

perf_counter[\234(O C:)\208]

