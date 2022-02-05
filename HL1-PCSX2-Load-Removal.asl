// PCSX2 v1.4.0 HL1 Load-Removal
// Based on PCSX2 v1.4.0 HL1 Load-Removal by _SmileyAG
// This repository is focused on fine-working Load-Removal on LiveSplit v1.8.18 and optimized Version Detector (using ModuleSize instead of MD5Hash)
// WORKING ONLY ON EUROPE REGION

state("pcsx2", "v1.4.0") // Offsets
{
    	int loading: "safemon.dll", 0x000A6618, 0x10C, 0x28C;
	string10 map: "pcsx2.exe", 0x00964440, 0x308, 0x824, 0xBB4;
}

init // Version specific
{
	// var mms = modules.First().ModuleMemorySize;
    // print("0x" + mms.ToString("X"));

	if(modules.First().ModuleMemorySize == 0x236B000)
		version = "v1.4.0";
	else
		version = "UNDETECTED";
}

isLoading // Gametimer
{
	if(current.loading == 1)
	{
		return true;
	} else{
		return false;
	}
}

start // Start splitter
{
	if (current.loading == 0 && current.map == "c1a0")
	{
		return true;
	}
}

reset // Reset splitter
{
	if (current.loading == 0 && old.loading == 1 && current.map == "c1a0")
	{
		return true;
	}
}

update // Version specific
{
	if (version.Contains("UNDETECTED"))
		return false;
}
