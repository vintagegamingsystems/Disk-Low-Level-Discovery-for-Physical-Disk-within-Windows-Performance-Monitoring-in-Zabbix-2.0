Disk Discovery Windows Zabbix
==========================

This Powershell script returns JSON for Windows Perfomance Monitoring within Zabbix.

This powershell script discovers the logical disks letters and partition index number for a windows machine. The returned values can be used to enable Zabbix to autodiscover all the individual disks in the following format: 

[partition number] [drive letter]:

0 C:

In order to monitor the physical disks for Windows performance monitoring within Zabbix as user must set up items for each individual disk. This is cumbersome as you must know the drive letter and index number for each Windows machine. Normal item syntax for physical disks within the Windows performance monitor in Zabbix looks like the following:

perf_counter[\234(0 C:)\208]

\234 Represents the Physical Disk.

\208 Represents Ave. Disk seconds/Read.

The conversion values are located in the registry.

Run regedit from the command line on your windows machine. Then navigate to the HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib\009. 

I would personally copy the contents of the file and put it into a text document if you want to reference them later. The numeric representation of the Windows Performance Monitoring metrics is better if you work in an environment where the machines may have different locales (i.e. Languages) because the Windows Perfomance Monitoring strings change based on locale.

Our script returns JSON (JavaScript Object Notation) it will look like this.

{
  "data":[
  
  { "{#DISKNUMLET}":"0 C:" },
  
  ]
}

You must create a create a UserParameter somewhere in the zabbix_agent.win.conf or zabbix_agent.conf file. It depends on what you named the file initially. 

Then restart the agent.

When you make an item you must use the defined macro in the JSON object, {#DISKNUMLET}.

It will look something this this

perf_counter[\234(#DISKNUMLET)\208]

For addional Zabbix Windows Performance Monitoring, please visit the following website:

https://www.zabbix.com/documentation/2.0/manual/config/items/perfcounters

For more information about Zabbix Low Level Discovery visit this site:

https://www.zabbix.com/documentation/2.0/manual/discovery/low_level_discovery

