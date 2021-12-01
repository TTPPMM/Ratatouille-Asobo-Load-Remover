state("overlay_win2k")
{
	float load : 0x003DD8A8, 0x8, 0x9D4, 0x5C;
	uint level : 0x003DD8A8, 0x8, 0x9C4, 0x7C;
	uint activeMissions : 0x003DD8A8, 0x8, 0xAF4, 0x20;
	float xPos : 0x003DBAA0;
}

state("overlay")
{
	float load : 0x003DE8A8, 0x8, 0xDD4, 0x370, 0x988;
	uint level : 0x003DE8A8, 0x8, 0x9C4, 0x7C;
	uint activeMissions : 0x003DE8A8, 0x8, 0xAF4, 0x20;
	float xPos : 0x003DCAA0;
}

isLoading
{
	return current.load != 0.0;
}

init
{
	// Keep last visited level stored, defaults to Menu02
	vars.prevLevel = 0;
}

start
{
	// Check to see if current level is Somewhere in France, and old x-position is the start x-position, 
	// if so return if x-position has changed
	if (current.level == 1 && ((Math.Abs(old.xPos) - Math.Abs(-16.57965)) < 0.0001)) {
		return !((Math.Abs(current.xPos) - Math.Abs(old.xPos)) < 0.0001);
	}
}

split
{	
	// Keep last visited updated
	if (old.level != current.level) {
		vars.prevLevel = old.level;
	}
	uint numCurrentActiveMissions = current.activeMissions >> 0xe;
	uint numOldActiveMissions = old.activeMissions >> 0xe;
	
	// Last Split, mission count goes to 1 after reaching the final cutscene trigger
	if (current.level == 24 && (numCurrentActiveMissions < numOldActiveMissions)) {
		return true;
	}

	// Disable splitting on entering Paris Streets (Not splitting if last level is Home Stink Home)
	if (old.level == 3) {
		return false;
	}

	// Splitting based on level change, disabled for cooking minigames in Desserted Kitchen
	if (old.level != 23 && old.level != 17 && old.level != 19 && old.level != 14) {
		return current.level != old.level;
	}

	// Splitting based on active mission count (After completing a mission in Desserted Kitchen count goes back to 7)
	if (current.level == 23 && vars.prevLevel != 12) {
		if (numCurrentActiveMissions < numOldActiveMissions) {
			return numCurrentActiveMissions == 7;
		}
	}
}

// NiV-L-A, ThePhotoshopMaster and Sabe