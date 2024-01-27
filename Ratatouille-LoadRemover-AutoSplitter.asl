state("overlay") {}
state("overlay_win2k") {}

startup
{
    vars.ScanTargets = new SigScanTarget[]
    {
        new SigScanTarget(2, "8B 0D ?? ?? ?? ?? 50 E8 ?? ?? ?? ?? 8B 48 ?? 89 4E"),
        new SigScanTarget(2, "D9 05 ?? ?? ?? ?? D8 A4 24 ?? ?? ?? ?? D9 1D ?? ?? ?? ?? D9 05 ?? ?? ?? ?? D8 A4 24 ?? ?? ?? ?? D9 1D ?? ?? ?? ?? D9 05 ?? ?? ?? ?? D8 A4 24 ?? ?? ?? ?? D9 1D ?? ?? ?? ?? D9 03"),
        new SigScanTarget(1, "A3 ?? ?? ?? ?? 8D 88 ?? ?? ?? ?? E9 ?? ?? ?? ?? 33 C0"),
        new SigScanTarget(2, "8B 0D ?? ?? ?? ?? B0 ?? 88 81 ?? ?? ?? ?? C3 ?? A1 ?? ?? ?? ?? 8B 80"),
        new SigScanTarget(2, "8B 15 ?? ?? ?? ?? 8B 04 ?? C3")
    };

    var levelList = new Dictionary<uint, string> {
        { 1, "Somewhere in France" },
        { 2, "Destiny River" },
        { 3, "Home Stink Home" },
        { 4, "Paris Streets" },
        { 5, "The City of Lights" },
        { 6, "How'd You Make That?" },
        { 7, "Little Chef - Big Kitchen" },
        { 8, "Chop Chop Chase" },
        { 9, "The City Market" },
        { 10, "Harried Grocery Havoc" },
        { 11, "Cake & Bake" },
        { 12, "This Ain't no Cakewalk" },
        { 13, "Soup, Line, and Sinker" },
        { 14, "Ratatouille" },
        { 15, "Soupy Assistance" },
        { 16, "Peeling Potatoes" },
        { 17, "Appetite for Appetizers" },
        { 18, "Salad Ballad" },
        { 19, "Stacking for a Salad" },
        { 20, "Take Aim and Blow" },
        { 21, "Sound the Alarm!" },
        { 22, "Shocking Starter" },
        { 23, "The Desserted Kitchen" },
        { 24, "Was the Food That Bad?" },
        { 25, "Fishing for treasures" },
        { 26, "Food Fishing" },
        { 27, "Lean, Mean, Dishwashing Machine" },
        { 28, "Spick & Span Pumpkins" },
        { 29, "Wait for the Crepe" },
        { 30, "Rat Race" },
        { 31, "Closet Collection" },
        { 32, "Last Rat Standing" },
        { 33, "Tightrope Chaos" },
        { 34, "That's a Loot of Fruit" },
        { 35, "This is a Steakout!" },
        { 36, "Say Cheese!" },
        { 37, "Dirty Dish Fright" },
        { 38, "Pasta Persuasion" },
        { 39, "Desserted Wonderland" },
        { 40, "Veggie Vault" },
        { 41, "Soaring Strawberries" },
        { 42, "Kitchen Chaos" },
        { 43, "Sausage Shenanigan" },
        { 44, "Underground Fun" },
        { 45, "Leaky Pipes" },
        { 46, "The Slide of Your Life" },
        { 47, "Kitchen Pipe" },
        { 48, "Oh Smelly Water" },
        { 49, "Test_Mar" },
        { 50, "Test_Connex" },
        { 51, "Test_Nico" },
        { 52, "Test_Julien" }
    };

    settings.Add("start", true, "Start");
        settings.Add("start_mb", true, "Somewhere in France", "start");
        settings.SetToolTip("start_mb", "Starts the timer in the first frame of movement");

    settings.Add("split", true, "Split");
        settings.Add("split_levels", true, "Levels", "split");
        settings.Add("split_missions", true, "Missions", "split");
            settings.Add("instantMissionSplit", false, "Instant mission split", "split_missions");
            settings.Add("split_missions_disableDW", false, "Disable mission split for:", "split_missions");
            settings.Add("split_missions_collection", false, "Collection", "split_missions");
        settings.Add("split_chase", true, "Chase", "split");
        settings.Add("split_deaths", false, "Deaths", "split");

    // Tool-Tip
    settings.SetToolTip("split_levels", "Split on level changes");
    settings.SetToolTip("split_missions", "Split on mission completions");
    settings.SetToolTip("split_missions_disableDW", "Turns off mission splitting when entering an enabled level.\nMission splitting turns back on after exiting the mission.");
    settings.SetToolTip("split_missions_collection", "Split on completed collection");
    settings.SetToolTip("split_chase", "Split on the chase cutscene at the end");
    settings.SetToolTip("instantMissionSplit", "Split when the book opens instead of book closing");
    settings.SetToolTip("split_deaths", "Split when dying");

    uint[] excludedLevelsFromSettings = { 25, 26, 27, 28, 29, 49, 50, 51, 52 };
    uint[] splitLevelsEnabled = { 2, 3, 5, 6, 7, 8, 9, 10, 15, 23, 24, 44, 45, 46, 47 };
    uint[] missionLevels = { 1, 3, 5, 7, 9, 23, 44, 45, 46, 47 };
    uint[] splitMissionsEnabled = { 1, 5, 7, 9, 23 };
    uint[] ExcludedMissionCompletedBookEnabled = { 44, 45, 46 };
    uint[] MissionCompletedLevelSuccess = { 1, 44, 45, 46};
    uint[] MissionCompletedLevelSuccessEnabled = { 44, 45, 46 };
    uint[] disableMissionsplitDW = { 34, 35, 36, 37, 38, 39, 40, 41, 42, 43 };
    uint[] disableMissionsplitEnabledLevelsDW = { 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 47 };
    uint[] splitChaseLevels = { 6, 8, 10, 24 };
    uint[] splitChaseEnabledLevels = { 24 };
    uint[] excludedDeathLevels = { 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 25, 26, 27, 28, 29 };
    uint[] collectibleLevels = { 3, 5, 7, 9, 23, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48 };
    uint[] toolTip = { 3, 5, 7, 9, 23 };

    foreach (var level in levelList)
    {
        if (!Array.Exists(excludedLevelsFromSettings, key => key == level.Key))
        {
            settings.Add("split_levels_"+level.Key.ToString(), Array.Exists(splitLevelsEnabled, key => key == level.Key), level.Value, "split_levels");
            if (Array.Exists(toolTip, key => key == level.Key)) {
                settings.SetToolTip("split_levels_"+level.Key.ToString(), "Split when entering this level from:");
            }

            if (Array.Exists(missionLevels, key => key == level.Key)) {
                settings.Add("split_missions_"+level.Key.ToString(), Array.Exists(splitMissionsEnabled, key => key == level.Key), level.Value, "split_missions");
                settings.Add("split_missions_missionCompletedBook"+level.Key.ToString(), !Array.Exists(ExcludedMissionCompletedBookEnabled, key => key == level.Key), "Mission Completed", "split_missions_"+level.Key.ToString());
            }
            if (Array.Exists(MissionCompletedLevelSuccess, key => key == level.Key)) {
                settings.Add("split_missions_missionCompletedLevelSuccessBook"+level.Key.ToString(), Array.Exists(MissionCompletedLevelSuccessEnabled, key => key == level.Key), "Level Completed", "split_missions_"+level.Key.ToString());
            }

            if (Array.Exists(disableMissionsplitDW, key => key == level.Key)) {
                settings.Add("split_missions_disableDW_"+level.Key, Array.Exists(disableMissionsplitEnabledLevelsDW, key => key == level.Key), level.Value, "split_missions_disableDW");
            }
            
            if (Array.Exists(splitChaseLevels, key => key == level.Key)) {
                settings.Add("split_chase_"+level.Key.ToString(), Array.Exists(splitChaseEnabledLevels, key => key == level.Key), level.Value, "split_chase");
            }

            if (!Array.Exists(excludedDeathLevels, key => key == level.Key)) {
                settings.Add("split_deaths_"+level.Key.ToString(), true, level.Value, "split_deaths");
            }

            if (Array.Exists(collectibleLevels, key => key == level.Key)) {
                settings.Add("split_missions_collectionComplededBook"+level.Key.ToString(), true, level.Value, "split_missions_collection");
            }
        }
    }

    // Setting for bone sequence break split
    settings.Add("split_missions_bsb", true, "Bone Sequence Break", "split_missions_5");

    uint[] fromLevelToSW = { 2, 5, 7, 9, 23, 44, 45, 46, 47, 48 };
    uint[] enabledLevelsToSW = { 2, 44, 45, 46, 47, 48 };
    uint[] fromLevelToCT = { 3, 34, 35, 36, 45 };
    uint[] enabledLevelsToCT = { 45 };
    uint[] fromLevelToKD = { 3, 37, 44 };
    uint[] enabledLevelsToKD = { 44 };
    uint[] fromLevelToMK = { 3, 38, 39, 40, 46 };
    uint[] enabledLevelsToMK = { 46 };
    uint[] fromLevelToKN = { 3, 41, 42, 43, 47 };
    uint[] enabledLevelsToKN = { 47 };

    // Add Sub-Settings to main levels
    foreach (var level in levelList)
    {
        if (Array.Exists(fromLevelToSW, key => key == level.Key)) {
            settings.Add(level.Key+"to3", Array.Exists(enabledLevelsToSW, key => key == level.Key), level.Value, "split_levels_3");
        }

        if (Array.Exists(fromLevelToCT, key => key == level.Key)) {
            settings.Add(level.Key+"to5", Array.Exists(enabledLevelsToCT, key => key == level.Key), level.Value, "split_levels_5");
        }

        if (Array.Exists(fromLevelToKD, key => key == level.Key)) {
            settings.Add(level.Key+"to7", Array.Exists(enabledLevelsToKD, key => key == level.Key), level.Value, "split_levels_7");
        }

        if (Array.Exists(fromLevelToMK, key => key == level.Key)) {
            settings.Add(level.Key+"to9", Array.Exists(enabledLevelsToMK, key => key == level.Key), level.Value, "split_levels_9");
        }

        if (Array.Exists(fromLevelToKN, key => key == level.Key)) {
            settings.Add(level.Key+"to23", Array.Exists(enabledLevelsToKN, key => key == level.Key), level.Value, "split_levels_23");
        }
    }
    refreshRate = 160;
}

