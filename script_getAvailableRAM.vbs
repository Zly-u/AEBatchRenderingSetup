Set WMI 		= GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2") 
Set perfData 	= WMI.ExecQuery("Select * from Win32_PerfFormattedData_PerfOS_Memory") 
For Each data in perfData 
	WScript.Quit data.AvailableBytes/(1024.0*1024.0*1024.0)
Next
