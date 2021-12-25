state("overlay_win2k")
{
	float load : 0x003DD8A8, 0x8, 0x9D4, 0x5C;
	uint level : 0x003DD8A8, 0x8, 0x9C4, 0x7C;
	uint activeMissions : 0x003DD8A8, 0x8, 0xAF4, 0x20;
	float xPos : 0x003DBAA0;
	byte paused : 0x003DD8B4, 0x4;
	byte menuState : 0x003C9F54, 0x12D8;
	uint dialogType : 0x003C9F54, 0x12DC;
}

state("overlay")
{
	float load : 0x003DE8A8, 0x8, 0x9D4, 0x5C;
	uint level : 0x003DE8A8, 0x8, 0x9C4, 0x7C;
	uint activeMissions : 0x003DE8A8, 0x8, 0xAF4, 0x20;
	float xPos : 0x003DCAA0;
	byte paused : 0x003DE8B4, 0x4;
	byte menuState : 0x003CAF54, 0x12D8;
	uint dialogType : 0x003CAF54, 0x12DC;
}

isLoading
{
	return current.load != 0.0;
}

init
{
	refreshRate = 160;
	// Keep last visited level stored, defaults to Menu02
	vars.prevLevel = 0;
}

start
{
	// If current level is Somewhere in France
	if (current.level == 1) {
		double deltaStartPos = Math.Abs(old.xPos) - Math.Abs(-16.57965);
		// If old xpos is virtually the start position
		if ((deltaStartPos > -0.00001) && (deltaStartPos < 0.00001)) {
			// Return if game isn't paused and a textbox dialog was closed
			return (current.paused == 0 && old.menuState == 5 && old.dialogType == 7);
		}
	}
}

split
{	
	uint numCurrentActiveMissions = current.activeMissions >> 0xe;
	uint numOldActiveMissions = old.activeMissions >> 0xe;

	// Update last visited level if needed
	if (old.level != current.level) {
		vars.prevLevel = old.level;
	}
	
	// Last Split, mission count goes to 1 after reaching the final cutscene trigger
	if (current.level == 24 && (numCurrentActiveMissions < numOldActiveMissions)) {
		return true;
	}

	// Splitting based on level change,
	// disabled for cooking minigames in Desserted Kitchen and when entering Paris Streets
	if (old.level != 3 && old.level != 14 && old.level != 17 && old.level != 19 && old.level != 23) {
		return current.level != old.level;
	}

	// Splitting based on active mission count (After completing a mission in Desserted Kitchen count goes back to 7).
	// This spliting is disabled if previous level was 12 to prevent double splitting (It already splits when changing from 12 to 23).
	// Also disabled in case the last level was 12, 14, 17 or 19 (DK Cake, DK Soup, DK Mixer and DK Salad) to prevent accidental splits.
	if (current.level == 23 && vars.prevLevel != 12 && vars.prevLevel != 14 && vars.prevLevel != 17 && vars.prevLevel != 19) {
		if (numCurrentActiveMissions < numOldActiveMissions) {
			return numCurrentActiveMissions == 7;
		}
	}
}

// NiV-L-A, ThePhotoshopMaster and Sabe