init
{
    IntPtr[] baseAddress = new IntPtr[vars.ScanTargets.Length];

    for (int i = 0; i < vars.ScanTargets.Length; i++) {
        IntPtr ptr = IntPtr.Zero;
        foreach (var page in game.MemoryPages(true)) {
            var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
            if (ptr == IntPtr.Zero) {
                ptr = scanner.Scan(vars.ScanTargets[i]);
            }
            if (ptr != IntPtr.Zero) {
                baseAddress[i] = (IntPtr)BitConverter.ToInt32(game.ReadBytes(ptr, 4), 0);
                break;
            }
        }
        if (baseAddress[i] == IntPtr.Zero) {
            var input = MessageBox.Show(
              "The autosplitter could not be initialized!\n"
            + "Try restarting the game."
            + "Would you like to join the speedrunning discord?",
              "LiveSplit | Ratatouille",
              MessageBoxButtons.YesNo,MessageBoxIcon.Error);
            if (input == DialogResult.Yes) Process.Start("https://discord.gg/zVNvemj");
            return false;
        }
    }

    vars.watchers = new MemoryWatcherList();
    vars.watchers.Add(new MemoryWatcher<float>(new DeepPointer(baseAddress[0], 0x8, 0x9D4, 0x5C)){ Name = "load" });
    vars.watchers.Add(new MemoryWatcher<uint>(new DeepPointer(baseAddress[0], 0x8, 0x9C4, 0x7C)){ Name = "level" });
    vars.watchers.Add(new MemoryWatcher<uint>(new DeepPointer(baseAddress[0], 0x8, 0xAF4, 0x20)){ Name = "activeMissions" });
    vars.watchers.Add(new MemoryWatcher<float>(new DeepPointer(baseAddress[1])){ Name = "xPos" });
    vars.watchers.Add(new MemoryWatcher<bool>(new DeepPointer(baseAddress[2], 0x4)){ Name = "paused" });
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(baseAddress[3], 0x12D8)){ Name = "menuState" });
    vars.watchers.Add(new MemoryWatcher<uint>(new DeepPointer(baseAddress[3], 0x12DC)){ Name = "dialogType" });
    vars.watchers.Add(new MemoryWatcher<uint>(new DeepPointer(baseAddress[4], 0x0, 0x94, 0x598)){ Name = "playerState" });

    vars.splitNextMission = true;
}

