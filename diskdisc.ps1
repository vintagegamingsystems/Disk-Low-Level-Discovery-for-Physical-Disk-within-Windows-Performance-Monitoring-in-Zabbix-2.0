# Many thanks to Tobias who created "Get Drive ID and Drive Leter" for which I modified to return the correct JSON output.
# http://powershell.com/cs/media/p/7924.aspx

function Combine-Object { 
        param( 
        $object1, 
        $object2 
        ) 
     
        trap { 
            $a = 1 
            continue 
        } 
        $propertylistObj1 = @($object1 | Get-Member -ea Stop -memberType *Property | Select-Object -ExpandProperty Name) 
        $propertylistObj2 = @($object2 | Get-Member -memberType *Property | Select-Object -ExpandProperty Name | Where-Object { $_ -notlike '__*'}) 
     
        $propertylistObj2 | ForEach-Object { 
            if ($propertyListObj1 -contains $_) { 
                $name = '_{0}' -f $_ 
            } else { 
                $name = $_ 
            } 
     
            $object1 = $object1 | Add-Member NoteProperty $name ($object2.$_) -PassThru 
        } 
     
        $object1 
    }  
     
    function Get-Drives { 
        Get-WmiObject Win32_DiskPartition | 
        ForEach-Object { 
            $partition = $_ 
            $logicaldisk = $partition.psbase.GetRelated('Win32_LogicalDisk')
            if ($logicaldisk -ne $null) {   
	    Combine-Object $logicaldisk $partition
	    } 
        } | select-Object DiskIndex, Name | sort-object -Property DeviceID
    } 
	#Get-Drives
    	#Puts the output of the Get-Drives function in the variable $colItems 
	$colItems = Get-Drives
	#Populates hashtable
	foreach ($objPull in $colItems)
		{
		$hashTable+=,@($objPull.DiskIndex,$objPull.Name)
		}	
	#write-host $hashTable
	#[array]::reverse($hashTable)
	#Restructures data structure.
	foreach ($hash in $hashTable)
		{
		$diskIndex=$hash[0]
		$driveLetter=$hash[1]
		if($diskIndex -gt $oldIndex)
			{
			$newHashTable+=,@(,($diskIndex, $driveLetter))
			}
		else
			{
			$newHashTable[$diskIndex][0]+=$driveLetter
			}
		
		$oldIndex = $diskIndex
		}
	write-host "{"
	write-host " `"data`":[`n"
	foreach ( $blah in $newHashtable)
		{
		$diskIndexNew = $blah[0]
		$driveIndexNew = $blah[1]
		$line= "{ `"{#DISKLET}`" : `"" + $diskIndexNew[0] + "`",`n  `"{#DISKNUMLET}`" : `"" + $diskIndexNew + "`" },"
		write-host $line
		}
	write-host
	write-host " ]"
	write-host "}"
	write-host
