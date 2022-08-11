local frame = CreateFrame("FRAME", "ZigiAllButtons")

local throttled = false
local throttledMessage = false

frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
frame:RegisterEvent("BAG_UPDATE_DELAYED")
frame:RegisterUnitEvent("PET_SPECIALIZATION_CHANGED")
frame:RegisterEvent("PET_STABLE_CLOSED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("VARIABLES_LOADED")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
--[[frame:RegisterEvent("PLAYER_ENTERING_WORLD")--]]
--frame:RegisterEvent("PLAYER_LEVEL_UP")

--[[/use [nomounted]Eternal Black Diamond Ring
/run if IsControlKeyDown() then C_PartyInfo.LeaveParty() elseif IsShiftKeyDown() then LFGTeleport(IsInLFGDungeon()) end
--]]

local function eventHandler(self, event)

	if InCombatLockdown() then
		frame:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		frame:UnregisterEvent("PLAYER_REGEN_ENABLED")

		-- Configure Battlefield Map
		if BattlefieldMapFrame then 
			BattlefieldMapFrame:SetScale(1.4)
			-- BattlefieldMapFrame:SetAlpha(1)
			BattlefieldMapFrame:SetPoint("TOPLEFT")
		end
		
		local faction = UnitFactionGroup("player")
		local _,race = UnitRace("player")
		local _,class = UnitClass("player")

		local level = UnitLevel("player")
		local eLevel = UnitEffectiveLevel("player")

		local z, m, mA, mP = GetZoneText(), "", "", ""

		local instanceName, instanceType, difficultyID, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance, mapID, instanceGroupSize = GetInstanceInfo()
		
		local playerspec = GetSpecialization(false,false)

		local petspec = GetSpecialization(false,true)
		local pwned = "Horde Flag of Victory"
		if faction == "Alliance" then 
			pwned = "Alliance Flag of Victory" 
		end
		if class == "WARLOCK" then
			pwned = "Drust Ritual Knife"
		end
		if class == "HUNTER" then
			pwned = "Warbeast Kraal Dinner Bell"
		end

		local fftpar = "Firefury Totem"
		if faction == "Alliance" then
			fftpar = "Touch of the Naaru"
		end
		local factionMurloc = "Gillvanas"
		if faction == "Alliance" then
			factionMurloc = "Finduin"
		end
		local factionPride = "Darkspear Pride"
		if faction == "Alliance" then
			factionPride = "Gnomeregan Pride"
		end
		local factionFireworks = "Everlasting Horde Firework"
		if faction == "Alliance" then
			factionFireworks = "Everlasting Alliance Firework"
		end
		local passengerMount = "Orgrimmar Interceptor"
		local covenantsEnum = {
			1,
			2,
			3,
			4,
		}

		local bfaIsland = ((select(3, GetInstanceInfo())))	
		local slBP = C_Covenants.GetActiveCovenantID(covenantsEnum)
		if class == "PRIEST" then
			passengerMount = "The Hivemind"
		elseif faction == "Alliance" then 
			passengerMount = "Stormwind Skychaser" 
		end
		local one = ""
		local two = ""
		local tre = ""
		local glider = GetItemCount("Goblin Glider Kit") 
		local brazier = GetItemCount("Brazier of Awakening")
		-- Battle of Dazar'alor, Mercenary BG Racial parser
		if IsSpellKnown(28730) then 
			race = "BloodElf" 
		elseif IsSpellKnown(28880) then 
			race = "Draenei"
		elseif IsSpellKnown(265221) then 
			race = "DarkIronDwarf"
		elseif IsSpellKnown(20594) then 
			race = "Dwarf"
		elseif IsSpellKnown(20589) then 
			race = "Gnome"
		elseif (IsSpellKnown(69041) or IsSpellKnown(69070)) then 
			race = "Goblin"
		elseif IsSpellKnown(255654) then 
			race = "HighmountainTauren"
		elseif IsSpellKnown(59752) then 
			race = "Human"
		elseif IsSpellKnown(287712) then 
			race = "KulTiran"
		elseif IsSpellKnown(255647) then 
			race = "LightforgedDraenei"	
		elseif IsSpellKnown(274738) then 
			race = "MagharOrc"
		elseif IsSpellKnown(312924) then 
			race = "Mechagnome"
		elseif IsSpellKnown(260364) then 
			race = "Nightborne"
		elseif IsSpellKnown(58984) then 
			race = "NightElf"
		elseif IsSpellKnown(20572) then 
			race = "Orc"
		elseif IsSpellKnown(107079) then 
			race = "Pandaren"
		elseif IsSpellKnown(7744) then 
			race = "Scourge"
		elseif IsSpellKnown(20549) then 
			race = "Tauren"
		elseif IsSpellKnown(26297) then 
			race = "Troll"
		elseif IsSpellKnown(256948) then 
			race = "VoidElf"
		elseif IsSpellKnown(312411) then 
			race = "Vulpera"
		elseif IsSpellKnown(68992) then 
			race = "Worgen"
		elseif IsSpellKnown(291944) then 
			race = "ZandalariTroll"
		end

		local racials = {
			["BloodElf"] = "Arcane Torrent",
			["Draenei"] = "[@mouseover,help,nodead][]Gift of the Naaru",
			["DarkIronDwarf"] = "Fireblood",
			["Dwarf"] = "Stoneform",
			["Gnome"] = "Escape Artist",
			["Goblin"] = "Rocket Jump",
			["HighmountainTauren"] = "Bull Rush",
			["Human"] = "Will to Survive",
			["KulTiran"] = "Haymaker",
			["LightforgedDraenei"] = "Light's Judgment",
			["MagharOrc"] = "Ancestral Call",
			["Mechagnome"] = "Hyper Organic Light Originator",
			["Nightborne"] = "Arcane Pulse",
			["NightElf"] = "Shadowmeld",
			["Orc"] = "Blood Fury",
			["Pandaren"] = "[@mouseover,harm,nodead][]Quaking Palm",
			["Scourge"] = "Will of the Forsaken",
			["Tauren"] = "War Stomp",
			["Troll"] = "Berserking",
			["VoidElf"] = "Spatial Rift",
			["Vulpera"] = "[mod]Return to Camp;[@mouseover,exists,nodead][]Bag of Tricks",
			["Worgen"] = "Darkflight",
			["ZandalariTroll"] = "Regeneratin'",
		}
		local dpsRacials = {
			["MagharOrc"] = "Ancestral Call",
			["Orc"] = "Blood Fury",
			["Troll"] = "Berserking",
			["DarkIronDwarf"] = "Fireblood",
			["Mechagnome"] = "Hyper Organic Light Originator",
		}
		if dpsRacials[race] then
			dpsRacials[race] = "\n/use "..dpsRacials[race]
		else 
			dpsRacials[race] = ""	
		end
		local extraRacials = {
			["DarkIronDwarf"] = "Mole Machine",
			["Goblin"] = "[@mouseover,harm,nodead][harm,nodead]Rocket Barrage;Pack Hobgoblin",
			["LightforgedDraenei"] = "Forge of Light",
			["Mechagnome"] = "Skeleton Pinkie",
			["Nightborne"] = "[nocombat,noexists]Cantrips;Nightborne Guard's Vigilance",
			["Scourge"] = "Cannibalize",
			["VoidElf"] = "Spatial Rift",
			["Vulpera"] = "[mod]Make Camp;Rummage Your Bag",
			["Worgen"] = "Two Forms",
			["ZandalariTroll"] = "Pterrordax Swoop",
		}
		if not extraRacials[race] and class == "SHAMAN" then
			extraRacials[race] = "[talent:5/3,@player]Wind Rush Totem;Zandalari Effigy Amulet"
		elseif not extraRacials[race] and class == "HUNTER" then
			extraRacials[race] = "Leather Pet Bed"
		elseif not extraRacials[race] then
			extraRacials[race] = "Zandalari Effigy Amulet"
		end
		if extraRacials[race] then
			if race == "Scourge" then 
				EditMacro("WSxExtraRacist",nil,nil,"#show "..extraRacials[race].."\n/targetlasttarget [noexists,nocombat,nodead]\n/use [harm,dead] "..extraRacials[race])
			else
			   EditMacro("WSxExtraRacist",nil,nil,"#show\n/use " ..extraRacials[race])
			end
		end
		-- Covenant Hearthstone
		local covHS = {
			[0] = "Hearthstone",
			[1] = "Kyrian Hearthstone",
			[2] = "Venthyr Sinstone",
			[3] = "Night Fae Hearthstone",
			[4] = "Necrolord Hearthstone",
		} 
		

        local covPets = {
        	[0] = {""},
        	[1] = {"Ruffle"},
        	[2] = {"Sinheart"},
        	[3] = {"Trootie","Floofa"},
        	[4] = {"Jiggles"},
        }
       	covPets = covPets[slBP]
       	covPets = covPets[random(#covPets)]
        		
		-- Hearthstones
		local HS = {
			["SHAMAN"] = "Eternal Traveler's Hearthstone",
			["MAGE"] = "Fire Eater's Hearthstone",
			["WARLOCK"] = "Headless Horseman's Hearthstone",
			["MONK"] = "Brewfest Reveler's Hearthstone",
			["PALADIN"] = "Hearthstone",
			["HUNTER"] = covHS[slBP],
			["ROGUE"] = covHS[slBP],
			["PRIEST"] = covHS[slBP],
			["DEATHKNIGHT"] = covHS[slBP],
			["WARRIOR"] = "The Innkeeper's Daughter",
			["DRUID"] = "Noble Gardener's Hearthstone",
			["DEMONHUNTER"] = covHS[slBP],
		}
			
		local hsToy = {
			["SHAMAN"] = "\n/use Portable Audiophone\n/use Underlight Sealamp",
			["MAGE"] = "\n/use [harm,nodead]Gaze of the Darkmoon;Magic Fun Rock",
			["WARLOCK"] = "\n/cancelaura Golden Hearthstone Card: Lord Jaraxxus\n/use Golden Hearthstone Card: Lord Jaraxxus",
			["MONK"] = "\n/use Brewfest Chowdown Trophy",
			["PALADIN"] = "\n/use Jar of Sunwarmed Sand",
			["HUNTER"] = "\n/use Tiny Mechanical Mouse",
			["ROGUE"] = "\n/use Cursed Spyglass",
			["PRIEST"] = "\n/use Steamy Romance Novel Kit\n/cancelaura For da Blood God!\n/use For da Blood God!",
			["DEATHKNIGHT"] = "\n/use Coldrage's Cooler",
			["WARRIOR"] = "\n/cancelaura Tournament Favor\n/use Tournament Favor\n/use Kovork Kostume",
			["DRUID"] = "\n/cancelaura Make like a Tree\n/use Ancient's Bloom\n/use Stave of Fur and Claw",
			["DEMONHUNTER"] = "\n/cancelaura Golden Hearthstone Card: Lord Jaraxxus\n/use Golden Hearthstone Card: Lord Jaraxxus",
		}
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

		local EQS = {
			[1] = "Noon!",
			[2] = "DoubleGate",
			[3] = "Menkify!",
			[4] = "Supermenk",
			[5] = "",
		}
		-- speciella item sets
		
		local tpPants, noPants = "Tipipants",EQS[playerspec]
		if C_EquipmentSet.GetEquipmentSetID(tpPants) ~= nil then
			tpPants = C_EquipmentSet.GetEquipmentSetID(tpPants)
			noPants = C_EquipmentSet.GetEquipmentSetID(noPants)
			tpPants = "C_EquipmentSet.UseEquipmentSet("..tpPants..")" 
			noPants = "C_EquipmentSet.UseEquipmentSet("..noPants..")"
		end
	 
		-- set spec title
		local SST = {
		-- Shaman titles
			[1] = "Gorgeous",
			[2] = "Storm's End",
			[3] = "Gorgeous",
		}
		if UnitName("player") == "Raxana" and class == "SHAMAN" and race == "Orc" then
			SST = {
				[1] = "Mistwalker", 
				[2] = "Lady of War",
				[3] = "of the Deeps",
			}
		elseif class == "MAGE" then
			SST = {
				[1] = "Headmistress", 
				[2] = "Flame Keeper",
				[3] = "Merrymaker",
			}
		elseif class == "WARLOCK" then
			SST = {
				[1] = "of The Black Harvest", 
				[2] = "Matron",
				[3] = "Netherlord",
			}
			if (UnitName("player") == "Darkglace" or UnitName("player") == "Voidlisa") and playerspec == 2 then
				SST = {
					[2] = "Lady of War",
				}
			end
		elseif class == "MONK" then
			SST = {
				[1] = "Brewmaster", 
				[2] = "the Tranquil Master",
				[3] = "Shado",
			}
		elseif class == "PALADIN" then
			SST = {
				[1] = "The Lightbringer", 
				[2] = "Highlord",
				[3] = "Gorgeous",
			}
			if UnitName("player") == "Blackvampkid" and playerspec == 3 then
				SST = { 
				[3] = "Lady of War",
			}
			end
		elseif class == "HUNTER" then
			SST = {
				[1] = "Zookeeper", 
				[2] = "Tower Ranger",
				[3] = "Predator",
			}
		elseif class == "ROGUE" then
			SST = {
				[1] = "The Kingslayer", 
				[2] = "Captain",
				[3] = "Shadowblade",
			}
		elseif class == "PRIEST" then
			SST = {
				[1] = "The Argent Champion", 
				[2] = "Gorgeous",
				[3] = "The Insane",
			}					
		elseif class == "DEATHKNIGHT" then
			SST = {
				[1] = "Baron", 
				[2] = "Abominable",
				[3] = "Deathlord",
			} 					
		elseif class == "WARRIOR" then
			if race == "Scourge" then
				SST = {
					[1] = "Lady of War", 
					[2] = "Lady of War",
					[3] = "The Proven Defender",
				}
			else
				SST = {
					[1] = "The Chosen", 
					[2] = "Battlelord",
					[3] = "The Proven Defender",
				}
			end
		elseif class == "DRUID" then
			SST = {
				[1] = "Starcaller", 
				[2] = "The Crazy Cat Lady",
				[3] = "Guardian of Cenarius",
				[4] = "The Dreamer",
			}					
		elseif class == "DEMONHUNTER" then
			SST = {
				[1] = "Demonslayer", 
				[2] = "Vengeance Incarnate",
			}					
        end

        if IsEquippedItem("Mirror of the Blademaster") then
        	SST[playerspec] = "Timelord"
        end

		local consOne, consTwo, consThree, invisPot = "Spellstone Delight","Spellstone Delight","The Necronom-i-nom","Stealthman 54"

		local hasBell = "Cooking School Bell"

		if SST[playerspec] and EQS[playerspec] then
			EditMacro("WSpecs!",nil,nil,"/settitle "..SST[playerspec].."\n/equipset "..EQS[playerspec].."\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 elseif(IsModifierKeyDown())then x=4 end if(x~=GetSpecialization())then SetSpecialization(x) end\n/stopcasting")
		end
		
		local oOtas = "\n/use Orb of Deception"
		if race ~= "BloodElf" and eLevel >= 25 then
			oOtas = "\n/use Orb of the Sin'dorei"
		end

		if eLevel < 20 then
			oOtas = oOtas.."\n/use Toy Armor Set\n/use Toy Weapon Set"
		else
			oOtas = oOtas
		end
		-- Class exception pvp macros.
		local warPvPExc = ""
		local shaPvPExc = "Fire Elemental"
		local locPvPExcQQ = "[@mouseover,exists,nodead][]Command Demon"
		local locPvPExcSeven = "[spec:2]Implosion"
		local locPvPExcSThree = ""
		local locPvPExcGenF = "[@focus,harm,nodead]Command Demon;"
		local ptdSG = GetItemCount("Protocol Transference Device")
		local chameleon = IsSpellKnown(61648)
		if chameleon == true then
			chameleon = "Aspect of the Chameleon"
		elseif chameleon == false then 
			chameleon = "Hunter's Call"
		end 
     	-- ptdSG, mechanical device
		if ptdSG >=1 then
			ptdSG = "[mod:alt]Protocol Transference Device;"
		elseif ptdSG <= 1 then 
			ptdSG = ""
		end

		-- Target BG Healers and Set BG Healers // Helpful measures in non-pvp areas
		local numaltcc = {
			["SHAMAN"] = "Hex",
			["MAGE"] = "Polymorph",
			["WARLOCK"] = "Command Demon",
			["MONK"] = "Paralysis",
			["PALADIN"] = "Blessing of Sacrifice",
			["HUNTER"] = "Intimidation",
			["ROGUE"] = "Blind",
			["PRIEST"] = "Mind Bomb",
			["DEATHKNIGHT"] = "Asphyxiate",
			["WARRIOR"] = "Storm Bolt",
			["DRUID"] = "Cyclone", 
			["DEMONHUNTER"] = "Imprison",
		}
		local numctrlcc = {
			["SHAMAN"] = "Purge",
			["MAGE"] = "Spellsteal",
			["WARLOCK"] = "Command Demon",
			["MONK"] = "Disable",
			["PALADIN"] = "Blessing of Protection",
			["HUNTER"] = "Harpoon",
			["ROGUE"] = "Shadowstep",
			["PRIEST"] = "Leap of Faith",
			["DEATHKNIGHT"] = "Dark Simulacrum",
			["WARRIOR"] = "Charge",
			["DRUID"] = "Entangling Roots", 
			["DEMONHUNTER"] = "Consume Magic",
		}
		if class == "ROGUE" and playerspec == 2 then
			numctrlcc[class] = "Kidney Shot"
		end
		local numnomodcc = {
			["SHAMAN"] = "Water Walking",
			["MAGE"] = "Slow Fall",
			["WARLOCK"] = "Unending Breath",
			["MONK"] = "Tiger's Lust",
			["PALADIN"] = "Blessing of Freedom",
			["HUNTER"] = "Master's Call",
			["ROGUE"] = "Shadowstep",
			["PRIEST"] = "Power Infusion",
			["DEATHKNIGHT"] = "Mind Freeze",
			["WARRIOR"] = "Intervene",
			["DRUID"] = "Wild Charge", 
			["DEMONHUNTER"] = "Disrupt",
		}

		if class == "DRUID" then
			if (playerspec == 2 or playerspec == 3) then
				numnomodcc[class] = "Skull Bash"
			elseif playerspec == 4 then
				numnomodcc[class] = "Cyclone"
			end
		end 

		-- Global Addon Messages
		if event == "BAG_UPDATE_DELAYED" and not throttledMessage then 
			throttledMessage = true
	        C_Timer.After(2, function()
	            -- denna kod körs efter 2 sekunder
	            throttledMessage = false
	        end)
		DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: BAG_UPDATE_DELAYED\nRecalibrating related macros :)",0.5,1.0,0.0)
		elseif event == "PET_SPECIALIZATION_CHANGED" and not throttledMessage then 
			throttledMessage = true
	        C_Timer.After(2, function()
	            -- denna kod körs efter 2 sekunder
	            throttledMessage = false
	        end)
			DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: PET_SPECIALIZATION_CHANGED\nRecalibrating related macros :)",0.5,1.0,0.0)
		elseif event == "ZONE_CHANGED_NEW_AREA" and not throttledMessage then 
			throttledMessage = true
	        C_Timer.After(2, function()
	            -- denna kod körs efter 2 sekunder
	            throttledMessage = false
	        end)
			DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: ZONE_CHANGED_NEW_AREA\nRecalibrating related macros :)",0.5,1.0,0.0)
		elseif event == "GROUP_ROSTER_UPDATE" and not throttledMessage then 
			eventHandler()
			throttledMessage = true
	        C_Timer.After(2, function()
	            -- denna kod körs efter 2 sekunder
	            throttledMessage = false
	        end)
			DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: GROUP_ROSTER_UPDATE\nRecalibrating related macros :)",0.5,1.0,0.0)
		end

		-- Här börjar Events
		-- Login,zone,bag_update based event, Swapper, Alt+J parser, Call Companion, set class/spec toys.
		-- Zone och bag baserade events
		if (event == "ZONE_CHANGED_NEW_AREA" or event == "BAG_UPDATE_DELAYED" or event == "PET_SPECIALIZATION_CHANGED" or event == "PLAYER_LOGIN") and not throttled then 
			throttled = true
	        C_Timer.After(2, function()
	            -- denna kod körs efter 2 sekunder
	            throttled = false
	        end)

	        local pets = "\"Snowfang\",\"Frostwolf Pup\",\"Bound Stream\",\"Pebble\",\"Soul of the Forge\",\"Zephyrian Prince\",\""..covPets.."\""
			local classText = "#show Mana Tide Totem" 

			if class == "SHAMAN" then
				if playerspec ~= 3 then 
					classText = "#show Earth Elemental"
				end
				if race == "Troll" then
					pets = "\"Sen'jin Fetish\",\"Lashtail Hatchling\",\"Drafty\",\"Searing Scorchling\",\"Seafury\",\"Mojo\",\"Lumpy\",\""..covPets.."\""
				end
			elseif class == "MAGE" then
				pets = "\"Lil' Tarecgosa\",\"Trashy\",\"Wondrous Wisdomball\",\"Magical Crawdad\",\""..covPets.."\""
				classText = "/use Pilfered Sweeper" 
				if playerspec == 2 then
					pets = "\"Lil' Tarecgosa\",\"Phoenix Hatchling\",\"Nethaera's Light\",\""..covPets.."\""
					classText = "/use Pilfered Sweeper\n/use Brazier of Dancing Flames"
				elseif playerspec == 3 then
					pets = "\"Lil' Tarecgosa\",\"Water Waveling\",\"Tiny Snowman\",\"Feline Familiar\",\""..covPets.."\""
				end
			elseif class == "WARLOCK" then
				pets = "\"Lesser Voidcaller\",\"Netherspace Abyssal\",\"Horde Fanatic\",\"Cross Gazer\",\"Sister of Temptation\",\"Nibbles\",\""..covPets.."\""
				classText = ""
				if playerspec == 2 then
					pets = "\"Rebellious Imp\",\"Lesser Voidcaller\",\"Netherspace Abyssal\",\"Sister of Temptation\",\"Nibbles\",\"Baa'l\",\""..covPets.."\""
				elseif playerspec == 3 then
					pets = "\"Rebellious Imp\",\"Lesser Voidcaller\",\"Netherspace Abyssal\",\"Horde Fanatic\",\"Sister of Temptation\",\"Nibbles\",\""..covPets.."\""
				end
			elseif class == "MONK" then
				if playerspec == 1 then 
					pets = "\"Zao, Calfling of Niuzao\",\"Ban-Fu, Cub of Ban-Lu\",\""..covPets.."\""
				elseif playerspec == 2 then 
					pets = "\"Chi-Chi, Hatchling of Chi-Ji\",\"Yu'la, Broodling of Yu'lon\",\"Ban-Fu, Cub of Ban-Lu\",\""..covPets.."\""
				else
					pets = "\"Xu-Fu, Cub of Xuen\",\"Ban-Fu, Cub of Ban-Lu\",\""..covPets.."\""
				end
				classText = ""
			elseif class == "PALADIN" then
				pets = "\"K'ute\",\"Draenei Micro Defender\",\"Uuna\",\"Ancient Nest Guardian\",\""..factionMurloc.."\",\""..covPets.."\""
				classText = "/use Burning Blade"
			elseif class == "HUNTER" then
				pets = "\"Rocket Chicken\",\"Baby Elderhorn\",\"Nuts\",\"Tito\",\"Stormwing\",\"Fox Kit\",\"Son of Skum\",\"Crow\",\""..covPets.."\""
				classText = "/use Hunter's Call"
				if playerspec == 2 then
					pets = "\"Rocket Chicken\",\"Blackfuse Bombling\",\"Alarm-o-Bot\",\"Tito\",\"Stormwing\",\"Crow\",\""..covPets.."\""
					classText = "/use Dark Ranger's Spare Cowl"
				elseif playerspec == 3 then
					pets = "\"Rocket Chicken\",\"Blackfuse Bombling\",\"Baby Elderhorn\",\"Nuts\",\"Tito\",\"Stormwing\",\"Crow\",\""..covPets.."\""
				end
			elseif class == "ROGUE" then
				pets = "\"Pocket Cannon\",\"Gilnean Raven\",\"Sneaky Marmot\",\"Giant Sewer Rat\",\"Creepy Crate\",\"Crackers\",\""..covPets.."\""
				classText = "#show Vanish"
			elseif class == "PRIEST" then
				pets = "\"Argi\",\"K'ute\",\"Dread Hatchling\",\"Argent Gruntling\",\"Shadow\",\"Uuna\",\""..covPets.."\""
				classText = "#show Mass Dispel"
				if playerspec == 2 then
					pets = "\"Argi\",\"K'ute\",\"Argent Gruntling\",\"Argi\",\"Sunborne Val'kyr\",\"Uuna\",\""..covPets.."\""
				elseif playerspec == 3 then
					pets = "\"Shadow\",\"K'ute\",\"Hungering Claw\",\"Dread Hatchling\",\"Faceless Minion\",\""..covPets.."\""
				end
			elseif class == "DEATHKNIGHT" then
				pets = "\"Bloodbrood Whelpling\",\"Blightbreath\",\"Boneshard\",\"Grotesque\",\"Stinkrot\",\"Unborn Val'kyr\",\"Naxxy\",\""..covPets.."\""
				classText = ""
				if playerspec == 2 then
					pets = "\"Frostbrood Whelpling\",\"Mr. Bigglesworth\",\"Boneshard\",\"Landro's Lichling\",\"Unborn Val'kyr\",\""..covPets.."\""	
				elseif playerspec == 3 then
					pets = "\"Vilebrood Whelpling\",\"Lost of Lordaeron\",\"Grotesque\",\"Unborn Val'kyr\",\"Mr. Bigglesworth\",\"Naxxy\",\""..covPets.."\""
				end
			elseif class == "WARRIOR" then
				pets = "\"Darkmoon Rabbit\",\"Sunborne Val'kyr\",\""..factionMurloc.."\",\"Crow\",\"Teeny Titan Orb\",\""..covPets.."\""
				classText = "#show\n/use "..factionPride..""
			elseif class == "DRUID" then
				if (race == "Tauren" and GetItemCount("Ancient Tauren Talisman") == 1) then
					hasBell = "Ancient Tauren Talisman"
				end
				pets = "\"Moonkin Hatchling\",\"Stardust\",\"Sun Darter Hatchling\",\"Ragepeep\",\""..covPets.."\""
				classText = "#show Rebirth\n/use Wisp in a Bottle"
				if playerspec == 2 then
					pets = "\"Cinder Kitten\",\"Lashtail Hatchling\",\"Singing Sunflower\",\"Sen'Jin Fetish\",\""..covPets.."\""
				elseif (UnitName("player") == "Fannylands" and playerspec == 3) then
					pets = "\"Nightmare Whelpling\",\"Nightmare Lasher\",\"Nightmare Treant\",\"Singing Sunflower\",\""..covPets.."\""
				elseif playerspec == 3 then
					pets = "\"Hyjal Cub\",\"Moonkin Hatchling\",\"Ashmaw Cub\",\"Singing Sunflower\",\""..covPets.."\""
				elseif playerspec == 4 then	
					pets = "\"Blossoming Ancient\",\"Broot\",\"Singing Sunflower\",\"Sun Darter Hatchling\",\""..covPets.."\""
				end
			elseif class == "DEMONHUNTER" then
				pets = "\"Murkidan\",\"Emmigosa\",\"Abyssius\",\"Micronax\",\"Wyrmy Tunkins\",\"Fragment of Desire\",\"Eye of the Legion\",\"Mischief\",\""..covPets.."\""
				classText = ""
			end
			
			-- Winter Veil Holiday Override
			if C_Calendar and C_DateAndTime then
				C_Calendar.SetMonth(0)
				local gHI = C_Calendar.GetHolidayInfo(0, C_DateAndTime.GetCurrentCalendarTime().monthDay, 1) and C_Calendar.GetHolidayInfo(0, C_DateAndTime.GetCurrentCalendarTime().monthDay, 1).name or ""
				-- print("gHI#1 = "..gHI)
				if gHI == "Feast of Winter Veil" then
					pets = "\"Perky Pug\""
					classText = classText.."\n/use Wild Holly"
					--[[print("gHI = "..gHI)--]]
				end
			end

			if GetItemCount(hasBell) < 1 then
				hasBell = "B. F. F. Necklace"
			end
			EditMacro("WSxSwapper",nil,nil,classText.."\n/use "..hasBell.."\n/run local a={"..pets.."}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")

	        -- print("ZONE_CHANGED_NEW_AREA or BAG_UPDATE_DELAYED or PET_SPECIALIZATION_CHANGED")

	         -- Role definition scope for dps potions
			local primary = "int"
			if (class == "DEMONHUNTER") or (class == "DRUID" and (playerspec == 2 or playerspec == 3)) or (class == "HUNTER") or (class == "MONK" and playerspec ~= 2) or (class == "ROGUE") or (class == "SHAMAN" and playerspec == 2) then
				primary = "agi"
			elseif (class == "DEATHKNIGHT") or (class == "WARRIOR") or (class == "PALADIN" and playerspec ~= 1) then
				primary = "str"
			end
			-- Throughput Potion synthesizer 
			EditMacro("Wx3ShowPot", nil, "INV_MISC_QUESTIONMARK", nil, 1, 1)
			if instanceType == "pvp" and GetItemCount("Saltwater Potion", false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Saltwater Potion\n/use Hell-Bent Bracers", 1, 1)
			elseif IsInJailersTower() == true and GetItemCount("Fleeting Frenzy Potion", false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Fleeting Frenzy Potion\n/use Hell-Bent Bracers", 1, 1)
			elseif IsInJailersTower() == true and GetItemCount("Mirror of the Conjured Twin", false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Mirror of the Conjured Twin\n/use Hell-Bent Bracers", 1, 1)	
			elseif primary == "int" and GetItemCount(171273, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Potion of Spectral Intellect\n/use Hell-Bent Bracers", 1, 1)
			elseif primary == "int" and GetItemCount(169299, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Potion of Unbridled Fury\n/use Hell-Bent Bracers", 1, 1)
			elseif primary == "int" and GetItemCount(168498, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Superior Battle Potion of Intellect\n/use Hell-Bent Bracers", 1, 1)
			elseif primary == "agi" and GetItemCount(168489, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Superior Battle Potion of Agility\n/use Hell-Bent Bracers", 1, 1)
			elseif primary == "str" and GetItemCount(168500, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Superior Battle Potion of Strength\n/use Hell-Bent Bracers", 1, 1)
			elseif primary == "int" and GetItemCount(163222, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Battle Potion of Intellect\n/use Hell-Bent Bracers", 1, 1)
			elseif primary == "agi" and GetItemCount(163223, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Battle Potion of Agility\n/use Hell-Bent Bracers", 1, 1)
			elseif primary == "str" and GetItemCount(163224, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Battle Potion of Strength\n/use Hell-Bent Bracers", 1, 1)
			elseif GetItemCount(171349, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Potion of Phantom Fire\n/use Hell-Bent Bracers", 1, 1)	
			elseif GetItemCount(169299, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Potion of Unbridled Fury\n/use Hell-Bent Bracers", 1, 1)
			elseif GetItemCount(142117, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Potion of Prolonged Power\n/use Hell-Bent Bracers", 1, 1)
			else
				EditMacro("Wx3ShowPot", nil, 132380, "#show", 1, 1)
			end	
			
			-- Map
			if C_Map and C_Map.GetBestMapForUnit("player") then
				local map = C_Map.GetMapInfo(C_Map.GetBestMapForUnit("player"))
				local parent = map.parentMapID and C_Map.GetMapInfo(map.parentMapID) or map
				local ink = "\n/use Moroes' Famous Polish"
				local hasCannon, alt4, alt5, alt6, CZ, AR, conDB, conEF, conAF, conVS, conSET, conST, conSst, conMW, conMS, conTE, conBE, conCE, conRE = "", "", "", "\n/use Goren \"Log\" Roller", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""
				alt4 = ink
				-- Gör ett nytt macro för ExtraActionButton1 som har en Vindicator Matrix ability bundet när du är på Argus, bind detta till CGenB

				-- Zone Ability
				local zA = "/use [@mouseover,exists,nodead][@cursor]Garrison Ability"
				if instanceName == "Draenor" then
					-- Draenor: Garrison Ability
				elseif instanceName == "Broken Isles" then
					zA = "/use [@mouseover,harm,nodead][@cursor]Combat Ally"
				elseif instanceName == "Argus" then
					-- Argus: Vindicaar Matrix Crystal
					zA = "/use [@mouseover,exists,nodead][@cursor]Vindicaar Matrix Crystal"
				elseif (instanceName == "Horrific Vision of Orgrimmar" or instanceName == "Horrific Vision of Stormwind") and IsSpellKnown(314955) then
					-- Horrific Vision: Sanity Restoration Orb
					zA = "/use [@mouseover,exists,nodead][@cursor]Sanity Restoration Orb"
				elseif instanceName == "Vision of the Twisting Sands" or instanceName == "Vale of Eternal Twilight" then
					zA = "/use [@mouseover,exists,nodead][@cursor]Resilient Soul"
					-- Minor Horrific Vision: Resilient Soul
				elseif instanceName == "Zereth Mortis" then 
					zA = "/use Summon Pocopoc"
				elseif instanceName == "The Shadowlands" and slBP == 4 then
					zA = "/use [@mouseover,exists,nodead][@cursor]Construct Ability"
					-- Shadowlands: Construct Ability
				elseif IsInJailersTower() == true then
					zA = "/use Activate Empowerment"
				elseif (bfaIsland == 38) or (bfaIsland == 39) or (bfaIsland == 40) or (bfaIsland == 45) then
					zA = "/use Wartime Ability"
					-- print("bfaIsland = "..bfaIsland)
				end
				EditMacro("WSxCSGen+B",nil,nil,zA)
				
				EditMacro("WSxCGen+B",nil,nil,"#show\n/click ExtraActionButton1")
				if GetItemCount("Darkmoon Cannon") == 1 then 
					hasCannon = "\n/use Darkmoon Cannon"
				end

				-- Augment Runes
				if eLevel <= 50 and GetItemCount("Lightforged Augment Rune") == 1 then
					AR = "/use [nostealth]Lightforged Augment Rune"
				elseif eLevel <= 60 and GetItemCount("Eternal Augment Rune") == 1 then
					AR = "/use [nostealth]Eternal Augment Rune"
				end
			
				local pp = parent and parent.name

				local LAR = "Loot-A-Rang"
				local hasShark, hasScrapper = "Photo B.O.M.B.","Citizens Brigade Whistle"
    			
			    if IsInJailersTower() == true then
					local torghastAnimaCell = {
					"Ravenous Anima Cell",
					"Plundered Anima Cell",
					"Requisitioned Anima Cell",					}
					local torghastAnimaCellInBags = ""
					for i, torghastAnimaCell in pairs(torghastAnimaCell) do
					    if GetItemCount(torghastAnimaCell) >= 1 then
					        torghastAnimaCellInBags = torghastAnimaCell
					    end
					end
					alt4 = ink
					alt5 = hasCannon
					alt6 = ""
					CZ = ""
					consOne = torghastAnimaCellInBags
					consTwo = torghastAnimaCellInBags
					consThree = torghastAnimaCellInBags
			    elseif (z == "The Maw" and pp == "The Shadowlands") then
					alt4 = ink.."\n/use Silver Shardhide Whistle"
					if (class == "PRIEST" or class == "MAGE" or class == "WARLOCK") then
						alt5 = "/use 9"
					elseif (class == "WARRIOR" or class == "DEATHKNIGHT" or class == "PALADIN" or class == "DRUID" or class == "MONK" or class == "ROGUE" or class == "DEMONHUNTER") then
						alt5 = "/use 10"
					else
						alt5 = "/use 8"
					end
					alt5 = hasCannon.."\n"..alt5
					CZ = "[nostealth]Borr-Geth's Fiery Brimstone"
				elseif slZones[z] then
					if (class == "PRIEST" or class == "MAGE" or class == "WARLOCK") then
							alt5 = "/use 9"
					elseif (class == "WARRIOR" or class == "DEATHKNIGHT" or class == "PALADIN" or class == "DRUID" or class == "MONK" or class == "ROGUE" or class == "DEMONHUNTER") then
						alt5 = "/use 10"
					else
						alt5 = "/use 8"
					end 
					local kyrianInstrument = {
						"Heavenly Drum",
						"Kyrian Bell",
						"Benevolent Gong",
					}
					local kyrianInBags = ""
					for i, kyrianInstrument in pairs(kyrianInstrument) do
					    if GetItemCount(kyrianInstrument) >= 1 then
					        kyrianInBags = kyrianInstrument
					    end
					end
					if (z == "Ardenweald" and pp == "The Shadowlands") then
						local consTwoFinder = {
							kyrianInBags,
							"Pinch of Faerie Dust",
						}
						local consTwoFinderInBags = ""
						for i, consTwoFinder in pairs(consTwoFinder) do
						    if GetItemCount(consTwoFinder) >= 1 then
						        consTwoFinderInBags = consTwoFinder
						    end
						end
						consTwo = consTwoFinderInBags
					end
					local consOneFinder = {
						kyrianInBags,
						"A Faintly Glowing Seed",
					}
					local consOneFinderInBags = ""
					for i, consOneFinder in pairs(consOneFinder) do
					    if GetItemCount(consOneFinder) >= 1 then
					        consOneFinderInBags = consOneFinder
					    end
					end
					-- print("consOneFinderInBags = "..consOneFinderInBags)
					if GetItemCount("Crumbling Pride Extractors") >= 1 then
						hasShark = "Crumbling Pride Extractors"
					end
					if GetItemCount("Shrieker's Voicebox") >= 1 then
						hasScrapper = "Shrieker's Voicebox"
					end
					if GetItemCount("Gargon Whistle") >= 1 then
						consthree = "Gargon Whistle"
					end
					CZ = "[nostealth]"..kyrianInBags.."\n/use [nostealth]Borr-Geth's Fiery Brimstone" 
					consOne = consOneFinderInBags
					alt4 = ink.."\n/use Silver Shardhide Whistle"
					alt5 = hasCannon.."\n"..alt5
					alt6 = alt6.."\n/use Phial of Ravenous Slime"
				    if instanceName == "Zereth Mortis" then
						consOne = "Accelerating Tendons"
						consTwo = "Evolved Exo-mucus"
						consThree = "Spiked Protomesh"
					end
				elseif bfaZones[z] then
					consOne = "Annoy-o-Tron Gang"
					consTwo = "Scrap Trap"
					consThree = "Rustbolt Pocket Turret"
					--print(bfaZones)
					if GetItemCount("G99.99 Landshark") >= 1 then
						hasShark = "G99.99 Landshark"
					end
					if GetItemCount("Scrap Grenade") >= 1 then
						hasScrapper = "Scrap Grenade"
					end
					if GetItemCount("Exposed Fish") >= 1 then
						conEF = "\n/use Exposed Fish"
					end
					if GetItemCount("Alpha Fin") >= 1 then 
						conAF = "\n/use Alpha Fin"
					end
					if GetItemCount("Voltscale Shield") >= 1 then
						conVS = "\n/use Voltscale Shield"
					end
					if GetItemCount("Storm Elemental Totem") >= 1 then
						conSET = "\n/use Storm Elemental Totem"
					end
					if GetItemCount("Sea Totem") >= 1 then
						conST = "\n/use Sea Totem"
					end
					if GetItemCount("Seastorm Totem") >= 1 then
						conSst = "\n/use Seastorm Totem"
					end
					if GetItemCount("Mudwrap") >= 1 then
						conMW = "\n/use Mudwrap"
					end
					if GetItemCount("Muck Slime") >= 1 then
						conMS = "\n/use Muck Slime"
					end
					-- Nazjatar exclusive and Aquatic mount
					if z == "Nazjatar" then
						if GetItemCount("Deepcoral Pod") >= 1 then
							conDB = "\n/use Deepcoral Pod"
						end
					end
					alt4 = ink..""..conDB..""..conEF..""..conAF
					alt5 = conSET..""..conST..""..conSst..""..conMS..""..conVS..""..hasCannon
					alt6 = conMW
					CZ = "Rhan'ka's Escape Plan"		
				-- Arathi Highlands
				elseif z == "Arathi Highlands" then
					if GetItemCount("Thundering Essence") >= 1 then 
						conTE = "\n/use Thundering Essence"
					end
					if GetItemCount("Burning Essence") >= 1 then 
						conBE = "\n/use Burning Essence"
					end
					if GetItemCount("Cresting Essence") >= 1 then 
						conCE = "\n/use Cresting Essence"
					end
					if GetItemCount("Rumbling Essence") >= 1 then 
						conRE = "\n/use Rumbling Essence"
					end
					alt5 = hasCannon..""..conTE..""..conBE..""..conCE..""..conRE
				-- Argus
				elseif pp == "Argus" then
					EditMacro("WSxCGen+B",nil,nil,"#show\n/use Vindicaar Matrix Crystal")
					alt4 = ink.."\n/use Baarut the Brisk"
					alt6 = "\n/use The \"Devilsaur\" Lunchbox"
					CZ = "Sightless Eye"
				-- Broken Isles is continent 8
				elseif pp == "Broken Isles" then
					alt4 = ink
					alt5 = "\n/use Emerald Winds"..hasCannon
					alt6 = "\n/use The \"Devilsaur\" Lunchbox"
					CZ = "Sightless Eye"
					if z == "Highmountain" then
						alt4 = "\n/use Majestic Elderhorn Hoof"..ink
					end
				-- Draenor is continent 7
				elseif (pp == "Draenor") or (pp == "Frostfire Ridge") or (pp == "Shadowmoon Valley") or (pp == "Ashran") then
					alt4 = ink.."\n/use Spirit of Shinri\n/use Skull of the Mad Chief"
					alt5 = "\n/use Breath of Talador\n/use Black Whirlwind"..hasCannon
					alt6 = "\n/use Ever-Blooming Frond"
					CZ = "Aviana's Feather\n/use Treessassin's Guise"
					LAR = "Findle's Loot-A-Rang"
				-- Pandaria
				elseif (pp == "Pandaria") or (pp == "Vale of Eternal Blossoms") then
					alt4 = ink.."\n/use Cursed Swabby Helmet\n/use Ash-Covered Horn\n/use Battle Horn"
					alt5 = "\n/use Bottled Tornado"..hasCannon
					alt6 = "\n/use Eternal Warrior's Sigil"
					CZ = "[combat]Salyin Battle Banner" 
				-- Northrend
				elseif pp == "Northrend" then
					alt4 = "\n/use Grizzlesnout's Fang"..ink
				end

				EditMacro("WLoot pls",nil,nil,"/click StaticPopup1Button1\n/use Battle Standard of Coordination\n/target mouseover\n/targetlasttarget [noharm,nocombat]\n/use "..LAR.."\n/use [exists,nodead,nochanneling]Rainbow Generator\n/use Gin-Ji Knife Set")

				-- array med klass abilities för varje klass, aC == Alt+456 Class ability
				-- Helpful Dispel Array ctrl+alt+num456
				local aC = {
					["SHAMAN"] = "Cleanse Spirit",
					["MAGE"] = "Remove Curse",
					["WARLOCK"] = "Singe Magic",
					["MONK"] = "Detox",
					["PALADIN"] = "Cleanse",
					["HUNTER"] = "Roar of Sacrifice",
					["ROGUE"] = "Tricks of the Trade",
					["PRIEST"] = "Purify Disease",
					["DEATHKNIGHT"] = "Chains of Ice",
					["WARRIOR"] = "Intervene",
					["DRUID"] = "Remove Corruption", 
					["DEMONHUNTER"] = "Silver-Plated Turkey Shooter",
				}
				-- array med klass abilities för varje klass, PoA == Party or Arena
				local PoA = "@party"
				if class == "DEATHKNIGHT" then
					PoA = "@arena"
				end
				
				--[[DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: New area detected: "..parent.name..".\nRecalibrating zone based macros :)",0.5,1.0,0.0)--]]			

				EditMacro("WMPAlt+4",nil,nil,"/target [nomod]Boss1\n/target [nomod]Arena1\n/use [mod:ctrl"..PoA.. "1]"..aC[class]..""..alt4.."\n/run DepositReagentBank();")
				EditMacro("WMPAlt+5",nil,nil,"/target [nomod]Boss2\n/target [nomod]Arena2\n/use [mod:ctrl"..PoA.. "2]"..aC[class]..""..alt5)
				if class == "DEATHKNIGHT" then
					PoA = "@arena3"
				else
					PoA = "@party"
				end        
				EditMacro("WMPAlt+6",nil,nil,"/target [nomod]Boss3\n/target [nomod]Arena3\n/use [mod:ctrl"..PoA.."]"..aC[class]..""..alt6)
				-- (Shaman är default/fallback)
				local ccz = "/use [nospec:3]Lightning Shield;Water Shield\n/use Haunting Memento"
				if class == "MAGE" then
					ccz = "/use Dalaran Initiates' Pin\n/use [combat,help,nodead][nocombat]Arcane Intellect\n/use [combat]Invisibility\n/use [spec:3,notalent:1/2,nopet]Summon Water Elemental"
				elseif class == "WARLOCK" then
					ccz = "/use Lingering Wyrmtongue Essence\n/use [nocombat]Heartsbane Grimoire\n/use Unending Breath"
				elseif class == "MONK" then
					ccz = ""
				elseif class == "PALADIN" then
					ccz = "/use Contemplation\n/use Bondable Val'kyr Diadem"
				elseif class == "HUNTER" then
					ccz = "/use "..chameleon.."\n/use Zanj'ir Weapon Rack\n/use [nocombat]!Camouflage" 
				elseif class == "ROGUE" then
					ccz = "/use [combat]Vanish;[stance:0,nocombat]Stealth\n/use [spec:2]Slightly-Chewed Insult Book"
				elseif class == "PRIEST" then
					ccz = "/use Power Word: Fortitude\n/use Haunting Memento\n/cancelaura Spirit of Redemption"
				elseif class == "DEATHKNIGHT" then
					ccz = "/use Haunting Memento\n/use [nopet,spec:3]Raise Dead\n/use [noexists,nocombat,spec:2]Vrykul Drinking Horn\n/cancelaura Vrykul Drinking Horn"
				elseif class == "WARRIOR" then
					ccz = "/use Battle Shout\n/use Shard of Archstone\n/use Vrykul Toy Boat Kit"
				elseif class == "DRUID" then
					ccz = "/use Fandral's Seed Pouch\n/use !Prowl\n/use Ravenbear Disguise"
				elseif class == "DEMONHUNTER" then
					ccz = "/use Lingering Wyrmtongue Essence\n/cancelaura Wyrmtongue Disguise"
				end
				
				if ccz and CZ and AR then
					EditMacro("WSxCGen+Z",nil,nil,"/use [nostealth]Repurposed Fel Focuser\n/use Seafarer's Slidewhistle\n/use "..CZ.."\n"..ccz.."\n"..AR)
					--DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Recalibrating zone based variables :)\nalt4 = "..alt4.."\nalt5 = "..alt5.."\nalt6 = "..alt6.."\nCZ = "..CZ.."\nccz = "..ccz.."\naC = "..aC.."\nPoA = "..PoA.."\nAR = "..AR.."\nconTE = "..conTE.."\nconRE = "..conRE.."\nconBE = "..conBE.."\nconCE = "..conCE,0.5,1.0,0.0)
				end		
				--[[print("pp = "..pp)
		    	print("z = "..z)
		    	print("CZ = "..CZ)--]]
				-- om du är i en battleground, kollar inte om det är rated dock.
				if instanceType == "pvp" then
					invisPot = "Potion of Trivial Invisibility" 
					consOne = "Potion of Heightened Senses"
					consTwo = "Potion of Defiance"
					consThree = invisPot
					EditMacro("wWBGHealer1",nil,nil,"/stopmacro [noexists]\n/run if not InCombatLockdown()then local A=UnitName(\"target\") EditMacro(\"wWBGHealerisSet1\",nil,nil,\"/target \"..A, nil)print(\"Healer1 set to : \"..A)else print(\"Cannot change assist now!\")end")
					EditMacro("wWBGHealer2",nil,nil,"/stopmacro [noexists]\n/run if not InCombatLockdown()then local A=UnitName(\"target\") EditMacro(\"wWBGHealerisSet2\",nil,nil,\"/target \"..A, nil)print(\"Healer2 set to : \"..A)else print(\"Cannot change assist now!\")end")        
					EditMacro("wWBGHealer3",nil,nil,"/stopmacro [noexists]\n/run if not InCombatLockdown()then local A=UnitName(\"target\") EditMacro(\"wWBGHealerisSet3\",nil,nil,\"/target \"..A, nil)print(\"Healer3 set to : \"..A)else print(\"Cannot change assist now!\")end")
					EditMacro("wWBGHealerisSet1",nil,nil,"")
					EditMacro("wWBGHealerisSet2",nil,nil,"")        
					EditMacro("wWBGHealerisSet3",nil,nil,"")
				-- om du är i ett dungeon eller raid
				elseif instanceType == "party" or instanceType == "raid" then
					invisPot = "Draenic Invisibility Potion"	
					consOne = "Swiftness Potion"
					consTwo = "Potion of Defiance"
					consThree = invisPot
				end

				EditMacro("wWBGHealer1",nil,nil,"/cleartarget")
				EditMacro("wWBGHealer2",nil,nil,"/cleartarget")        
				EditMacro("wWBGHealer3",nil,nil,"/cleartarget")
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..consOne)
			    EditMacro("WSxSGen+U",nil,nil,"#show\n/use "..consTwo)
			    EditMacro("WSxCGen+U",nil,nil,"#show\n/use "..consThree)	
				EditMacro("wWBGHealerisSet1",nil,nil,"/use [mod:alt,"..PoA.."1,exists]"..numaltcc[class]..";[mod:ctrl,"..PoA.."1,exists]"..numctrlcc[class]..";["..PoA.."1,exists]"..numnomodcc[class])
				EditMacro("wWBGHealerisSet2",nil,nil,"/use [mod:alt,"..PoA.."2,exists]"..numaltcc[class]..";[mod:ctrl,"..PoA.."2,exists]"..numctrlcc[class]..";["..PoA.."2,exists]"..numnomodcc[class])        
				EditMacro("wWBGHealerisSet3",nil,nil,"/use [mod:alt,"..PoA.."3,exists]"..numaltcc[class]..";[mod:ctrl,"..PoA.."3,exists]"..numctrlcc[class]..";["..PoA.."3,exists]"..numnomodcc[class])

				-- Healing Tonic and Scrap Grenade Addon, Ctrl+alt+Capslock
				-- Healthstone Addon "Capslock", Hearthstones, hsToy, Magefood/Water (and eventually Bandages)injector 
				
				local hsNecks = {
					"Man'ari Training Amulet",
					"Eternal Woven Ivy Necklace",
					"Eternal Will of the Martyr",
					"Eternal Talisman of Evasion",
					"Eternal Horizon Choker",
					"Eternal Emberfury Talisman",
					"Eternal Amulet of the Redeemed",
				}
		
				local eqhsNeck = ""
				for i, hsNecks in pairs(hsNecks) do
					if IsEquippedItem(hsNecks) == true then
						eqhsNeck = hsNecks
					end	
				end
				local hasTonics = {
					"item:177278",
					"Superior Healing Potion",
					"Major Healing Potion",
					"Runic Healing Potion",
					"Super Healing Potion",
					"Ancient Healing Potion",
					"Aged Health Potion",
					"Astral Healing Potion",
					"Coastal Healing Potion",
					"Abyssal Healing Potion",
					"Spiritual Healing Potion",
					"Soulful Healing Potion",
					"Cosmic Healing Potion",
					"item:137222",
				}
				local hasTonicInBags = ""
						hasTonicInBags = eqhsNeck
				for i, hasTonics in pairs(hasTonics) do
					if GetItemCount(hasTonics) >= 1 then
				    	hasTonicInBags = hasTonics
					end
				end
						
				if hasTonicInBags == "" then
					hasTonicInBags = hasScrapper
				elseif z == "Brawl'gar Arena" then
					hasTonicInBags = "Brawler's Coastal Healing Potion"
				elseif instanceType == "pvp" and GetItemCount("\"Third Wind\" Potion") >= 1 then 
					hasTonicInBags = "\"Third Wind\" Potion"
				end
				-- overrides potion
				-- Grenades addon "Ctrl+Shift+E"
			
		    	EditMacro("WGrenade",nil,nil,"#show [mod]"..hasScrapper..";"..hasShark.."\n/use Hot Buttered Popcorn\n/use [mod]"..hasScrapper..";"..hasShark)
				
				local sttFBpoS = ""
				if slBP == 1 and GetItemCount("item:177278") > 0 then  
					sttFBpoS = "item:177278"
				else
					sttFBpoS = "Foul Belly"
				end
				EditMacro("WTonic",nil,nil,"#show [mod]"..sttFBpoS..";"..hasTonicInBags.."\n/use Foul Belly\n/use "..hasTonicInBags)

				 -- First Aid Bandages Parser
		        local hasBandages = {
			        "Tidespray Linen Bandage",
			        "Deep Sea Bandage",
			        "Shrouded Cloth Bandage",
			        "Heavy Shrouded Cloth Bandage",
		 	   	}
		 	   	local hasBandagesInBags = ""
		 	   	for i, hasBandages in pairs(hasBandages) do 
			 	   	if GetItemCount(hasBandages) >= 1 then
			 	   		hasBandagesInBags = hasBandages
			 	   	end
			 	end

				-- Magefood parser
				local hasWaters = {
					"Refreshing Spring Water",
					"Ice Cold Milk",
					"Melon Juice",
					"Sweet Nectar",
					"Moonberry Juice",
					"Morning Glory Dew",
					"Honeymint Tea",
				    "Sparkling Oasis Water",
				    "Highland Spring Water",
				    "Ley-Enriched Water",
				    "item:170068",
				    "item:169763",
				    "Seafoam Coconut Water",
				    "Rockskip Mineral Water",
				    "Purified Skyspring Water",
				    "Ethereal Pomegranate",
				    "Shadespring Water",
				    "Stygian Stew",
				    "Conjured Mana Cookie",
				    "Conjured Mana Brownie",
				    "Conjured Mana Pudding",
				    "Conjured Mana Bun",
				    "Conjured Mana Cupcake",
				    "Conjured Mana Lollipop",
				    "Conjured Mana Pie",
				    "Conjured Mana Strudel",
				    "Conjured Mana Cake",
				    "Conjured Mana Fritter",
				}
				local hasWaterInBags = ""
				for i, hasWaters in pairs(hasWaters) do
				    if GetItemCount(hasWaters) >= 1 then
				        hasWaterInBags = hasWaters
				    end
				end

				if hasWaterInBags and GetItemCount(hasWaterInBags) > 0 then
					getWaters = GetItemCount(hasWaterInBags)
					if hasWaterInBags == "item:169763" then
						DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Updating bags :) Your Mardivas's Magnificent Desalinating Pouch is usable :)",0.5,1.0,0.0)
					elseif hasWaterInBags == "item:170068" then
						DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Updating bags :) Your Mardivas's Magnificent Desalinating Pouch is empty :(",0.5,1.0,0.0)
					else
						DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Updating bags :) and found "..getWaters.." "..hasWaterInBags.." to drink! :)",0.5,1.0,0.0)
					end
				end
				if (class == "MAGE" and playerspec == 3) or (class == "DEATHKNIGHT" and playerspec == 2) then
					HS[class] = "Greatfather Winter's Hearthstone"
				elseif (class == "MAGE" and playerspec == 1) then
					HS[class] = "Tome of Town Portal"
				elseif (class == "WARLOCK" and UnitName("player") == "Voidlisa") then
					HS[class] = "Venthyr Sinstone"
				elseif (class == "MONK" and playerspec ~= 1) or (class == "PALADIN" and playerspec ~=3) then
					HS[class] = "Kyrian Hearthstone"
				elseif (class == "HUNTER" and playerspec == 2) then 
					HS[class] = "Holographic Digitalization Hearthstone"
				elseif class == "PRIEST" then
					if playerspec == 2 then
						HS[class] = "Peddlefeet's Lovely Hearthstone"
					elseif playerspec == 1 then
						HS[class] = "Eternal Traveler's Hearthstone"
					end
				elseif class == "DRUID" then
					if playerspec == 1 then
						HS[class] = "Lunar Elder's Hearthstone"
					elseif playerspec == 4 then
						HS[class] = "Night Fae Hearthstone"
					end
				end
				if z == "Alterac Valley" and eLevel > 57 then
					-- race == horde races, else stormpike
					if faction == "Horde" then
						HS[class] = "Frostwolf Insignia"
					else 
						HS[class] = "Stormpike Insignia"
					end
				end

				if HS[class] and hsToy[class] and hasWaterInBags then
					HS[class] = "[mod:ctrl]"..HS[class]..";"

					if class == "MAGE" then 
						local sgen2hasWaterInBags = "Conjure Refreshment"
						if GetItemCount(hasWaterInBags) > 0 then
							sgen2hasWaterInBags = hasWaterInBags
						end
						EditMacro("WSxSGen+2",nil,nil,"/use "..sgen2hasWaterInBags.."\n/use Gnomish X-Ray Specs\n/stopcasting [spec:2]\n/use [nocombat]Conjure Refreshment")
						EditMacro("WSxSGen+1",nil,nil,"#show Alter Time\n/run for i=0,4 do for x=1,GetContainerNumSlots(i) do y=GetContainerItemLink(i,x) if y then if GetItemInfo(y)==\""..sgen2hasWaterInBags.."\" then PickupContainerItem(i,x);DropItemOnUnit(\"target\");return;end end end end\n/click TradeFrameTradeButton")
					end
					if GetItemCount(hasWaterInBags) > 0 then 
						hasWaterInBags = "[mod:alt]"..hasWaterInBags..";"
					end
					if GetItemCount(hasBandagesInBags) > 0 then
						hasBandagesInBags = "[mod]"..hasBandagesInBags..";"
					end
					if GetItemCount("Healthstone", false, true) >= 1 then
						EditMacro("WShow",nil,nil,"/use "..hasWaterInBags..HS[class]..hasBandagesInBags.."Healthstone\n/stopmacro [mod]"..hsToy[class].."\n/run PlaySound(15160)\n/glare", 1, 1)
					else
						EditMacro("WShow",nil,nil,"/use "..hasWaterInBags..HS[class]..hasBandagesInBags.."\n/stopmacro [mod]"..hsToy[class].."\n/use Healthstone\n/run PlaySound(15160)\n/cry", 1, 1)
					end
				end

				-- Garrisons Knappen, Mobile Gbank, Nimble Brew if has.
				local nBrew = "Nimble Brew"
				if GetItemCount("Nimble Brew") < 1 then 
					nBrew = "Magic Pet Mirror"
				end
				EditMacro("Wx2Garrisons",nil,nil,"#show\n/use [nocombat,noexists,nomod]Mobile Banking(Guild Perk);[mod:shift]Narcissa's Mirror;"..nBrew)

				local hasDrums = {
					"Drums of Rage",
					"Drums of Fury",
					"Drums of the Mountain",
					"Drums of the Maelstrom",
					"Drums of Deathly Ferocity",
				}
				local hasDrumsInBags = "Hot Buttered Popcorn"
				for i, hasDrums in pairs(hasDrums) do
				    if GetItemCount(hasDrums) >= 1 then
				        hasDrumsInBags = hasDrums
				    end
				end

				local name = AuraUtil.FindAuraByName("Lone Wolf", "player") 
				local bladlast = "Bloodlust"
				if class == "SHAMAN" then
					if faction == "Alliance" then 
				    	bladlast = "Heroism" 
					end
				elseif class == "MAGE" then 
					bladlast = "Time Warp"
				elseif class == "HUNTER" then
					-- hunter med bl drums
					if (name == nil and petspec ~= 1 and hasDrumsInBags) then
						bladlast = "[nopet]Call Pet 5;[pet]"..hasDrumsInBags
					-- hunter med bl pet
					elseif (name == nil and petspec == 1) then
						bladlast = "[nopet]Call Pet 5;[pet]Command Pet" 
					-- lone wolf hunter med bl drums
					elseif name == "Lone Wolf" then
						bladlast = "[nopet]"..hasDrumsInBags..";[pet]Command Pet" 
					end
				else
					bladlast = hasDrumsInBags
				end

				-- #show Bloodlust, Time Warp, Netherwinds, Drums and Favorite mount - Ctrl+Shift+V
				if class == "PRIEST" then
					EditMacro("WSxFavMount",nil,nil,"#show " ..bladlast.. "\n/run C_MountJournal.SummonByID(0)\n/dismount [mounted]\n/cancelaura Flaming Hoop/use Celebration Firework")
				else
					EditMacro("WSxFavMount",nil,nil,"#show " ..bladlast.. "\n/run C_MountJournal.SummonByID(0)\n/dismount [mounted]\n/cancelform Bear Form\n/cancelform Cat Form\n/cancelaura Zen Flight\n/cancelaura Flaming Hoop\n/cancelaura Prowl\n/use Celebration Firework\n/cancelaura Stealth")
				end
				--  T75 Talents, "Ctrl+7" bind Bloodlusts etc and SGen+G Biggest Dick in the game, Poppa BL, Ctrl+7 and ptdSG injector
				if class == "SHAMAN" then
					EditMacro("WSxT75",nil,nil,"#show [mod] " ..bladlast.. ";[talent:5/1]Wind Shear;[spec:1,talent:5/2]Ancestral Guidance;[spec:2,talent:5/2]Feral Lunge;[talent:5/3]Wind Rush Totem;" ..bladlast.. ";\n/use " ..bladlast.."\n/use [nocombat]Thunderstorm")
					EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG.."[@mouseover,harm,nodead][harm,nodead]Purge;Flaming Hoop\n/targetenemy [noexists]\n/cleartarget [dead]")
				-- Is class Mage
				elseif class == "MAGE" then
					EditMacro("WSxT75",nil,nil,"#show [mod] " ..bladlast.. ";[talent:5/3]Ring of Frost;Polymorph\n/use " ..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG.."Spellsteal\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]\n/use Poison Extraction Totem")
				-- Is class Warlock
				elseif class == "WARLOCK" then
					EditMacro("WSxT75",nil,nil,"#show [mod]"..bladlast..";[talent:5/1]Shadowfury;[talent:5/2]Mortal Coil;[talent:5/3]Howl of Terror\n/use " ..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG.."[pet:Felhunter/Observer]Devour Magic;[pet:Felguard]Axe Toss;Command Demon\n/use [noexists,nocombat] Flaming Hoop\n/targetenemy [noexists]")
				-- Is class Monk
				elseif class == "MONK" then
					EditMacro("WSxT75",nil,nil,"#show [mod] " ..bladlast.. ";[nospec:3]Fortifying Brew;[talent:5/1]Healing Elixir;[talent:5/2]Diffuse Magic;[talent:5/3]Dampen Harm;\n/use "..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG.."Pandaren Scarecrow\n/use [noexists,nocombat]Flaming Hoop\n/run if (not InCombatLockdown()) and UnitIsPlayer(\"target\") then DoEmote(\"bow\") end")
				-- Is class Paladin
				elseif class == "PALADIN" then
				    EditMacro("WSxT75",nil,nil,"#show [mod] " ..bladlast.. ";[talent:5/2]Holy Avenger;[talent:5/3]Seraphim;Concentration Aura\n/use " ..bladlast)
				    EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG.."Hammer of Justice\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]")
				-- Is class Hunter
				elseif class == "HUNTER" then
					EditMacro("WSxT75",nil,nil,"#show [spec:2,nomod][talent:5/3,nomod]Binding Shot;"..bladlast.."\n/use " ..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"#show Tranquilizing Shot\n/use [@mouseover,harm,nodead][]Tranquilizing Shot\n/use [nocombat,noexists,nomounted]Nat's Fishing Chair\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\"); else DoEmote(\"kneel\") end end")
				-- Is class Rogue
				elseif class == "ROGUE" then
					EditMacro("WSxT75",nil,nil,"#show\n/use " ..bladlast)
					if ptdSG and class == "ROGUE" then
						ptdSG = "[mod:alt]Protocol Transference Device;"
					end
					EditMacro("WSxGG",nil,nil,"#show\n/use [mod:alt,nocombat,noexists]Darkmoon Gazer;"..ptdSG.."[@mouseover,harm,nodead][harm,nodead]Shiv;Pick Lock")
					EditMacro("WSxSGen+G",nil,nil,"#show\n/targetenemy [noexists]\n/use [stance:0,nocombat]Stealth;[mod:alt,@focus,exists,nodead][]Kidney Shot\n/use [nocombat,noexists,stance:0]Flaming Hoop")
				-- is class Prist
				elseif class == "PRIEST" then
					EditMacro("WSxT75",nil,nil,"#show [mod] " ..bladlast.. ";[spec:1,talent:5/3]Shadow Covenant;[spec:2,talent:5/2]Binding Heal;[spec:3,talent:5/3]Shadow Crash;Smite\n/use " ..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG.."[@mouseover,harm,nodead][harm,nodead]Dispel Magic;Personal Spotlight\n/use [noexists,nocombat] Flaming Hoop\n/targetenemy [noexists]")
				-- Is class Death Knight
				elseif class == "DEATHKNIGHT" then
					EditMacro("WSxT75",nil,nil,"#show [mod] " ..bladlast.. ";[nospec:1,talent:5/2][spec:1,talent:5/3]Wraith Walk;[nospec:1,talent:5/3]Death Pact\n/use " ..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG.."[spec:2,talent:3/3]Blinding Sleet;[spec:2,talent:3/2][spec:1]Asphyxiate;[nopet]Raise Dead;[pet]!Gnaw\n/use [noexists,nocombat] Flaming Hoop\n/petattack [harm,nodead]")
				-- Is class Warrior
				elseif class == "WARRIOR" then
					EditMacro("WSxT75",nil,nil,"#show [mod]"..bladlast.. ";[spec:1,talent:5/3]Cleave;[spec:1]Colossus Smash;[spec:3,talent:5/3][]Victory Rush\n/use "..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG.."[talent:2/3]Storm Bolt;Victory Rush\n/use [noexists,nocombat]Flaming Hoop")
				-- Is class Druid
				elseif class == "DRUID" then
					EditMacro("WSxT75",nil,nil,"#show [mod]" ..bladlast..";[spec:1]Celestial Alignment;[spec:2,talent:5/2]Savage Roar;[spec:2/3]Berserk;[spec:4,talent:5/3]Incarnation: Tree of Life(Talent, Shapeshift)\n/use ".. bladlast) 
					EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG.."[spec:3/4,talent:3/2,form:2][spec:1,talent:3/1,form:2][spec:2,form:2]Maim;Soothe\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]") 
				-- Is class Demon Hunter
				elseif class == "DEMONHUNTER" then
					EditMacro("WSxT75",nil,nil,"#show [mod]" ..bladlast.. ";[spec:2,talent:5/3]Sigil of Chains;[spec:1,talent:5/3]Essence Break;Blade Dance\n/use " ..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"/use "..ptdSG.."[spec:1,talent:6/3]Fel Eruption;Consume Magic\n/use [noexists,nocombat] Flaming Hoop")
				end -- class
			end -- map
		end -- event
		-- Byta talent eller zone events
		if (event == "ZONE_CHANGED_NEW_AREA" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PLAYER_LOGIN") then
      	
			if glider >= 1 then
				glider = "Goblin Glider Kit"
			else 
				glider = "15"
			end
			if brazier ~= 1 then 
				brazier = ""
			else 
				brazier = "\n/use [mod:ctrl]Brazier of Awakening"
			end
			--DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Talent change detected! :)",0.5,1.0,0.0)
			-- PvP Talents
			-- Hämta aktiva talents
			local PvPTalentNames, PvPTalentIcons = {}, {}
			local i = 0
			for k, v in pairs(C_SpecializationInfo.GetAllSelectedPvpTalentIDs()) do
				i = i + 1
				if i >= 1 then
					local _, name, icon = GetPvpTalentInfoByID(v)
					PvPTalentNames[i] = name
					PvPTalentIcons[i] = icon
					--[[print(name)--]]
				end
			end

			-- Redigera macron
			for i = 1, 3 do
				if PvPTalentNames[i] == "Drink Up Me Hearties" then
					PvPTalentNames[i] = "Create: Crimson Vial"
					PvPTalentIcons[i] = 463862
				end

				if UnitIsPVP("player") == true then
					if PvPTalentNames[i] then
						-- Talent finns
						EditMacro("PvPAT " .. i, nil, PvPTalentIcons[i], "/stopspelltarget\n/stopspelltarget\n/use [mod,@focus,exists,nodead][mod,@player]"..PvPTalentNames[i].."\n/use [@mouseover,exists,nodead,nomod][@cursor,nomod]"..PvPTalentNames[i])
					else
						EditMacro("PvPAT " .. i, nil, 237554, "")
				    end
					if class == "SHAMAN" then 
						if PvPTalentNames[i] == "Skyfury Totem" then
							shaPvPExc = "[talent:6/2]Fire Elemental;Skyfury Totem"
						end
						if PvPTalentNames[i] == "Shamanism" then
							if faction == "Alliance" then
								PvPTalentNames[i] = "Heroism"
							elseif faction == "Horde" then
								PvPTalentNames[i] = "Bloodlust"
							end
							EditMacro("PvPAT " .. i, nil, PvPTalentIcons[i], "/stopspelltarget\n/stopspelltarget\n/targetfriendplayer [mod]\n/use [mod,@focus,exists,nodead][mod,help,nodead][mod,@player]"..PvPTalentNames[i].."\n/targetlasttarget [mod]\n/use [@mouseover,exists,nodead,nomod][@cursor,nomod]"..PvPTalentNames[i])
						end

						if PvPTalentNames[i] == "Thundercharge" then
							EditMacro("PvPAT " .. i, nil, PvPTalentIcons[i], "/stopspelltarget\n/stopspelltarget\n/targetfriendplayer [mod]\n/use [mod,@focus,exists,nodead][mod,help,nodead][mod,@player]"..PvPTalentNames[i].."\n/targetlasttarget [mod]\n/use [@mouseover,exists,nodead,nomod][@cursor,nomod]"..PvPTalentNames[i])
						end
						
					elseif class == "WARLOCK" then
						if PvPTalentNames[i] == "Call Felhunter" then
							locPvPExcQQ = "[@mouseover,harm,nodead][]Call Felhunter"
							locPvPExcGenF = "[@focus,harm,nodead]Call Felhunter;"
						end
						if PvPTalentNames[i] == "Call Fel Lord" then
							locPvPExcSeven = "[mod,@player][@cursor]Call Fel Lord;"
						end
						if PvPTalentNames[i] == "Fel Obelisk" then
							locPvPExcSThree = "[@player]Fel Obelisk"
						end
					elseif class == "WARRIOR" and PvPTalentNames[i] == "Death Wish" then
						warPvPExc = "[]Death Wish;"
					end
					
				end

			end
			
			-- Offensive Counter abilities Array 
			-- shift+alt+wmp456
			local wmpaltcc = {
				["SHAMAN"] = "Purge",
				["MAGE"] = "Spellsteal",
				["WARLOCK"] = "Devour Magic",
				["MONK"] = "Disable",
				["PALADIN"] = "Hammer of Justice",
				["HUNTER"] = "Harpoon",
				["ROGUE"] = "Shadowstep",
				["PRIEST"] = "Dispel Magic",
				["DEATHKNIGHT"] = "Dark Simulacrum",
				["WARRIOR"] = "Charge",
				["DRUID"] = "Entangling Roots", 
				["DEMONHUNTER"] = "Consume Magic",
			}
			-- shift+ctrl+wmp456
			local wmpctrlcc = {
				["SHAMAN"] = "Hex",
				["MAGE"] = "Polymorph",
				["WARLOCK"] = "Fear",
				["MONK"] = "Paralysis",
				["PALADIN"] = "Repentance",
				["HUNTER"] = "Intimidation",
				["ROGUE"] = "Blind",
				["PRIEST"] = "Mind Bomb",
				["DEATHKNIGHT"] = "Asphyxiate",
				["WARRIOR"] = "Storm Bolt",
				["DRUID"] = "Cyclone", 
				["DEMONHUNTER"] = "Imprison",
			}
			if class == "ROGUE" and playerspec == 2 then
				wmpctrlcc[class] = "Kidney Shot"
			end
			local wmpnomodcc = {
				["SHAMAN"] = "Wind Shear",
				["MAGE"] = "Counterspell",
				["WARLOCK"] = locPvPExcQQ,
				["MONK"] = "Spear Hand Strike",
				["PALADIN"] = "Rebuke",
				["HUNTER"] = "Counter Shot",
				["ROGUE"] = "Kick",
				["PRIEST"] = "Silence",
				["DEATHKNIGHT"] = "Mind Freeze",
				["WARRIOR"] = "Pummel",
				["DRUID"] = "Solar Beam", 
				["DEMONHUNTER"] = "Disrupt",
			}
			if class == "DRUID" then
				if (playerspec == 2 or playerspec == 3) then
					wmpnomodcc[class] = "Skull Bash"
				else
					wmpnomodcc[class] = "Cyclone"
				end
			end 

			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1]"..wmpaltcc[class]..";[mod:ctrl,@arena1]"..wmpctrlcc[class]..";[@arena1,exists][@boss1,exists]"..wmpnomodcc[class]..";" ..one)
			EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2]"..wmpaltcc[class]..";[mod:ctrl,@arena2]"..wmpctrlcc[class]..";[@arena2,exists][@boss2,exists]"..wmpnomodcc[class]..";" ..two)        
			EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3]"..wmpaltcc[class]..";[mod:ctrl,@arena3]"..wmpctrlcc[class]..";[@arena3,exists][@boss3,exists]"..wmpnomodcc[class]..";" ..tre)

			-- Target Calling Macro    
			EditMacro("WACommandKill",nil,nil,"/stopmacro [noexists]\n/run if UnitRace(\"target\") then SendChatMessage(\"Kill my target NOW! ->> %t the \"..(UnitRace(\"target\")..\" \"..UnitClass(\"target\"))..\" \", IsInGroup(2) and \"instance_chat\" or IsInRaid() and \"raid\" or IsInGroup() and \"party\" or \"say\")end")
			EditMacro("WACommandRare",nil,nil,"/run a=UnitName('target');b=C_Map;c='player';d=b.GetBestMapForUnit(c);e=b.GetPlayerMapPosition(d,c);b.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(d,e.x,e.y));SendChatMessage(a..' at '..b.GetUserWaypointHyperlink(),'CHANNEL',c,1);b.ClearUserWaypoint()")
			
			if racials[race] then
				if race == "VoidElf" then
					EditMacro("Wx6RacistAlt+V",nil,nil,"#show " ..racials[race].."\n/use Prismatic Bauble\n/use Sparklepony XL\n/castsequence reset=9 "..racials[race]..",Languages")
				else
					EditMacro("Wx6RacistAlt+V",nil,nil,"#show " ..racials[race].."\n/use Prismatic Bauble\n/use Sparklepony XL\n/use "..racials[race])
				end

			    -- Class Artifact Button, "§" Completed, note: Kanske kan hooka Heart Essence till fallback från Cov och Signature Ability? Sedan behöver vi hooka Ritual of Doom till Warlock Order Hall också.
				-- Covenant and Signature Ability parser
				-- Kyrian, "Summon Steward", phial of serenity

				local sigA,sigB,covA,poS,hoaEq,hasHE  = "","","Covenant Ability","","[@mouseover,exists,nodead][@cursor]13",""
				if IsSpellKnown(324739) == true then
					poS = "\n/use [mod]item:177278"
					sigA = "Summon Steward"
					if class == "SHAMAN" then
						covA = "Vesper Totem"
					elseif class == "MAGE" then
						covA = "Radiant Spark"
					elseif class == "WARLOCK" then
						covA = "Scouring Tithe"
					elseif class == "MONK" then
						covA = "Weapons of Order"
					elseif class == "PALADIN" then
						covA = "Divine Toll"
					elseif class == "HUNTER" then
						covA = "Resonating Arrow"
					elseif class == "ROGUE" then
						covA = "Echoing Reprimand"
					elseif class == "PRIEST" then
						covA = "Boon of the Ascended"
					elseif class == "DEATHKNIGHT" then
						covA = "Shackle the Unworthy"
					elseif class == "WARRIOR" then
						covA = "Spear of Bastion"
					elseif class == "DRUID" then
						covA = "Kindred Spirits"
					elseif class == "DEMONHUNTER" then
						covA = "Elysian Decree"
					end
				-- Necrolord, "Fleshcraft" 
				elseif IsSpellKnown(324631) == true then
					sigA = "Fleshcraft"
					if class == "SHAMAN" then
						covA = "Primordial Wave"
					elseif class == "MAGE" then
						covA = "Deathborne"
					elseif class == "WARLOCK" then
						covA = "Decimating Bolt"
					elseif class == "MONK" then
						covA = "Bonedust Brew"
					elseif class == "PALADIN" then
						covA = "Vanquisher's Hammer"
					elseif class == "HUNTER" then
						covA = "Death Chakram"
					elseif class == "ROGUE" then
						covA = "Serrated Bone Spike"
					elseif class == "PRIEST" then
						covA = "Unholy Nova"
					elseif class == "DEATHKNIGHT" then
						covA = "Abomination Limb"
					elseif class == "WARRIOR" then
						covA = "Conqueror's Banner"
					elseif class == "DRUID" then
						covA = "Adaptive Swarm"
					elseif class == "DEMONHUNTER" then
						covA = "Fodder to the Flame"
					end
				-- Night Fae, "Soulshape"
				elseif IsSpellKnown(310143) == true then
					sigA = "Soulshape"
					if class == "SHAMAN" then
						covA = "Fae Transfusion"
					elseif class == "MAGE" then
						covA = "Shifting Power"
					elseif class == "WARLOCK" then
						covA = "Soul Rot"
					elseif class == "MONK" then
						covA = "Faeline Stomp"
					elseif class == "PALADIN" then
						covA = "Blessing of Summer"
					elseif class == "HUNTER" then
						covA = "Wild Spirits"
					elseif class == "ROGUE" then
						covA = "Sepsis"
					elseif class == "PRIEST" then
						covA = "Fae Guardians"
					elseif class == "DEATHKNIGHT" then
						covA = "Death's Due"
					elseif class == "WARRIOR" then
						covA = "Ancient Aftershock"
					elseif class == "DRUID" then
						covA = "Convoke the Spirits"
					elseif class == "DEMONHUNTER" then
						covA = "The Hunt"
					end
				-- Venthyr, "Door of Shadows"
				elseif IsSpellKnown(300728) == true then
					sigA = "Door of Shadows"
					if class == "SHAMAN" then
						covA = "Chain Harvest"
					elseif class == "MAGE" then
						covA = "Mirrors of Torment"
					elseif class == "WARLOCK" then
						covA = "Impending Catastrophe"
					elseif class == "MONK" then
						covA = "Fallen Order"
					elseif class == "PALADIN" then
						covA = "Ashen Hallow"
					elseif class == "HUNTER" then
						covA = "Flayed Shot"
					elseif class == "ROGUE" then
						covA = "Flagellation"
					elseif class == "PRIEST" then
						covA = "Mindgames"
					elseif class == "DEATHKNIGHT" then
						covA = "Swarming Mist"
					elseif class == "WARRIOR" then
						covA = "Condemn"
					elseif class == "DRUID" then
						covA = "Ravenous Frenzy"
					elseif class == "DEMONHUNTER" then
						covA = "Sinful Brand"
					end
				end
				
				-- hard exceptions
				
				sigB = "[@mouseover,exists,nodead,mod][@cursor,mod]"..sigA
				covA = "[@mouseover,exists,nodead][@cursor]"..covA..poS
				hoaEq = "[@mouseover,exists,nodead][@cursor]Heart Essence"
				local slBPGen
				if (covA == "[@mouseover,exists,nodead][@cursor]Condemn" and IsEquippedItem("Heart of Azeroth")) and not slZones[z] then
					slBPGen = sigB..";"..hoaEq
				elseif covA == "Condemn" then 
					hoaEq = "13"
					slBPGen = sigB..";"..hoaEq
				elseif slBP ~= 0 then 
					slBPGen = sigB..";"..covA
				elseif (IsEquippedItem("Heart of Azeroth") and slBP == 0) then
					slBPGen = hoaEq
				else
					slBPGen = "13"
				end
				
				if class == "MAGE" then 
					hasHE = "\n/use Mirror Image" 
				end

				--alt+6 mods
				if (IsEquippedItem("Heart of Azeroth") and not slZones[z]) then
					hoaEq = "/stopspelltarget\n/stopspelltarget\n/use [mod,@player][@mouseover,exists,nodead][@cursor]Heart Essence"
					if class == "MAGE" then
						hasHE = "\n/castsequence Mirror Image, Heart Essence"
					else
						hasHE = "\n/use Heart Essence" 
					end
				elseif class == "WARLOCK" then
					hoaEq = "/use [nocombat,noexists]Wand of Simulated Life;[talent:5/2]Mortal Coil;[talent:5/3]Howl of Terror;Curse of Exhaustion"
				elseif class == "HUNTER" then 
					hoaEq = "/use [nocombat,noexists]Wand of Simulated Life;Misdirection"
				elseif class == "PRIEST" then 
					hoaEq = "/use [nocombat,noexists]Wand of Simulated Life;Mind Soothe"
				else
					hoaEq = "/use Wand of Simulated Life"
				end
				
				EditMacro("WArtifactCDs",nil,nil,"#showtooltip\n/stopspelltarget\n/stopspelltarget\n/use [@mouseover,help,dead,nomod][help,dead,nomod]Unstable Temporal Time Shifter;"..slBPGen)
				EditMacro("WSxCAGen+§",nil,nil,"/use [@player,mod]"..sigA..";[@player][@mouseover,exists,nodead][@cursor]"..covA)
				--[[print("sigA = "..sigA)--]]


				
				EditMacro("Wx4Trinket1",nil,nil,"#showtooltip\n/use [@mouseover,exists,nodead][@cursor][]13")

				--[[				EditMacro("Wx4Trinket1",nil,nil,"/run local Z,_,d=\"Mirror of the Blademaster\",GetItemCooldown(124224) if IsEquippedItem(Z) and d==0 then SendChatMessage(\"Daddy, i'm going to use \" .. Z .. \" pls no moverino", "SAY\") end")
				--]]

				-- EditMacro("Wx5Trinket2",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use 14\n/use [nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;Eternal Black Diamond Ring")
				
				local pennantClass = "\n/use Honorable Pennant"

				if class == "ROGUE" and playerspec ~= 2 then
					pennantClass = "\n/use Honorable Pennant\n/cancelaura A Mighty Pirate"
				elseif class == "ROGUE" then 
					pennantClass = "\n/use Jolly Roger\n/cancelaura Honorable Pennant"
				end

				EditMacro("Wx1Trinkit",nil,nil,"#show\n"..hoaEq.."\n/stopmacro [combat,channeling]\n/use Attraction Sign\n/use Rallying War Banner"..pennantClass)
				
				if (class == "WARLOCK" or class == "DEMONHUNTER") then
					EditMacro("Wx5Trinket2",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use 14\n/use [nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Fractured Necrolyte Skull;[help,dead,nocombat]Cremating Torch;Eternal Black Diamond Ring")
				else
					EditMacro("Wx5Trinket2",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use 14\n/use [nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;Eternal Black Diamond Ring")
				end

				local nPepe = ""
	    		local name = AuraUtil.FindAuraByName("Pepe", "player") 
				if nPepe then
					if (name ~= "Pepe" and (class == "WARLOCK" or class == "DEMONHUNTER")) then 
						name = "\n/use [nocombat,noexists]A Tiny Set of Warglaives"
					elseif (name ~= "Pepe" and (class ~= "WARLOCK" or class ~= "DEMONHUNTER")) then
						name = "\n/use [nocombat,noexists]Trans-Dimensional Bird Whistle"
					else
						name = ""
					end
					nPepe = name
					--[[print("nPepe = "..nPepe)--]]
				end
			 
				-- Main Class configuration
				-- Shaman
				if class == "SHAMAN" then
					EditMacro("WSkillbomb",nil,nil,"/use [spec:1]Fire Elemental;[spec:2]Feral Spirit;Earth Elemental\n/use Rukhmar's Sacred Memory\n/use Ascendance"..dpsRacials[race].."\n/use [@player]13\n/use 13\n/use Flippable Table\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")	
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]"..glider..";[mod]6;[nocombat]Ancestral Spirit;"..pwned.."\n/use [mod:ctrl]Ancestral Vision"..brazier)
					EditMacro("WSxSGen+1",nil,nil,"#show [spec:3]Spirit Link Totem;[spec:2,talent:4/3]Fire Nova;Haunted War Drum\n/use [mod:alt,@party3,help,nodead][mod,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Healing Surge\n/use [nocombat]Haunted War Drum")
					EditMacro("WSxGen2",nil,nil,"#show\n/use [nocombat,noexists]Raging Elemental Stone;[spec:2]Lava Lash;[@mouseover,harm,nodead][]Lightning Bolt\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/use [mod,@party4,help,nodead][@mouseover,help,nodead][]Healing Surge\n/cancelaura X-Ray Specs\n/use Gnomish X-Ray Specs")
					EditMacro("WSxCSGen+2",nil,nil,"/use [spec:3,@focus,help,nodead][spec:3,@party1,help,nodead]Purify Spirit;[@focus,help,nodead][@party1,help,nodead]Cleanse Spirit;[nocombat,noharm]Spirit Wand;")
					EditMacro("WSxGen3",nil,nil,"#show\n/startattack\n/targetenemy [noexists]\n/use [nocombat,noexists]Tadpole Cloudseeder;[spec:2]Stormstrike;[@mouseover,harm,nodead][]Lava Burst\n/cleartarget [dead]")
					EditMacro("WSxSGen+3",nil,nil,"#show Flame Shock\n/cleartarget [dead]\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead,nomod][nomod]Flame Shock\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Flame Shock\n/targetlasttarget")
					EditMacro("WSxCSGen+3",nil,nil,"/use [spec:3,@focus,help,nodead][spec:3,@party2,help,nodead]Purify Spirit;[nospec:2,@focus,harm,nodead]Flame Shock;[@party2,help,nodead]Cleanse Spirit;[nocombat,noharm]Cranky Crab;\n/cleartarget [dead]\n/stopspelltarget")
					EditMacro("WSxCGen+4",nil,nil,"#show\n/use [@party3,help,nodead,mod:alt]Riptide;[talent:7/3]Ascendance;[spec:2,talent:7/2]Earthen Spike;[spec:3,talent:7/2]Wellspring;[spec:1,talent:7/2]Stormkeeper\n/targetenemy [noexists]\n/use Trawler Totem")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Earth Shield")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,help,nodead][@party2,help,nodead][@targettarget,help,nodead]Earth Shield\n/use [spec:3]Waterspeaker's Totem")
					EditMacro("WSxSGen+6",nil,nil,"/use [spec:3]Healing Tide Totem;[@mouseover,help,nodead][]Chain Heal\n/use [nocombat,noexists]Goren \"Log\" Roller\n/use Orb of Deception\n/leavevehicle")
					EditMacro("WSxGen7",nil,nil,"/use [spec:3,mod:shift,@player]Healing Rain;[spec:1,mod:shift,@player][spec:1,@cursor]Earthquake;[@mouseover,harm,nodead][harm,nodead]Chain Lightning;Bom'bay's Color-Seein' Sauce\n/startattack\n/use [noexists,nocombat]Moonfang's Paw")
					EditMacro("WSxQQ",nil,nil,"/stopcasting [nomod:alt]\n/use [mod:alt,@focus,harm,nodead]Hex;[mod:shift]Tremor Totem;[help]Foot Ball;[nocombat,noexists]The Golden Banana;[@mouseover,harm,nodead][]Wind shear\n/use [nocombat,spec:3]Bubble Wand\n/cancelaura Bubble Wand")
					EditMacro("WSxStuns",nil,nil,"#show [mod:alt,spec:3,@player]Healing Rain;[nocombat,noexists]Party Totem;Capacitor Totem\n/use [mod:alt,spec:3,@player]Healing Rain;[@cursor]Capacitor Totem;\n/use Haunting Memento\n/use [nocombat,noexists]Party Totem")
					EditMacro("WSxRTS",nil,nil,"#show Earthbind Totem\n/use [mod:shift,@cursor]Earthbind Totem;[@mouseover,harm,nodead][]Frost Shock\n/targetenemy [noharm]\n/cleartarget [dead]")
					EditMacro("WSxClassT",nil,nil,"/use [spec:3,talent:3/2,@player][spec:3,talent:3/2,@cursor]Earthgrab Totem;Frost Shock"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxGenF",nil,nil,"#show\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@cursor]Far Sight;[@focus,harm,nodead]Wind Shear;Mrgrglhjorn\n/use Survey")
					EditMacro("WSxSGen+F",nil,nil,"#show\n/use [nocombat,noexists,mod:alt]Gastropod Shell;[nocombat,noexists,nomod]Totem of Harmony;Lightning Shield\n/cancelform [mod:alt]")
					EditMacro("WSxCGen+F",nil,nil,"#show [mod]"..fftpar..";Hex\n/use [spec:1,talent:5/2]Ancestral Guidance\n/use "..fftpar.."\n/cancelaura Thistleleaf Disguise")
					EditMacro("WSxCAGen+F",nil,nil,"#show [nospec:2]Spiritwalker's Grace;[spec:2]Spirit Walk\n/run if not InCombatLockdown() then if GetSpellCooldown(198103)==0 then "..tpPants.." else "..noPants.." end end\n/stopcasting\n/use [@cursor]Demonic Gateway\n/use Gateway Control Shard")
					EditMacro("WSxGG",nil,nil,"/use [mod:alt]Darkmoon Gazer;[@mouseover,harm,nodead]Purge;[spec:3,@mouseover,help,nodead][spec:3]Purify Spirit;[@mouseover,help,nodead][]Cleanse Spirit\n/targetenemy [noexists]\n/use Poison Extraction Totem")
					EditMacro("WSxSGen+H",nil,nil,"#show Healing Stream Totem\n/use [nomounted]Darkmoon Gazer\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\"); else DoEmote(\"kneel\") end end")
					EditMacro("WSxDef",nil,nil,"#show\n/use [mod:alt]Flametongue Weapon;[mod:shift,@player,spec:3]Spirit Link Totem;Astral Shift\n/use Whole-Body Shrinka'\n/use [mod:alt]Gateway Control Shard")
					EditMacro("WSxMove",nil,nil,"/use [talent:5/3,@cursor]Wind Rush Totem;[spec:1,talent:5/2]Ancestral Guidance;[spec:2,talent:5/2]Feral Lunge;[noform]Ghost Wolf\n/use Panflute of Pandaria\n/use Croak Crock\n/cancelaura Rhan'ka's Escape Plan\n/use Desert Flute\n/use Sparklepony XL")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@mouseover,help,nodead][nomod]Water Walking\n/use [swimming,nomod]Barnacle-Encrusted Gem\n/use [mod]Weathered Purple Parasol")   
					-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"\\#show Tremor Totem\\n/use [mod:shift,@\"..B..\"]Healing Surge;[@\"..B..\"]Earth Shield\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
					EditMacro("WSxGen+B",nil,nil,"#show Tremor Totem")
					EditMacro("WSxGen+N",nil,nil,"#show Reincarnation")
					-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"\\#show Reincarnation\\n/use [mod:shift,@\"..N..\"]Healing Surge;[@\"..N..\"]Earth Shield\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
					EditMacro("WSxT15",nil,nil,"#show [spec:3,talent:1/3]Unleash Life;[spec:2,talent:1/3]Elemental Blast;[spec:1,talent:1/3]Static Discharge;Flame Shock\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#show\n/use [mod:alt,@player]Capacitor Totem;[spec:3,talent:2/3]Surge of Earth;[spec:1,talent:2/2]Echoing Shock;[spec:2,talent:2/3]Ice Strike;[spec:1,talent:2/3]Elemental Blast;Water Walking"..oOtas)
					EditMacro("WSxT45",nil,nil,"#show\n/use [mod:alt,@player]Earthbind Totem;Healing Stream Totem\n/use Arena Master's War Horn\n/use Totem of Spirits\n/use [nocombat]Void-Touched Souvenir Totem")
					EditMacro("WSxT60",nil,nil,"#show [spec:3,talent:4/2]Earthen Wall Totem;[spec:3,talent:4/3]Ancestral Protection Totem;[spec:1,talent:4/3]Liquid Magma Totem;Vol'Jin's Serpent Totem\n/use Vol'Jin's Serpent Totem\n/click TotemFrameTotem1 RightButton\n/cry")
					EditMacro("WSxT100",nil,nil,"#show [talent:7/3]Ascendance;[spec:2,talent:7/2]Earthen Spike;[spec:3,talent:7/2]Wellspring;[spec:1,talent:7/2]Stormkeeper;")
					EditMacro("WSxCSGen+G",nil,nil,"#show Tremor Totem\n/use [@focus,harm,nodead]Purge;[spec:3,@focus,help,nodead]Purify Spirit;[@focus,help,nodead]Cleanse Spirit\n/cancelaura Whole-Body Shrinka'\n/cancelaura Growing Pains")
					EditMacro("WSxGND",nil,nil,"/use [mod:alt]Windfury Weapon;[mod:ctrl]Astral Recall;[mod,spec:2]Spirit Walk;[mod]Spiritwalker's Grace;[@mouseover,spec:3,help,nodead][@mouseover,talent:3/2,help,nodead][spec:3][talent:3/2]Earth Shield\n/use Void Totem\n/use Deceptia's Smoldering Boots")
					EditMacro("Wx5Trinket2",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod,@party4,help,nodead]Riptide;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14\n/use Eternal Black Diamond Ring")
					if playerspec == 1 then
						EditMacro("WSxGen1",nil,nil,"/use [spec:1,talent:1/3,harm,nodead]Static Discharge;[@mouseover,harm,nodead,talent:6/3][harm,talent:6/3]Frost Shock;[@mouseover,harm,nodead][harm,nodead]Flame Shock;Xan'tish's Flute\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxSGen+4",nil,nil,"/use [noexists,nocombat]Sen'jin Spirit Drum;[talent:4/2,pet:Primal Storm Elemental]Call Lightning;[pet:Primal Fire Elemental,@mouseover,harm,nodead][pet:Primal Fire Elemental]Meteor;[talent:6/3]Icefury;"..shaPvPExc.."\n/startattack")
						EditMacro("WSxGen5",nil,nil,"#show\n/use [mod]Earth Elemental;Earth Shock\n/targetenemy [noexists,nomod]\n/stopmacro [nomod]\n/target Greater Earth Ele\n/focus [exists,help,nodead]target\n/clearfocus [dead]\n/use Words of Akunda")
						EditMacro("WSxSGen+5",nil,nil,"/use [mod,talent:4/3,@player][talent:4/3,@cursor]Liquid Magma Totem;[talent:4/2,pet:Primal Storm Elemental,@mouseover,harm,nodead][pet:Primal Storm Elemental]Eye of the Storm;[talent:6/2]Fire Elemental\n/use [nocombat]Lava Fountain\n/targetenemy [noexists]")
						EditMacro("WSxGen6",nil,nil,"/use [mod]Fire Elemental;[@mouseover,harm,nodead][]Chain Lightning\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxT90",nil,nil,"#show [talent:6/1]Earth Shock;[talent:6/2]Fire Elemental;[talent:6/3]Icefury")
						EditMacro("WSxCC",nil,nil,"/use [mod,@mouseover,harm,nodead][mod]Hex;[@mouseover,help,nodead][]Thunderstorm\n/use Thistleleaf Branch")
						EditMacro("WSxGen4",nil,nil,"/use [talent:2/2]Echoing Shock;[talent:2/3]Elemental Blast;[talent:6/3]Frost Shock;Earth Shock\n/targetenemy [noexists]\n/cleartarget [dead]")
					elseif playerspec == 2 then
						EditMacro("WSxGen1",nil,nil,"#show\n/use [talent:2/3,harm,nodead]Ice Strike;[@mouseover,harm,nodead][harm,nodead]Frost Shock;Xan'tish's Flute\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxSGen+4",nil,nil,"#show\n/targetenemy [noexists]\n/use [mod,@party1,help,nodead]Chain Heal;[nocombat,noexists]Sen'jin Spirit Drum\n/use [talent:6/2]Stormkeeper;[talent:6/3]Sundering\n/cleartarget [dead]")
						EditMacro("WSxGen5",nil,nil,"#show\n/use [mod]Earth Elemental;[@mouseover,harm,nodead][harm,nodead]Lightning Bolt\n/targetenemy [noexists,nomod]\n/stopmacro [nomod]\n/target Greater Earth Ele\n/focus [exists,help,nodead]target\n/clearfocus [dead]\n/use Words of Akunda")
						EditMacro("WSxSGen+5",nil,nil,"#show\n/use Windfury Totem\n/use [mod,@party2,help,nodead]Chain Heal;[nocombat,noexists]Lava Fountain")
						EditMacro("WSxGen6",nil,nil,"/use [mod]Feral Spirit;Crash Lightning\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxT90",nil,nil,"#show [talent:6/1]Crash Lightning;[talent:6/2]Stormkeeper;[talent:6/3]Sundering")
						EditMacro("WSxCC",nil,nil,"/use [mod,@mouseover,harm,nodead][mod]Hex;Feral Spirit\n/use Thistleleaf Branch")
					EditMacro("WSxGen4",nil,nil,"/use [talent:1/3]Elemental Blast;[talent:4/3]Fire Nova;[talent:6/3]Sundering;[talent:6/2]Stormkeeper;[@mouseover,help,nodead][]Chain Heal\n/targetenemy [noexists]\n/cleartarget [dead]")
					else
						EditMacro("WSxGen1",nil,nil,"#show\n/use [noexists]Xan'tish's Flute\n/use [talent:1/3]Unleash Life;[@mouseover,harm,nodead][harm,nodead]Flame Shock;[@mouseover,help,nodead][]Riptide\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxSGen+4",nil,nil,"#show\n/use [@party1,help,nodead,mod:alt]Riptide;[nocombat,noexists]Sen'jin Spirit Drum;[talent:6/2,@cursor]Downpour;Healing Stream Totem")
						EditMacro("WSxGen5",nil,nil,"#show\n/use [mod,@cursor]Spirit Link Totem;[@mouseover,help,nodead][]Healing Wave\n/targetenemy [noexists]\n/use Words of Akunda")
						EditMacro("WSxSGen+5",nil,nil,"#show\n/use [@party2,help,nodead,mod]Riptide;[talent:4/2,@cursor]Earthen Wall Totem;[talent:4/3,@cursor]Ancestral Protection Totem\n/use Lava Fountain")
						EditMacro("WSxGen6",nil,nil,"/use [mod]Earth Elemental;[@cursor]Healing Rain\n/targetenemy [noexists,nomod]\n/cleartarget [dead]\n/stopmacro [nomod]\n/target Greater Earth Ele\n/focus [exists,help,nodead]target\n/clearfocus [dead]")
						EditMacro("WSxT90",nil,nil,"#show [talent:6/1]Mana Tide Totem;[talent:6/2]Downpour;[talent:6/2]Cloudburst Totem\n/use Spirit Link Totem")
						EditMacro("WSxCC",nil,nil,"/use [mod:shift]Mana Tide Totem;[mod,@mouseover,harm,nodead][mod]Hex;[@mouseover,help,nodead][]Riptide\n/use Thistleleaf Branch")
					EditMacro("WSxGen4",nil,nil,"/use [@mouseover,help,nodead][]Chain Heal\n/targetfriendplayer [noexists]\n/cleartarget [dead]")
					end	
				-- Mage, maggi, nooniverse
				elseif class == "MAGE" then
					EditMacro("WSkillbomb",nil,nil,"#show\n/use [spec:3]Icy Veins;[spec:1]Arcane Power;[spec:2]Combustion"..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13\n/use Hearthstone Board\n/use Big Red Raygun"..hasHE)
					EditMacro("WSxT15",nil,nil,"#show [spec:3,talent:1/3]Ice Nova;[spec:1,talent:1/3]Arcane Familiar;[spec:2]Scorch;Frost Nova\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#show\n/use [spec:3,talent:2/3]Ice Floes;[spec:2,talent:2/3]Blast Wave;[spec:1]Presence of Mind\n/use [spec:2]Blazing Wings"..oOtas)
					EditMacro("WSxT45",nil,nil,"#show [talent:3/3]Rune of Power;[talent:3/2]Focus Magic;Polymorph\n/use [mod:alt,spec:3,@player,pet]Freeze;Frost Nova")
					EditMacro("WSxT90",nil,nil,"#show [spec:3,talent:6/3]Comet Storm;[spec:2,talent:6/3]Living Bomb;[spec:1,talent:6/2]Arcane Orb;[spec:1,talent:6/3]Supernova;Ancient Mana Basin\n/use [mod,@player,talent:5/3][@cursor,talent:5/3]Ring of Frost\n/use [help,nocombat]Swapblaster")
					EditMacro("WSxT100",nil,nil,"#show [spec:3,talent:7/3]Glacial Spike;[spec:3,talent:7/2]Ray of Frost;[spec:2,talent:7/3]Meteor;Arcane Intellect")
					EditMacro("WSxCSGen+G",nil,nil,"#show [spec:3]Cold Snap;Invisibility\n/use [@focus,harm,nodead]Spellsteal\n/use Poison Extraction Totem")
					EditMacro("WSxT60",nil,nil,"#show [spec:3,talent:4/3]Ebonbolt;[spec:1,talent:4/3]Nether Tempest;Arcane Explosion\n/use Worn Doll\n/run PetDismiss();\n/cry")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]"..glider..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..brazier)
					EditMacro("WSxGen1",nil,nil,"/targetenemy [noharm,nodead]\n/use [nocombat,noexists]Dazzling Rod\n/use [spec:3,talent:7/2]Ray of Frost;[spec:3,talent:7/3]Glacial Spike;[@mouseover,spec:2,harm,nodead][spec:2]Phoenix Flames;[spec:1]Presence of Mind;Ice Lance")
					EditMacro("WSxGen2",nil,nil,"/use [spec:1,harm,nodead]Arcane Blast;[spec:3,harm,nodead]Frostbolt;[@mouseover,harm,nodead][harm,nodead]Scorch;Akazamzarak's Spare Hat\n/targetenemy [noharm]\n/cleartarget [dead]\n/use Kalec's Image Crystal\n/use Archmage Vargoth's Spare Staff")
					EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead]Remove Curse")
					EditMacro("WSxGen3",nil,nil,"/use [spec:3,@cursor]Frozen Orb;[@mouseover,harm,nodead,spec:2][spec:2]Pyroblast;[talent:6/2]Arcane Orb;[talent:6/3]Supernova\n/targetenemy [noexists]")
					EditMacro("WSxCSGen+3",nil,nil,"#show\n/use [spec:2,@focus,harm,nodead]Pyroblast;[@party2,help,nodead]Remove Curse;[exists,nodead]Magical Saucer\n/targetenemy [noharm]\n/cleartarget [dead][nocombat,noharm]\n/stopspelltarget")
					EditMacro("WSxGen4",nil,nil,"/use [@mouseover,harm,nodead,spec:2][spec:2,harm,nodead]Fireball;[help,dead,spec:2]Cremating Torch;[spec:3,harm,nodead]Flurry;[spec:1,harm,nodead]Arcane Missiles;Memory Cube\n/targetenemy [noexists]\n/cleartarget [dead]\n/stopspelltarget")
					EditMacro("WSxCGen+4",nil,nil,"#show\n/use [@mouseover,help,nodead,talent:3/2][talent:3/2]Focus Magic;[talent:3/3]Rune of Power\n/use [nocombat,noexists]Faded Wizard Hat")
					EditMacro("WSxCSGen+4",nil,nil,"/use [spec:2,@focus,harm,nodead]Fireball;[@focus,help,nodead][@party1,help,nodead]Slow Fall;Pink Gumball\n/targetenemy [noharm]\n/cleartarget [dead][nocombat,noharm]\n/stopspelltarget\n/use [nocombat,noexists]Ogre Pinata")
					EditMacro("WSxGen5",nil,nil,"/targetenemy [noexists]\n/use [mod]!Alter Time;[@mouseover,harm,nodead,spec:1][spec:1,harm,nodead]Arcane Barrage;[@mouseover,harm,nodead,spec:3][spec:3,harm,nodead]Ice Lance;[@mouseover,harm,nodead][harm,nodead]Fire Blast;[nocombat]Anti-Doom Broom;Worn Doll")
					EditMacro("WSxCSGen+5",nil,nil,"#show Ice Block\n/use [@party2,help,nodead]Slow Fall\n/use [nocombat,noexists]Shado-Pan Geyser Gun\n/cancelaura [combat]Shado-Pan Geyser Gun\n/stopmacro [combat]\n/click ExtraActionButton1")
					EditMacro("WSxGen6",nil,nil,"#show\n/use [spec:3,mod:ctrl]Icy Veins;[spec:1,mod:ctrl]Arcane Power;[spec:2,mod:ctrl]Combustion\n/use [mod:ctrl]Mirror Image;[spec:3,@cursor]Blizzard;[spec:1]Arcane Explosion;[spec:2,@cursor]Flamestrike\n/stopspelltarget [spec:2]")
					EditMacro("WSxSGen+6",nil,nil,"#show [spec:3]Cone of Cold;[spec:2]Dragon's Breath;Arcane Explosion\n/use [nocombat,noexists]Mystical Frosh Hat\n/use [spec:1,talent:1/3]Arcane Familiar;[spec:2,@player]Flamestrike;[spec:3,@player]Blizzard")
					EditMacro("WSxGen7",nil,nil,"/use [mod,spec:2,talent:7/3,@player]Meteor;[spec:3,talent:1/3]Ice Nova;[spec:2,talent:2/3]Blast Wave;[spec:2]Arcane Explosion;[spec:1]Touch of the Magi;Cone of Cold")
					EditMacro("WSxQQ",nil,nil,"#show\n/stopcasting [nomod]\n/use [mod:alt,@focus,harm,nodead]Polymorph;[mod:shift]Winning Hand;[@mouseover,harm,nodead][]Counterspell\n/use [mod:shift]Ice Block;")
					EditMacro("WSxStuns",nil,nil,"#show Frost Nova\n/use [nospec:1]Arcane Explosion;[@mouseover,harm,nodead][]Slow\n/use Manastorm's Duplicator")
					EditMacro("WSxRTS",nil,nil,"/use [spec:3,mod]Cone of Cold;[spec:2,mod]Dragon's Breath;[@mouseover,harm,nodead,spec:1,mod][spec:1,mod]Slow;[@mouseover,help,nodead]Slow Fall;[@mouseover,harm,nodead][]Frostbolt")
					EditMacro("WSxClassT",nil,nil,"/use [@mouseover,harm,nodead][]Fire Blast\n/targetenemy [noexists]\n/cleartarget [dead]\n/petattack [@mouseover,harm,nodead][]"..nPepe)
					EditMacro("WSxGenF",nil,nil,"#show\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/stopcasting [nomod]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Counterspell;Mrgrglhjorn\n/use Survey")
					EditMacro("WSxSGen+F",nil,nil,"#show Familiar Stone\n/cancelaura [mod:alt] Shado-Pan Geyser Gun\n/use [mod:alt,nocombat,noexists]Gastropod Shell;[nomod]Arcane Familiar Stone\n/use [nomod]Fiery Familiar Stone\n/use [nomod]Icy Familiar Stone\n/use [nomod]Familiar Stone")
					EditMacro("WSxCGen+F",nil,nil,"#show [combat]Invisibility;Ice Block\n/use Alter Time")
					EditMacro("WSxGG",nil,nil,"#show\n/targetenemy [noharm]\n/use [mod:alt]Darkmoon Gazer;[@mouseover,harm,nodead]Spellsteal;[@mouseover,help,nodead][]Remove Curse\n/use [noexists,nocombat]Set of Matches")
					EditMacro("WSxSGen+H",nil,nil,"#show\n/targetenemy [noharm]\n/use Nat's Fishing Chair\n/use Home Made Party Mask\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\"); else DoEmote(\"kneel\") end end")
					EditMacro("WSxDef",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;[nocombat]Invisibility;!Ice Block")
					EditMacro("WSxGND",nil,nil,"#show\n/use [mod:alt]Conjure Refreshment;[mod:ctrl]Teleport: Hall of the Guardian;[spec:1,mod]Displacement;[mod]Alter Time;[spec:1]Prismatic Barrier;[spec:2]Blazing Barrier;[spec:3]Ice Barrier\n/use [nomod,spec:1]Arcano-Shower;[nomod,spec:2]Blazing Wings")
					EditMacro("WSxCC",nil,nil,"#show [mod:shift,spec:1]Conjure Mana Gem;[spec:3]Cold Snap;[spec:1]Mana Gem;Polymorph\n/use [mod:shift,spec:1]Conjure Mana Gem;[mod:shift,spec:3]Cold Snap;[spec:1,nomod]Mana Gem;[@mouseover,harm,nodead][]Polymorph\n/cancelaura X-Ray Specs")
					EditMacro("WSxMove",nil,nil,"#show\n/use Blink\n/dismount [mounted]\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Illusion\n/use Prismatic Bauble\n/use Sparkle Wings")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@mouseover,help,nodead][noswimming]Slow Fall;Barnacle-Encrusted Gem\n/use [mod]Weathered Purple Parasol")
					EditMacro("WSxGen+B",nil,nil,"#show [spec:3,notalent:1/2]Summon Water Elemental;Invisibility\n/use [nocombat,noexists]Ancient Mana Basin")
					EditMacro("WSxGen+N",nil,nil,"#show [spec:3]Cold Snap;[spec:1]Conjure Mana Gem;Arcane Intellect\n/use Cold Snap")
					EditMacro("WSxCAGen+F",nil,nil,"#show Mirror Image\n/stopmacro [indoors]\n/use 16\n/run if not (InCombatLockdown() or IsEquippedItem(\"Dragonwrath, Tarecgosa's Rest\") and IsMounted) then EquipItemByName(71086) else Dismount() end\n/equipset [nomounted]"..EQS[playerspec])
					EditMacro("WSxSGen+5",nil,nil,"/targetenemy [noexists]\n/cleartarget [dead]\n/clearfocus [dead]\n/use [spec:3,notalent:1/2,nopet]Summon Water Elemental;[mod,pet,@player][pet,@cursor,nomod]Freeze;[spec:1]Slow;Frost Nova")
					if playerspec == 1 then
						EditMacro("WSxSGen+3",nil,nil,"#show\n/targetenemy [noexists]\n/use [nocombat,noexists]Archmage Vargoth's Spare Staff;[spec:1,talent:4/3]Nether Tempest;Arcane Blast")
						EditMacro("WSxSGen+4",nil,nil,"#show\n/targetenemy [noexists]\n/use Evocation")
					elseif playerspec == 2 then
						EditMacro("WSxSGen+3",nil,nil,"#show\n/targetenemy [noexists]\n/use [nocombat,noexists]Archmage Vargoth's Spare Staff;[spec:2,talent:6/3,nomod]Living Bomb;[nomod]Pyroblast\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Pyroblast\n/targetlasttarget")
						EditMacro("WSxSGen+4",nil,nil,"#show\n/targetenemy [noexists]\n/use [spec:2,talent:7/3,@cursor,nomod]Meteor;[nomod]Fireball\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Fireball\n/targetlasttarget")
					else
						EditMacro("WSxSGen+3",nil,nil,"#show [spec:3,talent:4/3]Ebonbolt;Archmage Vargoth's Spare Staff\n/targetenemy [noexists]\n/use [nocombat,noexists]Archmage Vargoth's Spare Staff\n/use [spec:3,talent:4/3]Ebonbolt")
						EditMacro("WSxSGen+4",nil,nil,"#show\n/targetenemy [noexists]\n/use [spec:3,talent:6/3]Comet Storm;[spec:3,talent:4/3]Ebonbolt;Frostbolt")
					end	
				-- Warlock, vårlök
				elseif class == "WARLOCK" then
					EditMacro("WSkillbomb",nil,nil,"#show\n/use [spec:2]Summon Demonic Tyrant;[spec:3,@cursor]Summon Infernal;[spec:1]Summon Darkglare\n/use Jewel of Hellfire\n/use [@player]13\n/use 13"..dpsRacials[race].."\n/use Shadescale\n/use Adopted Puppy Crate\n/use Big Red Raygun")
					EditMacro("WSxT15",nil,nil,"#show [spec:2,talent:1/3]Demonic Strength;[spec:2,talent:1/2]Bilescourge Bombers;[spec:3,talent:1/3]Soul Fire;Shadow Bolt\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#show [spec:1,talent:2/3]Siphon Life;[spec:2,talent:2/2]Power Siphon;[spec:2,talent:2/3]Doom;[spec:3,talent:2/3]Shadowburn;Fel Domination\n/use Fel Domination"..oOtas)
					EditMacro("WSxT45",nil,nil,"#show Spell Lock\n/use [mod,@focus,harm,nodead,pet:Felhunter/Observer][pet:Felhunter/Observer]Spell Lock;Fel Domination\n/use [nopet:Felhunter/Observer]Summon Felhunter")
					EditMacro("WSxT60",nil,nil,"#show [spec:1,talent:4/2]Phantom Singularity;[spec:1,talent:4/3]Vile Taint;[spec:2,talent:4/2]Soul Strike;[spec:2,talent:4/3]Summon Vilefiend;[spec:3,talent:4/3]Cataclysm;Demonic Gateway\n/use Spire of Spite\n/run PetDismiss();\n/cry")
					EditMacro("WSxT90",nil,nil,"#show Curse of Weakness\n/use [@mouseover,harm,nodead][harm,nodead]Curse of Weakness;[help,nocombat]Swapblaster"..nPepe.."\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxClassT",nil,nil,"/use [pet:Incubus/Succubus/Shivarra]Whiplash;[pet:Voidwalker/Voidlord]Suffering;[@mouseover,harm,nodead,pet:Felguard/Wrathguard][pet:Felguard/Wrathguard]!Pursuit\n/petattack [@mouseover,harm,nodead][]\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxT100",nil,nil,"#show [spec:2,talent:7/3]Nether Portal;[spec:3,talent:7/2]Channel Demonfire;[spec:3,talent:7/3]Dark Soul: Instability;[spec:1,talent:7/3]Dark Soul: Misery;Demonic Gateway")
					EditMacro("WSxCSGen+G",nil,nil,"#show [mod]Create Soulwell;[pet,nospec:2,talent:6/3]Grimoire of Sacrifice;[nopet][combat]Summon Felhunter;Create Soulwell\n/use [nopet]Summon Felhunter")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]"..glider..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..brazier)
					EditMacro("WSxGen1",nil,nil,"/use [@mouseover,harm,nodead,spec:3][spec:3]Havoc;[spec:2,talent:4/2]Soul Strike;[spec:2,talent:4/3]Summon Vilefiend;[spec:2]Drain Life;[@mouseover,harm,nodead][]Corruption\n/use Copy of Daglop's Contract\n/targetenemy [noexists]\n/use Imp in a Ball")
					EditMacro("WSxSGen+1",nil,nil,"#show Fel Domination\n/run for i=0,4 do for x=1,GetContainerNumSlots(i) do y=GetContainerItemLink(i,x) if y then if GetItemInfo(y)==\"Healthstone\" then PickupContainerItem(i,x); DropItemOnUnit(\"target\"); return; end end end end\n/click TradeFrameTradeButton")
					EditMacro("WSxGen2",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use [harm,dead,nocombat]Soul Inhaler;[spec:3]Incinerate;[@mouseover,harm,nodead,spec:1][spec:1]Agony;Shadow bolt\n/use Accursed Tome of the Sargerei\n/startattack\n/clearfocus [dead]\n/use Haunting Memento")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/use [nomod,harm,nodead]Drain Life;[nomod]Create Healthstone\n/use [nocombat,noexists]Gnomish X-Ray Specs\n/cleartarget [dead]\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Agony\n/targetlasttarget")
					EditMacro("WSxCSGen+2",nil,nil,"/use [spec:1,@focus,harm]Agony;[nocombat,noexists]Legion Invasion Simulator\n/targetenemy [noharm]\n/cleartarget [dead]")
					EditMacro("WSxGen3",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use [nocombat,noexists]Pocket Fel Spreader;[harm,dead]Narassin's Soul Gem;[@mouseover,harm,nodead,spec:1][spec:1]Shadow Bolt;[spec:2]Call Dreadstalkers;[talent:2/3]Shadowburn;Immolate\n/targetenemy [noexists]")
					EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noexists]The Perfect Blossom;[spec:1,@focus,harm,nodead]Corruption;[spec:3,@focus,harm,nodead]Immolate;[spec:2,@focus,harm,nodead]Doom;Fel Petal;\n/targetenemy [noharm]\n/cleartarget [dead]")
					EditMacro("WSxGen4",nil,nil,"/use [nocombat,noexists]Crystalline Eye of Undravius;[spec:2]Hand of Gul'dan;[spec:3]Chaos Bolt;[@mouseover,harm,nodead][]Unstable Affliction\n/targetenemy [noexists]\n/cleartarget [dead]\n/cancelaura Crystalline Eye of Undravius")
					EditMacro("WSxCGen+4",nil,nil,"/use [spec:1,talent:7/3]Dark Soul: Misery;[spec:2,talent:7/3]Nether Portal;[spec:3,talent:7/3]Dark Soul: Instability;[spec:3,talent:7/2]Channel Demonfire;[@cursor]Demonic Gateway\n/targetenemy [noexists]\n/cleartarget [dead]\n/use Gateway Control Shard")
					EditMacro("WSxCSGen+4",nil,nil,"/use [spec:1,@focus,harm,nodead]Unstable Affliction;[spec:3,@focus,harm,nodead]Havoc\n/targetenemy [noharm]\n/cleartarget [dead]\n/use [nocombat]Micro-Artillery Controller")
					EditMacro("WSxGen5",nil,nil,"/use [mod,spec:3,@player]Summon Infernal;[spec:1]Shadow Bolt;[@mouseover,spec:2,harm,nodead][spec:2]Demonbolt;[spec:3]Conflagrate\n/use Fire-Eater's Vial\n/targetenemy [noexists]")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,harm,nodead]Siphon Life\n/cleartarget [dead]\n/use Battle Standard of Coordination\n/stopmacro [combat]\n/use [noexists]Spire of Spite\n/target [@pet,nodead,pet:Incubus/Succubus/Shivarra]\n/kiss\n/targetlasttarget")
					EditMacro("WSxSGen+6",nil,nil,"/use [spec:3,talent:4/3,@player]Cataclysm;[spec:2,nopet]Summon Felguard;[pet:felguard/wrathguard]!Felstorm;[talent:4/2]Phantom Singularity;[talent:4/3,@player]Vile Taint;Command Demon\n/stopmacro [@pet,nodead]\n/run PetDismiss()")
					EditMacro("WSxGen7",nil,nil,"/use [mod:shift,nopet]Summon Imp;[mod:shift,pet:Imp]Flee;"..locPvPExcSeven..";[spec:3,talent:4/3,@cursor]Cataclysm;[spec:1]Malefic Rapture\n/targetenemy [noexists]\n/use Legion Pocket Portal")
					EditMacro("WSxQQ",nil,nil,"#show\n/stopcasting [nomod,nopet]\n/use [@focus,mod:alt,harm,nodead]Fear;[mod:shift]Demonic Circle;"..locPvPExcQQ.."\n/use [nocombat,noexists]Vixx's Chest of Tricks\n/cancelaura Wyrmtongue Collector Disguise")
					EditMacro("WSxStuns",nil,nil,"/use [mod:alt,@player][@cursor]Shadowfury")
					EditMacro("WSxRTS",nil,nil,"/use [mod:ctrl,nopet]Summon Sayaad;[@mouseover,harm,nodead,talent:5/2,mod][talent:5/2,mod]Mortal Coil;[talent:5/3,mod]Howl of Terror;[@mouseover,harm,nodead][]Curse of Exhaustion\n/targetenemy [noharm]")
					EditMacro("WSxGenF",nil,nil,"#show Demonic Circle\n/focus [@mouseover,exists]mouseover\n/stopmacro [@mouseover,exists]\n/stopcasting [nomod,nopet]\n/use [mod,exists,nodead]All-Seer's Eye;[mod]Eye of Kilrogg;"..locPvPExcGenF)
					EditMacro("WSxSGen+F",nil,nil,"/use [mod:alt,nocombat,noexists]Gastropod Shell;[pet:Felguard/Wrathguard,nomod]Threatening Presence;[pet:Imp]Flee\n/petautocasttoggle [mod:alt]Legion Strike;[pet:Voidwalker]Suffering;Threatening Presence\n/cancelaura Heartsbane Curse")
					EditMacro("WSxCGen+F",nil,nil,"/use [nocombat,noexists,pet:Incubus/Succubus/Shivarra]Lesser Invisibility;[group]Ritual of Doom;Bewitching Tea Set\n/use "..fftpar.."\n/cancelaura Wyrmtongue Disguise\n/cancelaura Burning Rush")
					EditMacro("WSxCAGen+F",nil,nil,"#show Gateway Control Shard\n/run if not InCombatLockdown() then if GetSpellCooldown(111771)==0 then "..tpPants.." else "..noPants.." end end\n/stopcasting\n/use [@cursor]Demonic Gateway\n/use Gateway Control Shard")
					EditMacro("WSxGG",nil,nil,"/use [mod:alt]S.F.E. Interceptor;[@mouseover,harm,nodead,pet:Felhunter/Observer][pet:Felhunter/Observer]Devour Magic;[@mousever,exists,nodead][]Command Demon")
					EditMacro("WSxSGen+H",nil,nil,"#show Demonic Circle: Teleport\n/use [nocombat]Legion Communication Orb\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\"); else DoEmote(\"kneel\") end end")
					EditMacro("WSxDef",nil,nil,"/use [mod:alt,@cursor]Demonic Gateway;Unending Resolve\n/use [mod:alt]Gateway Control Shard")
					EditMacro("WSxGND",nil,nil,"/use [mod:shift]Demonic Circle: Teleport;[mod:alt,group]Create Soulwell;[mod:alt]Create Healthstone;[mod,harm,nodead]Subjugate Demon;[mod,group]Ritual of Summoning;[mod]Unstable Portal Emitter;[talent:3/2]!Burning Rush;[talent:3/3]Dark Pact")
					EditMacro("WSxCC",nil,nil,"/use [mod,@mouseover,harm,nodead][mod]Fear;[nopet]Summon Voidwalker;Ring of Broken Promises\n/use Poison Extraction Totem\n/use Health Funnel\n/cancelaura Ring of Broken Promises\n/use Totem of Spirits\n/cancelaura X-Ray Specs")
					EditMacro("WSxMove",nil,nil,"#show [mod]Banish;Curse of Tongues\n/use [@mouseover,harm,nodead][]Curse of Tongues\n/use [nomod]Panflute of Pandaria\n/use Haw'li's Hot & Spicy Chili\n/cancelaura Rhan'ka's Escape Plan\n/use Void Totem\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@focus,harm,nodead,mod][@mouseover,harm,nodead,nomod][harm,nodead,nomod]Banish;[@mouseover,help,nodead,nomod][nomod]Unending Breath\n/use [mod]Stylish Black Parasol")
					EditMacro("WSxGen+B",nil,nil,"#show [nocombat,noexists]Ritual of Doom;[pet:Voidwalker/Voidlord]Consuming Shadows;\n/use [pet:Voidwalker/Voidlord]Consuming Shadows\n/use [nocombat,noexists]Tickle Totem")
					EditMacro("WSxCAGen+B",nil,nil,"")
					EditMacro("WSxGen+N",nil,nil,"#show\n/use [@mouseover,help][]Soulstone")
					EditMacro("WSxCAGen+N",nil,nil,"")
					if playerspec == 1 then
						EditMacro("WSxSGen+3",nil,nil,"#show\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead,nomod][nomod]Corruption\n/use Verdant Throwing Sphere\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Corruption\n/targetlasttarget")
						EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noexists]\n/use [nomod,talent:6/2]Haunt;[nomod,talent:6/3]Grimoire of Sacrifice;[nomod]Unstable Affliction\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Unstable Affliction\n/targetlasttarget")
						EditMacro("WSxSGen+5",nil,nil,"#show\n/targetenemy [noexists]\n/use [spec:1,talent:2/3,nomod]Siphon Life;[nomod]Corruption\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [spec:1,talent:2/3]Siphon Life;Corruption\n/targetlasttarget")
						EditMacro("WSxGen6",nil,nil,"/use [mod]Summon Darkglare;[@mouseover,harm,nodead][]Seed of Corruption\n/startattack")
					elseif playerspec == 2 then
						EditMacro("WSxSGen+3",nil,nil,"/targetenemy [noexists]\n/use [talent:2/2]Power Siphon;[@mouseover,harm,nodead,nomod,talent:2/3][nomod,talent:2/3]Doom;"..locPvPExcSThree.."\n/use Verdant Throwing Sphere\n/use Totem of Spirits\n/stopmacro [nomod]\n/targetlasttarget\n/use Doom\n/targetlasttarget")
						EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noexists]\n/use [@mouseover,harm,nodead,nomod][nomod]Corruption\n/use [nocombat,noexists]Verdant Throwing Sphere\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Corruption\n/targetlasttarget")
						EditMacro("WSxSGen+5",nil,nil,"#show\n/targetenemy [noexists]\n/use [@player,talent:1/2]Bilescourge Bombers;[talent:6/3]Grimoire: Felguard;[talent:1/3,pet:Felguard/Wrathguard]Demonic Strength;[nopet:Felguard/Wrathguard]Summon Felguard")
						EditMacro("WSxGen6",nil,nil,"/use [mod]Summon Demonic Tyrant;[talent:1/3]Demonic Strength;[talent:1/2,@cursor]Bilescourge Bombers;Implosion\n/startattack")
					else
						EditMacro("WSxSGen+3",nil,nil,"#show\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead,nomod][nomod]Immolate\n/use Verdant Throwing Sphere\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Immolate\n/targetlasttarget")
						EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noexists]\n/targetlasttarget\n/use Havoc\n/targetlasttarget")
						EditMacro("WSxSGen+5",nil,nil,"#show\n/use [talent:6/3,mod:alt]Grimoire of Sacrifice;[@player]Rain of Fire\n/targetenemy [noexists]")
						EditMacro("WSxGen6",nil,nil,"/use [mod,@cursor]Summon Infernal;[@cursor]Rain of Fire\n/startattack")
					end					
				-- Monk, menk, Happyvale
				elseif class == "MONK" then
					EditMacro("WSkillbomb",nil,nil,"#show [spec:3]Storm, Earth, and Fire;[spec:2]Revival;[spec:1]Fortifying Brew\n/use Storm, Earth, and Fire\n/use Invoke Xuen, the White Tiger"..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13\n/use Celestial Defender's Medallion")
					EditMacro("WSxT15",nil,nil,"#show [spec:2,talent:1/2]Zen Pulse;[talent:1/2]Chi Wave;[talent:1/3]Chi Burst\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#show [talent:2/3]Tiger's Lust;Roll"..oOtas)
					EditMacro("WSxT45",nil,nil,"#show [spec:1,talent:3/3]Black Ox Brew;[spec:2,talent:3/3]Mana Tea;[spec:3,talent:3/2]Fist of the White Tiger;[spec:3,talent:3/3]Energizing Elixir;Paralysis\n/use [mod:alt,@player]Ring of Peace")
					EditMacro("WSxT90",nil,nil,"#show [nospec:2,talent:6/2]Rushing Jade Wind;[talent:6/2]Refreshing Jade Wind;[spec:2,talent:6/1]Summon Jade Serpent Statue;[spec:3]Invoke Xuen, the White Tiger;[spec:2]Invoke Chi-Ji, the Red Crane;Invoke Niuzao, the Black Ox\n/use Provoke\n/startattack")
					EditMacro("WSxT100",nil,nil,"#show [spec:3,talent:7/2]Whirling Dragon Punch;[spec:3,talent:7/3]Serenity;")
					EditMacro("WSxCSGen+G",nil,nil,"#show Transcendence\n/use [@focus,help,nodead]Detox")
					EditMacro("WSxT60",nil,nil,"#show [spec:1,talent:4/2]Summon Black Ox Statue;[spec:2,talent:4/2]Song of Chi-Ji;[talent:4/3]Ring of Peace;\n/click TotemFrameTotem1 RightButton\n/run PetDismiss()\n/use [noexists,nocombat]Turnip Punching Bag")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]"..glider..";[mod]6;[nocombat]Resuscitate;"..pwned.."\n/use [mod:ctrl]Reawaken"..brazier)
					EditMacro("WSxSGen+H",nil,nil,"#show\n/use [nomounted]Darkmoon Gazer\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\"); else DoEmote(\"kneel\") end end")
					-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"\\#show Provoke\\n/use [mod:shift,@\"..B..\"]Vivify;[@\"..B..\"]Renewing Mist\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")	
					-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"\\#show Provoke\\n/use [mod:shift,@\"..N..\"]Vivify;[@\"..N..\"]Renewing Mist\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
					EditMacro("WSxGen+B",nil,nil,"#show Leg Sweep")
					EditMacro("WSxGen+N",nil,nil,"#show Provoke")	
					EditMacro("WSxGen1",nil,nil,"#show\n/use [nocombat,noexists]Mrgrglhjorn\n/use [@mouseover,exists,nodead][]Expel Harm\n/targetenemy [noexists]")
					EditMacro("WSxGen2",nil,nil,"#show\n/use [spec:2,channeling,@mouseover,help,nodead][spec:2,channeling:Soothing Mist]Vivify;[nocombat,noexists]Brewfest Keg Pony;Tiger Palm\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead]Detox")
					EditMacro("WSxGen3",nil,nil,"/use [@mouseover,harm,nodead][]Touch of Death\n/use [nocombat,noexists]Mystery Keg\n/use [nocombat,noexists]Jin Warmkeg's Brew\n/targetenemy [noexists]\n/cleartarget [dead]")  
					EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,help,nodead][@party2,help,nodead]Detox\n/run if not InCombatLockdown() then local j,p,_=C_PetJournal _,p=j.FindPetIDByName(\"Alterac Brew-Pup\") if p and j.GetSummonedPetGUID()~=p then j.SummonPetByGUID(p) end end")
					EditMacro("WSxGen4",nil,nil,"#show\n/use [nocombat,noexists]Brewfest Pony Keg;[spec:1]Keg Smash;Rising Sun Kick\n/use Piccolo of the Flaming Fire\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
					EditMacro("WSxSGen+4",nil,nil,"#show\n/use [@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Renewing Mist;[talent:1/2]Chi Wave;[talent:1/3]Chi Burst\n/stopspelltarget\n/targetenemy [noexists]")
					EditMacro("WSxCGen+4",nil,nil,"/use [mod,@party3,help,nodead]Renewing Mist;[spec:3]Invoke Xuen, the White Tiger;[spec:2]Invoke Yu'lon, the Jade Serpent;Invoke Niuzao, the Black Ox\n/targetenemy [nocombat,noexists]")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@focus,help,nodead,nochanneling:Soothing Mist][@party1,help,nodead,nochanneling:Soothing Mist]Soothing Mist;[@focus,help,nodead][@party1,help,nodead]Enveloping Mist\n/use [nocombat,noexists]Totem of Harmony")
					EditMacro("WSxGen5",nil,nil,"/use [mod:ctrl,spec:1]Zen Meditation;[mod:ctrl,spec:2]Thunder Focus Tea;Blackout Kick\n/use [noexists,nocombat]Brewfest Banner\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+5",nil,nil,"/use [@party2,help,nodead,mod:alt,spec:2]Renewing Mist;[spec:3,talent:3/2]Fist of the White Tiger;[spec:3,talent:3/3]Energizing Elixir;[spec:1]Leg Sweep;[spec:2]Thunder Focus Tea\n/use Displacer Meditation Stone\n/targetenemy [noexists]")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,help,nodead,nochanneling:Soothing Mist][@party2,nodead,nochanneling:Soothing Mist]Soothing Mist;[@focus,help,nodead][@party2,nodead]Enveloping Mist\n/use [nocombat,noexists]Pandaren Brewpack\n/cancelaura Pandaren Brewpack")
					EditMacro("WSxGen6",nil,nil,"#show\n/use [spec:3,mod]Storm, Earth, and Fire;[spec:2,mod]Revival;[mod]Invoke Niuzao, the Black Ox;[spec:1]Breath of Fire;!Spinning Crane Kick\n/use Words of Akunda")
					EditMacro("WSxSGen+6",nil,nil,"/use [noexists,nocombat,nospec:2]\"Purple Phantom\" Contender's Costume;[@mouseover,spec:3,harm,nodead][spec:3]Fists of Fury;[spec:2]Essence Font;[spec:1,talent:3/3]Black Ox Brew\n/targetenemy [noexists]\n/stopmacro [combat]\n/click ExtraActionButton1",1,1)
					EditMacro("WSxGen7",nil,nil,"/use [spec:3,talent:7/2]Whirling Dragon Punch;[spec:3]Storm, Earth, and Fire;[spec:2,talent:6/2]Refreshing Jade Wind;[spec:2,talent:6/1,@cursor]Summon Jade Serpent Statue;!Spinning Crane Kick")
					EditMacro("WSxQQ",nil,nil,"#show\n/use [mod:alt,@focus,harm,nodead][nomod,spec:2,exists,nodead]Paralysis;[mod:shift]Transcendence;[nocombat,noexists]The Golden Banana;[@mouseover,harm,nodead][]Spear Hand Strike;")
					EditMacro("WSxStuns",nil,nil,"#show [spec:1]Clash;[spec:2]Soothing Mist;Flying Serpent Kick\n/use Prismatic Bauble\n/use [mod:alt]Leg Sweep;[spec:3]Flying Serpent Kick;[@mouseover,harm,nodead,spec:1][spec:1]Clash;[@mouseover,help,nodead][]Soothing Mist\n/targetenemy [noexists]")
					EditMacro("WSxClassT",nil,nil,"#show Provoke\n/use [@mouseover,harm,nodead][]Crackling Jade Lightning"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxGenF",nil,nil,"#show Transcendence: Transfer\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[spec:2,@focus,harm,nodead]Paralysis;[@focus,harm,nodead]Spear Hand Strike\n/targetenemy [noexists]")
					EditMacro("WSxSGen+F",nil,nil,"/target Black Ox\n/use [spec:1,talent:4/2,help,nodead]Provoke;[spec:1,talent:4/2,@cursor]Summon Black Ox Statue;[nocombat]Gastropod Shell;\n/use [nocombat]Mulled Alterac Brandy\n/targetlasttarget [spec:1,talent:4/2]\n/cancelaura [mod]Purple Phantom")
					EditMacro("WSxCGen+F",nil,nil,"#show [spec:1,talent:4/2]Summon Black Ox Statue;[spec:2,talent:4/2]Song of Chi-Ji;[talent:4/3]Ring of Peace;[spec:3]Touch of Karma;[spec:2]Fortifying Brew\n/use [spec:3]Touch of Karma;[spec:2]Revival;[spec:1]Zen Meditation")
					EditMacro("WSxCAGen+F",nil,nil,"#show [combat][exists]Leg Sweep;Silversage Incense\n/targetfriendplayer\n/use [help,nodead]Tiger's Lust;Silversage Incense\n/targetlasttarget")
					EditMacro("WSxGG",nil,nil,"#show\n/use [mod:alt]Nimble Brew;[@mouseover,help,nodead,nomod][nomod]Detox;\n/use [mod:alt]Darkmoon Gazer")
					EditMacro("WSxDef",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;[mod:shift]Fortifying Brew;[spec:1,talent:5/2][spec:2,talent:5/1]Healing Elixir;[talent:5/2]Diffuse Magic;[talent:5/3]Dampen Harm;Fortifying Brew\n/use Lao Chin's Last Mug")
					EditMacro("WSxGND",nil,nil,"#show\n/use [mod:alt]Tumblerun Brew;[mod:ctrl]Zen Pilgrimage;[mod:shift]Transcendence: Transfer;[spec:1]Celestial Brew;[spec:3]Touch of Karma;[@mouseover,help,nodead,spec:2][spec:2,nodead]Life Cocoon;")
					EditMacro("WSxCC",nil,nil,"#show\n/use [mod:shift,spec:2,talent:3/3]Mana Tea;[mod,@mouseover,harm,nodead][mod]Paralysis;[spec:1]Purifying Brew;[spec:2,@mouseover,help,nodead][spec:2]Renewing Mist;[@mouseover,harm,nodead][]Paralysis\n/cancelaura X-Ray Specs")
					EditMacro("WSxMove",nil,nil,"#show\n/use Roll\n/use Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Ruthers' Harness\n/use Prismatic Bauble")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem;!Zen Flight\n/use [mod]Weathered Purple Parasol\n/use Mystical Orb of Meditation")
					EditMacro("Wx5Trinket2",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod,@party4,help,nodead]Renewing Mist;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14\n/use Eternal Black Diamond Ring")					
					if playerspec == 1 then
						EditMacro("WSxSGen+1",nil,nil,"#show\n/use [mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Vivify;Honorary Brewmaster Keg")
						EditMacro("WSxSGen+2",nil,nil,"/use [@party3,help,nodead,mod:alt][@mouseover,help,nodead][]Vivify\n/use [nochanneling]Gnomish X-Ray Specs")
						EditMacro("WSxSGen+3",nil,nil,"#show\n/use [mod,@party4,nodead,notalent:6/3]Vivify;[mod,@player,talent:6/3][@cursor,talent:6/3]Exploding Keg;[talent:6/2]Rushing Jade Wind;Tiger Palm")
						EditMacro("WSxRTS",nil,nil,"/use [mod:shift,talent:4/3,@cursor]Ring of Peace;[mod:shift,talent:4/2]Summon Black Ox Statue;[mod,@player,talent:2/3][@mouseover,help,talent:2/3][help,talent:2/3]Tiger's Lust;[@mouseover,harm,nodead][]Crackling Jade Lightning")
					elseif playerspec == 2 then
						EditMacro("WSxSGen+1",nil,nil,"/use [mod,@party2,nodead,nochanneling:Soothing Mist][@focus,help,nodead,nochanneling:Soothing Mist][@party1,nodead,nochanneling:Soothing Mist]Soothing Mist;[mod,@party2,nodead][@focus,help,nodead][@party1,nodead]Vivify;Honorary Brewmaster Keg")
						EditMacro("WSxSGen+2",nil,nil,"/use [mod,@party3,nodead,nochanneling:Soothing Mist][nochanneling:Soothing Mist,@mouseover,help,nodead][nochanneling:Soothing Mist]Soothing Mist;[@party3,nodead,mod][@mouseover,help,nodead][]Vivify\n/use [nochanneling]Gnomish X-Ray Specs")
						EditMacro("WSxSGen+3",nil,nil,"/use [mod,@party4,nodead,nochanneling:Soothing Mist][nochanneling:Soothing Mist,@mouseover,help,nodead][nochanneling:Soothing Mist]Soothing Mist;[@party4,nodead,mod]Vivify;[@mouseover,help,nodead,nomod][nomod]Enveloping Mist")
						EditMacro("WSxRTS",nil,nil,"/use [mod:shift,spec:2,talent:4/2]Song of Chi-Ji;[mod:shift,talent:4/3,@cursor]Ring of Peace;[mod,@player,talent:2/3][@mouseover,help,talent:2/3][help,talent:2/3]Tiger's Lust;[@mouseover,harm,nodead][]Crackling Jade Lightning")
					else	
						EditMacro("WSxSGen+1",nil,nil,"#show\n/use [mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Vivify;Honorary Brewmaster Keg")
						EditMacro("WSxSGen+2",nil,nil,"/use [@party3,help,nodead,mod:alt][@mouseover,help,nodead][]Vivify\n/use [nochanneling]Gnomish X-Ray Specs")
						EditMacro("WSxSGen+3",nil,nil,"/use [mod,@party4,nodead]Vivify;[talent:6/2]Rushing Jade Wind;Tiger Palm")
						EditMacro("WSxRTS",nil,nil,"/use [mod:shift,talent:4/3,@cursor]Ring of Peace;[mod,@player,talent:2/3][@mouseover,help,talent:2/3][help,talent:2/3]Tiger's Lust;Disable")
					end
				-- Paladin, bvk, palajong
				elseif class == "PALADIN" then
					EditMacro("WSkillbomb",nil,nil,"#show\n/use Avenging Wrath\n/use [@player]13\n/use 13\n/use Sha'tari Defender's Medallion"..dpsRacials[race].."\n/use Gnawed Thumb Ring\n/use Echoes of Rezan")
					EditMacro("WSxT15",nil,nil,"#show [spec:1,talent:1/2]Bestow Faith;[spec:1,talent:1/3]Light's Hammer;[spec:3,talent:1/3]Execution Sentence;Judgment\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#show [spec:1,talent:2/3]Holy Prism;[spec:2,talent:2/3]Moment of Glory;Lay on Hands\n/use Lay on Hands\n/use [help,nodead]Apexis Focusing Shard\n/stopspelltarget"..oOtas)
					EditMacro("WSxT90",nil,nil,"#show [spec:2,talent:6/3]Aegis of Light;[spec:1,talent:6/1]Fervent Martyr;[spec:1,talent:6/2]Sanctified Wrath;[spec:3,talent:6/2]Justicar's Vengeance;[spec:3,talent:6/3]Word of Glory;Avenging Wrath\n/use Hand of Reckoning")
					EditMacro("WSxT100",nil,nil,"#show [spec:3,talent:7/3]Final Reckoning;[spec:1,talent:7/2]Beacon of Faith;[spec:1,talent:7/3]Beacon of Virtue;Avenging Wrath")
					EditMacro("WSxCSGen+G",nil,nil,"#show Divine Shield\n/use [@focus,help,nodead]Cleanse")
					EditMacro("WSxT60",nil,nil,"#show [mod] Sylvanas' Music Box;[spec:1,talent:4/3]Rule of Law;[spec:3,talent:5/3]Eye for an Eye;Lay on Hands\n/use [mod,spec:1,talent:1/3,@player]Light's Hammer;!Concentration Aura\n/use Sylvanas' Music Box")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]"..glider..";[mod]6;[nocombat]Redemption;"..pwned.."\n/use [mod:ctrl]Absolution"..brazier)
					EditMacro("WSxCAGen+F",nil,nil,"#show [spec:1,combat][spec:1,exists]Aura Mastery;[combat]Turn Evil;Contemplation\n/use Contemplation")
					EditMacro("WSxT45",nil,nil,"#show\n/use [mod,spec:1,talent:1/3,@player]Light's Hammer;[talent:3/3]Blinding Light;[talent:3/2]Repentance;Hammer of Justice")
					EditMacro("WSxGen1",nil,nil,"/use [@mouseover,exists,nodead,spec:1][exists,nodead,spec:1]Holy Shock;[nocombat,noexists]!Devotion Aura;[spec:3]Blade of Justice;[@mouseover,harm,nodead][]Judgment\n/use Pretty Draenor Pearl\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+1",nil,nil,"#show Blessing of Protection\n/use [mod:alt,@party3,help,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Flash of Light\n/use Vindicator's Armor Polish Kit")
					EditMacro("WSxGen2",nil,nil,"#show\n/use Crusader Strike\n/startattack\n/targetenemy [noexists]\n/cleartarget [dead]\n/cancelaura X-Ray Specs")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/use [@party4,help,nodead,mod:alt][@mouseover,help,nodead][]Flash of Light\n/use Gnomish X-Ray Specs")
					EditMacro("WSxCSGen+2",nil,nil,"/use [spec:1,@focus,help,nodead][spec:1,@party1,help,nodead]Cleanse;[@focus,help,nodead][@party1,help,nodead]Cleanse Toxins")
					EditMacro("WSxGen3",nil,nil,"/use [spec:1,@mouseover,help,nodead][spec:1,help,nodead]Light of the Martyr;[@mouseover,harm,nodead][harm,nodead]Hammer of Wrath;Contemplation\n/targetenemy [noexists]\n/stopspelltarget")
					EditMacro("WSxSGen+3",nil,nil,"/use [spec:1,talent:4/3]Rule of Law;[spec:3,talent:1/3]Execution Sentence;Consecration\n/targetenemy [noexists]\n/use Soul Evacuation Crystal")
					EditMacro("WSxCSGen+3",nil,nil,"/use [spec:1,@focus,help,nodead][spec:1,@party2,help,nodead]Cleanse;[@focus,help,nodead][@party2,help,nodead]Cleanse Toxins\n/use [nocombat,noharm]Forgotten Feather")
					EditMacro("WSxGen4",nil,nil,"/use [spec:2,help,nodead,nocombat]Dalaran Disc;[help,nodead,nocombat]Holy Lightsphere;[spec:2,@mouseover,harm,nodead][spec:2]Avenger's Shield;[@mouseover,harm,nodead][]Judgment\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
					EditMacro("WSxCGen+4",nil,nil,"/use [@party3,help,nodead,mod:alt]Holy Shock;[spec:1,@mouseover,help,nodead,talent:7/2][spec:1,talent:7/2]Beacon of Faith;[spec:3,talent:7/3,@cursor]Final Reckoning;!Devotion Aura\n/startattack [combat]")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Word of Glory")
					EditMacro("WSxGen5",nil,nil,"/use [spec:2,mod:ctrl]Ardent Defender;[spec:1,mod:ctrl]Aura Mastery;[spec:3]Templar's Verdict;[spec:2,nocombat,noexists]Barrier Generator;[spec:2]Shield of the Righteous;[@mouseover,help,nodead][]Holy Light;\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+5",nil,nil,"#show\n/use [spec:3,talent:6/2]Justicar's Vengeance;[@party2,help,nodead,mod:alt][spec:1,@player]Holy Shock;[spec:1]Holy Light;Judgment\n/use [nocombat,noexists]Light in the Darkness")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,help,nodead][@party2,help,nodead]Word of Glory")
					EditMacro("WSxGen6",nil,nil,"#show\n/use [mod:ctrl]Avenging Wrath;[spec:3]Divine Storm;[spec:1]Light of Dawn;[spec:2]Consecration\n/use [mod:ctrl] 19\n/targetenemy [noexists]")
					EditMacro("WSxSGen+6",nil,nil,"#show [talent:5/2]Holy Avenger;[talent:5/3]Seraphim;Consecration\n/use [spec:1,talent:2/3,@player]Holy Prism;[talent:5/2]Holy Avenger;[talent:5/3]Seraphim;Consecration")
					EditMacro("WSxGen7",nil,nil,"#show\n/use [spec:3,talent:7/3,mod,@player]Final Reckoning;[mod,talent:5/2]Holy Avenger;[mod,talent:5/3]Seraphim;[spec:2]Judgment;Consecration\n/targetenemy [noexists]")
					EditMacro("WSxQQ",nil,nil,"/use [mod:shift]Divine Shield;[mod:alt,@focus,harm,nodead][spec:1,talent:3/1]Hammer of Justice;[spec:1,talent:3/2]Repentance;[spec:1,talent:3/3]Blinding Light;[@mouseover,harm,nodead][]Rebuke")
					EditMacro("WSxStuns",nil,nil,"#show\n/use [mod:alt,talent:3/2,@focus,harm,nodead]Repentance;[mod:alt]Blinding Light;[@mouseover,help,nodead][]Word of Glory")
					EditMacro("WSxRTS",nil,nil,"#show [spec:3]Hand of Hindrance;Blessing of Freedom\n/use [mod:ctrl]Divine Steed;[@mouseover,help,nodead][help,nodead]Blessing of Freedom;[spec:3,@mouseover,harm,nodead][spec:3,harm,nodead]Hand of Hindrance\n/use [mod:ctrl]Prismatic Bauble")
					EditMacro("WSxClassT",nil,nil,"#show Hand of Reckoning\n/use Titanium Seal of Dalaran\n/use Shield of the Righteous"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat]Wayfarer's Bonfire")
					EditMacro("WSxGenF",nil,nil,"#show Blessing of Freedom\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@focus,exists]Repentance;[mod:alt]Farwater Conch;[@focus,harm,nodead]Rebuke;[exists,nodead]Apexis Focusing Shard")
					EditMacro("WSxSGen+F",nil,nil,"#show Divine Steed\n/use [spec:2,@focus,harm,nodead]Avenger's Shield;[nocombat,noexists]Gastropod Shell")
					EditMacro("WSxCGen+F",nil,nil,"#show [nocombat,noexists]Sense Undead;Blessing of Sacrifice\n/run SetTracking(3,false)\n/use Sense Undead")
					EditMacro("WSxGG",nil,nil,"#show\n/use [mod:alt]Darkmoon Gazer;[spec:1,@mouseover,help,nodead][spec:1]Cleanse;[@mouseover,help,nodead][]Cleanse Toxins;\n/cancelaura [mod:alt]Divine Shield\n/cancelaura [mod:alt]Blessing of Protection")
					EditMacro("WSxSGen+H",nil,nil,"#show\n/use [nomounted]Darkmoon Gazer\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\"); else DoEmote(\"kneel\") end end")
					EditMacro("WSxDef",nil,nil,"/use [mod:alt]!Devotion Aura;[@mouseover,help,nodead,mod][mod]Blessing of Protection;[@mouseover,help,nodead][help,nodead]Blessing of Sacrifice;[spec:1]Divine Protection;[spec:2]Guardian of Ancient Kings;Divine Shield\n/use [mod:alt]Gateway Control Shard")
					EditMacro("WSxGND",nil,nil,"#show\n/use [mod:alt]!Retribution Aura;[mod:shift]Blessing of Freedom;[@mouseover,help,nodead][spec:1]Lay on Hands;[spec:2]Ardent Defender;Shield of Vengeance")
					EditMacro("WSxCC",nil,nil,"/use [mod,talent:3/2]Repentance;[spec:3,talent:4/3]Eye for an Eye;[spec:1,@mouseover,help,nodead,talent:1/2][spec:1,talent:1/2]Bestow Faith;[spec:1,talent:1/3,@cursor]Light's Hammer;[@mouseover,help,nodead][]Word of Glory")
					EditMacro("WSxMove",nil,nil,"#show Divine Steed\n/use [nospec:1]Divine Steed;[@mouseover,help,nodead][]Beacon of Light\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use [nospec:1]Prismatic Bauble")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@mouseover,harm,nodead][harm,nodead]Turn Evil;[swimming]Barnacle-Encrusted Gem\n/use [nostealth,nomod]Seafarer's Slidewhistle\n/use [mod]Weathered Purple Parasol")
					EditMacro("WSxGen+B",nil,nil,"#show\n/use [mod,@party1,nodead,spec:1,talent:1/2]Bestow Faith;[@party3,help,nodead]Word of Glory;Shield of the Righteous")
					EditMacro("WSxGen+N",nil,nil,"#show\n/use [mod,@party2,nodead,spec:1,talent:1/2]Bestow Faith;[@party4,help,nodead]Word of Glory;Turn Evil")
					EditMacro("Wx5Trinket2",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod,@party4,help,nodead]Holy Shock;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14\n/use Eternal Black Diamond Ring")
					if UnitName("player") == "Blackvampkid" then
						EditMacro("WSxCAGen+F",nil,nil,"#show [spec:1,combat][spec:1,exists]Aura Mastery;[combat]Turn Evil;Necromedes, the Death Resonator\n/stopmacro [combat,exists]\n/use 16\n/equipset "..EQS[playerspec].."\n/run local _,d,_=GetItemCooldown(151255) if d==0 then EquipItemByName(151255) end")
					end
					if playerspec == 1 then
						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"\\#show Lay on Hands\\n/use [mod:shift,@\"..B..\"]Flash of Light;[@\"..B..\"]Holy Shock\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"\\#show Lay on Hands\\n/use [mod:shift,@\"..N..\"]Flash of Light;[@\"..N..\"]Holy Shock\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
						EditMacro("WSxSGen+4",nil,nil,"#show [talent:2/3]Holy Prism;Shield of the Righteous\n/use [@focus,help,nodead,mod:alt][@party1,nodead,mod:alt]Holy Shock;[@mouseover,exists,nodead,talent:2/3][talent:2/3,exists,nodead]Holy Prism;Shield of the Righteous\n/targetenemy [noexists]")
					elseif playerspec == 2 then
						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"\\#show Lay on Hands\\n/use [mod:shift,@\"..B..\"]Lay on Hands;[@\"..B..\"]Light of the Protector\", nil)print(\"Vigil set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"\\#show Lay on Hands\\n/use [mod:shift,@\"..N..\"]Lay on Hands;[@\"..N..\"]Light of the Protector\", nil)print(\"Vigil#2 set to : \"..N)else print(\"Combat!\")end")
						EditMacro("WSxSGen+4",nil,nil,"/use [talent:2/3]Moment of Glory;Judgment\n/targetenemy [noexists]")
						
					else
						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"\\#show Lay on Hands\\n/use [mod:shift,@\"..B..\"]Lay on Hands;[@\"..B..\"]Flash of Light\", nil)print(\"Vigil set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"\\#show Lay on Hands\\n/use [mod:shift,@\"..N..\"]Lay on Hands;[@\"..N..\"]Flash of Light\", nil)print(\"Vigil#2 set to : \"..N)else print(\"Combat!\")end")
						EditMacro("WSxSGen+4",nil,nil,"/use Wake of Ashes\n/targetenemy [noexists]")
					end					
				-- Hunter, hanter 
				elseif class == "HUNTER" then					
					EditMacro("WSkillbomb",nil,nil,"#show\n/use [spec:1]Bestial Wrath;[spec:2]Trueshot;[spec:3]Coordinated Assault\n/use Will of Northrend"..dpsRacials[race].."\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Pendant of the Scarab Storm\n/use Big Red Raygun\n/use Echoes of Rezan")
					EditMacro("WSxT15",nil,nil,"#show [spec:3]Command Pet;[spec:1,talent:1/3]Dire Beast;[spec:1]Aspect of the Wild;[spec:2]Bursting Shot\n/use "..invisPot)
					EditMacro("WSxT45",nil,nil,"#show [talent:3/3]Camouflage;[spec:2][talent:5/3]Binding Shot;Misdirection\n/use [mod:alt,@player]Tar Trap;[@cursor,spec:2][@cursor,talent:5/3]Binding Shot\n/use [nocombat,noexists]Goblin Fishing Bomb\n/use Bloodmane Charm") 
					EditMacro("WSxT100",nil,nil,"#show [spec:1,talent:7/3]Bloodshed;[spec:2,talent:7/3]Volley;[spec:3,talent:7/3]Chakrams;Eagle Eye")
					EditMacro("WSxCSGen+G",nil,nil,"#show [talent:3/3]Camouflage;Scare Beast\n/cancelaura Whole-Body Shrinka'\n/cancelaura Growing Pains\n/cancelaura Aspect of the Turtle")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]"..glider..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..brazier)
					EditMacro("WSxT60",nil,nil,"#show [mod]Hunter's Mark;Play Dead\n/use Dismiss Pet\n/click TotemFrameTotem1 RightButton\n/use Crashin' Thrashin' Robot")
					EditMacro("WSxT90",nil,nil,"#show [spec:1,talent:6/3]Stampede;[nospec:3,talent:6/2]Barrage;[spec:3,talent:6/3]Flanking Strike;[spec:2,talent:6/3]Double Tap;[spec:3]Raptor Strike;[spec:1]Wild Call\n/use [mod,@player]Binding Shot;[@mouseover,harm,nodead][harm,nodead]Intimidation")
					EditMacro("WSxCAGen+B",nil,nil,"")
					EditMacro("WSxCAGen+N",nil,nil,"")
					EditMacro("WSxGen+B",nil,nil,"#show Dash\n/use Dash")
					EditMacro("WSxGen+N",nil,nil,"#show\n/use Growl")
					EditMacro("WSxCSGen+5",nil,nil,"/run SetTracking(4,true);SetTracking(7,true);SetTracking(5,true);SetTracking(10,true);SetTracking(11,true);SetTracking(6,true);SetTracking(8,true);SetTracking(3,true)\n/use Overtuned Corgi Goggles")
					EditMacro("WSxCGen+F",nil,nil,"#show Flare\n/run SetTracking(3,false);SetTracking(4,false);SetTracking(5,false);SetTracking(6,false);SetTracking(7,false);SetTracking(8,false);SetTracking(9,false);SetTracking(10,false);SetTracking(11,false);\n/cancelaura X-Ray Specs")
					EditMacro("WSxCAGen+F",nil,nil,"#show Exhilaration\n/run if not InCombatLockdown() then if GetSpellCooldown(5384)==0 then "..tpPants.." else "..noPants.." end end")
					EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,nodead]Misdirection;[nocombat,noexists]Mrgrglhjorn;[spec:1]Arcane Shot;[spec:2]Rapid Fire;Steady Shot\n/targetenemy [noexists]\n/equipset [noequipped:Bows/Crossbows/Guns]DoubleGate\n/use [nocombat][noexists]Words of Akunda")
					EditMacro("WSxSGen+1",nil,nil,"#show Aspect of the Cheetah\n/use [mod:ctrl,@party2,help,nodead][mod,@pet][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Spirit Mend;[noexists,nocombat]Whitewater Carp\n/targetexact Talua")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/use [spec:1,pet,nopet:Spirit Beast][spec:3,pet]Dismiss Pet;[nopet]Call Pet 2;[@mouseover,help,nodead,pet:Spirit Beast][pet:Spirit Beast,help,nodead][pet:Spirit Beast,@player]Spirit Mend;[spec:3]Arcane Shot;Dismiss Pet\n/use Totem of Spirits")
					EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead]Misdirection")
					local MSK,_ = IsUsableSpell("Mother's Skinning Knife") 
					if MSK == true and eLevel <= 40 then
						MSK = "/targetlasttarget [noexists,nocombat,nodead]\n/use [harm,dead]Mother's Skinning Knife"
					else
						MSK = ""
					end
					EditMacro("WSxGen3",nil,nil,MSK.."\n/use [@mouseover,harm,nodead][harm,nodead]Kill Shot;Imaginary Gun\n/targetenemy [noharm]\n/cleartarget [dead]\n/stopspelltarget\n/equipset [noequipped:Two-Hand,spec:3]Menkify!")
					EditMacro("WSxRTS",nil,nil,"/use [mod:shift,@cursor]Tar Trap;[mod:alt,@focus,harm,nodead,spec:3][spec:3]Wing Clip;[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Concussive Shot\n/targetenemy [noharm]")
					EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,help,nodead][@party2,help,nodead]Misdirection;[nocombat,noharm]Cranky Crab")
					EditMacro("WSxGen4",nil,nil,"#show\n/use [help,nodead]Dalaran Disc;[spec:2,harm,nodead]Aimed Shot;[@mouseover,harm,nodead][harm,nodead]Kill Command;Puntable Marmot\n/target Puntable Marmot\n/targetenemy [noexists]\n/startattack [harm,combat]\n/cleartarget [dead]")
					EditMacro("WSxCGen+4",nil,nil,"/use [spec:1,talent:7/3]Bloodshed;[spec:2,talent:7/3,@cursor]Volley;[spec:3,talent:7/3]Chakrams;[spec:1,talent:6/3]Stampede;[spec:1,talent:6/2]Barrage;Eyes of the Beast")
					EditMacro("WSxCSGen+4",nil,nil,"#show Play Dead\n/target [pet,pet:Crab]pet\n/run SetTracking(9,true);\n/use [nomounted]Gnomish X-Ray Specs\n/use [nopet]Call Pet 3;[pet:Crab,help,pet]Crab Shank;[nocombat,noexists]Gastropod Shell\n/targetlasttarget [help,nodead,pet,pet:Crab]")
					EditMacro("WSxGen5",nil,nil,"/use [mod]Exhilaration;[help,nodead]Silver-Plated Turkey Shooter;[nocombat,noexists]Fireworks;[spec:3,equipped:Two-Hand]Raptor Strike;[spec:1]Cobra Shot;Arcane Shot\n/use [mod]Skoller's Bag of Squirrel Treats\n/cleartarget [dead]\n/targetenemy [noexists]")
					EditMacro("WSxSGen+5",nil,nil,"#show\n/use [nocombat,noexists,mod]Pandaren Scarecrow;[mod,talent:5/3,@player]Binding Shot;[spec:1,talent:1/3]Dire Beast;[spec:3,talent:4/2,@cursor]Steel Trap;[spec:2,talent:1/3][spec:3,talent:4/3]A Murder of Crows;Hunter's Mark")
					EditMacro("WSxGen6",nil,nil,"/use [spec:1,mod]Bestial Wrath;[spec:2,mod]Trueshot;[spec:3,mod]Coordinated Assault;[nocombat,noexists]Twiddle Twirler: Sentinel's Glaive;[spec:3]Carve;[@mouseover,harm,nodead][]Multi-Shot\n/startattack\n/equipset [noequipped:Two-Hand,spec:3]Menkify!")
					EditMacro("WSxSGen+6",nil,nil,"#show\n/use [nocombat,noexists]Laser Pointer\n/use [spec:3,talent:4/2,@player]Steel Trap;[spec:3,talent:4/3]A Murder of Crows;[spec:2]Rapid Fire;[spec:1]Aspect of the Wild;Carve")
					EditMacro("WSxGen7",nil,nil,"/use [mod]Command Pet;[spec:3]Aspect of the Eagle;[spec:1,talent:6/3]Stampede;[spec:1,talent:6/2][spec:2,talent:2/2]Barrage;[spec:2,talent:2/3]Explosive Shot;[spec:2]Rapid Fire;Aspect of the Wild")
					EditMacro("WSxQQ",nil,nil,"/stopcasting [nomod:alt]\n/use [mod:alt,@focus,harm,nodead]Stopping Power;[noexists,noharm]The Golden Banana;[spec:3,@mouseover,harm,nodead][spec:3]Muzzle;[@mouseover,harm,nodead][]Counter shot\n/use Angler's Fishing Spear")
					EditMacro("WSxStuns",nil,nil,"/targetenemy [noharm]\n/stopspelltarget\n/use [mod,@cursor]Flare;[@mouseover,harm,nodead,spec:3][harm,nodead,spec:3]Harpoon;[spec:2]Bursting Shot;Intimidation\n/use [nocombat,noexists]Party Totem\n/cleartarget [dead]\n/equipset [noequipped:Two-Hand,spec:3]Menkify!")
					EditMacro("WSxGenF",nil,nil,"#show Tar Trap\n/focus [@mouseover,exists]mouseover\n/stopmacro [@mouseover,exists]\n/use [@cursor,mod]!Eagle Eye;[spec:3,@focus,harm,nodead]Muzzle;[@focus,harm,nodead]Counter Shot;[@mouseover,harm,nodead][]Hunter's Mark\n/targetenemy [noharm][dead]")
					EditMacro("WSxSGen+F",nil,nil,"#show Mend Pet\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead,nomod][harm,nodead,nomod]Hunter's Mark;Robo-Gnomebulator\n/use \n/stopmacro [mod:ctrl]\n/petautocasttoggle Growl\n/petautocasttoggle [mod:alt]Spirit Walk")
					EditMacro("WSxDef",nil,nil,"#show [mod]Play Dead;Feign Death\n/use [mod:alt]Hunter's Call;[mod]Play Dead;Personal Hologram\n/use [nomod]Feign Death\n/cancelaura Will of the Taunka\n/cancelaura Will of the Vrykul\n/cancelaura Will of the Iron Dwarves\n/use [mod:alt]Gateway Control Shard")
					EditMacro("WSxGND",nil,nil,"#show\n/use [mod:alt,exists]Beast Lore;[mod:ctrl,exists,nodead]Tame Beast;[mod]Aspect of the Cheetah;!Aspect of the Turtle\n/use Super Simian Sphere\n/use Angry Beehive\n/use Xan'tish's Flute")
					EditMacro("WSxCC",nil,nil,"#show Freezing Trap\n/use [mod:ctrl,@cursor]Freezing Trap;[mod,@player]Flare;Revive Pet\n/stopmacro [mod]\n/cancelaura X-Ray Specs\n/cancelaura Safari Hat\n/use [spec:1]Safari Hat\n/use Poison Extraction Totem\n/use Totem of Spirits\n/use Desert Flute")
					EditMacro("WSxMove",nil,nil,"#show\n/use Disengage\n/stopcasting\n/use Crashin' Thrashin' Robot\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Ruthers' Harness\n/use Bom'bay's Color-Seein' Sauce\n/use Prismatic Bauble")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@mouseover,harm,nodead][harm,nodead]Scare Beast;[nopet]Call Pet 1;[swimming]Barnacle-Encrusted Gem\n/use [mod]Weathered Purple Parasol\n/use [pet:Water Strider]Surface Trot")
					EditMacro("WSxRTS",nil,nil,"/use [mod:shift,@cursor]Tar Trap;[mod:ctrl,@player][@mouseover,help,nodead][help,nodead]Master's Call\n/use [spec:3]Wing Clip;[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Concussive Shot\n/targetenemy [noharm]")
					if playerspec == 1 then
						EditMacro("WSxSGen+3",nil,nil,"#show\n/use [talent:4/3]A Murder of Crows;Arcane Shot\n/use Everlasting Darkmoon Firework\n/use Power Converter\n/use Pandaren Firework Launcher\n/startattack\n/use [nocombat,noexists]"..factionFireworks)
						EditMacro("WSxClassT",nil,nil,"#show Intimidation\n/use [mod,@focus,harm,nodead]Intimidation;Hunter's Call"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]\n/petattack [@mouseover,harm,nodead][harm,nodead]")
						EditMacro("WSxT30",nil,nil,"#show [talent:2/3]Chimaera Shot;Fetch\n/use [mod:alt,@player]Freezing Trap;[@mouseover,help,nodead][help,nodead][@focus,help,nodead][pet,@pet]Misdirection"..oOtas)
						EditMacro("WSxGen2",nil,nil,"/use [@mouseover,harm,nodead]Barbed Shot;[harm,dead]Fetch;[help,nodead,nocombat]Corbyn's Beacon;Barbed Shot\n/targetlasttarget [noharm,nodead,nocombat]\n/targetenemy [noharm]")
						EditMacro("WSxSGen+4",nil,nil,"/use [talent:2/3]Chimaera Shot;Misdirection\n/targetenemy [noharm][dead]\n/cleartarget [dead]")
					elseif playerspec == 2  then
						EditMacro("WSxSGen+3",nil,nil,"/use [talent:1/2]Serpent Sting;[talent:1/3]A Murder of Crows;[talent:2/2]Barrage;[talent:2/3]Explosive Shot\n/use Everlasting Darkmoon Firework\n/use Power Converter\n/use Pandaren Firework Launcher\n/startattack\n/use [nocombat,noexists]"..factionFireworks)
						EditMacro("WSxClassT",nil,nil,"#show Command Pet\n/use Hunter's Call"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/petattack [@mouseover,harm,nodead][harm,nodead]\n/cleartarget [dead]\n/startattack [combat]")
						EditMacro("WSxT30",nil,nil,"#show [talent:2/2]Barrage;[talent:2/3]Explosive Shot;Fetch\n/use [mod:alt,@player]Freezing Trap;[@mouseover,help,nodead][help,nodead][@focus,help,nodead][pet,@pet]Misdirection"..oOtas)
						EditMacro("WSxGen2",nil,nil,"/use [@mouseover,harm,nodead]Steady Shot;[harm,dead]Fetch;[help,nodead,nocombat]Corbyn's Beacon;Steady Shot\n/targetlasttarget [noharm,nodead,nocombat]\n/targetenemy [noharm]")
						EditMacro("WSxSGen+4",nil,nil,"/use [talent:6/3]Double Tap;Misdirection\n/targetenemy [noharm][dead]\n/cleartarget [dead]")
					else
						EditMacro("WSxSGen+3",nil,nil,"/use [mod,@focus,harm]Kill Command;[@mouseover,harm,nodead][]Wildfire Bomb\n/use Everlasting Darkmoon Firework\n/use Power Converter\n/use Pandaren Firework Launcher\n/use Azerite Firework Launcher\n/startattack\n/use [nocombat,noexists]"..factionFireworks)
						EditMacro("WSxClassT",nil,nil,"#show Intimidation\n/use [mod,@focus,harm,nodead]Intimidation;Hunter's Call"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]\n/petattack [@mouseover,harm,nodead][harm,nodead]")
						EditMacro("WSxT30",nil,nil,"#show Fetch\n/use [mod:alt,@player]Freezing Trap;[@mouseover,help,nodead][help,nodead][@focus,help,nodead][pet,@pet]Misdirection"..oOtas)
						EditMacro("WSxGen2",nil,nil,"/use [@mouseover,harm,nodead]Serpent Sting;[harm,dead]Fetch;[help,nodead,nocombat]Corbyn's Beacon;Serpent Sting\n/targetlasttarget [noharm,nodead,nocombat]\n/targetenemy [noharm]")
						EditMacro("WSxSGen+4",nil,nil,"/use [spec:3,talent:6/3,nomod]Flanking Strike;[nomod]Misdirection\n/targetenemy [noharm][dead]\n/cleartarget [dead]\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Kill Command\n/targetlasttarget")
					end			
				-- Rogue, rogge, rouge, raxicil
				elseif class == "ROGUE" then
					EditMacro("WSkillbomb",nil,nil,"/use [spec:1]Vendetta;[spec:2]Adrenaline Rush;Shadow Blades;\n/stopmacro [stealth]\n/use Will of Northrend"..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13"..hasHE.."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
					EditMacro("WSxT15",nil,nil,"#show [spec:2,talent:1/1]Ghostly Strike;[spec:1,talent:1/3]Ambush;[spec:3,talent:1/3]Backstab;Wound Poison\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#show\n/use [@focus,help,nodead][@mouseover,help,nodead][help,nodead][@party1,help,nodead]Tricks of the Trade\n/use Seafarer's Slidewhistle"..oOtas)
					EditMacro("WSxT45",nil,nil,"#show\n/use [mod:alt,spec:1,@focus,harm,nodead,nostance:0][spec:1,nostance:0]Garrote;[stance:0,nocombat]Stealth;[stance:0,combat]Vanish\n/use [nostealth] Hourglass of Eternity")
					EditMacro("WSxT90",nil,nil,"#show [spec:2,talent:6/3]Dreadblades;[spec:3,talent:6/3]Enveloping Shadows;[spec:1,talent:6/2]Toxic Blade;[spec:1,talent:6/3]Exsanguinate\n/use [mod:alt,@player][]Distract")
					EditMacro("WSxT100",nil,nil,"#show [spec:1,talent:7/3]Crimson Tempest;[spec:2,talent:7/2]Blade Rush;[spec:2,talent:7/3]Killing Spree;[spec:3,talent:7/2]Secret Technique;[spec:3,talent:7/3]Shuriken Tornado;[nospec:2]Eviscerate;Run Through")
					EditMacro("WSxCSGen+G",nil,nil,"#show Blind\n/use Totem of Spirits\n/use [@focus,harm,nodead]Gouge")	
					EditMacro("WSxT60",nil,nil,"#show\n/use Numbing Poison\n/run PetDismiss();")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]"..glider..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..brazier)
					EditMacro("WSxSGen+H",nil,nil,"#show\n/use [nomounted,nocombat,noexists]Burgy Blackheart's Handsome Hat;Shiv\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\"); else DoEmote(\"kneel\") end end")
					EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"\\#show Sprint\\n/use [@\"..B..\"]Tricks of the Trade\\n/stopspelltarget\", nil)print(\"Trix set to : \"..B)else print(\"Combat!\")end")
					EditMacro("WSxGen+B",nil,nil,"#show\n/use Sprint")
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"\\#show Sprint\\n/use [@\"..N..\"]Tricks of the Trade\\n/stopspelltarget\", nil)print(\"Trix#2 set to : \"..N)else print(\"Combat!\")end")
					EditMacro("WSxGen+N",nil,nil,"#show\n/use Sprint")
					EditMacro("WSxGen1",nil,nil,"/use [nocombat,nostealth]Xan'tish's Flute\n/use [@mouseover,help,nodead]Tricks of the Trade;[stance:0,nocombat]Stealth;[spec:3]Symbols of Death;[spec:2]Pistol Shot;[@mouseover,harm,nodead][]Garrote\n/targetenemy [noexists]\n/startattack [combat]")
					EditMacro("WSxSGen+1",nil,nil,"#show Tricks of the Trade\n/use [mod:ctrl,@party2,help,nodead,nospec:2][@focus,help,nodead,nospec:2][@party1,help,nodead,nospec:2]Shadowstep\n/targetexact Lucian Trias")
					EditMacro("WSxGen2",nil,nil,"/targetenemy [noexists]\n/use [stance:0,nocombat]Stealth;[stealth,nostance:3,nodead]Pick Pocket;[spec:2]Sinister Strike;[spec:3]Shadowstrike;Shiv\n/cleartarget [exists,dead]\n/stopspelltarget")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/cast Crimson Vial\n/use [nostealth] Totem of Spirits\n/use [nostealth]Hourglass of Eternity\n/use [nocombat,nostealth,spec:2]Don Carlos' Famous Hat;[nocombat,nostealth]Dark Ranger's Spare Cowl")
					EditMacro("WSxGen3",nil,nil,"/use [spec:1,talent:1/3]Ambush;[stance:0,nocombat]Stealth;[stance:0,combat,spec:3]Shadow Dance;[nostance:0,spec:3]Shadowstrike;[spec:2]Between The Eyes;Sinister Strike\n/targetenemy [noexists]")
					EditMacro("WSxSGen+3",nil,nil,"#show\n/use [@mouseover,harm,nodead,nospec:2][nospec:2]Rupture;[spec:2]Between the Eyes\n/targetenemy [noexists]\n/use [spec:2,nocombat]Ghostly Iron Buccaneer's Hat;[nospec:2]Ravenbear Disguise")
					EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead]Tricks of the Trade;")
					EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,help,nodead][@party2,help,nodead]Tricks of the Trade")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@focus,help,nodead][@party3,help,nodead]Tricks of the Trade;[nocombat,noexists]Crashin' Thrashin' Cannon Controller")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,help,nodead][@party4,help,nodead]Tricks of the Trade")
					EditMacro("WSxGen4",nil,nil,"/use [nocombat,noexists,spec:2]Dead Ringer\n/use [nospec:3,nostance:0]Ambush;[spec:2,talent:1/3]Ghostly Strike;[spec:3]Backstab;[spec:1]Sinister Strike;Pistol Shot\n/use [stance:0,nocombat]Stealth\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+4",nil,nil,"/use [nocombat,noexists,nostealth]Barrel of Eyepatches\n/use [talent:3/3]Marked for Death;Feint\n/use [nostealth,nospec:2]Hozen Beach Ball;[nostealth]Titanium Seal of Dalaran\n/targetenemy [noexists]\n/startattack [combat]\n/cleartarget [dead]")
					EditMacro("WSxCGen+4",nil,nil,"#show\n/use [spec:2,talent:7/2]Blade Rush;[spec:2,talent:7/3]Killing Spree;[spec:1]Vendetta;[spec:2]Adrenaline Rush;Shadow Blades\n/targetenemy [noexists,nocombat]\n/use [nocombat,noexists]Gastropod Shell")
					EditMacro("WSxGen5",nil,nil,"#show\n/use [mod:ctrl]Smoke Bomb;[spec:1]Envenom;[spec:2]Dispatch;Eviscerate;\n/targetenemy [noexists]\n/stopmacro [nomod:ctrl]\n/use [spec:2]Mr. Smite's Brass Compass;Shadescale\n/roar")
					EditMacro("WSxSGen+5",nil,nil,"/use [nocombat,noexists,nostealth]Barrel of Bandanas\n/use Slice and Dice\n/use [nocombat,noexists,nostealth] Worn Troll Dice")
					EditMacro("WSxGen6",nil,nil,"#show\n/use [spec:1,mod:ctrl]Vendetta;[spec:2,mod:ctrl]Adrenaline Rush;[spec:3,mod:ctrl]Shadow Blades;[spec:1]Fan of Knives;[spec:2]Blade Flurry;[spec:3]Shuriken Storm")
					EditMacro("WSxSGen+6",nil,nil,"/use [stance:0,nocombat]Stealth;[spec:1,talent:7/3]Crimson Tempest;[spec:2,talent:6/3]Dreadblades;[spec:3,talent:7/2]Secret Technique;[spec:3,talent:7/3]Shuriken Tornado;[spec:3]Black Powder")
					EditMacro("WSxGen7",nil,nil,"#show\n/use [nocombat,help]Corbyn's Beacon;[spec:3]Black Powder;[spec:2]Roll the Bones;[spec:1,talent:6/3]Exsanguinate;[@mouseover,harm,nodead][]Rupture\n/use [stance:0]Stealth;Autographed Hearthstone Card")
					EditMacro("WSxQQ",nil,nil,"#show\n/use [mod:alt,@focus,harm,nodead]Blind;[mod:shift]Cloak of Shadows;[@mouseover,harm,nodead][harm,nodead]Kick;The Golden Banana\n/use [spec:2,nocombat,noexists]Rime of the Time-Lost Mariner;[nospec:2,nocombat,noexists]Sira's Extra Cloak")
					EditMacro("WSxStuns",nil,nil,"/use [mod:alt,@focus,harm,nodead,nostance:0][nostance:0]Cheap Shot;[stance:0,combat,spec:3]Shadow Dance;[stance:0,nocombat]Stealth;[stance:0,combat]Vanish\n/use [nostealth,spec:2,nocombat]Iron Buccaneer's Hat")
					EditMacro("WSxGenF",nil,nil,"#show\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,spec:1,@focus,harm,nodead]Garrote;[mod:alt]Farwater Conch;[@focus,harm,nodead]Kick;[exists,nodead,spec:1]Detoxified Blight Grenade;Detection")
					EditMacro("WSxSGen+F",nil,nil,"/use [stance:0,nocombat]Stealth;[mod:alt,spec:1,stance:0,combat]Vanish;[mod:alt,spec:1,@focus,harm]Garrote;[mod:alt,spec:2,@focus,harm]Gouge\n/use [nospec:2,@focus,harm,nodead][nospec:2]Shadowstep\n/use [nomod,@focus,harm][nomod]Kick")
					EditMacro("WSxCGen+F",nil,nil,"#show Cloak of Shadows\n/cancelaura Burgy Blackheart's Handsome Hat\n/use [help]Ai-Li's Skymirror\n/summonpet Crackers\n/use Suspicious Crate\n/stopmacro [noexists]\n/whistle")
					EditMacro("WSxCAGen+F",nil,nil,"#show [stealth]Shroud of Concealment;[nocombat,noexists]Twelve-String Guitar;Cloak of Shadows\n/targetfriend [nohelp,nodead]\n/use [nospec:2,help,nodead]Shadowstep;[nocombat,noexists]Twelve-String Guitar\n/targetlasttarget")
					EditMacro("WSxDef",nil,nil,"#show\n/use [mod:alt]Wound Poison;[mod,spec:1]Deadly Poison;[mod]Instant Poison;[stance:0,nocombat]Stealth;[combat]Evasion;[stance:1]Shroud of Concealment\n/use [mod:alt]Gateway Control Shard")
					EditMacro("WSxGND",nil,nil,"/use [mod:alt]Crippling Poison;[mod:ctrl,spec:2,exists,nodead]Bribe;[mod:ctrl]Scroll of Teleport: Ravenholdt;[mod:shift]Sprint;Feint\n/use [nostealth,mod:shift]Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
					EditMacro("WSxCC",nil,nil,"#show\n/targetenemy [noexists]\n/use [mod:ctrl,@mouseover,harm,nodead][mod:ctrl]Blind;[stance:0,nocombat]Stealth;[@focus,harm,nodead,stance:1/2/3,mod][@mouseover,harm,nodead,stance:1/2/3][stance:1/2/3]Sap;Blind\n/cancelaura Don Carlos' Famous Hat")
					EditMacro("WSxMove",nil,nil,"/use [@mouseover,exists,nodead,nospec:2][nospec:2]Shadowstep;[spec:2,@cursor]Grappling Hook\n/targetenemy [noexists]\n/use [nostealth]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use [nostealth]Prismatic Bauble")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem;Survivor's Bag of Coins\n/use [mod]Weathered Purple Parasol")	
					if playerspec == 1 then
						EditMacro("WSxRTS",nil,nil,"#show\n/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]Poisoned Knife;[@mouseover,help,nodead,nomod][help,nodead,nomod]Shadowstep;Horse Head Costume\n/targetenemy [noexists]")
						EditMacro("WSxClassT",nil,nil,"#show\n/use [nocombat,nostance:1/2/3]Stealth;[stealth,@cursor,nocombat]Distract;[@mouseover,harm,nodead][]Poisoned Knife"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
					elseif playerspec == 2 then
						EditMacro("WSxRTS",nil,nil,"#show\n/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]Pistol Shot;Horse Head Costume\n/targetenemy [noexists]")
						EditMacro("WSxClassT",nil,nil,"#show\n/use [nocombat,nostance:1/2/3]Stealth;[stealth,@cursor,nocombat]Distract;[mod,@focus,nodead][]Gouge\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
					else
						EditMacro("WSxRTS",nil,nil,"#show\n/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead,d]Shuriken Toss;[@mouseover,help,nodead][help,nodead]Shadowstep;Horse Head Costume")
						EditMacro("WSxClassT",nil,nil,"#show\n/use [nocombat,nostance:1/2/3]Stealth;[stealth,@cursor,nocombat]Distract;[@mouseover,harm,nodead][]Shuriken Toss"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
					end					
				-- Priest, Prist
				elseif class == "PRIEST" then
					local pristHeal = "Shadow Mend"
					if (level <= 27 and playerspec == 1) or (playerspec == 2) then 
						pristHeal = "Flash Heal"
					end
					EditMacro("WSkillbomb",nil,nil,"/use [spec:2,talent:7/2]Apotheosis;[nospec:2]Shadowfiend"..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
					EditMacro("WSxT15",nil,nil,"#show [spec:1,talent:1/3]Schism;Power Word: Fortitude\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#show [nospec:3,talent:2/3]Angelic Feather;Power Word: Shield\n/use [nospec:3,talent:4/3,mod,@player]Shining Force;Desperate Prayer"..oOtas)
					EditMacro("WSxT45",nil,nil,"#show [spec:1,talent:3/3]Power Word: Solace;[spec:3,talent:3/3]Searing Nightmare;Mind Control\n/use [mod:alt,@player]Mass Dispel;[@mouseover,harm,nodead][]Psychic Scream\n/use Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
					EditMacro("WSxT60",nil,nil,"#show [nospec:3,talent:4/3]Shining Force;[spec:3,talent:4/3]Psychic Horror;Psychic Scream\n/use [nocombat,noexists]Sturdy Love Fool\n/run PetDismiss();\n/cry")
					EditMacro("WSxT100",nil,nil,"#show [spec:3,talent:7/3]Surrender to Madness;[spec:2,talent:7/2]Apotheosis;[spec:2,talent:7/3]Holy Word: Salvation;[spec:1,talent:7/2]Rapture;[spec:1,talent:7/3]Evangelism;Smite")
					EditMacro("WSxCSGen+G",nil,nil,"#show Fade\n/use [@focus,harm,nodead]Dispel Magic;[nospec:3,@focus,help,nodead][nospec:3]Purify;[@focus,help,nodead][]Purify Disease\n/cancelaura Dispersion")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]"..glider..";[mod]6;[nocombat]Resurrection;"..pwned.."\n/use [mod:ctrl]Mass Resurrection"..brazier)
					EditMacro("WSxSGen+H",nil,nil,"#show Leap of Faith\n/use [nocombat,noexists]Don Carlos' Famous Hat\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\"); else DoEmote(\"kneel\") end end")	    
					EditMacro("WSxSGen+1",nil,nil,"#show Power Infusion\n/use [mod:alt,@party3,nodead][mod:ctrl,@party2,exists][@focus,help][@party1,exists][@targettarget,exists]"..pristHeal..";Kaldorei Light Globe")
					EditMacro("WSxGen2",nil,nil,"#show\n/cancelaura Fling Rings\n/use [nospec:3,help,nodead]Holy Lightsphere;[help,nodead]Corbyn's Beacon\n/use [@mouseover,harm,nodead][]Smite\n/use [nocombat]Darkmoon Ring-Flinger\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/use [mod,@party4,nodead][@mouseover,help,nodead][]"..pristHeal.."\n/use Gnomish X-Ray Specs\n/cancelaura Don Carlos' Famous Hat\n/cancelaura X-Ray Specs")
					EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead,nospec:3][@party1,help,nodead,nospec:3]Purify;[@focus,help,nodead][@party1,help,nodead]Purify Disease\n/use [nocombat]Thaumaturgist's Orb\n/use [@party1,mod]Apexis Focusing Shard")
					EditMacro("WSxGen3",nil,nil,"/targetenemy [noexists]\n/cleartarget [dead]\n/use [@mouseover,harm,nodead][harm,nodead]Shadow Word: Death\n/use Scarlet Confessional Book\n/petattack\n/use Ivory Feather\n/use [nocombat,noexists,spec:3]Twitching Eyeball")
					EditMacro("WSxSGen+3",nil,nil,"/targetenemy [noexists]\n/stopspelltarget\n/cleartarget [dead]\n/use [@mouseover,harm,nodead,nomod][nomod]Shadow Word: Pain\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Shadow Word: Pain\n/targetlasttarget")
					EditMacro("WSxCSGen+3",nil,nil,"/use [nospec:2,@focus,harm,nodead]Shadow Word: Pain;[@party2,help,nodead,nospec:3]Purify;[@party2,help,nodead]Purify Disease\n/use [nocombat,noharm]Forgotten Feather\n/stopspelltarget\n/use [@party2,mod]Apexis Focusing Shard")
					EditMacro("WSxGen4",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,noexists,nochanneling]Pretty Draenor Pearl\n/use [spec:3]Mind Blast;[spec:2,@mouseover,help,nodead][spec:2]Holy Word: Serenity;[@mouseover,help,nodead][]Penance")
					EditMacro("WSxCSGen+4",nil,nil,"/use [spec:3,@focus,harm,nodead]Vampiric Touch;[@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Power Word: Shield;[nocombat]Romantic Picnic Basket\n/use [@party1]Apexis Focusing Shard")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,spec:3,harm,nodead]Devouring Plague;[@focus,help,nodead][@party2,help,nodead]Power Word: Shield\n/use Battle Standard of Coordination\n/use [@party2]Apexis Focusing Shard")
					EditMacro("WSxGen6",nil,nil,"#show\n/use [mod,spec:2]Divine Hymn;[mod]Shadowfiend;[nospec:3,talent:6/2]Divine Star;[nospec:3,talent:6/3]Halo;[spec:3,talent:5/3,@cursor]Shadow Crash;[spec:2]Holy Nova;[@mouseover,exists,nodead][]Mind Sear\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+6",nil,nil,"/use [spec:3]Mind Sear;[@mouseover,help,nodead,spec:2][spec:2]Prayer of Healing;[@mouseover,help,nodead][]Power Word: Radiance\n/use Cursed Feather of Ikzan\n/use [nocombat]Dead Ringer\n/targetenemy [noexists]")
					EditMacro("WSxQQ",nil,nil,"#show\n/use [mod:alt,@focus,harm,nodead][spec:1,notalent:4/3]Mind Control;[@mouseover,exists,nodead,nospec:3,talent:4/3][nospec:3,talent:4/3]Shining Force;[spec:2]Holy Word: Chastise;[@mouseover,harm,nodead][]Silence")
					EditMacro("WSxStuns",nil,nil,"#show\n/use [mod:alt,@cursor]Mass Dispel;[noexists,nocombat]Party Totem;Holy Nova")
					EditMacro("WSxRTS",nil,nil,"/use [mod:shift]Psychic Scream;[mod,nospec:3,talent:2/3,@player][nospec:3,talent:2/3,@cursor]Angelic Feather;[mod,@player][@mouseover,help,nodead][]Power Word: Shield\n/stopspelltarget")
					EditMacro("WSxGenF",nil,nil,"/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod,@focus,harm,nodead]Shackle Undead;[mod,exists,nodead]Mind Vision;[mod]Farwater Conch;[spec:3,@focus,harm,nodead]Silence;[help,nodead]True Love Prism;Doomsayer's Robes")
					EditMacro("WSxSGen+F",nil,nil,"/use [help,nocombat,mod:alt]B. F. F. Necklace;[nocombat,noexists,mod:alt]Gastropod Shell;[nocombat,noexists,nomod]Tickle Totem\n/cancelaura [mod:alt]Shadowform")
					EditMacro("WSxCGen+F",nil,nil,"#show [spec:2]Symbol of Hope;[spec:1]Rapture;Psychic Scream\n/use [nocombat,noexists]Piccolo of the Flaming Fire;[spec:3]Vampiric Embrace;Rapture\n/cancelaura Twice-Cursed Arakkoa Feather\n/cancelaura Spirit Shell")
					EditMacro("WSxCAGen+F",nil,nil,"#show [spec:1]Power Word: Barrier;[spec:2]Divine Hymn;Vampiric Embrace\n/cancelaura Twice-Cursed Arakkoa Feather\n/targetfriendplayer\n/use [help,nodead]Power Infusion;Starlight Beacon\n/targetlasttarget")
					EditMacro("WSxGG",nil,nil,"#show\n/use [mod:alt]Darkmoon Gazer;[@mouseover,harm,nodead]Dispel Magic;[nospec:3,@mouseover,help,nodead][nospec:3]Purify;[@mouseover,help,nodead][]Purify Disease\n/use Poison Extraction Totem")
					EditMacro("WSxDef",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;[mod,spec:1,@player]Power Word: Barrier;[@mouseover,spec:1,help,nodead][spec:1]Pain Suppression;[@mouseover,spec:2,help,nodead][spec:2]Guardian Spirit;!Dispersion")
					EditMacro("WSxCC",nil,nil,"/use [spec:2,mod:shift]Symbol of Hope;[@mouseover,harm,nodead,mod][mod]Shackle Undead;[spec:2,@mouseover,help,nodead][spec:2]Prayer of Mending;[@mouseover,harm,nodead,spec:1,talent:3/3][spec:1,talent:3/3]Power Word: Solace;Shadowfiend")
					EditMacro("WSxMove",nil,nil,"#show\n/use [spec:2,@mouseover,help,nodead][spec:2]Renew\n/use [nomod]Panflute of Pandaria\n/use Puzzle Box of Yogg-Saron\n/use Spectral Visage\n/use Xan'tish's Flute\n/cancelaura Rhan'ka's Escape Plan")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming,noexists,nocombat]Barnacle-Encrusted Gem;Levitate\n/use [nomod]Seafarer's Slidewhistle\n/use [mod]Weathered Purple Parasol")
					EditMacro("WSxGen+B",nil,nil,"#show Desperate Prayer\n/use [@mouseover,exists,nodead,nospec:2][nospec:2]Mind Sear\n/targetfriendplayer [nohelp,nodead]\n/targetfriend [nohelp,nodead]")
					EditMacro("WSxGen+N",nil,nil,"#show Power Infusion\n/use [mod,@focus,help,nodead][@mouseover,help,nodead][]Power Infusion")
					EditMacro("WSxCAGen+B",nil,nil,"")
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"\\#show Power Infusion\\n/use [mod,@\"..N..\"][@mouseover,help,nodead][]Power Infusion\\n/stopspelltarget\", nil)print(\"PI set to : \"..N)else print(\"Nöpe!\")end")
					EditMacro("WSxGND",nil,nil,"/use [mod:alt]Mind Soothe;[mod:shift]Fade;[mod,harm,nodead]Mind Control;[mod]Unstable Portal Emitter;[@mouseover,help,nodead][]Power Word: Shield\n/use [nocombat]Bubble Wand\n/use Void Totem\n/cancelaura Bubble Wand")
					EditMacro("Wx5Trinket2",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod,@party4,help,nodead]Power Word: Shield;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14\n/use Eternal Black Diamond Ring")
					if playerspec == 1 then
						EditMacro("WSxGen1",nil,nil,"/use [help,nodead,nocombat]The Heartbreaker;[@mouseover,help,nodead][help,nodead]Power Infusion;[talent:1/3,talent:5/3]Schism;[talent:3/3]Power Word: Solace;[@mouseover,harm,nodead][]Shadow Word: Pain\n/startattack")
						EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noexists]\n/use [@focus,help,nodead,mod][@party1,help,nodead,mod]Penance;[nocombat,noharm]Leather Love Seat;[talent:1/3]Schism;[talent:3/3]Power Word: Solace;Smite\n/stopspelltarget")
						EditMacro("WSxCGen+4",nil,nil,"#show\n/use [mod,@party3,help,nodead]Power Word: Shield;[@mouseover,help,nodead,talent:5/3][talent:5/3]Shadow Covenant;[talent:7/3]Evangelism;Rapture\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxGen5",nil,nil,"/use [mod:ctrl,spec:1,@cursor]Power Word: Barrier;[@mouseover,harm,nodead][]Mind Blast\n/use [help,nodead]Apexis Focusing Shard\n/targetenemy [noexists]")
						EditMacro("WSxSGen+5",nil,nil,"/use [@party2,help,nodead,mod]Penance;[nocombat,noexists,nochanneling]Soul Evacuation Crystal\n/targetenemy [noharm]\n/cleartarget [dead]\n/use [spec:1,@player]Penance")
						EditMacro("WSxClassT",nil,nil,"/use [mod,@player,talent:4/3][@mouseover,exists,nodead,talent:4/3][exists,nodead,talent:4/3]Shining Force;Mind Vision"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]\n/stopspelltarget")
						EditMacro("WSxT90",nil,nil,"#show Leap of Faith\n/use [mod,@focus,help,nodead][@mouseover,help,nodead][exists,nodead]Leap of Faith")
						EditMacro("WSxGen7",nil,nil,"/use [talent:7/3,mod]Evangelism;[@mouseover,exists,nodead][]Mind Sear\n/targetenemy [noexists]\n/cleartarget [dead]")
						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Shadow Mend;[@\"..B..\"]Power Word: Shield\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Shadow Mend;[@\"..N..\"]Power Word: Shield\", nil)print(\"Tank#2 set to: \" ..N)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+B",nil,nil,"")
						-- EditMacro("WSxCAGen+N",nil,nil,"")
					elseif playerspec == 2 then
						EditMacro("WSxGen1",nil,nil,"/use [help,nodead,nocombat]The Heartbreaker;[@mouseover,help,nodead][help,nodead]Power Infusion;[@mouseover,harm,nodead][]Holy Fire\n/startattack")
						EditMacro("WSxSGen+4",nil,nil,"/use [mod,@focus,help,nodead][mod,@party1,help,nodead]Prayer of Mending;[talent:6/2]Divine Star;[talent:6/3]Halo;[@mouseover,help,nodead][]Prayer of Healing\n/use [nocombat,noexists]Leather Love Seat\n/stopspelltarget")
						EditMacro("WSxCGen+4",nil,nil,"#show\n/use [mod,@party3,help,nodead]Power Word: Shield;[talent:7/2]Apotheosis;[talent:7/3]Holy Word: Salvation;Power Infusion\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxGen5",nil,nil,"#show\n/use [spec:2,@mouseover,help,nodead][spec:2]Heal\n/targetenemy [noexists]")
						EditMacro("WSxSGen+5",nil,nil,"/use [@party2,help,nodead,mod]Prayer of Mending;[nocombat,noexists,nochanneling]Soul Evacuation Crystal\n/targetenemy [noharm]\n/cleartarget [dead]\n/use [@mouseover,help,nodead,spec:2][spec:2]Circle of Healing")
						EditMacro("WSxClassT",nil,nil,"/use [@mouseover,harm,nodead][]Holy Word: Chastise"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]\n/stopspelltarget")
						EditMacro("WSxT90",nil,nil,"#show\n/use [mod,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]Holy Word: Chastise\n/use [mod,@focus,help,nodead][@mouseover,help,nodead][]Leap of Faith")
						EditMacro("WSxGen7",nil,nil,"/use [@player,mod][@cursor]Holy Word: Sanctify\n/targetenemy [noexists]\n/cleartarget [dead]")
						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Flash Heal;[spec:2,@\"..B..\"]Prayer of Mending;[@\"..B..\"]Power Word: Shield\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Flash Heal;[spec:2,@\"..N..\"]Prayer of Mending;[@\"..N..\"]Power Word: Shield\", nil)print(\"Tank#2 set to: \" ..N)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+B",nil,nil,"")
						-- EditMacro("WSxCAGen+N",nil,nil,"")
					else						
						EditMacro("WSxGen1",nil,nil,"/use [help,nodead,nocombat]The Heartbreaker;[@mouseover,help,nodead][help,nodead]Power Infusion;[talent:6/3]Void Torrent;[@mouseover,harm,nodead,talent:6/1][talent:6/1]Damnation;[@mouseover,harm,nodead][]Shadow Word: Pain\n/startattack")	
						EditMacro("WSxSGen+4",nil,nil,"/stopspelltarget\n/targetenemy [noharm]\n/cleartarget [dead]\n/use [noform]Shadowform;[nomod,nocombat,noexists]Shadescale\n/use [@mouseover,harm,nodead][nomod]Vampiric Touch\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Vampiric Touch\n/targetlasttarget")
						-- If both Damnation and Void Torrent, then make macro Damnation (so that both can be used inside Torghast)
						local tSixPrist = "Power Infusion" 
						if IsSpellKnown(341374) and IsSpellKnown(263165) == true then
							tSixPrist = "[@mouseover,harm,nodead][]Damnation"
						end
						EditMacro("WSxCGen+4",nil,nil,"#show\n/use [mod,@party3,help,nodead]Power Word: Shield;[@mouseover,harm,nodead,talent:7/3][talent:7/3]Surrender to Madness;"..tSixPrist.."\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxGen5",nil,nil,"#show\n/use [spec:3,@mouseover,harm,nodead][spec:3]Void Eruption\n/targetenemy [noexists]")
						EditMacro("WSxSGen+5",nil,nil,"/use [@mouseover,harm,nodead,nomod][harm,nodead,nomod]Devouring Plague;Soul Evacuation Crystal\n/targetenemy [noharm]\n/cleartarget [dead]\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Devouring Plague\n/targetlasttarget")
						EditMacro("WSxClassT",nil,nil,"/use [@mouseover,harm,nodead,talent:4/3][talent:4/3]Psychic Horror"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]\n/stopspelltarget")
						EditMacro("WSxT90",nil,nil,"#show [talent:6/3]Void Torrent;[talent:6/1]Damnation;Mind Vision\n/use [mod,@focus,harm,nodead,talent:4/3][@mouseover,harm,nodead,talent:4/3][talent:4/3,harm,nodead]Psychic Horror\n/use [mod,@focus,help,nodead][@mouseover,help,nodead][]Leap of Faith")
						EditMacro("WSxGen7",nil,nil,"/use [@player,spec:3,talent:5/3,mod]Shadow Crash;[@mouseover,exists,nodead,talent:3/3]Mind Sear;[talent:3/3,channeling:Mind Sear]Searing Nightmare;[@mouseover,exists,nodead][]Mind Sear\n/targetenemy [noexists]\n/cleartarget [dead]")
						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Shadow Mend;[@\"..B..\"]Power Word: Shield\", nil)print(\"Vigil set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Shadow Mend;[@\"..N..\"]Power Word: Shield\", nil)print(\"Vigil#2 set to: \"..N)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+B",nil,nil,"")
						-- EditMacro("WSxCAGen+N",nil,nil,"")
					end
				-- Death Knight, DK, diky
				elseif class == "DEATHKNIGHT" then
					EditMacro("WSkillbomb",nil,nil,"#show\n/cast [spec:1]Dancing Rune Weapon;[spec:2]Pillar of Frost;[nopet]Raise Dead;Dark Transformation"..dpsRacials[race].."\n/use [@player]13\n/use 13\n/use Raise Dead\n/use Pendant of the Scarab Storm\n/use Adopted Puppy Crate\n/use Big Red Raygun")
					EditMacro("WSxT15",nil,nil,"#show [spec:1,talent:1/2]Blooddrinker;[spec:1,talent:1/3]Tombstone;Corpse Exploder\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#show [spec:1,talent:2/3]Consumption;[spec:2,talent:2/3]Horn of Winter;[spec:3,talent:2/3]Unholy Blight;[spec:1,talent:3/3]Blood Tap"..oOtas.."\n/use [spec:2,talent:2/3]Horn of Winter;[spec:1,talent:3/3]Blood Tap")
					EditMacro("WSxT45",nil,nil,"#show [spec:3,talent:3/3][spec:2,talent:3/2]Asphyxiate;[spec:2,talent:3/3]Blinding Sleet;[spec:1,talent:3/3]Blood Tap;Raise Ally\n/use [spec:2,talent:3/3]Blinding Sleet;[nospec:1]Asphyxiate;[mod,@player]Gorefiend's Grasp;Rune Tap")
					EditMacro("WSxT60",nil,nil,"#show [spec:1,talent:4/3]Mark of Blood;[spec:2,talent:4/3]Frostscythe;[spec:3,talent:4/3]Soul Reaper\n/use Sylvanas' Music Box\n/run PetDismiss();\n/cry")
					EditMacro("WSxT90",nil,nil,"#show [spec:2,talent:6/2]Hypothermic Presence;[spec:2,talent:6/3]Glacial Advance;[spec:3]Death and Decay;[spec:1,talent:6/2]Death Pact\n/use [mod,@player]Gorefiend's Grasp;Dark Command\n/use Blight Boar Microphone")
					EditMacro("WSxT100",nil,nil,"#show [spec:2,talent:7/3]Breath of Sindragosa;[spec:3,talent:7/3]Unholy Assault;[spec:3,talent:7/2]Summon Gargoyle;[spec:1,talent:7/3]Bonestorm")
					EditMacro("WSxCSGen+G",nil,nil,"#show Control Undead")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]"..glider..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..brazier)
					EditMacro("WSxSGen+H",nil,nil,"#show Death Gate\n/use [nomounted]Death Gate\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\"); else DoEmote(\"kneel\") end end")
					EditMacro("WSxCAGen+F",nil,nil,"#show [mod]Path of Frost;[spec:1]Gorefiend's Grasp;[spec:3,pet]!Gnaw;Stolen Breath\n/use 16\n/equipset "..EQS[playerspec].."\n/run local _,d,_=GetItemCooldown(151255) if d==0 then EquipItemByName(151255) end")
					EditMacro("WSxGen+B",nil,nil,"#show Lichborne\n/use Sacrificial Pact\n/use [nopet]Raise Dead")
					EditMacro("WSxCAGen+B",nil,nil,"")
					EditMacro("WSxGen+N",nil,nil,"#show\n/use [mod:alt,@player][]Anti-Magic Zone")
					EditMacro("WSxCAGen+N",nil,nil,"")
					EditMacro("WSxGen1",nil,nil,"#show\n/cast [@mouseover,help,dead][help,dead]Raise Ally;[spec:2]Frostwyrm's Fury;[spec:3]Apocalypse;[@mouseover,harm,nodead,spec:1][spec:1,talent:1/2]Blooddrinker;[spec:1,talent:1/3]Tombstone;Death Strike\n/targetenemy [noexists]")
					EditMacro("WSxSGen+1",nil,nil,"#show Raise Ally\n/use [@mouseover,exists][]Raise Ally\n/use Stolen Breath")
					EditMacro("WSxGen2",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use [harm,dead,nocombat]Corpse Exploder;[spec:1]Heart Strike;[spec:2,@mouseover,harm,nodead][spec:2]Howling Blast;[@mouseover,harm,nodead][]Scourge Strike\n/startattack\n/cancelaura Vrykul Drinking Horn")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/use [spec:1,talent:2/3]Consumption;Death Strike\n/use Gnomish X-Ray Specs\n/use [mod]Lichborne\n/cancelaura X-Ray Specs")
					EditMacro("WSxCSGen+2",nil,nil,"")
					EditMacro("WSxGen3",nil,nil,"#show\n/use [nocombat,noexists]Sack of Spectral Spiders;[spec:3,talent:4/3]Soul Reaper;[spec:3]Scourge Strike;[spec:2,talent:7/3]!Breath of Sindragosa;[spec:2]Obliterate;[spec:1]Marrowrend\n/startattack")
					EditMacro("WSxSGen+3",nil,nil,"/use [spec:2,talent:6/2]Hypothermic Presence;[spec:2,talent:6/3]Glacial Advance;[spec:3,@mouseover,harm,nodead][spec:3]Outbreak;[spec:1,@mouseover,harm,nodead][spec:1]Death's Caress;[spec:2]Howling Blast\n/startattack\n/stopspelltarget")
					EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noharm]Spirit Wand;[@focus,exists,harm,nodead,spec:3]Outbreak;[@focus,exists,harm,nodead,spec:2]Howling Blast\n/stopspelltarget")
					EditMacro("WSxGen4",nil,nil,"#show\n/use [spec:1]Death Strike;[spec:2]Obliterate;[spec:3]Festering Strike\n/startattack")
					EditMacro("WSxSGen+4",nil,nil,"#show [spec:3]Army of the Dead;Death and Decay\n/use [@focus,mod]Death Coil;[@cursor]Death and Decay\n/use [spec:1]Krastinov's Bag of Horrors\n/targetenemy [noexists]")
					EditMacro("WSxCSGen+4",nil,nil,"/use \n/use [@pet,pet,nodead]Death Coil\n/use [nocombat]Lilian's Warning Sign")
					EditMacro("WSxGen5",nil,nil,"#show\n/use [mod:ctrl,@cursor]Anti-Magic Zone;[spec:2]Frost Strike;[spec:1,talent:4/3]Mark of Blood;[@mouseover,exists,nodead][]Death Coil\n/startattack\n/cleartarget [dead]\n/use [nospec:2]Aqir Egg Cluster")
					EditMacro("WSxSGen+5",nil,nil,"#show\n/use [spec:3,talent:2/3,nomod]Unholy Blight;[@player,mod][@mouseover,exists,nodead][]Death Coil\n/use Angry Beehive\n/startattack\n/use [mod]Lichborne")
					EditMacro("WSxCSGen+5",nil,nil,"/clearfocus [dead]\n/use Permanent Frost Essence\n/use Stolen Breath")
					EditMacro("WSxGen6",nil,nil,"#show\n/use [mod,spec:1]Dancing Rune Weapon;[mod,spec:2]Pillar of Frost;[mod,spec:3,@player]Army of the Dead;[spec:1]Heart Strike;[spec:3]Epidemic;[spec:2]Remorseless Winter;[spec:1]Dancing Rune Blade\n/use [mod:ctrl]Angry Beehive")
					EditMacro("WSxSGen+6",nil,nil,"#show Sacrificial Pact\n/use [@player]Death and Decay\n/use [noexists,nocombat,spec:1] Vial of Red Goo\n/stopspelltarget\n/cancelaura Secret of the Ooze")
					EditMacro("WSxQQ",nil,nil,"/use [mod:alt,@focus,harm,nodead]Asphyxiate;[mod:shift]Lichborne;[@mouseover,harm,nodead][]Mind Freeze")
					EditMacro("WSxStuns",nil,nil,"#show\n/use [mod:alt,spec:2]Blinding Sleet;[@focus,mod:alt,harm,nodead,pet]Gnaw;[@mouseover,harm,nodead][]Death Grip;\n/startattack\n/petattack [mod:alt,@focus,exists,nodead]")
					EditMacro("WSxRTS",nil,nil,"#show\n/use [mod:ctrl]!Wraith Walk;[@mouseover,exists,nodead,spec:1,mod:shift][spec:1,mod:shift]Gorefiend's Grasp;[mod:alt,@focus,harm,nodead][nomod:alt,@mouseover,harm,nodead][nomod:alt]Chains of Ice\n/targetenemy [noexists]")
					EditMacro("WSxClassT",nil,nil,"#show Dark Command\n/use [spec:1]Blood Tap;[spec:2]Sacrificial Pact"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]\n/petattack [@mouseover,exists,nodead][]")
					EditMacro("WSxGenF",nil,nil,"#show Raise Dead\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@focus,harm,nodead]Death Grip;[mod:alt]Legion Communication Orb;[@focus,harm,nodead]Mind Freeze;Fishing\n/petattack [mod:alt,@focus,harm,nodead]")
					EditMacro("WSxCGen+F",nil,nil,"#show\n/use [spec:2,talent:2/3]Horn of Winter;[spec:1]Vampiric Blood;[pet]Huddle")
					EditMacro("WSxGG",nil,nil,"/use [mod:alt,@focus,harm,nodead]Death Grip;[mod:alt]S.F.E. Interceptor;[spec:3,nopet]Raise Dead;[@mouseover,harm,nodead,spec:3][spec:3,pet]Leap;[spec:1]Rune Tap;Death Grip")
					EditMacro("WSxDef",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;[@player,mod]Anti-Magic Zone;Icebound Fortitude")
					EditMacro("WSxGND",nil,nil,"#show\n/use [mod:alt]Runeforging;[mod:ctrl,exists,nodead]Control Undead;[mod:ctrl]Death Gate;Anti-Magic Shell;")
					EditMacro("WSxCC",nil,nil,"/use [mod]Raise Dead\n/use [nospec:1,mod]Sacrificial Pact;[mod]Death Pact;[spec:2,talent:3/3]Blinding Sleet;[spec:2,notalent:3/2,talent:2/3]Horn of Winter;[spec:3,pet,notalent:3/3]Leap;[spec:3,talent:3/3][spec:2,talent:3/2][spec:1]Asphyxiate;Death Grip")
					EditMacro("WSxMove",nil,nil,"#show\n/use !Death's Advance\n/use Syxsehnz Rod\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[nomod]Path of Frost\n/use [swimming]Barnacle-Encrusted Gem\n/use [mod]Weathered Purple Parasol")
					if playerspec == 1 then
						EditMacro("WSxCGen+4",nil,nil,"#show\n/use [talent:7/3]Bonestorm\n/use For da Blood God!\n/startattack")
						EditMacro("WSxSGen+F",nil,nil,"#show\n/use [spec:1,talent:3/3]Blood Tap")
						EditMacro("WSxGen7",nil,nil,"/use [mod:shift]Raise Dead\n/use [mod:shift]Sacrificial Pact;Blood Boil\n/use [nocombat]Champion's Salute")
					elseif playerspec == 2 then						
						EditMacro("WSxCGen+4",nil,nil,"#show\n/use Empower Rune Weapon\n/use [combat]Will of Northrend\n/startattack")
						EditMacro("WSxSGen+F",nil,nil,"#show\n/use Raise Dead")
						EditMacro("WSxGen7",nil,nil,"/use [mod:shift]Raise Dead\n/use [mod:shift]Sacrificial Pact;[talent:4/3]Frostscythe;Pillar of Frost\n/use [nocombat]Champion's Salute")
					else						
						EditMacro("WSxCGen+4",nil,nil,"#show\n/cast [talent:7/3]Unholy Assault;[talent:7/2]Summon Gargoyle;Apocalypse\n/use [combat]Will of Northrend\n/startattack")
						EditMacro("WSxSGen+F",nil,nil,"#show Claw\n/use [nocombat,mod:alt]Gastropod Shell;[spec:3,pet,@focus,harm,nodead][spec:3,pet,harm,nodead]Dark Transformation\n/use [spec:3,pet,@focus,harm,nodead][spec:3,pet,harm,nodead]!Leap\n/petautocasttoggle [mod:alt]Claw")
						EditMacro("WSxGen7",nil,nil,"#show [spec:3]Death and Decay\n/use [mod:shift,pet]Sacrificial Pact;[nopet]Raise Dead;Dark Transformation\n/use [nocombat]Champion's Salute")
					end
				-- Warrior, warror
				elseif class == "WARRIOR" then	
					EditMacro("WSxSGen+2",nil,nil,"#show\n/use Victory Rush\n/use [noexists,nocombat,nochanneling]Gnomish X-Ray Specs\n/targetenemy [noharm]\n/startattack")
					EditMacro("WSkillbomb",nil,nil,"#show Charge\n/use Flippable Table\n/use Bloodbath\n/use Dragon Roar"..dpsRacials[race].."\n/use Avatar\n/use Recklessness"..hasHE.."\n/use Will of Northrend\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
					EditMacro("WSxT15",nil,nil,"#show [spec:1,talent:1/3]Skullsplitter;Hamstring\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#show Battle Shout\n/use [spec:3]Last Stand\n/use Outrider's Bridle Chain"..oOtas)
					EditMacro("WSxT45",nil,nil,"#show [spec:2,talent:3/3]Onslaught;[spec:1,talent:3/3]Rend;[spec:3]Demoralizing Shout;Execute\n/use [spec:3]Demoralizing Shout;[@mouseover,harm,nodead][]Intimidating Shout\n/startattack\n/targetenemy")
					EditMacro("WSxT60",nil,nil,"#show\n/use [spec:1,talent:4/3,nomod]Defensive Stance\n/use Sylvanas' Music Box\n/run PetDismiss();\n/cry")
					EditMacro("WSxT90",nil,nil,"#show [spec:1,talent:6/2]Avatar;[spec:1,talent:6/3]Deadly Calm;[spec:2,talent:6/2]Dragon Roar;[spec:2,talent:6/3]Bladestorm;[spec:3,talent:6/3]Ravager;Whirlwind\n/use [nocombat,noexists]Blight Boar Microphone;Taunt\n/targetenemy [noexists]")
					EditMacro("WSxT100",nil,nil,"#show [spec:1]Bladestorm;[spec:2,talent:7/3]Siegebreaker;Execute")
					EditMacro("WSxCSGen+G",nil,nil,"#show [nospec:3]Piercing Howl;Intimidating Shout\n/use Burning Blade")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]"..glider..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..brazier)
					-- EditMacro("WSxCAGen+F",nil,nil,"#show Rallying Cry\n/use [nocombat]Throbbing Blood Orb\n/stopmacro [combat,exists]\n/equipset "..EQS[playerspec].."\n/run local _,d,_=GetItemCooldown(39769) if d==0 then EquipItemByName(39769) end\n/use 16")
					EditMacro("WSxCAGen+F",nil,nil,"#show Rallying Cry\n/use [nocombat]Throbbing Blood Orb\n/stopmacro [combat,exists]\n/run local _,d=GetItemCooldown(39769) if d==0 then EquipItemByName(39769) else C_EquipmentSet.UseEquipmentSet(C_EquipmentSet.GetEquipmentSetID(\""..EQS[playerspec].."\")) end\n/use 16")
					-- EditMacro("WSxCAGen+F",nil,nil,"#show Rallying Cry\n/use [nocombat]Throbbing Blood Orb\n/stopmacro [combat,exists]\n/run local _,d=GetItemCooldown(39769) if d~=0 then C_EquipmentSet.UseEquipmentSet(C_EquipmentSet.GetEquipmentSetID("..EQS[playerspec]..")) else EquipItemByName(39769) end\n/use 16")
					EditMacro("WSxGen+B",nil,nil,"#show\n/use [spec:1,equipped:Shields]Sweeping Strikes;[spec:1,talent:5/3]Cleave;Intervene")
					EditMacro("WSxCAGen+B",nil,nil,"")
					EditMacro("WSxGen+N",nil,nil,"#show\n/use Challenging Shout")
					EditMacro("WSxCAGen+N",nil,nil,"")
					EditMacro("WSxSGen+H",nil,nil,"#show [spec:1,talent:4/3]Defensive Stance;Whirlwind\n/use [nomounted]Darkmoon Gazer\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\"); else DoEmote(\"kneel\") end end")
					
					local EquipmentSets = {"DoubleGate", "Menkify!"}
					local OffHands = {}
					for i, SetName in ipairs(EquipmentSets) do
						local SetID = C_EquipmentSet and C_EquipmentSet.GetEquipmentSetID(SetName)
						if not SetID then return end

						local ItemLocations = C_EquipmentSet.GetItemLocations(SetID)
						local OffHand = ItemLocations[17] or 1

						if OffHand > 1 then 
							-- Om mh är <= 1 så finns det ingen location att hämta
						    -- https://wowpedia.fandom.com/wiki/API_EquipmentManager_UnpackLocation
						    local player, bank, _, void, slot, bag = EquipmentManager_UnpackLocation(OffHand)
						    if player and bag then 
						        local itemID = select(10, GetContainerItemInfo(bag, slot))
						        if itemID then
							        OffHands[EquipmentSets[i]] = GetItemInfo(itemID)
						       	end
						    elseif player then 
						        local itemID = GetInventoryItemID("player", slot)
						        OffHands[EquipmentSets[i]] = GetItemInfo(itemID)
						    end
						end
					end

					EditMacro("WSxGen1",nil,nil,"#show\n/use [nocombat,help]Corbyn's Beacon;[spec:1]Colossus Smash;[spec:2]Rampage;[spec:3]Shield Block\n/targetenemy [noexists]\n/startattack\n/use Chalice of Secrets" .. (OffHands["DoubleGate"] and ("\n/equipslot [equipped:Shields,spec:2] 17 " .. OffHands["DoubleGate"]) or ""))
					EditMacro("WSxSGen+1",nil,nil,"/use Ignore Pain\n/use Chalice of Secrets\n/targetexact Aerylia")
					EditMacro("WSxGen2",nil,nil,"/use [nocombat,noexists]Vrykul Drinking Horn;[spec:1]Mortal Strike;[spec:2]Bloodthirst;[spec:3]Devastate\n/targetenemy [noexists]\n/cleartarget [noharm]\n/startattack\n/cancelaura Vrykul Drinking Horn\n/equipset [equipped:Shields,spec:1]Noon!")
					EditMacro("WSxCSGen+2",nil,nil,"")
					EditMacro("WSxGen3",nil,nil,"#show\n/use Execute\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]\n/use Burning Blade")
					EditMacro("WSxSGen+3",nil,nil,"/use [spec:1,talent:3/3]Rend;[spec:2,talent:6/2][spec:3,talent:3/3]Dragon Roar;[spec:2,talent:6/3][spec:1]Bladestorm;[spec:3]Thunder Clap;Whirlwind\n/startattack")
					EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Rend;Vrykul Toy Boat;")
					EditMacro("WSxGen4",nil,nil,"#show\n/use [spec:1]Overpower;[spec:3][equipped:Shields,spec:2]Shield Slam;[spec:2]Raging Blow\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
					EditMacro("WSxSGen+4",nil,nil,"#show\n/use [spec:3]Shockwave;[spec:1,talent:1/3]Skullsplitter;[spec:2,talent:7/3]Siegebreaker\n/use Muradin's Favor\n/startattack")
					EditMacro("WSxCGen+4",nil,nil,"#show\n/use [spec:1,talent:6/2][spec:3]Avatar;[spec:1,talent:6/3]Deadly Calm;[spec:2]Recklessness\n/startattack\n/cleartarget [dead]\n/use [nocombat,noexists]Tosselwrench's Mega-Accurate Simulation Viewfinder")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@party1,help,nodead][@targettarget,help,nodead]Intervene")
					EditMacro("WSxGen5",nil,nil,"/use [mod]Rallying Cry;[spec:2,talent:3/3]Onslaught;[spec:3]Revenge;Slam\n/startattack\n/cleartarget [dead]\n/stopmacro [nomod]\n/use [mod]Gamon's Braid\n/roar")
					EditMacro("WSxSGen+5",nil,nil,"#show\n/use [spec:1,talent:7/3,@cursor][spec:3,talent:6/3,@cursor]Ravager;[spec:1]Bladestorm;[spec:2]Slam;Whirlwind\n/startattack")
					EditMacro("WSxCSGen+5",nil,nil,"//use [@party2,help,nodead][@targettarget,help,nodead]Intervene")
					EditMacro("WSxGen6",nil,nil,"#show [spec:3]Thunder clap;Whirlwind;\n/use [spec:2,talent:6/3,mod:ctrl][spec:1,mod:ctrl]Bladestorm;[spec:3,talent:6/3,mod:ctrl]Avatar;[nospec:3]Whirlwind;[spec:3]Thunder Clap\n/startattack\n/use Words of Akunda")
					EditMacro("WSxSGen+6",nil,nil,"#show Shield Block\n/use [spec:3,talent:6/3,@player][spec:1,talent:7/3,@player]Ravager;[spec:2]Rampage;[spec:3]Shield Block;Sweeping Strikes\n/targetenemy [noexists,nospec:2]\n/targetenemy [spec:2]\n/startattack")
					EditMacro("WSxGen7",nil,nil,"/use [mod]Shield Block;[equipped:Shields,nospec:3]Shield Slam;[spec:2,talent:6/2]Dragon Roar;[spec:2,talent:6/3]Bladestorm;[spec:1]Sweeping Strikes;Whirlwind\n/startattack" .. (OffHands["Menkify!"] and ("\n/equipslot [noequipped:Shields,mod] 17 " .. OffHands["Menkify!"]) or "")) 
					EditMacro("WSxQQ",nil,nil,"#show Pummel\n/use [mod:alt,@focus,exists,nodead]Storm Bolt;[mod:shift]Berserker Rage;[@mouseover,harm,nodead,nomod]Charge\n/use [@mouseover,harm,nodead,nomod][nomod]Pummel\n/use Mote of Light\n/use World Shrinker")
					EditMacro("WSxStuns",nil,nil,"#show\n/use [@mouseover,harm,nodead][]Charge\n/use [noexists,nocombat]Arena Master's War Horn\n/startattack\n/cleartarget [dead][help]\n/targetenemy [noharm]\n/use Prismatic Bauble")
					EditMacro("WSxRTS",nil,nil,"#show Heroic Throw\n/use [nomod,@mouseover,help,nodead][nomod,help,nodead]Intervene;[mod:alt,@focus,harm,nodead][nomod,@mouseover,harm,nodead][nomod]Hamstring;[nospec:3,mod]Piercing Howl;[mod]Intimidating Shout\n/startattack")
					EditMacro("WSxClassT",nil,nil,"#show Taunt\n/use [@mouseover,harm,nodead]Heroic Throw;Heroic Throw"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]\n/use Blight Boar Microphone")
					EditMacro("WSxGenF",nil,nil,"#show Berserker Rage\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Pummel;Survey;")
					EditMacro("WSxSGen+F",nil,nil,"/use [@focus,harm,nodead]Charge\n/use [@focus,harm,nodead]Pummel\n/use [nocombat,noexists,mod:alt] Gastropod Shell;Faintly Glowing Flagon of Mead")
					EditMacro("WSxCGen+F",nil,nil,"#show\n/use [nospec:3]Intervene;Demoralizing Shout")
					EditMacro("WSxGG",nil,nil,"#show\n/use [mod:alt]S.F.E. Interceptor;[@mouseover,harm,nodead][]Shattering Throw\n/targetenemy [noharm]")
					EditMacro("WSxDef",nil,nil,"#show\n/use [mod,spec:1,talent:4/3]Defensive Stance;[spec:1]Die By The Sword;[spec:2]Enraged Regeneration;Shield Wall\n/use Stormforged Vrykul Horn\n/use [mod:alt]Gateway Control Shard")
					EditMacro("WSxGND",nil,nil,"#show\n/use [nomod,spec:3]Last Stand;[nomod]Spell Reflection\n/targetfriend [mod:shift,nohelp]\n/use [mod:shift,help,nodead]Intervene\n/targetlasttarget [mod:shift]")
					EditMacro("WSxCC",nil,nil,"#show [spec:1/2]Intimidating Shout;Spell Reflection\n/use [mod:ctrl]Intimidating Shout;Spell Reflection\n/use Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
					EditMacro("WSxMove",nil,nil,"/use [@cursor]Heroic Leap\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[nomod]Heroic Leap\n/use [swimming]Barnacle-Encrusted Gem\n/use [mod]Weathered Purple Parasol")
				-- Druid, dodo
				elseif class == "DRUID" then
					EditMacro("WSxT30",nil,nil,"#show [talent:2/3]Wild Charge;[talent:2/2]Renewal\n/use [talent:2/1]Renewal;Swiftmend\n/use Nature's Swiftness\n/use [nocombat]Mylune's Call"..oOtas)
					EditMacro("WSxT45",nil,nil,"#show\n/use [mod,@player]Ursol's Vortex;[talent:4/1]Mighty Bash;[talent:4/2]Mass Entanglement;Heart of the Wild\n/use [nomod]!Prowl")
					EditMacro("WSxT60",nil,nil,"#show [nospec:1,talent:3/1]Typhoon;[spec:3/4,talent:3/2][spec:1,talent:3/1]Maim;[spec:4,talent:3/3][spec:1/2,talent:3/2]Incapacitating Roar;[nospec:4,talent:3/3]Ursol's Vortex\n/run PetDismiss();\n/cry")
					EditMacro("WSxT90",nil,nil,"#show [spec:1,talent:6/3]Stellar Flare;[spec:2,talent:6/3]Primal Wrath;Swipe\n/use [noform:1]Bear form(Shapeshift);Growl\n/use [spec:3]Highmountain War Harness\n/cancelaura [noform:1]Highmountain War Harness")
					EditMacro("WSxT100",nil,nil,"#show [spec:1,talent:7/1]Fury of Elune;[spec:4,talent:7/3]Flourish;[spec:3,talent:7/3]Pulverize;[spec:3,talent:7/2]Lunar Beam;Prowl")
					EditMacro("WSxCSGen+G",nil,nil,"#show Dash\n/use [spec:4,@focus,help,nodead]Nature's Cure;[@focus,help,nodead]Remove Corruption")
					EditMacro("WSxT15",nil,nil,"#show [spec:1,talent:1/3]Force of Nature;[spec:1,talent:1/2]Warrior of Elune;[spec:4,talent:1/2]Nourish;[spec:4,talent:1/3]Cenarion Ward;[spec:3,noform:1,talent:1/2]Bear Form(Shapeshift);[spec:3,talent:1/2]Bristling Fur\n/use "..invisPot)
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/cancelaura Flap\n/use [mod:alt]Jeeves;[mod:ctrl]"..glider..";[mod]6;[nocombat]Revive;"..pwned.."\n/use [mod:ctrl]Revitalize"..brazier)
					EditMacro("WSxSGen+H",nil,nil,"/use [spec:4]Nature's Swiftness;Wisp Amulet\n/stopmacro [combat]\n/run if not (IsControlKeyDown()) then if IsMounted() or GetShapeshiftFormID() ~= nil then DoEmote(\"mountspecial\"); else DoEmote(\"kneel\") end end")
					EditMacro("WSxSGen+F",nil,nil,"/cancelform [mod:alt]\n/use [mod:alt,nocombat]Gastropod Shell;[nomod,form:3/6,talent:2/3]Wild Charge;[nomod,noform:3/6]Travel Form(Shapeshift)\n/stopspelltarget\n/use Prismatic Bauble")
					EditMacro("WSxClassT",nil,nil,"#show Growl\n/use [@mouseover,harm,nodead][]Cyclone;"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxStuns",nil,nil,"/use [talent:2/3,help,nodead,noform][talent:2/3,form:1/2]Wild Charge\n/use [spec:2,talent:5/3,noform:1][nocombat,noform:1]!Prowl;[combat,noform:1/2]Bear Form(Shapeshift)\n/targetenemy [noexists]\n/cancelform [help,nodead]\n/use [nostealth]Prismatic Bauble")
					EditMacro("WSxQQ",nil,nil,"/use [mod:alt,@focus,harm,nodead]Cyclone;[spec:4,@cursor]Ursol's Vortex;[spec:2,noform:1/2]Cat Form;[spec:3,noform:1/2]Bear Form(Shapeshift);[@mouseover,harm,nodead,spec:2/3,form:1/2][spec:2/3,form:1/2]Skull Bash;[@mouseover,harm,nodead][]Solar Beam")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@focus,spec:4,help,nodead][@party1,help,nodead,spec:4]Lifebloom;[noform:2]!Cat Form\n/stopmacro [noform:2]\n/run SetTracking(3,true);") 
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,spec:4,help,nodead][@party2,help,nodead,spec:4]Lifebloom;[noform:2]!Cat Form\n/use Battle Standard of Coordination\n/run SetTracking(4,true);")
					EditMacro("WSxCGen+F",nil,nil,"#show [spec:2/3]Stampeding Roar;[spec:1/4]Innervate\n/use Mushroom Chair\n/run SetTracking(2,false);SetTracking(3,false);SetTracking(4,false);")
					EditMacro("WSxSGen+1",nil,nil,"#show [spec:4]Tranquility;Regrowth\n/use [mod:alt,@party3,nodead][mod,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Regrowth;Kalytha's Haunted Locket")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/cancelaura X-Ray Specs\n/use [mod,@party4,nodead][@mouseover,help,nodead][]Regrowth\n/use Gnomish X-Ray Specs")
					EditMacro("WSxCSGen+2",nil,nil,"/use [spec:4,@focus,help,nodead][spec:4,@party1,help,nodead]Nature's Cure;[@focus,help,nodead][@party1,help,nodead]Remove Corruption\n/use [nocombat]Spirit of Bashiok")
					EditMacro("WSxCSGen+3",nil,nil,"/use [@party2,help,nodead,spec:4,nomod]Nature's Cure;[@party2,help,nodead,nomod]Remove Corruption\n/use [@party1,help]Innervate\n/use [@party2,help]Innervate\n/use [@party3,help]Innervate\n/use [@party4,help]Innervate")
					EditMacro("WSxCGen+4",nil,nil,"#show\n/use [@party3,help,nodead,mod:alt]Rejuvenation;[spec:1,noform:4]Moonkin Form;[spec:1,talent:7/2]Fury of Elune;[spec:1,talent:7/3]New Moon;[spec:2,talent:5/2]Savage Roar;[spec:4,@cursor]Efflorescence;[spec:3]Incapacitating Roar")	
					EditMacro("WSxSGen+6",nil,nil,"#show\n/use [@mouseover,help,nodead,talent:3/3][@mouseover,help,nodead,spec:4][talent:3/3][spec:4]Wild Growth;[@player,spec:1]Starfall;Kaldorei Wind Chimes")
					EditMacro("WSxGen7",nil,nil,"/use [mod,spec:4,@player]Efflorescence;[spec:4,talent:7/3]Flourish;[spec:4,talent:3/2,noform:2]!Cat Form;[spec:2,talent:6/3]Primal Wrath;[form:2,spec:4,talent:3/2]Rake;[nospec:2]Barkskin;Swipe")
					EditMacro("WSxGenF",nil,nil,"#show Stampeding Roar\n/focus [@mouseover,exists]mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[spec:1,@focus,harm,nodead]Solar Beam;[@focus,harm,nodead,form:1/2]Skull Bash;Charm Woodland Creature\n/use Survey")
					EditMacro("WSxCAGen+F",nil,nil,"#show [spec:4]Nature's Swiftness;[nospec:2]Barkskin;Primal Fury\n/use [nocombat,noexists]Tear of the Green Aspect\n/targetfriend [nohelp,nodead]\n/cancelform [help,nodead]\n/use [help,nodead]Wild Charge\n/targetlasttarget\n/use Prismatic Bauble")
					EditMacro("WSxGG",nil,nil,"/use [nocombat,noexists,mod]Darkmoon Gazer;[mod]Stampeding Roar;[@mouseover,harm,nodead]Soothe;[spec:4,@mouseover,help,nodead][spec:4]Nature's Cure;[@mouseover,help,nodead][]Remove Corruption\n/use Poison Extraction Totem")
					EditMacro("WSxDef",nil,nil,"#show\n/use [mod:alt]Nature's Beacon;[mod][spec:1]Barkskin;[@mouseover,help,nodead,spec:4][spec:4]Ironbark;[spec:2/3]Survival Instincts\n/use [mod:alt]Gateway Control Shard")
					EditMacro("WSxMove",nil,nil,"/use [talent:2/2]Renewal;[spec:1,noform:4][talent:2/3,talent:3/1,noform:4]Moonkin Form;[talent:2/1]Dash;[@mousever,exists,nodead][]Wild Charge\n/use Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble\n/use Sparkle Wings")
					EditMacro("Wx5Trinket2",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod,@party4,help,nodead]Rejuvenation;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14\n/use Eternal Black Diamond Ring")
					local dOH = "Teleport: Moonglade"
					if IsSpellKnown(193753) == true then
						dOH = "Dreamwalk"
					end

					-- Block for Healer-Innervate secure pre-parser
					local healer = "help,nodead" 
					for i = 1, 5 do 
						if UnitGroupRolesAssigned("party"..i) == "HEALER" then 
							healer = "@".."party"..i 
							-- print(healer)
						end 
					end
						
					if playerspec == 1 then
						EditMacro("WSkillbomb",nil,nil,"#show\n/use Celestial Alignment"..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use [@cursor]Force of Nature\n/use Big Red Raygun\n/use Echoes of Rezan")
						EditMacro("WSxGen3",nil,nil,"#show\n/use [talent:3/1,form:2]Rake;Starsurge\n/targetenemy [noexists]\n/use Desert Flute")
						EditMacro("WSxSGen+3",nil,nil,"/use [talent:3/1,noform:2]!Cat Form;[talent:3/1,form:2]Rip;[talent:3/2,noform:1]!Bear Form;[talent:3/2,form:1]Thrash;Moonfire\n/use [talent:3/1,nocombat]!Prowl")
						EditMacro("WSxGen4",nil,nil,"/use [form:2]Shred;[form:1]Mangle;[form:4,@mouseover,harm,nodead][]Starfire\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,nostealth,noform:1]!Prowl")
						EditMacro("WSxSGen+4",nil,nil,"/use [@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Rejuvenation;[noform:4]Moonkin Form;[@mouseover,harm,nodead,talent:6/3][talent:6/3]Stellar Flare;[talent:7/3]New Moon;[talent:7/2]Fury of Elune;Charm Woodland Creature\n/targetenemy [noexists]")
						EditMacro("WSxGen5",nil,nil,"#show\n/use [mod:ctrl]Treant Form;[form:2]Ferocious Bite;[form:1]Ironfur;Wrath\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxGen6",nil,nil,"/use [mod]Celestial Alignment;[form:2]Swipe;[form:1,talent:3/2]Thrash;[@cursor]Starfall")
						EditMacro("WSxGND",nil,nil,"/use [mod:alt]Mount Form;[noform:2,mod:shift]!Cat Form;[mod:shift]Dash;[mod,harm,nodead]Hibernate;[mod]"..dOH..";[form:1]Ironfur;[@mouseover,help,talent:3/3][talent:3/3]Swiftmend\n/stopmacro [stealth]\n/use Path of Elothir\n/use Prismatic Bauble")
						EditMacro("WSxCC",nil,nil,"/use [mod:shift,"..healer.."]Innervate;[@mouseover,harm,nodead,mod][mod]Entangling Roots;[talent:3/2,noform:1]Bear Form;[talent:3/2,form:1]Frenzied Regeneration;[@mouseover,help,nodead,talent:3/3][noform:1,talent:3/3]Rejuvenation\n/use Totem of Spirits")
						EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[noform:4]Moonkin Form;!Flap\n/cancelform [form:1/2]\n/cancelaura Prowl\n/use [mod]Weathered Purple Parasol\n/use [nomod,nostealth,form]Seafarer's Slidewhistle")
						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod,@\"..B..\"]Innervate;[@\"..B..\"]Regrowth\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod,@\"..N..\"]Innervate;[@\"..N..\"]Regrowth\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
						EditMacro("WSxGen+B",nil,nil,"#show Dash\n/use [@focus,mod,help,nodead][@party1,help,nodead,mod]Swiftmend;[@focus,help,nodead][@party1,help,nodead]Swiftmend")
						EditMacro("WSxGen+N",nil,nil,"#show Innervate\n/use [@focus,mod,help,nodead][@party2,help,nodead,mod]Swiftmend;[@focus,help,nodead][@party2,help,nodead]Swiftmend")
						EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,dead][help,dead]Rebirth;[@mouseover,help,nodead][help,nodead]Innervate;[@mouseover,harm,nodead][harm,nodead]Moonfire;Druid and Priest Statue Set\n/use [nocombat,noform:1/4]!Prowl\n/targetenemy [noexists]")
						EditMacro("WSxGen2",nil,nil,"/use [@mouseover,harm,nodead][harm,nodead]Sunfire;Moonfeather Statue\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxRTS",nil,nil,"/cancelform [talent:2/3,form,@mouseover,help,nodead]\n/use [mod:ctrl]Stampeding Roar;[talent:3/3,@cursor,mod]Ursol's Vortex;[talent:3/2,mod]Incapacitating Roar;[talent:2/3,noform,@mouseover,help,nodead]Wild Charge;Typhoon")
						EditMacro("WSxSGen+5",nil,nil,"/use [@party2,help,nodead,mod]Rejuvenation;[nocombat,help,nodead]Corbyn's Beacon;[talent:1/3,@cursor]Force of Nature;[talent:1/2]Warrior of Elune;Starfall")
					elseif playerspec == 2 then
						EditMacro("WSkillbomb",nil,nil,"#show\n/use Berserk"..dpsRacials[race].."\n/use Will of Northrend\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
						EditMacro("WSxGen3",nil,nil,"#show\n/use [form:2]Rip;[talent:3/1,noform][talent:3/1,form:4]Starsurge;[talent:3/2,form:1]Frenzied Regeneration;[@mouseover,help,nodead][]Regrowth\n/targetenemy [noexists]\n/use Desert Flute")
						EditMacro("WSxSGen+3",nil,nil,"/use [noform:2]!Cat Form;[form:2]Thrash\n/use [nocombat]!Prowl;")
						EditMacro("WSxGen4",nil,nil,"/use [talent:3/2,noform:1/2]Bear Form;[form:1]Thrash;[form:2]Rake;[talent:3/1,noform:4]Moonkin Form;[talent:3/1,form:4]Starfire\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,nostealth,noform:1]!Prowl")
						EditMacro("WSxSGen+4",nil,nil,"/use [@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Rejuvenation;[noform:2]Cat Form;Tiger's Fury\n/use [nocombat,nostealth]Bloodmane Charm\n/use !Prowl\n/targetenemy [noexists]")
						EditMacro("WSxGen5",nil,nil,"#show\n/use [mod:ctrl]Treant Form;[talent:3/1,form:4]Wrath;[form:1]Ironfur;[noform]!Cat Form;[form:1]Thrash;[form:2]Ferocious Bite\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxGen6",nil,nil,"/use [mod]Berserk;[noform:1/2]Cat form;[talent:6/2,form:1]Thrash;[form:1/2]Swipe\n/use Hunter's Call")
						EditMacro("WSxGND",nil,nil,"/use [mod:alt]Mount Form;[noform:2,mod:shift]!Cat Form;[mod:shift]Dash;[mod,harm,nodead]Hibernate;[mod]"..dOH..";[form:1]Ironfur;[@mouseover,help,talent:3/3][talent:3/3]Swiftmend\n/stopmacro [stealth]\n/use Path of Elothir\n/use Prismatic Bauble")
						 EditMacro("WSxCC",nil,nil,"/use [@mouseover,harm,nodead,mod][mod]Entangling Roots;[talent:3/2,noform:1]Bear Form;[form:1,talent:3/2]Frenzied Regeneration;[@mouseover,help,nodead,talent:3/3][noform:1,talent:3/3]Rejuvenation;Entangling Roots\n/use Totem of Spirits")
						EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[talent:3/1,noform:4]Moonkin Form;[talent:3/1]!Flap;[noform]Mount Form;[talent:2/3,form]Wild Charge\n/cancelform [form:1/2]\n/use [mod]Weathered Purple Parasol\n/use [nomod,nostealth,form]Seafarer's Slidewhistle")
						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Regrowth;[@\"..B..\"]Regrowth\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Regrowth;[@\"..N..\"]Regrowth\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
						EditMacro("WSxGen+B",nil,nil,"#show Dash\n/use [@focus,mod,help,nodead][@party1,help,nodead,mod]Swiftmend;[@focus,help,nodead][@party1,help,nodead]Swiftmend")
						EditMacro("WSxGen+N",nil,nil,"#show Hibernate\n/use [@focus,mod,help,nodead][@party2,help,nodead,mod]Swiftmend;[@focus,help,nodead][@party2,help,nodead]Swiftmend")
						EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,dead][help,dead]Rebirth;[form:2,notalent:1/3]Rake;[@mouseover,harm,nodead][harm,nodead]Moonfire;Druid and Priest Statue Set\n/use [nocombat,noform:1/4]!Prowl\n/targetenemy [noexists]")
						EditMacro("WSxGen2",nil,nil,"/use [nocombat,noexists]Moonfeather Statue;[form:2]Shred;[form:1]Mangle;[talent:3/1,noform:4]Moonkin Form;[@mouseover,harm,nodead,talent:3/1,form:4][talent:3/1,form:4,harm,nodead]Sunfire;[noform:2]!Cat Form\n/targetenemy [noexists]") 
						EditMacro("WSxRTS",nil,nil,"/cancelform [talent:2/3,form,@mouseover,help,nodead]\n/use [mod:ctrl]Stampeding Roar;[talent:3/3,@cursor,mod]Ursol's Vortex;[talent:3/2,mod]Incapacitating Roar;[mod]Typhoon;[talent:2/3,noform,@mouseover,help,nodead]Wild Charge;Maim")
						EditMacro("WSxSGen+5",nil,nil,"/use [@party2,help,nodead,mod]Rejuvenation;[nocombat,help,nodead]Corbyn's Beacon;[talent:7/3]Feral Frenzy;Stampeding Roar")
					elseif playerspec == 3 then
						EditMacro("WSkillbomb",nil,nil,"#show\n/use Berserk"..dpsRacials[race].."\n/use Will of Northrend\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
						EditMacro("WSxGen3",nil,nil,"/use [talent:7/3,form:1]Pulverize;[talent:7/2]Lunar Beam;[form:2,talent:3/2]Rake;[talent:3/1,noform]Moonkin Form;[talent:3/1,form:4]Starsurge;[form:1]Frenzied Regeneration;[@mouseover,help,nodead][]Regrowth\n/targetenemy [noexists]\n/use Desert Flute")
						EditMacro("WSxSGen+3",nil,nil,"/use [talent:3/2,noform:2]!Cat Form;[talent:3/2,form:2]Rip;[noform:1]Bear Form(Shapeshift);Thrash\n/use [nocombat,talent:3/2]!Prowl;")
						EditMacro("WSxGen4",nil,nil,"/use [noform]Bear Form(Shapeshift);[form:1/2]Thrash;[talent:3/1,noform:4]Moonkin Form;[talent:3/1,form:4]Starfire\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxSGen+4",nil,nil,"/use [@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Rejuvenation;[noform:1]Bear Form(Shapeshift);[talent:1/3]Bristling Fur;Ironfur\n/use [nocombat,nostealth]Bloodmane Charm\n/targetenemy [noexists]")
						EditMacro("WSxGen5",nil,nil,"#show\n/use [mod:ctrl]Treant Form;[noform]Bear Form(Shapeshift);[form:1]Maul;[form:2]Ferocious Bite;[talent:3/1,form]Wrath\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxGen6",nil,nil,"/use [mod,talent:5/3]Berserk;[noform:1/2]Bear form(Shapeshift);[form:1/2]Swipe\n/use Hunter's Call")
						EditMacro("WSxGND",nil,nil,"/use [mod:alt]Mount Form;[noform:2,mod:shift]!Cat Form;[mod:shift]Dash;[mod,harm,nodead]Hibernate;[mod]"..dOH..";[form:1]Ironfur;[@mouseover,help,talent:3/3][talent:3/3]Swiftmend\n/stopmacro [stealth]\n/use Path of Elothir\n/use Prismatic Bauble")
						EditMacro("WSxCC",nil,nil,"/use [@mouseover,harm,nodead,mod][mod]Entangling Roots;[form:1]Frenzied Regeneration;[@mouseover,help,nodead,talent:3/3][noform:1,talent:3/3]Rejuvenation;[noform]Bear Form(Shapeshift);\n/use Totem of Spirits")
						EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[talent:3/1,noform:4]Moonkin Form;[talent:3/1]!Flap;[noform]Mount Form;[talent:2/3,form]Wild Charge\n/cancelform [form:1/2]\n/use [mod]Weathered Purple Parasol\n/use [nomod,nostealth,form]Seafarer's Slidewhistle")
						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Regrowth;[@\"..B..\"]Regrowth\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Regrowth;[@\"..N..\"]Regrowth\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
						EditMacro("WSxGen+B",nil,nil,"#show Dash\n/use [@focus,mod,help,nodead][@party1,help,nodead,mod]Swiftmend;[@focus,help,nodead][@party1,help,nodead]Swiftmend")
						EditMacro("WSxGen+N",nil,nil,"#show Hibernate\n/use [@focus,mod,help,nodead][@party2,help,nodead,mod]Swiftmend;[@focus,help,nodead][@party2,help,nodead]Swiftmend")
						EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,dead][help,dead]Rebirth;[@mouseover,harm,nodead][harm,nodead]Moonfire;Druid and Priest Statue Set\n/use [nocombat,noform:1/4]!Prowl\n/targetenemy [noexists]")
						EditMacro("WSxGen2",nil,nil,"/use [nocombat,noexists]Moonfeather Statue;[form:1]Mangle;[talent:3/1,noform:4]Moonkin Form;[talent:3/2,noform:2]!Cat Form;[form:2]Shred;[@mouseover,harm,nodead,talent:3/1,form:4][talent:3/1,form:4]Sunfire\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxRTS",nil,nil,"/cancelform [talent:2/3,form,@mouseover,help,nodead]\n/use [mod:ctrl]Stampeding Roar;[talent:3/3,@cursor,mod]Ursol's Vortex;[talent:3/1,mod]Typhoon;[talent:2/3,noform,@mouseover,help,nodead]Wild Charge;Incapacitating Roar")
						EditMacro("WSxSGen+5",nil,nil,"/use [@party2,help,nodead,mod]Rejuvenation;[nocombat,help,nodead]Corbyn's Beacon;[talent:4/1]Mighty Bash;[talent:4/2]Mass Entanglement;[talent:4/3]Heart of the Wild;Ursine Adept")
					else
						EditMacro("WSkillbomb",nil,nil,"#show\n/use [talent:5/3]!Incarnation: Tree of Life"..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
						EditMacro("WSxGen3",nil,nil,"#show\n/use [talent:3/1,noform:4]Moonkin Form;[talent:3/1,form:4]Starsurge;[form:2,talent:3/2]Rip;[@mouseover,help,nodead,talent:6/3][talent:6/3]Overgrowth;[@mouseover,help,nodead][]Regrowth\n/targetenemy [noexists]\n/use Desert Flute")
						EditMacro("WSxSGen+3",nil,nil,"/use [@mouseover,help,nodead][@focus,help,nodead][]Lifebloom")
						EditMacro("WSxGen4",nil,nil,"/use [form:2]Shred;[form:1]Mangle;[@mouseover,talent:3/1,form:4,harm,nodead][talent:3/1,form:4]Starfire;[@mouseover,help,nodead][]Regrowth\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxSGen+4",nil,nil,"/use [@focus,help,nodead,mod][@party1,help,nodead,mod]Rejuvenation;[noform:2]!Cat Form;[talent:3/2,form:2]Rake;[form:2]Shred\n/use [nocombat]!Prowl\n/targetenemy [noexists]")
						EditMacro("WSxGen5",nil,nil,"#show\n/use [mod,talent:5/3]!Incarnation: Tree of Life;[mod]Treant Form;[form:2]Ferocious Bite;[form:1]Ironfur;[@mouseover,help,nodead,talent:1/2][talent:1/2,noharm]Nourish;Wrath\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxGen6",nil,nil,"/use [mod]Tranquility;[talent:3/3,noform:1]Bear Form(Shapeshift);[talent:3/2,noform:2]!Cat Form;[form:1,talent:3/3]Thrash;[form:2,talent:3/2]Swipe;[@mouseover,help,nodead][]Sunfire")
						EditMacro("WSxGND",nil,nil,"/use [mod:alt]Mount Form;[noform:2,mod:shift]!Cat Form;[mod:shift]Dash;[mod,harm,nodead]Hibernate;[mod]"..dOH..";[form:1]Ironfur;[@mouseover,help,nodead][]Swiftmend\n/stopmacro [stealth]\n/use Path of Elothir\n/use Prismatic Bauble")	        
						EditMacro("WSxCC",nil,nil,"/use [mod:shift,noform:1/2]Innervate;[@mouseover,harm,nodead,mod][mod]Entangling Roots;[form:1,talent:3/3]Frenzied Regeneration;[@mouseover,help,nodead][]Rejuvenation\n/use Totem of Spirits\n/cancelform [mod:shift,form:1,talent:3/3]")
						EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[talent:3/1,noform:4]Moonkin Form;[talent:3/1]!Flap;[noform]Mount Form;[talent:2/3,form]Wild Charge\n/cancelform [form:1/2]\n/use [mod]Weathered Purple Parasol\n/use [nomod,nostealth,form]Seafarer's Slidewhistle")
						EditMacro("WSxGen+B",nil,nil,"#show Dash\n/use [@focus,mod,help,nodead][@party1,help,nodead,mod]Cenarion Ward;[@focus,help,nodead][@party1,help,nodead]Swiftmend")
						EditMacro("WSxGen+N",nil,nil,"#show Innervate\n/use [@focus,mod,help,nodead][@party2,help,nodead,mod]Cenarion Ward;[@focus,help,nodead][@party2,help,nodead]Swiftmend")
						-- ta bort cenarion ward @party12
						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Regrowth;[@\"..B..\"]Lifebloom\\n/stopspelltarget\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Regrowth;[@\"..N..\"]Lifebloom\\n/stopspelltarget\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
						EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,dead][help,dead]Rebirth;[@mouseover,help,nodead][help,nodead]Innervate;[@mouseover,harm,nodead][harm,nodead]Moonfire;Druid and Priest Statue Set\n/use [nocombat,noform:1/4]!Prowl\n/targetenemy [noexists]")
						EditMacro("WSxGen2",nil,nil,"/use [@mouseover,harm,nodead][harm,nodead][harm,nodead]Sunfire;Moonfeather Statue\n/targetenemy [noexists]\n/cleartarget [dead]") 
						EditMacro("WSxRTS",nil,nil,"/cancelform [talent:2/3,form,@mouseover,help,nodead]\n/use [mod:ctrl]Stampeding Roar;[talent:3/3,mod]Incapacitating Roar;[talent:3/1,mod]Typhoon;[talent:2/3,noform,@mouseover,help,nodead]Wild Charge;[@cursor]Ursol's Vortex")
						EditMacro("WSxSGen+5",nil,nil,"/use [@party2,help,nodead,mod]Rejuvenation;[nocombat,help,nodead]Corbyn's Beacon;[@mouseover,help,nodead,talent:1/2][talent:1/2]Nourish;[@mouseover,help,nodead,talent:1/3][talent:1/3]Cenarion Ward")
					end
				-- Demon Hunter, DH
				elseif class == "DEMONHUNTER" then
					EditMacro("WSxT15",nil,nil,"#show [talent:1/3]Felblade;[spec:2]Demon Spikes;Fel Rush\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#show [spec:2][spec:1,talent:2/3]Immolation Aura;Demon's Bite"..oOtas.."\n/use [mod:alt,spec:2,@player]Sigil of Misery")
					EditMacro("WSxT45",nil,nil,"#show [spec:2,talent:3/3]Spirit Bomb;[spec:2]Demon Spikes;[spec:1,talent:3/3]Glaive Tempest;Fel Rush\n/use [mod:alt,spec:2,@player]Sigil of Silence")
					EditMacro("WSxT90",nil,nil,"#show [spec:2,talent:6/3]Soul Barrier;[spec:1,talent:6/3]Fel Eruption;Throw Glaive\n/use [mod,spec:2,talent:5/3,@player]Sigil of Chains;[nocombat,noexists]Legion Invasion Simulator;Torment")
					EditMacro("WSxT100",nil,nil,"#show [spec:1,talent:7/3]Fel Barrage;[spec:2,talent:7/3]Bulk Extraction;Eye Beam")
					EditMacro("WSxCSGen+G",nil,nil,"#show\n/use [@focus,harm,nodead]Consume Magic\n/use Wisp Amulet")
					EditMacro("WSxT60",nil,nil,"#show [spec:1,talent:4/3]Netherwalk;[spec:2,talent:4/3]Fracture;Spire of Spite\n/use [nocombat,noexists]Spire of Spite\n/run PetDismiss();\n/cry")
					EditMacro("WSkillbomb",nil,nil,"/use [@player] Metamorphosis\n/use [@player]13\n/use 13"..dpsRacials[race].."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")         
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/cancelaura Glide\n/use [mod:alt]Jeeves;[mod:ctrl]"..glider..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..brazier)
					EditMacro("WSxSGen+H",nil,nil,"#show Spectral Sight\n/use Wisp Amulet\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\"); else DoEmote(\"kneel\") end end")
					EditMacro("WSxGen+B",nil,nil,"#show\n/use [spec:1,talent:4/3]Netherwalk;Glide;")
					EditMacro("WSxCAGen+B",nil,nil,"")
					EditMacro("WSxGen+N",nil,nil,"#show Glide")
					EditMacro("WSxCAGen+N",nil,nil,"")
					EditMacro("WSxGen1",nil,nil,"#show\n/use [spec:2]Demon Spikes;[spec:1]Fel Rush\n/targetenemy [noexists]\n/startattack\n/use Prismatic Bauble")
					EditMacro("WSxSGen+1",nil,nil,"#show Skull of Corruption\n/use [nocombat]Skull of Corruption")
					EditMacro("WSxGen2",nil,nil,"#show\n/use [nocombat,noexists]Verdant Throwing Sphere\n/targetlasttarget [noexists,nocombat]\n/use [harm,dead,nocombat,nomod]Soul Inhaler;[spec:1]Demon's Bite;[spec:2]Shear\n/cleartarget [dead]\n/targetenemy [noexists]\n/startattack")
					EditMacro("WSxSGen+2",nil,nil,"#show [spec:2]Fel Devastation;[spec:1,talent:6/3]Fel Eruption;Gnomish X-Ray Specs\n/use Gnomish X-Ray Specs\n/use [spec:2]Fel Devastation;[spec:1,talent:6/3]Fel Eruption\n/startattack\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxCSGen+2",nil,nil,"")
					EditMacro("WSxGen3",nil,nil,"#show\n/use [spec:1,talent:1/3][spec:2,talent:1/3]Felblade;[spec:2]Demon Spikes;[@mouseover,harm,nodead][]Throw Glaive\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]\n/use Imp in a Ball")
					EditMacro("WSxSGen+3",nil,nil,"#show\n/use [@mouseover,harm,nodead,nomod][nomod]Throw Glaive\n/use [nocombat]Legion Pocket Portal\n/targetenemy [noexists]\n/startattack\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Throw Glaive\n/targetlasttarget")
					EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noexists]The Perfect Blossom;[@focus,harm,nodead]Throw Glaive;Fel Petal;")
					EditMacro("WSxGen4",nil,nil,"#show\n/use [spec:2]Immolation Aura;Eye Beam\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]\n/cancelaura Netherwalk")
					EditMacro("WSxSGen+4",nil,nil,"#show\n/use [spec:2,talent:3/3]Spirit Bomb;[spec:1,talent:5/3]Essence Break;[spec:1,talent:3/3]Glaive Tempest;[spec:1,talent:6/3]Fel Eruption;[spec:2]Shear;Glide\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
					EditMacro("WSxCGen+4",nil,nil,"#show\n/use [spec:2,talent:7/3]Bulk Extraction;[spec:1,talent:7/3]Fel Barrage;[spec:1]Darkness;[spec:2]Fiery Brand;\n/targetenemy [noexists]\n/startattack")
					EditMacro("WSxCSGen+4",nil,nil,"")
					EditMacro("WSxGen5",nil,nil,"#show\n/use [spec:2,mod:ctrl]Metamorphosis;[mod:ctrl]Darkness;[spec:1]Chaos Strike;[spec:2]Soul Cleave\n/use [mod:ctrl]Shadescale\n/startattack\n/targetenemy [noexists]")
					EditMacro("WSxSGen+5",nil,nil,"#show\n/use [spec:2,@player]Infernal Strike;Chaos Nova\n/targetenemy [noexists]\n/startattack")
					EditMacro("WSxCSGen+5",nil,nil,"/clearfocus")
					EditMacro("WSxGen6",nil,nil,"#show\n/use [mod:ctrl,@cursor]Metamorphosis;[spec:2,@cursor]Sigil of Flame;Blade Dance\n/targetenemy [noexists]")
					EditMacro("WSxSGen+6",nil,nil,"#show [spec:1,talent:3/3]Glaive Tempest;Chaos Nova\n/use [spec:1,talent:3/3]Glaive Tempest;[spec:2,@player]Sigil of Flame;[spec:1]Blade Dance\n/stopspelltarget")
					EditMacro("WSxGen7",nil,nil,"#show\n/use [spec:2]Fel Devastation;Immolation Aura\n/targetenemy [noexists]")
					EditMacro("WSxQQ",nil,nil,"/use [mod:alt,@focus,harm,nodead]Imprison;[@mouseover,harm,nodead][]Disrupt")
					EditMacro("WSxStuns",nil,nil,"#show\n/use [mod:alt] !Spectral Sight; [spec:2,@cursor]Sigil of Silence; [spec:1]Chaos Nova;")
					EditMacro("WSxRTS",nil,nil,"#show [spec:2]Sigil of Misery;Throw Glaive\n/use [mod:ctrl,spec:2,talent:5/3,@player][mod:shift,spec:2,talent:5/3,@cursor]Sigil of Chains;[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Throw Glaive\n/startattack")
					EditMacro("WSxClassT",nil,nil,"#show [spec:2,talent:5/3]Sigil of Chains;Torment\n/use Throw Glaive"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxGenF",nil,nil,"#show Spectral Sight\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,exists,nodead]All-Seer's Eye;[mod:alt]Legion Communication Orb;[@focus,harm,nodead]Disrupt;[nocombat,noexists]Micro-Artillery Controller")
					EditMacro("WSxSGen+F",nil,nil,"#show Spectral Sight\n/cancelaura [mod:alt]Spectral Sight\n/use [nocombat,noexists]Gastropod Shell")
					EditMacro("WSxCGen+F",nil,nil,"#show [spec:2]Torment;[spec:1,talent:4/3]Netherwalk;Blur\n/cancelaura Wyrmtongue Disguise")
					EditMacro("WSxCAGen+F",nil,nil,"#show [spec:2,talent:5/3]Sigil of Chains;Fel Rush\n/run if not InCombatLockdown() then if GetSpellCharges(195072)>=1 then "..tpPants.." else "..noPants.." end end")
					EditMacro("WSxGG",nil,nil,"#show\n/use [mod:alt]S.F.E. Interceptor;[@mouseover,harm,nodead][]Consume Magic")
					EditMacro("WSxDef",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;[spec:2]Fiery Brand;[spec:1]Blur")
					EditMacro("WSxGND",nil,nil,"#show\n/use [mod:shift,spec:2,talent:1/2]Immolation Aura;[mod:shift,spec:1,talent:4/3]!Netherwalk;[spec:1]Darkness;[spec:2,talent:6/3]Soul Barrier;[spec:2]Demon Spikes")
					EditMacro("WSxCC",nil,nil,"#show\n/use [spec:2,mod:ctrl,@cursor]Sigil of Misery;[@mouseover,harm,nodead][]Imprison\n/cancelaura X-Ray Specs")
					EditMacro("WSxMove",nil,nil,"#show\n/use [spec:2,@cursor]Infernal Strike;Vengeful Retreat\n/use [nomod]Panflute of Pandaria\n/use Haw'li's Hot & Spicy Chili\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem\n/use Prismatic Bauble\n/use !Glide\n/use [mod]Weathered Purple Parasol\n/dismount [mounted]")
				end -- avslutar class
			end	-- avslutar racials[race]			
		end -- events

		-- Mount Parser based on events
		if (event == "ZONE_CHANGED_NEW_AREA" or event == "BAG_UPDATE_DELAYED" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PET_SPECIALIZATION_CHANGED" or event == "PLAYER_LOGIN") then
			local palaMounts = {
				["Draenei"] = "Summon Exarch's Elekk,Summon Great Exarch's Elekk,",
				["LightforgedDraenei"] = "Summon Lightforged Ruinstrider,",
				["DarkIronDwarf"] = "Summon Darkforge Ram,",
				["Dwarf"] = "Summon Dawnforge Ram,",
				["Tauren"] = "Summon Sunwalker Kodo,Summon Great Sunwalker Kodo,",
				["BloodElf"] = "Summon Thalassian Warhorse,Summon Thalassian Charger,",
				["Human"] = "Summon Warhorse,Summon Charger,",
				["ZandalariTroll"] = "Crusader's Direhorn,",
			}	
			local groundMount = {
				["SHAMAN"] = "",
				["MAGE"] = "Wild Dreamrunner",
				["WARLOCK"] = "Felblaze Infernal,Wild Dreamrunner,Lucid Nightmare,Illidari Felstalker,Hellfire Infernal",
				["MONK"] = "Wild Dreamrunner,Swift Zulian Tiger,Lil' Donkey",
				["PALADIN"] = "Blessed Felcrusher,Prestigious Bronze Courser,Argent Charger,Pureheart Courser",
				["HUNTER"] = "Spawn of Horridon,Bruce,Llothien Prowler,Ironhoof Destroyer,Alabaster Hyena",
				["ROGUE"] = "Blue Shado-Pan Riding Tiger,Broken Highland Mustang",
				["DEATHKNIGHT"] = "Midnight,Bloodgorged Crawg,Pureheart Courser",
				["PRIEST"] = "Trained Meadowstomper, Glorious Felcrusher, Ivory Hawkstrider, Wild Dreamrunner, Pureheart Courser",
				["WARRIOR"] = "Vicious War Turtle,Infernal Direwolf,Bloodfang Widow,Ironhoof Destroyer",
				["DRUID"] = "Wild Dreamrunner,Kaldorei Nightsaber,Pureheart Courser,Raven Lord",
				["DEMONHUNTER"] = "Felsaber,Wild Dreamrunner,Lucid Nightmare,Grove Defiler,Illidari Felstalker,Llothien Prowler",
			}
			if faction == "Alliance" then 
				groundMount = { 
					["SHAMAN"] = "Stormpike Battle Ram",
					["MAGE"] = "Wild Dreamrunner",
					["WARLOCK"] = "Lucid Nightmare,Illidari Felstalker,Hellfire Infernal",
					["MONK"] = "Wild Dreamrunner,Swift Zulian Tiger,Lil' Donkey",
					["PALADIN"] = "Blessed Felcrusher,Prestigious Bronze Courser,Argent Charger,Pureheart Courser",
					["HUNTER"] = "Spawn of Horridon,Bruce,Llothien Prowler,Ironhoof Destroyer,Alabaster Hyena",
					["ROGUE"] = "Blue Shado-Pan Riding Tiger,Highland Mustang",
					["WARRIOR"] = "Vicious War Turtle,Infernal Direwolf,Bloodfang Widow,Ironhoof Destroyer",
					["DRUID"] = "Wild Dreamrunner,Kaldorei Nightsaber,Pureheart Courser,Raven Lord",
					["DEMONHUNTER"] = "Felsaber,Wild Dreamrunner,Lucid Nightmare,Grove Defiler,Illidari Felstalker,Llothien Prowler",
				}
			end

			local flyingMount = {
				["SHAMAN"] = ",Spectral Pterrorwing,Grand Wyvern,Kua'fon",
				["MAGE"] = ",Leywoven Flying Carpet,Ashes of Al'ar,Arcanist's Manasaber,Violet Spellwing,Soaring Spelltome,Glacial Tidestorm",
				["WARLOCK"] = ",Grove Defiler,Headless Horseman's Mount,Felsteel Annihilator,Antoran Gloomhound,Shackled Ur'zul",
				["MONK"] = "Astral Cloud Serpent",
				["PALADIN"] = ",Highlord's Golden Charger,Lightforged Warframe,Invincible",
				["HUNTER"] = ",Mimiron's Head,Clutch of Ji-Kun,Armored Skyscreamer,Dread Raven,Darkmoon Dirigible,Spirit of Eche'ro,Spectral Pterrorwing",
				["ROGUE"] = ",Ironbound Wraithcharger,Shadowblade's Murderous Omen,Geosynchronous World Spinner",
				["PRIEST"] = ",Dread Raven,Lightforged Warframe",
				["DEATHKNIGHT"] = ",Invincible,Sky Golem",
				["WARRIOR"] = ",Invincible,Smoldering Ember Wyrm,Valarjar Stormwing,Obsidian Worldbreaker",
				["DRUID"] = ",Sky Golem,Ashenvale Chimaera,Leyfeather Hippogryph",
				["DEMONHUNTER"] = ",Arcanist's Manasaber,Felfire Hawk,Corrupted Dreadwing,Azure Drake,Cloudwing Hippogryph,Leyfeather Hippogryph,Felsteel Annihilator",
			}
			if faction == "Alliance" then 
				flyingMount = { 
					["SHAMAN"] = ",Spirit of Eche'ro,Grand Gryphon,Honeyback Harvester",
					["MAGE"] = ",Leywoven Flying Carpet,Ashes of Al'ar,Arcanist's Manasaber,Violet Spellwing,Soaring Spelltome,Glacial Tidestorm,Honeyback Harvester",
					["WARLOCK"] = ",Honeyback Harvester,Headless Horseman's Mount,Grove Defiler,Felsteel Annihilator,Shackled Ur'zul",
					["MONK"] = "Astral Cloud Serpent",
					["PALADIN"] = ",Highlord's Golden Charger,Lightforged Warframe,Invincible,Honeyback Harvester",
					["HUNTER"] = ",Mimiron's Head,Clutch of Ji-Kun,Armored Skyscreamer,Dread Raven,Darkmoon Dirigible,Spirit of Eche'ro,Honeyback Harvester",
					["ROGUE"] = ",Ironbound Wraithcharger,Shadowblade's Murderous Omen,Geosynchronous World Spinner",
					["PRIEST"] = ",Dread Raven,Lightforged Warframe,Honeyback Harvester",
					["DEATHKNIGHT"] = ",Invincible,Sky Golem,Honeyback Harvester,",
					["WARRIOR"] = ",Invincible,Smoldering Ember Wyrm,Valarjar Stormwing,Obsidian Worldbreaker,Honeyback Harvester",
					["DRUID"] = ",Sky Golem,Ashenvale Chimaera,Leyfeather Hippogryph,Honeyback Harvester",
					["DEMONHUNTER"] = ",Arcanist's Manasaber,Felfire Hawk,Corrupted Dreadwing,Azure Drake,Cloudwing Hippogryph,Leyfeather Hippogryph,Felsteel Annihilator,Honeyback Harvester",
				}	
			end

			-- classMount[class]	 
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
			}

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
				["NightElf"] = "",
				["Orc"] = "Frostwolf Snarler,",
				["Pandaren"] = "",
				["Scourge"] = "Undercity Plaguebat,",
				["Tauren"] = "",
				["Troll"] = "Fossilized Raptor,Bloodfang Widow,Swift Zulian Tiger,",
				["VoidElf"] = "Starcursed Voidstrider,",
				["Vulpera"] = "Alabaster Hyena,Springfur Alpaca,Elusive Quickhoof,Caravan Hyena,",
				["Worgen"] = "Running Wild,",
				["ZandalariTroll"] = "",
			}

			-- Random Covenant Mount Generator
			-- Covenant Ground mounts
			local covGroundMounts = {
	        	[0] = {""},
	        	[1] = {"Eternal Phalynx of Courage","Eternal Phalynx of Purity","Phalynx of Courage","Phalynx of Humility","Ascended Skymane","Sundancer"},
	        	[2] = {"Battle Gargon Vrednic","Crypt Gargon","Gravestone Battle Gargon","Hopecrusher Gargon","Inquisition Gargon","Sinfall Gargon","Court Sinrunner"},
	        	[3] = {"Enchanted Dreamlight Runestag","Enchanted Shadeleaf Runestag","Spinemaw Gladechewer","Wildseed Cradle","Swift Gloomhoof","Shimmermist Runner","Arboreal Gulper"},
	        	[4] = {"Armored Plaguerot Tauralus","Armored War-Bred Tauralus","Lurid Bloodtusk"},
        	}
			-- Covenant Flying mounts
			local covFlyingMounts = {
	        	[0] = {""},
	        	[1] = {"Gilded Prowler","Silverwind Larion"},
	        	[2] = {"Horrid Dredwing","Rampart Screecher", "Wastewarped Deathwalker"},
	        	[3] = {"Amber Ardenmoth","Duskflutter Ardenmoth"},
	        	[4] = {"Predatory Plagueroc","Colossal Slaughterclaw","Marrowfang"},
	        }

			-- pvp mount faction converter
			local pvpSkelly = "Vicious Skeletal Warhorse," 
			local pvpRaptor = "Vicious War Raptor," 
			local pvpKodo = "Vicious War Kodo,"
			local prestWolf = "Prestigious War Wolf,"
			if faction == "Alliance" then 
				pvpSkelly = "Vicious Kaldorei Warsaber,"
				pvpRaptor = "Vicious War Ram,"
				pvpKodo = "Vicious War Mechanostrider,"
				prestWolf = "Prestigious War Steed,"
			end

			local factionBike = "Warlord's Deathwheel,"
			if faction == "Alliance" then
				factionBike = "Champion's Treadblade,"
			end

			local factionHog = "Mechano-Hog"
			if faction == "Alliance" then
				factionHog = "Mekgineer's Chopper"
			end
			-- Mount class spec parser
			if class == "SHAMAN" then
				if playerspec == 3 then
					groundMount[class] = "Snapback Scuttler"
				end
			elseif class == "WARLOCK" then
				if playerspec == 2 then 
					classMount[class] = "Netherlord's Accursed Wrathsteed,Netherlord's Chaotic Wrathsteed"
				elseif playerspec == 3 then
					classMount[class] = "Netherlord's Brimstone Wrathsteed,Netherlord's Chaotic Wrathsteed"
				end
			elseif class == "MONK" then
				if (playerspec == 1 and faction == "Alliance") then
					flyingMount[class] = "Honeyback Harvester"
				elseif playerspec == 1 then 
					flyingMount[class] = "Lucky Yun"
				elseif playerspec == 2 then
					flyingMount[class] = "Yu'lei, Daughter of Jade" 
					classMount[class] = "Shu-Zen, the Divine Sentinel"
				elseif playerspec == 3 then
					flyingMount[class] = "Wen Lo, the River's Edge"
					classMount[class] = "Ban-Lu, Grandmaster's Companion"
				end
				classMount[class] = "/use [mounted]"..classMount[class]
				flyingMount[class] = "/use "..flyingMount[class]
				
			elseif class == "PALADIN" then
				if playerspec == 2 then 
					classMount[class] = "Highlord's Vigilant Charger" 
					groundMount[class] = "Avenging Felcrusher"   
				elseif playerspec == 3 then
					classMount[class] = "Highlord's Vengeful Charger"
				end
			elseif class == "HUNTER" then				
				if playerspec == 2 then 
					classMount[class] = "Huntmaster's Dire Wolfhawk" 
					groundMount[class] = "Spawn of Horridon,Spirit of Eche'ro,Brawler's Burly Basilisk,Llothien Prowler,Ironhoof Destroyer"
					flyingMount[class] = ",Mimiron's Head,Armored Skyscreamer,Dread Raven,Darkmoon Dirigible"
				elseif playerspec == 3 then
					classMount[class] = "Huntmaster's Fierce Wolfhawk" 
					groundMount[class] = "Highmountain Thunderhoof,Brawler's Burly Basilisk,Great Northern Elderhorn,Highmountain Elderhorn,Alabaster Hyena"
					flyingMount[class] = ",Clutch of Ji-Kun,Dread Raven,Spirit of Eche'ro"
				end
			elseif class == "ROGUE" then
				if playerspec == 2 then 
					classMount[class] = "Shadowblade's Crimson Omen"
					groundMount[class] = "Siltwing Albatross,Ratstallion"
					flyingMount[class] = ",Shadowblade's Murderous Omen,Infinite Timereaver,Siltwing Albatross,The Dreadwake"
				elseif playerspec == 3 then
					classMount[class] = "Shadowblade's Lethal Omen"	
					groundMount[class] = "Infinite Timereaver"
					flyingMount[class] = ",Ironbound Wraithcharger,Shadowblade's Murderous Omen"
				end			
			elseif class == "PRIEST" then		
				if playerspec == 3 then
					flyingMount[class] = ",Dread Raven,Riddler's Mind-Worm,The Hivemind,Uncorrupted Voidwing"	
					groundMount[class] = "Lucid Nightmare,Ivory Hawkstrider,Ultramarine Qiraji Battle Tank,The Hivemind,Voidtalon of the Dark Star"
				elseif playerspec == 2 then
					groundMount[class] = "Bone-White Primal Raptor,Ivory Hawkstrider,Wild Dreamrunner,Pureheart Courser"
				end
			elseif class == "DEATHKNIGHT" then
				if playerspec == 2 then
					groundMount[class] = "Frostshard Infernal,Pureheart Courser,Glacial Tidestorm"
				elseif playerspec == 3 then
					groundMount[class] = "Winged Steed of the Ebon Blade,Pureheart Courser"
				end
			elseif class == "WARRIOR" then	
				if playerspec == 2 then
					groundMount[class] = "Arcadian War Turtle,Bloodfang Widow,Ironhoof Destroyer"
				elseif playerspec == 3 then
					groundMount[class] = "Prestigious Bronze Courser,Bloodfang Widow,Ironhoof Destroyer"
				end
			elseif class == "DRUID" then
				if playerspec == 2 then 
					classMount[class] = "Swift Zulian Tiger"
				elseif playerspec == 3 then
					classMount[class] = "Darkmoon Dancing Bear"
				elseif playerspec == 4 then
					classMount[class] = "Emerald Drake"
				end

				if (UnitName("player") == "Fannylands" and playerspec == 3) then
					classMount[class] = "Grove Defiler"
					flyingMount[class] = ",Grove Defiler"
					pvpRaptor = ""
					groundMount[class] = "Grove Defiler"
				end
			end

        	covGroundMounts = covGroundMounts[slBP]
        	covGroundMounts = covGroundMounts[random(#covGroundMounts)]
        	if slBP == 2 then
        		covGroundMounts = covGroundMounts..",Sinrunner Blanchy,Wastewarped Deathwalker"
        	end        	
        	covFlyingMounts = covFlyingMounts[slBP]
        	covFlyingMounts = covFlyingMounts[random(#covFlyingMounts)]

			if class ~= "MONK" then
				groundMount[class] = groundMount[class]..","..covGroundMounts
				flyingMount[class] = flyingMount[class]..","..covFlyingMounts
			end
			
			local mountSlash = "/userandom"

			-- Vazj'ir
			if (z == "Vashj'ir" or z == "Kelp'thar Forest" or z == "Shimmering Expanse" or z == "Abyssal Depths") then
				if class == "DRUID" then
					flyingMount[class] = "!Travel Form"
				else
					flyingMount[class] = "Vashj'ir Seahorse"
				end
				mountSlash = "/use "
				classMount[class] = ""
				groundMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
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
				    if GetItemCount(torghastMountPower) >= 1 then
				        powerInBags = torghastMountPower
				    end
				end
				mountSlash = "/use "
				classMount[class] = ""
				flyingMount[class] = ""
				groundMount[class] = powerInBags
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
				-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Torghast = "..z.."",0.5,1.0,0.0)
			elseif z == "Torghast, Tower of the Damned" then
				mountSlash = ""
				classMount[class] = ""
				flyingMount[class] = ""
				groundMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Inside the Tower = "..z.."",0.5,1.0,0.0)
			elseif GetItemCount("Magic Broom") >= 1 then
				classMount[class] = "Magic Broom"
				flyingMount[class] = "Magic Broom"
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Magic Broom = "..z.."",0.5,1.0,0.0)
			elseif z == "The Maw" then
				mountSlash = "/use "
				classMount[class] = ""
				flyingMount[class] = ""
				groundMount[class] = "Colossal Ebonclaw Mawrat"
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: The Maw = "..z.."",0.5,1.0,0.0)
			-- Nazjatar
			elseif (z == "Nazjatar" or z == "Damprock Cavern") then
				local randomSeapony = {"Inkscale Deepseeker","Fabious","Subdued Seahorse","Crimson Tidestallion"}
				randomSeapony = ","..randomSeapony[random(#randomSeapony)]
				flyingMount[class] = randomSeapony
				groundMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Random Seapony = "..z.."",0.5,1.0,0.0)
			elseif instanceName == "The Deaths of Chromie" then
				-- We can use flying mounts
				groundMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
				--print("The Deaths of Chromie")
			elseif (instanceType ~= "none" and not garrisonId[mapID]) or groundAreas[z] or groundAreas[instanceName] then
				-- We can't fly inside instances, except Draenor Garrisons and The Deaths of Chromie
				-- Flying is also disabled in certain outdoor areas/zones
				classMount[class] = ""
				flyingMount[class] = ""
				-- groundMount[class] = ""
				-- pvpSkelly = "" 
				-- pvpRaptor = "" 
				-- pvpKodo = ""
				-- prestWolf = ""
				-- factionBike = ""
				-- racistMount[race] = ""
				-- palaMounts[race] = ""
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: No flying zones = "..z.."",0.5,1.0,0.0)
			--print("Cannot fly in certain areas")
			elseif (IsSpellKnown(34090) or IsSpellKnown(34091) or IsSpellKnown(90265)) then 
				-- Expert, Artisan or Master Riding
				groundMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Expert, Artisan or Master Riding = "..z.."",0.5,1.0,0.0)
			--print("Artisan or Master Riding")
			elseif IsSpellKnown(33388) or IsSpellKnown(33391) then 
				-- Apprentice or Journeyman Riding
				-- We can use ground mounts
				flyingMount[class] = ""
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Apprentice or Journeyman Riding = "..z.."",0.5,1.0,0.0)
			--print("Journeyman or Apprentice")
			elseif level < 10 then
				groundMount[class] = "Summon Chauffeur"
				classMount[class] = ""
				flyingMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Summon Chauffeur "..z.."",0.5,1.0,0.0)
			elseif level <= 20 then
				groundMount[class] = "Snapback Scuttler"
				classMount[class] = ""
				flyingMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
				-- Mount Type Zone Parser
				-- Check if the character has riding skill
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Snapback Scuttler "..z.."",0.5,1.0,0.0)
			else 
				classMount[class] = ""
				flyingMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
				mountSlash = ""
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Cannot mount = "..z.."",0.5,1.0,0.0)
			--print("We dont any Riding skill")
			end

			--[[Mount synthesis: 
			flying mounts: classMount[class], flyingMount[class], 
			ground mounts: "..pvpKodo..""..pvpRaptor..""..prestWolf..""..factionBike..",racistMount[race],groundMount[class] --]] 
			if (class == "MAGE" or class == "PRIEST" or class == "DEMONHUNTER" or class == "DEATHKNIGHT") then
				EditMacro("WSxSGen+V",nil,nil,mountSlash.." "..classMount[class]..""..flyingMount[class]..""..racistMount[race]..""..groundMount[class]) 
			elseif class == "SHAMAN" then
				EditMacro("WSxSGen+V",nil,nil,"/use [noform]Ghost Wolf\n/use [@player,nochanneling]Water Walking\n"..mountSlash.." "..classMount[class]..""..flyingMount[class]..""..pvpKodo..""..pvpRaptor..""..prestWolf..""..factionBike..""..racistMount[race]..""..groundMount[class].."\n/use Death's Door Charm")
			elseif class == "WARLOCK" then
				EditMacro("WSxSGen+V",nil,nil,mountSlash.." "..classMount[class]..""..flyingMount[class]..""..pvpSkelly..""..factionBike..""..racistMount[race]..""..groundMount[class].."\n/use Tithe Collector's Vessel")
			elseif class == "MONK" then
				if groundMount[class]  ~= "" then
					groundMount[class] = "/userandom "..groundMount[class]
				end
				EditMacro("WSxSGen+V",nil,nil,classMount[class].."\n"..flyingMount[class]..""..racistMount[race]..""..groundMount[class])
			elseif class == "PALADIN" then
				mountSlash = "/userandom [nomounted]"
				EditMacro("WSxSGen+V",nil,nil,"/use [combat]!Devotion Aura;[nomounted]!Crusader Aura\n"..mountSlash..""..classMount[class]..""..flyingMount[class]..""..palaMounts[race]..""..racistMount[race]..""..groundMount[class])
			elseif class == "HUNTER" then
				EditMacro("WSxSGen+V",nil,nil,mountSlash.." "..classMount[class]..""..flyingMount[class]..""..pvpKodo..""..pvpRaptor..""..racistMount[race]..""..groundMount[class])
			elseif class == "ROGUE" then
				EditMacro("WSxSGen+V",nil,nil,mountSlash.." "..classMount[class]..""..flyingMount[class]..""..racistMount[race]..""..groundMount[class].."\n/targetfriend [nospec:2,nohelp,combat]")
			elseif class == "WARRIOR" then
				EditMacro("WSxSGen+V",nil,nil,mountSlash.." "..classMount[class]..""..flyingMount[class]..""..factionBike..""..prestWolf..""..racistMount[race]..""..groundMount[class].."\n/use Death's Door Charm")
			elseif class == "DRUID" then
				EditMacro("WSxSGen+V",nil,nil,"/cancelform [form:1/2/3]\n"..mountSlash.." "..classMount[class]..""..flyingMount[class]..""..pvpRaptor..""..racistMount[race]..""..groundMount[class])
			end
--[[			print("mountSlash = "..noMount)--]]
		end -- class
	
		-- Hunter Misc pet parser
		if class == "HUNTER" and (event == "PET_STABLE_CLOSED" or event == "PLAYER_LOGIN") then
			local petAbilityMacro, petExoticMacro = "/use "..ptdSG.."[nopet]Call Pet 4;", "/use [mod:alt]Eyes of the Beast;[nopet]Call Pet 5;"
			local petAbilities = {
				["Basilisk"] = "Petrifying Gaze",
				["Bat"] = "Sonic Blast",
				["Bear"] = "Thick Fur",
				["Beetle"] = "Harden Carapace",
				["Bird of Prey"] = "Talon Rend",
				["Blood Beast"] = "Blood Bolt",
				["Boar"] = "Bristle",
				["Camel"] = "Hardy",
				["Carrion Bird"] = "Bloody Screech",
				["Cat"] = "Catlike Reflexes",
				["Chimaera"] = "Frost Breath",
				["Clefthoof"] = "Thick Hide",
				["Core Hound"] = "Obsidian Skin",
				["Courser"] = "Fleethoof",
				["Crab"] = "Pin",
				["Crane"] = "Chi-Ji's Tranquility",
				["Crocolisk"] = "Ankle Crack",
				["Devilsaur"] = "Monstrous Bite",
				["Direhorn"] = "Gore",
				["Dog"] = "Lock Jaw",
				["Dragonhawk"] = "Dragon's Guile",
				["Feathermane"] = "Feather Flurry",
				["Fox"] = "Agile Reflexes",
				["Gorilla"] = "Silverback",
				["Gruffhorn"] = "Gruff",
				["Hydra"] = "Acid Bite",
				["Hyena"] = "Infected Bite",
				["Krolusk"] = "Bulwark",
				["Lizard"] = "Grievous Bite",
				["Mammoth"] = "Trample",
				["Mechanical"] = "Defense Matrix",
				["Monkey"] = "Primal Agility",
				["Moth"] = "Serenity Dust",
				["Oxen"] = "Niuzao's Fortitude",
				["Pterrordax"] = "Ancient Hide",
				["Quilen"] = "Stone Armor",
				["Raptor"] = "Savage Rend",
				["Ravager"] = "Ravage",
				["Ray"] = "Nether Energy",
				["Riverbeast"] = "Gruesome Bite",
				["Rodent"] = "Gnaw",
				["Scalehide"] = "Scale Shield",
				["Scorpid"] = "Deadly Sting",
				["Serpent"] = "Serpent's Swiftness",
				["Shale Spider"] = "Solid Shell",
				["Silithid"] = "Tendon Rip",
				["Spider"] = "Web Spray",
				["Spirit Beast"] = "Spirit Pulse",
				["Sporebat"] = "Spore Cloud",
				["Stag"] = "Nature's Grace",
				["Tallstrider"] = "Dust Cloud",
				["Toad"] = "Swarm of Flies",
				["Turtle"] = "Shell Shield",
				["Warp Stalker"] = "Warp Time",
				["Wasp"] = "Toxic Sting",
				["Wind Serpent"] = "Winged Agility",
				["Wolf"] = "Furious Bite",
				["Worm"] = "Acid Spit",
			}
			local petExoticAbilities = {
				["Bear"] = "Rest",
				["Bird of Prey"] = "Trick",
				["Cat"] = "Prowl",
				["Chimaera"] = "Froststorm Breath",
				["Clefthoof"] = "Blood of the Rhino",
				["Core Hound"] = "Molten Hide",
				["Crane"] = "Trick",
				["Devilsaur"] = "Feast",
				["Feathermane"] = "Updraft",
				["Fox"] = "Play",
				["Krolusk"] = "Calcified Carapace",
				["Pterrordax"] = "Updraft",
				["Quilen"] = "Eternal Guardian",
				["Rodent"] = "Rest",
				["Shale Spider"] = "Shimmering Scale",
				["Silithid"] = "Dune Strider",
				["Spirit Beast"] = "Spirit Mend",
				["Worm"] = "Burrow Attack",
			}
			-- Hunter Pets
			for i = 1, 5 do
				local _, _, _, family = GetStablePetInfo(i)

				if family and petAbilities[family] then
					petAbilityMacro = petAbilityMacro .. "[pet:" .. family .. "]" .. petAbilities[family] .. ";"
				end

				if family and petExoticAbilities[family] then
					if family == "Spirit Beast" then
						petExoticMacro = petExoticMacro .. "[pet:Spirit Beast,nocombat]Spirit Walk;[pet:Spirit Beast]Spirit Shock;"
					else
						petExoticMacro = petExoticMacro .. "[pet:" .. family .. "]" .. petExoticAbilities[family] .. ";"
					end
				end
			end
			petAbilityMacro = petAbilityMacro .. "\n/use Hunter's Call\n/use [nocombat,noexists,resting]Flaming Hoop" 
			-- Call Pet 4, Shift+G
			petExoticMacro = petExoticMacro .. "\n/use Whole-Body Shrinka'" 
			-- Ctrl+Shift+G --> "GG", "G"
			EditMacro("WSxSGen+H", nil, nil, petAbilityMacro, 1, 1)
			EditMacro("WSxGG", nil, nil, petExoticMacro, 1, 1)
			DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Updating Active Pets! :D",0.5,1.0,0.0)
				--[[print(family)
				print(petAbilityMacro)
				print(petExoticAbilities)
				print(petAbilities[family])--]]			
		end -- eventHandler
	end -- Combat Lock
end -- Function
frame:SetScript("OnEvent", eventHandler)