update
{
    vars.watchers.UpdateAll(game);
}

isLoading
{
    return vars.watchers["load"].Current != 0.0;
}

start
{
    if (settings["start_mb"]) {
        // If current level is Somewhere in France
        if (vars.watchers["level"].Current == 1) {
            double deltaStartPos = Math.Abs(vars.watchers["xPos"].Old) - Math.Abs(-16.57965);
            // If old xpos is virtually the start position
            if ((deltaStartPos > -0.00001) && (deltaStartPos < 0.00001)) {
                // If game resumed
                if (vars.watchers["paused"].Old && !vars.watchers["paused"].Current) {
                    // Return if a textbox dialog was closed
                    return vars.watchers["menuState"].Current == 13 && vars.watchers["dialogType"].Current == 7;
                }
            }
        }
    }
}

onStart
{
    vars.splitNextMission = true;
}

split
{
    uint numCurrentActiveMissions = vars.watchers["activeMissions"].Current >> 0xe;
    uint numOldActiveMissions = vars.watchers["activeMissions"].Old >> 0xe;

    // Level splitting
    if (vars.watchers["level"].Changed) {
        if (settings["split_missions_disableDW_"+vars.watchers["level"].Current.ToString()]) {
            vars.splitNextMission = false;
        }

        if (vars.watchers["level"].Current == 3 || vars.watchers["level"].Current == 5 || vars.watchers["level"].Current == 7 || vars.watchers["level"].Current == 9 || vars.watchers["level"].Current == 23) {
            return settings[vars.watchers["level"].Old.ToString()+"to"+vars.watchers["level"].Current.ToString()];
        }
        else if (settings["split_levels_"+vars.watchers["level"].Current.ToString()])
        {
            return true;
        }
    }

    // Mission Splitting
    if (settings["split_missions"]) {
        bool shouldSplit = settings["instantMissionSplit"] ? (vars.watchers["menuState"].Old != 1 && vars.watchers["menuState"].Current == 1) : (vars.watchers["menuState"].Old == 5 && vars.watchers["menuState"].Current == 13);
        string missionMenu = (vars.watchers["dialogType"].Current == 3) ? "missionCompletedBook" : (vars.watchers["dialogType"].Current == 5) ? "missionFailedBook" : (vars.watchers["dialogType"].Current == 13) ? "missionCompletedLevelSuccessBook" : (vars.watchers["dialogType"].Current == 23) ? "collectionComplededBook" : null;

        if (shouldSplit && missionMenu != null) {
            if (!vars.splitNextMission) vars.splitNextMission = true;
            else if (settings["split_missions_"+missionMenu+vars.watchers["level"].Current.ToString()]) return true;
        }

        // Bone Sequence Break
        if (settings["split_missions_bsb"] && vars.watchers["level"].Current == 5) {
            if (vars.watchers["playerState"].Current >= 45 && vars.watchers["playerState"].Current <= 53) {
                if (vars.watchers["xPos"].Current >= 2 && vars.watchers["xPos"].Current <= 3.2) {
                    if (numCurrentActiveMissions < numOldActiveMissions) return true;
                }
            }
        }
    }

    if (numCurrentActiveMissions < numOldActiveMissions) {
        if (settings["split_chase_"+vars.watchers["level"].Current.ToString()]) return true;
    }


    if ((vars.watchers["playerState"].Old != 134 && vars.watchers["playerState"].Current == 134) || (vars.watchers["playerState"].Old != 134 && vars.watchers["playerState"].Old != 145 && vars.watchers["playerState"].Current == 145)) {
        if (settings["split_deaths_"+vars.watchers["level"].Current.ToString()]) return true;
    }
}

reset
{
    if (vars.watchers["level"].Current == 1) {
        return vars.watchers["dialogType"].Current == 1 && vars.watchers["activeMissions"].Current >> 0xe == 1;
    }
}

// NiV-L-A, ThePhotoshopMaster, Sabe and SplasBoi