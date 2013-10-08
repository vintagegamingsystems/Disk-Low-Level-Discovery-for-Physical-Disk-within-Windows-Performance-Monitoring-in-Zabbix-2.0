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
        } | select-Object Name, DiskIndex
    } 
     
    	$colItems = Get-Drives 
    	write-host "{"
	write-host " `"data`":["
	foreach ($objItem in $colItems)
		{
		$line= "{ `n`"{#DISKLET}`" : `"" + $objItem.Name + "`",`n`"{#DISKNUMLET}`" : `"" + $objItem.DiskIndex + " " + $objItem.Name + "`",`n}"
		#Allows only letter drives with unique Diskindex values to be discovered. 
		if ($objItem.DiskIndex -ne $oldObjItemDiskIndex)
			{
			write-host $line
			}
		# Keeps track of index number	
		$oldObjItemDiskIndex = $objItem.DiskIndex
		}
	write-host
	write-host " ]"
	write-host "}"
	write-host
