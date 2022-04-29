// PCSX2 v1.4.0 HL1 Load-Removal
// Based on PCSX2 v1.4.0 HL1 Load-Removal by SmileyAG and ScriptedSnark
// This repository is focused to fine working Load-Removal on LiveSplit v1.8.18+ and optimized Version Detector (using ModuleSize instead of MD5Hash)
// 
// Be sure to disable BunnySplit in Edit Splits, otherwise the PCSX2 autosplitter won't work!
// SET YOUR "COMPARE AGAINST" TO (GAME TIME) BY RIGHT CLICKING ON YOUR SPLITS OR YOU WON'T SEE LOADS GETTING PAUSED !!
// WORKING ONLY ON EUROPE REGION

state("pcsx2", "v1.4.0") // Offsets
{
    	int loading: "spu2-x.dll", 0x0027E67C, 0xB18, 0x1A4; // Thanks to gstroin for helping with finding pointers on win10
	string10 map: "pcsx2.exe", 0x00964440, 0x308, 0x824, 0xBB4;
}

init // Version specific
{
	var mms = modules.First().ModuleMemorySize;
    	// print("0x" + mms.ToString("X"));

	if(mms == 0x236B000)
		version = "v1.4.0";
	else
		version = "UNDETECTED";
}

isLoading // Gametimer
{
	return current.loading == 1;
}

start // Start splitter
{
	return current.loading == 0 && current.map == "c1a0";
}

reset // Reset splitter
{
	return current.loading == 0 && old.loading == 1 && current.map == "c1a0";
}

update // Version specific
{
	if (version.Contains("UNDETECTED"))
		return false;
}
