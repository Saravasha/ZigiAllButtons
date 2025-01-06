-- Huvudfunktion, Togglar pets, sätter player titel
function ZigiRunSwapper()

		local faction = UnitFactionGroup("player")
	local _,class = UnitClass("player")
	local _,race = UnitRace("player")
	local sex = UnitSex("player")
	local playerSpec = GetSpecialization(false,false)
	local SST = {}
	local playerName = UnitName("player")
	local level = UnitLevel("player")
	local eLevel = UnitEffectiveLevel("player")


	local instanceName, instanceType, difficultyID, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance, mapID, instanceGroupSize = GetInstanceInfo()

		local covenantsEnum = {
		1,
		2,
		3,
		4,
		5,
		6, 
	}

	local slBP = C_Covenants.GetActiveCovenantID(covenantsEnum)
	local classk = ""
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

	-- local SST = {}
	-- local playerSpec = ZG.playerSpec() or ""
	local factionWarPet = "Lil' War Machine"
	local factionMurloc = "Gillvanas"
	local pets = {}
	local sq = "Sergeant Quackers"
	local ds = "Dutiful Squire"
	local as = "Argent Squire"

	if faction == "Alliance" then
		factionWarPet = "Lil' Siege Tower"
		factionMurloc = "Finduin"
	elseif faction == "Horde" then
		sq = "Dart"
		ds = "Dutiful Gruntling"
		as = "Argent Gruntling"
	end

		local z, m, mA, mP = GetZoneText(), "", "", ""
	-- Outdoor zones where flying is disabled
	local groundAreas = {
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
	local garrisonId = { [1152] = true, [1330] = true, [1153] = true, [1158] = true, [1331] = true, [1159] = true, }

	local dfZones = {
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

	local slZones = {
		["Cosmic"] = true,
		["Bastion"] = true,
		["Maldraxxus"] = true,
		["Ardenweald"] = true,
		["Revendreth"] = true,
		["The Shadowlands"] = true,
		["Oribos"] = true,
		["The Maw"] = true,
		["Korthia"] = true,
		["Zereth Mortis"] = true,
	}

	local bfaZones = {
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

	local petTable = {
		["SHAMAN"] = {
			[1] = {"Snowfang","Pebble","Zephyrian Prince","Lil' Ragnaros","Blaise"}, 
			[2] = {"Frostwolf Ghostpup","Pebble","Primal Stormling"},
			[3] = {"Snowfang","Bound Stream","Pebble","Drafty"},
		},
		["MAGE"] = {
			[1] = {"Lil' Tarecgosa","Trashy","Wondrous Wisdomball","Sarge","Aura"},
			[2] = {"Phoenix Hatchling","Animated Tome","Nethaera's Light","Sarge","Aura"},
			[3] = {"Magical Crawdad","Water Waveling","Tiny Snowman","Sarge","Aura"},
		},
		["WARLOCK"] = {
			[1] = {"Eye of the Legion","Cross Gazer","Sister of Temptation","Nibbles","Baa'lial","Gill'dan"},
			[2] = {"Rebellious Imp","Lesser Voidcaller","Cross Gazer","Eye of the Legion","Sister of Temptation","Nibbles","Baa'l","Netherspace Abyssal","Baa'lial","Gill'dan"},
			[3] = {"Rebellious Imp","Lesser Voidcaller","Netherspace Abyssal","Eye of the Legion","Nibbles","Baa'lial","Gill'dan"},
		},
		["MONK"] = {
			[1] = {"Zao, Calfling of Niuzao","Ban-Fu, Cub of Ban-Lu","Comet"},
			[2] = {"Chi-Chi, Hatchling of Chi-Ji","Yu'la, Broodling of Yu'lon","Hoplet","Ban-Fu, Cub of Ban-Lu","Comet"},
			[3] = {"Xu-Fu, Cub of Xuen","Ban-Fu, Cub of Ban-Lu","Comet"},
		},
		["PALADIN"] = {
			[1] = {"K'ute","Uuna","Bound Lightspawn", factionMurloc,as},
			[2] = {"K'ute","Uuna","Bound Lightspawn", factionMurloc,as},
			[3] = {"K'ute","Uuna","Bound Lightspawn", factionMurloc,as},
		},
		["HUNTER"] = {
			[1] = {"Rocket Chicken","Nuts","Tito","Stormwing","Son of Skum","Bakar Companion","Ohuna Companion","Watcher of the Huntress"},
			[2] = {"Alarm-o-Bot","Tito","Stormwing","Crow","Bakar Companion","Ohuna Companion","Watcher of the Huntress"},
			[3] = {"Teroclaw Hatchling","Nuts","Tito","Stormwing","Crow","Bakar Companion","Ohuna Companion","Watcher of the Huntress"},
		},
		["ROGUE"] = {
			[1] = {"Toxic Wasteling","Sneaky Marmot","Creepy Crate"},
			[2] = {"Pocket Cannon","Captain Nibs","Cap'n Crackers","Barnaby"},
			[3] = {"Bronze Whelpling","Gilnean Raven","Sneaky Marmot"},
		},
		["PRIEST"] = {
			[1] = {"Argi","K'ute","Dread Hatchling","Shadow","Uuna",as},
			[2] = {"Bound Lightspawn","K'ute","Sunborne Val'kyr","Uuna"},
			[3] = {"K'ute","Hungering Claw","Dread Hatchling","Faceless Minion","Jenafur","Happiness"},
		},
		["DEATHKNIGHT"] = {
			[1] = {"Arfus","Boneshard","Mr. Bigglesworth","Naxxy","Bloodbrood Whelpling","Gruesome Belcher"},
			[2] = {"Arfus","Boneshard","Mr. Bigglesworth","Naxxy","Frostbrood Whelpling","Lil' K.T."},
			[3] = {"Arfus","Boneshard","Mr. Bigglesworth","Naxxy","Vilebrood Whelpling","N'Ruby","Putrid Geist","Gruesome Belcher","Grotesque"},
		},
		["WARRIOR"] = {
			[1] = {"Darkmoon Rabbit","Brul","Garrlok", factionWarPet, factionMurloc,sq,ds},
			[2] = {"Sunborne Val'kyr","Garrlok", factionWarPet, factionMurloc,sq,ds},
			[3] = {"Darkmoon Rabbit","Brul","Garrlok", factionWarPet, factionMurloc,sq,ds},
		},
		["DRUID"] = {
			[1] = {"Stardust","Singing Sunflower","Ragepeep","Slyvy"},
			[2] = {"Cinder Kitten","Singing Sunflower"},
			[3] = {"Lil' Ursoc","Singing Sunflower"},
			[4] = {"Blossoming Ancient","Singing Sunflower"},
		},
		["DEMONHUNTER"] = {
			[1] = {"Murkidan","Emmigosa","Abyssius","Micronax","Wyrmy Tunkins","Fragment of Desire"},
			[2] = {"Murkidan","Emmigosa","Abyssius","Micronax","Wyrmy Tunkins","Fragment of Desire"},
		},
		["EVOKER"] = {
			[1] = {"Drakks","Murkastrasza","Spyragos","Viridescent Duck","Mote of Nasz'uro", "Mallard Duckling"},
			[2] = {"Drakks","Murkastrasza","Spyragos","Viridescent Duck","Mote of Nasz'uro", "Mallard Duckling"},
			[3] = {"Drakks","Murkastrasza","Spyragos","Viridescent Duck","Mote of Nasz'uro", "Mallard Duckling"},
		},
		["PIRATE"] = {
			[1] = {"Fathom","Sea Gull","Barnaby","Captain Nibs","Crackers","Greatwing Macaw","Pocket Cannon","Tideskipper","Cap'n Crackers"},
			[2] = {"Fathom","Sea Gull","Barnaby","Captain Nibs","Crackers","Greatwing Macaw","Pocket Cannon","Tideskipper","Cap'n Crackers"},
			[3] = {"Fathom","Sea Gull","Barnaby","Captain Nibs","Crackers","Greatwing Macaw","Pocket Cannon","Tideskipper","Cap'n Crackers"},
		},
		["SENTINEL"] = {
			[1] = {"Watcher of the Huntress","Darkshore Sentinel"},
			[2] = {"Watcher of the Huntress","Darkshore Sentinel"},
			[3] = {"Watcher of the Huntress","Darkshore Sentinel"},
		},
		["DARKRANGER"] = {
			[1] = {"Cobalt Raven","Spectral Raven","Infected Fawn","Blighthawk","Blighted Squirrel","Gillvanas"},
			[2] = {"Cobalt Raven","Spectral Raven","Infected Fawn","Blighthawk","Blighted Squirrel","Gillvanas"},
			[3] = {"Cobalt Raven","Spectral Raven","Infected Fawn","Blighthawk","Blighted Squirrel","Gillvanas"},
		},
	}

	local covPets = {
		[0] = {"Terky","Gurgl","Murgle","Squirky","Glimr"},
		[1] = {"Ruffle","Lost Featherling","Steward Featherling","Courage","Purity","Larion Pouncer","Helpful Glimmerfly"},
		[2] = {"Sinheart","Burdened Soul","Dal","Dredger Butler","Will of Remornia","Char"},
		[3] = {"Trootie","Floofa","Gloober, as G'huun","Sir Reginald","Lavender Nibbler","Willowbreeze"},
		[4] = {"Jiggles","Micromancer","Minimancer","Toenail","Shy Melvin","Oonar's Arm","Sludge Feeler"},
		[5] = {"Mawsworn Minion","Ashen Chomper","Deathseeker","Mord'al Eveningstar","Tower Deathroach","Torghast Lurker","Lightless Tormentor","Gilded Darknight","Eye of Allseeing","Eye of Extermination","Eye of Affliction"},
		[6] = {"Pocopoc","Momma Vombata","Tarachnid Stalker","Gizmo","Rarity","Flawless Amethyst Baubleworm","Ruby Baubleworm","Topaz Baubleworm","Turquoise Baubleworm","Anima Wyrmling"},
	}

	-- Main Titles
	if classk == "SHAMAN" then
		SST = {
			-- [1] = 255, --"Mistwalker",
			[1] = 479, --"Farseer", 
			[2] = 302, --"Lord of War",
			[3] = 405, --"of the Deeps",
		}
		if not IsTitleKnown(479) then
			SST[1] = 221 --"the Stormbreaker"
		end
		if sex == 3 then
			SST[2] = 303 --"Lady of War",
		end
	elseif classk == "MAGE" then
		SST = {
			-- [1] = 348, --"Headmistress",
			[1] = 61, --"Archmage", 
			-- [2] = 45, --"Flame Keeper",
			[2] = 503, --"The Smoldering",
			[3] = 681, --"Winter's Envoy",
		}
		if not IsTitleKnown(681) then
			SST[3] = 102 --"Merrymaker"
		end
	elseif classk == "WARLOCK" then
		SST = {
			[1] = 256, --"of The Black Harvest",
			[2] = 302, --"Lord of War",
			[3] = 337, --"Netherlord",
		}
		if sex == 3 then
			SST[2] = 303 --"Lady of War",
		end
	elseif classk == "MONK" then
		SST = {
			[1] = 101, --"Brewmaster", 
			[2] = 255, -- "Mistwalker",
			-- [3] = 205, --"Shado",
			[3] = 209, --"Brawler",
		}
	elseif classk == "PALADIN" then
		SST = {
			[1] = 366, --"The Lightbringer", 
			[2] = 345, --"Highlord",
			[3] = 123, --"Crusader",
		}
	elseif classk == "HUNTER" then
		SST = {
			[1] = 199, --"Zookeeper", 
			[2] = 450, --"Tower Ranger",
			[3] = 59, --"Predator",
		}
	elseif classk == "ROGUE" then
		SST = {
			[1] = 140, --"The Kingslayer", 
			[2] = 317, --"Captain",
			[3] = 338, --"Shadowblade",
		}
	elseif classk == "PRIEST" then
		SST = {
			[1] = 99, --"The Argent Champion", 
			-- [2] = 229, --"Gorgeous",
			[2] = 381, --"Purifier"
			[3] = 112, --"The Insane",
		}					
	elseif classk == "DEATHKNIGHT" then
		SST = {
			[1] = 427, --"Baron", 
			[2] = 437, --"Abominable",
			[3] = 328, --"Deathlord",
		} 					
	elseif classk == "WARRIOR" then
		SST = {
			[1] = 302, --"Lord of War",
			[2] = 302, --"Lord of War",
			[3] = 216, --"The Proven Defender",
		}
		if not IsTitleKnown(216) then
		   SST[3] = 302
		end
		if sex == 3 then
			SST[1] = 303 --"Lady of War",
			SST[2] = 303 --"Lady of War",
			if not IsTitleKnown(216) then
			   SST[3] = 303
			end
		end
	elseif classk == "DRUID" then
		SST = {
			[1] = 129, --"Starcaller", 
			[2] = 252, --"The Crazy Cat Man",
			[3] = 100, --"Guardian of Cenarius",
			[4] = 341, --"the Dreamer",
		}
		if sex == 3 then					
			SST[2] = 240 --"The Crazy Cat Lady",
		end
		if playerName == "Halp" then
			SST[3] = 327 --"Archdruid",
		end
	elseif classk == "DEMONHUNTER" then
		SST = {
			[1] = 367, --"Demonslayer", 
			[2] = 342, --"Vengeance Incarnate",
		}
	elseif classk == "EVOKER" then
		SST = {
			-- [1] = 514, --"of the Infinite",
			-- [1] = 557, --"Awakened Hero",
			[1] = 533, --"The Forbidden",
			-- [2] = 517, --"the Dreaming",
			[2] = 527, --"Blossom Bringer",
			-- [3] = 513, --"Unparalleled",
			[3] = 483, --"Paragon of the Obsidian Brood",
		}
	elseif classk == "PIRATE" then
		SST = {
			[1] = 317, --"Captain", 
			[2] = 317, --"Captain",
			[3] = 541, --"Plunderlord",
		}
	elseif classk == "SENTINEL" then
		SST = {
			[1] = 532, --"Dream Defender", 
			[2] = 532, --"Dream Defender",
			[3] = 532, --"Dream Defender",
		}	
	elseif classk == "DARKRANGER" then
		SST = {
			[1] = 740, --"Malicious", 
			[2] = 740, --"Malicious",
			[3] = 740, --"Malicious",
		}					
	end

	-- local slBP = ZG.slBP()
   	if (slBP == 0 and ((level > 50 or eLevel > 50) and (level < 60 or eLevel < 60)) and slZones[z]) or (slBP == 0 and slZones[z]) then
		slBP = 5
		SST[playerSpec] = 462 --"Maw Walker"
	elseif slBP == 0 and ((level > 50 or eLevel > 50) and (level < 60 or eLevel < 60)) and not slZones[z] then
		slBP = 6
		SST[playerSpec] = 463 --"Veilstrider"
	end

	if C_EquipmentSet.GetEquipmentSetID("Casual") == nil then
		MakeEqSet("Casual")
	end

	if covPets[slBP] then
		covPets = covPets[slBP]
		covPets = covPets[random(#covPets)]
	end

	if (class == "SHAMAN" and race == "Troll") then
		pets = {"Sen'jin Fetish","Lashtail Hatchling","Searing Scorchling","Mojo"}
	elseif (playerName == "Fannylands" and playerSpec == 3) then
		pets = {"Nightmare Whelpling","Nightmare Lasher","Nightmare Treant"}
	elseif playerSpec ~= 5 then
		pets = petTable[class[playerSpec]]
		for k,v in pairs(petTable) do
			if k == class then
				for i,j in ipairs(petTable[class]) do
					if i == playerSpec then
						pets = j
						-- for g, d in pairs(pets) do
						-- 	print(d)
						-- end
					end
				end
			end
		end
		pets = {pets[random(#pets)],covPets}
		-- for k,v in ipairs(pets) do
		-- 	print(k,v)
		-- end
	else 
		pets = {covPets}
	end

	-- Holiday Overrides
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

	-- print("gHI = ", GWE())
	if gHI == "Lunar Festival" then
		SST[playerSpec] = 43 --"Elder"
		pets = {"Sky Lantern"}
		if faction == "Alliance" then
			pets = {"Lunar Lantern"}
		elseif faction == "Horde" then
			pets = {"Festival Lantern"}
		end
	elseif gHI == "Love is in the Air" then
		SST[playerSpec] = 103 --"the Love Fool"
		pets = {"Lovebird Hatchling","Peddlefeet","Toxic Wasteling","Heartseeker Moth"}
	elseif gHI == "Noblegarden" then
		SST[playerSpec] = 122 --"the Noble"
		pets = {"Noblegarden Bunny","Mystical Spring Bouquet","Spring Rabbit","Lovely Duckling"}
	elseif gHI == "Children's Week" then
		if sex == 2 then
			SST[playerSpec] = 105 --"Patron"
		elseif sex == 3 then
			SST[playerSpec] = 104 --"Matron"
		end
		pets = {"Beakbert","Curious Oracle Hatchling","Curious Wolvar Pup","Egbert","Froglet","Legs","Mr. Crabs","Mr. Wiggles","Peanut","Scaley","Scooter the Snail","Speedy","Whiskers the Rat","Willy"}
	elseif gHI == "Midsummer Fire Festival" then
		SST[playerSpec] = 45 --"Flame Keeper"
		pets = {"Blazing Cindercrawler","Frigid Frostling","Igneous Flameling","Spirit of Summer"}
	elseif gHI == "Brewfest" then
		SST[playerSpec] = 101 --"Brewmaster"
		pets = {"Pint-Sized Pink Pachyderm","Stout Alemental","Wolpertinger"}
	elseif gHI == "Hallow's End" then
		SST[playerSpec] = 92 --"the Hallowed"
		pets = {"Creepy Crate","Cursed Birman","Feline Familiar","Ghastly Rat","Ghost Maggot","Naxxy","Sinister Squashling","Spectral Spinner","Widget the Departed"}
	elseif gHI == "Pilgrim's Bounty" then
		SST[playerSpec] = 133 --"the Pilgrim"
		pets = {"Bush Chicken","Plump Turkey"}
	elseif gHI == "Feast of Winter Veil" then
		SST[playerSpec] = 102 --"Merrymaker"
		pets = {"Mitzy","Clockwork Rocket Bot","Father Winter's Helper","Winter's Little Helper","Rotten Little Helper","Globe Yeti","Grumpling","Jingles","Lumpy","Tiny Snowman","Winter Reindeer","Grunch","Portentous Present"}
	end

	if C_PvP.IsWarModeActive() == true or instanceType == "pvp" or instanceType == "arena" then
		SST[playerSpec] = 383 -- Contender
		local pvpTitles = {
			94,  --"of the Alliance",
			95,  --"of the Horde",
			229,  --"Gorgeous",
			302, -- "Lord of War", 
			303, -- "Lady of War",
			321,  --"The Honorable",
			322,  --"The Prestigious",
			323,  -- "The Unrelenting",
			325,  --"Bound by Honor",
			354,  --"the Unstoppable Force",
			376,  --"the Alliance Slayer",
			
			--  --"the Horde Slayer",
			-- "the Tactician",
			-- "Patron of War",
			-- "the Bloodthirsty",
			-- "Battlemaster",
			-- "Prospector",
			-- "Conqueror of Azeroth",
		}

		pvpTitles = pvpTitles[random(#pvpTitles)]
		if not IsTitleKnown(pvpTitles) then 
			return
		else
			SST[playerSpec] = pvpTitles
			pets = {"Dutiful Gruntling","Horde Fanatic","Tanzil","Horde Balloon"}
			if faction == "Alliance" then
				pets = {"Dutiful Squire","Alliance Enthusiast","Trecker","Alliance Balloon"}
			end
		end			
	end

	if IsEquippedItem("Mirror of the Blademaster") or (difficultyID == 24 or difficultyID == 33) then
		SST[playerSpec] = 361 -- Timelord title
		pets = {"Infinite Whelpling","Timeless Mechanical Dragonling","Ominous Flame","Paradox Spirit"}
	end
	--Timerunning
	if PlayerGetTimerunningSeasonID() == 1 then
		if IsTitleKnown(306) then
			SST[playerSpec] = 306 -- Legend of Pandaria title
		elseif IsTitleKnown(361) then
			SST[playerSpec] = 361-- Timelord
		end
		pets = {"Infinite Whelpling","Timeless Mechanical Dragonling","Ominous Flame","Paradox Spirit"}
	end

	-- New baby alt
	if eLevel < 10 then
		SST[playerSpec] = 557 --"Awakened Hero"
		-- 137 -- the Patient Title
	end

	-- Rested area pet and title
	if IsResting() then 
		SST[playerSpec] = 48 --"the Diplomat"
		pets = {"Hearthy"}
	end

	-- Hard Exceptions
	if playerName == "Noon" then
		SST[playerSpec] = 502 --[["Barter Boss"--]]
		pets = {"Francois"}
	end

	if not InCombatLockdown() then
		local a = pets
		local randPet = math.random(1,#a)
		local _,c = C_PetJournal.FindPetIDByName(a[randPet])
		local parrots = AuraUtil.FindAuraByName(232871 or 286268, "player")
		local b = {"Cap'n Crackers","Crackers"}
		local targetName = UnitName("target") 
		for k,v in pairs(b) do 
			if targetName == v and not parrots then 
				DoEmote("whistle") 
			else 
				if not InCombatLockdown() then
					C_PetJournal.SummonPetByGUID(c)
				end	 
			end
		end 
		
		-- SST[playerSpec] är titel Id som jag vill sätta, titleId är titel Id på Current Title
		local titleId = GetCurrentTitle()
		
		if titleId ~= SST[playerSpec] and SST[playerSpec] ~= nil and IsTitleKnown(SST[playerSpec]) then
			SetCurrentTitle(SST[playerSpec])
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiSwapper: Updating your title :)",0.5,1.0,0.0)
		end
		local t = true
		C_Timer.After(2, function() ZigiSetSwapper() t = false end)
	end
end

function ZigiEqSetSwapper()

	local EQS = {
		[1] = "Noon!",
		[2] = "DoubleGate",
		[3] = "Menkify!",
		[4] = "Supermenk",
		[5] = "Noon!",
	}
	local playerSpec = GetSpecialization(false,false)
	local instanceName, instanceType, difficultyID, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance, mapID, instanceGroupSize = GetInstanceInfo()

	-- chilling in town
	if IsResting() == true then
		EQS[playerSpec] = "Casual"
	end

	-- Timewalking
	if (difficultyID == 24 or difficultyID == 33) then
		EQS[playerSpec] = "Timewalking"
	end

	-- War mode / Pvp / Arena
	if C_PvP.IsWarModeActive() == true or instanceType == "pvp" or instanceType == "arena" then
		EQS[playerSpec] = "PvP"
	end

 	local _, _, _, isEquipped, _, _, _, _, _ = C_EquipmentSet.GetEquipmentSetInfo(C_EquipmentSet.GetEquipmentSetID(EQS[playerSpec]))
	if not InCombatLockdown() then
		if isEquipped == false and EQS[playerSpec] ~= nil then
			C_EquipmentSet.UseEquipmentSet(C_EquipmentSet.GetEquipmentSetID(EQS[playerSpec])) 
		end
		-- print("isEquipped = ", isEquipped)
		-- print("EQS[playerSpec] = ",EQS[playerSpec]) 
	end
end

function ZigiSetSwapper()

	local _,class = UnitClass("player")
	local instanceName, instanceType, difficultyID, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance, mapID, instanceGroupSize = GetInstanceInfo()

	local hasBell = "\n/use B. F. F. Necklace"
	local pepeState = ""
	local swapToy = ""

	if GetItemCount("Ancient Tauren Talisman") == 1 then
		hasBell = "\n/use Ancient Tauren Talisman"
	elseif GetItemCount("Cooking School Bell") >= 1 then
		hasBell = "\n/use Cooking School Bell"
	end	

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

	if gHI == "Lunar Festival" then
		local factionFireworks = "Everlasting Horde Firework"
		if faction == "Alliance" then
			factionFireworks = "Everlasting Alliance Firework"
		end
		swapToy = "\n/use "..factionFireworks.."\n/use Personal Spotlight"
	elseif gHI == "Love is in the Air" then
		swapToy = "\n/use True Love Prism"
	elseif gHI == "Noblegarden" then
		swapToy = "\n/use Eagger Basket\n/use A Drake's Big Basket of Eggs"
	elseif gHI == "Children's Week" then
		hasBell = ""
		swapToy = "\n/use Green Balloon"
	elseif gHI == "Midsummer Fire Festival" then
		swapToy = "\n/use Fire Festival Batons"
	elseif gHI == "Brewfest" then
		swapToy = "\n/use Brew Barrel"
	elseif gHI == "Hallow's End" then
		swapToy = "\n/use Little Wickerman"
	elseif gHI == "Pilgrim's Bounty" then
		swapToy = "\n/use Silver-Plated Turkey Shooter"
	elseif gHI == "Feast of Winter Veil" then
		swapToy = "\n/use Wild Holly"
	end

	if gHI == "Feast of Winter Veil" then 
		if not AuraUtil.FindAuraByName("Festive Pepe", "player") then
			pepeState = "\n/use Festive Trans-Dimensional Bird Whistle"
		end
	elseif (class == "WARLOCK" or class == "DEMONHUNTER") then
		if not AuraUtil.FindAuraByName("Festive Pepe", "player") or not AuraUtil.FindAuraByName("Pepe", "player") then 
			pepeState = "\n/use A Tiny Set of Warglaives"
		end
	elseif not AuraUtil.FindAuraByName("Festive Pepe", "player") or not AuraUtil.FindAuraByName("Pepe", "player") then
		pepeState = "\n/use Trans-Dimensional Bird Whistle"
	else
		pepeState = ""
	end
	
	-- Timewalking
	if (difficultyID == 24 or difficultyID == 33) or PlayerGetTimerunningSeasonID() == 1 then
		if not AuraUtil.FindAuraByName("Accelerated Time", "player") then
			swapToy = "\n/use Investi-gator's Pocketwatch"
		else
			swapToy = ""
		end
	end

	-- War mode / Pvp / Arena
	if C_PvP.IsWarModeActive() == true or instanceType == "pvp" or instanceType == "arena" then
		swapToy = "\n/use Horde War Banner\n/use Rallying War Banner"
		if faction == "Alliance" then
			swapToy = "\n/use Alliance War Banner\n/use Rallying War Banner"
		end			
	end
	
	local toyCollection = swapToy..hasBell..pepeState

	local _,_,body = GetMacroInfo("WSxSwapperBody")
	if not InCombatLockdown() then
		EditMacro("WSxSwapper", nil, nil, (body or "").."\n/stopmacro [combat]"..toyCollection.."\n/run ZigiRunSwapper() ZigiEqSetSwapper()")
	end
end