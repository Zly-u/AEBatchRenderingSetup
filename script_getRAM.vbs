Set WMI 	= GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2") 
Set pc_data = WMI.ExecQuery("Select * from Win32_ComputerSystem") 
For Each data in pc_data 
	WScript.Quit data.TotalPhysicalMemory/(1024.0*1024.0*1024.0)
Next