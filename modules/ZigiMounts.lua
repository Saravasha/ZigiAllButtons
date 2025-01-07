local ZigiMounts = CreateFrame("FRAME", "ZigiMounts")

ZigiMounts:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
ZigiMounts:RegisterEvent("BAG_UPDATE_DELAYED")
ZigiMounts:RegisterEvent("PLAYER_ENTERING_WORLD")
ZigiMounts:RegisterEvent("ZONE_CHANGED_NEW_AREA")
ZigiMounts:RegisterEvent("VARIABLES_LOADED")
ZigiMounts:RegisterEvent("LEARNED_SPELL_IN_TAB")
ZigiMounts:RegisterEvent("PLAYER_FLAGS_CHANGED","player")

local loaded = false
local locked = false


local function eventHandler(event)

	if InCombatLockdown() then
        ZigiMounts:RegisterEvent("PLAYER_REGEN_ENABLED")
    else

		local faction = ZG.Player_Info("faction")
		local race = ZG.Player_Info("race")
		local class = ZG.Player_Info("class")
		local classk = ZG.Player_Info("classk")
		local level = ZG.Player_Info("level")
		local eLevel = ZG.Player_Info("eLevel")
		local slBP = ZG.Player_Info("slBP")
		local z = ZG.Player_Info("z")
		local instanceName = ZG.Instance_Info("instanceName")
		local instanceType = ZG.Instance_Info("instanceType")
		local instanceID = ZG.Instance_Info("instanceID")
		local gHI = ZG.World_Event()
		
		local palaMounts = {
			["Draenei"] = "Summon Exarch's Elekk,Summon Great Exarch's Elekk,",
			["LightforgedDraenei"] = "Summon Lightforged Ruinstrider,",
			["DarkIronDwarf"] = "Summon Darkforge Ram,",
			["Dwarf"] = "Summon Dawnforge Ram,",
			["Tauren"] = "Summon Sunwalker Kodo,Summon Great Sunwalker Kodo,",
			["BloodElf"] = "Elusive Emerald Hawkstrider,Summon Thalassian Warhorse,Summon Thalassian Charger,",
			["Human"] = "Summon Warhorse,Summon Charger,",
			["ZandalariTroll"] = "Crusader's Direhorn,",
		}	

		local groundMount = {
			["SHAMAN"] = "Swift Frostwolf",
			["MAGE"] = "Wild Dreamrunner,Sarge's Tale",
			["WARLOCK"] = "Felblaze Infernal,Wild Dreamrunner,Lucid Nightmare,Illidari Felstalker,Hellfire Infernal,Incognitro, The Indecipherable Felcycle",
			["MONK"] = "Wild Dreamrunner,Swift Zulian Tiger,Lil' Donkey,Little Red Riding Goat",
			["PALADIN"] = "Prestigious Bronze Courser,Argent Charger,Pureheart Courser",
			["HUNTER"] = "Taivan,Spawn of Horridon,Bruce,Llothien Prowler,Ironhoof Destroyer,Alabaster Hyena,Divine Kiss of Ohn'Ahra",
			["ROGUE"] = "Blue Shado-Pan Riding Tiger,Broken Highland Mustang",
			["PRIEST"] = "Trained Meadowstomper, Glorious Felcrusher, Ivory Hawkstrider, Wild Dreamrunner, Pureheart Courser",
			["DEATHKNIGHT"] = "Midnight,Bloodgorged Crawg,Pureheart Courser",
			["WARRIOR"] = "Vicious War Turtle,Infernal Direwolf,Bloodfang Widow,Ironhoof Destroyer",
			["DRUID"] = "Wild Dreamrunner,Kaldorei Nightsaber,Pureheart Courser,Raven Lord",
			["DEMONHUNTER"] = "Felsaber,Wild Dreamrunner,Lucid Nightmare,Grove Defiler,Illidari Felstalker,Incognitro, The Indecipherable Felcycle,Hateforged Blazecycle",
			["EVOKER"] = "",
			["PIRATE"] = "Ratstallion",
			["DARKRANGER"] = "Forsaken Warhorse,Warstitched Darkhound,Battle-Bound Warhound",
		}

		-- Value must start with a ","
		local flyingMount = {
			["SHAMAN"] = ",Spectral Pterrorwing,Grand Wyvern,Kua'fon",
			["MAGE"] = ",Leywoven Flying Carpet,Ashes of Al'ar,Arcanist's Manasaber,Violet Spellwing,Soaring Spelltome,Glacial Tidestorm,Eve's Ghastly Rider",
			["WARLOCK"] = ",Grove Defiler,Headless Horseman's Mount,Felsteel Annihilator,Antoran Gloomhound,Shackled Ur'zul,Eve's Ghastly Rider",
			["MONK"] = "Astral Cloud Serpent",
			["PALADIN"] = ",Highlord's Golden Charger,Lightforged Warframe,Invincible,Tyrael's Charger",
			["HUNTER"] = ",Mimiron's Head,Clutch of Ji-Kun,Armored Skyscreamer,Dread Raven,Darkmoon Dirigible,Spirit of Eche'ro,Spectral Pterrorwing,Divine Kiss of Ohn'Ahra",
			["ROGUE"] = ",Ironbound Wraithcharger,Shadowblade's Murderous Omen,Geosynchronous World Spinner",
			["PRIEST"] = ",Dread Raven,Lightforged Warframe",
			["DEATHKNIGHT"] = ",Invincible,Sky Golem",
			["WARRIOR"] = ",Invincible,Smoldering Ember Wyrm,Valarjar Stormwing,Obsidian Worldbreaker",
			["DRUID"] = ",Sky Golem,Ashenvale Chimaera,Leyfeather Hippogryph",
			["DEMONHUNTER"] = ",Arcanist's Manasaber,Felfire Hawk,Corrupted Dreadwing,Azure Drake,Cloudwing Hippogryph,Leyfeather Hippogryph,Felsteel Annihilator",
			["EVOKER"] = "",
			["PIRATE"] = ",Siltwing Albatross,Gold-Toed Albatross,Quawks,Squawks,Royal Seafeather",
			["DARKRANGER"] = ",Vengeance",
		}

		if faction == "Alliance" then 
			groundMount = { 
				["SHAMAN"] = "",
				["MAGE"] = "Wild Dreamrunner, Sarge's Tale",
				["WARLOCK"] = "Lucid Nightmare,Illidari Felstalker,Hellfire Infernal,Incognitro, The Indecipherable Felcycle",
				["MONK"] = "Wild Dreamrunner,Swift Zulian Tiger,Lil' Donkey,Little Red Riding Goat",
				["PALADIN"] = "Prestigious Bronze Courser,Argent Charger,Pureheart Courser",
				["HUNTER"] = "Taivan,Spawn of Horridon,Bruce,Llothien Prowler,Ironhoof Destroyer",
				["ROGUE"] = "Blue Shado-Pan Riding Tiger,Highland Mustang",
				["PRIEST"] = "Trained Meadowstomper, Glorious Felcrusher, Ivory Hawkstrider, Wild Dreamrunner, Pureheart Courser",
				["DEATHKNIGHT"] = "Midnight,Bloodgorged Crawg,Pureheart Courser",
				["WARRIOR"] = "Vicious War Turtle,Infernal Direwolf,Ironhoof Destroyer",
				["DRUID"] = "Wild Dreamrunner,Kaldorei Nightsaber,Pureheart Courser,Raven Lord",
				["DEMONHUNTER"] = "Felsaber,Wild Dreamrunner,Lucid Nightmare,Grove Defiler,Illidari Felstalker,Incognitro, The Indecipherable Felcycle,Hateforged Blazecycle",
				["EVOKER"] = "",
				["SENTINEL_HUNTER"] = "Snowfluff Dreamtalon",
				["SENTINEL_WARRIOR"] = "Snowfluff Dreamtalon",

			}

			flyingMount = { 
				["SHAMAN"] = ",Spirit of Eche'ro,Grand Gryphon,Honeyback Harvester",
				["MAGE"] = ",Leywoven Flying Carpet,Ashes of Al'ar,Arcanist's Manasaber,Violet Spellwing,Soaring Spelltome,Glacial Tidestorm,Honeyback Harvester,Eve's Ghastly Rider",
				["WARLOCK"] = ",Honeyback Harvester,Headless Horseman's Mount,Grove Defiler,Felsteel Annihilator,Shackled Ur'zul,Eve's Ghastly Rider",
				["MONK"] = "Astral Cloud Serpent",
				["PALADIN"] = ",Highlord's Golden Charger,Lightforged Warframe,Invincible,Honeyback Harvester,Tyrael's Charger",
				["HUNTER"] = ",Mimiron's Head,Clutch of Ji-Kun,Armored Skyscreamer,Dread Raven,Darkmoon Dirigible,Spirit of Eche'ro,Honeyback Harvester,Divine Kiss of Ohn'Ahra",
				["ROGUE"] = ",Ironbound Wraithcharger,Shadowblade's Murderous Omen,Geosynchronous World Spinner",
				["PRIEST"] = ",Dread Raven,Lightforged Warframe,Honeyback Harvester",
				["DEATHKNIGHT"] = ",Invincible,Sky Golem,Honeyback Harvester,",
				["WARRIOR"] = ",Invincible,Smoldering Ember Wyrm,Valarjar Stormwing,Obsidian Worldbreaker,Honeyback Harvester",
				["DRUID"] = ",Sky Golem,Ashenvale Chimaera,Leyfeather Hippogryph,Honeyback Harvester",
				["DEMONHUNTER"] = ",Arcanist's Manasaber,Felfire Hawk,Corrupted Dreadwing,Azure Drake,Cloudwing Hippogryph,Leyfeather Hippogryph,Felsteel Annihilator,Honeyback Harvester",
				["EVOKER"] = "",
				["SENTINEL_HUNTER"] = ",Val'sharah Hippogryph, Ashenvale Chimaera",
				["SENTINEL_WARRIOR"] = ",Val'sharah Hippogryph, Ashenvale Chimaera",

			}	

			if race == "Mechagnome" then
				flyingMount[classk] = ",Mechagon Peacekeeper"
			elseif race == "VoidElf" and class == "WARRIOR" then
				flyingMount[classk] = ",Uncorrupted Voidwing"
			end
		end

		-- classMount[classk] are flying mounts	 
		local classMount = {
			["SHAMAN"] = "Farseer's Raging Tempest",
			["MAGE"] = "Archmage's Prismatic Disc",
			["WARLOCK"] = "Netherlord's Accursed Wrathsteed",
			["MONK"] = "Hogrus, Swine of Good Fortune",
			["PALADIN"] = "Highlord's Valorous Charger",
			["HUNTER"] = "Huntmaster's Loyal Wolfhawk",
			["ROGUE"] = "Shadowblade's Baneful Omen", 
			["PRIEST"] = "High Priest's Lightsworn Seeker",
			["DEATHKNIGHT"] = "Deathlord's Vilebrood Vanquisher",
			["WARRIOR"] = "Battlelord's Bloodthirsty War Wyrm",
			["DRUID"] = "Grove Warden",
			["DEMONHUNTER"] = "Slayer's Felbroken Shrieker",
			["EVOKER"] = "Red Flying Cloud",
			["PIRATE"] = "The Dreadwake",
			["SENTINEL_HUNTER"] = "Priestess' Moonsaber",
			["SENTINEL_WARRIOR"] = "Priestess' Moonsaber",
			["DARKRANGER"] = "Bloodthirsty Dreadwing",
		}

		-- racist ground mount
		local racistMount = {
			["BloodElf"] = "",
			["Draenei"] = "",
			["DarkIronDwarf"] = "Dark Iron Core Hound,",
			["Dwarf"] = "Stormpike Battle Ram,",
			["Gnome"] = "",
			["Goblin"] = "",
			["HighmountainTauren"] = "",
			["Human"] = "",
			["KulTiran"] = "Kul Tiran Charger,",
			["LightforgedDraenei"] = "Lightforged Felcrusher,",
			["MagharOrc"] = "Mag'har Direwolf,",
			["Mechagnome"] = "Mechagon Mechanostrider,Mechacycle Model W,",
			["Nightborne"] = "",
			["NightElf"] = "Kaldorei Nightsaber,",
			["Orc"] = "Frostwolf Snarler,",
			["Pandaren"] = "",
			["Scourge"] = "Undercity Plaguebat,",
			["Tauren"] = "Brown Kodo,",
			["Troll"] = "Fossilized Raptor,Bloodfang Widow,Swift Zulian Tiger,",
			["VoidElf"] = "Starcursed Voidstrider,",
			["Vulpera"] = "Alabaster Hyena,Springfur Alpaca,Elusive Quickhoof,Caravan Hyena,",
			["Worgen"] = "Running Wild,",
			["ZandalariTroll"] = "",
			["Dracthyr"] = "Lil' Donkey",
		}

		-- Random Covenant Mount Generator
		-- Covenant Ground mounts
		local covGroundMounts = {
	    	[0] = {""},
	    	[1] = {"Eternal Phalynx of Courage","Eternal Phalynx of Humility","Eternal Phalynx of Loyalty","Eternal Phalynx of Purity","Phalynx of Courage","Phalynx of Humility","Phalynx of Loyalty","Phalynx of Purity","Ascended Skymane","Sundancer"},
	    	[2] = {"Battle Gargon Vrednic","Crypt Gargon","Gravestone Battle Gargon","Hopecrusher Gargon","Inquisition Gargon","Sinfall Gargon","Court Sinrunner","Sinrunner Blanchy"},
	    	[3] = {"Enchanted Dreamlight Runestag","Enchanted Shadeleaf Runestag","Spinemaw Gladechewer","Wildseed Cradle","Swift Gloomhoof","Shimmermist Runner","Arboreal Gulper"},
	    	[4] = {"Armored Plaguerot Tauralus","Armored War-Bred Tauralus","Lurid Bloodtusk", "Jigglesworth Sr."},
	    	[5] = {"Colossal Wraithbound Mawrat","Colossal Umbrahide Mawrat","Colossal Soulshredder Mawrat","Colossal Plaguespew Mawrat","Mawsworn Charger","Soulbound Gloomcharger","Fallen Charger"},
	    	[6] = {"Heartlight Vombata","Adorned Vombata","Anointed Protostag", "Genesis Crawler"},
		}
		-- Covenant Flying mounts
		local covFlyingMounts = {
	    	[0] = {""},
	    	[1] = {"Gilded Prowler","Silverwind Larion","Elysian Aquilon","Battle-Hardened Aquilon","Ascendant's Aquilon","Forsworn Aquilon"},
	    	[2] = {"Harvester's Dredwing","Horrid Dredwing","Rampart Screecher", "Wastewarped Deathwalker", "Restoration Deathwalker"},
	    	[3] = {"Amber Ardenmoth","Duskflutter Ardenmoth"},
	    	[4] = {"Predatory Plagueroc","Colossal Slaughterclaw","Marrowfang"},
	    	[5] = {"Zovaal's Soul Eater"},
	    	[6] = {"Carcinized Zerethsteed", "Cartel Master's Gearglider","Tazavesh Gearglider"},
	    }

		-- pvp mount faction converter
		local factionMounts = {
			[1] = "Vicious War Wolf",
			[2] = "Vicious Skeletal Warhorse",
			[3] = "Vicious War Raptor",
			[4] = "Vicious War Trike",
			[5] = "Vicious War Kodo",
			[6] = "Vicious Warstrider",
			[7] = "Vicious War Clefthoof",
			[8] = "Vicious Black Bonesteed",
			[9] = "Vicious White Bonesteed",
			[10] = "Vicious War Scorpion",
			[11] = "Vicious War Turtle",
			[12] = "Vicious War Fox",
			[13] = "Vicious War Basilisk",
			[14] = "Vicious Warstalker",
			[15] = "Vicious War Croaker",
			[16] = "Vicious War Gorm",
			[17] = "Vicious War Spider",
			[18] = "Vicious War Bear",
			[19] = "Vicious Moonbeast",
			[20] = "Vicious Dreamtalon",
			[21] = "Vicious Sabertooth",
			[22] = "Vicious War Snail",
			[23] = "Prestigious War Wolf",
			[24] = "Warlord's Deathwheel",
			[25] = "Mechano-Hog",
		}

		if faction == "Alliance" then 
			factionMounts[1] = "Vicious War Steed"
			factionMounts[2] = "Vicious Kaldorei Warsaber"
			factionMounts[3] = "Vicious War Ram"
			factionMounts[4] = "Vicious Gilnean Warhorse"
			factionMounts[5] = "Vicious War Mechanostrider"
			factionMounts[6] = "Vicious War Elekk"
			factionMounts[7] = "Vicious War Riverbeast"
			factionMounts[8] = "Vicious Black Warsaber"
			factionMounts[9] = "Vicious White Warsaber"
			factionMounts[10] = "Vicious War Lion"
			factionMounts[23] = "Prestigious War Steed"
			factionMounts[24] = "Champion's Treadblade"
			factionMounts[25] = "Mekgineer's Chopper"
		end

		pvpWolfSteed = factionMounts[1]
		pvpSkellySaber = factionMounts[2]
		pvpRaptorRam = factionMounts[3]
		pvpTrikeGilnean = factionMounts[4]
		pvpKodoMechanostrider = factionMounts[5]
		pvpStriderElekk = factionMounts[6]
		pvpClefthoofRiverbeast = factionMounts[7]
		pvpBlackSkellySaber = factionMounts[8]
		pvpWhiteSkellySaber = factionMounts[9]
		pvpScorpionLion = factionMounts[10]
		pvpTurtle = factionMounts[11]	
		pvpFox = factionMounts[12]	
		pvpBasilisk = factionMounts[13]	
		pvpWarstalker = factionMounts[14]	
		pvpFrog = factionMounts[15]	
		pvpGorm = factionMounts[16]	
		pvpSpider = factionMounts[17]	
		pvpBear = factionMounts[18]	
		pvpMoonbeast = factionMounts[19]	
		pvpDreamtalon = factionMounts[20]
		pvpSabertooth = factionMounts[21]
		pvpWarsnail = factionMounts[22]	
		prestWolfSteed = factionMounts[23]
		factionBike =  factionMounts[24]
		factionHog = factionMounts[25]

		-- Mount class spec parser
		if class == "SHAMAN" then
			if playerSpec == 3 then
				groundMount[classk] = "Snapback Scuttler"
			end
		elseif class == "WARLOCK" then
			if playerSpec == 2 then 
				classMount[classk] = "Netherlord's Accursed Wrathsteed,Netherlord's Chaotic Wrathsteed"
			elseif playerSpec == 3 then
				classMount[classk] = "Netherlord's Brimstone Wrathsteed,Netherlord's Chaotic Wrathsteed"
				groundMount[classk] = "Hateforged Blazecycle"
			end
		elseif class == "MONK" then
			if (playerSpec == 1 and faction == "Alliance") then
				flyingMount[classk] = "Honeyback Harvester"
			elseif playerSpec == 1 then 
				flyingMount[classk] = "Lucky Yun"
			elseif playerSpec == 2 then
				flyingMount[classk] = "Yu'lei, Daughter of Jade" 
				classMount[classk] = "Shu-Zen, the Divine Sentinel"
			elseif playerSpec == 3 then
				flyingMount[classk] = "Wen Lo, the River's Edge"
				classMount[classk] = "Ban-Lu, Grandmaster's Companion"
			end
			local randomFlyingMount = { flyingMount[classk], "Jade, Bright Foreseer"}
			flyingMount[classk] = randomFlyingMount[random(#randomFlyingMount)]
		elseif class == "PALADIN" then
			if race == "Draenei" or race == "LightforgedDraenei" then
				if playerSpec == 1 then
					groundMount[classk] = "Blessed Felcrusher"
				elseif playerSpec == 2 then
					groundMount[classk] = "Avenging Felcrusher"   
				else 
					groundMount[classk] = "Glorious Felcrusher"
				end
			end
			if playerSpec == 2 then 
				classMount[classk] = "Highlord's Vigilant Charger" 
			elseif playerSpec == 3 then
				classMount[classk] = "Highlord's Vengeful Charger"
			end
		elseif class == "HUNTER" then				
			if playerSpec == 2 then 
				classMount[classk] = "Huntmaster's Dire Wolfhawk" 
				groundMount[classk] = "Taivan,Spawn of Horridon,Brawler's Burly Basilisk,Llothien Prowler,Ironhoof Destroyer"
				flyingMount[classk] = ",Mimiron's Head,Armored Skyscreamer,Dread Raven,Darkmoon Dirigible"
			elseif playerSpec == 3 then
				classMount[classk] = "Huntmaster's Fierce Wolfhawk"
				randomMoose = {"Highmountain Thunderhoof","Great Northern Elderhorn","Highmountain Elderhorn"}
				randomMoose = randomMoose[random(#randomMoose)]			
				randomMoose = ","..randomMoose
				groundMount[classk] = "Taivan,Brawler's Burly Basilisk,Alabaster Hyena,Divine Kiss of Ohn'Ahra"..randomMoose
				flyingMount[classk] = ",Clutch of Ji-Kun,Dread Raven,Spirit of Eche'ro,Divine Kiss of Ohn'Ahra"
			end
		elseif class == "ROGUE" then
			if playerSpec == 2 then 
				classMount[classk] = "Shadowblade's Crimson Omen"
				groundMount[classk] = "Siltwing Albatross,Ratstallion"
				flyingMount[classk] = ",Shadowblade's Murderous Omen,Infinite Timereaver,Siltwing Albatross,The Dreadwake"
			elseif playerSpec == 3 then
				classMount[classk] = "Shadowblade's Lethal Omen"	
				groundMount[classk] = "Infinite Timereaver"
				flyingMount[classk] = ",Ironbound Wraithcharger,Shadowblade's Murderous Omen"
			end			
		elseif class == "PRIEST" then		
			if playerSpec == 3 then
				flyingMount[classk] = ",Dread Raven,Riddler's Mind-Worm,The Hivemind,Uncorrupted Voidwing,Ny'alotha Allseer"	
				groundMount[classk] = "Lucid Nightmare,Ultramarine Qiraji Battle Tank,The Hivemind,Voidtalon of the Dark Star,Ny'alotha Allseer"
			elseif playerSpec == 2 then
				groundMount[classk] = "Bone-White Primal Raptor,Ivory Hawkstrider,Wild Dreamrunner,Pureheart Courser"
			end
		elseif class == "DEATHKNIGHT" then
			if playerSpec == 2 then
				groundMount[classk] = "Frostshard Infernal,Pureheart Courser,Glacial Tidestorm"
			elseif playerSpec == 3 then
				groundMount[classk] = "Winged Steed of the Ebon Blade,Pureheart Courser"
			end
		elseif class == "WARRIOR" then	
			if playerSpec == 2 then
				groundMount[classk] = "Arcadian War Turtle,Ironhoof Destroyer"
			elseif playerSpec == 3 then
				groundMount[classk] = "Prestigious Bronze Courser,Ironhoof Destroyer"
			end
		elseif class == "DRUID" then
			if playerSpec == 2 then 
				-- classMount[classk] = "Swift Zulian Tiger"
			elseif playerSpec == 3 then
				-- classMount[classk] = "Darkmoon Dancing Bear"
			elseif playerSpec == 4 then
				classMount[classk] = "Emerald Drake"
			end
		elseif class == "DEMONHUNTER" then
			if playerSpec == 1 then 
				-- classMount[classk] = "Swift Zulian Tiger"
			elseif playerSpec == 2 then
				-- classMount[classk] = "Darkmoon Dancing Bear"
			end
		elseif class == "EVOKER" then
			if playerSpec == 1 then 
				-- classMount[classk] = "Swift Zulian Tiger"
			elseif playerSpec == 2 then
				-- classMount[classk] = "Darkmoon Dancing Bear"
			end
		-- elseif class == "PIRATE" then
			-- if playerSpec == 2 then 
				-- classMount[classk] = "Swift Zulian Tiger"
			-- elseif playerSpec == 3 then
				-- classMount[classk] = "Darkmoon Dancing Bear"
			-- end
		-- elseif class == "SENTINEL" then
			-- if playerSpec == 2 then 
				-- classMount[classk] = "Swift Zulian Tiger"
			-- elseif playerSpec == 3 then
				-- classMount[classk] = "Darkmoon Dancing Bear"
			-- end
		-- elseif class == "DARKRANGER" then
			-- if playerSpec == 2 then 
				-- classMount[classk] = "Swift Zulian Tiger"
			-- elseif playerSpec == 3 then
				-- classMount[classk] = "Darkmoon Dancing Bear"
			-- end
		end

		if (playerName == "Fannylands" and playerSpec == 3) then
			classMount[classk] = "Grove Defiler"
			flyingMount[classk] = ",Grove Defiler"
			pvpRaptorRam = ""
			groundMount[classk] = "Grove Defiler"
		end


    	covGroundMounts = covGroundMounts[slBP]
    	covGroundMounts = covGroundMounts[random(#covGroundMounts)]
    	covFlyingMounts = covFlyingMounts[slBP]
    	covFlyingMounts = covFlyingMounts[random(#covFlyingMounts)]

		if (class ~= "MONK" and slBP ~= 0) then
			groundMount[classk] = groundMount[classk]..","..covGroundMounts
			flyingMount[classk] = flyingMount[classk]..","..covFlyingMounts
		end

		local mountSlash = "/userandom"
		
		if level < 10 and PlayerGetTimerunningSeasonID() ~= 1 then
			groundMount[classk] = "Summon Chauffeur"
			classMount[classk] = ""
			flyingMount[classk] = ""
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			pvpWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
			-- print("level < 9")
		-- Vashj'ir
		elseif (z == "Vashj'ir" or z == "Kelp'thar Forest" or z == "Shimmering Expanse" or z == "Abyssal Depths") then
			if class == "DRUID" then
				flyingMount[classk] = "!Travel Form"
			elseif class == "MONK" then
				flyingMount[classk] = "Vashj'ir Seahorse"
				classMount[classk] = "Vashj'ir Seahorse"
			-- elseif playerName = "Stabbin" and class == "HUNTER" and race == "Goblin" then
			-- 	flyingMount[classk] = "Vashj'ir Seahorse"
			else
				flyingMount[classk] = "Vashj'ir Seahorse"
			end
			mountSlash = "/use "
			classMount[classk] = ""
			groundMount[classk] = ""
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			pvpWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
		elseif (IsInJailersTower() == true and event == "BAG_UPDATE_DELAYED") then
		-- Torghast preloader
			local powerInBags = ""
			local torghastMountPower = {
	    		"Maw Seeker Harness",
				"Deadsoul Hound Harness",
				"Mawrat Harness",
				"Spectral Bridle",
			}
			for i, torghastMountPower in pairs(torghastMountPower) do
			    if ZG.Item_Count(torghastMountPower) >= 1 then
			        powerInBags = torghastMountPowerd
			    end
			end
			mountSlash = "/use "
			classMount[classk] = ""
			flyingMount[classk] = ""
			groundMount[classk] = powerInBags
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			pvpWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
			-- DEFAULT_CHAT_ZigiMounts:AddMessage("ZigiAllButtons: MountZoneParser: Torghast = "..z.."",0.5,1.0,0.0)
		elseif z == "Torghast, Tower of the Damned" then
			mountSlash = ""
			classMount[classk] = ""
			flyingMount[classk] = ""
			groundMount[classk] = ""
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			pvpWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
		-- Holiday mount block
		elseif gHI == "Love is in the Air" then
			mountSlash = "/use "
			classMount[classk] = ""
			flyingMount[classk] = "Fur-endship Fox"
			groundMount[classk] = ""
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			pvpWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
		elseif gHI == "Noblegarden" then
			mountSlash = "/use "
			classMount[classk] = ""
			flyingMount[classk] = "Noble Flying Carpet"
			groundMount[classk] = ""
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			pvpWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
		elseif gHI == "Brewfest" then
			mountSlash = "/use "
			local brewMount = {"Great Brewfest Kodo", "Swift Brewfest Ram"}
			brewMount = brewMount[random(#brewMount)]
			groundMount[classk] = brewMount
			flyingMount[classk] = "Hogrus, Swine of Good Fortune"
			classMount[classk] = ""
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			pvpWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
		elseif gHI == "Hallow's End" then
			mountSlash = "/use "
			classMount[classk] = ""
			flyingMount[classk] = "Eve's Ghastly Rider"
			groundMount[classk] = ""
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			pvpWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
		elseif instanceType == "pvp" or instanceType == "arena" then
			-- pvpmounts if in bg or arena :)
			factionMounts = {
				pvpWolfSteed,
				pvpSkellySaber,
				pvpRaptorRam,
				pvpTrikeGilnean,
				pvpKodoMechanostrider,
				pvpStriderElekk,
				pvpClefthoofRiverbeast,
				pvpBlackSkellySaber,
				pvpWhiteSkellySaber,
				pvpScorpionLion,
				pvpTurtle,
				pvpFox,	
				pvpBasilisk,	
				pvpWarstalker,
				pvpFrog,	
				pvpGorm,	
				pvpSpider,	
				pvpBear,	
				pvpMoonbeast,	
				pvpDreamtalon,
				pvpSabertooth,
				pvpWarsnail,	
				prestWolfSteed,
				factionBike,
				factionHog,
			}
			-- C_Spell.GetSpellInfo(444008) -- On a Paler Horse for Death Knight Riders
			factionMounts = factionMounts[random(#factionMounts)]
			mountSlash = "/use "
			classMount[classk] = ""
			flyingMount[classk] = ""
			groundMount[classk] = factionMounts
			pvpWolfSteed = ""
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
			if gHI == "Feast of Winter Veil" then
				mountSlash = "/use "
				groundMount[classk] = "Minion of Grumpus"
			end
		elseif z == "The Maw" then
			mountSlash = "/use "
			classMount[classk] = ""
			flyingMount[classk] = ""
			groundMount[classk] = "Colossal Ebonclaw Mawrat"
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			pvpWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
		-- Nazjatar
		elseif (z == "Nazjatar" or z == "Damprock Cavern") and C_QuestLog.IsQuestFlaggedCompleted(56766) then
			local randomSeapony = "Inkscale Deepseeker, Fabious, Subdued Seahorse, Crimson Tidestallion"
			flyingMount[classk] = randomSeapony
			groundMount[classk] = ""
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			pvpWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
			classMount[classk] = ""
		elseif instanceName == "The Deaths of Chromie" then
			-- We can use flying mounts
			groundMount[classk] = ""
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			pvpWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
			-- print("The Deaths of Chromie")
			-- Mount Type Zone Parser
		-- Dragon Isles
		elseif instanceName == "The Nokhud Offensive" then 
			-- local dfFlyingMounts = {"Highland Drake", "Renewed Proto-Drake", "Grotto Netherwing Drake",} 						
			-- flyingMount[classk] = dfFlyingMounts[random(#dfFlyingMounts)]			
			-- if class == "SHAMAN" then
			-- elseif class == "MAGE" then 
			-- elseif class == "WARLOCK" then
			-- elseif class == "MONK" then 
			-- elseif class == "PALADIN" then
			-- elseif class == "HUNTER" then
			-- elseif class == "ROGUE" then
			-- elseif class == "PRIEST" then
			-- elseif class == "DEATHKNIGHT" then
			-- elseif class == "WARRIOR" then
			-- elseif class == "DRUID" then
			-- elseif class == "DEMONHUNTER" then
			-- elseif class == "EVOKER" then
			-- elseif class == "SENTINEL" then
			-- elseif class == "DARKRANGER" then
			-- end
			-- if (class == "ROGUE" and playerSpec == 2) or class == "PIRATE" then
			-- 	flyingMount[classk] = "Polly Roger"
			-- elseif class == "DRUID" then
			-- 	flyingMount[classk] = "Flourishing Whimsydrake"
			-- elseif class == "DARKRANGER" then
			-- 	flyingMount[classk] = "Grotto Netherwing Drake"
			-- end
			mountSlash = "/use "
			-- classMount[classk] = ""
			groundMount[classk] = ""
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			pvpWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
			-- print("test")
		elseif (instanceType ~= "none" and not ZG.garrisonId[instanceID]) or ZG.groundAreas[z] or ZG.groundAreas[instanceName] then
			-- We can't fly inside instances, except Draenor Garrisons and The Deaths of Chromie
			-- Flying is also disabled in certain outdoor areas/zones
			-- print("level = ",groundMount[classk])
			classMount[classk] = ""
			flyingMount[classk] = ""
			-- groundMount[classk] = ""
			-- pvpSkellySaber = "" 
			-- pvpRaptorRam = "" 
			-- pvpKodoMechanostrider = ""
			-- prestWolfSteed = ""
			-- pvpWolfSteed = ""
			-- factionBike = ""
			-- racistMount[race] = ""
			-- palaMounts[race] = ""
			if gHI == "Feast of Winter Veil" then
				-- mountSlash = "/use "
				groundMount[classk] = "Minion of Grumpus"
			end
		-- print("Cannot fly in certain areas")
		-- Dragon Isles
		elseif instanceName == "The Nokhud Offensive" or ZG.dfZones[z] --[[or (level >= 60 or eLevel >= 60)--]] or PlayerGetTimerunningSeasonID() == 1 then 
			-- local dfFlyingMounts = {"Highland Drake", "Renewed Proto-Drake", "Grotto Netherwing Drake",} 						
			-- flyingMount[classk] = dfFlyingMounts[random(#dfFlyingMounts)]			
			-- if class == "SHAMAN" then
			-- elseif class == "MAGE" then 
			-- elseif class == "WARLOCK" then
			-- elseif class == "MONK" then 
			-- elseif class == "PALADIN" then
			-- elseif class == "HUNTER" then
			-- elseif class == "ROGUE" then
			-- elseif class == "PRIEST" then
			-- elseif class == "DEATHKNIGHT" then
			-- elseif class == "WARRIOR" then
			-- elseif class == "DRUID" then
			-- elseif class == "DEMONHUNTER" then
			-- elseif class == "EVOKER" then
			-- elseif class == "SENTINEL" then
			-- elseif class == "DARKRANGER" then
			-- end
			-- if (class == "ROGUE" and playerSpec == 2) or class == "PIRATE" then
			-- 	flyingMount[classk] = "Polly Roger"
			-- elseif class == "DRUID" then
			-- 	flyingMount[classk] = "Flourishing Whimsydrake"
			-- elseif class == "DARKRANGER" then
			-- 	flyingMount[classk] = "Grotto Netherwing Drake"
			-- end
			-- mountSlash = "/use "
			-- classMount[classk] = ""
			groundMount[classk] = ""
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			pvpWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
			-- print("test")
		elseif (IsSpellKnown(34090) or IsSpellKnown(34091) or IsSpellKnown(90265)) then 
			-- Expert, Artisan or Master Riding
			groundMount[classk] = ""
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			pvpWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
		-- print("Artisan or Master Riding")
		elseif IsSpellKnown(33388) or IsSpellKnown(33391) then 
			-- Apprentice or Journeyman Riding
			-- We can use ground mounts
			groundMount[classk] = ""
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			pvpWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
			-- flyingMount[classk] = ""
			-- classMount[classk] = ""
		print("Journeyman or Apprentice - Outdoors and can fly")
		-- Check if the character has riding skill
		else 
			classMount[classk] = ""
			flyingMount[classk] = ""
			pvpSkellySaber = "" 
			pvpRaptorRam = "" 
			pvpKodoMechanostrider = ""
			prestWolfSteed = ""
			pvpWolfSteed = ""
			factionBike = ""
			factionHog = ""
			racistMount[race] = ""
			palaMounts[race] = ""
			-- mountSlash = "/userandom"
		-- print("We dont any Riding skill")
		end
		--[[Mount synthesis: 
		flying mounts: classMount[classk], flyingMount[classk], 
		ground mounts: "..pvpKodoMechanostrider..""..pvpRaptorRam..""..prestWolfSteed..""..factionBike..",racistMount[race],groundMount[classk] --]]  
		if pvpWolfSteed ~= "" then
			pvpWolfSteed = pvpWolfSteed..","
		end
		if pvpSkellySaber ~= "" then
			pvpSkellySaber = pvpSkellySaber..","
		end
		if pvpRaptorRam ~= "" then
			pvpRaptorRam = pvpRaptorRam..","
		end
		if pvpKodoMechanostrider ~= "" then
			pvpKodoMechanostrider = pvpKodoMechanostrider..","
		end
		if prestWolfSteed ~= "" then
			prestWolfSteed = prestWolfSteed..","
		end
		if factionBike ~= "" then
			factionBike = factionBike..","
		end
		if factionHog ~= "" then
			factionHog = factionHog..","
		end

		if (class == "MAGE" or class == "PRIEST" or class == "DEMONHUNTER" or class == "EVOKER" or classk == "PIRATE" or classk == "SENTINEL_HUNTER" or classk == "DARKRANGER") then
			EditMacro("WSxSGen+V",nil,nil,mountSlash.." "..classMount[classk]..""..flyingMount[classk]..""..racistMount[race]..""..groundMount[classk]) 
		elseif class == "SHAMAN" then
			EditMacro("WSxSGen+V",nil,nil,"/use [noform]Ghost Wolf\n/use [@player,nochanneling]Water Walking\n"..mountSlash.." "..classMount[classk]..flyingMount[classk]..pvpKodoMechanostrider..pvpRaptorRam..prestWolfSteed..factionBike..factionHog..racistMount[race]..groundMount[classk].."\n/use Death's Door Charm")
		elseif class == "WARLOCK" then
			EditMacro("WSxSGen+V",nil,nil,mountSlash.." "..classMount[classk]..flyingMount[classk]..pvpSkellySaber..factionBike..factionHog..racistMount[race]..groundMount[classk].."\n/use Tithe Collector's Vessel")
		elseif class == "MONK" then
			mountSlash = "/use "
			-- if classMount[classk] is not empty...
			if classMount[classk] ~= "" then
				classMount[classk] = "[mounted]"..classMount[classk].."\n/use "
			else
				mountSlash = "/userandom "
			end
			EditMacro("WSxSGen+V",nil,nil,mountSlash..classMount[classk]..flyingMount[classk]..racistMount[race]..groundMount[classk])
		elseif class == "PALADIN" then
			mountSlash = "/userandom [nomounted]"
			EditMacro("WSxSGen+V",nil,nil,"/use [combat]!Devotion Aura;[nostance:1]!Crusader Aura\n"..mountSlash..classMount[classk]..flyingMount[classk]..palaMounts[race]..racistMount[race]..groundMount[classk])
		elseif class == "HUNTER" then
			EditMacro("WSxSGen+V",nil,nil,mountSlash.." "..classMount[classk]..flyingMount[classk]..pvpKodoMechanostrider..pvpRaptorRam..racistMount[race]..groundMount[classk])
		elseif class == "ROGUE" then
			EditMacro("WSxSGen+V",nil,nil,mountSlash.." "..classMount[classk]..flyingMount[classk]..racistMount[race]..groundMount[classk].."\n/targetfriend [nospec:2,nohelp,combat]")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxSGen+V",nil,nil,"/use [combat]!Acherus Deathcharger\n"..mountSlash.." "..classMount[classk]..""..flyingMount[classk]..""..racistMount[race]..""..groundMount[classk]) 
		elseif class == "WARRIOR" or classk == "SENTINEL_WARRIOR" then
			EditMacro("WSxSGen+V",nil,nil,mountSlash.." "..classMount[classk]..flyingMount[classk]..factionBike..factionHog..pvpWolfSteed..racistMount[race]..groundMount[classk].."\n/use Death's Door Charm")
		elseif class == "DRUID" then
			EditMacro("WSxSGen+V",nil,nil,"/cancelform [form:1/2/3]\n"..mountSlash.." "..classMount[classk]..flyingMount[classk]..pvpRaptorRam..racistMount[race]..groundMount[classk])
		end
	end
end

ZigiMounts:SetScript("OnEvent", function(self, event)
	-- Delay the first load

	if not loaded and not InCombatLockdown() then
		loaded = true
		C_Timer.After(1, function()
			eventHandler(event)
			-- print("loaded-event:",event)
			loaded = false
		end) 
	end

	if loaded then
		if event == "PLAYER_REGEN_ENABLED" then
			ZigiMounts:UnregisterEvent("PLAYER_REGEN_ENABLED")
		end 

		if not locked then
			locked = true
			C_Timer.After(1, function()
				eventHandler(event)
				-- print("locked-event:",event)
				locked = false	
			end)
		end
	end
end)