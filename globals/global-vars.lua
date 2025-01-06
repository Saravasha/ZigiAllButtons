ZG = {}

-- Static vars set into ZG parent table, invocable throughout the global scope
-- equipment sets
ZG.EQS = {
	[1] = "Noon!",
	[2] = "DoubleGate",
	[3] = "Menkify!",
	[4] = "Supermenk",
	[5] = "",
}

-- Sätta overrides för 5 = Mawsworn och 6 = Enlightened, så får vi fler customisations options på klassnivå.
ZG.covenantsEnum = {
	1,
	2,
	3,
	4,
	5,
	6,
}

-- Outdoor zones where flying is disabled
ZG.groundAreas = {
	-- Kalimdor
	["Ammen Vale"] = true,
	["Azuremyst Isle"] = true,
	["Bloodmyst Isle"] = true,
	["The Exodar"] = true,
	-- Eastern Kingdoms
	["Sunstrider Isle"] = true,
	["Eversong Woods"] = true,
	["Ghostlands"] = true,
	["Silvermoon City"] = true,
	["Isle of Quel'Danas"] = true,
	-- Darkmoon Faire
	["Darkmoon Faire"] = true,
	["Darkmoon Island"] = true,
	-- Cataclysm
	["Tol Barad Peninsula"] = true,
	["Tol Barad"] = true,
	["Molten Front"] = true,
	-- Pandaria
	["Isle of Thunder"] = true,
	["Mogu Island Daily Area"] = true, -- Isle of Thunder
	["Isle of Giants"] = true,
	["Timeless Isle"] = true,
	-- Draenor
	["Tanaan Jungle Intro"] = true,
	-- Broken Isles
	["Helheim"] = true,
	["Niskara"] = true,
	-- Order Halls
	["The Maelstrom"] = true,
	["Mardum, the Shattered Abyss"] = true,
	["Skyhold"] = true,
	["The Wandering Isle"] = true,
	["Dreadscar Rift"] = true,
	["Emerald Dreamway"] = true,
	["Malorne's Nightmare"] = true, -- Druid Emerald Dream Scenario
	["Artifact - The Vortex Pinnacle - Shaman Order Hall"] = true, -- Shaman Skywall Scenario
	["Firelands_Artifact"] = true, -- Shaman Firelands Scenario
	["Death Knight Campaign - Scarlet Monastery"] = true, -- Death Knight Scarlet Monastery Scenario
	-- Argus
	["Krokuun"] = true,
	["Antoran Wastes"] = true,
	["Mac'Aree"] = true, -- Removed in 9.1.5 but still used in API in some places
	["Eredath"] = true,
	["Invasion Points"] = true,
	-- Battle for Azeroth
	["8.1 Darkshore Alliance Quests"] = true, -- Darkshore Unlock Scenario
	["8.1 Darkshore Horde Quests"] = true, -- Darkshore Unlock Scenario
	["Mechagon City"] = true,
	["The Great Sea Horde"] = true, -- Horde War Campaign Scenario
	["Crapapolis"] = true, -- Goblin Heritage
	["Crapapolis - Scenario"] = true,
	["Vale of Eternal Twilight"] = true, -- Vision of N'Zoth
	["Vision of the Twisting Sands"] = true, -- Vision of N'Zoth
	-- Shadowlands
	["Shadowlands"] = true,
	["Oribos"] = true,
	["Maldraxxus Broker Islands"] = true, -- Shattered Grove
	["The Maw"] = true,
	["Korthia"] = true,
	["Caverns of Contemplation"] = true, -- Korthia
	["Torghast"] = true,
	["Font of Fealty"] = true, -- Chains of Domination Campaign Scenario
	["Tazavesh, the Veiled Market"] = true,
}

-- Garrisons Map IDs
ZG.garrisonId = { 
	[1152] = true, 
	[1330] = true,
	[1153] = true,
	[1158] = true,
	[1331] = true,
	[1159] = true, 
}

ZG.twwZones = {
	["Isle of Dorn"] = true,
	["The Ringing Deeps"] = true,
	["Hallowfall"] = true,
	["Azj-Kahet"] = true,
	["Khaz Algar"] = true,
}

ZG.dfZones = {
	["Ohn'ahran Plains"] = true,
	["Thaldraszus"] = true,
	["The Azure Span"] = true,
	["The Waking Shores"] = true,
	["The Forbidden Reach"] = true, 
	["Valdrakken"] = true,
	["The Roasted Ram"] = true,
	["The Dragon's Hoard"] = true,
	["Temporal Conflux"] = true,
	["The Primalist Future"] = true,
	["Zaralek Cavern"] = true,
	["Emerald Dream"] = true,
}

ZG.slZones = {
	["Cosmic"] = true,
	["Bastion"] = true,
	["The Necrotic Wake"] = true,
	["Maldraxxus"] = true,
	["House of Plagues"] = true,
	["Ardenweald"] = true,
	["Revendreth"] = true,
	["The Shadowlands"] = true,
	["Oribos"] = true,
	["The Maw"] = true,
	["Sanctum of Domination"] = true,
	["Korthia"] = true,
	["Zereth Mortis"] = true,
}

