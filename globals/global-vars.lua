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


function ZG.Player_Info(method)
	if method == "class" then
		local _,class = UnitClass("player")
		ZG.class = class
		method = class 
	elseif method == "faction" then
		local faction = UnitFactionGroup("player")
		ZG.faction = faction
		method = faction
	elseif method == "race" then
		local _,race = UnitRace("player")
		ZG.race = race
		method = race
	elseif method == "sex" then
		local sex = UnitSex("player")
		ZG.sex = sex
		method = sex
	elseif method == "playerSpec" then
		local playerSpec = GetSpecialization(false,false)
		ZG.playerSpec = playerSpec
		method = playerSpec
	elseif method == "playerName" then
		local playerName = UnitName("player")
		ZG.playerName = playerName
		method = playerName
	elseif method == "petSpec" then
		local petSpec = GetSpecialization(false,true)
		ZG.petSpec = petSpec
		method = petSpec
	elseif method == "level" then
		local level = UnitLevel("player")
		ZG.level = level
		method = level
	elseif method == "eLevel" then
		local eLevel = UnitEffectiveLevel("player")
		ZG.eLevel = eLevel
		method = eLevel
		-- prints zonetext
	elseif method == "z" then
		local z, m, mA, mP = GetZoneText(), "", "", ""
		ZG.z = z
		method = z
	elseif method == "slBP" then
		local z = GetZoneText()
		local level = UnitLevel("player")
		local eLevel = UnitEffectiveLevel("player")
		local slBP = C_Covenants.GetActiveCovenantID(ZG.covenantsEnum)
		if (slBP == 0 and ((level > 50 or eLevel > 50) and (level < 60 or eLevel < 60)) and ZG.slZones[z]) or (slBP == 0 and ZG.slZones[z]) then
			slBP = 5
		elseif slBP == 0 and ((level > 50 or eLevel > 50) and (level < 60 or eLevel < 60)) and not ZG.slZones[z] then
			slBP = 6
		end
		ZG.slBP = slBP
		method = slBP
	elseif method == "classk" then
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
		method = classk
	else
		method = "invalid"
	end

	if method == "invalid" then
		print("ZG.Player_Info: You didn't supply a valid method, try again")
	else
		return method
	end
end

function ZG.Player_Aura(aura) 
	if aura ~= nil then
		local state = C_UnitAuras.GetAuraDataBySpellName("player", aura)
		return state
	else
		print("ZG.Player_Aura: aura supplied was nil")
	end	
end

function ZG.Item_Count(item)
	if item ~= nil then
		local number = C_Item.GetItemCount(item)
		return number
	else
		print("ZG.Item_Count: item supplied was nil")
	end
end

function ZG.Instance_Info(payload)
	local instanceName, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo()
	if payload == "instanceName" then 
		ZG.instanceName = instanceName
		payload = instanceName
	elseif payload == "instanceType" then 
		ZG.instanceType = instanceType
		payload = instanceType
	elseif payload == "difficultyID" then 
		ZG.difficultyID = difficultyID
		payload = difficultyID
	elseif payload == "difficultyName" then 
		ZG.difficultyName = difficultyName
		payload = difficultyName
	elseif payload == "maxPlayers" then 
		ZG.maxPlayers = maxPlayers
		payload = maxPlayers
	elseif payload == "dynamicDifficulty" then 
		ZG.dynamicDifficulty = dynamicDifficulty
		payload = dynamicDifficulty
	elseif payload == "isDynamic" then 
		ZG.isDynamic = isDynamic
		payload = isDynamic
	elseif payload == "instanceID" then 
		ZG.instanceID = instanceID
		payload = instanceID
	elseif payload == "instanceGroupSize" then 
		ZG.instanceGroupSize = instanceGroupSize
		payload = instanceGroupSize
	elseif payload == "LfgDungeonID" then
		ZG.LfgDungeonID = LfgDungeonID
		payload = LfgDungeonID
	else 
		payload = "invalid"
	end
	-- print(payload)
	if payload == "invalid" then
		print("ZG.Instance_Info: You didn't supply a valid payload, try again")
	else
		return payload
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
		print("Info: Something went wrong with World_Event")
	end
end
