-- Huvudfunktion, Togglar pets, sätter player titel
function ZigiRunSwapper()

	local slBP = ZG.Player_Info("slBP")
	local class = ZG.Player_Info("class")
	local classk = ZG.Player_Info("classk")
	local race = ZG.Player_Info("race")
	local faction = ZG.Player_Info("faction")
	local level = ZG.Player_Info("level")
	local eLevel = ZG.Player_Info("eLevel")
	local playerSpec = ZG.Player_Info("playerSpec")
	local playerName = ZG.Player_Info("playerName")
	local z = ZG.Player_Info("z")
	local difficultyID = ZG.Instance_Info("difficultyID")
	local instanceType = ZG.Instance_Info("instanceType")
	local instanceName = ZG.Instance_Info("instanceName")
	local gHI = ZG.World_Event()

	local SST = {}

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
		["SENTINEL_HUNTER"] = {
			[1] = {"Watcher of the Huntress","Darkshore Sentinel"},
			[2] = {"Watcher of the Huntress","Darkshore Sentinel"},
			[3] = {"Watcher of the Huntress","Darkshore Sentinel"},
		},
		["SENTINEL_WARRIOR"] = {
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
   	if (slBP == 0 and ((level > 50 or eLevel > 50) and (level < 60 or eLevel < 60)) and ZG.slZones[z]) or (slBP == 0 and ZG.slZones[z]) then
		SST[playerSpec] = 462 --"Maw Walker"
	elseif slBP == 0 and ((level > 50 or eLevel > 50) and (level < 60 or eLevel < 60)) and not ZG.slZones[z] then
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
		pets = petTable[classk[playerSpec]]
		for k,v in pairs(petTable) do
			if k == class then
				for i,j in ipairs(petTable[classk]) do
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

	local playerSpec = ZG.Player_Info("playerSpec")
	local difficultyID = ZG.Instance_Info("difficultyID")
	local instanceType = ZG.Instance_Info("instanceType")

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

	local class = ZG.Player_Info("class")
	local instanceType = ZG.Instance_Info("instanceType")
	local difficultyID = ZG.Instance_Info("difficultyID")
	local faction = ZG.Player_Info("faction")
	local gHI = ZG.World_Event()

	local hasBell = "\n/use B. F. F. Necklace"
	local pepeState = ""
	local swapToy = ""

	if GetItemCount("Ancient Tauren Talisman") == 1 then
		hasBell = "\n/use Ancient Tauren Talisman"
	elseif GetItemCount("Cooking School Bell") >= 1 then
		hasBell = "\n/use Cooking School Bell"
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
		if C_UnitAuras.GetAuraDataBySpellName("player","Festive Pepe") == nil then
			pepeState = "\n/use Festive Trans-Dimensional Bird Whistle"
		end
	elseif (class == "WARLOCK" or class == "DEMONHUNTER") then
		if C_UnitAuras.GetAuraDataBySpellName("player","Pepe") == nil then 
			pepeState = "\n/use A Tiny Set of Warglaives"
		end
	elseif C_UnitAuras.GetAuraDataBySpellName("player","Pepe") == nil then
		pepeState = "\n/use Trans-Dimensional Bird Whistle"
	else
		pepeState = ""
	end

	-- Timewalking
	if (difficultyID == 24 or difficultyID == 33) or PlayerGetTimerunningSeasonID() == 1 then
		if not C_UnitAuras.GetAuraDataBySpellName("player","Accelerated Time") then
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