ZG.bfaZones = {
	["Zandalar"] = true,
	["Kul Tiras"] = true,
	["Zuldazar"] = true,
	["Boralus"] = true,
	["Dazar'alor"] = true,
	["Tiragarde Sound"] = true,
	["Nazjatar"] = true,
	["Damprock Cavern"] = true,
	["Boralus Harbor"] = true,
	["Tradewinds Market"] = true,
}


function ZG.Player_Info(payload)
	
	if payload == "class" then
		local _,class = UnitClass("player")
		ZG.class = class
		payload = class 
	elseif payload == "faction" then
		local faction = UnitFactionGroup("player")
		ZG.faction = faction
		payload = faction
	elseif payload == "race" then
		local _,race = UnitRace("player")
		ZG.race = race
		payload = race
	elseif payload == "sex" then
		local sex = UnitSex("player")
		ZG.sex = sex
		payload = sex
	elseif payload == "playerSpec" then
		local playerSpec = GetSpecialization(false,false)
		ZG.playerSpec = playerSpec
		payload = playerSpec
	elseif payload == "playerName" then
		local playerName = UnitName("player")
		ZG.playerName = playerName
		payload = playerName
	elseif payload == "petSpec" then
		local petSpec = GetSpecialization(false,true)
		ZG.petSpec = petSpec
		payload = petSpec
	elseif payload == "level" then
		local level = UnitLevel("player")
		ZG.level = level
		payload = level
	elseif payload == "eLevel" then
		local eLevel = UnitEffectiveLevel("player")
		ZG.eLevel = eLevel
		payload = eLevel
		-- prints zonetext
	elseif payload == "z" then
		local z, m, mA, mP = GetZoneText(), "", "", ""
		ZG.z = z
		payload = z
	elseif payload == "slBP" then
		local slBP = C_Covenants.GetActiveCovenantID(ZG.covenantsEnum)
		ZG.slBP = slBP
		payload = slBP
	elseif payload == "classk" then
		local _,class = UnitClass("player")
		local _,race = UnitRace("player")
		local playerName = UnitName("player")
		local classk = class
		-- custom classes indexed in classk
		if (playerName == "Stabbin" and class == "HUNTER" and race == "Goblin") then
			classk = "PIRATE"
		elseif (race == "NightElf" and class == "HUNTER") then
			classk = "SENTINEL_HUNTER"
		elseif (race == "NightElf" and class == "WARRIOR") then
			classk = "SENTINEL_WARRIOR"		
		elseif (playerName == "Mortalia" and class == "HUNTER" and race == "BloodElf") then
			classk = "DARKRANGER"
		end
		ZG.classk = classk
		payload = classk
	end

	if payload ~= nil then
		return payload
	else
		return print("ZG.Player_Info: You didn't supply a valid payload, try again")
	end

end


function ZG.Instance_Info(payload)
	local instanceName, instanceType, difficultyID, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance, mapID, instanceGroupSize = GetInstanceInfo()
	if payload == "InstanceName" then 
		payload = instanceName
	elseif payload == "instanceType" then 
		payload = instanceType
	elseif payload == "InstanceName" then 
		payload = instanceName
	elseif payload == "difficultyID" then 
		payload = difficultyID
	elseif payload == "difficultyName" then 
		payload = difficultyName
	elseif payload == "maxPlayers" then 
		payload = maxPlayers
	elseif payload == "playerDifficulty" then 
		payload = playerDifficulty
	elseif payload == "isDynamicInstance" then 
		payload = isDynamicInstance
	elseif payload == "mapID" then 
		payload = mapID
	elseif payload == "instanceGroupSize" then 
		payload = instanceGroupSize
	end
	if payload ~= nil then
		return payload
	else
		return print("ZG.Instance_Info: You didn't supply a valid payload, try again")
	end
end


function ZG.World_Event()
	C_Calendar.SetMonth(0)
	local gHI = C_Calendar.GetHolidayInfo(0, C_DateAndTime.GetCurrentCalendarTime().monthDay, 1) and C_Calendar.GetHolidayInfo(0, C_DateAndTime.GetCurrentCalendarTime().monthDay, 1).name or ""

	local holidays = {
		"Lunar Festival", 
		"Love is in the Air", 
		"Noblegarden", 
		"Children's Week",
		"Midsummer Fire Festival", 
		"Brewfest", 
		"Hallow's End", 
		"Pilgrim's Bounty",
		"Feast of Winter Veil",
	}

	for i=1,C_Calendar.GetNumDayEvents(0, C_DateAndTime.GetCurrentCalendarTime().monthDay) do
		for h, holidays in pairs(holidays) do 
			if holidays == C_Calendar.GetHolidayInfo(0, C_DateAndTime.GetCurrentCalendarTime().monthDay, i).name then
				gHI = holidays
			end
		end
	end
	if gHI ~= nil then
		return gHI
	else
		return print("Info: Something went wrong with World_Event")
	end
end
