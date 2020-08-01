local frame = CreateFrame("FRAME", "ZigiAllButtons")
local throttled = false
local throttlef = false

frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
frame:RegisterEvent("BAG_UPDATE_DELAYED")
frame:RegisterUnitEvent("PET_SPECIALIZATION_CHANGED")
frame:RegisterEvent("PET_STABLE_CLOSED")
--frame:RegisterEvent("PLAYER_LEVEL_UP")
frame:RegisterEvent("PLAYER_LOGIN")
--frame:RegisterEvent("VARIABLES_LOADED")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

local function eventHandler(self, event)

	if InCombatLockdown() then
		frame:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		frame:UnregisterEvent("PLAYER_REGEN_ENABLED")

		local faction = UnitFactionGroup("player")
		local _,race = UnitRace("player")
		local _,class = UnitClass("player")
		if not class then 
			return
		end
		local level = UnitLevel("player")

		local z, m, mA, mP = GetZoneText(), "", "", ""
		local instanceName, instanceType, difficulty, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance, mapID, instanceGroupSize = GetInstanceInfo()
		local playerspec = GetSpecialization(false,false)
		if not playerspec then
			return
		end
		local petspec = GetSpecialization(false,true)
		local pwned = "Horde Flag of Victory"
		if faction == "Alliance" then 
			pwned = "Alliance Flag of Victory" 
		end
		if class == "WARLOCK" then
			pwned = "Drust Ritual Knife"
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
		if class == "PRIEST" then
			passengerMount = "The Hivemind"
		elseif faction == "Alliance" then 
			passengerMount = "Stormwind Skychaser" 
		end
		
		local one = "\n/run SelectGossipOption(1, true)"
		local two = "\n/run SelectGossipAvailableQuest(1);AcceptQuest(1)"
		local tre = "\n/run SelectGossipActiveQuest(1);CompleteQuest();\n/click QuestFrameCompleteQuestButton"
		
		-- BoD, Mercenary BG Racial parser
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
		elseif IsSpellKnown(69041) then 
			race = "Goblin"
		elseif IsSpellKnown(69070) then 
			race = "Goblin"
		elseif IsSpellKnown(59752) then 
			race = "Human"
		elseif IsSpellKnown(274738) then 
			race = "MagharOrc"
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
		end

		local racials = {
			["BloodElf"] = "Arcane Torrent",
			["Draenei"] = "[@mouseover,help,nodead][]Gift of the Naaru",
			["DarkIronDwarf"] = "Fireblood",
			["Dwarf"] = "Stoneform",
			["Gnome"] = "Escape Artist",
			["Goblin"] = "Rocket Jump",
			["HighmountainTauren"] = "Bull Rush",
			["Human"] = "Every Man for Himself",
			["KulTiran"] = "Haymaker",
			["LightforgedDraenei"] = "Light's Judgment",
			["MagharOrc"] = "Ancestral Call",
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
		}
		if dpsRacials[race] then
			dpsRacials[race] = "\n/use "..dpsRacials[race]
		else 
			dpsRacials[race] = ""	
		end
		local extraRacials = {
			["DarkIronDwarf"] = "Mole Machine",
			["Goblin"] = "Pack Hobgoblin",
			["LightforgedDraenei"] = "Forge of Light",
			["Nightborne"] = "Cantrips",
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
				EditMacro("WSxExtraRacist",nil,nil,"#showtooltip "..extraRacials[race].."\n/targetlasttarget [noexists,nocombat,nodead]\n/use [harm,dead] "..extraRacials[race])
			else
			   EditMacro("WSxExtraRacist",nil,nil,"#showtooltip\n/use " ..extraRacials[race])
			end
		end

		-- Hearthstones
		local HS = {
			["SHAMAN"] = "Tome of Town Portal",
			["MAGE"] = "Fire Eater's Hearthstone",
			["WARLOCK"] = "Headless Horseman's Hearthstone",
			["MONK"] = "Brewfest Reveler's Hearthstone",
			["PALADIN"] = "Hearthstone",
			["HUNTER"] = "Holographic Digitalization Hearthstone",
			["ROGUE"] = "Tome of Town Portal",
			["PRIEST"] = "Peddlefeet's Lovely Hearthstone",
			["DEATHKNIGHT"] = "Eternal Traveler's Hearthstone",
			["WARRIOR"] = "The Innkeeper's Daughter",
			["DRUID"] = "Noble Gardener's Hearthstone",
			["DEMONHUNTER"] = "Tome of Town Portal",
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
			["Mogu Island Daily Area"] = true,
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
			-- Argus
			["Krokuun"] = true,
			["Antoran Wastes"] = true,
			["Mac'Aree"] = true,
			["Invasion Points"] = true,
			-- Battle for Azeroth
			["8.1 Darkshore Alliance Quests"] = true, -- Darkshore Unlock Scenario
			["8.1 Darkshore Horde Quests"] = true, -- Darkshore Unlock Scenario
		}

		-- Garrisons Map IDs
		local garrisonId = { [1152] = true, [1330] = true, [1153] = true, [1158] = true, [1331] = true, [1159] = true, }

		local EQS = {
			[1] = "Noon!",
			[2] = "DoubleGate",
			[3] = "Menkify!",
			[4] = "Supermenk",
		}
		-- speciella item sets
		local tipiSet = ""
		if C_EquipmentSet.GetEquipmentSetID("Tipipants") then 
			tipiSet = "C_EquipmentSet.UseEquipmentSet(C_EquipmentSet.GetEquipmentSetID(\"Tipipants\"))" 
		end
		if not tipiSet then
			return
		end

		-- set spec title
		local SST = {
		-- Shaman titles
			[1] = "Gorgeous",
			[2] = "Storm's End",
			[3] = "Gorgeous",
		}
		if class == "SHAMAN" and race == "Orc" then
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
			if (race == "VoidElf" or race == "BloodElf") and playerspec == 2 then
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
			if race == "BloodElf" and playerspec == 3 then
				SST = { 
				[3] = "Lady of War",
			}
			end
		elseif class == "HUNTER" then
			SST = {
				[1] = "Zookeeper", 
				[2] = "The Patient",
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
				[1] = "Bane of the Fallen King", 
				[2] = "Champion of the Frozen Wastes",
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
		local consOne, consTwo, consThree, invisPot = "Spellstone Delight","Spellstone Delight","Spellstone Delight","Stealthman 54"

		local hasBell = "Cooking School Bell"

		if SST[playerspec] and EQS[playerspec] then
			EditMacro("WSpecs!",nil,nil,"/settitle "..SST[playerspec].."\n/equipset "..EQS[playerspec].."\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 elseif(IsModifierKeyDown())then x=4 end if(x~=GetSpecialization())then SetSpecialization(x) end\n/stopcasting")
		end
		
		local oOtas = "\n/use Orb of Deception"
		if race ~= "BloodElf" and level >= 60 then
			oOtas = "\n/use Orb of the Sin'dorei"
		end
		if level <= 60 then
			oOtas = oOtas.."\n/use Toy Armor Set\n/use Toy Weapon Set"
		end 
		-- Class exception pvp macros.
		local warPvPExc = ""
		local hunPvPExcSTree = ""
		local hunPvPExcSFour = ""
		local shaPvPExc = "Fire Elemental"
		local locPvPExcQQ = "[@mouseover,exists,nodead][]Command Demon"
		local locPvPExcSeven = "[spec:2]Implosion"
		local locPvPExcGenF = "[@focus,harm,nodead]Command Demon;"
		local magPvPExcTwo = "[@mouseover,harm,nodead][]Scorch"
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
		-- Target BG Healers and Set BG Healers
		local numaltcc = {
			["SHAMAN"] = "Hex",
			["MAGE"] = "Polymorph",
			["WARLOCK"] = "Command Demon",
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
		local numctrlcc = {
			["SHAMAN"] = "Purge",
			["MAGE"] = "Spellsteal",
			["WARLOCK"] = "Command Demon",
			["MONK"] = "Disable",
			["PALADIN"] = "Blessing of Protection",
			["HUNTER"] = "Harpoon",
			["ROGUE"] = "Shadowstep",
			["PRIEST"] = "Dispel Magic",
			["DEATHKNIGHT"] = "Dark Simulacrum",
			["WARRIOR"] = "Charge",
			["DRUID"] = "Entangling Roots", 
			["DEMONHUNTER"] = "Consume Magic",
		}
		if class == "ROGUE" and playerspec == 2 then
			numctrlcc[class] = "Between The Eyes"
		end
		local numnomodcc = {
			["SHAMAN"] = "Wind Shear",
			["MAGE"] = "Counterspell",
			["WARLOCK"] = "Mortal Coil",
			["MONK"] = "Tiger's Lust",
			["PALADIN"] = "Blessing of Freedom",
			["HUNTER"] = "Master's Call",
			["ROGUE"] = "Kick",
			["PRIEST"] = "Silence",
			["DEATHKNIGHT"] = "Mind Freeze",
			["WARRIOR"] = "Pummel",
			["DRUID"] = "Solar Beam", 
			["DEMONHUNTER"] = "Disrupt",
		}
		if class == "DRUID" then
			if (playerspec == 2 or playerspec == 3) then
				numnomodcc[class] = "Skull Bash"
			end
		end

		-- Zone och bag baserade events
		if (event == "ZONE_CHANGED_NEW_AREA" or event == "BAG_UPDATE_DELAYED") and not throttled then 
			throttled = true
	        C_Timer.After(2, function()
	            -- denna kod körs efter 2 sekunder
	            throttled = false
	        end)

			if not hasBell then
				return
			end
			if GetItemCount(hasBell) < 1 then
				hasBell = "B. F. F. Necklace"
			end

			-- Login,zone,bag_update based event, Swapper, Alt+J parser, Call Companion, set class/spec toys.
			local pets = "\"Snowfang\",\"Frostwolf Pup\",\"Bound Stream\",\"Pebble\",\"Soul of the Forge\",\"Zephyrian Prince\""
			if class == "SHAMAN" then
				if race == "Troll" then
					pets = "\"Sen'jin Fetish\",\"Lashtail Hatchling\",\"Drafty\",\"Searing Scorchling\",\"Seafury\",\"Mojo\",\"Lumpy\""
				end
				EditMacro("WSxSwapper",nil,nil,"#show Earth Elemental\n/use "..hasBell.."\n/run local a={"..pets.."}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			elseif class == "MAGE" then
				pets = "\"Lil' Tarecgosa\",\"Trashy\",\"Wondrous Wisdomball\",\"Stardust\",\"Noblegarden Bunny\",\"Magical Crawdad\""
				if playerspec == 3 then
					pets = "\"Lil' Tarecgosa\",\"Mr. Chilly\",\"Tiny Snowman\",\"Stardust\",\"Feline Familiar\",\"Frigid Frostling\""
				end
				EditMacro("WSxSwapper",nil,nil,"/use Pilfered Sweeper\n/use "..hasBell.."\n/run local a={"..pets.."}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
				if playerspec == 2 then
					pets = "\"Lil' Tarecgosa\",\"Nethaera's Light\",\"Stardust\",\"Feline Familiar\""
					EditMacro("WSxSwapper",nil,nil,"/use Pilfered Sweeper\n/use Brazier of Dancing Flames\n/use "..hasBell.."\n/run local a={"..pets.."}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
				end
			elseif class == "PALADIN" then
				pets = "\"K'ute\",\"Draenei Micro Defender\",\"Uuna\",\"Ancient Nest Guardian\",\""..factionMurloc.."\""
				EditMacro("WSxSwapper",nil,nil,"/use Burning Blade\n/use "..hasBell.."\n/use [spec:3]Blazing Wings\n/run local a={"..pets.."}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			elseif class == "HUNTER" then
				pets = "\"Rocket Chicken\",\"Baby Elderhorn\",\"Nuts\",\"Tito\",\"Stormwing\",\"Fox Kit\",\"Son of Skum\",\"Crow\""
				if playerspec == 3 then
					pets = "\"Rocket Chicken\",\"Blackfuse Bombling\",\"Baby Elderhorn\",\"Nuts\",\"Tito\",\"Stormwing\",\"Crow\""
				end
				EditMacro("WSxSwapper",nil,nil,"/use Hunter's Call\n/use "..hasBell.."\n/run local a={"..pets.."}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
				if playerspec == 2 then
					pets = "\"Rocket Chicken\",\"Blackfuse Bombling\",\"Alarm-o-Bot\",\"Tito\",\"Stormwing\",\"Crow\""
					EditMacro("WSxSwapper",nil,nil,"/use Dark Ranger's Spare Cowl\n/use "..hasBell.."\n/run local a={"..pets.."}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
				end
			elseif class == "ROGUE" then
				pets = "\"Pocket Cannon\",\"Gilnean Raven\",\"Sneaky Marmot\",\"Giant Sewer Rat\",\"Creepy Crate\",\"Crackers\""
				EditMacro("WSxSwapper",nil,nil,"#show Vanish\n/use "..hasBell.."\n/run local a={"..pets.."}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			elseif class == "PRIEST" then
				pets = "\"Nightmare Bell\",\"Argi\",\"K'ute\",\"Dread Hatchling\",\"Argent Gruntling\",\"Shadow\",\"Uuna\""
				if playerspec == 2 then
					pets = "\"Argi\",\"K'ute\",\"Argent Gruntling\",\"Argi\",\"Sunborne Val'kyr\",\"Uuna\""
				elseif playerspec == 3 then
					pets = "\"Shadow\",\"K'ute\",\"Hungering Claw\",\"Dread Hatchling\",\"Faceless Minion\",\"Grasping Manifestation\""
				end
				EditMacro("WSxSwapper",nil,nil,"#showtooltip Mass Dispel\n/use "..hasBell.."\n/run local a={"..pets.."}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			elseif class == "WARRIOR" then
				pets = "\"Darkmoon Rabbit\",\"Sunborne Val'kyr\",\""..factionMurloc.."\",\"Crow\",\"Teeny Titan Orb\""
				EditMacro("WSxSwapper",nil,nil,"#showtooltip\n/use "..factionPride.."\n/use "..hasBell.."\n/run local a={"..pets.."}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			elseif class == "DRUID" then
				if race == "Tauren" then
					hasBell = "Ancient Tauren Talisman"
				end
				pets = "\"Moonkin Hatchling\",\"Stardust\",\"Sun Darter Hatchling\",\"Ragepeep\""
				if playerspec == 2 then
					pets = "\"Cinder Kitten\",\"Lashtail Hatchling\",\"Singing Sunflower\",\"Sen'Jin Fetish\""
				elseif playerspec == 3 then
					pets = "\"Hyjal Cub\",\"Moonkin Hatchling\",\"Ashmaw Cub\",\"Singing Sunflower\""
				elseif playerspec == 4 then	
					pets = "\"Blossoming Ancient\",\"Stardust\",\"Broot\",\"Singing Sunflower\",\"Sun Darter Hatchling\""
				end
				EditMacro("WSxSwapper",nil,nil,"#show Rebirth\n/use "..hasBell.."\n/use Wisp in a Bottle\n/run local a={"..pets.."}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			elseif (class == "WARLOCK" or class == "MONK" or class == "DEATHKNIGHT" or class == "DEMONHUNTER") then
				if class == "WARLOCK" then
					pets = "\"Rebellious Imp\",\"Lesser Voidcaller\",\"Netherspace Abyssal\",\"Horde Fanatic\",\"Cross Gazer\",\"Sister of Temptation\",\"Nibbles\""
					if playerspec == 2 then
						pets = "\"Rebellious Imp\",\"Lesser Voidcaller\",\"Netherspace Abyssal\",\"Cross Gazer\",\"Sister of Temptation\",\"Nibbles\",\"Baa'l\""
					elseif playerspec == 3 then
						pets = "\"Rebellious Imp\",\"Lesser Voidcaller\",\"Netherspace Abyssal\",\"Horde Fanatic\",\"Cross Gazer\",\"Sister of Temptation\",\"Nibbles\""
					end
				elseif class == "MONK" then
					pets = "\"Chi-Chi, Hatchling of Chi-Ji\",\"Yu'la, Broodling of Yu'lon\",\"Xu-Fu, Cub of Xuen\",\"Zao, Calfling of Niuzao\""
				elseif class == "DEATHKNIGHT" then
					pets = "\"Bloodbrood Whelpling\",\"Lost of Lordaeron\",\"Blightbreath\",\"Boneshard\",\"Grotesque\",\"Stinkrot\",\"Unborn Val'kyr\",\"Naxxy\""
					if playerspec == 2 then
						pets = "\"Frostbrood Whelpling\",\"Lost of Lordaeron\",\"Mr. Bigglesworth\",\"Boneshard\",\"Landro's Lichling\",\"Unborn Val'kyr\",\"Naxxy\""	
					elseif playerspec == 3 then
						pets = "\"Vilebrood Whelpling\",\"Lost of Lordaeron\",\"Boneshard\",\"Grotesque\",\"Stinkrot\",\"Unborn Val'kyr\",\"Mr. Bigglesworth\",\"Naxxy\""
					end
				elseif class == "DEMONHUNTER" then
					pets = "\"Murkidan\",\"Emmigosa\",\"Abyssius\",\"Micronax\",\"Wyrmy Tunkins\",\"Fragment of Desire\",\"Eye of the Legion\",\"Mischief\",\"Baa'l\""
				end
				EditMacro("WSxSwapper",nil,nil,"/use "..hasBell.."\n/run local a={"..pets.."}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			end 

			if C_Map and C_Map.GetBestMapForUnit("player") then
				local map = C_Map.GetMapInfo(C_Map.GetBestMapForUnit("player"))
				local parent = map.parentMapID and C_Map.GetMapInfo(map.parentMapID) or map
				local ink = "\n/use Moroes' Famous Polish"
				local hasCannon, alt4, alt5, alt6, CZ, AR, conDB, conEF, conAF, conVS, conSET, conST, conSst, conMW, conMS, conTE, conBE, conCE, conRE = "", "", "", "\n/use Goren \"Log\" Roller", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""
				alt4 = ink
				-- Gör ett nytt macro för ExtraActionButton1 som har en Vindicator Matrix ability bundet när du är på Argus, bind detta till CGenB

				EditMacro("WSxCSGen+B",nil,nil,"/run if not InCombatLockdown() then local b = myZA or CreateFrame(\"button\",\"myZA\",nil,\"SecureActionButtonTemplate\");b:SetAttribute(\"type\",\"click\");b:SetAttribute(\"clickbutton\",ZoneAbilityFrame.SpellButton);end\n/click myZA")
				EditMacro("WSxCGen+B",nil,nil,"#showtooltip\n/click ExtraActionButton1")
				if GetItemCount("Darkmoon Cannon") == 1 then 
					hasCannon = "\n/use Darkmoon Cannon"
				end
				if level < 120 and GetItemCount("Lightforged Augment Rune") == 1 then
					AR = "\n/use [nostealth]Lightforged Augment Rune"
				end
			
				local pp = parent and parent.name
				if not pp then
					return
				end

				local hasShark, hasScrapper = "Photo B.O.M.B.","Citizens Brigade Whistle"
    			
			    local bfaZones = ((pp == "Zandalar") or (pp == "Kul Tiras") or (pp == "Zuldazar") or (pp == "Boralus") or (pp == "Dazar'alor") or (pp == "Tiragarde Sound") or (z == "Nazjatar") or (z == "Damprock Cavern") or (z == "Boralus Harbor") or (z == "Tradewinds Market"))

				if bfaZones then
					invisPot = "Stealthman 54"	
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
					CZ = "\n/use Rhan'ka's Escape Plan"
					
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
				elseif parent and parent.name == "Argus" then
					EditMacro("WSxCGen+B",nil,nil,"#showtooltip\n/use Vindicaar Matrix Crystal")
					alt4 = ink.."\n/use Baarut the Brisk"
					alt6 = "\n/use The \"Devilsaur\" Lunchbox"
					CZ = "\n/use Sightless Eye"
				-- Broken Isles is continent 8
				elseif parent and parent.name == "Broken Isles" then
					alt4 = ink
					alt5 = "\n/use Emerald Winds"..hasCannon
					alt6 = "\n/use The \"Devilsaur\" Lunchbox"
					CZ = "\n/use Sightless Eye"
					if z == "Highmountain" then
						alt4 = "\n/use Majestic Elderhorn Hoof"..ink
					end
				-- Draenor is continent 7
				elseif (parent and parent.name == "Draenor") or (parent and parent.name == "Frostfire Ridge") or (parent and parent.name == "Shadowmoon Valley") or (parent and parent.name == "Ashran") then
					alt4 = ink.."\n/use Spirit of Shinri\n/use Skull of the Mad Chief"
					alt5 = "\n/use Breath of Talador"..hasCannon
					alt6 = "\n/use Ever-Blooming Frond"
					CZ = "\n/use Aviana's Feather\n/use Treessassin's Guise"
				-- Pandaria
				elseif (parent and parent.name == "Pandaria") or (parent and parent.name == "Vale of Eternal Blossoms") then
					alt4 = ink.."\n/use Cursed Swabby Helmet\n/use Ash-Covered Horn\n/use Battle Horn"
					alt5 = "\n/use Bottled Tornado"..hasCannon
					alt6 = "\n/use Eternal Warrior's Sigil"
					CZ = "\n/use [combat]Salyin Battle Banner" 
				-- Northrend
				elseif parent and parent.name == "Northrend" then
					alt4 = "\n/use Grizzlesnout's Fang"..ink
				end

				-- array med klass abilities för varje klass, aC == Alt+456 Class ability
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
					["WARRIOR"] = "Charge",
					["DRUID"] = "Remove Corruption", 
					["DEMONHUNTER"] = "Silver-Plated Turkey Shooter",
				}
				-- array med klass abilities för varje klass, PoA == Party or Arena
				local PoA = "@party"
				if (class == "DEATHKNIGHT" or class == "WARRIOR") then
					PoA = "@arena"
				end
				EditMacro("wWBGHealer1",nil,nil,"/cleartarget")
				EditMacro("wWBGHealer2",nil,nil,"/cleartarget")        
				EditMacro("wWBGHealer3",nil,nil,"/cleartarget")
				EditMacro("WSxGenU",nil,nil,"#showtooltip\n/use "..consOne)
			    EditMacro("WSxSGen+U",nil,nil,"#showtooltip\n/use "..consTwo)
			    EditMacro("WSxCGen+U",nil,nil,"#showtooltip\n/use "..consThree)	
				EditMacro("wWBGHealerisSet1",nil,nil,"/use [mod:alt,"..PoA.."1,exists]"..numaltcc[class]..";[mod:ctrl,"..PoA.."1,exists]"..numctrlcc[class]..";["..PoA.."1,exists]"..numnomodcc[class])
				EditMacro("wWBGHealerisSet2",nil,nil,"/use [mod:alt,"..PoA.."2,exists]"..numaltcc[class]..";[mod:ctrl,"..PoA.."2,exists]"..numctrlcc[class]..";["..PoA.."2,exists]"..numnomodcc[class])        
				EditMacro("wWBGHealerisSet3",nil,nil,"/use [mod:alt,"..PoA.."3,exists]"..numaltcc[class]..";[mod:ctrl,"..PoA.."3,exists]"..numctrlcc[class]..";["..PoA.."3,exists]"..numnomodcc[class])
				
--[[				DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: New area detected: "..parent.name..".\nRecalibrating zone based macros :)",0.5,1.0,0.0)--]]			

				EditMacro("WMPAlt+4",nil,nil,"/target [nomod]Boss1\n/target [nomod]Arena1\n/use [mod:ctrl"..PoA.. "1]"..aC[class]..""..alt4.."\n/run DepositReagentBank();")
				EditMacro("WMPAlt+5",nil,nil,"/target [nomod]Boss2\n/target [nomod]Arena2\n/use [mod:ctrl"..PoA.. "2]"..aC[class]..""..alt5)
				EditMacro("WMPAlt+6",nil,nil,"/target [nomod]Boss3\n/target [nomod]Arena3\n/use [mod:ctrl"..PoA.. "3]"..aC[class]..""..alt6)
				-- (Shaman är default/fallback)
				local ccz = "[spec:3]Waterspeaker's Totem\n/use Lightning Shield\n/use Haunting Memento\n/use Trawler Totem"
				if class == "MAGE" then
					ccz = "Dalaran Initiates' Pin\n/use [combat,help,nodead][nocombat]Arcane Intellect\n/use [combat]Invisibility"
				elseif class == "WARLOCK" then
					ccz = "Lingering Wyrmtongue Essence\n/use [nocombat]Heartsbane Grimoire\n/use Unending Breath"
				elseif class == "MONK" then
					ccz = ""
				elseif class == "PALADIN" then
					ccz = "[spec:3]Greater Blessing of Kings"
				elseif class == "HUNTER" then
					ccz = "Aspect of the Chameleon\n/use [nocombat]!Camouflage\n/use Zanj'ir Weapon Rack" 
				elseif class == "ROGUE" then
					ccz = "[combat]Vanish;[stance:0,nocombat]Stealth;[spec:1]Deadly Poison;Slightly-Chewed Insult Book"
				elseif class == "PRIEST" then
					ccz = "Power Word: Fortitude\n/use Haunting Memento\n/cancelaura Spirit of Redemption"
				elseif class == "DEATHKNIGHT" then
					ccz = "Haunting Memento\n/use [nopet,spec:3]Raise Dead"
				elseif class == "WARRIOR" then
					ccz = "Battle Shout\n/use Shard of Archstone\n/use Vrykul Toy Boat Kit"
				elseif class == "DRUID" then
					ccz = "Fandral's Seed Pouch\n/use !Prowl"
				elseif class == "DEMONHUNTER" then
					ccz = "Lingering Wyrmtongue Essence\n/cancelaura Wyrmtongue Disguise"
				end
				
				if ccz and CZ and AR then
					EditMacro("WSxCGen+Z",nil,nil,"/use [nostealth]Repurposed Fel Focuser\n/use Seafarer's Slidewhistle\n/use "..ccz..""..CZ..""..AR)
					--DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Recalibrating zone based variables :)\nalt4 = "..alt4.."\nalt5 = "..alt5.."\nalt6 = "..alt6.."\nCZ = "..CZ.."\nccz = "..ccz.."\naC = "..aC.."\nPoA = "..PoA.."\nAR = "..AR.."\nconTE = "..conTE.."\nconRE = "..conRE.."\nconBE = "..conBE.."\nconCE = "..conCE,0.5,1.0,0.0)
				end			
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
					"Superior Healing Potion",
					"Major Healing Potion",
					"Runic Healing Potion",
					"Super Healing Potion",
					"Ancient Healing Potion",
					"Aged Health Potion",
					"Astral Healing Potion",
					"Coastal Healing Potion",
					"Abyssal Healing Potion",
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
				elseif GetZoneText() == "Brawl'gar Arena" then
					hasTonicInBags = "Brawler's Coastal Healing Potion"
				elseif instanceType == "pvp" and GetItemCount("\"Third Wind\" Potion") >= 1 then 
					hasTonicInBags = "\"Third Wind\" Potion"
				end
				-- overrides potion
				-- Grenades addon "Ctrl+Shift+E"
			
		    	EditMacro("WGrenade",nil,nil,"#showtooltip [mod]"..hasScrapper..";"..hasShark.."\n/use Hot Buttered Popcorn\n/use [mod]"..hasScrapper..";"..hasShark)
				EditMacro("WTonic",nil,nil,"#showtooltip [mod]Foul Belly;"..hasTonicInBags.."\n/use Foul Belly\n/use "..hasTonicInBags)
			end
		end

		-- Byta talent eller zone events
		if (event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "ZONE_CHANGED_NEW_AREA") then
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
				EditMacro("Wx3ShowPot", nil, nil, "#showtooltip\n/use Saltwater Potion", 1, 1)
			elseif primary == "int" and GetItemCount(169299, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#showtooltip\n/use Potion of Unbridled Fury", 1, 1)
			elseif primary == "int" and GetItemCount(168498, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#showtooltip\n/use Superior Battle Potion of Intellect", 1, 1)
			elseif primary == "agi" and GetItemCount(168489, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#showtooltip\n/use Superior Battle Potion of Agility", 1, 1)
			elseif primary == "str" and GetItemCount(168500, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#showtooltip\n/use Superior Battle Potion of Strength", 1, 1)
			elseif primary == "int" and GetItemCount(163222, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#showtooltip\n/use Battle Potion of Intellect", 1, 1)
			elseif primary == "agi" and GetItemCount(163223, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#showtooltip\n/use Battle Potion of Agility", 1, 1)
			elseif primary == "str" and GetItemCount(163224, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#showtooltip\n/use Battle Potion of Strength", 1, 1)
			elseif GetItemCount(169299, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#showtooltip\n/use Potion of Unbridled Fury", 1, 1)
			elseif GetItemCount(142117, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#showtooltip\n/use Potion of Prolonged Power", 1, 1)
			else
				EditMacro("Wx3ShowPot", nil, 132380, "#showtooltip", 1, 1)
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
					print(name)
				end
			end

			-- Redigera macron
			for i = 1, 3 do
				if PvPTalentNames[i] == "Drink Up Me Hearties" then
					PvPTalentNames[i] = "Create: Crimson Vial"
					PvPTalentIcons[i] = 463862
				end
				
				if UnitIsPVP("player") == true then
					if class == "SHAMAN" and PvPTalentNames[i] == "Skyfury Totem" then
						shaPvPExc = "[talent:6/2]Fire Elemental;Skyfury Totem"
					elseif class == "MAGE" and PvPTalentNames[i] == "Greater Pyroblast" then
						magPvPExcTwo = "[@mouseover,harm,nodead][]Greater Pyroblast"
					elseif class == "WARLOCK" then
						if PvPTalentNames[i] == "Call Felhunter" then
							locPvPExcQQ = "[@mouseover,harm,nodead][]Call Felhunter"
							locPvPExcGenF = "[@focus,harm,nodead]Call Felhunter;"
						end
						if PvPTalentNames[i] == "Call Fel Lord" then
							locPvPExcSeven = "[mod:alt,@player][@cursor]Call Fel Lord;"
						end
					elseif class == "HUNTER" then
						if PvPTalentNames[i] == "Dire Beast: Basilisk" then 
							hunPvPExcSTree = ";[]Dire Beast: Basilisk"
						end
						if PvPTalentNames[i] == "Dire Beast: Hawk" then 
							hunPvPExcSFour = "[mod:alt,@player][@cursor]Dire Beast: Hawk;"
						end
					elseif class == "WARRIOR" and PvPTalentNames[i] == "Death Wish" then
						warPvPExc = "[]Death Wish;"
					end
				end

				if PvPTalentNames[i] then
--[[					print(PvPTalentNames[i])
					print(PvPTalentIcons[i])--]]
					-- Talent finns
					EditMacro("PvPAT " .. i, nil, PvPTalentIcons[i], "#showtooltip\n/stopspelltarget [mod]\n/use [@mouseover,exists,nodead][@cursor,noexists]" .. PvPTalentNames[i])
				else
					EditMacro("PvPAT " .. i, nil, 237554, "")
			    end
			end

			local wmpaltcc = {
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
			local wmpctrlcc = {
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
			if class == "ROGUE" and playerspec == 2 then
				wmpctrlcc[class] = "Between The Eyes"
			end
			local wmpnomodcc = {
				["SHAMAN"] = "Wind Shear",
				["MAGE"] = "Counterspell",
				["WARLOCK"] = "Call Felhunter",
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
				end
			end 
			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1]"..wmpaltcc[class]..";[mod:ctrl,@arena1]"..wmpctrlcc[class].."\n/use [@arena1,exists][@boss1,exists]"..wmpnomodcc[class]..";" ..one)
			EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2]"..wmpaltcc[class]..";[mod:ctrl,@arena2]"..wmpctrlcc[class].."\n/use [@arena2,exists][@boss2,exists]"..wmpnomodcc[class]..";" ..two)        
			EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3]"..wmpaltcc[class]..";[mod:ctrl,@arena3]"..wmpctrlcc[class].."\n/use [@arena3,exists][@boss3,exists]"..wmpnomodcc[class]..";" ..tre)

			-- Target Calling Macro    
			EditMacro("WACommandKill",nil,nil,"/stopmacro [noexists]\n/run if UnitRace(\"target\") then SendChatMessage(\"Kill my target NOW! ->> %t the \"..(UnitRace(\"target\")..\" \"..UnitClass(\"target\"))..\" \", IsInGroup(2) and \"instance_chat\" or IsInRaid() and \"raid\" or IsInGroup() and \"party\" or \"say\")end")

			EditMacro("Wx5Trinket2",nil,nil,"#showtooltip 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use Eternal Black Diamond Ring\n/use [nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14")
			EditMacro("Wx1Trinkit",nil,nil,"#showtooltip\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Honorable Pennant\n/use Rallying War Banner")
				
			if (class == "WARLOCK" or class == "DEMONHUNTER") then
				EditMacro("Wx5Trinket2",nil,nil,"#showtooltip 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use Eternal Black Diamond Ring\n/use [nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Fractured Necrolyte Skull;[help,dead,nocombat]Cremating Torch;14")
			elseif class == "MONK" then
				EditMacro("Wx1Trinkit",nil,nil,"/use Honorable Medallion\n/use [nocombat]Wand of Simulated Life\n/use Attraction Sign\n/use Honorable Pennant\n/run local j,p,_=C_PetJournal _,p=j.FindPetIDByName(\"Alterac Brew-Pup\") if p and j.GetSummonedPetGUID()~=p then j.SummonPetByGUID(p) end")
			elseif class == "HUNTER" then
				EditMacro("Wx5Trinket2",nil,nil,"#showtooltip 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use Eternal Black Diamond Ring\n/use [nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Warbeast Kraal Dinner Bell;14")
			elseif class == "ROGUE" then
				if playerspec == 2 then
					EditMacro("Wx1Trinkit",nil,nil,"#showtooltip\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Jolly Roger\n/use Rallying War Banner\n/cancelaura [spec:2]Honorable Pennant")
				else
					EditMacro("Wx1Trinkit",nil,nil,"#showtooltip\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Honorable Pennant\n/use Rallying War Banner\n/cancelaura [nospec:2]A Mighty Pirate")
				end
			end 
			
			if racials[race] then
				if race == "VoidElf" then
					EditMacro("Wx6RacistAlt+V",nil,nil,"#showtooltip " ..racials[race].."\n/use Prismatic Bauble\n/use Sparklepony XL\n/castsequence reset=9 "..racials[race]..",Languages")
				else
					EditMacro("Wx6RacistAlt+V",nil,nil,"#showtooltip " ..racials[race].."\n/use Prismatic Bauble\n/use Sparklepony XL\n/use "..racials[race])
				end
				-- Main Class configuration
				-- Shaman
				if class == "SHAMAN" then
					EditMacro("WSkillbomb",nil,nil,"/use [spec:1]Fire Elemental;[spec:2]Feral Spirit\n/use Rukhmar's Sacred Memory\n/use Ascendance"..dpsRacials[race].."\n/use 13\n/use Flippable Table\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")	
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[nocombat]Ancestral Spirit;"..pwned.."\n/use [mod:ctrl]Ancestral Vision\n/use [mod:ctrl]Brazier of Awakening")
					EditMacro("WSxSGen+1",nil,nil,"#showtooltip [spec:3]Spirit Link Totem;Haunted War Drum\n/use [mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Healing Surge\n/use [noexists,nocombat]Haunted War Drum\n/tar Reaves\n/tar Captain Krooz")
					EditMacro("WSxGen2",nil,nil,"#showtooltip\n/use [nocombat,noexists]Raging Elemental Stone;[spec:2]Rockbiter;Lightning Bolt\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
					EditMacro("WSxSGen+2",nil,nil,"#showtooltip\n/use [@mouseover,help,nodead][]Healing Surge\n/cancelaura X-Ray Specs\n/use Gnomish X-Ray Specs")
					EditMacro("WSxCSGen+2",nil,nil,"/use [spec:3,@focus,help,nodead][spec:3,@party1,help,nodead]Purify Spirit;[@focus,help,nodead][@party1,help,nodead]Cleanse Spirit;[nocombat,noharm]Spirit Wand;")
					EditMacro("WSxGen3",nil,nil,"#showtooltip\n/startattack\n/targetenemy [noexists]\n/use [nocombat,noexists]Tadpole Cloudseeder;[spec:2]Stormstrike;[@mouseover,harm,nodead][]Lava Burst\n/cleartarget [dead]")
					EditMacro("WSxSGen+3",nil,nil,"#showtooltip Flame Shock\n/cleartarget [dead]\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead,nomod][nomod]Flame Shock\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Flame Shock\n/targetlasttarget")
					EditMacro("WSxCSGen+3",nil,nil,"/use [spec:3,@focus,help,nodead][spec:3,@party2,help,nodead]Purify Spirit;[nospec:2,@focus,harm,nodead]Flame Shock;[@party2,help,nodead]Cleanse Spirit;[nocombat,noharm]Cranky Crab;\n/cleartarget [dead]\n/stopspelltarget")
					EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [@mouseover,help,nodead][]Chain Heal;[spec:2]Flametongue;[spec:1,talent:1/3]Elemental Blast;[spec:1,talent:6/3]Frost Shock;[spec:1]Earth Shock;\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [talent:7/3]Ascendance;[spec:2,talent:7/2]Earthen Spike;[spec:3,talent:7/2]Wellspring;[spec:1,talent:7/2]Stormkeeper\n/targetenemy [noexists]")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead]Earth Shield")
					EditMacro("WSxGen5",nil,nil,"#showtooltip [spec:1]Earth Shock;[spec:2]Lava Lash;Healing Stream Totem;\n/use [mod:ctrl,@player]Earth Elemental;[spec:1]Earth Shock;[spec:2]Lava Lash;[@mouseover,help,nodead][]Healing Wave;\n/targetenemy [noexists]\n/use Words of Akunda")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,help,nodead][@party2,help,nodead]Earth Shield")
					EditMacro("WSxGen6",nil,nil,"/use [mod:ctrl,spec:2]Feral Spirit;[mod:ctrl,spec:3]Mana Tide Totem;[mod:ctrl,@player]Fire Elemental;[spec:2]Crash Lightning;[spec:3,@cursor]Healing Rain;[@mouseover,harm,nodead][]Chain Lightning;\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+6",nil,nil,"/use [spec:1,talent:2/2]Echoing Shock;[spec:1,talent:2/3]Totem Mastery;[spec:1,@player]Earthquake;[spec:2,talent:6/2]Fury of Air;[spec:3]Healing Tide Totem\n/use [nocombat,noexists]Goren \"Log\" Roller\n/use Orb of Deception\n/leavevehicle")
					EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [spec:1,mod:shift,@player][spec:1,@cursor]Earthquake;[spec:2]Frostbrand;Chain Lightning\n/startattack\n/use Bom'bay's Color-Seein' Sauce\n/use [noexists,nocombat]Moonfang's Paw")
					EditMacro("WSxQQ",nil,nil,"/stopcasting [nomod:alt]\n/use [mod:alt,@focus,harm,nodead]Hex;[mod:shift]Tremor Totem;[help]Foot Ball;[nocombat,noexists]The Golden Banana;[@mouseover,harm,nodead][]Wind shear;")
					EditMacro("WSxStuns",nil,nil,"#showtooltip [mod:alt,spec:3,@player]Healing Rain;[nocombat,noexists]Party Totem;Capacitor Totem\n/use [mod:alt,spec:3,@player]Healing Rain;[@cursor]Capacitor Totem;\n/use Haunting Memento\n/use [nocombat,noexists]Party Totem")
					EditMacro("WSxRTS",nil,nil,"#show Earthbind Totem\n/use [mod:alt]MOLL-E;[mod:shift,@cursor][nomod,spec:3,notalent:3/2]Earthbind Totem;[@mouseover,harm,nodead][]Frost Shock\n/targetenemy [noharm]\n/cleartarget [dead]")
					EditMacro("WSxClassT",nil,nil,"/targetenemy [noexists]\n/cleartarget [dead]\n/use [help,nocombat]Swapblaster;[spec:3,talent:3/2,@cursor]Earthgrab Totem;[@mouseover,help,nodead][]Chain Heal\n/use [nocombat]Trans-Dimensional Bird Whistle")
					EditMacro("WSxGenF",nil,nil,"#showtooltip\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@cursor]Far Sight;[@focus,harm,nodead]Wind Shear;Mrgrglhjorn\n/use Survey")
					EditMacro("WSxSGen+F",nil,nil,"#showtooltip\n/use [nocombat,noexists,mod:alt]Gastropod Shell;[nocombat,noexists,nomod]Totem of Harmony\n/cancelform [mod:alt]")
					EditMacro("WSxCGen+F",nil,nil,"#showtooltip [mod]Firefury Totem;Hex;\n/use [spec:1,talent:5/2]Ancestral Guidance\n/use Firefury Totem\n/cancelaura Thistleleaf Disguise")
					EditMacro("WSxCAGen+F",nil,nil,"#showtooltip [spec:3]Spiritwalker's Grace;[spec:2]Spirit Walk;Deceptia's Smoldering Boots;\n/use Deceptia's Smoldering Boots")
					EditMacro("WSxGG",nil,nil,"/use [mod:alt]Darkmoon Gazer;[@mouseover,harm,nodead]Purge;[spec:3,@mouseover,help,nodead][spec:3]Purify Spirit;[@mouseover,help,nodead][]Cleanse Spirit\n/targetenemy [noexists]\n/use Poison Extraction Totem")
					EditMacro("WSxSGen+H",nil,nil,"/use [nomounted]Darkmoon Gazer\n/stopmacro [combat]\n/run if not (IsControlKeyDown()) then if IsMounted() then DoEmote\"mountspecial\"; else DoEmote\"kneel\" end end")
					EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:alt]Flametongue Weapon;[mod:shift,@cursor,spec:3]Spirit Link Totem;Astral Shift\n/use Whole-Body Shrinka'")
					EditMacro("WSxMove",nil,nil,"/use [talent:5/3,@cursor]Wind Rush Totem;[spec:1,talent:5/2]Ancestral Guidance;[spec:2,talent:5/2]Feral Lunge;[noform]Ghost Wolf\n/use Panflute of Pandaria\n/use Croak Crock\n/cancelaura Rhan'ka's Escape Plan\n/use Desert Flute")
					EditMacro("WSxCGen+V",nil,nil,"/use [mod:alt,nocombat]"..passengerMount..";[nocombat,noexists]Silversage Incense\n/use [nomod] Water Walking\n/use [swimming] Barnacle-Encrusted Gem\n/use [nomod] Whispers of Rai'Vosh")   
					EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"\\#showtooltip Tremor Totem\\n/use [mod:shift,@\"..B..\"]Healing Surge;[@\"..B..\"]Earth Shield\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"\\#showtooltip Reincarnation\\n/use [mod:shift,@\"..N..\"]Healing Surge;[@\"..N..\"]Earth Shield\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
					EditMacro("WSxSRBGCC+1",nil,nil,"/run if not InCombatLockdown()then local C=UnitName(\"target\") EditMacro(\"WSxRBGCC+1\",nil,nil,\"/cleartarget\n/target \"..C..\"\n/use [mod]Hex;[nomod]Wind Shear;\n/targetlasttarget\", nil)print(\"RBGCC1 : \"..C)else print(\"Combat!\")end")
					EditMacro("WSxRBGCC+1",nil,nil,"")
					EditMacro("WSxSRBGCC+2",nil,nil,"/run if not InCombatLockdown()then local C=UnitName(\"target\") EditMacro(\"WSxRBGCC+2\",nil,nil,\"/cleartarget\n/target \"..C..\"\n/use [mod]Hex;[nomod]Wind Shear;\n/targetlasttarget\", nil)print(\"RBGCC2 : \"..C)else print(\"Combat!\")end")
					EditMacro("WSxRBGCC+2",nil,nil,"")
					EditMacro("WSxSRBGCC+3",nil,nil,"/run if not InCombatLockdown()then local C=UnitName(\"target\") EditMacro(\"WSxRBGCC+3\",nil,nil,\"/cleartarget\n/target \"..C..\"\n/use [mod]Hex;[nomod]Wind Shear;\n/targetlasttarget\", nil)print(\"RBGCC3 : \"..C)else print(\"Combat!\")end")
					EditMacro("WSxRBGCC+3",nil,nil,"")
					EditMacro("WSxT15",nil,nil,"#showtooltip [spec:3,talent:1/3]Unleash Life;[spec:1,talent:1/3]Elemental Blast;[spec:2,talent:1/3]Lightning Shield;[spec:1/3]Flame Shock;Lightning Bolt\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#showtooltip\n/use [mod:alt,@player]Capacitor Totem;[spec:3,talent:2/3]Earth Shield;[spec:1,talent:2/2]Echoing Shock;[nospec:3,talent:2/3]Totem Mastery"..oOtas)
					EditMacro("WSxT45",nil,nil,"#showtooltip\n/use [mod:alt,@player]Earthbind Totem;Healing Stream Totem\n/use Arena Master's War Horn\n/use Totem of Spirits\n/use [nocombat]Void-Touched Souvenir Totem")
					EditMacro("WSxT60",nil,nil,"#showtooltip [spec:3,talent:4/2]Earthen Wall Totem;[spec:3,talent:4/3]Ancestral Protection Totem;[spec:1,talent:4/3]Liquid Magma Totem;Vol'Jin's Serpent Totem;\n/use Vol'Jin's Serpent Totem;\n/click TotemFrameTotem1 RightButton\n/cry")
					EditMacro("WSxT100",nil,nil,"#showtooltip [mod:ctrl]Bloodlust;[talent:7/3]Ascendance;[spec:2,talent:7/2]Earthen Spike;[spec:3,talent:7/2]Wellspring;[spec:1,talent:7/2]Stormkeeper;")
					EditMacro("WSxCSGen+G",nil,nil,"#showtooltip Tremor Totem\n/use [@focus,harm,nodead]Purge;[spec:3,@focus,help,nodead]Purify Spirit;[@focus,help,nodead]Cleanse Spirit")
					EditMacro("WSxGND",nil,nil,"/use [mod:ctrl]Astral Recall;[mod,spec:2]Spirit Walk;[mod]Spiritwalker's Grace;[@mouseover,talent:3/2,help,nodead][@mouseover,spec:3,help,nodead][talent:3/2][spec:3]Earth Shield\n/use Void Totem\n/use [nocombat,spec:3]Bubble Wand\n/cancelaura Bubble Wand")
					if playerspec == 1 then
						EditMacro("WSxGen1",nil,nil,"/use [@mouseover,harm,nodead,talent:6/3][harm,talent:6/3]Frost Shock;[@mouseover,harm,nodead][harm,nodead]Flame Shock\n/use Xan'tish's Flute\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxT90",nil,nil,"#showtooltip [talent:6/1]Earth Shock;[talent:6/2]Fire Elemental;[talent:6/3]Icefury")
						if not shaPvPExc then
							return
						end
						EditMacro("WSxSGen+4",nil,nil,"/use [noexists,nocombat]Sen'jin Spirit Drum;[talent:4/2,pet:Primal Storm Elemental]Call Lightning;[pet:Primal Fire Elemental,@mouseover,harm,nodead][pet:Primal Fire Elemental]Meteor;[talent:6/3]Icefury;"..shaPvPExc.."\n/startattack")
						EditMacro("WSxSGen+5",nil,nil,"/use [mod,talent:4/3,@player][talent:4/3,@cursor]Liquid Magma Totem;[talent:4/2,pet:Primal Storm Elemental,@mouseover,harm,nodead][pet:Primal Storm Elemental]Eye of the Storm;[talent:6/2]Fire Elemental\n/use [nocombat]Lava Fountain\n/targetenemy [noexists]")
						EditMacro("WSxCC",nil,nil,"/use [mod,@mouseover,harm,nodead][mod]Hex;[@mouseover,help,nodead][]Thunderstorm\n/use Thistleleaf Branch\n/run local j,p,_=C_PetJournal _,p=j.FindPetIDByName(\"Frostwolf Ghostpup\") if p and j.GetSummonedPetGUID()~=p then j.SummonPetByGUID(p)end")
					elseif playerspec == 2 then
						EditMacro("WSxGen1",nil,nil,"#showtooltip\n/castsequence [talent:2/3] reset=5/combat Totem Mastery,Stormbringer\n/use [@mouseover,harm,nodead,notalent:2/3][exists,nodead,notalent:2/3]Lightning Bolt\n/use [noexists]Xan'tish's Flute\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxT90",nil,nil,"#showtooltip [talent:6/1]Crashing Storm;[talent:6/2]Fury of Air;[talent:6/3]Sundering")
						EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/use [mod:alt,@party3,nodead]Healing Surge;[nocombat,noexists]Sen'jin Spirit Drum;[talent:6/3]Sundering;[talent:6/2]!Fury of Air")
						EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/use [mod:alt,@party4,nodead]Healing Surge;Lava Fountain")
						EditMacro("WSxCC",nil,nil,"/use [mod,@mouseover,harm,nodead][mod]Hex;Feral Spirit\n/use Thistleleaf Branch\n/run local j,p,_=C_PetJournal _,p=j.FindPetIDByName(\"Frostwolf Ghostpup\") if p and j.GetSummonedPetGUID()~=p then j.SummonPetByGUID(p)end")
					else
						EditMacro("WSxGen1",nil,nil,"#showtooltip\n/use [noexists]Xan'tish's Flute\n/use [talent:1/3]Unleash Life;[@mouseover,harm,nodead][harm,nodead]Flame Shock\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxT90",nil,nil,"#showtooltip [talent:6/1]Flash Flood;[talent:6/2]Downpour;[talent:6/2]Cloudburst Totem\n/use Spirit Link Totem")
						EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/use [@party1,help,nodead,mod:alt]Riptide;[nocombat,noexists]Sen'jin Spirit Drum;[talent:6/2,@cursor]Downpour;Healing Stream Totem")
						EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/use [@party2,help,nodead,mod]Riptide;[talent:4/2,@cursor]Earthen Wall Totem;[talent:4/3,@cursor]Ancestral Protection Totem\n/use Lava Fountain")
						EditMacro("WSxCC",nil,nil,"/use [mod,@mouseover,harm,nodead][mod]Hex;[@mouseover,help,nodead][]Riptide\n/use Thistleleaf Branch\n/run local j,p,_=C_PetJournal _,p=j.FindPetIDByName(\"Frostwolf Ghostpup\") if p and j.GetSummonedPetGUID()~=p then j.SummonPetByGUID(p)end")
					end
					
				-- Mage, maggi, nooniverse

				elseif class == "MAGE" then
					EditMacro("WSkillbomb",nil,nil,"#showtooltip\n/use [spec:3]Icy Veins;[spec:1]Arcane Power;[spec:2]Combustion"..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use 13\n/use Mirror Image\n/use Heart Essence\n/use Hearthstone Board\n/use Big Red Raygun")
					EditMacro("WSxT15",nil,nil,"#showtooltip [spec:3,talent:1/3]Ice Nova;[spec:1,talent:1/3]Arcane Familiar;[spec:2]Scorch;Frost Nova\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#showtooltip\n/use [spec:3,talent:2/3]Ice Floes;[spec:2,talent:2/3]Blast Wave;Blazing Wings"..oOtas)
					EditMacro("WSxT45",nil,nil,"#showtooltip [talent:3/3]Rune of Power;[talent:3/2]Mirror Image;Polymorph\n/use [mod:alt,spec:3,@player,pet]Freeze;Frost Nova")
					EditMacro("WSxT90",nil,nil,"#showtooltip [spec:3,talent:6/3]Comet Storm;[spec:1,talent:6/1]Nether Tempest;[spec:2,talent:6/1]Living Bomb;Ancient Mana Basin\n/use [mod:alt,@player,talent:5/3][@cursor,talent:5/3]Ring of Frost")
					EditMacro("WSxT100",nil,nil,"#showtooltip [spec:3,talent:7/3]Glacial Spike;[spec:3,talent:7/2]Ray of Frost;[spec:1,talent:7/3]Arcane Orb;[spec:2,talent:7/3]Meteor")
					EditMacro("WSxCSGen+G",nil,nil,"#showtooltip [spec:3]Cold Snap;Spellsteal\n/use [@focus,harm,nodead]Spellsteal\n/use Poison Extraction Totem")
					EditMacro("WSxT60",nil,nil,"#showtooltip [spec:1,talent:4/3]Supernova;[spec:3,talent:4/3]Ebonbolt;[spec:1,talent:4/2]Charged up;[spec:2,talent:4/3]Phoenix Flames\n/use Worn Doll\n/run PetDismiss();\n/cry")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned.."\n/use [mod:ctrl]Brazier of Awakening")
					EditMacro("WSxGen1",nil,nil,"/targetenemy [noharm,nodead]\n/use [nocombat,noexists]Dazzling Rod\n/use [spec:3,talent:7/2]Ray of Frost;[spec:3,talent:7/3]Glacial Spike;[@mouseover,spec:2,harm,nodead][spec:2]Scorch;[spec:1]Presence of Mind;Ice Lance\n/cleartarget [spec:2,talent:5/1]")
					EditMacro("WSxSGen+1",nil,nil,"/use [mod:ctrl,@party2target,harm,nodead][@focustarget,harm,nodead][@party1target,harm,nodead]Polymorph;[noexists,nocombat]Manastorm's Duplicator\n/tar Reaves\n/tar Captain Krooz")
					EditMacro("WSxGen2",nil,nil,"#showtooltip\n/use [noexists,nocombat]Akazamzarak's Spare Hat;[spec:1]Arcane Blast;[spec:3]Frostbolt;"..magPvPExcTwo.."\n/targetenemy [noharm]\n/cleartarget [dead]\n/use [nocombat,noexists]Kalec's Image Crystal")
					EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead]Remove Curse")
					EditMacro("WSxGen3",nil,nil,"/use [nocombat,noexists]Shado-Pan Geyser Gun;[spec:3,@cursor]Frozen Orb;[@mouseover,harm,nodead,spec:2][spec:2]Pyroblast;[talent:7/3]Arcane Orb;Evocation\n/startattack\n/cancelaura [combat]Shado-Pan Geyser Gun\n/stopmacro [combat]\n/click ExtraActionButton1")
					EditMacro("WSxCSGen+3",nil,nil,"#showtooltip\n/use [spec:2,@focus,harm,nodead]Pyroblast;[@party2,help,nodead]Remove Curse;[exists,nodead]Magical Saucer\n/targetenemy [noharm]\n/cleartarget [dead][nocombat,noharm]\n/stopspelltarget")
					EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [nocombat,noexists]Memory Cube;[spec:3]Flurry;[spec:1]Arcane Missiles;[@mouseover,harm,nodead,spec:2][spec:2]Fireball\n/targetenemy [noexists]\n/cleartarget [dead]\n/stopspelltarget")
					EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [spec:1,talent:3/1]Evocation;[talent:3/2]Mirror Image;[talent:3/3]Rune of Power\n/use [nocombat,noexists]Faded Wizard Hat")
					EditMacro("WSxCSGen+4",nil,nil,"#showtooltip\n/use [spec:2,@focus,harm,nodead]Fireball;[@focus,help,nodead][@party1,help,nodead]Slow Fall;Pink Gumball\n/targetenemy [noharm]\n/cleartarget [dead][nocombat,noharm]\n/stopspelltarget")
					EditMacro("WSxGen5",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead,spec:1][spec:1]Arcane Barrage;[nospec:1,@mouseover,harm,nodead][nospec:1]Fire Blast")
					EditMacro("WSxCSGen+5",nil,nil,"#showtooltip Ice Block\n/use [@party2,help,nodead]Slow Fall")
					EditMacro("WSxGen6",nil,nil,"#showtooltip\n/use [spec:3,mod:ctrl]Icy Veins;[spec:1,mod:ctrl]Arcane Power;[spec:2,mod:ctrl]Combustion;[spec:3,@cursor]Blizzard;[spec:1]Arcane Explosion;[spec:2,@cursor]Flamestrike\n/stopspelltarget [spec:2]")
					EditMacro("WSxSGen+6",nil,nil,"/use [nocombat,noexists]Mystical Frosh Hat\n/use [spec:1,talent:1/3]Arcane Familiar;[spec:2,talent:4/3]Phoenix Flames;[spec:2,talent:7/3]Meteor;[spec:2,@player]Flamestrike;[spec:3,@player]Blizzard\n/targetenemy [noharm]\n/cleartarget [noharm]")
					EditMacro("WSxGen7",nil,nil,"#show\n/use [mod,spec:2,@player]Flamestrike;[spec:1,talent:4/3]Supernova;[spec:1,talent:4/2]Charged up;[spec:3,talent:4/1]Ice Nova;[spec:2]Dragon's Breath;[spec:1]Arcane Explosion;Cone of Cold")
					EditMacro("WSxQQ",nil,nil,"#showtooltip\n/stopcasting [nomod]\n/use [mod:alt,@focus,harm,nodead]Polymorph;[mod:shift]Winning Hand;[@mouseover,harm,nodead][]Counterspell\n/use [mod:shift]Ice Block;")
					EditMacro("WSxStuns",nil,nil,"#showtooltip\n/use [spec:1,talent:4/3]Supernova;[spec:2,talent:2/3]Blast Wave;[spec:3,talent:1/3]Ice Nova;Frost Nova")
					EditMacro("WSxRTS",nil,nil,"/use [noexists,mod:alt]MOLL-E;[spec:3,mod,nopet]Summon Water Elemental;[spec:3,mod,@cursor]Freeze;[spec:2,mod,@player]Flamestrike;[@mouseover,help,nodead]Slow Fall;[spec:3]Cone of Cold;[spec:2]Dragon's Breath;[@mouseover,harm,nodead][]Slow")
					EditMacro("WSxClassT",nil,nil,"#show [spec:3,notalent:1/2]Summon Water Elemental;[spec:1]Displacement;Frost Nova\n/use [help,nocombat]Swapblaster;[nocombat]Trans-Dimensional Bird Whistle\n/use [spec:1,nocombat]Arcano-Shower\n/petattack [@mouseover,harm,nodead][]")
					EditMacro("WSxGenF",nil,nil,"#showtooltip\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/stopcasting [nomod]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Counterspell;Mrgrglhjorn\n/use Survey")
					EditMacro("WSxSGen+F",nil,nil,"#showtooltip Familiar Stone\n/cancelaura [mod:alt] Shado-Pan Geyser Gun\n/use [mod:alt,nocombat,noexists]Gastropod Shell;[nomod]Arcane Familiar Stone\n/use [nomod]Fiery Familiar Stone\n/use [nomod]Icy Familiar Stone\n/use [nomod]Familiar Stone")
					EditMacro("WSxCGen+F",nil,nil,"#showtooltip [combat]Invisibility;Ice Block")
					EditMacro("WSxGG",nil,nil,"#showtooltip\n/targetenemy [noharm]\n/use [mod:alt]Darkmoon Gazer;[@mouseover,harm,nodead]Spellsteal;[@mouseover,help,nodead][]Remove Curse\n/use [noexists,nocombat]Set of Matches")
					EditMacro("WSxSGen+H",nil,nil,"#showtooltip\n/targetenemy [noharm]\n/use Nat's Fishing Chair\n/use Home Made Party Mask\n/stopmacro [combat]\n/run if not (IsControlKeyDown()) then if IsMounted() then DoEmote\"mountspecial\"; else DoEmote\"kneel\" end end")
					EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [nocombat]Invisibility;!Ice Block")
					EditMacro("WSxGND",nil,nil,"#showtooltip\n/use [mod:alt]Conjure Refreshment;[mod:ctrl]Teleport: Hall of the Guardian;[spec:1,mod:shift]Displacement;[spec:1]Prismatic Barrier;[spec:2]Blazing Barrier;[spec:3]Ice Barrier\n/use [nomod,spec:2]Blazing Wings")
					EditMacro("WSxCC",nil,nil,"#showtooltip\n/use [mod:shift,spec:3]Cold Snap;[@mouseover,harm,nodead][]Polymorph\n/cancelaura X-Ray Specs")
					EditMacro("WSxMove",nil,nil,"#showtooltip\n/use Blink\n/dismount [mounted]\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use [spec:2]Blazing Wings")
					EditMacro("WSxCGen+V",nil,nil,"#showtooltip Frost Nova\n/use [mod:alt,nocombat]"..passengerMount..";[swimming] Barnacle-Encrusted Gem;Slow Fall\n/use Ogre Pinata")
					EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use [nocombat,noexists]Ancient Mana Basin;Invisibility")
					EditMacro("WSxGen+N",nil,nil,"#showtooltip [spec:3]Cold Snap;Invisibility\n/use Cold Snap")
					EditMacro("WSxSRBGCC+1",nil,nil,"")
					EditMacro("WSxCAGen+F",nil,nil,"/stopmacro [indoors]\n/use 16\n/run if not (InCombatLockdown() or IsEquippedItem(\"Dragonwrath, Tarecgosa's Rest\") and IsMounted) then EquipItemByName(71086) else Dismount() end\n/equipset [nomounted]"..EQS[playerspec])
					if playerspec == 1 then
						EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [nocombat,noexists]Archmage Vargoth's Spare Staff;[spec:1,notalent:6/3]Evocation;[spec:1,talent:6/3]Nether Tempest;Arcane Blast")
						EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [spec:1,talent:7/3]Arcane Orb;Evocation")
						EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/cleartarget [dead]\n/clearfocus [dead]\n/use [spec:1,talent:4/2]Charged Up;[spec:1,talent:4/3]Supernova")
					elseif playerspec == 2 then
						EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [nocombat,noexists]Archmage Vargoth's Spare Staff;[spec:2,talent:6/3,nomod]Living Bomb;[nomod]Pyroblast;\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Pyroblast\n/targetlasttarget")
						EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [nomod]Fireball\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Fireball\n/targetlasttarget")
						EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/cleartarget [dead]\n/clearfocus [dead]\n/use [mod,spec:2,talent:7/3,@player][spec:2,talent:7/3,@cursor]Meteor")
					else
						EditMacro("WSxSGen+3",nil,nil,"#showtooltip [spec:3,talent:4/3]Ebonbolt;Archmage Vargoth's Spare Staff\n/targetenemy [noexists]\n/use [nocombat,noexists]Archmage Vargoth's Spare Staff\n/use [spec:3,talent:4/3]Ebonbolt")
						EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [spec:3,talent:6/3]Comet Storm;[spec:3,talent:4/3]Ebonbolt;Frostbolt")
						EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/cleartarget [dead]\n/clearfocus [dead]\n/use [spec:3,notalent:1/2,nopet]Summon Water Elemental;[mod,pet,@player][pet,@cursor,nomod]Freeze")
					end	
				-- Warlock
				elseif class == "WARLOCK" then
					EditMacro("WSkillbomb",nil,nil,"#showtooltip\n/use [spec:2]Summon Demonic Tyrant;[spec:3,@cursor]Summon Infernal;[spec:1]Summon Darkglare\n/use Jewel of Hellfire\n/use 13\n/use 16"..dpsRacials[race].."\n/use Shadescale\n/use Adopted Puppy Crate\n/use Big Red Raygun")
					EditMacro("WSxT15",nil,nil,"#showtooltip [spec:1,talent:1/3]Deathbolt;[spec:2,talent:1/2]Demonic Strength;[spec:2,talent:1/3]Bilescourge Bombers;[spec:3,talent:1/3]Soul Fire;Shadow Bolt\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#showtooltip [spec:2,talent:2/3]Implosion;[spec:1,talent:2/3]Siphon Life;[spec:3,talent:2/3]Soulburn"..oOtas)
					EditMacro("WSxT45",nil,nil,"#showtooltip [mod:shift]"..racials[race]..";[talent:3/3]Dark Pact;[talent:3/2]Burning Rush;Shadowfury;\n/use "..racials[race])
					EditMacro("WSxT90",nil,nil,"#showtooltip [spec:2,talent:6/3]Grimoire: Felguard;[spec:1,talent:6/2]Haunt;[spec:1,talent:6/3]Grimoire of Sacrifice\n/use [nocombat,noexists]Legion Invasion Simulator;[help,nocombat]Swapblaster\n/use [pet:Voidwalker/Voidlord]Consuming Shadows")
					EditMacro("WSxT100",nil,nil,"#showtooltip [spec:2,talent:7/3]Nether Portal;[spec:3,talent:7/2]Channel Demonfire;[spec:3,talent:7/3]Dark Soul: Instability;[spec:1,talent:7/3]Dark Soul: Misery;Demonic Gateway")
					EditMacro("WSxCSGen+G",nil,nil,"#showtooltip [mod]Create Soulwell;[pet,nospec:2,talent:6/3]Grimoire of Sacrifice;[nopet][combat]Summon Felhunter;Create Soulwell\n/use [nopet]Summon Felhunter")
					EditMacro("WSxT60",nil,nil,"#showtooltip [nocombat,noexists]Spire of Spite;[spec:1,talent:4/2]Phantom Singularity;[spec:1,talent:4/3]Vile Taint;Demonic Gateway;\n/use Spire of Spite\n/run PetDismiss();\n/cry")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned.."\n/use [mod:ctrl]Brazier of Awakening")
					EditMacro("WSxGen1",nil,nil,"/use [spec:3,@focus,harm,nodead]Havoc;[spec:2,talent:4/2]Soul Strike;[spec:2,talent:4/3]Summon Vilefiend;[spec:1,@mouseover,harm,nodead][spec:1]Corruption\n/use Copy of Daglop's Contract\n/targetenemy [noexists]")
					EditMacro("WSxSGen+1",nil,nil,"#showtooltip [nocombat,nospec:2,talent:6/3]Grimoire of Sacrifice;Vixx's Chest of Tricks\n/cancelaura Wyrmtongue Collector Disguise\n/focus [@focus,noexists,nodead]\n/targetenemy\n/use [nocombat,noexists]Vixx's Chest of Tricks\n/tar Reaves\n/tar Captain Krooz")
					EditMacro("WSxGen2",nil,nil,"#showtooltip\n/targetlasttarget [noexists,nocombat]\n/use [harm,dead,nocombat]Soul Inhaler;[spec:3]Incinerate;[spec:2]Shadow bolt;[@mouseover,harm,nodead][]Agony\n/use Accursed Tome of the Sargerei\n/startattack\n/clearfocus [dead]\n/use Haunting Memento")
					EditMacro("WSxSGen+2",nil,nil,"#showtooltip\n/use [nomod,harm,nodead]Drain Life;[nomod]Create Healthstone\n/use [nocombat,noexists]Gnomish X-Ray Specs\n/targetenemy [noharm]\n/cleartarget [dead]\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Agony\n/targetlasttarget")
					EditMacro("WSxCSGen+2",nil,nil,"/use [spec:1,@focus,harm]Agony\n/targetenemy [noharm]\n/cleartarget [dead]")
					EditMacro("WSxGen3",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use [nocombat,noexists]Pocket Fel Spreader;[harm,dead]Narassin's Soul Gem;[spec:1,talent:1/3]Deathbolt;[spec:1]Shadow Bolt;[spec:2]Call Dreadstalkers;[talent:2/3]Shadowburn;Immolate\n/targetenemy [noexists]")
					EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noexists]The Perfect Blossom;[spec:1,@focus,harm,nodead]Corruption;[spec:3,@focus,harm,nodead]Immolate;[spec:2,@focus,harm,nodead]Doom;Fel Petal;\n/targetenemy [noharm]\n/cleartarget [dead]")
					EditMacro("WSxGen4",nil,nil,"/use [nocombat,noexists]Crystalline Eye of Undravius;[spec:2]Hand of Gul'dan;[spec:3]Chaos Bolt;[@mouseover,harm,nodead][]Unstable Affliction\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [spec:1,talent:7/3]Dark Soul: Misery;[spec:2,talent:7/3]Nether Portal;[spec:3,talent:7/3]Dark Soul: Instability;[spec:3,talent:7/2]Channel Demonfire;[@cursor]Demonic Gateway\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxCSGen+4",nil,nil,"/use [spec:1,@focus,harm,nodead]Unstable Affliction\n/targetenemy [noharm]\n/cleartarget [dead]")
					EditMacro("WSxGen5",nil,nil,"/use [mod,spec:3,@player]Summon Infernal;[spec:1]Shadow Bolt;[@mouseover,spec:2,harm,nodead][spec:2]Demonbolt;[spec:3]Conflagrate\n/use Fire-Eater's Vial\n/targetenemy [noexists]")
					EditMacro("WSxCSGen+5",nil,nil,"/use [spec:1,@focus,harm,nodead]Siphon Life\n/targetenemy [noharm]\n/cleartarget [dead]")
					EditMacro("WSxSGen+6",nil,nil,"/use [spec:3,talent:4/3,@player]Cataclysm;[spec:2,nopet]Summon Felguard;[pet:felguard/wrathguard]!Felstorm;[talent:4/2]Phantom Singularity;[talent:4/3,@player]Vile Taint;Command Demon\n/use [nocombat,noexists]Imp in a Ball")
					EditMacro("WSxGen7",nil,nil,"/use [mod:shift,nopet]Summon Imp;[mod:shift,pet:Imp]Flee;[nocombat,noexists,nomod]Legion Pocket Portal;[spec:2]Implosion;[spec:3,talent:4/3,@cursor]Cataclysm;[talent:4/2]Phantom Singularity;[talent:4/3,@cursor]Vile Taint\n/targetenemy [noexists]")
					EditMacro("WSxQQ",nil,nil,"#showtooltip\n/stopcasting [nomod,nopet]\n/use [@focus,mod:alt,harm,nodead]Fear;[mod:shift]Demonic Circle;"..locPvPExcQQ)
					EditMacro("WSxStuns",nil,nil,"#showtooltip Shadowfury\n/use [mod:alt,@player][@cursor]Shadowfury")
					EditMacro("WSxRTS",nil,nil,"/use [mod:alt,nocombat]Moll-E;[mod:ctrl,nopet]Summon Succubus;[@mouseover,harm,nodead,talent:5/2][talent:5/2]Mortal Coil;[@mouseover,harm,nodead][]Command Demon\n/targetenemy [noharm]")
					EditMacro("WSxClassT",nil,nil,"/use [pet:Succubus/Shivarra]Whiplash;[pet:Voidwalker/Voidlord]Suffering;[@mouseover,harm,nodead,pet:Felguard/Wrathguard][harm,nodead,pet:Felguard/Wrathguard]!Pursuit;A Tiny Set of Warglaives\n/petattack [@mouseover,harm,nodead][harm,nodead]\n/startattack")
					EditMacro("WSxGenF",nil,nil,"/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/stopcasting [nomod,nopet]\n/use [mod:alt,exists,nodead]All-Seer's Eye;[mod:alt]Eye of Kilrogg;"..locPvPExcGenF.."Micro-Artillery Controller")
					EditMacro("WSxSGen+F",nil,nil,"/use [mod:alt,nocombat,noexists]Gastropod Shell;[pet:Felguard/Wrathguard,nomod]Threatening Presence;[pet:Imp]Flee\n/petautocasttoggle [mod:alt]Legion Strike;[pet:Voidwalker]Suffering;Threatening Presence\n/cancelaura [mod:alt]Heartsbane Curse")
					EditMacro("WSxCGen+F",nil,nil,"#showtooltip\n/use [nocombat,noexists,pet:Succubus/Shivarra]Lesser Invisibility;[group:party/raid]Ritual of Summoning;Bewitching Tea Set\n/use Firefury Totem\n/cancelaura Wyrmtongue Disguise\n/cancelaura Burning Rush\n/cancelaura Crystalline Eye of Undravius")
					EditMacro("WSxCAGen+F",nil,nil,"/run local _,z,_=GetSpellCooldown(111771) local _,d,_=GetSpellCooldown(5384) if (z and d) == 0 then "..tipiSet.." end\n/stopcasting\n/use [@cursor]Demonic Gateway\n/equipset "..EQS[playerspec])
					EditMacro("WSxGG",nil,nil,"/use [mod:alt]S.F.E. Interceptor;[@mouseover,harm,nodead,pet:Felhunter/Observer][pet:Felhunter/Observer]Devour Magic;[@mousever,exists,nodead][]Command Demon")
					EditMacro("WSxSGen+H",nil,nil,"/use [talent:5/2]Mortal Coil;[talent:5/3]Demonic Circle: Teleport;Legion Communication Orb\n/stopmacro [combat]\n/run if not (IsControlKeyDown()) then if IsMounted() then DoEmote\"mountspecial\"; else DoEmote\"kneel\" end end")
					EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:alt,@cursor]Demonic Gateway;Unending Resolve\n/stopspelltarget")
					EditMacro("WSxGND",nil,nil,"/use [mod:shift]Demonic Circle: Teleport;[mod:alt,group]Create Soulwell;[mod:alt]Create Healthstone;[mod,harm,nodead]Enslave Demon;[mod,group]Ritual of Summoning;[mod]Unstable Portal Emitter;[talent:3/2]!Burning Rush;[talent:3/3]Dark Pact\n/use Void Totem")
					EditMacro("WSxCC",nil,nil,"/use [mod:ctrl,@mouseover,harm,nodead][mod:ctrl]Fear;[nopet]Summon Voidwalker;Health Funnel;\n/stopmacro [channeling]\n/use Poison Extraction Totem\n/use Totem of Spirits\n/cancelaura Ring of Broken Promises\n/use Ring of Broken Promises\n/cancelaura X-Ray Specs")
					EditMacro("WSxMove",nil,nil,"#showtooltip\n/use [@mouseover,harm,nodead,spec:3][spec:3]Havoc;[spec:2,talent:6/3]Grimoire: Felguard\n/use [nomod]Panflute of Pandaria\n/use Haw'li's Hot & Spicy Chili\n/cancelaura Rhan'ka's Escape Plan")
					EditMacro("WSxCGen+V",nil,nil,"#showtooltip Unending Breath\n/use [mod:alt,nocombat]"..passengerMount.."\n/use [@focus,harm,nodead,mod:alt][@mouseover,harm,nodead][harm,nodead]Banish\n/use [swimming,noexists]Barnacle-Encrusted Gem\n/use [nomod] Whispers of Rai'Vosh")
					EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use Tickle Totem")
					EditMacro("WSxCAGen+B",nil,nil,"")
					EditMacro("WSxGen+N",nil,nil,"#showtooltip\n/use [@mouseover,help][]Soulstone")
					EditMacro("WSxCAGen+N",nil,nil,"")
					EditMacro("WSxSRBGCC+1",nil,nil,"")
					if playerspec == 1 then
						EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead,nomod][nomod]Corruption\n/use Totem of Spirits\n/use [nocombat,noexists]Verdant Throwing Sphere\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Corruption\n/targetlasttarget")
						EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [spec:1,talent:2/3,nomod]Siphon Life;[nomod]Corruption\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [spec:1,talent:2/3]Siphon Life;Corruption\n/targetlasttarget")
						EditMacro("WSxGen6",nil,nil,"/use [mod]Summon Darkglare;[@mouseover,harm,nodead][]Seed of Corruption\n/startattack")
						EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noexists]\n/use [nomod,talent:6/2]Haunt;[nomod,talent:6/3]Grimoire of Sacrifice;[nomod]Unstable Affliction\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Unstable Affliction\n/targetlasttarget")
					elseif playerspec == 2 then
						EditMacro("WSxSGen+3",nil,nil,"/targetenemy [noexists]\n/use [nocombat,noexists][talent:2/1]Verdant Throwing Sphere;[talent:2/2]Power Siphon;[@mouseover,harm,nodead,nomod][nomod]Doom\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Doom\n/targetlasttarget")
						EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [@player,talent:1/3]Bilescourge Bombers;[talent:6/3]Grimoire: Felguard;[talent:1/2,pet:Felguard/Wrathguard]Demonic Strength;[nopet:Felguard/Wrathguard]Summon Felguard")
						EditMacro("WSxGen6",nil,nil,"/use [mod]Summon Demonic Tyrant;[talent:1/2]Demonic Strength;[talent:1/3,@cursor]Bilescourge Bombers;Implosion\n/startattack")
						EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noexists]\n/use "..locPvPExcSeven)
					else
						EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead,nomod][nomod]Immolate\n/use Totem of Spirits\n/use [nocombat,noexists]Verdant Throwing Sphere\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Immolate\n/targetlasttarget")
						EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/use [talent:6/3,mod:alt]Grimoire of Sacrifice;[@player]Rain of Fire\n/targetenemy [noexists]")
						EditMacro("WSxGen6",nil,nil,"/use [mod,@cursor]Summon Infernal;[@cursor]Rain of Fire\n/startattack")
						EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noexists]\n/targetlasttarget\n/use Havoc\n/targetlasttarget")
					end
					
				-- Monk, menk

				elseif class == "MONK" then
					EditMacro("WSkillbomb",nil,nil,"#showtooltip [spec:3]Storm, Earth, and Fire;[spec:2]Revival;[spec:1]Fortifying Brew\n/use Storm, Earth, and Fire"..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use 13\n/use Celestial Defender's Medallion")
					EditMacro("WSxT15",nil,nil,"#showtooltip [spec:2,talent:1/2]Zen Pulse;[talent:1/2]Chi Wave;[talent:1/3]Chi Burst\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#showtooltip [talent:2/3]Tiger's Lust;Roll"..oOtas)
					EditMacro("WSxT45",nil,nil,"#showtooltip [spec:1,talent:3/3]Black Ox Brew;[spec:2,talent:3/3]Mana Tea;[spec:3,talent:3/2]Fist of the White Tiger;[spec:3,talent:3/3]Energizing Elixir;Paralysis\n/use [mod:alt,@player]Ring of Peace;"..racials[race])
					EditMacro("WSxT90",nil,nil,"#show [nospec:2,talent:6/2]Rushing Jade Wind;[talent:6/2]Refreshing Jade Wind;[spec:2,talent:6/1]Summon Jade Serpent Statue;[spec:3]Invoke Xuen, the White Tiger;[spec:2]Invoke Chi-Ji, the Red Crane;Invoke Niuzao, the Black Ox\n/use Provoke\n/startattack")
					EditMacro("WSxT100",nil,nil,"#showtooltip [spec:3,talent:7/2]Whirling Dragon Punch;[spec:3,talent:7/3]Serenity;")
					EditMacro("WSxCSGen+G",nil,nil,"#showtooltip Transcendence\n/use [@focus,help,nodead]Detox")
					EditMacro("WSxT60",nil,nil,"#showtooltip [spec:1,talent:4/2]Summon Black Ox Statue;[spec:2,talent:4/2]Song of Chi-Ji;[talent:4/3]Ring of Peace;[talent:4/1]Ring of Peace\n/click TotemFrameTotem1 RightButton\n/run PetDismiss()\n/use [noexists,nocombat]Turnip Punching Bag")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[nocombat]Resuscitate;"..pwned.."\n/use [mod:ctrl]Reawaken\n/use [mod:ctrl]Brazier of Awakening")
					EditMacro("WSxSGen+H",nil,nil,"#showtooltip\n/use [nomounted]Darkmoon Gazer\n/stopmacro [combat]\n/run if not (IsControlKeyDown()) then if IsMounted() then DoEmote\"mountspecial\"; else DoEmote\"kneel\" end end")
					EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"\\#showtooltip Provoke\\n/use [mod:shift,@\"..B..\"]Vivify;[@\"..B..\"]Renewing Mist\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")	
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"\\#showtooltip Provoke\\n/use [mod:shift,@\"..N..\"]Vivify;[@\"..N..\"]Renewing Mist\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
					EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use [@focus,help,nodead][@party1,help,nodead]Renewing Mist")
					EditMacro("WSxGen+N",nil,nil,"#showtooltip\n/use [@party2,help,nodead]Renewing Mist")	
					EditMacro("WSxGen1",nil,nil,"#showtooltip\n/use [@mouseover,help,nodead,spec:2]Soothing Mist;[nocombat]Mrgrglhjorn;[spec:2]Soothing Mist;[spec:3,talent:7/2]Whirling Dragon Punch;[spec:3]Storm, Earth, and Fire;Expel Harm\n/targetenemy [noexists]")
					EditMacro("WSxGen2",nil,nil,"#showtooltip\n/use [spec:2,channeling,@mouseover,help,nodead][spec:2,channeling:Soothing Mist]Vivify;[nocombat,noexists]Brewfest Keg Pony;Tiger Palm\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead]Detox")
					EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/use [@party4,help,nodead,nochanneling:Soothing Mist,mod,spec:2]Soothing Mist;[@party4,nodead,mod]Vivify;[nocombat,noexists]Brewfest Pony Keg;[spec:1,talent:3/3]Black Ox Brew;[spec:3,talent:6/2]Rushing Jade Wind;Tiger Palm")
					EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,help,nodead][@party2,help,nodead]Detox;")
					EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [nocombat,noexists]Totem of Harmony;[spec:1]Keg Smash;Rising Sun Kick\n/use Piccolo of the Flaming Fire\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
					EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/use [@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Renewing Mist;[talent:1/2]Chi Wave;[talent:1/3]Chi Burst\n/stopspelltarget\n/targetenemy [noexists]")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@focus,help,nodead,nochanneling:Soothing Mist][@party1,help,nodead,nochanneling:Soothing Mist]Soothing Mist;[@focus,help,nodead][@party1,help,nodead]Enveloping Mist")
					EditMacro("WSxGen5",nil,nil,"/use [mod:ctrl,spec:1]Zen Meditation;[mod:ctrl,spec:2]Thunder Focus Tea;[nocombat,noexists]Pandaren Brewpack;Blackout Kick\n/use [noexists,nocombat]Brewfest Banner\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+5",nil,nil,"/use [@party2,help,nodead,mod:alt,spec:2]Renewing Mist;[spec:3,talent:3/2]Fist of the White Tiger;[spec:3,talent:3/3]Energizing Elixir;[spec:1]Zen Meditation;[spec:2]Thunder Focus Tea\n/use Displacer Meditation Stone\n/targetenemy [noexists]")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,help,nodead,nochanneling:Soothing Mist][@party2,nodead,nochanneling:Soothing Mist]Soothing Mist;[@focus,help,nodead][@party2,nodead]Enveloping Mist")
					EditMacro("WSxGen6",nil,nil,"#showtooltip [spec:3]Fists of Fury;[spec:2]Essence Font;[spec:1]Breath of Fire\n/use [spec:3,mod:ctrl]Storm, Earth, and Fire;[spec:1]Breath of Fire;!Spinning Crane Kick\n/use Words of Akunda")
					EditMacro("WSxSGen+6",nil,nil,"#showtooltip Leg Sweep\n/use [noexists,nocombat,nospec:2]\"Purple Phantom\" Contender's Costume;[@mouseover,spec:3,harm,nodead][spec:3]Fists of Fury;[spec:2]Essence Font\n/targetenemy [noexists]\n/stopmacro [combat]\n/click ExtraActionButton1",1,1)
					EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [spec:1]Ironskin Brew;[spec:3]!Spinning Crane Kick;!Spinning Crane Kick")
					EditMacro("WSxQQ",nil,nil,"#showtooltip\n/use [mod:alt,@focus,harm,nodead][nomod,spec:2,exists,nodead]Paralysis;[mod:shift]Transcendence;[nocombat,noexists]The Golden Banana;[@mouseover,harm,nodead][]Spear Hand Strike;")
					EditMacro("WSxStuns",nil,nil,"#showtooltip\n/use [mod:alt][spec:1]Leg Sweep;[@mouseover,help,nodead,spec:2][spec:2]Soothing Mist;[spec:3]Flying Serpent Kick;")
					EditMacro("WSxRTS",nil,nil,"#showtooltip\n/use [mod:alt]MOLL-E;[mod:shift,spec:2,talent:4/2]Song of Chi-Ji;[mod:shift,talent:4/3,@cursor]Ring of Peace;[mod,@player,talent:2/3][@mouseover,help,talent:2/3][help,talent:2/3]Tiger's Lust;[spec:3]Disable;Crackling Jade Lightning")
					EditMacro("WSxClassT",nil,nil,"#showtooltip Provoke\n/use [@mouseover,harm,nodead][harm,nodead]Crackling Jade Lightning;[nocombat,noexists]Trans-Dimensional Bird Whistle\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxGenF",nil,nil,"#showtooltip Transcendence: Transfer\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[spec:2,@focus,harm,nodead]Paralysis;[@focus,harm,nodead]Spear Hand Strike\n/targetenemy [noexists]")
					EditMacro("WSxSGen+F",nil,nil,"#showtooltip\n/use [nocombat,noexists,mod:alt]Gastropod Shell;[nocombat]Mulled Alterac Brandy\n/cancelaura [mod:alt]Purple Phantom")
					EditMacro("WSxCGen+F",nil,nil,"#showtooltip [spec:2,talent:4/2]Song of Chi-Ji;[talent:4/3]Ring of Peace;[spec:3]Touch of Karma;[spec:2]Fortifying Brew;[spec:1]Summon Black Ox Statue\n/use [spec:3]Touch of Karma;[spec:2]Revival;[spec:1]Zen Meditation")
					EditMacro("WSxCAGen+F",nil,nil,"#showtooltip [spec:2,combat][spec:2,exists]Fortifying Brew;Silversage Incense\n/use Silversage Incense")
					EditMacro("WSxGG",nil,nil,"#showtooltip\n/use [mod:alt]Nimble Brew;[@mouseover,help,nodead,nomod][nomod]Detox;\n/use [mod:alt]Darkmoon Gazer")
					EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:shift]Fortifying Brew;[spec:1,talent:5/2][spec:2,talent:5/1]Healing Elixir;[talent:5/2]Diffuse Magic;[talent:5/3]Dampen Harm;Fortifying Brew\n/use Lao Chin's Last Mug")
					EditMacro("WSxGND",nil,nil,"#showtooltip\n/use [mod:alt]Tumblerun Brew;[mod:ctrl]Zen Pilgrimage;[mod:shift]Transcendence: Transfer;[spec:1,talent:7/2]Guard;[spec:1]Fortifying Brew;[spec:3]Touch of Karma;[@mouseover,help,nodead,spec:2][spec:2,nodead]Life Cocoon;")
					EditMacro("WSxCC",nil,nil,"#showtooltip\n/use [mod:shift,spec:2,talent:3/3]Mana Tea;[mod,@mouseover,harm,nodead][mod]Paralysis;[spec:1]Purifying Brew;[spec:2,@mouseover,help,nodead][spec:2]Renewing Mist;[@mouseover,harm,nodead][]Paralysis\n/cancelaura X-Ray Specs")
					EditMacro("WSxMove",nil,nil,"#showtooltip\n/use Roll\n/use Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Ruthers' Harness\n/run local j,p,_=C_PetJournal _,p=j.FindPetIDByName(\"Ban-Fu, Cub of Ban-Lu\") if p and j.GetSummonedPetGUID()~=p then j.SummonPetByGUID(p)end")
					EditMacro("WSxCGen+V",nil,nil,"#showtooltip [spec:1]Fortifying Brew;[spec:2,talent:3/3]Mana Tea;[spec:2]Thunder Focus Tea;[spec:3]Storm, Earth, and Fire;\n/use [mod:alt,nocombat]"..passengerMount..";[swimming] Barnacle-Encrusted Gem;!Zen Flight\n/use [nomod] Whispers of Rai'Vosh")
					EditMacro("WSxSRBGCC+1",nil,nil,"")
					if playerspec == 1 then
						EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/target [talent:4/2]Black Ox\n/use [talent:4/2,help,nodead]Provoke;[talent:4/2,@cursor]Summon Black Ox Statue;[talent:4/3,@cursor]Ring of Peace;\n/targetlasttarget [talent:4/2]\n/startattack")
						EditMacro("WSxGen3",nil,nil,"#showtooltip\n/use [talent:6/3]Invoke Niuzao, the Black Ox;[talent:6/2]Rushing Jade Wind;Blackout Kick\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,noexists] Mystery Keg\n/use [nocombat,noexists]Jin Warmkeg's Brew")
						EditMacro("WSxSGen+1",nil,nil,"#showtooltip\n/use [mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Vivify;Honorary Brewmaster Keg\n/targetexact Reaves\n/tar Captain Krooz")
						EditMacro("WSxSGen+2",nil,nil,"/use [@party3,help,nodead,mod:alt][@mouseover,help,nodead][]Vivify\n/use [nochanneling]Gnomish X-Ray Specs")
					elseif playerspec == 2 then
						EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [talent:6/2]Refreshing Jade Wind;[talent:6/3]Invoke Chi-Ji, the Red Crane;[talent:6/1,@cursor]Summon Jade Serpent Statue;\n/startattack")
						EditMacro("WSxGen3",nil,nil,"/use [nochanneling:Soothing Mist,@mouseover,help,nodead][nochanneling:Soothing Mist]Soothing Mist;[@mouseover,help,nodead][]Enveloping Mist\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,noexists]Mystery Keg\n/use [nocombat,noexists]Jin Warmkeg's Brew")
						EditMacro("WSxSGen+1",nil,nil,"/use [mod,@party2,nodead,nochanneling:Soothing Mist][@focus,help,nodead,nochanneling:Soothing Mist][@party1,nodead,nochanneling:Soothing Mist]Soothing Mist;[mod,@party2,nodead][@focus,help,nodead][@party1,nodead]Vivify;Honorary Brewmaster Keg")
						EditMacro("WSxSGen+2",nil,nil,"/use [@party3,nodead,nochanneling:Soothing Mist,mod:alt][nochanneling:Soothing Mist,@mouseover,help,nodead][nochanneling:Soothing Mist]Soothing Mist;[@party3,help,mod:alt][@mouseover,help,nodead][]Vivify\n/use [nochanneling]Gnomish X-Ray Specs")
					else
						EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [spec:3,talent:6/3]Invoke Xuen, the White Tiger;Storm, Earth, and Fire\n/startattack")
						EditMacro("WSxGen3",nil,nil,"#showtooltip\n/use Touch of Death\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,noexists] Mystery Keg\n/use [nocombat,noexists]Jin Warmkeg's Brew")
						EditMacro("WSxSGen+1",nil,nil,"#showtooltip\n/use [mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Vivify;Honorary Brewmaster Keg\n/targetexact Reaves\n/tar Captain Krooz")
						EditMacro("WSxSGen+2",nil,nil,"/use [@party3,help,nodead,mod:alt][@mouseover,help,nodead][]Vivify\n/use [nochanneling]Gnomish X-Ray Specs")
					end

				-- Paladin, bvk, palajong

				elseif class == "PALADIN" then
					EditMacro("WSkillbomb",nil,nil,"#showtooltip\n/use Avenging Wrath\n/use 13\n/use 14\n/use Sha'tari Defender's Medallion"..dpsRacials[race].."\n/use Gnawed Thumb Ring\n/use Echoes of Rezan")
					EditMacro("WSxT15",nil,nil,"#showtooltip [spec:1,talent:1/2]Bestow Faith;[spec:1,talent:1/3]Light's Hammer;[spec:3,talent:1/3]Execution Sentence;Judgment\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#showtooltip [spec:1,talent:2/3]Holy Prism;[spec:2,talent:2/3]Moment of Glory;Lay on Hands\n/use Lay on Hands\n/use [help,nodead]Apexis Focusing Shard\n/stopspelltarget"..oOtas)
					EditMacro("WSxT90",nil,nil,"#showtooltip [spec:2,talent:6/3]Aegis of Light;[spec:1,talent:6/1]Fervent Martyr;[spec:1,talent:6/2]Sanctified Wrath;[spec:3,talent:6/2]Justicar's Vengeance;[spec:3,talent:6/3]Word of Glory;Avenging Wrath\n/use Hand of Reckoning")
					EditMacro("WSxT100",nil,nil,"#showtooltip [spec:3,talent:7/3]Inquisition;[spec:1,talent:7/2]Beacon of Faith;[spec:1,talent:7/3]Beacon of Virtue;[spec:2,talent:7/3]Seraphim;Avenging Wrath;")
					EditMacro("WSxCSGen+G",nil,nil,"#showtooltip Divine Shield\n/use [@focus,help,nodead]Cleanse")
					EditMacro("WSxT60",nil,nil,"#showtooltip [mod] Sylvanas' Music Box;[spec:1,talent:4/3]Rule of Law;[spec:3,talent:5/2]Eye for an Eye\n/use [mod,spec:1,talent:1/3,@player]Light's Hammer;!Concentration Aura\n/use Sylvanas' Music Box\n/run PetDismiss();\n/cry")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[nocombat]Redemption;"..pwned.."\n/use [mod:ctrl]Absolution\n/use [mod:ctrl]Brazier of Awakening")
					EditMacro("WSxCAGen+F",nil,nil,"#showtooltip [spec:1]Aura Mastery;Contemplation;\n/use Contemplation")
					EditMacro("WSxT45",nil,nil,"#showtooltip [talent:3/3]Blinding Light;[talent:3/2]Repentance;Hammer of Justice;\n/use "..racials[race])
					EditMacro("WSxGen1",nil,nil,"/use [spec:3]Blade of Justice;[spec:2,talent:2/3]Moment of Glory;[spec:1,@mouseover,help,nodead][@spec:1,@mouseover,harm,nodead][spec:1]Holy Shock;Judgment\n/use Pretty Draenor Pearl")
					EditMacro("WSxSGen+1",nil,nil,"#showtooltip Blessing of Protection\n/use [mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Flash of Light\n/tar Reaves\n/tar Captain Krooz\n/use Vindicator's Armor Polish Kit")
					EditMacro("WSxGen2",nil,nil,"#showtooltip\n/use Crusader Strike\n/startattack\n/targetenemy [noexists]\n/cleartarget [dead]\n/cancelaura X-Ray Specs")
					EditMacro("WSxSGen+2",nil,nil,"#showtooltip\n/use [@party4,help,nodead,mod:alt]Holy Light;[@mouseover,help,nodead][]Flash of Light\n/use Gnomish X-Ray Specs")
					EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead,spec:1]Holy Shock;[spec:1,@focus,help,nodead][spec:1,@party1,help,nodead]Cleanse;[@focus,help,nodead][@party1,help,nodead]Cleanse Toxins")
					EditMacro("WSxGen3",nil,nil,"/use [spec:1,@mouseover,help,nodead][spec:1,help,nodead]Light of the Martyr;[@mouseover,harm,nodead][harm,nodead]Hammer of Wrath\n/use [nocombat,noexists]Contemplation\n/targetenemy [noexists]\n/stopspelltarget")
					EditMacro("WSxSGen+3",nil,nil,"/use [@party3,help,nodead,mod:alt]Holy Light;[spec:1,talent:2/3]Rule of Law;[spec:3,talent:7/3]Inquisition;Consecration\n/targetenemy [noexists]")
					EditMacro("WSxCSGen+3",nil,nil,"/use [mod:alt,@party4,help,nodead,spec:1]Holy Shock;[spec:1,@focus,help,nodead][spec:1,@party2,help,nodead]Cleanse;[@focus,help,nodead][@party2,help,nodead]Cleanse Toxins")
					EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [nospec:2,help,nodead,nocombat]Holy Lightsphere;[spec:2,help,nodead,nocombat]Dalaran Disc;[spec:2,@mouseover,harm,nodead][spec:2]Avenger's Shield;Judgment\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
					EditMacro("WSxCGen+4",nil,nil,"/use [spec:1,@mouseover,help,nodead,talent:7/2][spec:1,talent:7/2]Beacon of Faith;[spec:1,@mouseover,help,nodead][spec:1]Beacon of Light;[spec:3,talent:7/3]Inquisition\n/targetenemy [noexists]\n/use Soul Evacuation Crystal")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead]Holy Shock")
					EditMacro("WSxGen5",nil,nil,"/use [spec:2,mod:ctrl]Ardent Defender;[spec:1,mod:ctrl]Aura Mastery;[spec:3]Templar's Verdict;[spec:2,nocombat,noexists]Barrier Generator;[spec:2]Shield of the Righteous;[@mouseover,help,nodead][]Holy Light;\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/use [@party2,help,nodead,mod:alt]Holy Light;[spec:3,talent:6/2]Justicar's Vengeance;[spec:3,talent:6/3]Word of Glory;[spec:1,@player]Holy Shock;[spec:1]Holy Light;Judgment\n/use [nocombat,noexists]Light in the Darkness")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,help,nodead][@party2,help,nodead]Holy Shock")
					EditMacro("WSxGen6",nil,nil,"#showtooltip\n/use [mod:ctrl]Avenging Wrath;[spec:3]Divine Storm;[spec:1]Light of Dawn;[spec:2]Consecration\n/use [mod:ctrl] 19\n/targetenemy [noexists]")
					EditMacro("WSxSGen+6",nil,nil,"#showtooltip [talent:5/2]Holy Avenger;[talent:5/3]Seraphim\n/use [spec:1,talent:2/3,@player]Holy Prism;Consecration\n/use Contemplation")
					EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [mod:shift,spec:1,talent:5/2]Holy Avenger;[mod:shift,spec:1,talent:5/3]Seraphim;[spec:3]Wake of Ashes;Consecration\n/targetenemy [noexists]")
					EditMacro("WSxQQ",nil,nil,"/use [mod:shift]Divine Shield;[mod:alt,@focus,harm,nodead][spec:1,talent:3/1]Hammer of Justice;[spec:1,talent:3/2]Repentance;[spec:1,talent:3/3]Blinding Light;[@mouseover,harm,nodead][]Rebuke")
					EditMacro("WSxStuns",nil,nil,"#showtooltip Hammer of Justice\n/use [mod:alt,talent:3/2,@focus,exists,nodead]Repentance;[mod:alt]Blinding Light;[help,nodead][]Word of Glory")
					EditMacro("WSxRTS",nil,nil,"#showtooltip [spec:3]Hand of Hindrance;Blessing of Freedom\n/use [mod:alt]MOLL-E;[mod:ctrl]Divine Steed;[@mouseover,help,nodead][help,nodead]Blessing of Freedom;[spec:3,@mouseover,harm,nodead][spec:3,harm,nodead]Hand of Hindrance;")
					EditMacro("WSxClassT",nil,nil,"#show Hand of Reckoning\n/use [help]Swapblaster;[harm,nodead]Shield of the Righteous;Titanium Seal of Dalaran\n/use [nocombat]Trans-Dimensional Bird Whistle\n/use [nocombat]Wayfarer's Bonfire\n/startattack")
					EditMacro("WSxGenF",nil,nil,"#show [combat]Blessing of Freedom;Apexis Focusing Shard\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@focus,exists]Repentance;[mod:alt]Farwater Conch;[@focus,harm,nodead]Rebuke;[exists,nodead]Apexis Focusing Shard")
					EditMacro("WSxSGen+F",nil,nil,"/use [spec:2,@focus,harm,nodead]Avenger's Shield;[nocombat,noexists]Gastropod Shell")
					EditMacro("WSxCGen+F",nil,nil,"#showtooltip Blessing of Sacrifice")
					EditMacro("WSxGG",nil,nil,"#showtooltip\n/use [mod:alt]Darkmoon Gazer;[spec:1,@mouseover,help,nodead][spec:1]Cleanse;[@mouseover,help,nodead][]Cleanse Toxins;\n/cancelaura [mod:alt]Divine Shield\n/cancelaura [mod:alt]Blessing of Protection")
					EditMacro("WSxSGen+H",nil,nil,"#showtooltip\n/use [nomounted]Darkmoon Gazer\n/stopmacro [combat]\n/run if not (IsControlKeyDown()) then if IsMounted() then DoEmote\"mountspecial\"; else DoEmote\"kneel\" end end")
					EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:alt]!Devotion Aura;[mod:shift,help,nodead][mod:shift,combat]Blessing of Protection;[@mouseover,help,nodead][help,nodead]Blessing of Sacrifice;[spec:1]Divine Protection;[spec:2]Guardian of Ancient Kings;[spec:3]Divine Shield")
					EditMacro("WSxGND",nil,nil,"#showtooltip\n/use [mod:alt]!Retribution Aura;[mod:shift]Blessing of Freedom;[@mouseover,help,nodead][spec:1]Lay on Hands;[spec:2]Ardent Defender;Shield of Vengeance")
					EditMacro("WSxCC",nil,nil,"/use [mod,talent:3/2]Repentance;[spec:3,talent:4/3]Eye for an Eye;[spec:1,@mouseover,help,nodead,talent:1/2][spec:1,talent:1/2]Bestow Faith;[spec:1,talent:1/3,@cursor]Light's Hammer;Judgment")
					EditMacro("WSxMove",nil,nil,"/use [spec:2/3]Divine Steed;[@mouseover,help,nodead][]Beacon of Light;\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan")
					EditMacro("WSxCGen+V",nil,nil,"#showtooltip\n/use [mod:alt,nocombat]"..passengerMount..";[swimming] Barnacle-Encrusted Gem;[@mouseover,harm,nodead][]Turn Evil\n/use [nostealth,nomod] Seafarer's Slidewhistle\n/use [nomod] Whispers of Rai'Vosh")
					EditMacro("WSxSRBGCC+1",nil,nil,"")
					if race == "BloodElf" then
						EditMacro("WSxCAGen+F",nil,nil,"#show [spec:1,combat][spec:1,exists]Aura Mastery;Necromedes, the Death Resonator;\n/stopmacro [combat,exists]\n/use 16\n/equipset "..EQS[playerspec].."\n/run local _,d,_=GetItemCooldown(151255) if d==0 then EquipItemByName(151255) end")
					end
					if playerspec == 1 then
						EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"\\#showtooltip Lay on Hands\\n/use [mod:shift,@\"..B..\"]Flash of Light;[@\"..B..\"]Holy Shock\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"\\#showtooltip Lay on Hands\\n/use [mod:shift,@\"..N..\"]Flash of Light;[@\"..N..\"]Holy Shock\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
						EditMacro("WSxSGen+4",nil,nil,"/use [@focus,help,nodead,mod:alt][@party1,nodead,mod:alt]Holy Light;[spec:1,talent:2/3,exists,nodead]Holy Prism;Judgment\n/targetenemy [noexists]")
					elseif playerspec == 2 then
						EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"\\#showtooltip Lay on Hands\\n/use [mod:shift,@\"..B..\"]Lay on Hands;[@\"..B..\"]Light of the Protector\", nil)print(\"Vigil set to : \"..B)else print(\"Combat!\")end")
						EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"\\#showtooltip Lay on Hands\\n/use [mod:shift,@\"..N..\"]Lay on Hands;[@\"..N..\"]Light of the Protector\", nil)print(\"Vigil#2 set to : \"..N)else print(\"Combat!\")end")
						EditMacro("WSxSGen+4",nil,nil,"/use Judgment\n/targetenemy [noexists]")
					else
						EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"\\#showtooltip Lay on Hands\\n/use [mod:shift,@\"..B..\"]Lay on Hands;[@\"..B..\"]Flash of Light\", nil)print(\"Vigil set to : \"..B)else print(\"Combat!\")end")
						EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"\\#showtooltip Lay on Hands\\n/use [mod:shift,@\"..N..\"]Lay on Hands;[@\"..N..\"]Flash of Light\", nil)print(\"Vigil#2 set to : \"..N)else print(\"Combat!\")end")
						EditMacro("WSxSGen+4",nil,nil,"/use [spec:3,talent:1/3]Execution Sentence;[spec:3,talent:4/3]Wake of Ashes;Judgment\n/targetenemy [noexists]")
					end
					
				-- Hunter, hanter 
				elseif class == "HUNTER" then					
					EditMacro("WSxT15",nil,nil,"#showtooltip [spec:3]Command Pet;[spec:1]Aspect of the Wild;[spec:2]Bursting Shot\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#showtooltip [spec:1,talent:2/3]Chimaera Shot;[spec:3,talent:2/1]A Murder of Crows;[spec:3,talent:2/3]Snake Hunter;[spec:2,talent:2/2]Black Arrow;Fetch\n/use [mod:alt,@player]Freezing Trap;[pet,@pet]Misdirection"..oOtas)
					EditMacro("WSxT45",nil,nil,"#showtooltip\n/use [mod:alt,@player]Tar Trap;[@mouseover,help,nodead][help,nodead][@focus,help,nodead][pet,@pet]Misdirection\n/use [nocombat,noexists]Angler's Fishing Spear\n/use [nocombat,noexists]Goblin Fishing Bomb")
					EditMacro("WSxT100",nil,nil,"#showtooltip [spec:1,talent:7/3]Spitting Cobra;[spec:2,talent:7/1]Sidewinders;[spec:2,talent:7/2]Piercing Shot;[spec:3,talent:7/3]Chakrams;Eagle Eye")
					EditMacro("WSxCSGen+G",nil,nil,"#showtooltip [talent:3/3]Camouflage;"..chameleon.."\n/cancelaura Whole-Body Shrinka'\n/cancelaura Growing Pains")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned.."\n/use [mod:ctrl]Brazier of Awakening")
					EditMacro("WSxT60",nil,nil,"#showtooltip [spec:2,talent:4/3]Hunter's Mark;Dismiss Pet\n/use Dismiss Pet\n/click TotemFrameTotem1 RightButton\n/use Crashin' Thrashin' Robot")
					EditMacro("WSxT90",nil,nil,"#show [spec:1,talent:6/3]Stampede;[nospec:3,talent:6/2]Barrage;[spec:3,talent:6/3]Flanking Strike;[spec:2,talent:6/3]Double Tap;[spec:3]Raptor Strike;[spec:1]Wild Call\n/use [@mouseover,harm,nodead][harm,nodead]Intimidation")
					EditMacro("WSkillbomb",nil,nil,"#showtooltip\n/use [spec:1]Bestial Wrath;[spec:2]Trueshot;[spec:3]Coordinated Assault;\n/use Bloodmane Charm"..dpsRacials[race].."\n/use 13\n/use 14\n/use Adopted Puppy Crate\n/use Pendant of the Scarab Storm\n/use Big Red Raygun\n/use Echoes of Rezan")
					EditMacro("WSxCAGen+B",nil,nil,"")
					EditMacro("WSxCAGen+N",nil,nil,"")
					EditMacro("WSxGen+N",nil,nil,"#showtooltip\n/use Growl")
					EditMacro("WSxCSGen+5",nil,nil,"/run SetTracking(3,true);SetTracking(4,true);SetTracking(5,true);SetTracking(6,true);SetTracking(7,true);SetTracking(8,true);SetTracking(10,true);SetTracking(11,true);\n/use Overtuned Corgi Goggles")
					EditMacro("WSxCGen+F",nil,nil,"#showtooltip Flare\n/run SetTracking(3,false);SetTracking(4,false);SetTracking(5,false);SetTracking(6,false);SetTracking(7,false);SetTracking(8,false);SetTracking(9,false);SetTracking(10,false);SetTracking(11,false);\n/cancelaura X-Ray Specs")
					EditMacro("WSxCAGen+F",nil,nil,"#showtooltip Exhilaration\n/run local _,d,_=GetSpellCooldown(5384) if d==0 then "..tipiSet.." end\n/use Feign Death\n/equipset "..EQS[playerspec])
					EditMacro("WSxSGen+H",nil,nil,"/use Dash\n/use [nocombat,noexists,nomounted]Nat's Fishing Chair\n/stopmacro [combat]\n/run if not (IsControlKeyDown()) then if IsMounted() then DoEmote\"mountspecial\"; else DoEmote\"kneel\" end end")
					EditMacro("WSxGen1",nil,nil,"/targetlasttarget [noharm,nodead,nocombat]\n/use [@mouseover,help,nodead]Misdirection;[help,nodead]Corbyn's Beacon;[harm,dead]Fetch;[nospec:2,talent:4/3][spec:2,talent:1/3]A Murder of Crows;[spec:2,talent:1/2]Serpent Sting;Fetch\n/startattack")
					EditMacro("WSxSGen+1",nil,nil,"#show Aspect of the Cheetah\n/use [noexists,nocombat]Whitewater Carp;[mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Spirit Mend\n/targetexact Talua\n/tar Reaves\n/tar Captain Krooz")
					EditMacro("WSxGen2",nil,nil,"#showtooltip\n/use [nocombat,noexists]Mrgrglhjorn;[spec:1]Barbed Shot;[spec:2]Steady Shot;[spec:3]Serpent Sting;\n/use Gnomish X-Ray Specs\n/targetenemy [noexists]\n/use Words of Akunda")
					EditMacro("WSxSGen+2",nil,nil,"#showtooltip\n/use [spec:1,pet,nopet:Spirit Beast][spec:3,pet]Dismiss Pet;[nopet]Call Pet 2;[@mouseover,help,nodead,pet:Spirit Beast][pet:Spirit Beast,help,nodead][pet:Spirit Beast,@player]Spirit Mend;Dismiss Pet;\n/use Totem of Spirits")
					EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead]Misdirection;")
					EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,help,nodead][@party2,help,nodead]Misdirection;[nocombat,noharm]Cranky Crab")
					if not hunPvPExcSFour then
						return
					end
					EditMacro("WSxSGen+4",nil,nil,"/use [spec:2,talent:6/3]Double Tap;[nospec:3,talent:6/2]Barrage;[spec:2,talent:2/3]Explosive Shot;[spec:3,talent:6/3]Flanking Strike;[spec:1,talent:6/3]Stampede;"..hunPvPExcSFour.."Misdirection")
					EditMacro("WSxCSGen+4",nil,nil,"#showtooltip Play Dead\n/run SetTracking(9,true);\n/use Gnomish X-Ray Specs")
					EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [mod:ctrl]Exhilaration;[help,nodead]Silver-Plated Turkey Shooter;[spec:1]Cobra Shot;[spec:2]Arcane Shot;[spec:3]Raptor Strike\n/use [mod:ctrl] Skoller's Bag of Squirrel Treats\n/cleartarget [dead]\n/targetenemy [noexists]")
					EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/use [nocombat,noexists,nomod]Pandaren Scarecrow;Command Pet")
					EditMacro("WSxGen6",nil,nil,"#showtooltip\n/use [spec:1,mod:ctrl]Bestial Wrath;[spec:3,mod:ctrl]Coordinated Assault;[spec:2,mod:ctrl]Trueshot;[spec:3]Carve;[@mouseover,harm,nodead][harm,nodead]Multi-Shot;Twiddle Twirler: Sentinel's Glaive\n/startattack [nomod]")
					EditMacro("WSxSGen+6",nil,nil,"#showtooltip [nocombat]Laser Pointer;Play Dead\n/use [nocombat,noexists,nomod]Laser Pointer;[spec:1,@player]Dire Beast: Hawk")
					EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [spec:1]Aspect of the Wild;[@mouseover,harm,nodead,spec:2][spec:2,talent:2/3]Explosive Shot;[spec:3]Aspect of the Eagle\n/use [nocombat,noexists]Fireworks\n/use Will of Northrend\n/use Bom'bay's Color-Seein' Sauce")
					EditMacro("WSxQQ",nil,nil,"/stopcasting [nomod:alt]\n/use [mod:alt,@focus,harm,nodead]Stopping Power;[noexists,noharm]The Golden Banana;[spec:3,@mouseover,harm,nodead][spec:3]Muzzle;[@mouseover,harm,nodead][]Counter shot\n/use Angler's Fishing Spear")
					EditMacro("WSxStuns",nil,nil,"/targetenemy [noexists]\n/stopspelltarget\n/use [mod:alt,@cursor]Flare;[nocombat,noexists]Party Totem;[spec:2]Bursting Shot;[@mouseover,harm,nodead,spec:3][spec:3]Harpoon;Intimidation\n/cleartarget [dead]\n/use Angler's Fishing Spear")
					EditMacro("WSxRTS",nil,nil,"/use [mod:alt,noexists]MOLL-E;[mod:shift,@cursor]Tar Trap;[@mouseover,help,nodead,nomod][help,nodead,nomod]Master's Call;[spec:3]Wing Clip;[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Concussive Shot\n/targetenemy [noharm]")
					EditMacro("WSxGenF",nil,nil,"#showtooltip Tar Trap\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@cursor]!Eagle Eye;[spec:3,@focus,harm,nodead]Muzzle;[@focus,harm,nodead]Counter Shot;[nocombat,noexists]S.F.E. Interceptor")
					EditMacro("WSxSGen+F",nil,nil,"#showtooltip Mend Pet\n/use Robo-Gnomebulator\n/stopmacro [mod:ctrl]\n/petautocasttoggle Growl\n/petautocasttoggle [mod:alt]Spirit Walk")
					EditMacro("WSxDef",nil,nil,"#show [mod:alt]Hunter's Call;[mod:shift]Play Dead;Feign Death\n/use [mod:alt]Hunter's Call;[mod:shift]Play Dead;Personal Hologram\n/use [nomod]Feign Death\n/cancelaura Will of the Taunka\n/cancelaura Will of the Vrykul\n/cancelaura Will of the Iron Dwarves")
					EditMacro("WSxGND",nil,nil,"#showtooltip\n/use [mod:alt,exists]Beast Lore;[mod:ctrl,exists,nodead]Tame Beast;[mod]Aspect of the Cheetah;Aspect of the Turtle;\n/use Super Simian Sphere\n/use Angry Beehive\n/use Xan'tish's Flute")
					EditMacro("WSxCC",nil,nil,"#showtooltip Freezing Trap\n/use [mod:ctrl,@cursor]Freezing Trap;[mod,@player]Flare;Revive Pet\n/stopmacro [mod]\n/cancelaura X-Ray Specs\n/cancelaura Safari Hat\n/use [spec:1]Safari Hat\n/use Poison Extraction Totem\n/use Totem of Spirits\n/use Desert Flute")
					EditMacro("WSxMove",nil,nil,"#showtooltip\n/use Disengage\n/stopcasting\n/use Crashin' Thrashin' Robot\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Ruthers' Harness")
					EditMacro("WSxCGen+V",nil,nil,"/use [mod:alt,nocombat]"..passengerMount..";[spec:1,pet,nopet:Water Strider]Dismiss Pet;[nopet]Call Pet 1;[spec:1,pet:Water Strider]Surface Trot\n/use Barnacle-Encrusted Gem\n/use [nomod] Whispers of Rai'Vosh")
					EditMacro("WSxSRBGCC+1",nil,nil,"")
					local MSK,_ = IsUsableSpell("Mother's Skinning Knife") 
					if MSK == true and level <= 113 then
						MSK = "\n/targetlasttarget [noexists,nocombat,nodead]\n/use [harm,dead]Mother's Skinning Knife"
					else
						MSK = ""
					end
					if playerspec == 1 then
						EditMacro("WSxCGen+4",nil,nil,"/use [nopet]Call Pet 3;[pet:Crab,help,pet]Crab Shank;[talent:7/3]Spitting Cobra;[@pet,pet:Spirit Beast]Spirit Mend;[nocombat,noexists]Gastropod Shell\n/target pet [pet:Crab]\n/targetlasttarget [pet:Crab]")
						EditMacro("WSxGen3",nil,nil,MSK.."\n/use [nocombat,noexists]Imaginary Gun;[talent:2/3]Chimaera Shot;Cobra Shot\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]\n/stopspelltarget")
						EditMacro("WSxGen1",nil,nil,"/targetlasttarget [noharm,nodead,nocombat]\n/use [@mouseover,help,nodead]Misdirection;[help,nodead]Corbyn's Beacon;[harm,dead]Fetch;[talent:4/3]A Murder of Crows;Fetch\n/startattack")
						if not hunPvPExcSTree then
							return
						end
						EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/use [nocombat,noexists]"..factionFireworks..";[spec:1,talent:1/3]Dire Beast"..hunPvPExcSTree..";Misdirection\n/use Everlasting Darkmoon Firework\n/use Power Converter\n/use Pandaren Firework Launcher\n/startattack")
						EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [noexists,nocombat]Puntable Marmot;[help,nodead]Dalaran Disc;[spec:1,@pettarget]Kill Command;\n/targetenemy [noexists]\n/startattack\n/cancelaura Aspect of the Turtle\n/cleartarget [dead]\n/petattack")
						EditMacro("WSxClassT",nil,nil,"#show Intimidation\n/targetenemy [noexists]\n/use [mod,@focus,harm,nodead]Intimidation;[help,nocombat]Swapblaster;[nocombat,noexists]Trans-Dimensional Bird Whistle\n/petattack [@mouseover,harm,nodead][harm,nodead]\n/cleartarget [dead]\n/use Angler's Fishing Spear")
					elseif playerspec == 2  then
						EditMacro("WSxCGen+4",nil,nil,"/use [nopet]Call Pet 3;[pet:Crab,help,pet]Crab Shank;[talent:7/3]Piercing Shot;[nocombat,noexists]Gastropod Shell\n/target pet [pet:Crab]\n/targetlasttarget [pet:Crab]")
						EditMacro("WSxGen3",nil,nil,MSK.."\n/use [nocombat,noexists]Imaginary Gun;Aimed Shot\n/targetenemy [noexists]\n/cleartarget [dead]\n/stopspelltarget")
						EditMacro("WSxGen1",nil,nil,"/targetlasttarget [noharm,nodead,nocombat]\n/use [@mouseover,help,nodead]Misdirection;[help,nodead]Corbyn's Beacon;[harm,dead]Fetch;[@mouseover,harm,talent:4/3][talent:4/3]Hunter's Mark;Fetch\n/targetenemy [noexists]")
						EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/use [nocombat,noexists]"..factionFireworks..";[talent:1/3]A Murder of Crows;[talent:1/2]Serpent Sting\n/use Everlasting Darkmoon Firework\n/use Power Converter\n/use Pandaren Firework Launcher\n/startattack")
						EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [noexists,nocombat]Puntable Marmot;[help,nodead]Dalaran Disc;Rapid Fire\n/targetenemy [noexists]\n/startattack\n/cancelaura Aspect of the Turtle\n/cleartarget [dead]\n/petattack")
						EditMacro("WSxClassT",nil,nil,"#showtooltip Freezing Trap\n/targetenemy [noexists]\n/use [help,nocombat]Swapblaster;[nocombat,noexists]Trans-Dimensional Bird Whistle;Auto Shoot;\n/cleartarget [dead]\n/use Angler's Fishing Spear")
					else
						EditMacro("WSxCGen+4",nil,nil,"/use [nopet]Call Pet 3;[pet:Crab,help,pet]Crab Shank;[talent:7/3]Chakrams;[nocombat,noexists]Gastropod Shell\n/target pet [pet:Crab]\n/targetlasttarget [pet:Crab]")
						EditMacro("WSxGen3",nil,nil,MSK.."\n/use [nocombat,noexists]Imaginary Gun;[spec:3]Wildfire Bomb\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]\n/stopspelltarget")
						EditMacro("WSxGen1",nil,nil,"/targetlasttarget [noharm,nodead,nocombat]\n/use [@mouseover,help,nodead]Misdirection;[help,nodead]Corbyn's Beacon;[harm,dead]Fetch;[talent:4/3]A Murder of Crows;Fetch\n/startattack")
						EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/use [nocombat,noexists]"..factionFireworks..";[@mouseover,harm,nodead,spec:3][spec:3]Serpent Sting\n/use Everlasting Darkmoon Firework\n/use Power Converter\n/use Pandaren Firework Launcher\n/use Azerite Firework Launcher\n/startattack")
						EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [noexists,nocombat]Puntable Marmot;[help,nodead]Dalaran Disc;[spec:3]Kill Command\n/targetenemy [noexists]\n/startattack\n/cancelaura Aspect of the Turtle\n/cleartarget [dead]\n/petattack")
						EditMacro("WSxClassT",nil,nil,"#show Intimidation\n/targetenemy [noexists]\n/use [mod,@focus,harm,nodead]Intimidation;[help,nocombat]Swapblaster;[nocombat,noexists]Trans-Dimensional Bird Whistle\n/petattack [@mouseover,harm,nodead][harm,nodead]\n/cleartarget [dead]\n/use Angler's Fishing Spear")
					end			
				-- Rogue, rogge

				elseif class == "ROGUE" then
					EditMacro("WSkillbomb",nil,nil,"/use [spec:1]Vendetta;[spec:2]Adrenaline Rush;Shadow Blades;\n/stopmacro [stealth]\n/use Will of Northrend"..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use 13\n/use 14\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
					EditMacro("WSxT15",nil,nil,"#showtooltip [spec:2,talent:1/1]Ghostly Strike;[spec:1,talent:1/3]Blindside;[spec:3,talent:1/3]Gloomblade;[spec:1]Wound Poison\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#showtooltip\n/use [@focus,help,nodead][@mouseover,help,nodead][help,nodead][@party1,help,exists]Tricks of the Trade\n/use Seafarer's Slidewhistle"..oOtas)
					EditMacro("WSxT45",nil,nil,"#showtooltip\n/use [mod:alt,spec:1,@focus,harm,nodead,nostance:0][spec:1,nostance:0]Garrote;[stance:0,nocombat]Stealth;[stance:0,combat]Vanish\n/use [nostealth] Hourglass of Eternity")
					EditMacro("WSxT90",nil,nil,"#showtooltip [spec:2,talent:6/1]Cannonball Barrage;[spec:2,talent:6/3]Killing Spree;[spec:3,talent:6/3]Enveloping Shadows;[spec:1,talent:6/2]Toxic Blade;[spec:1,talent:6/3]Exsanguinate\n/use [mod:alt,@player][]Distract")
					EditMacro("WSxT100",nil,nil,"#showtooltip [spec:1,talent:7/3]Crimson Tempest;[spec:2,talent:7/2]Blade Rush;[spec:2,talent:7/3]Killing Spree;[spec:3,talent:7/2]Secret Technique;[spec:3,talent:7/3]Shuriken Tornado;[nospec:2]Eviscerate;Run Through")
					EditMacro("WSxCSGen+G",nil,nil,"#showtooltip\n/use Totem of Spirits\n/use [@focus,harm,nodead]Gouge")	
					EditMacro("WSxT60",nil,nil,"#showtooltip\n/castsequence reset=15 Pack of Battle Potions, Smoky Boots, Stealth\n/run PetDismiss();")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned.."\n/use [mod:ctrl]Brazier of Awakening")
					EditMacro("WSxSGen+H",nil,nil,"#showtooltip\n/use [nomounted]Burgy Blackheart's Handsome Hat\n/stopmacro [combat]\n/run if not (IsControlKeyDown()) then if IsMounted() then DoEmote\"mountspecial\"; else DoEmote\"kneel\" end end")
					EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"\\#showtooltip Sprint\\n/use [@\"..B..\"]Tricks of the Trade\\n/stopspelltarget\", nil)print(\"Trix set to : \"..B)else print(\"Combat!\")end")
					EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use Sprint")
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"\\#showtooltip Sprint\\n/use [@\"..N..\"]Tricks of the Trade\\n/stopspelltarget\", nil)print(\"Trix#2 set to : \"..N)else print(\"Combat!\")end")
					EditMacro("WSxGen+N",nil,nil,"#showtooltip\n/use Sprint")
					EditMacro("WSxSRBGCC+1",nil,nil,"")
					EditMacro("WSxGen1",nil,nil,"/use [nocombat,nostealth]Xan'tish's Flute\n/use [@mouseover,help,nodead]Tricks of the Trade;[stance:0,nocombat]Stealth;[spec:3]Symbols of Death;[spec:2]Pistol Shot;[@mouseover,harm,nodead][]Garrote\n/targetenemy [noexists]\n/startattack [combat]")
					EditMacro("WSxSGen+1",nil,nil,"#showtooltip Tricks of the Trade\n/use [mod:ctrl,@party2,help,nodead,nospec:2][@focus,help,nodead,nospec:2][@party1,help,nodead,nospec:2]Shadowstep\n/targetexact Lucian Trias\n/tar Reaves\n/tar Captain Krooz")
					EditMacro("WSxGen2",nil,nil,"/targetenemy [noexists]\n/use [stance:0,nocombat]Stealth;[stealth,nostance:3,nodead]Pick Pocket;[spec:2]Sinister Strike;[spec:3]Shadowstrike;[talent:6/3]Exsanguinate;[talent:6/2]Toxic Blade;Poisoned Knife\n/cleartarget [exists,dead]\n/stopspelltarget")
					EditMacro("WSxSGen+2",nil,nil,"#showtooltip\n/cast Crimson Vial\n/use [nostealth] Totem of Spirits\n/use [nostealth]Hourglass of Eternity\n/use [nocombat,nostealth,spec:2]Don Carlos' Famous Hat;[nocombat,nostealth]Dark Ranger's Spare Cowl")
					EditMacro("WSxGen3",nil,nil,"/use [stance:0,nocombat]Stealth;[stance:0,combat,spec:3]Shadow Dance;[nostance:0,spec:3]Shadowstrike;[spec:2,talent:7/2]Blade Rush;[spec:2,talent:7/3]Killing Spree;[spec:2]Between The Eyes;[spec:1,talent:1/3]Blindside;Sinister Strike")
					EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/use [@mouseover,harm,nodead,spec:1][spec:1]Rupture;[spec:2]Between the Eyes;[spec:3]Nightblade;\n/targetenemy [noexists]")
					EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead]Tricks of the Trade;")
					EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,help,nodead][@party2,help,nodead]Tricks of the Trade")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@focus,help,nodead][@party3,help,nodead]Tricks of the Trade")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,help,nodead][@party4,help,nodead]Tricks of the Trade")
					EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [nocombat,noexists,spec:2]Dead Ringer\n/use [stance:0,nocombat]Stealth;[spec:2,stance:1/2/3]Ambush;[spec:2,talent:1/3]Ghostly Strike;[spec:3]Backstab;[spec:1]Sinister Strike;Pistol Shot\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+4",nil,nil,"/use [nocombat,noexists,nostealth]Barrel of Eyepatches\n/use [talent:3/3]Marked for Death;Feint\n/use [nostealth,nospec:2]Hozen Beach Ball;[nostealth]Titanium Seal of Dalaran\n/targetenemy [noexists]\n/startattack [combat]\n/cleartarget [dead]")
					EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [spec:1]Vendetta;[spec:2]Adrenaline Rush;Shadow Dance;\n/targetenemy [noexists,nocombat]\n/use [nocombat,noexists]Gastropod Shell")
					EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [mod:ctrl]Smoke Bomb;[spec:1]Envenom;[spec:2]Dispatch;Eviscerate;\n/targetenemy [noexists]\n/stopmacro [nomod:ctrl]\n/use [spec:2]Mr. Smite's Brass Compass;Shadescale\n/roar")
					EditMacro("WSxSGen+5",nil,nil,"/use [nocombat,noexists,nostealth]Barrel of Bandanas\n/use [spec:3]Shadow Dance;[spec:2]Roll the Bones\n/use [nocombat,noexists,nostealth] Worn Troll Dice")
					EditMacro("WSxGen6",nil,nil,"#showtooltip\n/use [spec:1,mod:ctrl]Vendetta;[spec:2,mod:ctrl]Adrenaline Rush;[spec:3,mod:ctrl]Shadow Blades;[spec:1]Fan of Knives;[spec:2]!Blade Flurry;[spec:3]Shuriken Storm")
					EditMacro("WSxSGen+6",nil,nil,"/cancelaura Blade Flurry\n/use [spec:1,talent:7/3]Crimson Tempest;[spec:3,stance:0,combat]Shadow Dance;[spec:3,stance:0,nocombat]Stealth;[spec:3]Shuriken Storm;\n/use [spec:2,nocombat]Ghostly Iron Buccaneer's Hat;[nospec:2]Ravenbear Disguise")
					EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [nocombat,help]Corbyn's Beacon;[spec:2]Between The Eyes;[spec:3]Shadow Blades;[spec:1,talent:7/3]Crimson Tempest;[@mouseover,harm,nodead,spec:1][spec:1]Rupture;\n/use [stance:0]Stealth;Autographed Hearthstone Card")
					EditMacro("WSxQQ",nil,nil,"#showtooltip\n/use [mod:alt,@focus,harm,nodead]Blind;[mod:shift]Cloak of Shadows;[@mouseover,harm,nodead][harm,nodead]Kick;The Golden Banana\n/use [spec:2,nocombat,noexists]Rime of the Time-Lost Mariner;[nospec:2,nocombat,noexists]Sira's Extra Cloak")
					EditMacro("WSxStuns",nil,nil,"/use [mod:alt,@focus,harm,nodead,nostance:0][nostance:0]Cheap Shot;[stance:0,combat,spec:3]Shadow Dance;[stance:0,nocombat]Stealth;[stance:0,combat]Vanish\n/use [nostealth,spec:2,nocombat]Iron Buccaneer's Hat")
					EditMacro("WSxGenF",nil,nil,"#showtooltip\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,spec:1,@focus,harm,nodead]Garrote;[mod:alt]Farwater Conch;[@focus,harm,nodead]Kick;[exists,nodead,spec:1]Detoxified Blight Grenade;Detection")
					EditMacro("WSxSGen+F",nil,nil,"/use [stance:0,nocombat]Stealth;[mod:alt,spec:1,stance:0,combat]Vanish;[mod:alt,spec:1,@focus,harm]Garrote;[mod:alt,spec:2,@focus,harm]Gouge\n/use [nospec:2,@focus,harm,nodead][nospec:2]Shadowstep\n/use [nomod,@focus,harm][nomod]Kick")
					EditMacro("WSxCGen+F",nil,nil,"#showtooltip Cloak of Shadows\n/cancelaura Burgy Blackheart's Handsome Hat\n/use [help]Ai-Li's Skymirror\n/summonpet Crackers\n/use Suspicious Crate\n/stopmacro [noexists]\n/whistle")
					EditMacro("WSxCAGen+F",nil,nil,"#showtooltip [stealth]Shroud of Concealment;[nocombat,noexists]Twelve-String Guitar;Cloak of Shadows;\n/targetfriend [nohelp,nodead]\n/use [nospec:2,help,nodead]Shadowstep;[nocombat,noexists]Twelve-String Guitar;\n/targetlasttarget")
					EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [stance:0,nocombat]Stealth;[spec:2,mod:alt,@focus,harm,nodead][spec:2]Between the Eyes;[mod:alt,@focus,exists,nodead][]Kidney Shot\n/use [nocombat,noexists,stance:0]Flaming Hoop")
					EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:alt,spec:1]Wound Poison;[mod:ctrl,spec:1]Deadly Poison;[stance:0,nocombat]Stealth;[spec:2,combat]Riposte;[nospec:2,combat]Evasion;[stance:1]Shroud of Concealment")
					EditMacro("WSxGND",nil,nil,"/use [spec:1,mod:alt]Crippling Poison;[mod:ctrl,spec:2,exists,nodead]Bribe;[mod:ctrl]Scroll of Teleport: Ravenholdt;[mod:shift]Sprint;Feint;\n/use [nostealth,mod:shift]Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
					EditMacro("WSxCC",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [mod:ctrl]Blind;[mod:shift]Smoke Powder;[stance:0,nocombat]Stealth;[@focus,harm,nodead,stance:1/2/3][stance:1/2/3]Sap;Blind;\n/cancelaura Don Carlos' Famous Hat")
					EditMacro("WSxMove",nil,nil,"/use [@mouseover,exists,nodead,nospec:2][nospec:2]Shadowstep;[spec:2,@cursor]Grappling Hook;Sprint;\n/targetenemy [noexists]\n/use [nomod,nostealth]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan")
					EditMacro("WSxCGen+V",nil,nil,"/use [mod:alt,nocombat]"..passengerMount..";[swimming] Barnacle-Encrusted Gem;[harm,nodead]Poisoned Throwing Knives;Survivor's Bag of Coins\n/use [nomod] Whispers of Rai'Vosh")
					if playerspec == 1 then
						EditMacro("WSxRTS",nil,nil,"#showtooltip\n/use [mod:alt]MOLL-E;[@mouseover,harm,nodead][harm,nodead]Poisoned Knife;[@mouseover,nodead][nodead]Shadowstep;[nocombat,noexists]Crashin' Thrashin' Cannon Controller\n/targetenemy [noexists]")
						EditMacro("WSxClassT",nil,nil,"#showtooltip\n/targetenemy [noharm]\n/use [help,nocombat]Swapblaster;[nocombat,nostance:1/2/3]Stealth;[stealth,@cursor],@cursor][nocombat,@cursor]Distract;Poisoned Knife\n/use [nocombat,nostealth]Trans-Dimensional Bird Whistle")	
					elseif playerspec == 2 then
						EditMacro("WSxRTS",nil,nil,"#showtooltip\n/use [mod:alt,@focus,harm,nodead][@mouseover,nomod,harm,nodead][nomod,harm,nodead]Pistol Shot;[mod:alt]MOLL-E;[nocombat,noexists]Crashin' Thrashin' Cannon Controller\n/targetenemy [noexists]")
						EditMacro("WSxClassT",nil,nil,"#showtooltip\n/targetenemy [noharm]\n/use [help,nocombat]Swapblaster;[nocombat,nostance:1/2/3]Stealth;[stealth,@cursor][nocombat,@cursor]Distract;Pistol Shot\n/use [nocombat,nostealth]Trans-Dimensional Bird Whistle")
					else
						EditMacro("WSxRTS",nil,nil,"/use [mod:alt]MOLL-E;[@mousoever,harm,nodead][harm,nodead]Shuriken Toss;[@mouseover,nodead][nodead]Shadowstep;[nocombat,noexists]Crashin' Thrashin' Cannon Controller\n/targetenemy [noexists]")
						EditMacro("WSxClassT",nil,nil,"#showtooltip\n/targetenemy [noharm]\n/use [help,nocombat]Swapblaster;[nocombat,nostance:1/2/3]Stealth;[stealth,@cursor][nocombat,@cursor]Distract;Shuriken Toss\n/use [nocombat,nostealth]Trans-Dimensional Bird Whistle")
					end
					
				-- Priest, Prist

				elseif class == "PRIEST" then
					local pristHeal = "Shadow Mend"
					if (level <= 27 and playerspec == 1) or (playerspec == 2) then 
						pristHeal = "Flash Heal"
					end
					EditMacro("WSxClassT",nil,nil,"/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead,spec:3,talent:4/3][spec:3,talent:4/3,harm,nodead]Psychic Horror;[@mouseover,help,nodead][help,nodead]Leap of Faith;Trans-Dimensional Bird Whistle\n/use [help,nocombat]Swapblaster\n/cleartarget [dead]")
					EditMacro("WSkillbomb",nil,nil,"/use [spec:2,talent:7/2]Apotheosis;[nospec:2]Shadowfiend"..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
					EditMacro("WSxT45",nil,nil,"#showtooltip [nospec:2,mod]Psychic Scream;[nospec:3,talent:3/1]Shining Force;Mind Control\n/use [mod:alt,@player]Mass Dispel;"..racials[race].."\n/use Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
					EditMacro("WSxT15",nil,nil,"#showtooltip [spec:3,talent:1/3]Shadow Word: Void;[spec:1,talent:1/3]Schism;Smite\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#showtooltip [nospec:3]Desperate Prayer;Power Word: Shield\n/use Desperate Prayer"..oOtas)
					EditMacro("WSxT90",nil,nil,"#showtooltip [nospec:3,talent:6/2]Divine Star;[nospec:3,talent:6/3]Halo;[spec:3,talent:6/3]Void Torrent;[nospec:2]Shadow Word: Pain;Leap of Faith\n/use [spec:1]Power Word: Barrier;[@mouseover,help,nodead][help,nodead]Leap of Faith")
					EditMacro("WSxT100",nil,nil,"#showtooltip [spec:3,talent:7/3]Surrender to Madness;[spec:3,talent:7/2]Dark Ascension;[spec:2,talent:7/2]Apotheosis;[spec:2,talent:7/3]Holy Word: Salvation;[spec:1,talent:7/2]Power Word: Barrier;[spec:1,talent:7/3]Evangelism;Smite;")
					EditMacro("WSxCSGen+G",nil,nil,"#showtooltip Fade\n/use [@focus,harm,nodead]Dispel Magic;[nospec:3,@focus,help,nodead][nospec:3]Purify;[@focus,help,nodead][]Purify Disease")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[nocombat]Resurrection;"..pwned.."\n/use [mod:ctrl]Mass Resurrection\n/use [mod:ctrl]Brazier of Awakening")
					EditMacro("WSxT60",nil,nil,"#showtooltip [nospec:3,talent:4/3]Shining Force;[spec:3,talent:4/3]Psychic Horror;[spec:3]Psychic Scream\n/use [nocombat,noexists]Sturdy Love Fool\n/run PetDismiss();\n/cry")
					EditMacro("WSxSRBGCC+1",nil,nil,"/run if not InCombatLockdown()then local C=UnitName(\"target\") EditMacro(\"WSxRBGCC+1\",nil,nil,\"/cleartarget\n/target \"..C..\"\n/use [mod]Mind Bomb;[nomod]Silence;\n/targetlasttarget\", nil)print(\"CC1 : \"..C)else print(\"Cannot change assist now!\")end")
					EditMacro("WSxSRBGCC+1",nil,nil,"")
					EditMacro("WSxSRBGCC+2",nil,nil,"/run if not InCombatLockdown()then local C=UnitName(\"target\") EditMacro(\"WSxRBGCC+2\",nil,nil,\"/cleartarget\n/target \"..C..\"\n/use [mod]Mind Bomb;[nomod]Silence;\n/targetlasttarget\", nil)print(\"CC2 : \"..C)else print(\"Cannot change assist now!\")end")
					EditMacro("WSxSRBGCC+2",nil,nil,"")
					EditMacro("WSxSRBGCC+3",nil,nil,"/run if not InCombatLockdown()then local C=UnitName(\"target\") EditMacro(\"WSxRBGCC+3\",nil,nil,\"/cleartarget\n/target \"..C..\"\n/use [mod]Mind Bomb;[nomod]Silence;\n/targetlasttarget\", nil)print(\"CC3 : \"..C)else print(\"Cannot change assist now!\")end")
					EditMacro("WSxSRBGCC+3",nil,nil,"")
					EditMacro("WSxSGen+H",nil,nil,"#showtooltip Leap of Faith\n/use [nocombat,noexists]Don Carlos' Famous Hat\n/stopmacro [combat]\n/run if not (IsControlKeyDown()) then if IsMounted() then DoEmote\"mountspecial\"; else DoEmote\"kneel\" end end")
					EditMacro("WSxGen1",nil,nil,"#show\n/use [help,nodead]The Heartbreaker;[spec:1,talent:3/3]Power Word: Solace;[spec:1,talent:1/3]Schism;[spec:2]Holy Fire;[spec:3,talent:6/3]Void Torrent;[spec:3]Vampiric Touch;Shadow Word: Pain\n/use [nocombat,noexists]Dead Ringer\n/targetenemy [noexists]")	    
					EditMacro("WSxSGen+1",nil,nil,"/use [mod:ctrl,@party2,exists][@focus,help][@party1,exists][@targettarget,exists]"..pristHeal..";Kaldorei Light Globe\n/tar Reaves\n/tar Captain Krooz")
					EditMacro("WSxGen2",nil,nil,"#showtooltip\n/cancelaura Fling Rings\n/use [nospec:3,help,nodead]Holy Lightsphere\n/use [nocombat] Darkmoon Ring-Flinger\n/use Smite\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+2",nil,nil,"#showtooltip\n/use [@mouseover,help,nodead][]"..pristHeal.."\n/use Gnomish X-Ray Specs\n/cancelaura Don Carlos' Famous Hat")
					EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead,nospec:3][@party1,help,nodead,nospec:3]Purify;[@focus,help,nodead][@party1,help,nodead]Purify Disease;")
					EditMacro("WSxGen3",nil,nil,"/targetenemy [noexists]\n/cleartarget [dead]\n/use [help,nocombat]Scarlet Confessional Book;[@cursor,spec:3,talent:5/3]Shadow Crash;[spec:3,talent:5/2]Shadow Word: Death;[spec:2]Holy Word: Chastise;[spec:1]Rapture;Smite\n/petattack\n/use Ivory Feather")
					EditMacro("WSxCSGen+3",nil,nil,"/use [nospec:2,@focus,harm,nodead]Shadow Word: Pain;[@party2,help,nodead,nospec:3]Purify;[@party2,help,nodead]Purify Disease;[nocombat,noharm]Spirit Wand;\n/stopspelltarget")
					EditMacro("WSxGen4",nil,nil,"/use [nocombat,noexists]Pretty Draenor Pearl\n/use [spec:3]Mind Blast;[spec:2,@mouseover,help,nodead][spec:2]Holy Word: Serenity;[@mouseover,help,nodead][]Penance\n/targetenemy [noexists]\n/cancelaura Dispersion\n/cleartarget [dead]")
					EditMacro("WSxCSGen+4",nil,nil,"/use [spec:3,@focus,harm,nodead]Vampiric Touch;[@focus,nospec:2,help,nodead][@party1,help,nodead,nospec:2]Power Word: Shield;[@focus,help,nodead][@party1,help,nodead]Prayer of Mending;[nocombat]Romantic Picnic Basket;")
					EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/use [mod:alt,spec:3,talent:5/3,@player]Shadow Crash;[spec:2,talent:4/3]Symbol of Hope;[spec:1,@player]Penance;[spec:3]Mind Sear;\n/targetfriend [spec:3]\n/targetenemy [noexists]\n/use [nocombat,nochanneling]Soul Evacuation Crystal")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,nospec:2,help,nodead][@party2,help,nodead,nospec:2]Power Word: Shield;[@focus,help,nodead][@party2,help,nodead]Prayer of Mending;\n/use Battle Standard of Coordination")
					EditMacro("WSxGen6",nil,nil,"#showtooltip\n/use [mod:ctrl,spec:2]Divine Hymn;[mod:ctrl]Shadowfiend;[@mouseover,exists,nodead,spec:3][spec:3]Mind Sear;Holy Nova\n/targetenemy [noharm]\n/cleartarget [dead]\n/use [nocombat,noexists,spec:3]Twitching Eyeball")
					EditMacro("WSxSGen+6",nil,nil,"/use [@mouseover,help,nodead,spec:2][spec:2]Prayer of Healing;[@mouseover,help,nodead,spec:1][spec:1]Power Word: Radiance;[spec:3,talent:3/3,@mouseover,harm,nodead][spec:3,talent:3/3]Dark Void;Shadowfiend;\n/use Cursed Feather of Ikzan")
					EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [help,nodead,nocombat]Corbyn's Beacon;[spec:2,mod:shift,@player][spec:2,@cursor]Holy Word: Sanctify;[spec:3]!Void Eruption;[talent:7/3]Evangelism;[talent:6/2]Divine Star;[talent:6/3]Halo;Holy Nova")
					EditMacro("WSxQQ",nil,nil,"#showtooltip\n/use [mod:alt,@focus,harm,nodead][spec:1,notalent:4/3]Mind Control;[nospec:3,talent:4/3,nomod]Shining Force;[spec:2]Holy Word: Chastise;[@mouseover,harm,nodead][]Silence")
					EditMacro("WSxStuns",nil,nil,"#showtooltip\n/use [mod:alt,@cursor]Mass Dispel;[@mouseover,harm,nodead][exists][combat]Psychic Scream;[noexists,nocombat]Party Totem;")
					EditMacro("WSxRTS",nil,nil,"/use [mod:alt]MOLL-E;[mod:shift,spec:1]Psychic Scream;[mod:ctrl,nospec:3,talent:2/3,@player][nospec:3,talent:2/3,@cursor]Angelic Feather;[spec:2,talent:2/2]Body and Mind;[mod:ctrl,@player][@mouseover,help,nodead][]Power Word: Shield\n/stopspelltarget")
					EditMacro("WSxGenF",nil,nil,"/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@focus,harm,nodead]Shackle Undead;[mod:alt,exists,nodead]Mind Vision;[mod:alt]Farwater Conch;[spec:3,@focus,harm,nodead]Silence;[help,nodead]True Love Prism;Doomsayer's Robes")
					EditMacro("WSxSGen+F",nil,nil,"/use [help,nocombat,mod:alt]B. F. F. Necklace;[nocombat,noexists,mod:alt]Gastropod Shell;[nocombat,noexists,nomod]Tickle Totem;[nospec:3,talent:4/3,nomod,@player]Shining Force\n/cancelaura [mod:alt]Shadowform")
					EditMacro("WSxCGen+F",nil,nil,"#showtooltip [spec:3]Mind Control;Psychic Scream\n/use [nocombat,noexists]Piccolo of the Flaming Fire;[spec:3]Vampiric Embrace;Psychic Scream\n/cancelaura Twice-Cursed Arakkoa Feather")
					EditMacro("WSxGG",nil,nil,"#showtooltip\n/use [mod:alt]Darkmoon Gazer;[@mouseover,harm,nodead]Dispel Magic;[nospec:3,@mouseover,help,nodead][nospec:3]Purify;[@mouseover,help,nodead][]Purify Disease;")
					EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [@mouseover,spec:1,help,nodead][spec:1]Pain Suppression;[@mouseover,spec:2,help,nodead][spec:2]Guardian Spirit;[spec:3]!Dispersion;")
					EditMacro("WSxGND",nil,nil,"/use [mod:shift]Fade;[mod,exists,nodead]Mind Control;[mod]Unstable Portal Emitter;[spec:2,@mouseover,help,nodead][spec:2]Prayer of Mending;[@mouseover,help,nodead][]Power Word: Shield\n/use [nocombat]Bubble Wand\n/use Void Totem\n/cancelaura Bubble Wand")
					EditMacro("WSxCC",nil,nil,"#show\n/use [mod:ctrl]Shackle Undead;[mod:shift,@focus,help,nodead]Power Word: Shield;[spec:2,mod:shift]Symbol of Hope;[spec:2,@mouseover,help,nodead][spec:2]Renew;[mod:shift][]Shadowfiend;\n/cancelaura X-Ray Specs\n/use Poison Extraction Totem")
					EditMacro("WSxMove",nil,nil,"#showtooltip\n/use Fade\n/use [nomod]Panflute of Pandaria\n/use Puzzle Box of Yogg-Saron\n/use Spectral Visage\n/use Xan'tish's Flute\n/cancelaura Rhan'ka's Escape Plan")
					EditMacro("WSxCGen+V",nil,nil,"#showtooltip [nospec:3,talent:4/3]Shining Force;Psychic Scream\n/use [mod:alt,nocombat]"..passengerMount..";[swimming,noexists,nocombat] Barnacle-Encrusted Gem;Levitate\n/use [nomod]Seafarer's Slidewhistle\n/use [nomod]Thaumaturgist's Orb")
					if playerspec == 1 then
						EditMacro("WSxSGen+3",nil,nil,"#showtooltip Shadow Word: Pain\n/targetenemy [noexists]\n/stopspelltarget\n/cleartarget [dead]\n/use [@mouseover,harm,nodead][nomod]Shadow Word: Pain\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Shadow Word: Pain\n/targetlasttarget")
						EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [talent:1/3]Schism;[talent:5/3]Shadow Covenant;Smite;\n/use [nocombat,noexists]Leather Love Seat\n/stopspelltarget")
						EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [@mouseover,help,nodead,talent:5/3][talent:5/3]Shadow Covenant;[talent:7/3]Evangelism;Power Word: Barrier\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [mod:ctrl,spec:1,@cursor]Power Word: Barrier;Holy Nova\n/use [help,nodead]Apexis Focusing Shard\n/targetenemy [noexists]")
						EditMacro("WSxCAGen+F",nil,nil,"#showtooltip Power Word: Barrier\n/use [combat,@player]Power Word: Barrier\n/use [nocombat] Starlight Beacon\n/cancelaura Twice-Cursed Arakkoa Feather")
						EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Shadow Mend;[@\"..B..\"]Power Word: Shield\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Shadow Mend;[@\"..N..\"]Power Word: Shield\", nil)print(\"Tank#2 set to: \" ..N)else print(\"Combat!\")end")
					elseif playerspec == 2 then
						EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/stopspelltarget\n/cleartarget [dead]\n/use [talent:6/2]Divine Star;[talent:6/3]Halo;\n/use Totem of Spirits")
						EditMacro("WSxSGen+4",nil,nil,"/use [@mouseover,help,nodead,talent:5/2][talent:5/2]Binding Heal;[@mouseover,help,nodead,talent:5/3][talent:5/3]Circle of Healing;[@mouseover,help,nodead][]Prayer of Healing;\n/use [nocombat,noexists]Leather Love Seat\n/stopspelltarget")
						EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [spec:2,talent:7/2]Apotheosis;[spec:2,talent:7/3]Holy Word: Salvation;Smite;\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [spec:2,@mouseover,help,nodead][spec:2]Heal\n/targetenemy [noexists]")
						EditMacro("WSxCAGen+F",nil,nil,"#showtooltip Divine Hymn")
						EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Flash Heal;[spec:2,@\"..B..\"]Prayer of Mending;[@\"..B..\"]Power Word: Shield\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Flash Heal;[spec:2,@\"..N..\"]Prayer of Mending;[@\"..N..\"]Power Word: Shield\", nil)print(\"Tank#2 set to: \" ..N)else print(\"Combat!\")end")
					else
						EditMacro("WSxSGen+3",nil,nil,"#showtooltip Shadow Word: Pain\n/targetenemy [noexists]\n/stopspelltarget\n/cleartarget [dead]\n/use [@mouseover,harm,nodead][nomod]Shadow Word: Pain\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Shadow Word: Pain\n/targetlasttarget")
						EditMacro("WSxSGen+4",nil,nil,"/stopspelltarget\n/targetenemy [noharm]\n/cleartarget [dead]\n/use [noform]Shadowform;[nomod,nocombat,noexists]Shadescale\n/use [@mouseover,harm,nodead][nomod]Vampiric Touch\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Vampiric Touch\n/targetlasttarget")
						EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [spec:3,talent:7/3]Surrender to Madness;[spec:3,talent:7/2]Dark Ascension;Smite;\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [spec:3,@mouseover,harm,nodead][spec:3]Void Eruption\n/targetenemy [noexists]")
						EditMacro("WSxCAGen+F",nil,nil,"#showtooltip Vampiric Embrace\n/target Ebon Gargoyle\n/targetlasttarget\n/target Ebon Gargoyle\n/use Shackle Undead\n/targetlasttarget\n/use [nocombat] Starlight Beacon\n/cancelaura Twice-Cursed Arakkoa Feather")
						EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Shadow Mend;[@\"..B..\"]Power Word: Shield\", nil)print(\"Vigil set to : \"..B)else print(\"Combat!\")end")
						EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Shadow Mend;[@\"..N..\"]Power Word: Shield\", nil)print(\"Vigil#2 set to: \"..N)else print(\"Combat!\")end")
					end

				-- Death Knight, DK, diky

				elseif class == "DEATHKNIGHT" then
					EditMacro("WSkillbomb",nil,nil,"#showtooltip\n/use [spec:1]Dancing Rune Weapon;[spec:2]Pillar of Frost;[nopet]Raise Dead;Dark Transformation"..dpsRacials[race].."\n/use 13\n/use Combat Ally\n/use Angry Beehive\n/use Pendant of the Scarab Storm\n/use Adopted Puppy Crate\n/use Big Red Raygun")
					EditMacro("WSxT15",nil,nil,"#showtooltip [spec:1,talent:1/2]Blooddrinker;[spec:1,talent:1/3]Rune Strike\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#showtooltip [spec:1,talent:2/2]Soulgorge;[spec:2,talent:2/3]Horn of Winter;[spec:3,talent:2/3]Unholy Blight"..oOtas)
					EditMacro("WSxT45",nil,nil,"#showtooltip [spec:3,talent:3/3][spec:2,talent:3/2]Asphyxiate;[spec:2,talent:3/3]Blinding Sleet;[spec:1,talent:3/2]Blood Tap;Raise Ally\n/use "..racials[race])
					EditMacro("WSxT90",nil,nil,"#showtooltip [spec:2,talent:6/2]Glacial Advance;[spec:2,talent:6/3]Frostwyrm's Fury;[spec:3,talent:6/3]Epidemic;[spec:3]Death and Decay;[spec:2,talent:6/1];[spec:1,talent:6/2]Rune Tap;\n/use Dark Command\n/use Blight Boar Microphone")
					EditMacro("WSxT100",nil,nil,"#showtooltip [spec:2,talent:7/3]Breath of Sindragosa;[spec:3,talent:7/3]Summon Gargoyle;[spec:3,talent:7/2]Unholy Frenzy;[spec:1,talent:7/3]Bonestorm;")
					EditMacro("WSxCSGen+G",nil,nil,"#showtooltip [nospec:1,talent:5/2][spec:1,talent:5/3]Wraith Walk;[nospec:1,talent:5/3]Death Pact")
					EditMacro("WSxT60",nil,nil,"#showtooltip [spec:1,talent:4/3]Tombstone;[spec:1,talent:4/1]Mark of Blood;[spec:2,talent:4/3]Frostscythe;[spec:3,talent:4/3]Soul Reaper;\n/use Sylvanas' Music Box\n/run PetDismiss();\n/cry")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned.."\n/use [mod:ctrl]Brazier of Awakening")
					EditMacro("WSxSGen+H",nil,nil,"#showtooltip\n/use [nomounted]Death Gate\n/stopmacro [combat]\n/run if not (IsControlKeyDown()) then if IsMounted() then DoEmote\"mountspecial\"; else DoEmote\"kneel\" end end")
					EditMacro("WSxCAGen+F",nil,nil,"#showtooltip [spec:3,pet,talent:4/1]!Smash;[spec:3,pet]!Gnaw;Stolen Breath\n/use 16\n/equipset "..EQS[playerspec].."\n/run local _,d,_=GetItemCooldown(151255) if d==0 then EquipItemByName(151255) end")
					EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use Asphyxiate")
					EditMacro("WSxCAGen+B",nil,nil,"")
					EditMacro("WSxGen+N",nil,nil,"#showtooltip\n/use [spec:1,talent:5/3][nospec:1,talent:5/2]Wraith Walk;[nospec:1,talent:5/3]Death Pact;")
					EditMacro("WSxCAGen+N",nil,nil,"")
					EditMacro("WSxGen1",nil,nil,"#showtooltip\n/cast [@mouseover,help,dead][help,dead]Raise Ally;[spec:2,talent:6/2]Glacial Advance;[spec:2,talent:6/3]Frostwyrm's Fury;[spec:3]Apocalypse;[spec:1,talent:2/3]Consumption;[spec:1,talent:1/2]Blooddrinker;Death Strike\n/targetenemy [noexists]")
					EditMacro("WSxSGen+1",nil,nil,"#showtooltip\n/use [@mouseover,exists][]Raise Ally\n/use Stolen Breath\n/tar Reaves\n/tar Captain Krooz")
					EditMacro("WSxGen2",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use [harm,dead,nocombat]Corpse Exploder;[spec:1,talent:3/3]Tombstone;[spec:1]Heart Strike;[spec:2,@mouseover,harm,nodead][spec:2]Howling Blast;[@mouseover,harm,nodead][]Scourge Strike\n/startattack")
					EditMacro("WSxSGen+2",nil,nil,"#showtooltip\n/use Death Strike\n/use Gnomish X-Ray Specs")
					EditMacro("WSxCSGen+2",nil,nil,"")
					EditMacro("WSxGen3",nil,nil,"#showtooltip\n/use [nocombat,noexists]Sack of Spectral Spiders;[spec:3,talent:4/3]Soul Reaper;[spec:3]Scourge Strike;[spec:2,talent:7/3]Breath of Sindragosa;[spec:2]Obliterate;[spec:1]Marrowrend;\n/startattack")
					EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/use [spec:2,talent:2/3]Horn of Winter;[spec:3,@mouseover,harm,nodead][spec:3]Outbreak;[spec:1,@mouseover,harm,nodead][spec:1]Death's Caress;[spec:2]Howling Blast;\n/targetenemy [noexists]\n/startattack\n/stopspelltarget")
					EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noharm]Spirit Wand;[@focus,exists,harm,nodead,spec:3]Outbreak;[@focus,exists,harm,nodead,spec:2]Howling Blast;\n/stopspelltarget")
					EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [spec:1,talent:6/3]Mark of Blood;[spec:1]Death Strike;[spec:2]Obliterate;[spec:3]Festering Strike;\n/startattack")
					EditMacro("WSxSGen+4",nil,nil,"#show [spec:2,talent:4/3]Frostscythe;[spec:3]Army of the Dead;[spec:2]Obliterate;Death and Decay\n/use [spec:2,talent:4/3]Frostscythe;[spec:2]Obliterate;[@cursor]Death and Decay\n/use [spec:1]Krastinov's Bag of Horrors\n/targetenemy [noexists]")
					EditMacro("WSxCSGen+4",nil,nil,"")
					EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [mod:ctrl,spec:3,@player]Army of the Dead;[spec:1,talent:1/2]Blooddrinker;[spec:1,talent:1/3]Rune Strike;[spec:1]Death Strike;[spec:2]Frost Strike;[@mouseover,harm,nodead][]Death Coil;\n/startattack\n/cleartarget [dead]")
					EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/use [spec:1,talent:2/2]Soulgorge;[spec:3,talent:2/3]Unholy Blight\n/use [spec:3,talent:2/3][]Angry Beehive\n/startattack")
					EditMacro("WSxCSGen+5",nil,nil,"/clearfocus")
					EditMacro("WSxGen6",nil,nil,"#showtooltip\n/use [spec:2,mod:ctrl]Pillar of Frost;[spec:3,mod:ctrl]Summon Gargoyle;[spec:1]Heart Strike;[spec:3,talent:6/3]Epidemic;[spec:3,@cursor]Death and Decay;[spec:2]Remorseless Winter\n/use [mod:ctrl]Angry Beehive")
					EditMacro("WSxSGen+6",nil,nil,"#showtooltip\n/use [spec:2]Remorseless Winter;[@player]Death and Decay\n/use [noexists,nocombat,spec:1] Vial of Red Goo\n/stopspelltarget\n/cancelaura Secret of the Ooze")
					EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [spec:3,nopet]Raise Dead;[spec:3,pet]Dark Transformation;[spec:2,talent:4/3]Frostscythe;[spec:2]Pillar of Frost;Blood Boil\n/use [nocombat,noexists]Champion's Salute\n/use [nocombat]Permanent Frost Essence\n/use [nocombat]Stolen Breath")
					EditMacro("WSxQQ",nil,nil,"/use [mod:alt,@focus,harm,nodead]Asphyxiate;[@mouseover,harm,nodead][]Mind Freeze;")
					EditMacro("WSxStuns",nil,nil,"#showtooltip\n/use [mod:alt,spec:2]Blinding Sleet;[@focus,mod:alt,harm,nodead,pet]Gnaw;[@mouseover,harm,nodead][]Death Grip;\n/startattack\n/petattack [mod:alt,@focus,exists,nodead]")
					EditMacro("WSxRTS",nil,nil,"#showtooltip \n/use [mod:ctrl]!Wraith Walk;[mod:shift,spec:1,@player][spec:1,nomod:alt]Gorefiend's Grasp;[mod:alt,@focus,harm,nodead][nomod,@mouseover,harm,nodead][nomod]Chains of Ice;[mod:alt]MOLL-E;\n/targetenemy [noexists]")
					EditMacro("WSxClassT",nil,nil,"#showtooltip Dark Command\n/use [@mouseover,harm,nodead,spec:3][spec:3,pet,harm,nodead]Leap;[help,nocombat]Swapblaster;[nocombat]Trans-Dimensional Bird Whistle\n/petattack [@mouseover,exists,nodead][]\n/startattack")
					EditMacro("WSxGenF",nil,nil,"#showtooltip\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@focus,harm,nodead]Death Grip;[mod:alt]Legion Communication Orb;[@focus,harm,nodead]Mind Freeze;Fishing;\n/petattack [mod:alt,@focus,harm,nodead]")
					EditMacro("WSxSGen+F",nil,nil,"#showtooltip Claw\n/use [nocombat,mod:alt]Gastropod Shell;[nomod,spec:3,pet,@focus,harm,nodead][nomod,spec:3,pet,harm,nodead]Dark Transformation\n/use [nomod:spec:3,pet,@focus,harm,nodead][nomod,spec:3,pet,harm,nodead]!Leap\n/petautocasttoggle [mod:alt]Claw")
					EditMacro("WSxCGen+F",nil,nil,"#showtooltip\n/use [spec:1] Vampiric Blood;[pet:Abomination]Protective Bile;[pet]Huddle;")
					EditMacro("WSxGG",nil,nil,"/use [mod:alt,@focus,harm,nodead]Dark Simulacrum;[mod:alt]S.F.E. Interceptor;[spec:3,nopet]Raise Dead;[spec:3,pet:Ghoul]Leap;[spec:1,talent:4/3]Rune Tap;[@focus,harm,nodead][]Death Grip;\n/use [nocombat]Lilian's Warning Sign")
					EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [spec:1,mod:shift]Dancing Rune Weapon;Icebound Fortitude")
					EditMacro("WSxGND",nil,nil,"#showtooltip\n/use [mod:alt]Runeforging;[mod:ctrl,exists,nodead]Control Undead;[mod:ctrl]Death Gate;Anti-Magic Shell;")
					EditMacro("WSxCC",nil,nil,"#showtooltip\n/use [spec:3,mod:shift,nopet]Raise Dead;[nospec:1,talent:5/3,mod:shift]Death Pact;[spec:2,talent:3/3]Blinding Sleet;[spec:3,talent:3/3][spec:2,talent:3/2][spec:1]Asphyxiate;[spec:3]Leap;\n/cancelaura X-Ray Specs")
					EditMacro("WSxMove",nil,nil,"#showtooltip\n/use !Death's Advance\n/use Syxsehnz Rod\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan")
					EditMacro("WSxCGen+V",nil,nil,"/use [mod:alt,nocombat]"..passengerMount..";[swimming,noexists,nocombat] Barnacle-Encrusted Gem;[exists][]Path of Frost\n/use [nomod] Whispers of Rai'Vosh")
					EditMacro("WSxSRBGCC+1",nil,nil,"")
					if playerspec == 1 then
						EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [talent:7/3]Bonestorm\n/use For da Blood God!\n/startattack")
					elseif playerspec == 2 then						
						EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use Empower Rune Weapon\n/use [combat]Will of Northrend\n/startattack")
					else						
						EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [talent:7/2]Unholy Frenzy;[talent:7/3]Summon Gargoyle;\n/use [combat]Will of Northrend\n/startattack")
					end

				-- Warrior, warror

				elseif class == "WARRIOR" then	
					if race == "Scourge" then
						EditMacro("WSxSGen+2",nil,nil,"#showtooltip\n/targetlasttarget [noexists,nodead]\n/use [dead,harm]Cannibalize;Victory Rush;\n/use [noexists,nocombat,nochanneling]Gnomish X-Ray Specs\n/startattack")
					else
						EditMacro("WSxSGen+2",nil,nil,"#showtooltip\n/use Victory Rush\n/use [noexists,nocombat,nochanneling]Gnomish X-Ray Specs\n/targetenemy [noharm]\n/startattack")
					end	
					EditMacro("WSxT45",nil,nil,"#showtooltip [spec:2,talent:3/3]Furious Slash;[spec:1,talent:3/3]Rend;[spec:3]Demoralizing Shout;Execute\n/use [spec:3]Demoralizing Shout;[@mouseover,harm,nodead][]Intimidating Shout;\n/startattack\n/targetenemy")
					EditMacro("WSkillbomb",nil,nil,"#showtooltip Charge\n/use Flippable Table\n/use Bloodbath\n/use Dragon Roar"..dpsRacials[race].."\n/use Avatar\n/use Heart Essence\n/use Will of Northrend\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
					EditMacro("WSxT15",nil,nil,"#showtooltip [spec:1,talent:1/2]Overpower;[spec:3,talent:1/1]Shockwave;[spec:3,talent:1/2]Storm Bolt\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#showtooltip [spec:1/2,talent:2/3]Storm Bolt\n/use Outrider's Bridle Chain"..oOtas)
					EditMacro("WSxT90",nil,nil,"#showtooltip [spec:2,talent:6/2]Dragon Roar;[spec:2,talent:6/3]Bladestorm;\n/use [harm,nodead]Taunt\n/use Blight Boar Microphone")
					EditMacro("WSxT100",nil,nil,"#showtooltip [spec:1]Bladestorm;[spec:2,talent:7/3]Siegebreaker;[spec:3,talent:7/3]Ravager;Execute")
					EditMacro("WSxCSGen+G",nil,nil,"#showtooltip [spec:2]Piercing Howl;[spec:3]Intimidating Shout;Taunt;\n/use\n/use Burning Blade")
					EditMacro("WSxT60",nil,nil,"#showtooltip\n/use [spec:1,talent:4/3,nomod]Defensive Stance\n/use Sylvanas' Music Box\n/run PetDismiss();\n/cry")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned.."\n/use [mod:ctrl]Brazier of Awakening")
					EditMacro("WSxCAGen+F",nil,nil,"#showtooltip Rallying Cry\n/use [nocombat]Throbbing Blood Orb\n/run local _,d,_=GetSpellCooldown(6544) if d==0 then "..tipiSet.." end\n/use [@cursor]Heroic Leap\n/equipset "..EQS[playerspec])
					EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use Spell Reflection")
					EditMacro("WSxCAGen+B",nil,nil,"")
					EditMacro("WSxGen+N",nil,nil,"#showtooltip [nospec:3]Rallying Cry;Last Stand")
					EditMacro("WSxCAGen+N",nil,nil,"")
					EditMacro("WSxSGen+H",nil,nil,"#showtooltip [spec:1,talent:4/3]Defensive Stance;Whirlwind\n/use [nomounted]Darkmoon Gazer\n/stopmacro [combat]\n/run if not (IsControlKeyDown()) then if IsMounted() then DoEmote\"mountspecial\"; else DoEmote\"kneel\" end end")
					EditMacro("WSxSRBGCC+1",nil,nil,"")
					EditMacro("WSxGen1",nil,nil,"#showtooltip\n/use [nocombat,help]Corbyn's Beacon;[spec:1]Colossus Smash;[spec:2]Rampage;[spec:3]Shield Block;\n/targetenemy [noexists]\n/startattack\n/use Chalice of Secrets")
					EditMacro("WSxSGen+1",nil,nil,"/use [spec:3]Ignore Pain;[spec:1]Sweeping Strikes\n/use Chalice of Secrets\n/targetexact Aerylia\n/tar Reaves\n/tar Captain Krooz")
					EditMacro("WSxGen2",nil,nil,"#showtooltip\n/use [nocombat,noexists]Vrykul Drinking Horn;[spec:1]Mortal Strike;[spec:2]Bloodthirst;[spec:3]Devastate;\n/targetenemy [noexists]\n/cleartarget [noharm]\n/startattack\n/cancelaura Vrykul Drinking Horn")
					EditMacro("WSxCSGen+2",nil,nil,"")
					EditMacro("WSxGen3",nil,nil,"#showtooltip\n/use [spec:3]Revenge;Execute;\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]\n/use Burning Blade")
					EditMacro("WSxSGen+3",nil,nil,"/use [spec:1,talent:3/3]Rend;[spec:1]Slam;[spec:2,talent:6/2][spec:3,talent:3/3]Dragon Roar;[spec:2,talent:6/3]Bladestorm;[spec:3]Thunder Clap;Whirlwind\n/startattack")
					EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Rend;Vrykul Toy Boat;")
					EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [spec:1]Overpower;[spec:2]Raging Blow;[spec:3]Shield Slam;\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
					EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/use [spec:3]Shockwave;[spec:1,talent:1/3]Skullsplitter;[spec:2,talent:7/3]Siegebreaker;\n/use Muradin's Favor\n/startattack")
					EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [spec:1,talent:6/2][spec:3]Avatar;[spec:1,talent:6/3]Deadly Calm;[spec:2]Recklessness\n/startattack\n/cleartarget [dead]\n/use [nocombat,noexists]Tosselwrench's Mega-Accurate Simulation Viewfinder")
					EditMacro("WSxCSGen+4",nil,nil,"")
					EditMacro("WSxGen5",nil,nil,"/use [mod]Rallying Cry;[spec:1]Slam;[spec:2,talent:3/3]Furious Slash;[spec:2]Execute;[spec:3]Thunder Clap\n/startattack\n/cleartarget [dead]\n/stopmacro [nomod]\n/use [mod]Gamon's Braid\n/roar")
					EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/use [spec:2,talent:6/2]Dragon Roar;[nospec:2,talent:7/3]Ravager;[spec:1][spec:2,talent:6/3]Bladestorm;Whirlwind;\n/startattack")
					EditMacro("WSxCSGen+5",nil,nil,"/clearfocus")
					EditMacro("WSxGen6",nil,nil,"#showtooltip [spec:3]Thunder clap;Whirlwind;\n/use [spec:2,talent:7/1,mod:ctrl][spec:1,mod:ctrl]Bladestorm;[spec:3,talent:7/3,mod:ctrl]Ravager;[nospec:3]Whirlwind;[spec:3]Thunder Clap;\n/startattack\n/use Words of Akunda")
					EditMacro("WSxSGen+6",nil,nil,"#showtooltip\n/use [nospec:2,talent:7/3,@player]Ravager;[spec:2]Rampage;[spec:3]Shield Block;\n/targetenemy [noexists,nospec:2]\n/targetenemy [spec:2]\n/startattack")
					if not warPvPExc then
						return
					end
					EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use "..warPvPExc.."[spec:2,talent:6/2]Dragon Roar;[spec:2,talent:6/3]Bladestorm;[spec:3]Ignore Pain;[spec:1,talent:5/3]Cleave;Whirlwind\n/startattack\n/use Mote of Light\n/use World Shrinker")
					EditMacro("WSxQQ",nil,nil,"#showtooltip Pummel\n/use [mod:alt,@focus,exists,nodead]Storm Bolt;[mod:shift]Berserker Rage;[@mouseover,harm,nodead,nomod]Charge;\n/use [@mouseover,harm,nodead,nomod][nomod]Pummel;")
					EditMacro("WSxStuns",nil,nil,"#showtooltip\n/use [@mouseover,harm,nodead][]Charge\n/use [noexists,nocombat]Arena Master's War Horn\n/startattack\n/cleartarget [dead][help]\n/targetenemy [noharm]")
					EditMacro("WSxRTS",nil,nil,"/use [mod:alt,spec:1,@focus,harm,nodead][spec:1,nomod]Hamstring;[mod:alt]MOLL-E;[spec:2,mod:shift]Piercing Howl;[@mouseover,help,nodead]Charge;[@mouseover,harm,nodead][]Heroic Throw;\n/startattack")
					EditMacro("WSxClassT",nil,nil,"#showtooltip Taunt\n/use [help,nocombat]Swapblaster;Heroic Throw;\n/use [nocombat]Trans-Dimensional Bird Whistle\n/startattack\n/use Blight Boar Microphone")
					EditMacro("WSxGenF",nil,nil,"#showtooltip Berserker Rage\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Pummel;Survey;")
					EditMacro("WSxSGen+F",nil,nil,"/use [@focus,harm,nodead]Charge\n/use [@focus,harm,nodead]Pummel\n/use [nocombat,noexists,mod:alt] Gastropod Shell;Faintly Glowing Flagon of Mead")
					EditMacro("WSxCGen+F",nil,nil,"#showtooltip\n/use [spec:1]Die By The Sword;[spec:2]Enraged Regeneration;[spec:3]Demoralizing Shout")
					EditMacro("WSxGG",nil,nil,"#showtooltip\n/use [mod:alt]S.F.E. Interceptor;[spec:1/2,talent:2/3][spec:3,talent:5/3]Storm Bolt;[spec:3]Demoralizing Shout;Whirlwind;\n/targetenemy [noharm]")
					EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod]Defensive Stance;[spec:1]Die By The Sword;[spec:2]Enraged Regeneration;[spec:3]Shield Wall\n/use Stormforged Vrykul Horn")
					EditMacro("WSxGND",nil,nil,"#showtooltip\n/use [nomod,spec:3]Last Stand;[nomod]Rallying Cry;\n/targetfriend [mod:shift,nohelp]\n/use [mod:shift,help,nodead]Charge\n/targetlasttarget [mod:shift]")
					EditMacro("WSxCC",nil,nil,"#showtooltip [spec:1/2]Intimidating Shout;Spell Reflection;\n/use [mod:ctrl]Intimidating Shout;[spec:3]Spell Reflection;\n/use Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
					EditMacro("WSxMove",nil,nil,"/use [@cursor] Heroic Leap\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan")
					EditMacro("WSxCGen+V",nil,nil,"/use [mod:alt,nocombat]"..passengerMount..";[swimming] Barnacle-Encrusted Gem\n/use Heroic Leap\n/use [nomod] Whispers of Rai'Vosh")

				-- Druid, dodo

				elseif class == "DRUID" then
					EditMacro("WSxT30",nil,nil,"#show [talent:2/3]Wild Charge;[talent:2/2]Renewal\n/use [talent:2/1]Renewal;Swiftmend\n/use [nocombat]Mylune's Call"..oOtas)
					EditMacro("WSxT45",nil,nil,"#showtooltip\n/use [spec:2,form:2,talent:5/2]Rake;[nospec:4,@mouseover,help,nodead,talent:3/3][spec:4,@mouseover,help,nodead][nospec:4,talent:3/3][spec:4]Wild Growth;Dreamwalk;\n/use [spec:2,talent:5/2]!Prowl")
					EditMacro("WSxT90",nil,nil,"#showtooltip [spec:1,talent:6/3]Stellar Flare;[spec:2,talent:6/2]Brutal Slash;[spec:2,talent:6/3]Primal Wrath;Prowl;\n/use Growl\n/dance [nocombat]")
					EditMacro("WSxT100",nil,nil,"#showtooltip [spec:1,talent:7/1]Fury of Elune;[spec:4,talent:7/3]Flourish;[spec:3,talent:7/3]Pulverize;[spec:3,talent:7/2]Lunar Beam;Prowl;")
					EditMacro("WSxCSGen+G",nil,nil,"#showtooltip Dash\n/use [spec:4,@focus,help,nodead]Nature's Cure;[@focus,help,nodead]Remove Corruption")
					EditMacro("WSxT15",nil,nil,"#showtooltip [spec:1,talent:1/3]Force of Nature;[spec:1,talent:1/2]Warrior of Elune;[spec:4,talent:1/3]Cenarion Ward;[spec:3,noform:1,talent:1/2]Bear Form(Shapeshift);[spec:3,talent:1/2]Bristling Fur\n/use "..invisPot)
					EditMacro("WSxT60",nil,nil,"#showtooltip [talent:4/3]Typhoon;[talent:4/2]Mass Entanglement;[talent:4/1]Mighty Bash;\n/run PetDismiss();\n/cry")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/cancelaura Flap\n/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[nocombat]Revive;"..pwned.."\n/use [mod:ctrl]Revitalize\n/use [mod:ctrl]Brazier of Awakening")
					EditMacro("WSxSGen+H",nil,nil,"#showtooltip\n/use [spec:2/3]Stampeding Roar;Wisp Amulet\n/use Wisp Amulet\n/stopmacro [combat]\n/run if not (IsControlKeyDown()) then if IsMounted() then DoEmote\"mountspecial\"; else DoEmote\"kneel\" end end")
					EditMacro("WSxSGen+F",nil,nil,"/cancelform [mod:alt]\n/use [mod:alt,nocombat]Gastropod Shell;[nomod,form:3/6,talent:2/3]Wild Charge;[nomod,noform:3/6]Travel Form(Shapeshift)\n/stopspelltarget")
					EditMacro("WSxClassT",nil,nil,"#showtooltip Growl\n/use [help,nocombat]Swapblaster;[noform:1]Bear form(Shapeshift);Growl;\n/use [nocombat]Trans-Dimensional Bird Whistle\n/targetenemy [noexists]\n/use [spec:3]Highmountain War Harness\n/cancelaura [noform:1]Highmountain War Harness")
					EditMacro("WSxStuns",nil,nil,"/use [talent:2/3,help,nodead,noform][talent:2/3,form:1/2]Wild Charge;[spec:3]Incapacitating Roar;\n/use [spec:2,talent:5/2][nocombat]!Prowl;[combat,noform:1/2]Bear Form(Shapeshift);\n/targetenemy [noexists]\n/cancelform [help,nodead]\n/use Ravenbear Disguise")
					EditMacro("WSxQQ",nil,nil,"/use [mod:alt,@focus,harm,nodead]Cyclone;[spec:4,@cursor]Ursol's Vortex;[spec:2,noform:1/2]Cat Form;[spec:3,noform:1/2]Bear Form(Shapeshift);[@mouseover,harm,nodead,spec:2/3,form:1/2][spec:2/3,form:1/2]Skull Bash;[@mouseover,harm,nodead][]Solar Beam;")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@focus,spec:4,help,nodead][@party1,help,nodead,spec:4]Lifebloom;[@focus,spec:1,help,nodead][@party1,help,nodead,spec:1]Innervate;[noform:2]!Cat Form\n/run SetTracking(3,true);") 
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,spec:4,help,nodead][@party2,help,nodead,spec:4]Lifebloom;[@focus,spec:1,help,nodead][@party1,help,nodead,spec:1]Innervate;[noform:2]!Cat Form\n/run SetTracking(4,true);")
					EditMacro("WSxCGen+F",nil,nil,"#showtooltip [spec:2/3]Stampeding Roar;[spec:1/4]Innervate\n/use Mushroom Chair\n/run SetTracking(2,false);SetTracking(3,false);SetTracking(4,false);")
					EditMacro("WSxSGen+1",nil,nil,"#showtooltip [spec:4]Tranquility;Regrowth\n/use [mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Regrowth;Kalytha's Haunted Locket\n/tar Reaves\n/tar Captain Krooz")
					EditMacro("WSxSGen+2",nil,nil,"#showtooltip\n/cancelaura X-Ray Specs\n/use [@mouseover,help,nodead][]Regrowth\n/use Gnomish X-Ray Specs")
					EditMacro("WSxCSGen+2",nil,nil,"/use [spec:4,@focus,help,nodead][spec:4,@party1,help,nodead]Nature's Cure;[@focus,help,nodead][@party1,help,nodead]Remove Corruption;")
					EditMacro("WSxCSGen+3",nil,nil,"/use [@party2,help,nodead,spec:4]Nature's Cure;[@party2,help,nodead]Remove Corruption")
					EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [spec:1,noform:4]Moonkin Form;[spec:1,talent:7/2]Fury of Elune;[spec:1,talent:7/3]New Moon;[spec:2,talent:5/2]Savage Roar;[spec:4,@cursor]Efflorescence;[spec:3]Incapacitating Roar")
					EditMacro("WSxSGen+5",nil,nil,"/use [@party2,help,nodead,mod]Rejuvenation;[spec:1,talent:1/3,@cursor]Force of Nature;[spec:1,talent:1/2]Warrior of Elune;[@player,spec:1]Starfall;[spec:2,talent:7/3]Feral Frenzy;[@mouseover,help,nodead,spec:4,talent:1/3][spec:4,talent:1/3]Cenarion Ward")
					EditMacro("WSxSGen+6",nil,nil,"#showtooltip\n/use [@mouseover,help,nodead,talent:3/3][@mouseover,help,nodead,spec:4][talent:3/3][spec:4]Wild Growth;[@player,spec:1]Starfall;Kaldorei Wind Chimes\n/use [spec:2/3]Hunter's Call")
					EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [mod,spec:4,@player]Efflorescence;[spec:4,talent:7/3]Flourish;[spec:4,talent:3/2,noform:2]!Cat Form;[form:2,spec:4,talent:3/2]Swipe;[spec:2,talent:6/3]Primal Wrath;[nospec:2]Barkskin\n/use [nocombat]Spirit of Bashiok")
					EditMacro("WSxRTS",nil,nil,"/cancelform [talent:2/3,form,@mouseover,help,nodead]\n/use [mod:alt]MOLL-E;[spec:4,mod]Ursol's Vortex;[mod]Incapacitating Roar;[talent:2/3,noform,@mouseover,help,nodead]Wild Charge;[talent:4/3]Typhoon;[talent:4/2]Mass Entanglement;Mighty Bash")
					EditMacro("WSxGenF",nil,nil,"#showtooltip\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[spec:1,@focus,harm,nodead]Solar Beam;[spec:4,@focus,harm,nodead]Cyclone;[@focus,harm,nodead]Skull Bash;Charm Woodland Creature\n/use Survey")
					EditMacro("WSxCAGen+F",nil,nil,"#showtooltip [nospec:2]Barkskin;Primal Fury\n/use [nocombat,noexists]Tear of the Green Aspect\n/targetfriend [nohelp,nodead]\n/cancelform [help,nodead]\n/use [help,nodead]Wild Charge\n/targetlasttarget")
					EditMacro("WSxGG",nil,nil,"#show\n/use [noform,nocombat,noexists,mod:alt]Darkmoon Gazer;[mod:alt,spec:2/3]Stampeding Roar;[@mouseover,harm,nodead]Soothe;[spec:4,@mouseover,help,nodead][spec:4]Nature's Cure;[@mouseover,help,nodead][]Remove Corruption;\n/use Poison Extraction Totem")
					EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:alt]Nature's Beacon;[mod][spec:1]Barkskin;[@mouseover,help,nodead,spec:4][spec:4]Ironbark;[spec:2/3]Survival Instincts")
					EditMacro("WSxMove",nil,nil,"/use [spec:3,talent:2/2,@cursor]Ursol's Vortex;[talent:2/2]Renewal;[spec:1,noform:4][talent:2/3,talent:3/1,noform:4]Moonkin Form;[talent:2/1]Dash;[@mousever,exists,nodead][]Wild Charge\n/use Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan")
					EditMacro("WSxSRBGCC+1",nil,nil,"")
					if playerspec == 1 then
						EditMacro("WSkillbomb",nil,nil,"#showtooltip\n/use Celestial Alignment"..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use 13\n/use Adopted Puppy Crate\n/use [@cursor]Force of Nature\n/use Big Red Raygun\n/use Echoes of Rezan")
						EditMacro("WSxGen3",nil,nil,"#showtooltip\n/use [talent:3/1,form:2]Rake;Starsurge\n/targetenemy [noexists]\n/use Desert Flute")
						EditMacro("WSxSGen+3",nil,nil,"/use [talent:3/1,noform:2]!Cat Form;[talent:3/1,form:2]Rip;[talent:3/2,noform:1]!Bear Form;[talent:3/2,form:1]Thrash;Moonfire;\n/use [talent:3/1,nocombat]!Prowl;")
						EditMacro("WSxGen4",nil,nil,"/use [form:2]Shred;[form:1]Mangle;[form:4,@mouseover,harm,nodead][]Lunar Strike;\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,nostealth]!Prowl")
						EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/use [@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Rejuvenation;[noform:4]Moonkin Form;[@mouseover,harm,nodead,talent:6/3][talent:6/3]Stellar Flare;[talent:7/3]New Moon;[talent:7/2]Fury of Elune;Charm Woodland Creature")
						EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [mod:ctrl]Treant Form;[nocombat,help,nodead]Corbyn's Beacon;[talent:3/1,form:2]Ferocious Bite;[talent:3/2,form:1]Ironfur;Solar Wrath\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxGen6",nil,nil,"/use [mod]Celestial Alignment;[form:2]Swipe;[form:1,talent:3/2]Thrash;[@cursor]Starfall")
						EditMacro("WSxGND",nil,nil,"/use [mod:alt]Stag Form;[noform:2,mod:shift]!Cat Form;[mod:shift]Dash;[mod,harm,nodead]Hibernate;[mod]Dreamwalk;[form:1,talent:3/2]Ironfur;[@mouseover,help,talent:3/3][talent:3/3]Swiftmend\n/stopmacro [stealth]\n/use Path of Elothir\n/use Prismatic Bauble")
						EditMacro("WSxCC",nil,nil,"/use [mod:shift]Innervate;[@mouseover,harm,nodead,mod][mod]Entangling Roots;[talent:3/2,noform:1]Bear Form;[form:1,talent:3/2]Frenzied Regeneration;[@mouseover,help,nodead,talent:3/3][noform:1,talent:3/3]Rejuvenation;Entangling Roots\n/use Totem of Spirits")
						EditMacro("WSxCGen+V",nil,nil,"#showtooltip\n/use [mod:alt,nocombat]"..passengerMount..";[noform:4]Moonkin Form;!Flap\n/cancelform [form:1/2]\n/cancelaura Prowl\n/use [nomod,nostealth,form]Seafarer's Slidewhistle")
						EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Innervate;[@\"..B..\"]Regrowth\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Innervate;[@\"..N..\"]Regrowth\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
						EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,dead][help,dead]Rebirth;[@mouseover,help,nodead][help,nodead]Innervate;[@mouseover,harm,nodead][harm,nodead]Moonfire(Lunar);Druid and Priest Statue Set\n/use [nocombat,noform:1/4]!Prowl\n/targetenemy [noexists]")
						EditMacro("WSxGen2",nil,nil,"/use [@mouseover,harm,nodead][harm,nodead]Sunfire(Solar);Moonfeather Statue\n/targetenemy [noexists]\n/cleartarget [dead]") 
					elseif playerspec == 2 then
						EditMacro("WSkillbomb",nil,nil,"#showtooltip\n/use Berserk"..dpsRacials[race].."\n/use Will of Northrend\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
						EditMacro("WSxGen3",nil,nil,"#showtooltip\n/use [form:2]Thrash;[talent:3/1,noform][talent:3/1,form:4]Starsurge;[talent:3/2,form:1]Frenzied Regeneration;[@mouseover,help,nodead][]Regrowth\n/targetenemy [noexists]\n/use Desert Flute")
						EditMacro("WSxSGen+3",nil,nil,"/use [noform:2]!Cat Form;[form:2]Rip;\n/use [nocombat]!Prowl;")
						EditMacro("WSxGen4",nil,nil,"/use [talent:3/2,noform:1/2]Bear Form;[nocombat,nostealth]!Prowl;[form:1]Thrash;[form:2]Rake;[talent:3/1,noform:4]Moonkin Form;[talent:3/1,form:4]Lunar Strike\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/use [noform:2]Cat Form;Tiger's Fury\n/use [nocombat,nostealth]Bloodmane Charm\n/use !Prowl")
						EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [mod:ctrl]Treant Form;[nocombat,help,nodead]Corbyn's Beacon;[talent:3/1,form:4]Solar Wrath;[talent:3/2,form:1]Ironfur;[noform]!Cat Form;[form:1]Thrash;[form:2]Ferocious Bite\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxGen6",nil,nil,"/use [mod]Berserk;[noform:1/2]Cat form;[talent:6/2,form:1]Thrash;[form:1/2]Swipe;")
						EditMacro("WSxGND",nil,nil,"/use [mod:alt]Stag Form;[noform:2,mod:shift]!Cat Form;[mod:shift]Dash;[mod,harm,nodead]Hibernate;[mod]Dreamwalk;[form:1,talent:3/2]Ironfur;[@mouseover,help,talent:3/3][talent:3/3]Swiftmend\n/stopmacro [stealth]\n/use Path of Elothir\n/use Prismatic Bauble")
						 EditMacro("WSxCC",nil,nil,"/use [@mouseover,harm,nodead,mod][mod]Entangling Roots;[talent:3/2,noform:1]Bear Form;[form:1,talent:3/2]Frenzied Regeneration;[@mouseover,help,nodead,talent:3/3][noform:1,talent:3/3]Rejuvenation;Entangling Roots\n/use Totem of Spirits")
						EditMacro("WSxCGen+V",nil,nil,"#showtooltip\n/use [mod:alt,nocombat]"..passengerMount..";[talent:3/1,noform:4]Moonkin Form;[talent:3/1]!Flap;[noform]Stag Form;[talent:2/3,form]Wild Charge\n/cancelform [form:1/2]\n/use [nomod,nostealth,form]Seafarer's Slidewhistle")
						EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Regrowth;[@\"..B..\"]Regrowth\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Regrowth;[@\"..N..\"]Regrowth\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
						EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,dead][help,dead]Rebirth;[form:2,notalent:1/3]Rake;[@mouseover,harm,nodead][harm,nodead]Moonfire(Lunar);Druid and Priest Statue Set\n/use [nocombat,noform:1/4]!Prowl\n/targetenemy [noexists]")
						EditMacro("WSxGen2",nil,nil,"/use [nocombat,noexists]Moonfeather Statue;[form:2]Shred;[form:1]Mangle;[talent:3/1,noform:4]Moonkin Form;[@mouseover,harm,nodead,talent:3/1,form:4][talent:3/1,form:4,harm,nodead]Sunfire(Solar);[noform:2]!Cat Form\n/targetenemy [noexists]") 
					elseif playerspec == 3 then
						EditMacro("WSkillbomb",nil,nil,"#showtooltip\n/use [talent:5/3]Incarnation: Guardian of Ursoc"..dpsRacials[race].."\n/use Will of Northrend\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
						EditMacro("WSxGen3",nil,nil,"/use [talent:7/3,form:1]Pulverize;[talent:7/2,form:1]Lunar Beam;[form:2,talent:3/2]Rake;[talent:3/1,noform]Moonkin Form;[talent:3/1,form:4]Starsurge;[form:1]Frenzied Regeneration;[@mouseover,help,nodead][]Regrowth\n/targetenemy [noexists]\n/use Desert Flute")
						EditMacro("WSxSGen+3",nil,nil,"/use [talent:3/2,noform:2]!Cat Form;[talent:3/2,form:2]Rip;[noform:1]Bear Form(Shapeshift);Thrash\n/use [nocombat,talent:3/2]!Prowl;")
						EditMacro("WSxGen4",nil,nil,"/use [noform]Bear Form(Shapeshift);[nocombat,nostealth]!Prowl;[form:1/2]Thrash;[talent:3/1,noform:4]Moonkin Form;[talent:3/1,form:4]Lunar Strike\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/use [noform:1]Bear Form(Shapeshift);[talent:1/3]Bristling Fur;Ironfur\n/use [nocombat,nostealth]Bloodmane Charm")
						EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [mod:ctrl]Treant Form;[nocombat,help,nodead]Corbyn's Beacon;[noform]Bear Form(Shapeshift);[form:1]Maul;[talent:3/2,form:2]Ferocious Bite;[talent:3/1,form]Solar Wrath;\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxGen6",nil,nil,"/use [mod,talent:5/2]Incarnation: Guardian of Ursoc;[mod]Hunter's Call;[noform:1/2]Bear form(Shapeshift);[form:1/2]Swipe;")
						EditMacro("WSxGND",nil,nil,"/use [mod:alt]Stag Form;[noform:2,mod:shift]!Cat Form;[mod:shift]Dash;[mod,harm,nodead]Hibernate;[mod]Dreamwalk;[form:1]Ironfur;[@mouseover,help,talent:3/3][talent:3/3]Swiftmend\n/stopmacro [stealth]\n/use Path of Elothir\n/use Prismatic Bauble")
						EditMacro("WSxCC",nil,nil,"/use [@mouseover,harm,nodead,mod][mod]Entangling Roots;[form:1]Frenzied Regeneration;[@mouseover,help,nodead,talent:3/3][noform:1,talent:3/3]Rejuvenation;[noform]Bear Form(Shapeshift);\n/use Totem of Spirits")
						EditMacro("WSxCGen+V",nil,nil,"#showtooltip\n/use [mod:alt,nocombat]"..passengerMount..";[talent:3/1,noform:4]Moonkin Form;[talent:3/1]!Flap;[noform]Stag Form;[talent:2/3,form]Wild Charge\n/cancelform [form:1/2]\n/use [nomod,nostealth,form]Seafarer's Slidewhistle")
						EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Regrowth;[@\"..B..\"]Regrowth\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Regrowth;[@\"..N..\"]Regrowth\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
						EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,dead][help,dead]Rebirth;[@mouseover,harm,nodead][harm,nodead]Moonfire(Lunar);Druid and Priest Statue Set\n/use [nocombat,noform:1/4]!Prowl\n/targetenemy [noexists]")
						EditMacro("WSxGen2",nil,nil,"/use [nocombat,noexists]Moonfeather Statue;[talent:3/1,noform:4]Moonkin Form;[talent:3/2,noform:2]!Cat Form;[form:1]Mangle;[form:2]Shred;[@mouseover,harm,nodead,talent:3/1,form:4][talent:3/1,form:4]Sunfire(Solar)\n/targetenemy [noexists]\n/cleartarget [dead]")
					else
						EditMacro("WSkillbomb",nil,nil,"#showtooltip\n/use [talent:5/3]!Incarnation: Tree of Life"..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
						EditMacro("WSxGen3",nil,nil,"#showtooltip\n/use [talent:3/1,noform:4]Moonkin Form;[talent:3/1,form:4]Starsurge;[form:2,talent:3/2]Rip;[@mouseover,help,nodead][]Regrowth\n/targetenemy [noexists]\n/use Desert Flute")
						EditMacro("WSxSGen+3",nil,nil,"/use [@mouseover,help,nodead][@focus,help,nodead][]Lifebloom")
						EditMacro("WSxGen4",nil,nil,"/use [form:2]Shred;[form:1]Mangle;[@mouseover,talent:3/1,form:4,harm,nodead][talent:3/1,form:4]Lunar Strike;[@mouseover,help,nodead][]Regrowth\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,nostealth]!Prowl")
						EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/use [@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Rejuvenation;[noform:2]!Cat Form;[talent:3/2,form:2]Rake;[form:2]Shred\n/use [nocombat]!Prowl")
						EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [mod,talent:5/3]!Incarnation: Tree of Life;[mod]Treant Form;[nocombat,help,nodead]Corbyn's Beacon;[talent:3/2,form:2]Ferocious Bite;[talent:3/3,form:1]Ironfur;Solar Wrath\n/targetenemy [noexists]\n/cleartarget [dead]")
						EditMacro("WSxGen6",nil,nil,"/use [mod]Tranquility;[talent:3/3,noform:1]Bear Form(Shapeshift);[talent:3/2,noform:2]!Cat Form;[form:1,talent:3/3]Thrash;[form:2,talent:3/2]Swipe;[@mouseover,help,nodead][]Sunfire")
						EditMacro("WSxGND",nil,nil,"/use [mod:alt]Stag Form;[noform:2,mod:shift]!Cat Form;[mod:shift]Dash;[mod,harm,nodead]Hibernate;[mod]Dreamwalk;[form:1,talent:3/3]Ironfur;[@mouseover,help,nodead][]Swiftmend\n/stopmacro [stealth]\n/use Path of Elothir\n/use Prismatic Bauble")	        
						EditMacro("WSxCC",nil,nil,"/use [mod:shift,noform:1/2]Innervate;[@mouseover,harm,nodead,mod][mod]Entangling Roots;[form:1,talent:3/3]Frenzied Regeneration;[@mouseover,help,nodead][]Rejuvenation\n/use Totem of Spirits\n/cancelform [mod:shift,form:1,talent:3/3]")
						EditMacro("WSxCGen+V",nil,nil,"#showtooltip\n/use [mod:alt,nocombat]"..passengerMount..";[talent:3/1,noform:4]Moonkin Form;[talent:3/1]!Flap;[noform]Stag Form;[talent:2/3,form]Wild Charge\n/cancelform [form:1/2]\n/use [nomod,nostealth,form]Seafarer's Slidewhistle")
						EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use [@focus,mod,help,nodead][@party1,help,nodead,mod:shift]Swiftmend;[@focus,help,nodead][@party1,help,nodead]Rejuvenation")
						EditMacro("WSxGen+N",nil,nil,"#showtooltip\n/use [@focus,mod,help,nodead][@party2,help,nodead,mod:shift]Swiftmend;[@focus,help,nodead][@party2,help,nodead]Rejuvenation")
						EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Regrowth;[@\"..B..\"]Lifebloom\\n/stopspelltarget\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Regrowth;[@\"..N..\"]Lifebloom\\n/stopspelltarget\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
						EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,dead][help,dead]Rebirth;[@mouseover,help,nodead][help,nodead]Innervate;[@mouseover,harm,nodead][harm,nodead]Moonfire(Lunar);Druid and Priest Statue Set\n/use [nocombat,noform:1/4]!Prowl\n/targetenemy [noexists]")
						EditMacro("WSxGen2",nil,nil,"/use [@mouseover,harm,nodead][harm,nodead][harm,nodead]Sunfire(Solar);Moonfeather Statue\n/targetenemy [noexists]\n/cleartarget [dead]") 
					end
				-- Demon Hunter, DH
				elseif class == "DEMONHUNTER" then
					EditMacro("WSxT15",nil,nil,"#showtooltip [spec:2]Demon Spikes;[spec:1,notalent:1/3]Fel Rush;[spec:1,talent:1/3]Felblade\n/use "..invisPot)
					EditMacro("WSxT30",nil,nil,"#showtooltip [spec:2][spec:1,talent:2/3]Immolation Aura;Demon's Bite"..oOtas.."\n/use [mod:alt,spec:2,@player]Sigil of Misery")
					EditMacro("WSxT45",nil,nil,"#showtooltip [spec:2,talent:3/3]Felblade;[spec:2]Demon Spikes;[spec:1,talent:3/3]Fel Barrage;Fel Rush\n/use [mod:alt,spec:2,@player]Sigil of Silence;"..racials[race])
					EditMacro("WSxT90",nil,nil,"#showtooltip [spec:2,talent:6/3]Fel Devastation;[spec:2,talent:6/2]Spirit Bomb;[spec:1,talent:6/3]Fel Eruption;Throw Glaive\n/use [nocombat,noexists]Legion Invasion Simulator;Torment")
					EditMacro("WSxT100",nil,nil,"#showtooltip [spec:1,talent:7/3]Nemesis;[spec:2,talent:7/3]Soul Barrier;Eye Beam")
					EditMacro("WSxCSGen+G",nil,nil,"#showtooltip\n/use [@focus,harm,nodead]Consume Magic\n/use Wisp Amulet")
					EditMacro("WSxT60",nil,nil,"#showtooltip [spec:1,talent:4/3]Netherwalk;[spec:2,talent:4/3]Fracture;Spire of Spite;\n/use [nocombat,noexists]Spire of Spite\n/run PetDismiss();\n/cry")
					EditMacro("WSkillbomb",nil,nil,"/use [@player] Metamorphosis\n/use 13"..dpsRacials[race].."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")         
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/cancelaura Glide\n/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned.."\n/use [mod:ctrl]Brazier of Awakening")
					EditMacro("WSxSGen+H",nil,nil,"#showtooltip Spectral Sight\n/use Wisp Amulet\n/stopmacro [combat]\n/run if not (IsControlKeyDown()) then if IsMounted() then DoEmote\"mountspecial\"; else DoEmote\"kneel\" end end")
					EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use [spec:1,talent:4/3]Netherwalk;Glide;")
					EditMacro("WSxCAGen+B",nil,nil,"")
					EditMacro("WSxGen+N",nil,nil,"#showtooltip Glide")
					EditMacro("WSxCAGen+N",nil,nil,"")
					EditMacro("WSxSRBGCC+1",nil,nil,"")
					EditMacro("WSxGen1",nil,nil,"#showtooltip\n/use [spec:2]Demon Spikes;[spec:1]Fel Rush;\n/targetenemy [noexists]\n/startattack")
					EditMacro("WSxSGen+1",nil,nil,"#showtooltip Skull of Corruption\n/use [nocombat]Skull of Corruption\n/tar Reaves\n/tar Captain Krooz")
					EditMacro("WSxGen2",nil,nil,"#showtooltip\n/use [nocombat,noexists]Verdant Throwing Sphere\n/targetlasttarget [noexists,nocombat]\n/use [harm,dead,nocombat,nomod]Soul Inhaler;[spec:1]Demon's Bite;[spec:2]Shear;\n/cleartarget [spec:1,talent:2/2]\n/targetenemy [noexists]\n/startattack")
					EditMacro("WSxSGen+2",nil,nil,"#showtooltip\n/use [spec:2,talent:6/3]Fel Devastation;[spec:2,talent:6/2]Spirit Bomb;[spec:1,talent:6/3]Fel Eruption;\n/startattack\n/targetenemy [noexists]\n/cleartarget [dead]\n/use Gnomish X-Ray Specs")
					EditMacro("WSxCSGen+2",nil,nil,"")
					EditMacro("WSxGen3",nil,nil,"#showtooltip\n/use [spec:1,talent:1/3][spec:2,talent:3/3]Felblade;[spec:2]Demon Spikes;Throw Glaive;\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]\n/use Imp in a Ball")
					EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/use [@mouseover,harm,nodead,nomod][nomod]Throw Glaive\n/use [nocombat]Legion Pocket Portal\n/targetenemy [noexists]\n/startattack\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Throw Glaive\n/targetlasttarget")
					EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noexists]The Perfect Blossom;[@focus,harm,nodead]Throw Glaive;Fel Petal;")
					EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use Eye Beam\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]\n/cancelaura Netherwalk")
					EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/use [spec:1,talent:5/3]Dark Slash;[spec:1,talent:3/3]Fel Barrage;[spec:1,talent:6/3]Fel Eruption;[spec:2]Shear;Glide;\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
					EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [spec:2,talent:7/3]Soul Barrier;[spec:1,talent:7/3]Nemesis;[spec:1]Darkness;[spec:2]Fiery Brand;\n/targetenemy [noexists]\n/startattack")
					EditMacro("WSxCSGen+4",nil,nil,"")
					EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [spec:2,mod:ctrl]Metamorphosis;[mod:ctrl]Darkness;[spec:1]Chaos Strike;[spec:2]Soul Cleave\n/use [mod:ctrl]Shadescale\n/startattack\n/targetenemy [noexists]")
					EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/use [spec:2,@player]Infernal Strike;Chaos Nova\n/targetenemy [noexists]\n/startattack")
					EditMacro("WSxCSGen+5",nil,nil,"/clearfocus")
					EditMacro("WSxGen6",nil,nil,"#showtooltip\n/use [mod:ctrl,@cursor] Metamorphosis;Blade Dance;\n/targetenemy [noexists]")
					EditMacro("WSxSGen+6",nil,nil,"#showtooltip [spec:1,talent:3/3]!Fel Barrage;Chaos Nova\n/use [spec:1,talent:3/3]!Fel Barrage;[spec:2,@player]Sigil of Flame;[spec:1]Blade Dance\n/stopspelltarget")
					EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [spec:1,talent:2/3]Immolation Aura\n/use !Throw Glaive\n/targetenemy [noexists]")
					EditMacro("WSxQQ",nil,nil,"/use [mod:alt,@focus,harm,nodead]Imprison;[@mouseover,harm,nodead][]Disrupt")
					EditMacro("WSxStuns",nil,nil,"#showtooltip\n/use [mod:alt] !Spectral Sight; [spec:2,@cursor]Sigil of Silence; [spec:1]Chaos Nova;")
					EditMacro("WSxRTS",nil,nil,"#showtooltip [spec:2]Sigil of Misery;Throw Glaive;\n/use [mod:ctrl,spec:2,talent:5/3,@player][mod:shift,spec:2,talent:5/3,@cursor]Sigil of Chains;[mod:alt,@focus,harm,nodead][nomod,@mouseover,harm,nodead][nomod]Throw Glaive;[mod:alt]MOLL-E;\n/startattack")
					EditMacro("WSxClassT",nil,nil,"#showtooltip [spec:2,talent:5/3]Sigil of Chains;Torment\n/use [help,nocombat]Swapblaster;[spec:2,talent:5/3]Sigil of Chains;Throw Glaive\n/use [nocombat]A Tiny Set of Warglaives\n/startattack")
					EditMacro("WSxGenF",nil,nil,"#showtooltip Spectral Sight\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,exists,nodead]All-Seer's Eye;[mod:alt]Legion Communication Orb;[@focus,harm,nodead]Disrupt;[nocombat,noexists]Micro-Artillery Controller")
					EditMacro("WSxSGen+F",nil,nil,"#showtooltip Spectral Sight\n/cancelaura [mod:alt]Spectral Sight\n/use [nocombat,noexists]Gastropod Shell")
					EditMacro("WSxCGen+F",nil,nil,"#showtooltip [spec:1,talent:4/3]Netherwalk;Blur\n/cancelaura Wyrmtongue Disguise")
					EditMacro("WSxCAGen+F",nil,nil,"#showtooltip [spec:2,talent:5/3]Sigil of Chains;Fel Rush\n/use [spec:2,talent:5/3,@player]Sigil of Chains")
					EditMacro("WSxGG",nil,nil,"#showtooltip\n/use [mod:alt]S.F.E. Interceptor;[@mouseover,harm,nodead][]Consume Magic")
					EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [spec:2]Fiery Brand;[spec:1]Blur")
					EditMacro("WSxGND",nil,nil,"#showtooltip\n/use [mod:shift,spec:2,talent:1/2]Immolation Aura;[mod:shift,spec:1,talent:4/3]!Netherwalk;[spec:1]Darkness;[spec:2,talent:7/3]Soul Barrier;[spec:2]Demon Spikes")
					EditMacro("WSxCC",nil,nil,"#showtooltip\n/use [spec:2,mod:ctrl,@cursor]Sigil of Misery;[@mouseover,harm,nodead][]Imprison\n/cancelaura X-Ray Specs")
					EditMacro("WSxMove",nil,nil,"#showtooltip\n/use [spec:2,@cursor]Infernal Strike;Vengeful Retreat;\n/use [nomod]Panflute of Pandaria\n/use Haw'li's Hot & Spicy Chili\n/cancelaura Rhan'ka's Escape Plan")
					EditMacro("WSxCGen+V",nil,nil,"/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem;!Glide\n/dismount [mounted]")
				end -- avslutar class
			end	-- avslutar racials[race]
			
			-- Mount Parser based on events
			local palaMounts = {
				["Draenei"] = "Summon Exarch's Elekk,",
				["LightforgedDraenei"] = "Summon Exarch's Elekk,",
				["DarkIronDwarf"] = "Summon Darkforge Ram,",
				["Dwarf"] = "Summon Dawnforge Ram,",
				["Tauren"] = "Summon Sunwalker Kodo,",
				["BloodElf"] = "Summon Thalassian Warhorse,",
				["Human"] = "Summon Warhorse,",
				["ZandalariTroll"] = "Crusader's Direhorn,",
			}
			if level > 39 then
				palaMounts = {
				["Draenei"] = "Summon Great Exarch's Elekk,",
				["LightforgedDraenei"] = "Summon Great Exarch's Elekk,",
				["DarkIronDwarf"] = "Summon Darkforge Ram,",
				["Dwarf"] = "Summon Dawnforge Ram,",
				["Tauren"] = "Summon Great Sunwalker Kodo,",
				["BloodElf"] = "Summon Thalassian Charger,",
				["Human"] = "Summon Charger,",
				["ZandalariTroll"] = "Crusader's Direhorn,",
			}
			end
				
			local groundMount = {
				["SHAMAN"] = "Swift Zulian Tiger,Wild Dreamrunner",
				["MAGE"] = "Wild Dreamrunner",
				["WARLOCK"] = "Wild Dreamrunner,Lucid Nightmare,Illidari Felstalker,Hellfire Infernal",
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
				["MAGE"] = ",Leywoven Flying Carpet,Ashes of Al'ar,Arcanist's Manasaber,Violet Spellwing,Leyfeather Hippogryph,Glacial Tidestorm",
				["WARLOCK"] = ",Grove Defiler,Headless Horseman's Mount,Felsteel Annihilator,Antoran Gloomhound",
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
				["MAGE"] = ",Leywoven Flying Carpet,Ashes of Al'ar,Arcanist's Manasaber,Violet Spellwing,Leyfeather Hippogryph,Glacial Tidestorm",
				["WARLOCK"] = ",Honeyback Harvester,Headless Horseman's Mount,Grove Defiler,Felsteel Annihilator",
				["MONK"] = " Astral Cloud Serpent",
				["PALADIN"] = ",Highlord's Golden Charger,Lightforged Warframe,Invincible",
				["HUNTER"] = ",Mimiron's Head,Clutch of Ji-Kun,Armored Skyscreamer,Dread Raven,Darkmoon Dirigible,Spirit of Eche'ro",
				["ROGUE"] = ",Ironbound Wraithcharger,Shadowblade's Murderous Omen,Geosynchronous World Spinner",
				["PRIEST"] = ",Dread Raven,Lightforged Warframe,Honeyback Harvester",
				["DEATHKNIGHT"] = ",Invincible,Sky Golem,",
				["WARRIOR"] = ",Invincible,Smoldering Ember Wyrm,Valarjar Stormwing,Obsidian Worldbreaker",
				["DRUID"] = ",Sky Golem,Ashenvale Chimaera,Leyfeather Hippogryph",
				["DEMONHUNTER"] = ",Arcanist's Manasaber,Felfire Hawk,Corrupted Dreadwing,Azure Drake,Cloudwing Hippogryph,Leyfeather Hippogryph,Felsteel Annihilator",
			}	
			end

			-- classMount[class]	 
			local classMount = {
				["SHAMAN"] = "Farseer's Raging Tempest",
				["MAGE"] = "Archmage's Prismatic Disc",
				["WARLOCK"] = "Netherlord's Accursed Wrathsteed",
				["MONK"] = "[mounted]Hogrus, Swine of Good Fortune",
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
				["BloodElf"] = "Red Dragonhawk,",
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
				["Nightborne"] = "",
				["NightElf"] = "",
				["Orc"] = "Frostwolf Snarler,",
				["Pandaren"] = "",
				["Scourge"] = "Undercity Plaguebat,",
				["Tauren"] = "",
				["Troll"] = "Fossilized Raptor,Amani Battle Bear,Bloodfang Widow,Swift Zulian Tiger,",
				["VoidElf"] = "Starcursed Voidstrider,",
				["Vulpera"] = "Alabaster Hyena,Springfur Alpaca,Elusive Quickhoof,Caravan Hyena,",
				["Worgen"] = "Running Wild,",
				["ZandalariTroll"] = "",
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
					classMount[class] = "Netherlord's Chaotic Wrathsteed,Netherlord's Accursed Wrathsteed"
				elseif playerspec == 3 then
					classMount[class] = "Netherlord's Brimstone Wrathsteed,Netherlord's Chaotic Wrathsteed"
				end
			elseif class == "MONK" then
				if playerspec == 2 then
					flyingMount[class] = "Yu'lei, Daughter of Jade" 
					classMount[class] = "[mounted]Shu-Zen, the Divine Sentinel"
				elseif playerspec == 3 then
					classMount[class] = "[mounted]Ban-Lu, Grandmaster's Companion"
				end
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
					groundMount[class] = factionHog..",Arcadian War Turtle,Bloodfang Widow,Ironhoof Destroyer"
				elseif playerspec == 3 then
					groundMount[class] = factionHog..",Prestigious Bronze Courser,Bloodfang Widow,Ironhoof Destroyer"
				end
			elseif class == "DRUID" then
				if playerspec == 2 then 
					classMount[class] = "Swift Zulian Tiger"
				elseif playerspec == 3 then
					classMount[class] = "Darkmoon Dancing Bear"
				elseif playerspec == 4 then
					classMount[class] = "Emerald Drake"
				end
			end

			-- Vazj'ir
			if z == "Vashj'ir" or z == "Kelp'thar Forest" or z == "Shimmering Expanse" or z == "Abyssal Depths" then
				if class == "DRUID" then
					flyingMount[class] = "!Travel Form"
				else
					flyingMount[class] = "Vazj'ir Seahorse"
				end
			elseif GetItemCount("Magic Broom") >= 1 then
				classMount[class] = "Magic Broom"
				flyingMount[class] = "Magic Broom"
			-- Nazjatar
			elseif z == "Nazjatar" or z == "Damprock Cavern" then
				local randomSeapony = GetRandomArgument("Inkscale Deepseeker","Fabious","Subdued Seahorse","Crimson Tidestallion")
				flyingMount[class] = ","..randomSeapony
			elseif level < 20 then
				groundMount[class] = "Summon Chauffeur"
			elseif level <= 60 then
				groundMount[class] = "Snapback Scuttler"
			end
			-- Mount Type Zone Parser
			-- Check if the character has riding skill
			if instanceName == "The Deaths of Chromie" then
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
				--print("Cannot fly in certain areas")
			elseif IsSpellKnown(34090) or IsSpellKnown(34091) or IsSpellKnown(90265) then 
			-- Expert, Artisan or Master Riding
				groundMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
				--print("Artisan or Master Riding")
			elseif IsSpellKnown(33388) or IsSpellKnown(33391) then 
			-- Apprentice or Journeyman Riding
			-- We can use ground mounts
				classMount[class] = ""
				flyingMount[class] = ""
				--print("Journeyman or Apprentice")
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
				--print("We dont any Riding skill")
			end

			--[[Mount synthesis: 
			flying mounts: classMount[class], flyingMount[class], 
			ground mounts: "..pvpKodo..""..pvpRaptor..""..prestWolf..""..factionBike..",racistMount[race],groundMount[class] --]]
			if flyingMount[class] and groundMount[class] and classMount[class] then
				if (class == "MAGE" or class == "PRIEST" or class == "DEMONHUNTER" or class == "DEATHKNIGHT") then
					EditMacro("WSxSGen+V",nil,nil,"/userandom "..classMount[class]..""..flyingMount[class]..""..racistMount[race]..""..groundMount[class]) 
				elseif class == "SHAMAN" then
					EditMacro("WSxSGen+V",nil,nil,"/use [noform]Ghost Wolf\n/use [@player,nochanneling,nomounted]Water Walking\n/userandom "..classMount[class]..""..flyingMount[class]..""..pvpKodo..""..pvpRaptor..""..prestWolf..""..factionBike..""..racistMount[race]..""..groundMount[class].."\n/use Death's Door Charm")
				elseif class == "WARLOCK" then
					EditMacro("WSxSGen+V",nil,nil,"/userandom "..classMount[class]..""..flyingMount[class]..""..pvpSkelly..""..factionBike..""..racistMount[race]..""..groundMount[class])
				elseif class == "MONK" then
					if classMount[class] ~= "" then
						classMount[class] = "/use "..classMount[class]
					end 
					if flyingMount[class] ~= "" then
						flyingMount[class] = "\n/use "..flyingMount[class]
					else 
						flyingMount[class] = "/userandom "..flyingMount[class]
					end
					EditMacro("WSxSGen+V",nil,nil,classMount[class]..""..flyingMount[class]..""..racistMount[race]..""..groundMount[class])
				elseif class == "PALADIN" then
					EditMacro("WSxSGen+V",nil,nil,"/use !Crusader Aura\n/userandom "..classMount[class]..""..flyingMount[class]..""..palaMounts[race]..""..racistMount[race]..""..groundMount[class])
				elseif class == "HUNTER" then
					EditMacro("WSxSGen+V",nil,nil,"/userandom "..classMount[class]..""..flyingMount[class]..""..pvpKodo..""..pvpRaptor..""..racistMount[race]..""..groundMount[class])
				elseif class == "ROGUE" then
					EditMacro("WSxSGen+V",nil,nil,"/userandom "..classMount[class]..""..flyingMount[class]..""..racistMount[race]..""..groundMount[class].."\n/cancelaura [nocombat]Stealth\n/targetfriend [nospec:2,nohelp,combat]")
				elseif class == "WARRIOR" then
					EditMacro("WSxSGen+V",nil,nil,"/userandom "..classMount[class]..""..flyingMount[class]..""..factionBike..""..prestWolf..""..racistMount[race]..""..groundMount[class].."\n/use Death's Door Charm")
				elseif class == "DRUID" then
					EditMacro("WSxSGen+V",nil,nil,"/cancelform [form:1/2/3]\n/userandom "..classMount[class]..""..flyingMount[class]..""..pvpRaptor..""..racistMount[race]..""..groundMount[class])
				end
			end -- 
		end -- events

		-- Bag_update baserade events, laddas en gång vid variables loaded
		if (event == "BAG_UPDATE_DELAYED" or event == "PET_SPECIALIZATION_CHANGED" or event == "PLAYER_LOGIN") and not throttlef then 
			throttlef = true
	        C_Timer.After(1, function()
	            -- denna kod körs efter 2 sekunder
	            throttlef = false
	        end)

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
			    "Seafoam Coconut Water",
			    "Rockskip Mineral Water",
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

			if hasWaterInBags == "" then
				--[[DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Updating bags :) but couldn't find anything to drink :(",0.5,1.0,0.0)--]]
			elseif hasWaterInBags and GetItemCount(hasWaterInBags) > 0 then
				getWaters = GetItemCount(hasWaterInBags)
				DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Updating bags :) and found "..getWaters.." "..hasWaterInBags.." to drink! :)",0.5,1.0,0.0)
				hasWaterInBags = hasWaterInBags..";"
			end
			if class == "MAGE" then
				if playerspec == 3 then
					HS[class] = "Greatfather Winter's Hearthstone"
				elseif playerspec == 1 then
					HS[class] = "Tome of Town Portal"
				end
			elseif (class == "DEATHKNIGHT" and playerspec == 2) then
				HS[class] = "Greatfather Winter's Hearthstone"
			elseif (class == "DRUID" and playerspec == 1) then
				HS[class] = "Lunar Elder's Hearthstone"
			end
			if z == "Alterac Valley" and level > 57 then
				if faction == "Horde" then
					HS[class] = "Frostwolf Insignia"
				else 
					HS[class] = "Stormpike Insignia"
				end
			end

			if HS[class] and hsToy[class] and hasWaterInBags then
				if GetItemCount("Healthstone", false, true) >= 1 then
					EditMacro("WShow",nil,nil,"/use [mod:alt]"..hasWaterInBags.."[mod:ctrl]"..HS[class]..";[mod]Deep Sea Bandage;Healthstone\n/stopmacro [mod]\n/use Winning Hand"..hsToy[class].."\n/run PlaySound(15160)\n/glare", 1, 1)
				else
					EditMacro("WShow",nil,nil,"/use [mod:alt]"..hasWaterInBags.."[mod:ctrl]"..HS[class]..";[mod]Deep Sea Bandage\n/stopmacro [mod]"..hsToy[class].."\n/use Healthstone\n/run PlaySound(15160)\n/cry", 1, 1)
				end
			end

			if class == "MAGE" and hasWaterInBags then
				if hasWaterInBags == "" then
					hasWaterInBags = "Conjure Refreshment"
				end
				EditMacro("WSxSGen+2",nil,nil,"/use [spec:3,pet:Water Elemental,harm,nodead]Water Jet;"..hasWaterInBags.."\n/use Gnomish X-Ray Specs\n/stopcasting [spec:2]\n/use [nocombat]Conjure Refreshment\n/targetenemy [noharm]")                    
			end

			local hasDrums = {
				"Drums of Rage",
				"Drums of Fury",
				"Drums of the Mountain",
				"Drums of the Maelstrom",
			}
			local hasDrumsInBags = "Hot Buttered Popcorn"
			for i, hasDrums in pairs(hasDrums) do
			    if GetItemCount(hasDrums) >= 1 then
			        hasDrumsInBags = hasDrums
			    end
			end

			-- Class Artifact Button, "§" Completed
			local hoaEq = "[@mouseover,exists,nodead][@cursor]Heart Essence"
			if IsEquippedItem("Heart of Azeroth") == false then
				hoaEq = "13"
			end
			EditMacro("WArtifactCDs",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/stopspelltarget\n/use [@mouseover,help,dead][help,dead]Unstable Temporal Time Shifter;"..hoaEq)
			-- Garrisons Knappen, Mobile Gbank, Nimble Brew if has.
			local nBrew = "Nimble Brew"
			if GetItemCount("Nimble Brew") < 1 then 
				nBrew = "Magic Pet Mirror"
			end
			EditMacro("Wx2Garrisons",nil,nil,"#showtooltip\n/use [nocombat,noexists,nomod]Mobile Banking(Guild Perk);[mod:shift]Narcissa's Mirror;"..nBrew)

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
					bladlast = "[nopet]Call Pet 5;[pet]Command Pet;" 
				-- lone wolf hunter med bl drums
				elseif name == "Lone Wolf" then
					bladlast = "[nopet]"..hasDrumsInBags..";[pet]Command Pet;" 
				end
			else
				bladlast = hasDrumsInBags
			end

			-- #showtooltip Bloodlust, Time Warp, Netherwinds, Drums and Favorite mount - Ctrl+Shift+V
			EditMacro("WSxFavMount",nil,nil,"#showtooltip " ..bladlast.. "\n/run C_MountJournal.SummonByID(0)\n/dismount [mounted]\n/cancelform\n/cancelaura Zen Flight\n/cancelaura Flaming Hoop\n/cancelaura Prowl\n/cancelaura Stealth")

			--  T75 Talents, "Ctrl+7" bind Bloodlusts etc and SGen+G Biggest Dick in the game, Poppa BL, Ctrl+7 and ptdSG injector
			if class == "SHAMAN" then
				EditMacro("WSxT75",nil,nil,"#showtooltip [mod] " ..bladlast.. ";[talent:5/1]Nature's Guardian;[spec:1,talent:5/2]Ancestral Guidance;[spec:2,talent:5/2]Feral Lunge;[talent:5/3]Wind Rush Totem;" ..bladlast.. ";\n/use " ..bladlast.."\n/use [nocombat]Thunderstorm")
				EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use "..ptdSG.."[@mouseover,harm,nodead][harm,nodead]Purge;Flaming Hoop\n/targetenemy [noexists]\n/cleartarget [dead]")
			-- Is class Mage
			elseif class == "MAGE" then
				EditMacro("WSxT75",nil,nil,"#showtooltip [mod] " ..bladlast.. ";[talent:5/3]Ring of Frost;Polymorph;\n/use " ..bladlast)
				EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use "..ptdSG.."Spellsteal\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]\n/use Poison Extraction Totem")
			-- Is class Warlock
			elseif class == "WARLOCK" then
				EditMacro("WSxT75",nil,nil,"#showtooltip [mod]"..bladlast..";[talent:5/1]Shadowfury;[talent:5/2]Mortal Coil;[talent:5/3]Demonic Circle\n/use " ..bladlast)
				EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use "..ptdSG.."[pet:Felhunter/Observer]Devour Magic;[pet:Felguard]Axe Toss;Command Demon\n/use [noexists,nocombat] Flaming Hoop\n/targetenemy [noexists]")
			-- Is class Monk
			elseif class == "MONK" then
				EditMacro("WSxT75",nil,nil,"#showtooltip [mod] " ..bladlast.. ";[nospec:3]Fortifying Brew;[talent:5/1]Healing Elixir;[talent:5/2]Diffuse Magic;[talent:5/3]Dampen Harm;\n/use "..bladlast)
				EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use "..ptdSG.."Pandaren Scarecrow\n/use [noexists,nocombat]Flaming Hoop")
			-- Is class Paladin
			elseif class == "PALADIN" then
			    EditMacro("WSxT75",nil,nil,"#showtooltip [mod] " ..bladlast.. ";[talent:5/2]Holy Avenger;[talent:5/3]Seraphim\n/use " ..bladlast)
			    EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use "..ptdSG.."Hammer of Justice\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]")
			-- Is class Hunter
			elseif class == "HUNTER" then
				EditMacro("WSxT75",nil,nil,"#showtooltip [talent:5/3,nomod]Binding Shot;"..bladlast.."\n/use " ..bladlast)
				--[[EditMacro("WSxSGen+G",nil,nil,"/use "..ptdSG.."[nopet]Call Pet 4;[pet:Water Strider]Soothing Water;[pet:Spirit Beast]Spirit Shock;[pet:Crab]Pin;[pet:Devilsaur]Monstrous Bite;[pet:Ray]Nether Shock\n/use [nocombat,noexists,resting]Flaming Hoop")
				EditMacro("WSxGG",nil,nil,"/use [mod:alt,pet,@player]Master's Call;[nopet,mod:alt]Call Pet 1;[nopet]Call Pet 5;[pet:Water Strider]Surface Trot;[pet:Spirit Beast,nocombat]Spirit Walk;[pet:Spirit Beast]Spirit Shock;[pet:Devilsaur]Feast\n/use [nocombat]Whole-Body Shrinka'")--]]
			-- Is class Rogue
			elseif class == "ROGUE" then
				EditMacro("WSxT75",nil,nil,"#showtooltip\n/use " ..bladlast)
				if ptdSG and class == "ROGUE" then
					ptdSG = "[mod:alt][nospec:2,harm,nodead]Protocol Transference Device;"
				end
					EditMacro("WSxGG",nil,nil,"#showtooltip\n/use [mod:alt,nocombat,noexists]Darkmoon Gazer;"..ptdSG.."[spec:2,harm,nodead]Gouge;Pick Lock")
			-- is class Prist
			elseif class == "PRIEST" then
				EditMacro("WSxT75",nil,nil,"#showtooltip [mod] " ..bladlast.. ";[spec:1,talent:5/3]Shadow Covenant;[spec:2,talent:5/2]Binding Heal;[spec:2,talent:5/3]Circle of Healing;[spec:3,talent:5/2]Shadow Word: Death;[spec:3,talent:5/3]Shadow Crash;Smite\n/use " ..bladlast)
				EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use "..ptdSG.."[@mouseover,harm,nodead][harm,nodead]Dispel Magic;Personal Spotlight\n/use [noexists,nocombat] Flaming Hoop\n/targetenemy [noexists]")
			-- Is class Death Knight
			elseif class == "DEATHKNIGHT" then
				EditMacro("WSxT75",nil,nil,"#showtooltip [mod] " ..bladlast.. ";[spec:3,talent:5/2]Corpse Shield;\n/use " ..bladlast)
				EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use "..ptdSG.."[spec:2,talent:3/3]Blinding Sleet;[spec:2,talent:3/2][spec:1]Asphyxiate;[nopet]Raise Dead;[pet]!Gnaw\n/use [noexists,nocombat] Flaming Hoop\n/petattack [harm,nodead]")
			-- Is class Warrior
			elseif class == "WARRIOR" then
				EditMacro("WSxT75",nil,nil,"#showtooltip [mod]"..bladlast.. ";[spec:1,talent:5/3]Focused Rage\n/use "..bladlast)
				EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use "..ptdSG.."[nospec:3,talent:2/3][spec:3,talent:5/3]Storm Bolt\n/use [noexists,nocombat]Flaming Hoop")
			-- Is class Druid
			elseif class == "DRUID" then
				EditMacro("WSxT75",nil,nil,"#showtooltip [mod]" ..bladlast..";[spec:1]Celestial Alignment;[spec:2,talent:5/3]Savage Roar;[spec:2]Berserk;[spec:3,talent:5/2]Incarnation: Guardian of Ursoc;[spec:4,talent:5/3]Incarnation: Tree of Life(Talent, Shapeshift)\n/use ".. bladlast) 
				EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use "..ptdSG.."[spec:2,form:2]Maim;Soothe;\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]") 
			-- Is class Demon Hunter
			elseif class == "DEMONHUNTER" then
				EditMacro("WSxT75",nil,nil,"#showtooltip [mod]" ..bladlast.. ";[spec:2,talent:5/3]Sigil of Chains;[spec:1,talent:5/3]Dark Slash;Blade Dance\n/use " ..bladlast)
				EditMacro("WSxSGen+G",nil,nil,"/use "..ptdSG.."[spec:1,talent:6/3]Fel Eruption;Consume Magic\n/use [noexists,nocombat] Flaming Hoop")
			end -- Class
		end -- EventHandler

		if (class == "HUNTER" and event == "PET_SPECIALIZATION_CHANGED") and event == "PLAYER_LOGIN" then
		-- Hunter Pet specialization changed or if @ player_login
			if petspec == 1 then
				EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use [pet]Dash(Basic Ability)")
			elseif petspec == 2 then
				EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use [pet]Command Pet")
			end
			if petspec == 3 then				
				EditMacro("WSxGen+B",nil,nil,"#showtooltip Command Pet\n/use [@mouseover,help,nodead][help,nodead]Command Pet")
				EditMacro("WSxRTS",nil,nil,"/use [mod:alt,noexists]MOLL-E;[mod:shift,@cursor]Tar Trap;[@mouseover,help,nodead,nomod][help,nodead,nomod]Master's Call;[spec:3]Wing Clip;[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Concussive Shot\n/targetenemy [noharm]")
			else
				EditMacro("WSxRTS",nil,nil,"/use [mod:alt,noexists]MOLL-E;[mod:shift,@cursor]Tar Trap;[spec:3]Wing Clip;[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Concussive Shot\n/targetenemy [noharm]")
			end
		end

		-- Hunter Misc pet parser
		if class == "HUNTER" and (event == "PET_STABLE_CLOSED" or event == "PLAYER_LOGIN") then 
		
			local petAbilityMacro, petExoticMacro = "/use "..ptdSG.."[nopet]Call Pet 4;", "/use [mod:alt,pet,@player]Master's Call;[nopet,mod:alt]Call Pet 1;[nopet]Call Pet 5;"

			local petAbilities = {
				["Basilisk"] = "Petrifying Gaze",
				["Bat"] = "Sonic Blast",
				["Bear"] = "Thick Fur",
				["Beetle"] = "Harden Carapace",
				["Bird of Prey"] = "Talon Rend",
				["Blood Beast"] = "Blood Bolt",
				["Boar"] = "Bristle",
				["Carrion Bird"] = "Bloody Screech",
				["Cat"] = "Catlike Reflexes",
				["Chimaera"] = "Frost Breath",
				["Clefthoof"] = "Thick Hide",
				["Core Hound"] = "Obsidian Skin",
				["Crab"] = "Pin",
				["Crane"] = "Chi-Ji's Tranquility",
				["Crocolisk"] = "Ankle Crack",
				["Devilsaur"] = "Monstrous Bite",
				["Direhorn"] = "Gore",
				["Dog"] = "Lock Jaw",
				["Dragonhawk"] = "Dragon's Guile",
				["Feathermane"] = "Feather Flurry",
				["Fox"] = "Agile Reflexes",
				["Goat"] = "Gruff",
				["Gorilla"] = "Silverback",
				["Hydra"] = "Acid Bite",
				["Hyena"] = "Infected Bite",
				["Krolusk"] = "Bulwark",
				["Lizard"] = "Grievous Bite",
				["Mechanical"] = "Defense Matrix",
				["Monkey"] = "Primal Agility",
				["Moth"] = "Serenity Dust",
				["Oxen"] = "Niuzao's Fortitude",
				["Pterrordax"] = "Ancient Hide",
				["Quilen"] = "Stone Armor",
				["Raptor"] = "Savage Rend",
				["Ravager"] = "Ravage",
				["Ray"] = "Nether Shock",
				["Riverbeast"] = "Gruesome Bite",
				["Rodent"] = "Gnaw",
				["Scalehide"] = "Scale Shield",
				["Scorpid"] = "Deadly Sting",
				["Serpent"] = "Serpent's Swiftness",
				["Shale Spider"] = "Solid Shell",
				["Silithid"] = "Tendon Rip",
				["Spider"] = "Web Spray",
				["Spirit Beast"] = "Spirit Shock",
				["Sporebat"] = "Spore Cloud",
				["Stag"] = "Nature's Grace",
				["Tallstrider"] = "Dust Cloud",
				["Toad"] = "Swarm of Flies",
				["Turtle"] = "Shell Shield",
				["Warp Stalker"] = "Warp Time",
				["Water Strider"] = "Soothing Water",
				["Wind Serpent"] = "Winged Agility",
				["Wolf"] = "Furious Bite",
				["Worm"] = "Acid Spit",
			}

			local petExoticAbilities = {
				["Spirit Beast"] = "Spirit Mend",
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
				["Water Strider"] = "Surface Trot",
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
			petAbilityMacro = petAbilityMacro .. "\n/use [nocombat,noexists,resting]Flaming Hoop" 
			-- Call Pet 4, Shift+G
			petExoticMacro = petExoticMacro .. "\n/use Whole-Body Shrinka'" 
			-- Ctrl+Shift+G --> "GG", "G"
			EditMacro("WSxSGen+G", nil, nil, petAbilityMacro, 1, 1)
			EditMacro("WSxGG", nil, nil, petExoticMacro, 1, 1)
			DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Updating Active Pets! :D",0.5,1.0,0.0)
				print(family)
				print(petAbilityMacro)
				print(petExoticAbilities)
				print(petAbilities[family])
			
		end -- eventHandler
	end -- Combat Lock
end -- Function
frame:SetScript("OnEvent", eventHandler)