state("overlay_win2k")
{
	float load : 0x003DD8A8, 0x8, 0x9D4, 0x5C;
}

state("overlay")
{
	float load : 0x003DE8A8, 0x8, 0xDD4, 0x370, 0x988;
}

isLoading
{
	return current.load != 0;
}

// NiV-L-A and ThePhotoshopMaster
