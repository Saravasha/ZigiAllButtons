SLASH_ZIGIALLBUTTONS1 = "/zigi"
local ZigiAllButtons = CreateFrame("FRAME", "ZigiAllButtons")

-- ZigiAllButtons:RegisterEvent("ADDON_LOADED")
ZigiAllButtons:RegisterEvent("BAG_UPDATE_DELAYED")
ZigiAllButtons:RegisterEvent("ZONE_CHANGED_NEW_AREA")
ZigiAllButtons:RegisterUnitEvent("UNIT_PET","player")
ZigiAllButtons:RegisterEvent("GROUP_ROSTER_UPDATE")
ZigiAllButtons:RegisterEvent("PLAYER_ENTERING_WORLD")
ZigiAllButtons:RegisterEvent("PLAYER_LEVEL_UP")
ZigiAllButtons:RegisterEvent("LEARNED_SPELL_IN_SKILL_LINE")
ZigiAllButtons:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
ZigiAllButtons:RegisterEvent("TRAIT_CONFIG_UPDATED")
ZigiAllButtons:RegisterEvent("COVENANT_CHOSEN")

local loaded = false
local locked = false

function SlashCmdList.ZIGIALLBUTTONS(msg, ...)
	if msg == "zonevars" then
		ZigiPrintZoneVars()
	else
		DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Known commands are:\n(ZigiAllButtons): zigi zonevars\n(ZigiLevelNewChar): zigiplz eq\n(ZigiLevelNewChar): zigiplz save\n(ZigiLevelNewChar): zigiplz load\n(ZigiLevelNewChar): zigiplz dragonzigi\n(ZigiLevelNewChar): zigiplz new",0.5,1.0,0.0)
	end
end
--[[/use [nomounted]Eternal Black Diamond Ring
/run if IsControlKeyDown() then C_PartyInfo.LeaveParty() elseif IsShiftKeyDown() then LFGTeleport(IsInLFGDungeon()) end
--]]


local function eventHandler(event)

	if InCombatLockdown() then
		ZigiAllButtons:RegisterEvent("PLAYER_REGEN_ENABLED")
	else

		-- print("test")
		hasCannon = ZA.vars[1]
		alt4 = ZA.vars[2]
		alt5 = ZA.vars[3]
		alt6 = ZA.vars[4]
		alt9 = ZA.vars[5]
		CZ = ZA.vars[6]
		AR = ZA.vars[7]
		conDB = ZA.vars[8]
		conEF = ZA.vars[9]
		conAF = ZA.vars[10]
		conVS = ZA.vars[11]
		conSET = ZA.vars[12]
		conST = ZA.vars[13]
		conSst = ZA.vars[14]
		conMW = ZA.vars[15]
		conMS = ZA.vars[16]
		conTE = ZA.vars[17]
		conBE = ZA.vars[18]
		conCE = ZA.vars[19]
		conRE = ZA.vars[20]
		LAR = ZA.vars[21] 
		hasShark = ZA.vars[22]
		hasScrapper = ZA.vars[23] 
		sigA = ZA.vars[24]
		sigB = ZA.vars[25]
		covA = ZA.vars[26]
		covB = ZA.vars[27]
		poS = ZA.vars[28]
		hoaEq = ZA.vars[29]
		hasHE = ZA.vars[30]
		slBPGen = ZA.vars[31]
		pwned = ZA.vars[32] 
		fftpar = ZA.vars[33] 
		factionPride = ZA.vars[34] 
		factionFireworks = ZA.vars[35] 
		passengerMount = ZA.vars[36] 
		warPvPExc = ZA.vars[37]
		locPvPQ = ZA.vars[38] 
		locPvPSThree = ZA.vars[39]
		locPvPF = ZA.vars[40] 
		PoA = ZA.vars[41]
		covSpecial = ZA.vars[42]
		classText = ZA.vars[43]
		zA = ZA.vars[44]
		ink = ZA.vars[45]
		ccz = ZA.vars[46]
		usable = ZA.vars[47]
		tpPants = ZA.vars[48]
		noPants = ZA.vars[49]
		oOtas = ZA.vars[50]
		bfaIsland = ZA.vars[51]
		slBP = ZA.vars[52]
		pennantClass = ZA.vars[53]
		usableWeapons = ZA.vars[54]
		usableWeaponEquipped = ZA.vars[55]
		override = ZA.vars[56]
		overrideModAlt = ZA.vars[57]
		overrideModCtrl = ZA.vars[58]
		mercenaryRacials = ZA.vars[59]
		racials = ZA.vars[60]
		dpsRacials = ZA.vars[61]
		extraRacials = ZA.vars[62]
		swapblaster = ZA.vars[63]

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
		local instanceName = ZG.Instance_Info("instanceName")
		local instanceType = ZG.Instance_Info("instanceType")
		local difficultyID = ZG.Instance_Info("difficultyID")
		local gHI = ZG.World_Event()

		
		-- -- Configure Battlefield Map
		if not BattlefieldMapFrame then
			BattlefieldMap_LoadUI(); 
		else
			BattlefieldMapFrame:SetScale(1.4)
			BattlefieldMapFrame:SetAlpha(.9)
			BattlefieldMapFrame:SetPoint("TOPLEFT")
			BattlefieldMapFrame.BorderFrame.CloseButton:Hide()
		end

		if class == "MAGE" then 
			pwned = "Khadgar's Disenchanting Rod"
		elseif class == "WARLOCK" then
			pwned = "Drust Ritual Knife"
		elseif class == "HUNTER" then
			pwned = "Warbeast Kraal Dinner Bell"
		elseif class == "PRIEST" then
			passengerMount = "The Hivemind"
		end

		-- CovToys
		if slBP and ZA.covToys[slBP] then
			covToys = ZA.covToys[slBP]
			covToys = covToys[random(#covToys)]
			covToys = "\n/use "..covToys
		end

		-- if Instanced Content 
		if instanceType ~= "none" then
			SetBinding("A","STRAFELEFT")
			SetBinding("D","STRAFERIGHT")
		else
		-- else: InstanceType: "none"
			SetBinding("A","TURNLEFT")
			SetBinding("D","TURNRIGHT")
		end

		-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: ZONEw_CHANGED_NEW_AREA\nRecalibrating related macros :)",0.5,1.0,0.0)
	
		if race == "Orc" then
			pennantClass = "\n/use Clan Banner"
		elseif class == "ROGUE" and playerSpec ~= 2 then
			pennantClass = "\n/use Honorable Pennant\n/cancelaura A Mighty Pirate"
		elseif class == "ROGUE" or (classk == "PIRATE") then 
			pennantClass = "\n/use Jolly Roger\n/cancelaura Honorable Pennant\n/use Swarthy Warning Sign"
		end

		mercenaryRacials = {
			[28730] = "BloodElf",
			[28880] = "Draenei",
			[265221] = "DarkIronDwarf",
			[20594] = "Dwarf",
			[20589] = "Gnome",
			[69070] = "Goblin", 
			[69041] = "Goblin",
			[255654] = "HighmountainTauren",
			[59752] = "Human",
			[287712] = "KulTiran",
			[255647] = "LightforgedDraenei",
			[274738] = "MagharOrc",
			[312924] = "Mechagnome",
			[260364] = "Nightborne",
			[58984] = "NightElf",
			[20572] = "Orc",
			[107079] = "Pandaren",
			[7744] = "Scourge",
			[20549] = "Tauren",
			[26297] = "Troll",
			[256948] = "VoidElf",
			[312411] = "Vulpera",
			[68992] = "Worgen",
			[291944] = "ZandalariTroll",
			[358733] = "Dracthyr",
		}

		-- mercenaryRacials Setter
		for k,v in pairs(mercenaryRacials) do
			if IsSpellKnown(k) == true then
				race = v
			end
		end

		racials = {	
			["BloodElf"] = "Arcane Torrent",
			["Draenei"] = "[@mouseover,help,nodead][]Gift of the Naaru",
			["DarkIronDwarf"] = "Fireblood",
			["Dwarf"] = "Stoneform",
			["EarthenDwarf"] = "Azerite Surge",
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
			["Vulpera"] = "[@mouseover,exists,nodead][]Bag of Tricks",
			["Worgen"] = "Darkflight",
			["ZandalariTroll"] = "Regeneratin'",
			["Dracthyr"] = "Visage",
		}
		racials = racials[race]
		
		dpsRacials = {
			["MagharOrc"] = "\n/use Ancestral Call",
			["Orc"] = "\n/use Blood Fury",
			["Troll"] = "\n/use Berserking",
			["DarkIronDwarf"] = "\n/use Fireblood",
			["Mechagnome"] = "\n/use Hyper Organic Light Originator",
		}
		if not dpsRacials[race] then
			dpsRacials[race] = ""
		end
		dpsRacials = dpsRacials[race]
		extraRacials = {	
			["DarkIronDwarf"] = "Mole Machine",
			["Goblin"] = "[nocombat,noexists]Pack Hobgoblin;[@mouseover,harm,nodead][]Rocket Barrage",
			["LightforgedDraenei"] = "Forge of Light",
			["Mechagnome"] = "Skeleton Pinkie",
			["Nightborne"] = "[nocombat,noexists]Cantrips;Nightborne Guard's Vigilance",
			["Scourge"] = "Cannibalize",
			["VoidElf"] = "Spatial Rift",
			["Vulpera"] = "Rummage Your Bag",
			["Worgen"] = "Two Forms",
			["Dracthyr"] = "Chosen Identity",
			["ZandalariTroll"] = "Pterrordax Swoop",
		}
		if faction == "Alliance" then
			pwned = "Alliance Flag of Victory" 
			fftpar = "Touch of the Naaru"
			factionPride = "Gnomeregan Pride"
			factionFireworks = "Everlasting Alliance Firework"
			passengerMount = "Stormwind Skychaser" 
		end

		-- Kyrian, 
		if ZA.cov[slBP] == "Kyrian" then
			covSpecial = "\n/use Bondable Val'kyr Diadem\n/use Acrobatic Steward\n/use Malfunctioning Goliath Gauntlet"
		-- Venthyr, 
		elseif ZA.cov[slBP] == "Venthyr" then
			covSpecial = "\n/use [exists,nodead]Tome of Small Sins;Bondable Sinstone"
		-- Night Fae,
		elseif ZA.cov[slBP] == "Night Fae" then
			covSpecial = "\n/use Sparkle Wings\n/use [nocombat,nostealth]Gormling in a Bag"
		-- Necrolord, 
		elseif ZA.cov[slBP] == "Necrolord" then
			covSpecial = "\n/use Apprentice Slimemancer's Boots"
		-- Mawsworn, 
		elseif ZA.cov[slBP] == "Mawsworn" then
			covSpecial = "\n/use Experimental Anima Cell"
		-- Enlightened, 
		elseif ZA.cov[slBP] == "Enlightened" then
			covSpecial = "\n/use Protological Cube"
		end

		if not extraRacials[race] and class == "SHAMAN" then
			extraRacials[race] = (Get_Spell({{"Wind Rush Totem","[@player]",""},{"Earthgrab Totem","[@player]",""},}) or "Zandalari Effigy Amulet")
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
		if race == "VoidElf" then
			EditMacro("Wx6RacistAlt+V",nil,nil,"#show " ..racials.."\n/use Prismatic Bauble\n/use Sparklepony XL\n/castsequence reset=9 "..racials..",Languages")
		else
			EditMacro("Wx6RacistAlt+V",nil,nil,"#show " ..racials.."\n/use Prismatic Bauble\n/use Sparklepony XL\n/use "..racials)
		end
		-- dpsRacials Implementation
		if class == "SHAMAN" then
			EditMacro("WSkillbomb",nil,nil,"/use "..(Get_Spell({{"Fire Elemental","",""},{"Storm Elemental","",""},{"Feral Spirit","",""},{"Earth Elemental","\n/use ","\n/use Tiny Box of Tiny Rocks"},}) or "").."\n/use Rukhmar's Sacred Memory"..(Get_Spell("Ascendance","\n/use ","") or "")..dpsRacials.."\n/use [@player]13\n/use 13\n/use Flippable Table\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")	
		elseif class == "MAGE" then
			EditMacro("WSkillbomb",nil,nil,"#show"..(Get_Spell({{"Combustion","\n/use ",""},{"Icy Veins","\n/use ",""},{"Arcane Surge","\n/use ",""},}) or "")..(Get_Spell("Mirror Image","\n/use ","") or "")..dpsRacials.."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13\n/use Hearthstone Board\n/use Gleaming Arcanocrystal\n/use Big Red Raygun"..hasHE)
		elseif class == "WARLOCK" then
			EditMacro("WSkillbomb",nil,nil,"#show\n/use "..(Get_Spell({{"Summon Demonic Tyrant","",""},{"Nether Portal","",""},{"Summon Infernal","[@player]",""},{"Summon Darkglare","",""},}) or "").."\n/use Jewel of Hellfire\n/use [@player]13\n/use 13"..dpsRacials.."\n/use Shadescale\n/use Adopted Puppy Crate\n/use Big Red Raygun")
		elseif class == "MONK" then
			EditMacro("WSkillbomb",nil,nil,"#show"..(Get_Spell({{"Storm, Earth, and Fire","\n/use ",""},{"Serenity","\n/use ",""},}) or "")..(Get_Spell({{"Invoke Xuen, the White Tiger","\n/use ",""},{"Invoke Yu'lon, the Jade Serpent","\n/use ",""},{"Invoke Chi-Ji, the Red Crane","\n/use ",""},{"Invoke Niuzao, the Black Ox","\n/use ",""},}) or "")..dpsRacials.."\n/use Rukhmar's Sacred Memory\n/use Adopted Puppy Crate\n/use [@player]13\n/use 13\n/use Big Red Raygun\n/use Piccolo of the Flaming Fire\n/use [@player]Summon White Tiger Statue")
		elseif class == "PALADIN" then
			EditMacro("WSkillbomb",nil,nil,"#show\n/use "..(Get_Spell("Avenging Wrath","","") or "").."\n/use [@player]13\n/use 13\n/use Sha'tari Defender's Medallion"..dpsRacials.."\n/use Gnawed Thumb Ring\n/use Echoes of Rezan")
		elseif class == "HUNTER" then
			EditMacro("WSkillbomb",nil,nil,"#show\n/use "..(Get_Spell({{"Bestial Wrath","",""},{"Trueshot","",""},{"Coordinated Assault","",""},{"Spearhead","",""}}) or "Hunter's Call").."\n/use Will of Northrend"..dpsRacials.."\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Pendant of the Scarab Storm\n/use Big Red Raygun\n/use Echoes of Rezan")
		elseif class == "ROGUE" then
			EditMacro("WSkillbomb",nil,nil,"/use "..(Get_Spell({{"Deathmark","",""},{"Adrenaline Rush","",""},{"Shadow Blades","",""},}) or "").."\n/stopmacro [stealth]\n/use Will of Northrend"..dpsRacials.."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13"..hasHE.."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
		elseif class == "PRIEST" then
			EditMacro("WSkillbomb",nil,nil,"/use "..(Get_Spell("Shadowfiend","","") or "")..dpsRacials.."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSkillbomb",nil,nil,"#show\n/cast "..(Get_Spell({{"Dancing Rune Weapon","",""},{"Pillar of Frost","",""},{"Dark Transformation","[nopet]Raise Dead;",""},}) or "")..dpsRacials.."\n/use [@player]13\n/use 13\n/use Raise Dead\n/use Pendant of the Scarab Storm\n/use Adopted Puppy Crate\n/use Big Red Raygun")
		elseif class == "WARRIOR" then
			EditMacro("WSkillbomb",nil,nil,"#show "..(Get_Spell("Avatar","\n/use ","") or "")..(Get_Spell("Recklessness","\n/use ","") or "")..(Get_Spell("Battle Stance","\n/use [nostance:2]","") or "")..((Get_Spell("Berserker Stance","\n/use [nostance:2]","") or "")).."\n/use Flippable Table"..dpsRacials..hasHE.."\n/use Will of Northrend\n/use [@player]13\n/use 13"..(Get_Spell("Thunderous Roar","\n/use ","") or "")..(Get_Spell("Bladestorm","\n/use ","") or "")..(Get_Spell("Ravager","\n/use [@player]","") or "").."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
		elseif class == "DRUID" then
			EditMacro("WSkillbomb",nil,nil,"#show "..(Get_Spell({{"Celestial Alignment","\n/use [@cursor]",""},{"Incarnation: Chosen of Elune","\n/use !",""},{"Incarnation: Avatar of Ashamane","\n/use !",""},{"Incarnation: Guardian of Ursoc","\n/use !",""},{"Berserk","\n/use ",""},{"Incarnation: Tree of Life","\n/use !",""},{"Tranquility","\n/use ",""},}) or "")..(Get_Spell("Nature's Vigil","\n/use ","") or "")..(Get_Spell("Force of Nature","\n/use [@player]","") or "")..dpsRacials.."\n/use [spec:1/4]Rukhmar's Sacred Memory;Will of Northrend\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSkillbomb",nil,nil,"#showtooltip "..(Get_Spell("Metamorphosis") or "").."\n/use Shadowy Disguise\n/use Shadow Slicing Shortsword\n/use [@player]Metamorphosis\n/use [@player]13\n/use 13"..dpsRacials.."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
		elseif class == "EVOKER" then
			EditMacro("WSkillbomb",nil,nil,(Get_Spell({{"Dragonrage","/use ",""},{"Emerald Communion","/use !",""},{"Time Skip","/use !",""},}) or "").."\n/use [@player]13\n/use 13"..dpsRacials.."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
		end

		-- print("slBP is: ",slBP)
		if race ~= "BloodElf" and (level and eLevel) >= 25 then
			oOtas = "\n/use Orb of the Sin'dorei"
		end
		if (level and eLevel) < 20 then
			oOtas = oOtas.."\n/use Toy Aarmor Set\n/use Toy Weapon Set"
		else
			oOtas = oOtas
		end

		-- speciella item sets
		noPants = ZG.EQS[playerSpec]
		tpPants = "Tipipants"
		-- print("noPants = ", ZG.EQS[playerSpec])
		if C_EquipmentSet.GetEquipmentSetID(tpPants) ~= nil and playerSpec ~= 5 then
			tpPants = C_EquipmentSet.GetEquipmentSetID(tpPants) or ""
			noPants = C_EquipmentSet.GetEquipmentSetID(noPants) or ""
			tpPants = "C_EquipmentSet.UseEquipmentSet("..tpPants..")" 
			noPants = "C_EquipmentSet.UseEquipmentSet("..noPants..")"
		end 
		
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
			-- if UnitIsPVP("player") == true then
			-- end
			if PvPTalentNames[i] then
				-- Talent finns
				EditMacro("PvPAT " .. i, nil, PvPTalentIcons[i], "/stopspelltarget\n/stopspelltarget\n/use [mod,@focus,exists,nodead][mod,@player]"..PvPTalentNames[i].."\n/use [@mouseover,exists,nodead,nomod][@cursor,nomod]"..PvPTalentNames[i])
			else
				EditMacro("PvPAT " .. i, nil, 237554, "")
		    end
			if class == "SHAMAN" then 
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
					locPvPQ = "[@mouseover,harm,nodead][]Call Felhunter"
					locPvPF = "[@focus,harm,nodead]Call Felhunter;"
				end
				if PvPTalentNames[i] == "Call Fel Lord" then
					locPvPExcSeven = "[mod:shift,@player][@cursor]Call Fel Lord"
				end
				if PvPTalentNames[i] == "Fel Obelisk" then
					locPvPSThree = "[@player]Fel Obelisk"
				end
			elseif class == "PRIEST" then
				if PvPTalentNames[i] == "Inner Light and Shadow" then
					EditMacro("PvPAT " .. i, nil, PvPTalentIcons[i], "#showtooltip Inner Light and Shadow\n/stopspelltarget\n/stopspelltarget\n/use Inner Shadow\n/use Inner Light")
				elseif PvPTalentNames[i] == "Thoughtsteal" then
					EditMacro("PvPAT " .. i, nil, PvPTalentIcons[i], "/stopspelltarget\n/stopspelltarget\n/use [@mouseover,exists,nodead,nomod][@cursor,nomod]"..PvPTalentNames[i])
				end
			elseif class == "WARRIOR" and PvPTalentNames[i] == "Death Wish" then
				warPvPExc = "[]Death Wish;"
			end
		end
		-- end

		if (event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD") then 		

			-- lite b-funktion overrides och setters
			if class == "SHAMAN" then
				ZA.numaltbuff101112[class] = Get_Spell("Earth Shield") or ""
				ZA.numaltbuff789[class] = Get_Spell("Earth Shield") or ""
				ZA.modnumaltbuff789[class] = Get_Spell("Earth Shield") or ""
			elseif class == "MAGE" then
				ZA.altArenaDots[class] = Get_Spell({{"Nether Tempest","",""},{"Living Bomb","",""},{"Frost Bomb","",""},}) or ""
				ZA.ctrlArenaDots[class] = Get_Spell({{"Nether Tempest","",""},{"Living Bomb","",""},{"Frost Bomb","",""},}) or ""
				ZA.arenaDots[class] = Get_Spell({{"Nether Tempest","",""},{"Living Bomb","",""},{"Frost Bomb","",""},}) or ""
			elseif class == "WARLOCK" then
				ZA.wmpnomodkick[class] = locPvPQ
				ZA.arenaDots[class] = Get_Spell({{"Demonbolt","",""},{"Immolation","",""},{"Corruption","",""},}) or ""
			-- elseif class == "ROGUE" and playerSpec == 2 then
			-- 	ZA.modnumctrlbuff789[class] = "Kidney Shot"
			-- 	ZA.numctrlbuff101112[class] = "Kidney Shot"
			-- 	ZA.numctrlbuff789[class] = "Kidney Shot"
			-- 	ZA.wmpctrlcc[class] = "Kidney Shot"
			elseif class == "PRIEST" then 
				ZA.arenaDots[class] = Get_Spell("Vampiric Touch","[]",";") or "".."Shadow Word: Pain"
				ZA.wmpctrlcc[class] = Get_Spell({{"Thoughtsteal","",""},{"Mind Control","",""},}) or ""
				if Get_Spell("Pain Suppression") or Get_Spell("Guardian Spirit") then
					ZA.numaltbuff101112[class] = (Get_Spell("Pain Suppression") or "")..(Get_Spell("Guardian Spirit") or "")
				end
				if playerSpec ~= 3 then
					ZA.wmpnomodkick[class] = "Mindgames"
				end
			elseif class == "DRUID" then
					ZA.wmpnomodkick[class] = (Get_Spell({{"Skull Bash","",""},{"Solar Beam","",""},{"Cyclone","",""},}) or "")
					ZA.wmpctrlcc[class] = (Get_Spell({{"Cyclone","",""},{"Entangling Roots","",""},}) or "")
				if (playerSpec == 2 or playerSpec == 3) then
				elseif playerSpec == 4 then
					--mod:shift base
					ZA.numaltbuff789[class] = (Get_Spell("Grove Guardians","","") or "")
					ZA.numnomodbuff789[class] = (Get_Spell("Grove Guardians","","") or "")
					ZA.numctrlbuff789[class] = (Get_Spell("Grove Guardians","","") or "")

					ZA.modnumaltbuff789[class] = (Get_Spell("Grove Guardians","","") or "")
					ZA.modnumnomodbuff789[class] = (Get_Spell("Grove Guardians","","") or "")
					ZA.modnumctrlbuff789[class] = (Get_Spell("Grove Guardians","","") or "")

					-- 10,11,12 buttons,
					ZA.numnomodbuff101112[class] = (Get_Spell("Grove Guardians","","") or "")
					ZA.numaltbuff101112[class] = (Get_Spell("Grove Guardians","","") or "")
					ZA.numctrlbuff101112[class] = (Get_Spell("Grove Guardians","","") or "")
				end
			end 
		end
		-- Här börjar Events
		-- Login,zone,bag_update based event, Swapper, Alt+J parser, Call Companion, set class/spec toys.
		-- Zone och bag baserade events

		-- Showtooltip on Alt+J
		if (event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "BAG_UPDATE_DELAYED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LEVEL_UP" or event == "LEARNED_SPELL_IN_SKILL_LINE") then 
			if class == "MAGE" then
				classText = "#show "..(Get_Spell("Conjure Mana Gem","item:36799;",";") or "")..(Get_Spell("Arcane Familiar") or "").."\n/use Pilfered Sweeper"
			end
		end
		if (event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LEVEL_UP" or event == "LEARNED_SPELL_IN_SKILL_LINE") then 

			-- Skulle kunna migrera det här blocket till ZigiSwapper och göra ett funktionsanrop cross addons för b-funktionerna som lagras i classText
			if class == "SHAMAN" then
				classText = "#show "..(Get_Spell({{"Mana Tide Totem","",""},{"Earth Elemental","",""},}) or "")
			elseif class == "WARLOCK" then
				classText = ""
			elseif class == "MONK" then
				classText = "#show "..(Get_Spell({{"Black Ox Brew","",""},{"Thunder Focus Tea","",""},{"Invoke Xuen, the White Tiger","",""},}) or "")			
				if Get_Spell("Invoke Xuen, the White Tiger") then
					classText = classText.."\n/use Fury of Xuen" 
				elseif Get_Spell("Invoke Niuzao, the Black Ox") then 
					classText = classText.."\n/use Fortitude of Niuzao"
				elseif Get_Spell("Invoke Chi-Ji, the Red Crane") then
					classText = classText.."\n/use Kindness of Chi-Ji"
				elseif Get_Spell("Invoke Yu'lon, the Jade Serpent") then
					classText = classText.."\n/use Essence of Yu'lon"
				end
			elseif class == "PALADIN" then
				classText = "#show "..(Get_Spell("Lay on Hands") or "").."\n/use "..(Get_Spell("Contemplation","[]",";") or "Holy Lightsphere")
			elseif class == "HUNTER" then
				classText = "#show Command Pet"
				if playerSpec == 2 then 
					classText = classText.."\n/use Dark Ranger's Spare Cowl"
				else
					classText = classText.."\n/use Zanj'ir Weapon Rack"
				end
			elseif class == "ROGUE" then
				classText = "#show "..(Get_Spell({{"Shadow Dance","",""},{"Tricks of the Trade","",""},}) or "")
			elseif class == "PRIEST" then
				classText = "#show "..(Get_Spell("Mass Dispel") or "")
			elseif class == "DEATHKNIGHT" then
				classText = "#show "..(Get_Spell("Raise Dead") or "").."\n/use [nocombat]Permanent Frost Essence\n/use [nocombat]Champion's Salute"
				if faction == "Alliance" then
					classText = "#show "..(Get_Spell("Raise Dead") or "").."\n/use [nocombat]Stolen Breath\n/use [nocombat]Champion's Salute"
				end
			elseif class == "WARRIOR" then
				classText = "#show Shield Block\n/use "..factionPride.."\n/use Raise Banner"
			elseif class == "DRUID" then
				classText = "#show Rebirth\n/use Wisp in a Bottle"
			elseif class == "DEMONHUNTER" then
				classText = "#show "..(Get_Spell("Vengeful Retreat") or "")
			elseif class == "EVOKER" then
				classText = "#show "..(Get_Spell({{"Time Spiral","",""},{"Spatial Paradox","",""},}) or "")
			end
			-- print("classtext is = ",classText)
			EditMacro("WSxSwapperBody",nil, nil, classText)
			ZigiSetSwapper()	
		end
			        
		if event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD" or event == "LEARNED_SPELL_IN_SKILL_LINE" then
			bfaIsland = difficultyID
			-- Gör ett nytt macro för ExtraActionButton1 som har en Vindicator Matrix ability bundet när du är på Argus, bind detta till CGenB
			-- Zone Ability
			if instanceName == "Draenor" then
				-- Draenor: Garrison Ability
			elseif instanceName == "Broken Isles" then
				zA = "/use [@mouseover,harm,nodead][@cursor]Combat Ally"
			elseif instanceName == "Argus" then
				-- Argus: Vindicaar Matrix Crystal
				zA = "/use [mod:alt,@mouseover,harm,nodead][mod:alt,@cursor]Combat Ally;[@mouseover,exists,nodead][@cursor]Vindicaar Matrix Crystal"
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
			elseif ZG.dfZones[z] then
				zA = "/use Hunting Companion\n/use Blessing of Ohn'ahra"
			elseif (ZG.twwZones[z] or z == "Azj-Kahet") then
				if IsSpellKnownOrOverridesKnown(442040) then
					zA = "/use Woven Cocoon"
				elseif IsSpellKnownOrOverridesKnown(441990) then
					zA = "/use Heavy Ordnance"
				elseif IsSpellKnownOrOverridesKnown(442044) then
					zA = "/use Unstable Concoction: Slumber"
				elseif IsSpellKnownOrOverridesKnown(442133) then
					zA = "/use Unstable Concoction: Ravenous"
				end
			end
			EditMacro("WSxCSGen+B",nil,nil,zA)
			EditMacro("WSxCGen+B",nil,nil,"#show\n/click ExtraActionButton1")
		end

        if (event == "ZONE_CHANGED_NEW_AREA" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "BAG_UPDATE_DELAYED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LEVEL_UP" or event == "LEARNED_SPELL_IN_SKILL_LINE") then 

			if ZG.Item_Count("Darkmoon Cannon") == 1 then 
				hasCannon = "\n/use Darkmoon Cannon"
			end
			alt4 = ink
			alt5 = hasCannon
			CZ = ""
			if ZG.dfZones[z] then
				if ZG.Item_Count("Fleeting Sands") >= 1 then
					alt4 = alt4.."\n/use Fleeting Sands"
				end 
				if ZG.Item_Count("Shikaar Hunting Horn") >= 1 then
					alt6 = alt6.."\n/use Shikaar Hunting Horn"
				end 
				alt9 = "\n/use Element-Infused Rocket Helmet"
				if ZG.Item_Count("Sticky Warp Grenade") >= 1 then
					hasShark = "Sticky Warp Grenade"
				end
				if ZG.Item_Count("Gravitational Displacer") >= 1 then
					hasScrapper = "Gravitational Displacer"
				end
		    elseif IsInJailersTower() == true then
				local torghastAnimaCell = {
					"Ravenous Anima Cell",
					"Plundered Anima Cell",
					"Requisitioned Anima Cell",					
				}
				local torghastAnimaCellInBags = ""
				for i, torghastAnimaCell in pairs(torghastAnimaCell) do
				    if ZG.Item_Count(torghastAnimaCell) >= 1 then
				        torghastAnimaCellInBags = torghastAnimaCell
				    end
				end
		    elseif ((z == "The Maw" and instanceName == "The Shadowlands") or (z == "The Rift" and instanceName == "The Shadowlands")) then
				alt4 = alt4.."\n/use Silver Shardhide Whistle"
				if (class == "PRIEST" or class == "MAGE" or class == "WARLOCK") then
					alt5 = "\n/use 9"
				elseif (class == "WARRIOR" or class == "DEATHKNIGHT" or class == "PALADIN" or class == "DRUID" or class == "MONK" or class == "ROGUE" or class == "DEMONHUNTER") then
					alt5 = alt5.."\n/use 10"
				else
					alt5 = alt5.."\n/use 8"
				end
				CZ = "[nostealth]Borr-Geth's Fiery Brimstone"
			elseif ZG.slZones[z] then
				if (class == "PRIEST" or class == "MAGE" or class == "WARLOCK") then
						alt5 = alt5.."\n/use 9"
				elseif (class == "WARRIOR" or class == "DEATHKNIGHT" or class == "PALADIN" or class == "DRUID" or class == "MONK" or class == "ROGUE" or class == "DEMONHUNTER") then
					alt5 = alt5.."\n/use 10"
				else
					alt5 = alt5.."\n/use 8"
				end 
				local kyrianInstrument = {
					"Heavenly Drum",
					"Kyrian Bell",
					"Benevolent Gong",
				}
				local kyrianInBags = ""
				for i, kyrianInstrument in pairs(kyrianInstrument) do
				    if ZG.Item_Count(kyrianInstrument) >= 1 then
				        kyrianInBags = kyrianInstrument
				    end
				end
				if ZG.Item_Count("Crumbling Pride Extractors") >= 1 then
					hasShark = "Crumbling Pride Extractors"
				end
				if ZG.Item_Count("Shrieker's Voicebox") >= 1 then
					hasScrapper = "Shrieker's Voicebox"
				end
				CZ = "[nostealth]"..kyrianInBags.."\n/use [nostealth]Borr-Geth's Fiery Brimstone" 
				alt4 = alt4.."\n/use Silver Shardhide Whistle"
				alt6 = alt6.."\n/use Phial of Ravenous Slime"
			elseif ZG.bfaZones[z] then
				if ZG.Item_Count("G99.99 Landshark") >= 1 then
					hasShark = "G99.99 Landshark"
				end
				if ZG.Item_Count("Scrap Grenade") >= 1 then
					hasScrapper = "Scrap Grenade"
				end
				if ZG.Item_Count("Exposed Fish") >= 1 then
					conEF = "\n/use Exposed Fish"
				end
				if ZG.Item_Count("Alpha Fin") >= 1 then 
					conAF = "\n/use Alpha Fin"
				end
				if ZG.Item_Count("Voltscale Shield") >= 1 then
					conVS = "\n/use Voltscale Shield"
				end
				if ZG.Item_Count("Storm Elemental Totem") >= 1 then
					conSET = "\n/use Storm Elemental Totem"
				end
				if ZG.Item_Count("Sea Totem") >= 1 then
					conST = "\n/use Sea Totem"
				end
				if ZG.Item_Count("Seastorm Totem") >= 1 then
					conSst = "\n/use Seastorm Totem"
				end
				if ZG.Item_Count("Mudwrap") >= 1 then
					conMW = "\n/use Mudwrap"
				end
				if ZG.Item_Count("Muck Slime") >= 1 then
					conMS = "\n/use Muck Slime"
				end
				-- Nazjatar exclusive and Aquatic mount
				if z == "Nazjatar" then
					if ZG.Item_Count("Deepcoral Pod") >= 1 then
						conDB = "\n/use Deepcoral Pod"
					end
				end
				alt4 = alt4..""..conDB..""..conEF..""..conAF
				alt5 = conSET..""..conST..""..conSst..""..conMS..""..conVS..""..hasCannon
				alt6 = conMW
				CZ = "Rhan'ka's Escape Plan"		
			elseif z == "Azj-Kahet" or z == "City of Threads" then
				CZ = "General's Expertise"
			-- Arathi Highlands
			elseif z == "Arathi Highlands" then
				if ZG.Item_Count("Thundering Essence") >= 1 then 
					conTE = "\n/use Thundering Essence"
				end
				if ZG.Item_Count("Burning Essence") >= 1 then 
					conBE = "\n/use Burning Essence"
				end
				if ZG.Item_Count("Cresting Essence") >= 1 then 
					conCE = "\n/use Cresting Essence"
				end
				if ZG.Item_Count("Rumbling Essence") >= 1 then 
					conRE = "\n/use Rumbling Essence"
				end
				alt5 = hasCannon..""..conTE..""..conBE..""..conCE..""..conRE
			-- Argus
			elseif instanceName == "Argus" then
				EditMacro("WSxCGen+B",nil,nil,"#show\n/use Vindicaar Matrix Crystal")
				alt4 = alt4.."\n/use Baarut the Brisk"
				alt6 = alt6.."\n/use The \"Devilsaur\" Lunchbox"
				CZ = "Sightless Eye"
			-- Broken Isles is continent 8
			elseif instanceName == "Broken Isles" then
				alt5 = "\n/use Emerald Winds"..hasCannon
				alt6 = alt6.."\n/use The \"Devilsaur\" Lunchbox"
				CZ = "Sightless Eye"
				if z == "Highmountain" then
					alt4 = alt4.."\n/use Majestic Elderhorn Hoof"
				end
			-- Draenor is continent 7
			elseif (instanceName == "Draenor") or (instanceName == "Frostfire Ridge") or (instanceName == "Shadowmoon Valley") or (instanceName == "Ashran") then
				alt4 = alt4.."\n/use Spirit of Shinri\n/use Skull of the Mad Chief"
				alt5 = "\n/use Breath of Talador\n/use Black Whirlwind"..hasCannon
				alt6 = alt6.."\n/use Ever-Blooming Frond"
				CZ = "Aviana's Feather\n/use Treessassin's Guise"
				LAR = "Findle's Loot-A-Rang"
			elseif z == "Timeless Isle" then
				alt4 = alt4.."\n/use Cursed Swabby Helmet\n/use Battle Horn\n/use Ash-Covered Horn"
				alt5 = "\n/use Bottled Tornado"..(pandaremixSpecial("meteorChip") or "")..hasCannon
				alt6 = alt6.."\n/use Eternal Warrior's Sigil"
				CZ = "[combat]Salyin Battle Banner" 
			-- Pandaria
			elseif (instanceName == "Pandaria") or (instanceName == "Vale of Eternal Blossoms") then
				-- if pandaTaxiUsables == nil then pandaTaxiUsables = "" end
				alt4 = alt4.."\n/use Cursed Swabby Helmet\n/use Battle Horn"..(pandaremixSpecial("pandaTaxi") or "")
				alt5 = "\n/use Bottled Tornado"..(pandaremixSpecial("meteorChip") or "")..hasCannon
				alt6 = alt6.."\n/use Eternal Warrior's Sigil"
				CZ = "[combat]Salyin Battle Banner" 
				hasShark = pandaremixSpecial("bottleBees") or ""
			-- Northrend
			elseif instanceName == "Northrend" then
				alt4 = alt4.."\n/use Grizzlesnout's Fang"
			end

			EditMacro("WLoot pls",nil,nil,"/click StaticPopup1Button1\n/use Battle Standard of Coordination\n/target mouseover\n/targetlasttarget [noharm,nocombat]\n/use "..LAR.."\n/use [exists,nodead,nochanneling]Rainbow Generator\n/use Gin-Ji Knife Set")
			EditMacro("WGrenade",nil,nil,"#show [mod:alt]"..hasScrapper..";"..hasShark.."\n/use Hot Buttered Popcorn\n/use [mod:alt]"..hasScrapper..";"..hasShark)
			
			-- (Shaman är default/fallback)
			
			if class == "MAGE" then
				ccz = "\n/use [combat,help,nodead][nocombat]Arcane Intellect;Invisibility"
			elseif class == "WARLOCK" then
				ccz = "\n/use Lingering Wyrmtongue Essence\n/use [nocombat,noexists]Heartsbane Grimoire"
			elseif class == "MONK" then
				ccz = "\n/use Mystical Orb of Meditation"
			elseif class == "PALADIN" then
				ccz = "\n/use Mystical Orb of Meditation\n/use !Devotion Aura\n/use Mark of Purity"
			elseif class == "HUNTER" then
				ccz = "\n/use "..(Get_Spell("Aspect of the Chameleon","","") or "Hunter's Call").."\n/use [nocombat]!Camouflage;Feign Death" 
			elseif class == "ROGUE" then
				ccz = "\n/use [combat]Vanish;[stance:0,nocombat]Stealth"
			elseif class == "PRIEST" then
					ccz = "\n/use Power Word: Fortitude"
				-- if Kyrian Prist
				if ZA.cov[slBP] == "Kyrian" then
					ccz = ccz.."\n/use Mystical Orb of Meditation"
				end
			elseif class == "DEATHKNIGHT" then
				ccz = "\n/use Haunting Memento\n/use [nopet,spec:3]Raise Dead"
			elseif class == "WARRIOR" then
				ccz = "\n/use Battle Shout\n/use Shard of Archstone"
				if ZA.cov[slBP] == "Kyrian" then
					ccz = ccz.."\n/use Mark of Purity"
				else
					ccz = ccz.."\n/use Brynja's Beacon"
				end
			elseif class == "DRUID" then
				ccz = "\n/use Fandral's Seed Pouch\n/use Ravenbear Disguise\n/use Mark of the Wild\n/use !Prowl"
			elseif class == "DEMONHUNTER" then
				ccz = "\n/use Lingering Wyrmtongue Essence\n/cancelaura Wyrmtongue Disguise"
			elseif class == "EVOKER" then
				ccz = "\n/use Blessing of the Bronze\n/use Red Dragon Head Costume\n/cancelaura Red Dragon Head Costume"
			end
			

			if CZ ~= "" then 
				CZ = "\n/use "..CZ
			end
			EditMacro("WSxCGen+Z",nil,nil,"/use Seafarer's Slidewhistle\n/use [nostealth]Repurposed Fel Focuser"..itemBuilder("augmentRune",eLevel)..ccz..CZ..covSpecial)
			function ZigiPrintZoneVars()
				
				DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Recalibrating zone based variables :)\nalt4 = "..alt4.."\nalt5 = "..alt5.."\nalt6 = "..alt6.."\nCZ = "..CZ.."\nccz = "..ccz.."\nPoA = "..PoA.."\nAR = "..itemBuilder("augmentRune",eLevel).."\nconTE = "..conTE.."\nconRE = "..conRE.."\nconBE = "..conBE.."\nconCE = "..conCE.."\nhasCannon = "..hasCannon.."\nz = "..z.."\ninstanceName = "..instanceName.."\ninstanceType = "..instanceType.."\ndifficultyID = "..difficultyID.."\ngHI = "..gHI,0.5,1.0,0.0)
			-- \ngHI = "..gHI
			end
      		      		    
			if class == "DEATHKNIGHT" then
				PoA = "harm,nodead,@arena"
			else
				PoA = "help,nodead,@party"
			end    
			
			EditMacro("WMPAlt+4",nil,nil,"/target [@boss1,exists,nodead,nomod:ctrl]\n/target [@arena1,exists,nodead,nomod:ctrl]\n/use [mod:ctrl,"..PoA.. "1,nodead]"..ZA.aC[class]..alt4)
			EditMacro("WMPAlt+5",nil,nil,"/target [@boss2,exists,nodead,nomod:ctrl]\n/target [@arena2,exists,nodead,nomod:ctrl]\n/use [mod:ctrl,"..PoA.. "2,nodead]"..ZA.aC[class]..alt5)
			EditMacro("WMPAlt+6",nil,nil,"/target [@boss3,exists,nodead,nomod:ctrl]\n/target [@arena3,exists,nodead,nomod:ctrl]\n/use [mod:ctrl,"..PoA.."3,nodead]"..ZA.aC[class]..alt6)
			EditMacro("WMPAlt+9",nil,nil,"/focus [@arena3,exists,nodead]\n/target [@boss6,exists]Boss6"..alt9)
			
			EditMacro("wWBGHealer1",nil,nil,"/use [bonusbar:5]Surge Forward(Skyriding);[mod:alt,@arena1,harm,nodead][mod:alt,@boss1,harm,nodead]"..ZA.altArenaDots[class]..";[mod:ctrl,@arena1,harm,nodead][mod:ctrl,@boss1,harm,nodead]"..ZA.ctrlArenaDots[class]..";[@arena1,harm,nodead][@boss1,harm,nodead]"..ZA.arenaDots[class])
			EditMacro("wWBGHealer2",nil,nil,"/use [bonusbar:5]Skyward Ascent(Skyriding);[mod:alt,@arena2,harm,nodead][mod:alt,@boss2,harm,nodead]"..ZA.altArenaDots[class]..";[mod:ctrl,@arena2,harm,nodead][mod:ctrl,@boss2,harm,nodead]"..ZA.ctrlArenaDots[class]..";[@arena2,harm,nodead][@boss2,harm,nodead]"..ZA.arenaDots[class])        
			EditMacro("wWBGHealer3",nil,nil,"/use [bonusbar:5]Whirling Surge(Skyriding);[mod:alt,@arena3,harm,nodead][mod:alt,@boss3,harm,nodead]"..ZA.altArenaDots[class]..";[mod:ctrl,@arena3,harm,nodead][mod:ctrl,@boss3,harm,nodead]"..ZA.ctrlArenaDots[class]..";[@arena3,harm,nodead][@boss3,harm,nodead]"..ZA.arenaDots[class])
			-- numpad 7-8-9
			EditMacro("wWBGHealer4",nil,nil,"/use [bonusbar:5]Bronze Timelock(Skyriding);[mod:alt,"..PoA.."1]"..ZA.numaltbuff789[class]..";[mod:ctrl,"..PoA.."1]"..ZA.numctrlbuff789[class]..";["..PoA.."1]"..ZA.numnomodbuff789[class])
			EditMacro("wWBGHealer5",nil,nil,"/use [bonusbar:5]Aerial Halt(Skyriding);[mod:ctrl,"..PoA.."2]"..ZA.numctrlbuff789[class]..";["..PoA.."2]"..ZA.numnomodbuff789[class])
			
			-- EditMacro("wWBGHealer4",nil,nil,"/use [mod:alt,@arena4,harm,nodead]"..ZA.altArenaDots[class]..";[@arena4,harm,nodead]"..ZA.arenaDots[class])

			-- shift+numpad 10-11-12
			EditMacro("wWBGHealerSet1",nil,nil,"/use [bonusbar:5]Second Wind(Skyriding);[mod:alt,"..PoA.."1]"..ZA.numaltbuff101112[class]..";[mod:ctrl,"..PoA.."1]"..ZA.numctrlbuff101112[class]..";["..PoA.."1]"..ZA.numnomodbuff101112[class])
			EditMacro("wWBGHealerSet2",nil,nil,"/use [mod:alt,"..PoA.."2]"..ZA.numaltbuff101112[class]..";[mod:ctrl,"..PoA.."2]"..ZA.numctrlbuff101112[class]..";["..PoA.."2]"..ZA.numnomodbuff101112[class])        
			EditMacro("wWBGHealerSet3",nil,nil,"/use [mod:alt,"..PoA.."3]"..ZA.numaltbuff101112[class]..";[mod:ctrl,"..PoA.."3]"..ZA.numctrlbuff101112[class]..";["..PoA.."3]"..ZA.numnomodbuff101112[class])

			EditMacro("wWBGHealerSet4",nil,nil,"/use [mod:alt,"..PoA.."1]"..ZA.modnumaltbuff789[class]..";[mod:ctrl,"..PoA.."2]"..ZA.modnumctrlbuff789[class]..";["..PoA.."1]"..ZA.modnumnomodbuff789[class])
			
			-- shift + 4-5-6
			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1,harm,nodead]"..(ZA.wmpaltpurge[class] or "")..";[mod:ctrl,@arena1,harm,nodead]"..(ZA.wmpctrlcc[class] or "")..";[@arena1,harm,nodead][@boss1,harm,nodead]"..(ZA.wmpnomodkick[class] or "")..";")
			EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2,harm,nodead]"..ZA.wmpaltpurge[class]..";[mod:ctrl,@arena2,harm,nodead]"..ZA.wmpctrlcc[class]..";[@arena2,harm,nodead][@boss2,harm,nodead]"..ZA.wmpnomodkick[class]..";")        
			EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3,harm,nodead]"..ZA.wmpaltpurge[class]..";[mod:ctrl,@arena3,harm,nodead]"..ZA.wmpctrlcc[class]..";[@arena3,harm,nodead][@boss3,harm,nodead]"..ZA.wmpnomodkick[class]..";")	
			
			-- om du är i en battleground, kollar inte om det är rated dock.
			if instanceType == "pvp" then
				EditMacro("wWBGHealerSet1",nil,nil,"/stopmacro [noexists]\n/run if not InCombatLockdown()then local A=UnitName(\"target\") EditMacro(\"wWBGHealer1\",nil,nil,\"/target \"..A, nil)print(\"Healer1 set to : \"..A)else print(\"Cannot change assist now!\")end")
				EditMacro("wWBGHealerSet2",nil,nil,"/stopmacro [noexists]\n/run if not InCombatLockdown()then local A=UnitName(\"target\") EditMacro(\"wWBGHealer2\",nil,nil,\"/target \"..A, nil)print(\"Healer2 set to : \"..A)else print(\"Cannot change assist now!\")end")        
				EditMacro("wWBGHealerSet3",nil,nil,"/stopmacro [noexists]\n/run if not InCombatLockdown()then local A=UnitName(\"target\") EditMacro(\"wWBGHealer3\",nil,nil,\"/target \"..A, nil)print(\"Healer3 set to : \"..A)else print(\"Cannot change assist now!\")end")
				-- EditMacro("wWBGHealerSet4",nil,nil,"/stopmacro [noexists]\n/run if not InCombatLockdown()then local A=UnitName(\"target\") EditMacro(\"wWBGHealer4\",nil,nil,\"/target \"..A, nil)print(\"Healer4 set to : \"..A)else print(\"Cannot change assist now!\")end")
				EditMacro("wWBGHealer1",nil,nil,"")
				EditMacro("wWBGHealer2",nil,nil,"")        
				EditMacro("wWBGHealer3",nil,nil,"")
				-- EditMacro("wWBGHealer4",nil,nil,"")
			-- om du är i ett dungeon eller raid
			elseif instanceType == "party" or instanceType == "raid" then
				EditMacro("wWBGHealer1",nil,nil,"/use [bonusbar:5]Surge Forward(Skyriding);[mod:alt,@boss1,harm,nodead]"..ZA.altArenaDots[class]..";[@boss1,harm,nodead]"..ZA.arenaDots[class])
				EditMacro("wWBGHealer2",nil,nil,"/use [bonusbar:5]Skyward Ascent(Skyriding);[mod:alt,@boss2,harm,nodead]"..ZA.altArenaDots[class]..";[@boss2,harm,nodead]"..ZA.arenaDots[class])        
				EditMacro("wWBGHealer3",nil,nil,"/use [bonusbar:5]Whirling Surge(Skyriding);[mod:alt,@boss3,harm,nodead]"..ZA.altArenaDots[class]..";[@boss3,harm,nodead]"..ZA.arenaDots[class])	
				EditMacro("wWBGHealer4",nil,nil,"/use [bonusbar:5]Bronze Timelock(Skyriding)\n/cleartarget")
				EditMacro("wWBGHealer5",nil,nil,"/use [bonusbar:5]Aerial Halt(Skyriding);[mod:ctrl,"..PoA.."2]"..ZA.numctrlbuff789[class]..";["..PoA.."2]"..ZA.numnomodbuff789[class])
				EditMacro("wWBGHealer6",nil,nil,"/use [mod:alt,"..PoA.."4]"..ZA.numaltbuff101112[class]..";[mod:ctrl,"..PoA.."4]"..ZA.numctrlbuff101112[class]..";["..PoA.."4]"..ZA.numnomodbuff101112[class])				-- shift+numpad 10-11-12
				-- EditMacro("wWBGHealer6",nil,nil,"/cleartarget")
				EditMacro("wWBGHealerSet1",nil,nil,"/use [bonusbar:5]Second Wind(Skyriding);[mod:alt,"..PoA.."1]"..ZA.numaltbuff101112[class]..";[mod:ctrl,"..PoA.."1]"..ZA.numctrlbuff101112[class]..";["..PoA.."1]"..ZA.numnomodbuff101112[class])
				EditMacro("wWBGHealerSet2",nil,nil,"/use [mod:alt,"..PoA.."2]"..ZA.numaltbuff101112[class]..";[mod:ctrl,"..PoA.."2]"..ZA.numctrlbuff101112[class]..";["..PoA.."2]"..ZA.numnomodbuff101112[class])        
				EditMacro("wWBGHealerSet3",nil,nil,"/use [mod:alt,"..PoA.."3]"..ZA.numaltbuff101112[class]..";[mod:ctrl,"..PoA.."3]"..ZA.numctrlbuff101112[class]..";["..PoA.."3]"..ZA.numnomodbuff101112[class])
				EditMacro("wWBGHealerSet6",nil,nil,"/use [mod:alt,"..PoA.."4]"..ZA.numaltbuff101112[class]..";[mod:ctrl,"..PoA.."4]"..ZA.numctrlbuff101112[class]..";["..PoA.."4]"..ZA.numnomodbuff101112[class])

			-- shift+numpad 10-11-12
			-- EditMacro("wWBGHealerSet1",nil,nil,"/use [bonusbar:5]Second Wind(Skyriding);[mod:alt,"..PoA.."1]"..ZA.numaltbuff101112[class]..";[mod:ctrl,"..PoA.."1]"..ZA.numctrlbuff101112[class]..";["..PoA.."1]"..ZA.numnomodbuff101112[class])
				-- EditMacro("wWBGHealerSet4",nil,nil,"/use [mod:alt,"..PoA.."4]"..ZA.numaltbuff789[class]..";[mod:ctrl,"..PoA.."4]"..ZA.numctrlbuff789[class]..";["..PoA.."4]"..ZA.numnomodbuff789[class])
				-- EditMacro("wWBGHealerSet6",nil,nil,"/use [mod:alt,"..PoA.."6]"..ZA.numaltbuff789[class]..";[mod:ctrl,"..PoA.."6]"..ZA.numctrlbuff789[class]..";["..PoA.."6]"..ZA.numnomodbuff789[class])
			end
			--DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Talent change detected! :)",0.5,1.0,0.0)
			if ZA.cov[slBP] == "Kyrian" then
				poS = "\n/use [mod]item:177278"
				sigA = "Summon Steward"
			-- Necrolord, "Fleshcraft" 
			elseif ZA.cov[slBP] == "Necrolord" then
				poS = ""
				sigA = "Fleshcraft"
			-- Night Fae, "Soulshape"
			elseif ZA.cov[slBP] == "Night Fae" then
				poS = ""
				sigA = "Soulshape"
			-- Venthyr, "Door of Shadows"
			elseif ZA.cov[slBP] == "Venthyr" then
				poS = ""
				sigA = "Door of Shadows"
			end
			-- print(ZA.covTable[cov])
			-- print(ZA.cov[slBP])
			-- print(ZA.covTable[ZA.cov[slBP]])
			-- print(ZA.covTable[ZA.cov[slBP]][class])
			-- print("covA", covA)
			if ZA.cov[slBP] ~= "" and ZA.covTable[ZA.cov[slBP]] ~= "" and ZA.covTable[ZA.cov[slBP]][class] ~= "" then
				covA = ZA.covTable[ZA.cov[slBP]][class]
				-- print("covA = ",covA) 
			end
			-- print("covA", covA)
			-- hard exceptions
			if class == "EVOKER" then 
				covA = "Boon of the Covenants"
			end
		 
		    -- Class Artifact Button, "§" Completed, note: Kanske kan hooka Heart Essence till fallback från Cov och Signature Ability? Sedan behöver vi hooka Ritual of Doom till Warlock Order Hall också.
			-- Covenant and Signature Ability parser
			-- Kyrian, "Summon Steward", phial of serenity
			for i,v in pairs(usableWeapons) do
				if IsEquippedItem(v) == true then
					usableWeaponEquipped = v
				end
			end
				
			if sigA then
				sigB = "[@mouseover,exists,nodead,mod][@cursor,mod]"..sigA
			end
			if covA then 
				covB = "[@mouseover,exists,nodead][@cursor]"..covA..poS
			end
			if hoaEq then
				hoaEq = "[@mouseover,exists,nodead][@cursor]Heart Essence"
			end
			if PlayerGetTimerunningSeasonID() == 1 then
				covA = pandaremixSpecial("throughputAbilities") or ""
				sigA = pandaremixSpecial("movementAbilties") or ""
				sigB = "[@mouseover,exists,nodead,mod][@cursor,mod]"..sigA
				covB = "[@mouseover,exists,nodead][@cursor]"..covA
				slBPGen = sigB..";"..covB
				if ZG.Item_Count("Timeless Scroll of Cleansing") >= 1 then
					EditMacro("PvPAT 1" , nil, 4549192, "/stopspelltarget\n/stopspelltarget\n/use [@mouseover,exists,nodead,nomod][@cursor,nomod]Timeless Scroll of Cleansing")
				end
				if ZG.Item_Count("Timeless Scroll of Summoning") >= 1 then
					EditMacro("PvPAT 2" , nil, 4549182, "/stopspelltarget\n/stopspelltarget\n/use [@mouseover,exists,nodead,nomod][@cursor,nomod]Timeless Scroll of Summoning")
				end
				if ZG.Item_Count("Drake Treat") >= 1 then
					EditMacro("PvPAT 3" , nil, 132165, "/stopspelltarget\n/stopspelltarget\n/use [@mouseover,exists,nodead,nomod][@cursor,nomod]Drake Treat")
				end
				pwned = pandaremixSpecial("resItem") or ""
			elseif ((slBP == 2 and class == "WARRIOR") and IsEquippedItem("Heart of Azeroth") and not ZG.slZones[z]) then
				sigA = "The Golden Banana"
				if class == "WARRIOR" then
					sigA = (Get_Spell({{"Demolish","",""},{"Odyn's Fury","",""},{"Skullsplitter","",""},{"Shield Charge","",""},}) or sigA)
				end
				sigB = "[@mousever,exists,nodead,mod][@cursor,mod]"..sigA
				slBPGen = sigB..";"..hoaEq
			-- elseif (slBP == 2 and class == "WARRIOR") then 
			-- 	hoaEq = "13"
			-- 	slBPGen = sigB..";"..hoaEq
			elseif (IsEquippedItem("Heart of Azeroth") and (not ZG.slZones[z])) then
				covA = "Murglasses"
				sigA = "The Golden Banana"
				if class == "WARRIOR" then
					covA = (Get_Spell({{"Champion's Spear","",""},{"Odyn's Fury","",""},}) or covA)
					sigA = (Get_Spell({{"Demolish","",""},{"Odyn's Fury","",""},{"Skullsplitter","",""},{"Shield Charge","",""},}) or sigA)
				elseif class == "EVOKER" then
					sigA = usableWeaponEquipped
				end
				if slBP == 3 then
					sigA = "Seed of Renewed Souls"
				end
				sigB = "[@mouseover,exists,nodead,mod][@cursor,mod]"..sigA
				slBPGen = sigB..";"..hoaEq
			elseif (slBP and not ZG.slZones[z]) then
			-- elseif (slBP ~= 0 and not ZG.slZones[z]) then
				sigA = "The Golden Banana"
				covA = "Murglasses"
				if slBP == 3 then
					sigA = "Seed of Renewed Souls"
				end
				if class == "SHAMAN" then
					covA = (Get_Spell({{"Liquid Magma Totem","",""},{"Ancestral Swiftness","",""},{"Nature's Swiftness","",""},{"Primordial Wave(Shadowlands)","",""},{"Primordial Wave","",""},{"Primordial Wave(Necrolord)","",""},{"Doom Winds","",""},}) or covA) 
					sigA = (Get_Spell({{"Healing Tide Totem","",""},{"Ancestral Swiftness","",""},{"Nature's Swiftness","",""},{"Primordial Wave(Shadowlands)","",""},{"Primordial Wave","",""},{"Primordial Wave(Necrolord)","",""},}) or sigA)
				elseif class == "MAGE" then
					covA = (Get_Spell({{"Meteor","",""},{"Glacial Spike","",""},{"Mirror Image","",""},}) or covA) 
					sigA = (Get_Spell({{"Shifting Power","",""},{"Mirror Image","",""},{"Cold Snap","",""},{"Meteor","",""},}) or sigA)
				elseif class == "WARLOCK" then
					covA = (Get_Spell({{"Malevolence","",""},{"Summon Soulkeeper","",""},{"Soul Rot","",""},{"Guillotine","",""},{"Dimensional Rift","",""},{"Soulburn","",""},}) or covA)
					sigA = (Get_Spell({{"Soul Rot","",""},{"Dimensional Rift","",""},{"Guillotine","",""},{"Malevolence","",""},{"Summon Soulkeeper","",""},{"Inquisitor's Gaze","",""},{"Create Healthstone","",""},{"Summon Imp","",""},}) or sigA)
				elseif class == "MONK" then
					covA = (Get_Spell({{"Exploding Keg","",""},{"Sheilun's Gift","",""},{"Bonedust Brew","",""},{"Jadefire Stomp","",""},{"Strike of the Windlord","",""},}) or covA)
					sigA = (Get_Spell({{"Weapons of Order","",""},{"Jadefire Stomp","",""},{"Bonedust Brew","",""},{"Whirling Dragon Punch","",""},{"Sheilun's Gift","",""},}) or sigA)
				elseif class == "PALADIN" then
					covA = (Get_Spell({{"Blessing of Summer","",""},{"Divine Toll","",""},}) or covA)
					sigA = (Get_Spell({{"Divine Toll","",""},{"Blessing of Summer","",""},}) or sigA)
				elseif class == "HUNTER" then
					covA = (Get_Spell({{"Spearhead","",""},{"Black Arrow","",""},{"Barrage","",""},{"Stampede","",""},}) or covA)
					sigA = (Get_Spell({{"High Explosive Trap","",""},{"Implosive Trap","",""},}) or sigA)
				elseif class == "ROGUE" then
					covA = (Get_Spell({{"Echoing Reprimand","",""},{"Goremaw's Bite"},{"Kingsbane","",""},}) or covA)
					sigA = (Get_Spell({{"Thistle Tea","",""},{"Echoing Reprimand","",""},{"Cold Blood","",""},{"Serrated Bone Spike","",""},{"Ghostly Strike","",""},{"Sepsis","",""},{"Flagellation","",""},{"Goremaw's Bite","",""},}) or sigA)
				elseif class == "PRIEST" then
					covA = (Get_Spell({{"Premonition","",""},{"Void Torrent","",""},{"Mindgames","",""},{"Power Word: Life","",""},{"Apotheosis","",""},}) or covA)
					sigA = (Get_Spell({{"Void Shift","",""},{"Void Torrent","",""},{"Holy Word: Chastise","",""},{"Rapture","",""},}) or sigA)
				elseif class == "DEATHKNIGHT" then
					covA = (Get_Spell({{"Reaper's Mark","",""},{"Blood Tap","",""},{"Abomination Limb","",""},{"Empower Rune Weapon","",""},}) or covA)
					sigA = (Get_Spell({{"Abomination Limb","",""},{"Rune Tap","",""},{"Horn of Winter","",""},{"Empower Rune Weapon","",""},}) or sigA)
				elseif class == "WARRIOR" then
					covA = (Get_Spell({{"Champion's Spear","",""},{"Odyn's Fury","",""},}) or covA)
					sigA = (Get_Spell({{"Demolish","",""},{"Odyn's Fury","",""},{"Skullsplitter","",""},{"Shield Charge","",""},}) or sigA)
				elseif class == "DRUID" then
					covA = (Get_Spell({{"Adaptive Swarm","",""},{"Rage of the Sleeper","",""},{"Convoke the Spirits","",""},}) or covA)
					sigA = (Get_Spell({{"Astral Communion","",""},{"Fluid Form","Mangle;",""},{"Convoke the Spirits","",""},{"Adaptive Swarm","",""},}) or sigA)
					if sigA == "Mangle;Fluid Form" then
						sigA = "Mangle"
					end
				elseif class == "DEMONHUNTER" then
					covA = (Get_Spell({{"Fel Barrage","",""},{"Sigil of Spite","",""},{"Glaive Tempest","",""},{"Soul Carver","",""},}) or covA)
					sigA = (Get_Spell({{"Soul Carver","",""},{"Immolation Aura","",""},}) or sigA)
				elseif class == "EVOKER" then
					covA = Get_Spell({{"Engulf","";""},{"Deep Breath","!",""},}) or covA
					sigA = usableWeaponEquipped
				end
				sigB = "[@mouseover,exists,nodead,mod][@cursor,mod]"..sigA
				covB = "[@mouseover,exists,nodead][@cursor]"..covA..poS
				slBPGen = sigB..";"..covB
			elseif slBP ~= 0 then 
				slBPGen = sigB..";"..covB
			else
				slBPGen = "13"
			end
			if class == "MAGE" then 
				hasHE = "\n/use Mirror Image" 
			end
			
			--alt+6 mods
			if (IsEquippedItem("Heart of Azeroth") and (not ZG.slZones[z])) then
				hoaEq = "\n/stopspelltarget\n/stopspelltarget\n/use [mod,@player][@mouseover,exists,nodead][@cursor]Heart Essence"
				if class == "MAGE" then
					hasHE = "\n/castsequence Mirror Image, Heart Essence"
				else
					hasHE = "\n/use Heart Essence" 
				end
			elseif class == "SHAMAN" then 
				hoaEq = (Get_Spell({{"Spirit Link Totem","",""},{"Spiritwalker's Grace","",""},{"Far Sight","",""},}) or "Farwater Conch")
			elseif class == "MAGE" then
				hoaEq = (Get_Spell({{"Mass Polymorph","",""},{"Polymorph","",""},}) or "Mage's Chewed Wand")
			elseif class == "WARLOCK" then
				hoaEq = Get_Spell("Demonic Gateway") or ""
			elseif class == "MONK" then 
				hoaEq = (Get_Spell({{"Song of Chi-Ji"},{"Ring of Peace","",""},}) or "")
			elseif class == "PALADIN" then 
				hoaEq = Get_Spell("Divine Steed") or ""
			elseif class == "HUNTER" then 
				hoaEq = Get_Spell("Misdirection") or ""
			elseif class == "ROGUE" then 
				hoaEq = "Shroud of Concealment"
			elseif class == "PRIEST" then 
				hoaEq = (Get_Spell({{"Evangelism","",""},{"Mind Soothe","",""},}) or "")
			elseif class == "DEATHKNIGHT" then 
				hoaEq = (Get_Spell({{"Wraith Walk","",""},{"Anti-Magic Zone","",""},}) or "")
			elseif class == "WARRIOR" then 
				hoaEq = Get_Spell("Piercing Howl") or ""
			elseif class == "DRUID" then 
				hoaEq = (Get_Spell({{"Ursol's Vortex","",""},{"Mass Entanglement","",""},{"Barkskin","";""}}) or "Primal Stave of Claw and Fur")
			elseif class == "DEMONHUNTER" then 
				hoaEq = "Shattered Souls"
			elseif class == "EVOKER" then 
				hoaEq = Get_Spell({{"Oppressing Roar","",""},{"Obsidian Scales","",""},}) or ""
			end
	
			EditMacro("WArtifactCDs",nil,nil,"#show\n/stopspelltarget\n/stopspelltarget\n/cast "..itemBuilder("resItem")..slBPGen)
			EditMacro("WSxCAGen+§",nil,nil,"/cast [@player,mod:shift]"..sigA..";[@player][@mouseover,exists,nodead][@cursor]"..covA)
			if IsEquippedItem("Nymue's Unraveling Spindle") and IsEquippedItem("Kharnalex, The First Light") then 
				EditMacro("WSxAGen+4",nil,nil,"#showtooltip\n/castsequence reset=10 13,16")
			else
				EditMacro("WSxAGen+4",nil,nil,"#showtooltip 13\n/use [@mouseover,exists,nodead][@cursor][]13\n/use [@mouseover,exists,nodead][@cursor][]16")
			end			
			EditMacro("Wx1Trinkit",nil,nil,"#show "..hoaEq.."\n/use [nocombat,noexists]Wand of Simulated Life\n/use Attraction Sign\n/use Rallying War Banner"..pennantClass.."")

			if class == "SHAMAN" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@mouseover,help,nodead][nomod:alt]Water Walking\n/use [swimming,nomod:alt]Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")   
			elseif class == "MAGE" then 
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@mouseover,help,nodead][noswimming]Slow Fall;Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")
			elseif class == "WARLOCK" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@focus,harm,nodead,mod:alt][@mouseover,harm,nodead][harm,nodead]Banish;[@mouseover,help,nodead][]Unending Breath\n/use [mod:alt]Stylish Black Parasol")
			elseif class == "MONK" then 
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem;!Zen Flight\n/use [mod:alt]Delicate Jade Parasol\n/use Mystical Orb of Meditation")
			elseif class == "PALADIN" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";"..(Get_Spell("Turn Evil","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";") or "").."[swimming]Barnacle-Encrusted Gem\n/use [nomod:alt]Seafarer's Slidewhistle\n/use [mod:alt]Weathered Purple Parasol")
			elseif class == "HUNTER" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@mouseover,harm,nodead][harm,nodead]Scare Beast;[nopet]Call Pet 1;[swimming]Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")
			elseif class == "ROGUE" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem;Survivor's Bag of Coins\n/use [mod:alt]Weathered Purple Parasol")	
			elseif class == "PRIEST" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming,noexists,nocombat]Barnacle-Encrusted Gem;Levitate\n/use [nomod:alt]Seafarer's Slidewhistle\n/use [mod:alt]Weathered Purple Parasol")
			elseif class == "DEATHKNIGHT" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[nomod:alt]Path of Frost\n/use [swimming]Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")
			elseif class == "WARRIOR" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[nomod:alt]Heroic Leap\n/use [swimming]Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")
			elseif class == "DRUID" then
	 			EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";"..(Get_Spell("Moonkin Form","[noform:4]",";!Flap;") or "")..(Get_Spell("Wild Charge","[noform]Mount Form;[form]",";") or "").."\n/cancelform [form:1/2]\n/cancelaura Prowl\n/use [mod:alt]Weathered Purple Parasol")				
			elseif class == "DEMONHUNTER" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem\n/use Prismatic Bauble\n/use !Glide\n/use [mod:alt]Weathered Purple Parasol\n/dismount [mounted]")
			elseif class == "EVOKER" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem\n/use Prismatic Bauble\n/use !Glide\n/use [mod:alt]Weathered Purple Parasol\n/dismount [mounted]")
			end
		end

		-- consumablebuilder(bladlast
		if (event == "TRAIT_CONFIG_UPDATED" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "BAG_UPDATE_DELAYED" or event == "UNIT_PET" or event == "PLAYER_ENTERING_WORLD" or event == "LEARNED_SPELL_IN_SKILL_LINE") then
			
			EditMacro("WSxBladlast",nil,nil,"#show\n/use "..consumableBuilder("bladlast",faction))
			-- #show Bloodlust, Time Warp, Netherwinds, Drums and Favorite mount - Ctrl+Shift+V
			if class == "PRIEST" then				
				EditMacro("WSxFavMount",nil,nil,"#show " ..consumableBuilder("bladlast",faction).. "\n/run if not IsMounted() then C_MountJournal.SummonByID(0) end\n/cast [mounted]Switch Flight Style\n/dismount [mounted]\n/cancelaura Flaming Hoop\n/use Celebration Firework")
			elseif class == "DRUID" then
				EditMacro("WSxFavMount",nil,nil,"#show " ..consumableBuilder("bladlast",faction).. "\n/run if not IsMounted() then C_MountJournal.SummonByID(0) end\n/cast [mounted]Switch Flight Style\n/dismount [mounted]\n/cancelform\n/cancelaura Flaming Hoop\n/use Celebration Firework")
			elseif class == "MONK" then
				EditMacro("WSxFavMount",nil,nil,"#show " ..consumableBuilder("bladlast",faction).. "\n/run if not IsMounted() then C_MountJournal.SummonByID(0) end\n/cast [mounted]Switch Flight Style\n/dismount [mounted]\n/cancelaura Zen Flight\n/cancelaura Flaming Hoop\n/use Celebration Firework")
			else
				EditMacro("WSxFavMount",nil,nil,"#show " ..consumableBuilder("bladlast",faction).. "\n/run if not IsMounted() then C_MountJournal.SummonByID(0) end\n/cast [mounted]Switch Flight Style\n/dismount [mounted]\n/cancelaura Flaming Hoop\n/use Celebration Firework\n/cancelaura Stealth\n/cancelform")
			end
			if class == "HUNTER" then
				EditMacro("WSxGenR",nil,nil,"/stopspelltarget\n/use "..(Get_Spell("Tar Trap","[mod:shift,@mouseover,exists,nodead][mod:shift,@cursor]",";") or "")..Get_Pet_Spell("Master's Call","[mod:ctrl,@player][@mouseover,help,nodead,nomod][help,nodead,nomod]",";")..Get_Pet_Spell("Fortitude of the Bear","[mod:ctrl]",";").."[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Wing Clip\n/targetenemy [noharm]")
			end
		end

		-- itembuilder, consumablebuilder
		if (event == "BAG_UPDATE_DELAYED" or event == "ZONE_CHANGED_NEW_AREA" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD" or event == "LEARNED_SPELL_IN_SKILL_LINE") then							
			EditMacro("Wx3ShowPot", nil, "INV_MISC_QUESTIONMARK", nil, 1, 1)
			-- is World Shrinker usable?
			usable = C_ToyBox.IsToyUsable(109183)
			if usable == false then 
				usable = "Vrykul Drinking Horn"
				EditMacro("Wx3ShowPot",nil, nil,"#showtooltip "..consumableBuilder("potion")..consumableBuilder("potion","\n/use ","\n/use Hell-Bent Bracers\n/use "..usable.."\n/doom"))
			else 
				usable = "World Shrinker" 
				EditMacro("Wx3ShowPot",nil, nil,"#showtooltip "..consumableBuilder("potion")..consumableBuilder("potion","\n/use "..usable.."\n/use ","\n/use Hell-Bent Bracers\n/doom"))
			end
			if ZG.Item_Count(consumableBuilder("potion")) < 1 then
				EditMacro("Wx3ShowPot", nil, 132380, "#show\n/oops", 1, 1)
			end
			EditMacro("WTonic",nil,nil,"#show [mod:shift]"..itemBuilder("fartToy",slBP)..";"..consumableBuilder("tonic").."\n/use "..itemBuilder("fartToy",slBP).."\n/use "..consumableBuilder("tonic").."\n/use Eternal Black Diamond Ring")
			EditMacro("WSxCGen+J",nil,nil,"#show\n/use "..consumableBuilder("invispot"))
		    EditMacro("Wx2Garrisons",nil,nil,"#show\n/use [nocombat,noexists,nomod:alt]Mobile Banking(Guild Perk);[mod:shift]Narcissa's Mirror;"..consumableBuilder("nimblebrew"))
			if ZG.Item_Count(consumableBuilder("water")) > 0 then
				EditMacro("WWeyrnstone",nil,nil,consumableBuilder("water","/use "))
			else
				EditMacro("WWeyrnstone",nil,nil,"/use Whispers of Rai'Vosh\n/helpme")
			end
			if ZG.Item_Count("Weyrnstone") >= 1 then
				EditMacro("WWeyrnstone",nil,nil,"/use Weyrnstone\n/run PlaySound(15160)")
			end
			EditMacro("WFirstAid",nil,nil,"/run local c,g = GetTitleName(GetCurrentTitle()),GetCurrentTitle() if not((c == \"Field Medic\") or (g == 372)) then SetTitleByName(\"Field Medic\") end\n/use "..consumableBuilder("bandages",""))
			if ZG.Item_Count("Healthstone") >= 1  then
				EditMacro("WShow",nil,nil,"/use "..consumableBuilder("water","[mod:alt,nocombat]",";")..consumableBuilder("manapot","[mod:alt]",";")..((hsBuilder("HS","[mod:ctrl]",";",class, slBP, z, eLevel, playerSpec, race, playerName) or "") or "").."Healthstone\n/stopmacro [mod]"..((hsBuilder("hsToy","","",class, slBP, z, eLevel, playerSpec, race, playerName) or "") or "").."\n/run HSAction()")
			elseif ZG.Item_Count("Demonic Healthstone") >= 1  then
				EditMacro("WShow",nil,nil,"/use "..consumableBuilder("water","[mod:alt,nocombat]",";")..consumableBuilder("manapot","[mod:alt]",";")..((hsBuilder("HS","[mod:ctrl]",";",class, slBP, z, eLevel, playerSpec, race, playerName) or "") or "").."Demonic Healthstone\n/stopmacro [mod]"..((hsBuilder("hsToy","","",class, slBP, z, eLevel, playerSpec, race, playerName) or "") or "").."\n/run HSAction()")
			else
				EditMacro("WShow",nil,nil,"/use "..consumableBuilder("water","[mod:alt,nocombat]",";")..consumableBuilder("manapot","[mod:alt]",";")..((hsBuilder("HS","[mod:ctrl]",";",class, slBP, z, eLevel, playerSpec, race, playerName) or "") or "").."\n/stopmacro [mod]"..((hsBuilder("hsToy","","",class, slBP, z, eLevel, playerSpec, race, playerName) or "") or "").."\n/use Healthstone\n/use Demonic Healthstone\n/run HSAction()", 1, 1)
			end  
			if class == "SHAMAN" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Ancestral Spirit;"..pwned.."\n/use [mod:ctrl]Ancestral Vision"..itemBuilder("brazier"))
			elseif class == "MAGE" then
				EditMacro("WSxGen5",nil,nil,"/stopspelltarget [@mouseover,harm,nodead][harm,nodead][exists,nodead]\n/targetenemy [noexists]\n/use "..(Get_Spell("Alter Time", "[mod]!",";") or "")..(Get_Spell({{"Arcane Barrage","[@mouseover,harm,nodead][harm,nodead]",";"},{"Ice Lance","[@mouseover,harm,nodead][harm,nodead]",";"},{"Fire Blast","[@mouseover,harm,nodead][harm,nodead]",";"},}) or "")..itemBuilder("broom")..(Get_Spell({{"Arcane Barrage","",";"},{"Ice Lance","",";"},{"Fire Blast","",";"},}) or ""))
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;"..itemBuilder("crKnife")..pwned..""..itemBuilder("brazier"))
				EditMacro("WSxSGen+1",nil,nil,"#showtooltip Alter Time\n/run ConsumableTrader(\""..consumableBuilder("water").."\")")
				EditMacro("WSxSGen+2",nil,nil,"#show "..(Get_Spell("Presence of Mind","[combat][harm,nodead]",";") or "")..consumableBuilder("water").."\n/use [nocombat,noexists]"..consumableBuilder("water").."\n/use Gnomish X-Ray Specs\n/stopcasting [spec:2]\n/use "..(Get_Spell("Presence of Mind","[combat][harm,nodead]",";") or "").."[nocombat]Conjure Refreshment")
				EditMacro("WSxGenU",nil,nil,"#showtooltip\n/use "..consumableBuilder("managem"))
				EditMacro("WSxSGen+F",nil,nil,"#show Familiar Stone\n/cancelaura [mod:alt]Shado-Pan Geyser Gun\n/use [help,nocombat,mod:alt]B. F. F. Necklace;[nocombat,noexists,mod:alt]Gastropod Shell;[nomod:alt]"..consumableBuilder("managem").."\n/use [nomod:alt]Familiar Stone")
			elseif class == "WARLOCK" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;"..itemBuilder("crKnife")..pwned..""..itemBuilder("brazier"))
			elseif class == "MONK" then 
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Resuscitate;"..pwned.."\n/use [mod:ctrl]Reawaken"..itemBuilder("brazier"))
			elseif class == "PALADIN" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Redemption;"..pwned.."\n/use [mod:ctrl]Absolution"..itemBuilder("brazier"))
				EditMacro("WSxCAGen+F",nil,nil,(Get_Spell({{"Blessing of Summer","/targetfriendplayer\n/use [help,nodead]",";Languages\n/targetlasttarget"},{"Blessing of Freedom","/targetfriendplayer\n/use [help,nodead]",";Languages\n/targetlasttarget"},}) or "").."\n/stopmacro [combat,exists]"..itemBuilder("instrument",noPants))
			elseif class == "HUNTER" then
				EditMacro("WSxGen3",nil,nil,"/targetlasttarget [noexists,nocombat,nodead]\n/use "..(Get_Spell("Kill Shot","[@mouseover,harm,nodead][harm,nodead]",";") or "")..((itemBuilder("flyingSkinner") or "") or "").."Imaginary Gun\n/targetenemy [noharm]\n/cleartarget [dead]"..((itemBuilder("inject",class,playerSpec) or "") or "").."\n/targetlasttarget [dead]")
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;"..itemBuilder("crKnife")..pwned..""..itemBuilder("brazier"))
			elseif class == "ROGUE" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;"..itemBuilder("crKnife")..pwned..""..itemBuilder("brazier"))
			elseif class == "PRIEST" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Resurrection;"..pwned.."\n/use [mod:ctrl]Mass Resurrection"..itemBuilder("brazier"))
			elseif class == "DEATHKNIGHT" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;"..itemBuilder("crKnife")..pwned..""..itemBuilder("brazier"))
				EditMacro("WSxCAGen+F",nil,nil,"#show Lichborne"..itemBuilder("instrument",noPants))
			elseif class == "WARRIOR" then
				if playerSpec ~= 3 and Get_Spell("Thunder Clap") == "Thunder Clap" then override = "Thunder Clap"
				elseif Get_Spell("Bladestorm") then override = "Bladestorm"	
				elseif Get_Spell("Sweeping Strikes") then override = "Sweeping Strikes"
				elseif playerSpec == 3 then override = "Whirlwind"
				else override = "Slam"
				end
				EditMacro("WSxGen7",nil,nil,"/use [mod]Shield Block;"..override.."\n/use "..(Get_Spell("Defensive Stance","[mod,nostance:1]!","") or "").."\n/startattack"..(itemBuilder("inject",class,playerSpec) or "") or "")
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;"..itemBuilder("crKnife")..pwned..""..itemBuilder("brazier"))
				EditMacro("WSxCAGen+F",nil,nil,"#show "..(Get_Spell("Rallying Cry","[]","") or "").."\n/use [nocombat]Throbbing Blood Orb\n/stopmacro [combat,exists]"..itemBuilder("instrument",noPants))
				EditMacro("WSxGenZ",nil,nil,"/use "..(Get_Spell("Defensive Stance","[mod:alt][mod:shift]!",";") or "").."[mod:shift]Shield Block;"..(Get_Spell({{"Die by the Sword","",""},{"Enraged Regeneration","",""},{"Shield Wall","",""},}) or "")..(itemBuilder("inject",class,playerSpec) or "").."\n/use Stormforged Vrykul Horn\n/use [mod:alt]Gateway Control Shard")
			elseif class == "DRUID" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant\n/cancelaura Flap"..itemBuilder("glider")..";[mod]6;[nocombat]Revive;"..pwned.."\n/use [mod:ctrl]Revitalize"..itemBuilder("brazier"))
			elseif class == "DEMONHUNTER" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant\n/cancelaura Glide"..itemBuilder("glider")..";[mod]6;"..itemBuilder("crKnife")..pwned..""..itemBuilder("brazier"))
			elseif class == "EVOKER" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant\n/cancelaura Glide"..itemBuilder("glider")..";[mod]6;[nocombat]Return;"..pwned.."\n/use [mod:ctrl]Mass Return"..itemBuilder("brazier"))
			end
		end

		--grouprosterbuilder, group roster update or spec talent change or on load
		if (event == "GROUP_ROSTER_UPDATE" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD" or event == "LEARNED_SPELL_IN_SKILL_LINE") then
			override = ""
			overrideModCtrl = ""
			overrideModAlt = ""
			if class == "SHAMAN" then
				EditMacro("WSxGenX",nil,nil,"/use "..(Get_Spell({{"Thunderstrike Ward","[mod:alt]",";"},{"Windfury Weapon","[mod:alt]",";"},{"Earthliving Weapon","[mod:alt]",";"},{"Tidecaller's Guard","[mod:alt]",";"},}) or "").."[mod:ctrl]Astral Recall;"..(Get_Spell({{"Spirit Walk","[mod:shift]",";"},{"Spiritwalker's Grace","[mod:shift]",";"},}) or "")..(Get_Spell({{"Earth Shield","[@mouseover,help,nodead]["..groupRosterBuilder("tank").."][]",""},{"Lightning Shield","",""},}) or "").."\n/use Void Totem\n/use Deceptia's Smoldering Boots")
			-- elseif class == "MAGE" then 
			-- elseif class == "WARLOCK" then
			elseif class == "MONK" then 
				EditMacro("WSxGenH",nil,nil,"#show "..(Get_Spell("Paralysis") or "Leg Sweep").."\n/use "..(Get_Spell("Life Cocoon","[mod:shift,"..groupRosterBuilder("tank").."]",";") or "")..(Get_Spell("Healing Elixir","","") or "").."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
			elseif class == "PALADIN" then
				EditMacro("WSxGenX",nil,nil,"#show\n/use "..(Get_Spell({{"Retribution Aura","[mod:alt]!",";"},{"Concentration Aura","[mod:alt]!",";"},}) or "")..(Get_Spell("Blessing of Freedom","[mod:shift]",";") or "")..(Get_Spell({{"Barrier of Faith","[@mouseover,help,nodead]["..groupRosterBuilder("tank").."][]",""},{"Divine Favor","",""},{"Hand of Divinity","",""},{"Ardent Defender","",""},{"Shield of Vengeance","",""},{"Lay on Hands","[@mouseover,help,nodead][]",""},}) or ""))
				if playerSpec == 2 and Get_Spell("Blessing of Sacrifice") then 
					override = "["..groupRosterBuilder("healer").."][]Blessing of Sacrifice"
				elseif Get_Spell("Blessing of Sacrifice") then 
					override = "["..groupRosterBuilder("tank").."][]Blessing of Sacrifice"
				end
				EditMacro("WSxGenC",nil,nil,"/use "..(Get_Spell({{"Repentance","[mod:ctrl,@mouseover,harm,nodead][mod:ctrl]",";"},{"Turn Evil","[mod:ctrl,@mouseover,harm,nodead][mod:ctrl]"},}) or "")..(Get_Spell({{"Blessing of Summer","[mod:shift,known:Blessing of Spring][mod:shift,known:Blessing of Winter][mod:shift,known:Blessing of Spring,"..groupRosterBuilder("tank").."]",";"},{"Blessing of Spellwarding","[mod:shift,"..groupRosterBuilder("healer").."]",";"},{"Blessing of Protection","[mod:shift,"..groupRosterBuilder("healer").."]",";"},}) or "Holy Lightsphere")..override)
			-- elseif class == "HUNTER" then
			-- elseif class == "ROGUE" then
			elseif class == "PRIEST" then
				EditMacro("WSxGenF",nil,nil,"#show "..(Get_Spell({{"Void Shift","",""},{"Power Word: Life","",""},}) or "").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod,exists,nodead]Mind Vision;[mod]Farwater Conch;"..(Get_Spell({{"Pain Suppression","["..groupRosterBuilder("tank").."]",";"},{"Guardian Spirit","["..groupRosterBuilder("tank").."]",";"},{"Silence","[@focus,harm,nodead]",";"},}) or "").."[help,nodead]True Love Prism;Doomsayer's Robes")
			-- elseif class == "DEATHKNIGHT" then
			elseif class == "WARRIOR" then
				EditMacro("WSxGenC",nil,nil,"#show\n/use "..(Get_Spell("Intimidating Shout","[mod:ctrl]",";") or "")..(Get_Spell("Intervene","[mod:shift,"..groupRosterBuilder("healer").."]",";") or "")..(Get_Spell("Spell Reflection") or "").."\n/use Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
			elseif class == "DRUID" then
				EditMacro("WSxGenH",nil,nil,"#show "..(Get_Spell({{"Nature's Swiftness","",""},{"Ironbark","",""},}) or "").."\n/use "..(Get_Spell({{"Ironbark","["..groupRosterBuilder("tank").."]",""},{"Nature's Swiftness","",""},}) or "").."\n/use Wisp Amulet\n/stopmacro [combat][mod:ctrl]\n/run if IsMounted() or GetShapeshiftFormID() ~= nil then DoEmote(\"mountspecial\") end")
		 		EditMacro("WSxGenC",nil,nil,"/use "..(Get_Spell("Innervate","[mod:shift,"..groupRosterBuilder("healer").."][mod:shift,@player]",";") or "")..(Get_Spell({{"Cyclone","[@mouseover,harm,nodead,mod][mod]",";"},{"Entangling Roots","[@mouseover,harm,nodead,mod][mod]",";"},}) or "")..(Get_Spell({{"Rejuvenation","[@mouseover,help,nodead,noform:1][noform:1]",";"},}) or "")..(Get_Spell({{"Frenzied Regeneration","[noform:1]Bear Form;[form:1]",""},{"Astral Communion","[noform:4]Moonkin Form;[form:4]",""},}) or "").."\n/use Totem of Spirits\n/cancelform [mod:shift,form:2]")
			-- elseif class == "DEMONHUNTER" then
			elseif class == "EVOKER" then
				EditMacro("WSxSGen+3",nil,nil,"#show\n/use "..(Get_Spell({{"Blistering Scales","[@mouseover,help,nodead]["..groupRosterBuilder("tank").."][]",""},{"Stasis","",""},{"Pyre","[@mouseover,harm,nodead][]",""},}) or "Hover").."\n/targetenemy [noexists]")
				EditMacro("WSxGenC",nil,nil,"#show\n/use "..(Get_Spell("Sleep Walk","[@mouseover,harm,nodead,mod:ctrl][mod:ctrl]",";") or "")..(Get_Spell("Source of Magic","[mod:shift][mod:shift,"..groupRosterBuilder("healer").."]",";") or "")..(Get_Spell("Reversion","[@mouseover,help,nodead][]","") or "[@mouseover,help,nodead][]Emerald Blossom").."\n/cancelaura X-Ray Specs")
			end
		end
		
		if (event == "LEARNED_SPELL_IN_SKILL_LINE" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD") then
			if (class == "WARLOCK" or class == "DEMONHUNTER") then
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use 14\n/use [nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Fractured Necrolyte Skull;[help,dead,nocombat]Cremating Torch")
			else
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use 14\n/use [nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol")
			end

			if ZG.Item_Count("Swapblaster") ~= 1 then
				swapblaster = ""
			end
			
			-- Main Class configuration
			-- Shaman, Raxxy
			if class == "SHAMAN" then
				EditMacro("WSxGen1",nil,nil,"#show\n/use "..(Get_Spell({{"Ice Strike","[@mouseover,harm,nodead][harm,nodead]",""},{"Unleash Life","[@mouseover,help,nodead][help,nodead]",""},{"Tidecaller's Guard","[exists,nodead]",""},{"Frost Shock","[@mouseover,harm,nodead][harm,nodead]",""},{"Primal Strike","[@mouseover,harm,nodead][harm,nodead]",""},}) or "")..";Xan'tish's Flute\n/targetenemy [noexists]\n/cleartarget [dead]")
				if Get_Spell("Healing Stream Totem") and playerSpec ~= 2 then
					override = "Healing Stream Totem"
				elseif Get_Spell("Frost Shock") then
					override = "Frost Shock"
				end
				EditMacro("WSxSGen+1",nil,nil,"#show "..(override or "Primal Strike").."\n/use [mod:alt,@party3,help,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Healing Surge\n/use Haunted War Drum")
				EditMacro("WSxGen2",nil,nil,"#show\n/use [nocombat,noexists]Raging Elemental Stone;"..(Get_Spell({{"Lava Lash","",""},{"Lightning Bolt","[@mouseover,harm,nodead][]",""},}) or "").."\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use [mod:alt,@party4,help,nodead][@mouseover,help,nodead][]Healing Surge\n/cancelaura X-Ray Specs\n/use Gnomish X-Ray Specs")
				EditMacro("WSxGen3",nil,nil,"#show\n/stopspelltarget\n/startattack\n/targetenemy [noexists]\n/use [nocombat,noexists]Tadpole Cloudseeder;"..(Get_Spell({{"Stormstrike","[@mouseover,harm,nodead][]",""},{"Lava Burst","[@mouseover,harm,nodead][]",""},}) or "Primal Strike").."\n/cleartarget [dead]\n/use Words of Akunda")
				EditMacro("WSxSGen+3",nil,nil,"#show Flame Shock\n/cleartarget [dead]\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead,nomod:alt][nomod:alt]Flame Shock\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Flame Shock\n/targetlasttarget")
				if Get_Spell("Wellspring") then override = "Wellspring" 
				elseif Get_Spell("Icefury") then override = "Icefury" 
				elseif playerSpec ~= 3 and Get_Spell("Lava Burst") then override = "[nocombat,noexists]Molten Lava Ball;[@mouseover,harm,nodead][]Lava Burst" 
				elseif Get_Spell("Chain Heal") then override = "[@mouseover,help,nodead][]Chain Heal"
				elseif Get_Spell("Primal Strike") then override = "[@mouseover,harm,nodead][]Primal Strike" 
				end
				EditMacro("WSxGen4",nil,nil,"#show\n/use "..override.."\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,noexists,nospec:3]Smolderheart\n/startattack")
				EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noexists]\n/use "..(Get_Spell({{"Riptide","[@party1,help,nodead,mod:alt]",";"},}) or "")..(Get_Spell({{"Primordial Wave(Shadowlands)","[@mouseover,exists,nodead,nomod:alt][nomod:alt]","(Shadowlands)\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Primordial Wave(Shadowlands)\n/targetlasttarget"},{"Primordial Wave","[@mouseover,exists,nodead,nomod:alt][nomod:alt]","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Primordial Wave\n/targetlasttarget"},{"Storm Elemental","[pet:Storm Elemental]Tempest;",""},{"Fire Elemental","[pet:Fire Elemental,@mouseover,harm,nodead][pet:Fire Elemental]Meteor;",""},{"Healing Tide Totem","",""},}) or "").."\n/use [nocombat,noexists]Sen'jin Spirit Drum\n/cleartarget [dead]")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use [@party3,help,nodead,mod:alt]Riptide;"..(Get_Spell({{"Ascendance","",""},{"Stormkeeper","",""},{"Wellspring","",""},{"Totemic Projection","[@cursor]",""},{"Downpour","[@cursor]",""},}) or "").."\n/targetenemy [noexists]\n/use Trawler Totem")
				if playerSpec == 2 then override = "\n/use Lightning Bolt" elseif Get_Spell("Earth Shock") then override = "\n/use Earth Shock" elseif Get_Spell("Elemental Blast") then override = "\n/use Elemental Blast" elseif Get_Spell("Healing Wave") then override = "\n/use [@mouseover,help,nodead][]Healing Wave" end
				EditMacro("WSxGen5",nil,nil,"/targetenemy [noexists,nomod]\n/target [@Greater Earth,mod]\n/use "..(Get_Spell({{"Spirit Link Totem","[mod,@cursor]",""},{"Earth Elemental","[mod,@pet,help,nodead][mod,help,nodead]Healing Surge;[mod]","\n/use [mod]Tiny Box of Tiny Rocks\n/targetlasttarget [mod,exists]"},}) or "")..override)
				EditMacro("WSxSGen+5",nil,nil,"#show ".."\n/cast [nocombat,noexists]Lava Fountain\n/stopspelltarget\n/cast "..(Get_Spell({{"Riptide","[@party2,help,nodead,mod:alt]",";"},}) or "[@party2,help,nodead,mod:alt]Healing Surge;")..(Get_Spell({{"Storm Elemental","[pet:Storm Elemental]Tempest;",""},{"Fire Elemental","[pet:Fire Elemental,@mouseover,harm,nodead][pet:Fire Elemental]Meteor;",""},{"Doom Winds","",""},{"Stormkeeper","",""},{"Frost Shock","",""},{"Healing Stream Totem","",""},}) or ""))
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod:ctrl,@party4,help,nodead]Riptide;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14")
				if Get_Spell("Healing Rain") then override = "[@cursor]Healing Rain" 
				elseif Get_Spell("Crash Lightning") then override = "Crash Lightning" 
				elseif playerSpec ~= 3 then override = "[@mouseover,harm,nodead][]Chain Lightning" 
				else override = "[@mouseover,help,nodead]Chain Heal;[@mouseover,harm,nodead][harm,nodead]Chain Lightning;Chain Heal"
				end
				EditMacro("WSxGen6",nil,nil,"/stopspelltarget\n/targetenemy [noexists,nomod]\n/use "..(Get_Spell({{"Feral Spirit","\n/use [mod:ctrl]",";"},{"Fire Elemental","\n/use [mod:ctrl]",";"},{"Storm Elemental","\n/use [mod:ctrl]",";"},{"Earth Elemental","\n/target [@Greater Earth Ele,mod:ctrl]\n/use [help,mod:ctrl,nodead]Healing Surge;[mod:ctrl]","\n/use [mod:ctrl]Tiny Box of Tiny Rocks\n/targetlasttarget [mod:ctrl]\n/use "},}) or "")..override)
				EditMacro("WSxSGen+6",nil,nil,"#show\n/use "..(Get_Spell({{"Sundering","",""},{"Stormkeeper","",""},{"Healing Tide Totem","",""},{"Chain Heal","[@mouseover,help,nodead][]",""},}) or "Lightning Bolt").."\n/use Orb of Deception\n/targetenemy [noexists]")
				EditMacro("WSxGen7",nil,nil,"/use "..(Get_Spell({{"Surging Totem","[mod:shift,@player]",""},{"Healing Rain","[mod:shift,@player]",";"},{"Earthquake","[mod:shift,@player][@cursor]",";"},{"Windfury Totem","[mod:shift]",";"},}) or "")..(Get_Spell({{"Chain Lightning","[@mouseover,harm,nodead][]",""},{"Riptide","",""},}) or "X-treme Water Blaster Display").."\n/startattack")
				EditMacro("WSxGen8",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell({{"Liquid Magma Totem","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Earthen Wall Totem","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Ancestral Protection Totem","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Downpour","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Healing Rain","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Fire Nova","",""},{"Surging Totem","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Frost Shock","",""},}) or "Flametongue Weapon"))
				EditMacro("WSxGen9",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell({{"Surging Totem","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Tidecaller's Guard","",""},{"Primordial Wave(Shadowlands)","","(Shadowlands)"},{"Primordial Wave","",""},{"Healing Stream Totem","",""},{"Windfury Totem","",""},{"Ice Strike","",""},{"Fire Nova","",""},{"Earthliving Weapon","",""},{"Spirit Link Totem","",""},{"Tremor Totem","",""},{"Downpour","[@cursor]",""},}) or "Water Walking"))
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,spec:3,@party3,help,nodead][spec:3,@party1,help,nodead][spec:3,@targettarget,help,nodead]Purify Spirit;[mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Cleanse Spirit;[nocombat,noharm]Spirit Wand")
				EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Flame Shock;[mod:alt,spec:3,@party4,help,nodead][spec:3,@party2,help,nodead]Purify Spirit;[mod:alt,@party4,help,nodead][@party2,help,nodead]Cleanse Spirit;[nocombat,noharm]Cranky Crab;\n/cleartarget [dead]\n/stopspelltarget")
				EditMacro("WSxCSGen+4",nil,nil,"/use [@focus,harm,nodead]Primordial Wave;[mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Chain Heal\n/use [spec:3]Waterspeaker's Totem")
				if playerSpec == 3 then 
					override = "\n/use [nocombat,noexists]X-treme Water Blaster Display\n/cancelaura [combat]X-treme Water Blaster P.R.\n/stopmacro [combat]\n/click ExtraActionButton1"
				else
					override = "\n/use [nocombat,noexists]Molten Lava Pack\n/cancelaura [combat]Molten Lava Pack\n/stopmacro [combat]\n/click ExtraActionButton1"
				end
				EditMacro("WSxCSGen+5",nil,nil,"/use [mod:alt,@party4,help,nodead][@party2,help,nodead][@targettarget,help,nodead]Chain Heal"..override)
				EditMacro("WSxGenQ",nil,nil,"/stopcasting [nomod:alt]\n/use "..(Get_Spell("Hex","[mod:alt,@focus,harm,nodead]",";") or "")..(Get_Spell("Tremor Totem","[mod:shift]",";") or "").."[help,nodead]Foot Ball;[nocombat,noexists]The Golden Banana;"..(Get_Spell("Wind Shear","[@mouseover,harm,nodead][]","") or "").."\n/use [nocombat,spec:3]Bubble Wand\n/cancelaura Bubble Wand")
				EditMacro("WSxGenE",nil,nil,"#show [nocombat,noexists]Party Totem;"..(Get_Spell("Capacitor Totem","",";") or "").."Party Totem\n/use "..(Get_Spell("Capacitor Totem","[@cursor]","") or "").."\n/use Haunting Memento\n/use [nocombat,noexists]Party Totem")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(Get_Spell("Capacitor Totem","[mod:alt,@player]",";") or "")..(Get_Spell({{"Ancestral Swiftness","",""},{"Nature's Swiftness","",""},}) or "")..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use [mod:alt,@player]Earthbind Totem;"..(Get_Spell("Healing Stream Totem","","") or "").."\n/use Arena Master's War Horn\n/use Totem of Spirits\n/use [nocombat]Void-Touched Souvenir Totem")
				EditMacro("WSxGenR",nil,nil,"#show Earthbind Totem\n/stopspelltarget\n/use "..(Get_Spell("Totemic Projection","[mod:ctrl,@cursor]",";") or "").."[@mouseover,exists,nodead,mod:shift][@cursor,mod:shift]Earthbind Totem;"..(Get_Spell("Frost Shock","[@mouseover,harm,nodead][]",";") or "").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGenT",nil,nil,"/stopspelltarget\n/use "..(Get_Spell({{"Thunderstorm","[@mouseover,exists,nodead][]",""},{"Frost Shock","[@mouseover,harm,nodead][]",""},{"Earthgrab Totem","[@mouseover,exists,nodead][@cursor]",""},}) or "[noexists,nodead]Water Walking")..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+T",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell({{"Lightning Lasso","[@mouseover,harm,nodead][]",""},{"Totemic Projection","[mod:alt,@player][@mouseover,exists,nodead][@cursor]",""},{"Thunderstorm","[@mouseover,exists,nodead][]",""},{"Earthquake","[@cursor]",""},{"Purge","[@mouseover,harm,nodead][]",""},{"Greater Purge","[@mouseover,harm,nodead][]",""},{"Frost Shock","[@mouseover,harm,nodead][]",""},{"Wind Rush Totem","[mod:alt,@player][@mouseover,exists,nodead][@cursor]",""},}) or ""))
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell({{"Wind Rush Totem","[@mouseover,exists,nodead][@cursor]",""},{"Earthgrab Totem","[@mouseover,exists,nodead][@cursor]",""},}) or ""))
				EditMacro("WSxGenU",nil,nil,"#show\n/use Reincarnation")
				EditMacro("WSxGenF",nil,nil,"#show "..(Get_Spell({{"Healing Stream Totem","",""},{"Totemic Projection","",""},}) or "").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@cursor]Far Sight;"..(Get_Spell("Wind Shear","[@focus,harm,nodead]",";") or "").."Mrgrglhjorn")
				if playerSpec == 2 then 
					override = Get_Spell({{"Gust of Wind","",""},{"Spirit Walk","",""},{"Stone Bulwark Totem","[@cursor]",""},}) or "Totem of Harmony"
				else
					override = Get_Spell({{"Stone Bulwark Totem","[@cursor]",""},{"Tranquil Air Totem","[@cursor]",""},{"Gust of Wind","",""},{"Spirit Walk","",""},}) or "Totem of Harmony"
				end
				EditMacro("WSxSGen+F",nil,nil,"#show\n/use [help,nocombat,mod:alt]B.B.F. Fist;[nocombat,noexists,mod:alt]Gastropod Shell;[nocombat,noexists]Totem of Harmony\n/use "..override.."\n/cancelform [mod:alt]")
				EditMacro("WSxCGen+F",nil,nil,"#show "..(Get_Spell({{"Ancestral Guidance","",""},{"Totemic Projection","",""},}) or "").."\n/use [nocombat,noexists]Molten Lava Ball"..(Get_Spell("Ancestral Guidance",";","") or "").."\n/use "..fftpar.."\n/cancelaura Thistleleaf Disguise\n/use Bom'bay's Color-Seein' Sauce")
				EditMacro("WSxCAGen+F",nil,nil,"#show "..(Get_Spell("Tremor Totem","","") or "Water Walking").."\n/run if not InCombatLockdown() then if (C_Spell.GetSpellCooldown(198103).duration == 0) then "..tpPants.." else "..noPants.." end end\n/use Gateway Control Shard")
				EditMacro("WSxGenG",nil,nil,"/use [mod:alt]Darkmoon Gazer;"..(Get_Spell({{"Purge","[@mouseover,harm,nodead]",";"},{"Greater Purge","[@mouseover,harm,nodead]",";"},}) or "")..(Get_Spell({{"Purify Spirit","[@mouseover,help,nodead][]",""},{"Cleanse Spirit","[@mouseover,help,nodead][]",""},{"Frost Shock","[@mouseover,harm,nodead][]",""},}) or "Darkmoon Gazer").."\n/targetenemy [noexists]\n/use Poison Extraction Totem")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(Get_Spell({{"Purge","[@mouseover,harm,nodead][harm,nodead]",""},{"Greater Purge","[@mouseover,harm,nodead][harm,nodead]",""},{"Healing Stream Totem","",""},}) or "").."\n/use Flaming Hoop\n/targetenemy [noexists]\n/cleartarget [dead]")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(Get_Spell({{"Earthen Wall Totem","[@cursor]",""},{"Ancestral Protection Totem","[@cursor]",""},{"Spiritwalker's Grace","",""},{"Stone Bulwark Totem","[@cursor]",""},{"Tranquil Air Totem","[@cursor]",""},}) or ""))
				EditMacro("WSxCSGen+G",nil,nil,"/use "..(Get_Spell({{"Purge","[@focus,harm,nodead]",";"},{"Greater Purge","[@focus,harm,nodead]",";"},}) or "")..(Get_Spell({{"Purify Spirit","[@focus,help,nodead]",";"},{"Cleanse Spirit","[@focus,help,nodead]",";"},}) or "")..(Get_Spell({{"Poison Cleansing Totem","",""},{"Tremor Totem","",""},{"Capacitor Totem","",""},}) or "Reincarnation").."\n/cancelaura Whole-Body Shrinka'\n/cancelaura Growing Pains\n/cancelaura Words of Akunda")
				EditMacro("WSxGenH",nil,nil,"#show\n/use "..(Get_Spell({{"Totemic Recall","",""},{"Stone Bulwark Totem","[@cursor]",""},{"Tranquil Air Totem","[@cursor]",""},{"Hex","",""},}) or "Astral Recall").."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenZ",nil,nil,"#show\n/use "..(Get_Spell({{"Water Shield","[mod:alt]",";"},{"Flametongue Weapon","[mod:alt]",";"},}) or "")..(Get_Spell({{"Spirit Link Totem","[mod:shift,@player]",";"},{"Earthen Wall Totem","[mod:shift,@player]",";"},{"Ancestral Protection Totem","[mod:shift,@player]",";"},{"Stone Bulwark Totem","[mod:shift,@player]",";"},{"Tranquil Air Totem","[mod:shift,@player]",";"},}) or "")..(Get_Spell("Astral Shift","[nomod]","") or "").."\n/use Whole-Body Shrinka'\n/use [mod:alt]Gateway Control Shard\n/use Moonfang's Paw")
				EditMacro("WSxGenC",nil,nil,"/use [help,nodead,nocombat]Chasing Storm".."\n/use "..(Get_Spell("Hex","[@mouseover,exists,nodead,mod:ctrl][mod:ctrl]",";") or "")..(Get_Spell({{"Mana Tide Totem","[mod]",";"},{"Totemic Recall","[mod]",";"},}) or "")..(Get_Spell({{"Riptide","[@mouseover,help,nodead][]",""},{"Lightning Shield","",""},{"Hex","",""},{"Thunderstorm","[@mouseover,exists,nodead][]",""},}) or "").."\n/use Thistleleaf Branch")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use [nocombat,noexists]Vol'Jin's Serpent Totem\n/use "..(Get_Spell({{"Tidecaller's Guard","",""},{"Totemic Recall","",""},}) or "").."\n/click TotemFrameTotem1 RightButton\n/cancelaura Chasing Storm\n/use [nocombat,noexists]Goren \"Log\" Roller\n/leavevehicle")
				EditMacro("WSxGenV",nil,nil,"#show\n/use "..(Get_Spell({{"Feral Lunge","[@mouseover,harm,nodead][]","\n/targetenemy [noexists]"},{"Gust of Wind","",""},{"Spiritwalker's Grace","",""},{"Spirit Walk","",""},{"Ghost Wolf","[noform]",""},}) or "").."\n/use Panflute of Pandaria\n/use Croak Crock\n/cancelaura Rhan'ka's Escape Plan\n/use Desert Flute\n/use Sparklepony XL")

			-- Mage, maggi, nooniverse
			elseif class == "MAGE" then
				EditMacro("WSxGen1",nil,nil,"/targetenemy [noharm,nodead]\n/use [nocombat,noexists]Dazzling Rod\n/use "..(Get_Spell({{"Ray of Frost","",""},{"Radiant Spark","[@mouseover,harm,nodead][]",""},{"Ice Lance","[@mouseover,harm,nodead][]",""},{"Phoenix Flames","[@mouseover,harm,nodead][]",""},{"Frostbolt","",""},}) or ""))
				EditMacro("WSxGen2",nil,nil,"/use "..(Get_Spell({{"Arcane Blast","[harm,nodead]",";"},{"Scorch","[@mouseover,harm,nodead][harm,nodead]",";"},{"Frostbolt","[harm,nodead]",";"},}) or "").."Akazamzarak's Spare Hat\n/targetenemy [noharm]\n/cleartarget [dead]\n/use [nocombat,noexists]Kalec's Image Crystal\n/use [nocombat,noexists]Archmage Vargoth's Spare Staff")
				EditMacro("WSxGen3",nil,nil,"/use "..(Get_Spell({{"Pyroblast","[@mouseover,harm,nodead][harm,nodead]",""},{"Arcane Surge","",""},{"Glacial Spike","",""},}) or "").."\n/use [spec:2]Smolderheart\n/use Dalaran Initiates' Pin\n/targetenemy [noexists]")
				EditMacro("WSxSGen+3",nil,nil,"/targetenemy [noexists]\n/use [nocombat,noexists]Archmage Vargoth's Spare Staff;"..(Get_Spell({{"Nether Tempest","[nomod:alt]",""},{"Arcane Blast","[nomod:alt]",""},{"Living Bomb","[nomod:alt]","\n/use [nocombat]Brazier of Dancing Flames"},{"Icy Veins","[pet:Water Elemental,@mouseover,harm,nodead][pet:Water Elemental]Water Jet;[nomod:alt]Frostbolt;",""},{"Pyroblast","[nomod:alt]","\n/use [nocombat]Brazier of Dancing Flames\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [mod:alt]Pyroblast\n/targetlasttarget"},}) or ""))
				EditMacro("WSxGen4",nil,nil,"/use "..(Get_Spell({{"Fireball","[@mouseover,harm,nodead][harm,nodead]",";"},{"Flurry","[harm,nodead]",";"},{"Arcane Missiles","[harm,nodead]",";"},}) or "").."Memory Cube\n/targetenemy [noexists]\n/cleartarget [dead]\n/stopspelltarget")
				EditMacro("WSxSGen+4",nil,nil,"#showtooltip "..(Get_Spell("Touch of the Magi") or "").."\n/targetenemy [noexists]\n/stopspelltarget\n/use "..(Get_Spell({{"Touch of the Magi","[nomod:alt]Arcane Barrage\n/use [nomod:alt]",""},{"Comet Storm","[nomod:alt]",""},{"Ebonbolt","[nomod:alt]",""},{"Meteor","[@mouseover,exists,nodead,nomod:alt,spec:2][@cursor,nomod:alt,spec:2]",""},{"Dragon's Breath","[nomod:alt]",""},{"Frostbolt","[nomod:alt]",""},{"Fireball","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [mod:alt]","\n/targetlasttarget"},}) or ""))
				EditMacro("WSxCGen+4",nil,nil,"#show "..(Get_Spell({{"Shifting Power","",""},{"Arcane Familiar","[nocombat,noexists]",""},{"Meteor","[@mouseover,exists,nodead][@cursor]",""},}) or "").."\n/use [nocombat,noexists]Faded Wizard Hat"..(Get_Spell("Ice Floes","\n/use Ice Floes","") or "").."\n/use "..(Get_Spell({{"Shifting Power","",""},{"Arcane Familiar","[nocombat,noexists]",""},{"Meteor","[@mouseover,exists,nodead][@cursor]",""},}) or ""))
				EditMacro("WSxSGen+5",nil,nil,"/stopspelltarget\n/targetenemy [noexists]\n/cleartarget [dead]\n/use "..(Get_Spell({{"Icy Veins","[mod:alt,pet:Water Elemental,@player][@mouseover,exists,nodead,pet:Water Elemental][pet:Water Elemental,@cursor]Freeze;[@mouseover,harm,nodead][]Fire Blast;","",""},{"Evocation","",""},{"Pyroblast","[@mouseover,harm,nodead][]Fire Blast;",""},}) or ""))
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..(Get_Spell({{"Icy Veins","[mod:ctrl]",""},{"Arcane Surge","[mod:ctrl]",""},{"Combustion","[mod:ctrl]",""},}) or "").."\n/use "..(Get_Spell("Mirror Image","[mod:ctrl]",";") or "")..(Get_Spell({{"Frozen Orb","[@cursor]",""},{"Arcane Orb","",""},{"Supernova","[@mouseover,exists,nodead][]",""},{"Dragon's Breath","",""},{"Arcane Explosion","",""},}) or ""))
				EditMacro("WSxSGen+6",nil,nil,"#show\n/use [nocombat,noexists]Mystical Frosh Hat\n/use "..(Get_Spell({{"Meteor","[@player]",""},{"Dragon's Breath","[@mouseover,exists,nodead][]",""},{"Supernova","[@mouseover,exists,nodead][]",""},}) or ""))
				EditMacro("WSxGen7",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell({{"Blizzard","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Flamestrike","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Supernova","[@mouseover,exists,nodead][]",""},{"Arcane Orb","",""},{"Ice Nova","",""},{"Arcane Explosion","",""},{"Touch of the Magi","",""},}) or ""))
				EditMacro("WSxGen8",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell("Arcane Explosion","","") or ""))
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..(Get_Spell({{"Shifting Power","",""},{"Dragon's Breath","",""},{"Meteor","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Arcane Familiar","[nocombat,noexists]",""},{"Arcane Explosion","[spec:2]",""},}) or ""))
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Remove Curse")
				EditMacro("WSxCSGen+3",nil,nil,"#show\n/use "..(Get_Spell("Pyroblast","[@focus,harm,nodead]",";") or "").."[mod:alt,@party4,help,nodead][@party2,help,nodead]Remove Curse;[exists,nodead]Magical Saucer\n/targetenemy [noharm]\n/cleartarget [dead][nocombat,noharm]\n/stopspelltarget")
				EditMacro("WSxCSGen+4",nil,nil,"/use [spec:2,@focus,harm,nodead]Fireball;[mod:alt,@party3,help,nodead][@party1,help,nodead]Slow Fall;Pink Gumball\n/targetenemy [noharm]\n/cleartarget [dead][nocombat,noharm]\n/stopspelltarget\n/use [nocombat,noexists]Ogre Pinata")
				EditMacro("WSxCSGen+5",nil,nil,"#show Ice Block\n/use [mod:alt,@party4,help,nodead][@party2,help,nodead]Slow Fall\n/use [nocombat,noexists]Shado-Pan Geyser Gun\n/cancelaura [combat]Shado-Pan Geyser Gun\n/stopmacro [combat]\n/click ExtraActionButton1")
				EditMacro("WSxGenQ",nil,nil,"#show\n/stopcasting [nomod]\n/use [mod:alt,@focus,harm,nodead]Polymorph;[mod:shift]Winning Hand;[@mouseover,harm,nodead][harm,nodead]Counterspell;Nightborne Guard's Vigilance\n/use [mod:shift]Ice Block;")
				EditMacro("WSxGenE",nil,nil,"#show\n/use "..(Get_Spell({{"Mass Polymorph","[mod:alt]",";"},{"Blast Wave","[mod:alt]",";"},}) or "")..(Get_Spell("Frost Nova") or "").."\n/use Manastorm's Duplicator")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(Get_Spell({{"Ice Floes","",""},{"Ice Nova","",""},}) or "").."\n/use [spec:2]Blazing Wings"..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell({{"Ring of Frost","[mod:alt,@player][@mouseover,exists,nodead][@cursor]",""},{"Ice Nova","",""},}) or ""))
				EditMacro("WSxGenR",nil,nil,"#show "..(Get_Spell("Cone of Cold") or "").."\n/use "..(Get_Spell("Cone of Cold","[mod:shift]",";") or "")..(Get_Spell({{"Slow","",""},{"Frostbolt","",""},}) or "").."\n/targetenemy [noexists]")
				EditMacro("WSxGenT",nil,nil,"/use "..(Get_Spell("Fire Blast","[@mouseover,harm,nodead][harm,nodead]",";") or "")..swapblaster.."\n/targetenemy [noexists]\n/use Titanium Seal of Dalaran\n/cleartarget [dead]\n/petattack [@mouseover,harm,nodead][]")
				EditMacro("WSxSGen+T",nil,nil,"#show\n/use "..(Get_Spell("Blast Wave","","") or "Frostbolt"))
			    EditMacro("WSxCGen+T",nil,nil,"#show")
				EditMacro("WSxGenF",nil,nil,"#show "..(Get_Spell("Invisibility","[combat]","") or "")..";"..(Get_Spell("Ice Block") or "").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/stopcasting [nomod]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Counterspell;Mrgrglhjorn")
				EditMacro("WSxCGen+F",nil,nil,"#show\n/use "..(Get_Spell({{"Mass Invisibility","",""},{"Mass Barrier","",""},}) or ""))
				EditMacro("WSxCAGen+F",nil,nil,"#show "..(Get_Spell({{"Ring of Frost","",""},{"Mirror Image","",""},}) or "").."\n/use !Blink\n/use Alter Time\n/cancelaura Alter Time")
				EditMacro("WSxGenG",nil,nil,"#show [mod:alt]Darkmoon Gazer"..(Get_Spell("Spellsteal",";[@mouseover,harm,nodead]",";") or "")..(Get_Spell("Remove Curse","[@mouseover,help,nodead][]","") or "").."\n/targetenemy [noharm]\n/use Set of Matches\n/use [mod:alt]Darkmoon Gazer"..(Get_Spell("Spellsteal",";[@mouseover,harm,nodead]",";") or "")..(Get_Spell("Remove Curse","[@mouseover,help,nodead][]","") or ""))
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(Get_Spell("Spellsteal","[@mouseover,harm,nodead][]","") or "").."\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]\n/use Poison Extraction Totem")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(Get_Spell("Arcane Familiar") or ""))
				EditMacro("WSxCSGen+G",nil,nil,"#show "..(Get_Spell({{"Cold Snap","",""},{"Greater Invisibility","",""},}) or "").."\n/use "..(Get_Spell("Spellsteal","[@focus,harm,nodead]","") or "").."\n/use Poison Extraction Totem")
				EditMacro("WSxGenH",nil,nil,"#show "..(Get_Spell("Ice Nova") or "").."\n/targetenemy [noharm]\n/use Nat's Fishing Chair\n/use Home Made Party Mask\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") else C_MountJournal.SummonByID(1727) end end")
				EditMacro("WSxGenZ",nil,nil,"#show\n/use "..(Get_Spell("Arcane Familiar","[mod:alt]",";") or "")..(Get_Spell("Invisibility","[nocombat]",";") or "")..(Get_Spell("Ice Block","!","") or "").."\n/use [mod:alt]Gateway Control Shard")
				EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt]Conjure Refreshment;[mod:ctrl]Teleport: Hall of the Guardian;"..(Get_Spell({{"Displacement","[mod:shift]",";"},{"Alter Time","[mod:shift]",";"},}) or "")..(Get_Spell({{"Prismatic Barrier","",""},{"Blazing Barrier","",""},{"Ice Barrier","",""},}) or "").."\n/use [nomod,spec:1]Arcano-Shower;[nomod,spec:2]Blazing Wings")
				EditMacro("WSxGenC",nil,nil,"/use "..(Get_Spell({{"Cold Snap","[mod:shift]",";"},{"Conjure Mana Gem","[mod:shift]",";"},}) or "")..(Get_Spell("Mirror Image","[nomod]",";") or "").."[@mouseover,harm,nodead,mod][mod][]Polymorph\n/use "..(Get_Spell("Conjure Mana Gem","[mod:shift]","") or "").."\n/cancelaura X-Ray Specs\n/ping [mod:ctrl,@mouseover,harm,nodead][mod:ctrl,harm,nodead]onmyway")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use Worn Doll\n/run PetDismiss()\n/cry")
				EditMacro("WSxGenV",nil,nil,"#show\n/cast Blink\n/dismount [mounted]\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Illusion\n/use Prismatic Bauble\n/use Choofa's Call")
			-- Warlock, vårlök
			elseif class == "WARLOCK" then
				EditMacro("WSxGen1",nil,nil,"/use "..(Get_Spell("Soulstone","[@mouseover,help,dead][help,dead]",";") or "")..(Get_Spell({{"Soul Fire","",""},{"Havoc","[@mouseover,harm,nodead][]",""},{"Summon Vilefiend","",""},{"Soul Strike","[nopet]Summon Felguard;[@mouseover,harm,nodead][harm,nodead]",""},{"Soul Swap","[@mouseover,harm,nodead][harm,nodead]",""},{"Drain Life","",""},{"Corruption","[@mouseover,harm,nodead][]",""},}) or "").."\n/use Copy of Daglop's Contract\n/targetenemy [noexists]\n/use Imp in a Ball\n/cancelaura Ring of Broken Promises")
				EditMacro("WSxSGen+1",nil,nil,"#showtooltip "..(Get_Spell({{"Fel Domination","",""},{"Amplify Curse","",""},}) or "").."\n/run ConsumableTrader(\"Healthstone\")")
				EditMacro("WSxGen2",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use [harm,dead,nocombat]Soul Inhaler;"..(Get_Spell({{"Incinerate","",""},{"Agony","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",""},{"Shadow Bolt","",""},}) or "").."\n/use Accursed Tome of the Sargerei\n/startattack\n/clearfocus [dead]\n/use Haunting Memento\n/use Verdant Throwing Sphere\n/use Totem of Spirits")
				EditMacro("WSxSGen+2",nil,nil,"/use [nomod:alt,harm,nodead]Drain Life;"..(Get_Spell({{"Demonic Healthstone","[nomod:alt]Demonic Healthstone\n/use [noexists,nomod:alt]Create Healthstone;",""},{"Create Healthstone","[nomod:alt]Healthstone\n/use [noexists,nomod:alt]",""},}) or "").."\n/use [nocombat,noexists]Gnomish X-Ray Specs\n/cleartarget [dead]"..(Get_Spell("Unstable Affliction","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use ","\n/targetlasttarget") or ""))
				EditMacro("WSxGen3",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use [nocombat,noexists]Pocket Fel Spreader;[harm,dead]Narassin's Soul Gem;"..(Get_Spell({{"Shadowburn","[@mouseover,harm,nodead][]",""},{"Call Dreadstalkers","[@mouseover,harm,nodead][]",""},{"Oblivion","[@mouseover,harm,nodead][]",""},{"Immolate","[@mouseover,harm,nodead][]",""},{"Shadow Bolt","[@mouseover,harm,nodead][]",""},}) or "").."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+3",nil,nil,"/targetenemy [noexists]\n/use "..(Get_Spell({{"Doom","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",""},{"Immolate","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",""},{"Corruption","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",""},}) or "").."\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use "..(Get_Spell({{"Doom","",""},{"Immolate","",""},{"Corruption","",""},}) or "").."\n/targetlasttarget")
				EditMacro("WSxGen4",nil,nil,"/use [nocombat,noexists]Crystalline Eye of Undravius;"..(Get_Spell({{"Hand of Gul'dan","",""},{"Chaos Bolt","",""},{"Haunt","[@mouseover,harm,nodead][]",""},{"Unstable Affliction","[@mouseover,harm,nodead][]",""},}) or "").."\n/targetenemy [noexists]\n/cleartarget [dead]\n/cancelaura Crystalline Eye of Undravius\n/use Poison Extraction Totem")
				EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noexists]\n/use "..(Get_Spell({{"Havoc","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",""},{"Unstable Affliction","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",""},{"Power Siphon","",""},{"Corruption","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",""},}) or "").."\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use "..(Get_Spell({{"Unstable Affliction","",""},{"Havoc","",""},{"Corruption","",""},}) or "").."\n/targetlasttarget")
				EditMacro("WSxCGen+4",nil,nil,"/use "..(Get_Spell({{"Nether Portal","",""},{"Channel Demonfire","",""},{"Soul Fire","",""},{"Demonic Gateway","[@cursor]",""},{"Amplify Curse","",""},}) or "").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGen5",nil,nil,"/use [pet:Voidwalker,mod:ctrl]Suffering;[mod:ctrl]Fel Domination;[nocombat,noexists]Fire-Eater's Vial\n/use [nopet:Voidwalker,mod:ctrl]Summon Voidwalker;"..(Get_Spell({{"Demonbolt","[@mouseover,harm,nodead][]",""},{"Conflagrate","[@mouseover,harm,nodead][]",""},}) or "Shadow Bolt").."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+5",nil,nil,"/targetenemy [noexists]\n/use "..(Get_Spell("Summon Infernal","[mod:alt,@cursor]","") or "")..(Get_Spell({{"Grimoire: Felguard","[nomod:alt]",""},{"Bilescourge Bombers", "[@player,nomod:alt]",""},{"Demonic Strength","[pet:Felguard/Wrathguard,nomod:alt]",""},{"Grimoire of Sacrifice","[nomod:alt]",""},}) or "")..(Get_Spell({{"Demonbolt","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use ","\n/targetlasttarget"},{"Agony","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use ","\n/targetlasttarget"},}) or ""))
				EditMacro("WSxGen6",nil,nil,"/use "..(Get_Spell({{"Summon Darkglare","[mod]",";"},{"Summon Demonic Tyrant","[mod]",";"},{"Summon Infernal","[mod,@cursor]",";"},}) or "")..(Get_Spell({{"Seed of Corruption","[@mouseover,harm,nodead][]",""},{"Soul Strike","[nopet]Summon Felguard;[@mouseover,harm,nodead][]",""},{"Implosion","[@mouseover,harm,nodead][]",""},{"Rain of Fire","[@cursor]",""},}) or "").."\n/startattack")
				EditMacro("WSxSGen+6",nil,nil,"/use "..(Get_Spell({{"Rain of Fire","[@player]",""},{"Malefic Rapture","",""},}) or "[spec:2,nopet:Felguard/Wrathguard]Summon Felguard;[pet:Felguard/Wrathguard]!Felstorm;Command Demon\n/stopmacro [@pet,nodead]\n/run PetDismiss()"))
				if Get_Spell("Cataclysm") then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Cataclysm"
				elseif Get_Spell("Bilescourge Bombers") and Get_Spell("Guillotine") then override = "[@player,mod:shift][@mouseover,exists,nodead][@cursor]Bilescourge Bombers"
				elseif Get_Spell("Guillotine") then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Guillotine"
				elseif Get_Spell("Demonic Strength") then override = "[mod:shift,nopet]Summon Imp;[@mouseover,harm,nodead][]Demonic Strength"
				elseif Get_Spell("Phantom Singularity") then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Phantom Singularity"
				elseif Get_Spell("Vile Taint") then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Vile Taint"
				elseif playerSpec == 2 then
					override = "[mod:shift,nopet]Summon Imp;Felstorm"
				else
					override = "[mod:shift,nopet]Summon Imp;Command Demon"
				end
				EditMacro("WSxGen7",nil,nil,"#showtooltip\n/stopspelltarget\n/use "..override.."\n/targetenemy [noexists]")
				if Get_Spell("Soul Rot") then override = "[@mouseover,harm,nodead][]Soul Rot"
				elseif Get_Spell("Guillotine") and Get_Spell("Demonic Strength") then 
						override = "[@mouseover,harm,nodead][]Demonic Strength"
				elseif Get_Spell("Bilescourge Bombers") and Get_Spell("Guillotine") then
						override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Guillotine"
				else 
					override = Get_Spell({{"Guillotine","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Bilescourge Bombers","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Summon Soulkeeper","[mod:shift,@player][@mouseover,exists,nodead][@cursor]","",},{"Implosion","[@mouseover,harm,nodead][]",""},{"Dimensional Rift","[@mouseover,harm,nodead][]",""},}) or "Subjugate Demon"
				end
				EditMacro("WSxGen8",nil,nil,"#showtooltip\n/stopspelltarget\n/use "..override)
				if Get_Spell("Summon Soulkeeper") then 
					override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Summon Soulkeeper"
				elseif Get_Spell("Inquisitor's Gaze") and playerSpec == 2 then 
					override = "Felstorm"
				else
					override = Get_Spell({{"Inquisitor's Gaze","",""},{"Implosion","",""},}) or "Create Soulwell"
				end
				EditMacro("WSxGen9",nil,nil,"#showtooltip\n/stopspelltarget\n/use "..override)
				EditMacro("WSxCSGen+2",nil,nil,"/use [spec:1,@focus,harm,nodead]Unstable Affliction;[@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Singe Magic;[nocombat,noexists]Legion Invasion Simulator\n/targetenemy [noharm]\n/cleartarget [dead]")
				EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noexists]The Perfect Blossom;[spec:1,@focus,harm,nodead]Corruption;[spec:2,@focus,harm,nodead]Doom;[spec:3,@focus,harm,nodead]Immolate;[@party2,help,nodead]Singe Magic;Fel Petal;\n/targetenemy [noharm]\n/cleartarget [dead]")
				EditMacro("WSxCSGen+4",nil,nil,"/use [spec:1,@focus,harm,nodead]Unstable Affliction;[spec:3,@focus,harm,nodead]Havoc\n/targetenemy [noharm]\n/cleartarget [dead]\n/use [nocombat]Micro-Artillery Controller")
				EditMacro("WSxCSGen+5",nil,nil,"/use "..(Get_Spell({{"Agony","[@focus,harm,nodead]",""},{"Demonbolt","[@focus,harm,nodead]",""},}) or "").."\n/cleartarget [dead]\n/use Battle Standard of Coordination\n/stopmacro [combat]\n/use S.F.E. Interceptor")
				EditMacro("WSxGenQ",nil,nil,"#show\n/stopcasting [nomod,nopet]\n/use [@focus,mod:alt,harm,nodead]Fear;[mod:shift]Demonic Circle;"..locPvPQ.."\n/use [nocombat,noexists]Vixx's Chest of Tricks\n/cancelaura Wyrmtongue Collector Disguise")
				EditMacro("WSxGenE",nil,nil,"/stopspelltarget\n/use "..(Get_Spell("Shadowfury","[@mouseover,exists,nodead,nocombat,nomod][@cursor,nomod]",";") or "")..(Get_Spell({{"Soulburn","",""},{"Amplify Curse","",""},}) or "[@mouseover,harm,nodead][]Fear"))
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(Get_Spell("Shadowfury","[mod:alt,@player]",";") or "")..(Get_Spell("Fel Domination") or "")..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show [nopet:Felhunter]Summon Felhunter;Spell Lock\n/use [mod:alt,@focus,harm,nodead,pet:Felhunter/Observer][@mouseover,harm,nodead,pet:Felhunter/Observer][pet:Felhunter/Observer]Spell Lock;Fel Domination\n/use [nopet:Felhunter/Observer]Summon Felhunter")
				EditMacro("WSxGenR",nil,nil,"/use [mod:ctrl]Summon Sayaad;[mod:ctrl,pet]Lesser Invisibility;"..(Get_Spell("Shadowflame","[mod:shift]",";") or "")..(Get_Spell("Curse of Exhaustion","[@mouseover,harm,nodead,nomod:ctrl][nomod:ctrl]","") or "").."\n/targetenemy [noexists,nomod]\n/stopmacro [nomod:ctrl][nopet]\n/target pet\n/kiss\n/targetlasttarget [exists]")
				EditMacro("WSxGenT",nil,nil,"/use [pet:Incubus/Succubus/Shivarra]Whiplash;[@mouseover,harm,nodead,pet:Felguard/Wrathguard][pet:Felguard/Wrathguard]!Pursuit;Command Demon\n/petattack [@mouseover,harm,nodead][]\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+T",nil,nil,"#show "..(Get_Spell("Shadowflame") or "Curse of Weakness").."\n/use [@mouseover,harm,nodead][harm,nodead]Curse of Weakness"..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use [@mouseover,help][]Soulstone")
				EditMacro("WSxGenU",nil,nil,"#show [help]Soulstone;[nopet]Summon Imp;"..(Get_Spell("Amplify Curse","[]",";") or "").."Soulstone\n/use "..(Get_Spell("Amplify Curse","[]",";") or "").."[nopet]Summon Imp")
				EditMacro("WSxGenF",nil,nil,"#show "..(Get_Spell("Demonic Circle","","") or "").."\n/focus [@mouseover,exists]mouseover\n/stopmacro [@mouseover,exists]\n/stopcasting [nomod,nopet]\n/use [mod,exists,nodead]All-Seer's Eye;[mod]Legion Communication Orb;"..locPvPF.."Tickle Totem")
				EditMacro("WSxSGen+F",nil,nil,"/use [mod:alt,nocombat,noexists]Gastropod Shell;[pet:Felguard/Wrathguard]Threatening Presence;[pet:Imp]Flee;[pet:Voidwalker]Suffering\n/use B. F. F. Necklace\n/petautocasttoggle [mod:alt]Legion Strike;[pet:Voidwalker]Suffering;Threatening Presence")
				EditMacro("WSxCGen+F",nil,nil,"#show "..(Get_Spell("Amplify Curse","[combat]",";") or "").."Ritual of Doom\n/use [group,nocombat]Ritual of Doom"..(Get_Spell("Amplify Curse",";","") or "").."\n/use Bewitching Tea Set\n/use "..fftpar.."\n/cancelaura Wyrmtongue Disguise\n/cancelaura Burning Rush\n/cancelaura Heartsbane Curse")
				EditMacro("WSxCAGen+F",nil,nil,"#show "..(Get_Spell("Soulburn","","") or "")..
					"\n/stopcasting\n/use "..(Get_Spell("Soulburn","","") or "").."\n/use "..(Get_Spell("Demonic Gateway","[@cursor]","") or "").."\n/use Gateway Control Shard")
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]Eye of Kilrogg;[@mouseover,harm,nodead,pet:Felhunter][pet:Felhunter,harm,nodead]Devour Magic;[@mouseover,exists,nodead][]Command Demon\n/stopspelltarget")
				EditMacro("WSxSGen+G",nil,nil,"/use "..(Get_Spell({{"Mortal Coil","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]",""},{"Howl of Terror","",""},}) or "").."\n/use Flaming Hoop\n/targetenemy [noexists]")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use [help,nodead,pet:Imp/Fel Imp][@player,pet:Imp/Fel Imp]Singe Magic;Fel Domination\n/use [nopet:Imp/Fel Imp]Summon Imp\n/use Legion Pocket Portal")
				EditMacro("WSxCSGen+G",nil,nil,"#show [mod]Create Soulwell;"..(Get_Spell({{"Grimoire of Sacrifice","",";"},{"Dark Pact","",";"},}) or "").."Summon Felhunter\n/use "..(Get_Spell("Grimoire of Sacrifice","[pet]",";") or "").."[nopet][combat]Summon Felhunter;Create Soulwell\n/use [nopet]Summon Felhunter")
				EditMacro("WSxGenH",nil,nil,"#show "..(Get_Spell("Demonic Circle","",": Teleport") or "").."\n/run if not InCombatLockdown() then if IsMounted()then DoEmote(\"mountspecial\")end end"..(Get_Spell("Soulburn","\n/use ","\n/castsequence [mod,nomounted]reset=5 Demonic Circle,Demonic Circle: Teleport\n/use [nomod,nomounted]Demonic Circle: Teleport") or ""))
				EditMacro("WSxGenZ",nil,nil,"/cast "..(Get_Spell("Demonic Gateway","[mod:alt,@cursor]",";") or "")..(Get_Spell("Dark Pact","[mod:shift]",";") or "").."Unending Resolve")
				EditMacro("WSxGenX",nil,nil,"/cast [mod:alt,group]Create Soulwell;[mod:alt]Create Healthstone;[mod:shift]Demonic Circle: Teleport;[mod,harm,nodead]Subjugate Demon;[mod,group]Ritual of Summoning;[mod]Unstable Portal Emitter;"..(Get_Spell({{"Burning Rush","!",";"},{"Dark Pact","",";"},}) or "").."Demonic Circle: Teleport")
				EditMacro("WSxGenC",nil,nil,"/use [mod,@mouseover,harm,nodead][mod]Fear;[nopet]Summon Voidwalker;Ring of Broken Promises\n/use Smolderheart\n/use Health Funnel\n/cancelaura X-Ray Specs\n/ping [mod:ctrl,@mouseover,harm,nodead][mod:ctrl,harm,nodead]onmyway")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use Spire of Spite\n/run PetDismiss();\n/cry")
				EditMacro("WSxGenV",nil,nil,"#show\n/use "..(Get_Spell("Curse of Tongues","[@mouseover,harm,nodead][harm,nodead]",";The Heartbreaker") or "").."\n/use [nomod]Panflute of Pandaria\n/use Haw'li's Hot & Spicy Chili\n/cancelaura Rhan'ka's Escape Plan\n/use Void Totem\n/targetenemy [noexists]\n/cleartarget [dead]")
				-- EditMacro("WSxCAGen+B",nil,nil,"")
				-- EditMacro("WSxCAGen+N",nil,nil,"")
			-- Monk, menk, Happyvale
			elseif class == "MONK" then
				if Get_Spell("Soothing Mist") and playerSpec == 2 then override = "[@mouseover,help,nodead,nochanneling:Soothing Mist][nochanneling:Soothing Mist]Soothing Mist;[@mouseover,help,nodead][]Vivify"
				elseif Get_Spell("Celestial Conduit") then override = "Celestial Conduit" 
				else override = "Expel Harm"
				end
				EditMacro("WSxGen1",nil,nil,"#show\n/use [nocombat,noexists]Mrgrglhjorn\n/use "..override.."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+1",nil,nil,"/use "..(Get_Spell("Soothing Mist","[mod:ctrl,@party2,help,nodead,nochanneling:Soothing Mist][@party1,help,nodead,nochanneling:Soothing Mist]",";") or "").."[mod:ctrl,@party2,help,nodead][@party1,help,nodead]Vivify;Honorary Brewmaster Keg")
				EditMacro("WSxGen2",nil,nil,"#show\n/use [channeling,@mouseover,help,nodead][channeling:Soothing Mist]Vivify;[nocombat,noexists]Brewfest Keg Pony;Tiger Palm\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use "..(Get_Spell("Soothing Mist","[mod:alt,@party3,nodead,nochanneling:Soothing Mist]",";") or "").."[@party3,nodead,mod:alt][@mouseover,help,nodead][]Vivify\n/use [nochanneling]Gnomish X-Ray Specs")
				EditMacro("WSxGen3",nil,nil,"/use "..(Get_Spell("Enveloping Mist","[channeling,@mouseover,help,nodead][channeling:Soothing Mist]",";") or "").."[@mouseover,harm,nodead][]Touch of Death\n/use [nocombat,noexists]Mystery Keg\n/use [nocombat,noexists]Jin Warmkeg's Brew\n/targetenemy [noexists]\n/cleartarget [dead]")  
				EditMacro("WSxSGen+3",nil,nil,"/use "..(Get_Spell("Soothing Mist","[mod:alt,@party4,nodead,nochanneling:Soothing Mist]",";") or "").."[@party4,nodead,mod:alt]Vivify;"..(Get_Spell({{"Rushing Jade Wind","",""},{"Enveloping Mist","[@mouseover,help,nodead][]",""},}) or "Crackling Jade Lightning"))
				EditMacro("WSxGen4",nil,nil,"#show\n/use [nocombat,noexists]Brewfest Pony Keg;"..(Get_Spell("Rising Sun Kick","","") or "").."\n/use Piccolo of the Flaming Fire\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxSGen+4",nil,nil,"#show\n/use [@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Renewing Mist;"..(Get_Spell({{"Chi Wave","",""},{"Chi Burst","",""},{"Rushing Jade Wind","",""},}) or "Tiger Palm").."\n/stopspelltarget\n/targetenemy [noexists]")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..(Get_Spell("Renewing Mist","[mod:alt,@party3,help,nodead]",";") or "")..(Get_Spell("Celestial Conduit","[spec:3]",";Expel Harm") or "Expel Harm").."\n/targetenemy [nocombat,noexists]")
				EditMacro("WSxGen5",nil,nil,"#show "..(Get_Spell({{"Zen Meditation","[mod:ctrl]",";"},{"Thunder Focus Tea","[mod:ctrl]",";"},}) or "").."Blackout Kick\n/use [noexists,nocombat]Brewfest Banner\n/use "..(Get_Spell({{"Zen Meditation","[mod:ctrl]",";"},{"Thunder Focus Tea","[mod:ctrl]",";"},}) or "").."Blackout Kick\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+5",nil,nil,"/use "..(Get_Spell("Renewing Mist","[@party2,help,nodead,mod:alt]",";") or "")..(Get_Spell({{"Strike of the Windlord","",""},{"Energizing Elixir","",""},{"Zen Pulse","[@mouseover,help,nodead][]",""},{"Keg Smash","",""},{"Thunder Focus Tea","",""},{"Jadefire Stomp","",""},}) or "").."\n/use Displacer Meditation Stone\n/targetenemy [noexists]")
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod:ctrl,@party4,help,nodead]Renewing Mist;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14")
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..(Get_Spell({{"Storm, Earth, and Fire","[mod]",";"},{"Serenity","[mod]",";"},{"Invoke Xuen, the White Tiger","[mod]",";"},{"Invoke Yu'lon, the Jade Serpent","[mod]",";"},{"Invoke Chi-Ji, the Red Crane","[mod]",";"},{"Invoke Niuzao, the Black Ox","[mod]",";"},}) or "").."!Spinning Crane Kick\n/use Words of Akunda")
				EditMacro("WSxSGen+6",nil,nil,"/use [noexists,nocombat,spec:3]\"Purple Phantom\" Contender's Costume;"..(Get_Spell({{"Fists of Fury","[@mouseover,harm,nodead][]",""},{"Celestial Conduit","",""},{"Breath of Fire","",""},{"Black Ox Brew","",""},{"Rushing Jade Wind","",""},}) or "Kindness of Chi-Ji").."\n/targetenemy [noexists]\n/stopmacro [combat]\n/click ExtraActionButton1",1,1)
				EditMacro("WSxGen7",nil,nil,"#show\n/use "..(Get_Spell({{"Exploding Keg","[mod:shift,@player][@cursor]",""},{"Whirling Dragon Punch","",""},{"Bonedust Brew","[mod:shift,@player][@cursor]",""},{"Jadefire Stomp","",""},{"Summon White Tiger Statue","[mod:shift,@player][@cursor]",""},{"Storm, Earth, and Fire","",""},{"Serenity","",""},{"Summon Jade Serpent Statue","[@cursor]",""},{"Rushing Jade Wind","",""},}) or "!Spinning Crane Kick"))
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..(Get_Spell({{"Summon White Tiger Statue","[mod:shift,@player][@cursor]",""},{"Weapons of Order","",""},{"Refreshing Jade Wind","",""},{"Summon Jade Serpent Statue","[mod:shift,@player][@cursor]",""},{"Jadefire Stomp","",""},{"Bonedust Brew","",""},{"Thunder Focus Tea","",""},{"Rushing Jade Wind","",""},{"Invoke Xuen, the White Tiger","",""},{"Storm, Earth, and Fire","",""},{"Serenity","",""},}) or "!Spinning Crane Kick"))
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..(Get_Spell({{"Bonedust Brew","[mod:shift,@player][@cursor]",""},{"Invoke Xuen, the White Tiger","",""},{"Storm, Earth, and Fire","",""},{"Serenity","",""},{"Sheilun's Gift","",""},{"Revival","",""},{"Restoral","",""},{"Weapons of Order","",""},{"Invoke Niuzao, the Black Ox","",""},}) or "Haw'li's Hot & Spicy Chili"))
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Detox")
				EditMacro("WSxCSGen+3",nil,nil,"/use [mod:alt,@party4,help,nodead][@party2,help,nodead]Detox;Mulled Alterac Brandy\n/run if not InCombatLockdown() then local j,p,_=C_PetJournal _,p=j.FindPetIDByName(\"Alterac Brew-Pup\") if p and j.GetSummonedPetGUID()~=p then j.SummonPetByGUID(p) end end")
				EditMacro("WSxCSGen+4",nil,nil,"/use "..(Get_Spell("Enveloping Mist","[mod:alt,@party3,help,nodead,nochanneling:Soothing Mist][@party1,help,nodead,nochanneling:Soothing Mist]Soothing Mist;[mod:alt,@party3,help,nodead][@party1,help,nodead]","") or "").."\n/use [nocombat,noexists]Totem of Harmony")
				EditMacro("WSxCSGen+5",nil,nil,"/use "..(Get_Spell("Enveloping Mist","[mod:alt,@party4,help,nodead,nochanneling:Soothing Mist][@party2,nodead,nochanneling:Soothing Mist]Soothing Mist;[mod:alt,@party4,help,nodead][@party2,help,nodead]","") or "").."\n/use [nocombat,noexists]Pandaren Brewpack\n/cancelaura Pandaren Brewpack")
				EditMacro("WSxGenQ",nil,nil,"#show\n/use "..(Get_Spell("Transcendence","[mod:shift]",";") or "")..(Get_Spell("Spear Hand Strike","[@mouseover,harm,nodead,nomod][harm,nodead,nomod]",";") or "")..(Get_Spell("Paralysis","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]","") or "").."\n/use [mod:shift]Celestial Defender's Medallion;The Golden Banana")
				EditMacro("WSxGenE",nil,nil,"#show "..(Get_Spell({{"Flying Serpent Kick","",""},{"Clash","[@mouseover,harm,nodead][]",""},{"Soothing Mist","[@mouseover,help,nodead][]",""},{"Song of Chi-Ji","",""},{"Ring of Peace","",""},}) or "").."\n/use Prismatic Bauble\n/use [mod:alt]Leg Sweep;"..(Get_Spell({{"Flying Serpent Kick","",""},{"Soothing Mist","[@mouseover,help,nodead][]",""},{"Song of Chi-Ji","",""},{"Ring of Peace","",""},{"Clash","[@mouseover,harm,nodead][]",""},}) or "").."\n/targetenemy [noexists]")
				EditMacro("WSxCGen+E",nil,nil,"#show Roll\n/use Expel Harm"..oOtas..covToys.."\n/use A Collection Of Me")
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..(Get_Spell("Ring of Peace","[mod:alt,@player]",";") or "")..(Get_Spell({{"Song of Chi-Ji","",""},{"Clash","[@mouseover,harm,nodead][]",""},{"Summon Black Ox Statue","\n/target Black Ox\n/use [@cursor,nomod:alt]","\n/use [help,nodead]Provoke\n/targetlasttarget"},}) or "").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGenR",nil,nil,"#show\n/use "..(Get_Spell({{"Ring of Peace","[mod:shift,@cursor]",";"},{"Song of Chi-Ji","[mod:shift]",";"},}) or "")..(Get_Spell("Tiger's Lust","[mod:ctrl,@player][@mouseover,help,nodead][help,nodead]",";") or "")..(Get_Spell("Disable","[]",";") or "").."[@mouseover,harm,nodead][]Crackling Jade Lightning")
				EditMacro("WSxGenT",nil,nil,"#show "..(Get_Spell({{"Revival","",""},{"Restoral","",""},{"Black Ox Brew","",""},{"Summon Jade Serpent Statue","",""},{"Summon Black Ox Statue","",""},{"Mystic Touch","",""},}) or "Crackling Jade Lightning").."\n/use [@mouseover,harm,nodead][harm,nodead]Crackling Jade Lightning"..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+T",nil,nil,"#show\n/targetenemy [noexists]\n/cleartarget [dead]\n/use Provoke")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..(Get_Spell("Summon Black Ox Statue","\n/target Black Ox\n/use [mod:alt,@player][@cursor]","\n/use [help,nodead]Provoke\n/targetlasttarget") or "")..(Get_Spell("Summon Jade Serpent Statue","[mod:alt,@player][@cursor]",";") or "")..(Get_Spell("Summon White Tiger Statue","[mod:alt,@player][@cursor]",";") or "").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..(Get_Spell("Tiger's Lust","","") or "Roll"))
				EditMacro("WSxGenF",nil,nil,"#show "..(Get_Spell("Transcendence","",": Transfer") or "Crackling Jade Lightning").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;"..(Get_Spell({{"Spear Hand Strike","[@focus,harm,nodead]",""},{"Paralysis","[@focus,harm,nodead]",""},}) or "").."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+F",nil,nil,"/use [help,nocombat,mod:alt]B. B. F. Fist;[nocombat,noexists,mod:alt]Gastropod Shell;"..(Get_Spell({{"Dampen Harm","",""},{"Clash","[@mouseover,harm,nodead][]",""},{"Diffuse Magic","",""},{"Jadefire Stomp","",""},}) or "Leg Sweep").."\n/use [nocombat]Mulled Alterac Brandy\n/cancelaura [mod]Purple Phantom")
				EditMacro("WSxCGen+F",nil,nil,"#show "..(Get_Spell({{"Touch of Karma","",""},{"Mana Tea","",""},{"Zen Meditation","",""},{"Zen Pilgrimage","",""},}) or "Fortitude of Niuzao").."\n/use "..(Get_Spell({{"Touch of Karma","",""},{"Revival","",""},{"Restoral","",""},{"Zen Meditation","",""},}) or "").."\n/cancelaura Celestial Defender")
				EditMacro("WSxCAGen+F",nil,nil,"#show "..(Get_Spell("Leg Sweep","[combat][exists,nodead]",";") or "").."Silversage Incense\n/targetfriendplayer\n/use [help,nodead]Tiger's Lust;Silversage Incense\n/targetlasttarget")
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt,nomounted,nocombat,noexists]Darkmoon Gazer;[mod:alt]Nimble Brew;"..(Get_Spell("Detox","[@mouseover,help,nodead][]","") or "Totem of Harmony"))
				EditMacro("WSxSGen+G",nil,nil,"#show "..(Get_Spell({{"Diffuse Magic","\n/use ",""},{"Dampen Harm","\n/use ",""},}) or "").."\n/use Pandaren Scarecrow\n/use [noexists,nocombat]Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(Get_Spell("Summon White Tiger Statue","[mod:alt,@player][@cursor]",";") or "")..(Get_Spell("Summon Black Ox Statue","\n/target Black Ox\n/use [mod:alt,@player][@cursor]","\n/use [help,nodead]Provoke\n/targetlasttarget") or "")..(Get_Spell("Summon Jade Serpent Statue","[mod:alt,@player][@cursor]",";") or "").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxCSGen+G",nil,nil,"#show "..(Get_Spell("Transcendence","","") or "Tiger Palm").."\n/use [@focus,help,nodead]Detox\n/cancelaura Blessing of Protection\n/cancelaura Words of Akunda")
				EditMacro("WSxGenZ",nil,nil,"#show "..(Get_Spell("Fortifying Brew") or "").."\n/use [mod:alt]Gateway Control Shard;"..(Get_Spell({{"Healing Elixir","[nomod]",";"},{"Dampen Harm","[nomod]",";"},{"Diffuse Magic","[nomod]",""},}) or "")..(Get_Spell({{"Fortifying Brew","[mod:shift][nomod]",";"},{"Diffuse Magic","[mod:shift][nomod]",""},}) or "").."\n/use Lao Chin's Last Mug")
				EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt]Tumblerun Brew;[mod:ctrl]Zen Pilgrimage;[mod:shift]Transcendence: Transfer;"..(Get_Spell({{"Celestial Brew","",""},{"Touch of Karma","[@mouseover,harm,nodead][nodead]",""},{"Life Cocoon","[@mouseover,help,nodead][nodead]",""},}) or "Cherry Blossom Trail"))
				EditMacro("WSxGenC",nil,nil,"#show\n/use "..(Get_Spell({{"Mana Tea","[mod:shift]",";"},{"Black Ox Brew","[mod:shift]",";"},}) or "")..(Get_Spell({{"Purifying Brew","[nomod]",";"},{"Renewing Mist","[@mouseover,help,nodead,nomod][nomod]",";"},{"Soothing Mist","[@mouseover,help,nodead,nomod][nomod]",";"},}) or "[nomod]Essence of Yu'lon")..(Get_Spell("Paralysis","[mod,@mouseover,harm,nodead][mod][@mouseover,harm,nodead][]",";") or "").."\n/cancelaura X-Ray Specs")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/click TotemFrameTotem1 RightButton\n/run PetDismiss()\n/use [noexists,nocombat]Turnip Punching Bag")
				EditMacro("WSxGenV",nil,nil,"#show\n/cast Roll\n/use Cherry Blossom Trail\n/use Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Ruthers' Harness\n/use Prismatic Bauble")
			-- Paladin, bvk, palajong
			elseif class == "PALADIN" then
				EditMacro("WSxGen1",nil,nil,"/use "..(Get_Spell("Intercession","[@mouseover,help,dead][help,dead]",";") or "")..(Get_Spell("Holy Shock","[@mouseover,exists,nodead][exists,nodead]",";") or "")..(Get_Spell({{"Crusader Aura","[nostance:2]!Devotion Aura;[nostance:2]",";"},{"Devotion Aura","[nostance:1]!",";"},}) or "").."Judgment\n/use Pretty Draenor Pearl\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+1",nil,nil,"#show "..(Get_Spell("Blessing of Protection") or "").."\n/use [mod:alt,@party3,help,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Flash of Light\n/use Vindicator's Armor Polish Kit")
				EditMacro("WSxGen2",nil,nil,"#show\n/use "..(Get_Spell("Blessing of Summer","[@mouseover,help,nodead][help,nodead]",";") or "")..(Get_Spell("Crusader Strike","[known:404542,@mouseover,harm,nodead][known:404542]Judgment;","") or "").."\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]\n/cancelaura X-Ray Specs")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use [@party4,help,nodead,mod:alt][@mouseover,help,nodead][]Flash of Light\n/use Gnomish X-Ray Specs")
				EditMacro("WSxGen3",nil,nil,"/use "..(Get_Spell("Light of the Martyr","[@mouseover,help,nodead][help,nodead]",";") or "")..(Get_Spell("Hammer of Wrath","[@mouseover,harm,nodead][harm,nodead]",";") or "")..(Get_Spell("Contemplation") or "Holy Lightsphere").."\n/targetenemy [noexists]\n/stopspelltarget")
				EditMacro("WSxSGen+3",nil,nil,"/stopspelltarget\n/use "..(Get_Spell({{"Holy Armaments","[@mouseover,help,nodead][]",""},{"Blessing of Summer","",""},{"Execution Sentence","",""},{"Consecration","",""},}) or "").."\n/targetenemy [noexists]\n/use Soul Evacuation Crystal")
				EditMacro("WSxGen4",nil,nil,"/use [spec:2,help,nodead,nocombat]Dalaran Disc;[help,nodead,nocombat]Holy Lightsphere;"..(Get_Spell({{"Avenger's Shield","[@mouseover,harm,nodead][]",""},{"Blade of Justice","",""},{"Judgment","",""},}) or "").."\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
				EditMacro("WSxSGen+4",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell("Holy Shock","[@focus,help,nodead,mod:alt][@party1,nodead,mod:alt]",";") or "")..(Get_Spell({{"Moment of Glory","",""},{"Final Reckoning","[@mouseover,exists,nodead][@cursor]",""},{"Tyr's Deliverance","[@mouseover,help,nodead][]",""},}) or "Judgment").."\n/targetenemy [noexists]")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/targetenemy [noexists]\n/use "..(Get_Spell("Holy Shock","[@party3,help,nodead,mod:alt]",";") or "")..(Get_Spell({{"Beacon of Faith","[@mouseover,help,nodead][]",""},{"Beacon of Light","[@mouseover,help,nodead][]",""},{"Crusader Aura","[nostance:2]!Devotion Aura;[nostance:2]",";"},{"Devotion Aura","[nostance:1]!",";"},}) or "").."\n/stopmacro\n/use Darkmoon Ring-Flinger")
				EditMacro("WSxGen5",nil,nil,"/use "..(Get_Spell({{"Ardent Defender","[mod:ctrl]",";"},{"Aura Mastery","[known:32223,mod:ctrl,stance:1][mod:ctrl,nostance]Devotion Aura;[mod:ctrl]",";"},}) or "")..(Get_Spell({{"Templar's Verdict","",""},{"Holy Light","[@mouseover,help,nodead][]",""},}) or "[spec:2,nocombat,noexists]Barrier Generator;[spec:2]Shield of the Righteous").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+5",nil,nil,"#show "..(Get_Spell({{"Divine Hammer","",""},{"Divine Favor","",""},{"Hand of Divinity","",""},}) or "").."\n/use "..(Get_Spell({{"Holy Shock","[@party2,help,nodead,mod:alt][@player]",""},{"Bastion of Light","",""},{"Divine Hammer","",""},{"Consecration","",""},{"Judgment","",""},}) or "").."\n/use [nocombat,noexists]Light in the Darkness")
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod:ctrl,@party4,help,nodead]Holy Shock;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14")
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..(Get_Spell("Avenging Wrath","[mod:ctrl]",";") or "")..(Get_Spell("Divine Storm","","") or "Shield of the Righteous").."\n/use [mod:ctrl] 19\n/targetenemy [noexists]")
				EditMacro("WSxSGen+6",nil,nil,"#show\n/use "..(Get_Spell({{"Final Reckoning","[@player]",""},{"Eye of Tyr","",""},{"Light of Dawn","",""},{"Consecration","",""},}) or ""))
				EditMacro("WSxGen7",nil,nil,"#show "..(Get_Spell({{"Holy Prism","",""},{"Wake of Ashes","",""},{"Consecration","",""},}) or "").."\n/targetenemy [noexists]\n/stopspelltarget\n/use "..(Get_Spell({{"Holy Prism","[@player,mod:shift][@mouseover,exists,nodead][exists,nodead]",""},{"Wake of Ashes","",""},{"Consecration","",""},}) or ""))
				EditMacro("WSxGen8",nil,nil,"#show "..(Get_Spell({{"Divine Toll","",""},{"Light's Hammer","",""},}) or "Shield of the Righteous").."\n/targetenemy [noexists]\n/stopspelltarget\n/use "..(Get_Spell({{"Divine Toll","[mod,@player][@mouseover,exists,nodead][exists,nodead]",""},{"Light's Hammer","[mod,@player][@mouseover,exists,nodead][@cursor]",""},}) or "Shield of the Righteous"))
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..(Get_Spell("Consecration","","") or "Auto Attack"))
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,spec:1,@party3,help,nodead][spec:1,@party1,help,nodead][spec:1,@targettarget,help,nodead]Cleanse;"..(Get_Spell("Cleanse Toxins","[mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]","") or ""))
				EditMacro("WSxCSGen+3",nil,nil,"/use [mod:alt,spec:1,@party4,help,nodead][spec:1,@party2,help,nodead]Cleanse;"..(Get_Spell("Cleanse Toxins","[mod:alt,@party4,help,nodead][@party2,help,nodead]","") or "").."\n/use [nocombat,noharm]Forgotten Feather")
				EditMacro("WSxCSGen+4",nil,nil,"/use [mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Word of Glory")
				EditMacro("WSxCSGen+5",nil,nil,"/use [mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]Word of Glory")
				EditMacro("WSxGenQ",nil,nil,"/use "..(Get_Spell("Repentance","[mod:alt,@focus,harm,nodead]",";") or "").."[mod:shift]Divine Shield;"..(Get_Spell({{"Rebuke","[@mouseover,harm,nodead][]",";"},{"Hammer of Justice","[@mouseover,harm,nodead][]",";"},}) or ""))
				EditMacro("WSxGenE",nil,nil,"#show\n/use "..(Get_Spell({{"Divine Favor","[mod:alt]",";"},{"Hand of Divinity","[mod:alt]",";"},}) or "").."[@mouseover,help,nodead][]Word of Glory")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/cast [@mouseover,help,nodead][]Lay on Hands\n/use [help,nodead]Apexis Focusing Shard\n/stopspelltarget"..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..(Get_Spell({{"Repentance","[@mouseover,harm,nodead][]",""},{"Blinding Light","",""},}) or "Hammer of Justice"))
				EditMacro("WSxGenR",nil,nil,(Get_Spell("Aura Mastery","#show ","\n") or "").."/use "..(Get_Spell("Divine Steed","[mod:ctrl]",";") or "")..(Get_Spell("Blessing of Freedom","[@mouseover,help,nodead][help,nodead]",";") or "")..(Get_Spell("Avenger's Shield","[@mouseover,harm,nodead][]","") or "Judgment").."\n/use [mod:ctrl]Prismatic Bauble")
				EditMacro("WSxGenT",nil,nil,"/stopspelltarget\n/use "..(Get_Spell({{"Holy Armaments","[mod:alt,@player][@mouseover,exists,nodead][@cursor]",""},{"Turn Evil","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";"},}) or "")..swapblaster.."\n/use Titanium Seal of Dalaran\n/use \n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat]Wayfarer's Bonfire")
				EditMacro("WSxSGen+T",nil,nil,"#show\n/use Hand of Reckoning")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..(Get_Spell("Bestow Faith","[mod:alt,@party2,nodead]",";") or "").."[@party4,help,nodead]Word of Glory")
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..(Get_Spell({{"Repentance","",""},{"Blinding Light","",""},}) or "Hammer of Justice"))
				EditMacro("WSxGenF",nil,nil,"#show "..(Get_Spell("Blessing of Freedom") or "").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;"..(Get_Spell("Rebuke","[@focus,harm,nodead]",";") or "").."[exists,nodead]Apexis Focusing Shard")
				EditMacro("WSxSGen+F",nil,nil,"#show\n/use "..(Get_Spell({{"Divine Favor","[nomod:alt]",";"},{"Hand of Divinity","[nomod:alt]",";"},{"Avenger's Shield","[nomod:alt,@focus,harm,nodead]",";"},}) or "").."[help,nocombat]B. F. F. Necklace;[nocombat,noexists]Gastropod Shell"..(Get_Spell("Contemplation",";","") or ";Holy Lightsphere)"))
				EditMacro("WSxCGen+F",nil,nil,"#show\n/use Sense Undead")
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]Darkmoon Gazer"..(Get_Spell({{"Cleanse Toxins",";[@mouseover,help,nodead][]",""},{"Cleanse",";[@mouseover,help,nodead][]",""},}) or ""))
			    EditMacro("WSxSGen+G",nil,nil,"#show\n/use [mod:alt,@focus,harm,nodead][]Hammer of Justice\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]")
				EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(Get_Spell("Bestow Faith","[mod:alt,@party1,nodead]",";") or "").."[@party3,help,nodead]Word of Glory;")
				EditMacro("WSxCSGen+G",nil,nil,"#show Divine Shield\n/use [@focus,help,nodead]Cleanse\n/cancelaura Divine Shield\n/cancelaura Blessing of Protection")
				EditMacro("WSxGenH",nil,nil,"#show Intercession\n/use [nomounted]Darkmoon Gazer\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenZ",nil,nil,"/use "..(Get_Spell("Blessing of Protection","[@mouseover,help,nodead,mod:shift][mod:shift]",";") or "")..(Get_Spell("Blessing of Sacrifice","[@mouseover,help,nodead,nomod][help,nodead,nomod]",";") or "")..(Get_Spell({{"Divine Protection","[nomod]",";"},{"Guardian of Ancient Kings","[nomod]",";"},}) or "[nomod]Divine Shield")..(Get_Spell({{"Rite of Adjuration(Weapon Imbue)","[mod:alt]","\n/use [mod:alt]16"},{"Rite of Sanctification(Weapon Imbue)","[mod:alt]","\n/use [mod:alt]16"},}) or "").."\n/use [mod:alt]Gateway Control Shard")
				EditMacro("WSxAGen+C",nil,nil,"#show [mod]Sylvanas' Music Box;Lay on Hands\n/use !Concentration Aura")
				EditMacro("WSxGenV",nil,nil,"#show\n/use "..(Get_Spell({{"Beacon of Light","[@mouseover,help,nodead][]",""},{"Divine Steed","",""},}) or "").."\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use [nospec:1]Prismatic Bauble")
				EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxCGen+G\",nil,nil,\"/use [@\"..B..\",known:Blessing of Summer]Blessing of Summer\\n/stopspelltarget\", nil)print(\"BoS set to : \"..B)else print(\"Nope!\")end")
				EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxCGen+T\",nil,nil,\"/use [@\"..N..\",known:Blessing of Autumn]Blessing of Summer\\n/stopspelltarget\", nil)print(\"BoA set to : \"..N)else print(\"Nööp!\")end")	
			-- Hunter, hanter 
			elseif class == "HUNTER" then
				EditMacro("WSxGen1",nil,nil,"/use [known:127933,nocombat,noexists]Fireworks;[help,nodead]Corbyn's Beacon;"..(Get_Spell("Black Arrow","[@mouseover,harm,nodead,spec:1][spec:1]",";Steady Shot") or "Steady Shot").."\n/targetenemy [noexists]\n/equipset [noequipped:Bows/Crossbows/Guns]DoubleGate\n/use [nocombat,noexists]Mrgrglhjorn")
				EditMacro("WSxSGen+1",nil,nil,"#show Aspect of the Cheetah\n/use [mod:ctrl,@party2,help,nodead][mod:shift,@pet][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Spirit Mend\n/use [noexists,nocombat]Whitewater Carp\n/targetexact Talua")
				EditMacro("WSxGen2",nil,nil,"/use "..(Get_Spell("Misdirection","[@mouseover,help,nodead][help,nodead]",";") or "")..(Get_Spell({{"Barbed Shot","[@mouseover,harm,nodead][harm,nodead]",";"},{"Rapid Fire","[@mouseover,harm,nodead][harm,nodead]",";"},{"Serpent Sting","[@mouseover,harm,nodead][harm,nodead]",";"},{"Harpoon","[@mouseover,harm,nodead][harm,nodead]",";"},{"Barrage","[@mouseover,harm,nodead,known:265895][harm,nodead,known:265895]",";"},{"Explosive Shot","[@mouseover,harm,nodead][harm,nodead]",";"},}) or "").."[harm,dead]Fetch;Corbyn's Beacon\n/targetlasttarget [noharm,nodead,nocombat]\n/targetenemy [noharm]")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use [spec:1,pet,nopet:Spirit Beast][spec:3,pet]Dismiss Pet;[nopet]Call Pet 2;[@mouseover,help,nodead,pet:Spirit Beast][pet:Spirit Beast,help,nodead][pet:Spirit Beast,@player]Spirit Mend;[spec:3]Arcane Shot;Dismiss Pet\n/use Totem of Spirits")
				EditMacro("WSxSGen+3",nil,nil,"/startattack\n/use "..(Get_Spell({{"Wildfire Bomb","[@mouseover,harm,nodead,nomod:alt][nomod:alt]","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [mod:alt]Wildfire Bomb\n/targetlasttarget"},{"A Murder of Crows","",""},{"Bloodshed","",""},{"Serpent Sting","",""},{"Stampede","",""},{"Death Chakram","",""},{"Dire Beast","",""},{"Wailing Arrow","",""},}) or "Hunter's Call"))
				EditMacro("WSxGen4",nil,nil,"#show\n/use [harm,dead]Gin-Ji Knife Set;[help,nodead]Dalaran Disc;"..(Get_Spell({{"Aimed Shot","[harm,nodead]",";"},{"Kill Command","[@mouseover,harm,nodead][harm,nodead]",";"},}) or "").."Puntable Marmot\n/target Puntable Marmot\n/targetenemy [noexists]\n/startattack [harm,combat]\n/cleartarget [dead]\n/use Squeaky Bat")
				override = "[nocombat,noexists]Owl Post;"
				if (classk == "PIRATE") then
					override = "" 
				end
				EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noharm]\n/cleartarget [dead]\n/use "..override..(Get_Spell({{"Flanking Strike","[nomod:alt]",""},{"Steel Trap","[@cursor,nomod:alt]",""},{"Explosive Shot","[@mouseover,harm,nodead][]",""},{"Dire Beast","",""},{"Wailing Arrow","",""},{"Chimaera Shot","",""},{"Serpent Sting","[nomod:alt]",""},{"Misdirection","[nomod:alt]",""},{"Kill Command","[nomod:alt]","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [mod:alt]Kill Command\n/targetlasttarget"},}) or ""))
				EditMacro("WSxCGen+4",nil,nil,"/stopspelltarget\n/cast "..(Get_Spell({{"Call of the Wild","",""},{"Salvo","",""},{"Fury of the Eagle","",""},{"Spearhead","",""},{"Death Chakram","",""},{"Stampede","",""},{"Barrage","",""},{"Eyes of the Beast","",""},}) or "Hunter's Call"))
				EditMacro("WSxGen5",nil,nil,"/use [mod]Exhilaration\n/use [mod]Fortitude of the Bear;[help,nodead]Silver-Plated Turkey Shooter;"..(Get_Spell({{"Raptor Strike","[equipped:Two-Hand]",";Arcane Shot"},}) or "Arcane Shot").."\n/use [mod]Skoller's Bag of Squirrel Treats\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use [nocombat,noexists]Pandaren Scarecrow;Hunter's Mark\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGen6",nil,nil,"/stopspelltarget\n/use "..(Get_Spell({{"Bestial Wrath","[mod]",";"},{"Trueshot","[mod]",";"},{"Coordinated Assault","[mod]",";"},}) or "").."[nocombat,noexists]Twiddle Twirler: Sentinel's Glaive;"..(Get_Spell({{"Carve","",""},{"Butchery","",""},{"Multi-Shot","[@mouseover,harm,nodead][]",""},{"Steel Trap","[@mouseover,exists,nodead][@cursor]",""},}) or "").."\n/startattack\n/equipset [noequipped:Two-Hand,spec:3]Menkify!")
				EditMacro("WSxSGen+6",nil,nil,"#show\n/use [nocombat,noexists]Laser Pointer\n/use "..(Get_Spell({{"Steel Trap","[@player]",""},{"Barrage","",""},{"Aspect of the Eagle","",""},{"Stampede","",""},{"Death Chakram","",""},{"A Murder of Crows","",""},{"Bloodshed","",""},{"Rapid Fire","",""},{"Carve","","Carve"},{"Butchery","",""},}) or "Laser Pointer"))
				EditMacro("WSxGen7",nil,nil,"#showtooltip "..(Get_Spell("Volley","[mod:shift,@player]",";") or "")..(Get_Spell({{"Aspect of the Wild","",""},{"Explosive Shot","",""},{"Aspect of the Eagle","",""},{"Barrage","",""},{"Stampede","",""},{"Death Chakram","",""},{"Rapid Fire","",""},}) or "").."\n/use Champion's Salute\n/use Words of Akunda\n/cancelaura Chasing Storm\n/use Chasing Storm\n/use "..(Get_Spell("Volley","[mod:shift,@player]",";") or "")..(Get_Spell({{"Aspect of the Wild","",""},{"Explosive Shot","[@mouseover#,harm,nodead][]",""},{"Barrage","",""},{"Aspect of the Eagle","",""},{"Stampede","",""},{"Death Chakram","",""},{"Rapid Fire","",""},}) or ""))
				EditMacro("WSxGen8",nil,nil,"#show "..(Get_Spell({{"Spearhead","",""},{"Aspect of the Eagle","",""},{"Volley","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Wailing Arrow","",""},{"Stampede","",""},{"Death Chakram","",""},}) or "Hunter's Call").."\n/stopspelltarget\n/use "..(Get_Spell("Salvo","","\n/use ") or "")..(Get_Spell({{"Spearhead","",""},{"Aspect of the Eagle","",""},{"Volley","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Wailing Arrow","",""},{"Stampede","",""},{"Death Chakram","",""},}) or "Hunter's Call"))
				EditMacro("WSxGen9",nil,nil,"#show\n/use [mod:shift]Command Pet"..(Get_Spell({{"Sentinel Owl",";",""},{"Aspect of the Wild",";",""},{"Kill Command",";",""},}) or ";Hunter's Call"))
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Misdirection")
				EditMacro("WSxCSGen+3",nil,nil,"/use [mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]Misdirection;[nocombat,noharm]Cranky Crab")
				EditMacro("WSxCSGen+4",nil,nil,"/use [nospec:3,nomounted]Safari Hat;[nomounted]Gnomish X-Ray Specs\n/run ZigiHunterTrack(not IsAltKeyDown())")
				EditMacro("WSxCSGen+5",nil,nil,"/run local c,arr = C_Minimap,{12,11,10,9,8,6,5,4,7,1} for _,v in pairs(arr) do local name, _, active = c.GetTrackingInfo(v) if (name and active ~= true) then active = true c.SetTracking(v,true) return active end end\n/use Overtuned Corgi Goggles")
				EditMacro("WSxGenQ",nil,nil,"/use [mod:alt,@player]Freezing Trap;[mod:shift]!Aspect of the Turtle;"..(Get_Spell({{"Muzzle","[@mouseover,harm,nodead][harm,nodead]",";"},{"Counter Shot","[@mouseover,harm,nodead][harm,nodead]",";"},{"Harpoon","[@mouseover,harm,nodead][harm,nodead]",";"}}) or "").."The Golden Banana\n/use Angler's Fishing Spear")
				EditMacro("WSxGenE",nil,nil,"/targetenemy [noharm]\n/stopspelltarget\n/use [mod:alt,@mouseover,exists,nodead][mod:alt,@cursor]Flare;"..(Get_Spell({{"Bursting Shot","",";"},{"Scatter Shot","[@mouseover,harm,nodead][harm,nodead]",";"},{"Harpoon","[@mouseover,harm,nodead][harm,nodead]",";"},{"Intimidation","[@mouseover,harm,nodead][harm,nodead]",";"},{"Binding Shot","[@mouseover,exists,nodead][@cursor]",";"},{"Kill Command","[@mouseover,exists,nodead][@cursor]",";"},}) or "").."[nocombat]Party Totem\n/cleartarget [dead]\n/equipset [noequipped:Two-Hand,spec:3,nomod]Menkify!")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(Get_Spell({{"Binding Shot","[mod:alt,@player]",";"},{"Scatter Shot","[mod:alt,@focus,harm,nodead]",";"},}) or "")..(Get_Spell("Misdirection","[@mouseover,help,nodead][help,nodead][@focus,help,nodead][pet,@pet]","") or "")..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"/stopspelltarget\n/use "..(Get_Spell("Tar Trap","[mod:alt,@player]",";") or "")..(Get_Spell({{"Binding Shot","[@mouseover,exists,nodead][@cursor]",""},{"Scatter Shot","",""},}) or "[@player]Flare").."\n/use [nocombat,noexists]Goblin Fishing Bomb\n/use Bloodmane Charm")
				EditMacro("WSxGenT",nil,nil,"#show Feign Death\n/use [@mouseover,harm,nodead][harm,nodead]Hunter's Mark;Hunter's Call"..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]\n/petattack [@mouseover,harm,nodead][harm,nodead]")
				EditMacro("WSxSGen+T",nil,nil,"/stopspelltarget\n/use "..(Get_Spell({{"Intimidation","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]",""},{"High Explosive Trap","[mod:alt,@player][@mouseover,exists,nodead][@cursor]",""},{"Sentinel","[mod:alt,@player][@mouseover,exists,nodead][@cursor]",""},{"Fetch","",""},}) or "Hunter's Call"))
			    EditMacro("WSxCGen+T",nil,nil,"/stopspelltarget\n/use "..(Get_Spell({{"High Explosive Trap","[mod:alt,@player][@mouseover,exists,nodead][@cursor]",""},{"Implosive Trap","[mod:alt,@player][@mouseover,exists,nodead][@cursor]",""},}) or "").."\n/use Everlasting Darkmoon Firework\n/use Pandaren Firework Launcher\n/use Azerite Firework Launcher\n/use "..factionFireworks)
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..(Get_Spell({{"Binding Shot","",""},{"Scatter Shot","",""},}) or "Silver-Plated Turkey Shooter"))
				EditMacro("WSxGenF",nil,nil,"#show "..(Get_Spell("Tar Trap") or "").."\n/focus [@mouseover,exists]mouseover\n/stopmacro [@mouseover,exists]\n/use [@cursor,mod,known:Eagle Eye]!Eagle Eye;"..(Get_Spell({{"Muzzle","[@focus,harm,nodead]",";"},{"Counter Shot","[@focus,harm,nodead]",";"},}) or "").."[@mouseover,harm,nodead][]Hunter's Mark\n/targetenemy [noharm][dead]")
				EditMacro("WSxSGen+F",nil,nil,"#show Freezing Trap\n/targetenemy [noexists]Robo-Gnomebulator\n/use [nocombat,noexists]Gastropod Shell\n/use \n/stopmacro [mod:ctrl]\n/petautocasttoggle Growl\n/petautocasttoggle [mod:alt]Spirit Walk")
				EditMacro("WSxCGen+F",nil,nil,"#show Flare\n/run for i = 4,12 do C_Minimap.SetTracking(i,false) end C_Minimap.SetTracking(1,false);\n/cancelaura [nospec:3]Safari Hat;X-Ray Specs\n/cancelaura Will of the Taunka\n/cancelaura Will of the Vrykul\n/cancelaura Will of the Iron Dwarves")
				EditMacro("WSxCAGen+F",nil,nil,"#show Exhilaration\n/run if not InCombatLockdown() then if C_Spell.GetSpellCooldown(5384).duration==0 then "..tpPants.." else "..noPants.." end end")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(Get_Spell({{"Tranquilizing Shot","[@mouseover,harm,nodead][]",""},{"Eyes of the Beast","",""},}) or "Hunter's Call").."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxCGen+G",nil,nil,"#show\n/use [@mouseover,help,nodead][]Roar of Sacrifice")
				EditMacro("WSxCSGen+G",nil,nil,"#show "..(Get_Spell({{"Camouflage","",""},{"Scare Beast","",""},}) or "").."\n/cancelaura Whole-Body Shrinka'\n/cancelaura Growing Pains\n/cancelaura Aspect of the Turtle\n/use Choofa's Call\n/cancelaura Chasing Storm\n/cancelaura Enthralling\n/cancelaura Words of Akunda")
				EditMacro("WSxGenZ",nil,nil,"#show [mod,pet,@pet,nodead]Play Dead;[mod]Revive Pet;"..(Get_Spell("Survival of the Fittest","[nomod]","") or "[nomod]Feign Death").."\n/use [mod:alt]Gateway Control Shard;[mod,pet,@pet,nodead]Play Dead;[mod]Revive Pet;"..(Get_Spell("Survival of the Fittest","[nomod]","") or "[nomod]Feign Death").."\n/use Personal Hologram")
				EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt,exists]Beast Lore;[mod:ctrl,exists,nodead]Tame Beast;[mod]Aspect of the Cheetah;!Aspect of the Turtle\n/use Super Simian Sphere\n/use Angry Beehive\n/use The Super Shellkhan Gang")
				EditMacro("WSxGenC",nil,nil,"/target [@pet,pet:Crab]\n/stopspelltarget\n/use [mod,@mouseover,exists,nodead][mod,@cursor]Freezing Trap;[nopet]Call Pet 3;[pet:Crab,help,pet,nocombat]Crab Shank;[pet,nodead]Mend Pet\n/use Totem of Spirits\n/targetlasttarget [help,nodead,pet,pet:Crab]")
				EditMacro("WSxAGen+C",nil,nil,"#show [mod]Hunter's Mark;Play Dead\n/use [mod:ctrl,@player]Freezing Trap;Dismiss Pet\n/stopmacro [mod:ctrl]\n/click TotemFrameTotem1 RightButton\n/use Crashin' Thrashin' Robot")
				EditMacro("WSxGenV",nil,nil,"#show\n/cast Disengage\n/stopcasting\n/use Crashin' Thrashin' Robot\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Ruthers' Harness\n/use Bom'bay's Color-Seein' Sauce\n/use Prismatic Bauble\n/use Desert Flute")
				EditMacro("WSxCAGen+B",nil,nil,"")
				EditMacro("WSxCAGen+N",nil,nil,"")	
			-- Rogue, rogge, rouge, raxicil
			elseif class == "ROGUE" then
				EditMacro("WSxGen1",nil,nil,"/use [nocombat,nostealth]Xan'tish's Flute\n/use "..(Get_Spell("Tricks of the Trade","[@mouseover,help,nodead][help,nodead]",";") or "").."[stance:0,nocombat]Stealth;"..(Get_Spell({{"Cold Blood","",""},{"Echoing Reprimand","",""},{"Pistol Shot","",""},{"Thistle Tea","",""},}) or "").."\n/targetenemy [noexists]\n/startattack [combat]")
				EditMacro("WSxSGen+1",nil,nil,"#show Vanish\n/use "..(Get_Spell("Shadowstep","[mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][]",";") or "")..(Get_Spell("Tricks of the Trade","[]","") or "").."\n/targetexact Lucian Trias")
				EditMacro("WSxGen2",nil,nil,"/targetenemy [noexists]\n/use [nocombat,help]Corbyn's Beacon;[stealth,nostance:3,nodead]Pick Pocket;Sinister Strike\n/use !Stealth\n/cleartarget [exists,dead]\n/stopspelltarget")
				EditMacro("WSxSGen+2",nil,nil,"#show "..(Get_Spell("Shuriken Tornado") or "").."\n/cast Crimson Vial\n/use [nostealth] Totem of Spirits\n/use [nostealth]Hourglass of Eternity\n/use [nocombat,nostealth,spec:2]Don Carlos' Famous Hat;[nocombat,nostealth]Dark Ranger's Spare Cowl")
				EditMacro("WSxGen3",nil,nil,"/use [stance:0,nocombat]Stealth;"..(Get_Spell("Shadow Dance","[spec:3,harm,nodead]Symbols of Death\n/use [stance:0,combat]",";") or "").."[@mouseover,harm,nodead][]Ambush\n/targetenemy [noexists]")
				EditMacro("WSxSGen+3",nil,nil,"#show\n/use [@mouseover,harm,nodead,nospec:2][nospec:2]Rupture;[spec:2]Between the Eyes\n/targetenemy [noexists]\n/use [spec:2,nocombat]Ghostly Iron Buccaneer's Hat;[nospec:2]Ravenbear Disguise")
				EditMacro("WSxGen4",nil,nil,"/use [nocombat,noexists,spec:2,nostealth]Dead Ringer\n/use [spec:1]Shiv;"..(Get_Spell("Ghostly Strike","[]",";") or "").."[@mouseover,harm,nodead][]Ambush\n/use !Stealth\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+4",nil,nil,"/use [nocombat,noexists,nostealth]Barrel of Eyepatches\n/use "..(Get_Spell({{"Garrote","[@mouseover,harm,nodead][]",""},{"Cold Blood","",""},{"Between the Eyes","",""},{"Pistol Shot","",""},}) or "Feint").."\n/use [nostealth,nospec:2]Hozen Beach Ball;[nostealth]Titanium Seal of Dalaran\n/targetenemy [noexists]\n/startattack [combat]\n/cleartarget [dead]")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..(Get_Spell({{"Killing Spree","",""},{"Dreadblades","",""},{"Keep It Rolling","",""},{"Goremaw's Bite","",""},{"Shuriken Tornado","",""},{"Kingsbane","",""},{"Cold Blood","",""},{"Thistle Tea","",""},{"Deathmark","","Deathmark"},{"Adrenaline Rush","",""},{"Shadow Blades","",""},}) or "").."\n/targetenemy [noexists,nocombat]\n/use [nocombat,noexists]Gastropod Shell")
				EditMacro("WSxGen5",nil,nil,"#show\n/use [combat,mod:ctrl]Vanish;Eviscerate\n/use !Stealth\n/targetenemy [noexists]\n/stopmacro [nomod:ctrl]\n/use [spec:2]Mr. Smite's Brass Compass;Shadescale\n/roar")
				EditMacro("WSxSGen+5",nil,nil,"/use [nocombat,noexists,nostealth]Barrel of Bandanas\n/use Slice and Dice\n/use [nocombat,noexists,nostealth] Worn Troll Dice")					
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..(Get_Spell({{"Deathmark","[mod:ctrl]",";"},{"Adrenaline Rush","[mod:ctrl]",";"},{"Shadow Blades","[mod:ctrl]",";"},}) or "")..(Get_Spell({{"Fan of Knives","",""},{"Blade Flurry","",""},{"Shuriken Storm","",""},}) or ""))
				EditMacro("WSxSGen+6",nil,nil,"/use "..(Get_Spell({{"Crimson Tempest","",""},{"Secret Technique","",""},{"Shuriken Tornado","",""},{"Black Powder","",""},{"Roll the Bones","",""},{"Blade Flurry","",""},}) or "").."\n/stopmacro\n/use Vanish")			
				EditMacro("WSxGen7",nil,nil,"#show\n/use "..(Get_Spell({{"Shuriken Tornado","[mod:shift]",";"},{"Keep It Rolling","[mod:shift]",";"},}) or "")..(Get_Spell({{"Black Powder","",""},{"Blade Rush","",""},{"Ghostly Strike","",""},{"Pistol Shot","",""},{"Thistle Tea","",""},{"Cold Blood","",""},}) or "").."\n/use Autographed Hearthstone Card\n/use !Stealth")
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..(Get_Spell({{"Exsanguinate","",""},{"Sepsis","",""},{"Keep It Rolling","",""},{"Ghostly Strike","",""},{"Shuriken Tornado","",""},{"Cold Blood","",""},{"Thistle Tea","",""},}) or "Sprint"))
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..(Get_Spell({{"Flagellation","",""},{"Serrated Bone Spike","",""},{"Keep It Rolling","",""},{"Sepsis","",""},{"Ghostly Strike","",""},{"Shadow Dance","",""},{"Numbing Poison","",""},{"Echoing Reprimand","",""},}) or "Evasion"))
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Tricks of the Trade")
				EditMacro("WSxCSGen+3",nil,nil,"/use [mod:alt,@party4,help,nodead][@party2,help,nodead]Tricks of the Trade")
				EditMacro("WSxCSGen+4",nil,nil,"/use [mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead]Tricks of the Trade;[nocombat,noexists]Crashin' Thrashin' Cannon Controller")
				EditMacro("WSxCSGen+5",nil,nil,"/use [mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]Tricks of the Trade")
				EditMacro("WSxGenQ",nil,nil,"#show\n/use "..(Get_Spell("Blind","[mod:alt,@focus,harm,nodead]",";") or "")..(Get_Spell("Cloak of Shadows","[mod:shift]",";") or "").."[@mouseover,harm,nodead][harm,nodead]Kick;The Golden Banana\n/use [spec:2]Rime of the Time-Lost Mariner;Sira's Extra Cloak\n/use [mod:shift]Poison Extraction Totem")
				EditMacro("WSxGenE",nil,nil,"/use "..(Get_Spell("Cheap Shot","[mod:alt,@focus,harm,nodead,nostance:0][nostance:0]",";") or "")..(Get_Spell("Shadow Dance","[stance:0,combat]",";") or "")..(Get_Spell("Vanish","[stance:0,combat]",";") or "").."\n/use !Stealth\n/use [nostealth,spec:2,nocombat]Iron Buccaneer's Hat")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(Get_Spell({{"Thistle Tea","",""},{"Tricks of the Trade","[@focus,help,nodead][@mouseover,help,nodead][help,nodead][@party1,help,nodead]",""},}) or "").."\n/use Seafarer's Slidewhistle"..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..(Get_Spell({{"Garrote","[mod:alt,@focus,harm,nodead,nostance:0][nostance:0]",";"},{"Cheap Shot","[mod:alt,@focus,harm,nodead,nostance:0][nostance:0]",";"},}) or "")..(Get_Spell("Shadow Dance","[stance:0,combat]",";") or "")..(Get_Spell("Vanish","[stance:0,combat]","") or "").."\n/use !Stealth\n/use [nostealth]Hourglass of Eternity")
				EditMacro("WSxGenR",nil,nil,"/stopspelltarget\n/use [@mouseover,exists,nodead,mod:ctrl][@cursor,mod:ctrl]Distract;"..(Get_Spell({{"Poisoned Knife","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";"},{"Pistol Shot","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";"},{"Shuriken Toss","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";"},}) or "")..(Get_Spell("Shadowstep","[@mouseover,help,nodead][help,nodead]",";") or "").."Horse Head Costume\n/targetenemy [noexists]")
				EditMacro("WSxGenT",nil,nil,"/use "..(Get_Spell("Gouge","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";") or "")..swapblaster.."\n/stopattack\n/targetenemy [noexists]\n/cleartarget [dead]\n/stopspelltarget\n/use !Stealth")
				EditMacro("WSxSGen+T",nil,nil,"#show "..(Get_Spell({{"Tricks of the Trade","",""},{"Shadowstep","",""},}) or "").."\n/stopspelltarget\n/use Titanium Seal of Dalaran\n/use [@mouseover,exists,nodead][@cursor]Grappling Hook\n/targetenemy [noexists]")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell("Grappling Hook","[@mouseover,exists,nodead][@cursor]",";") or "").."[mod:alt,@player][@mouseover,exists,nodead][@cursor]Distract")
				EditMacro("WSxGenU",nil,nil,"#show\n/use Sprint")
				if playerSpec == 1 then
					override = "Detoxified Blight Grenade"
				elseif playerSpec == 2 then
					override = "Crashin' Thrashin' Cannon Controller"
				else
					override = "Shadow Slicing Shortsword"
				end
				EditMacro("WSxGenF",nil,nil,"#show\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Kick;"..(Get_Spell("Detection","[noexists,nodead]",";") or "")..override)
				EditMacro("WSxSGen+F",nil,nil,"#show "..(Get_Spell({{"Grappling Hook","",""},{"Gouge","",""},}) or "Kick").."\n/use "..(Get_Spell("Shadowstep","[@focus,harm,nodead]","\n/use [@focus,harm,nodead]Kick\n/use [@cursor]Grappling Hook") or ""))
				EditMacro("WSxCGen+F",nil,nil,"#show "..(Get_Spell("Cloak of Shadows","","") or "").."\n/use "..(Get_Spell({{"Garrote","[nostance:0]",";"},{"Cheap Shot","[nostance:0]",";"},}) or "")..(Get_Spell("Vanish","[stance:0,combat]",";") or "").."\n/use !Stealth")
				EditMacro("WSxCAGen+F",nil,nil,"#show [nocombat,noexists,resting]Twelve-String Guitar;Distract\n/targetfriend [nohelp,nodead]\n/use [help,nodead]Shadowstep;[nocombat,noexists]Twelve-String Guitar\n/targetlasttarget")
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt,nocombat,noexists]Darkmoon Gazer;[@mouseover,harm,nodead][harm,nodead]Shiv;Pick Lock")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/targetenemy [noexists]\n/use [stance:0,nocombat]Stealth;[mod:alt,@focus,exists,nodead][]Kidney Shot\n/use [nocombat,noexists,stance:0]Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(Get_Spell("Cheap Shot","[mod:alt,@focus,harm,nodead,nostance:0][nostance:0]",";") or "")..(Get_Spell("Vanish","[stance:0,combat]",";") or "").."\n/use !Stealth")
				EditMacro("WSxCSGen+G",nil,nil,"#show Blind\n/use Totem of Spirits\n/use [@focus,harm,nodead]Gouge")	
				EditMacro("WSxGenH",nil,nil,"#show\n/use Crimson Vial\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenZ",nil,nil,"/use "..(Get_Spell("Wound Poison","[mod:alt]",";") or "")..(Get_Spell({{"Deadly Poison","[mod]",";"},{"Instant Poison","[mod]",";"},}) or "")..(Get_Spell("Evasion","[combat]",";") or "").."[stance:1]Shroud of Concealment\n/use !Stealth\n/use [mod:alt]Gateway Control Shard\n/use [spec:2,mod]Slightly-Chewed Insult Book;[mod]Shadowy Disguise")
				EditMacro("WSxGenX",nil,nil,"/use [mod:alt]Crippling Poison;[mod:ctrl]Scroll of Teleport: Ravenholdt;[mod:shift]Sprint;"..(Get_Spell("Feint","","") or "").."\n/use [nostealth,mod:shift]Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
				EditMacro("WSxGenC",nil,nil,"#show\n/targetenemy [noexists]\n/use "..(Get_Spell("Blind","[mod:ctrl,@mouseover,harm,nodead][mod:ctrl]",";") or "")..(Get_Spell("Amplifying Poison","[mod:shift]",";") or "").."[@mouseover,harm,nodead,nostance:0][nostance:0]Sap;Blind\n/use !Stealth\n/cancelaura Don Carlos' Famous Hat")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use "..(Get_Spell({{"Numbing Poison","",""},{"Atrophic Poison","",""},}) or "").."\n/run PetDismiss();")
				EditMacro("WSxGenV",nil,nil,"/use "..(Get_Spell({{"Shadowstep","[@mouseover,exists,nodead][]",""},{"Grappling Hook","[@cursor]",""},}) or "").."\n/targetenemy [noexists]\n/use [nostealth]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use [nostealth]Prismatic Bauble")
			-- Priest, Prist
			elseif class == "PRIEST" then
				EditMacro("WSxGen1",nil,nil,"/use [help,nodead,nocombat]The Heartbreaker;"..(Get_Spell("Power Infusion","[@mouseover,help,nodead][help,nodead]",";") or "")..(Get_Spell({{"Void Torrent","[@mouseover,harm,nodead][harm,nodead]",""},{"Premonition","",""},{"Mind Blast","[@mouseover,harm,nodead][harm,nodead]",""},{"Shadow Word: Pain","[@mouseover,harm,nodead][harm,nodead]",""}}) or "").."\n/startattack\n/use Xan'tish's Flute")
				EditMacro("WSxSGen+1",nil,nil,"#show "..(Get_Spell("Power Infusion") or "Shadow Word: Pain").."\n/use [mod:alt,@party3,nodead][mod:ctrl,@party2,exists][@focus,help][@party1,exists][@targettarget,exists]Flash Heal;Kaldorei Light Globe")
				EditMacro("WSxGen2",nil,nil,"/targetenemy [noexists]\n/cleartarget [dead]\n/cancelaura Fling Rings\n/use [nospec:3,help,nodead,nocombat]Holy Lightsphere;[help,nodead,nocombat]Corbyn's Beacon\n/use [@mouseover,harm,nodead][]Smite\n/use [nocombat]Darkmoon Ring-Flinger\n/use Haunting Memento")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use [mod:alt,@party4,nodead][@mouseover,help,nodead][]Flash Heal\n/use [nocombat,noexists,resting]Gnomish X-Ray Specs\n/cancelaura Don Carlos' Famous Hat\n/cancelaura X-Ray Specs")
				EditMacro("WSxGen3",nil,nil,"/targetenemy [noexists]\n/cleartarget [dead]\n/use "..(Get_Spell("Shadow Word: Death","[@mouseover,harm,nodead][harm,nodead]",";") or "")..(Get_Spell("Power Word: Life","[@mouseover,help,nodead,combat][help,nodead,combat]","") or "").."\n/use Scarlet Confessional Book\n/use [nocombat,noexists,spec:3]Twitching Eyeball")
				EditMacro("WSxSGen+3",nil,nil,"/targetenemy [noexists]\n/stopspelltarget\n/cleartarget [dead]\n/use "..(Get_Spell("Shadow Word: Pain","[@mouseover,harm,nodead,nomod:alt][nomod:alt]","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Shadow Word: Pain\n/targetlasttarget") or "").."\n/use Totem of Spirits")
				EditMacro("WSxGen4",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,noexists,nochanneling]Pretty Draenor Pearl\n/use "..(Get_Spell({{"Penance","[@mouseover,exists,nodead][]",""},{"Holy Word: Serenity","[@mouseover,help,nodead][]",""},{"Mind Blast","[@mouseover,harm,nodead][]",""},}) or ""))	
				EditMacro("WSxSGen+4",nil,nil,"/stopspelltarget\n/targetenemy [noexists]\n/use "..(Get_Spell({{"Penance","[@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]",";"},{"Prayer of Mending","[@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]",";"},}) or "")..(Get_Spell("Shadowform","[noform]",";") or "")..(Get_Spell({{"Vampiric Touch","[@mouseover,harm,nodead,nomod:alt][nomod:alt]","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Vampiric Touch\n/targetlasttarget"},{"Divine Star","",""},{"Halo","",""},{"Mindgames","",""},{"Prayer of Healing","[@mouseover,help,nodead][]",""},}) or ""))
				EditMacro("WSxCGen+4",nil,nil,"#show\n/cast "..(Get_Spell({{"Penance","[mod:alt,@party3,help,nodead]",";"},{"Prayer of Mending","[mod:alt,@party3,help,nodead]",";"},}) or "")..(Get_Spell({{"Ultimate Penitence","[@mouseover,help,nodead][]",""},{"Rapture","",""},{"Lightwell","[@cursor]",""},{"Divine Word","",""},{"Apotheosis","",""},{"Holy Word: Salvation","",""},{"Dark Void","",""},{"Power Infusion","",""},{"Void Torrent","",""},{"Mindgames","",""},}) or "").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGen5",nil,nil,"/targetenemy [noexists]\n/use "..(Get_Spell({{"Power Word: Barrier","[mod:ctrl,@cursor]",";"},{"Symbol of Hope","[mod:ctrl]",";"},{"Desperate Prayer","[mod:ctrl]",";"},}) or "")..(Get_Spell({{"Void Eruption","[@mouseover,harm,nodead][]",""},{"Dark Ascension","",""},{"Heal","[@mouseover,help,nodead][]",""},{"Mind Blast","[@mouseover,harm,nodead][]",""},}) or "").."\n/use [help,nodead]Apexis Focusing Shard\n/use [nocombat]Thaumaturgist's Orb\n/use [spec:3]Shadescale")
				EditMacro("WSxSGen+5",nil,nil,(Get_Spell({{"Devouring Plague","/targetenemy [noharm]\n/cleartarget [dead]\n/use [@mouseover,harm,nodead,nomod:alt][harm,nodead,nomod:alt]","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Devouring Plague\n/targetlasttarget"},{"Penance","/targetenemy [noharm]\n/cleartarget [dead]\n/use [@party2,help,nodead,mod:alt][@player]",";"},{"Prayer of Mending","/targetenemy [noharm]\n/cleartarget [dead]\n/use [@party2,help,nodead,mod:alt]",";"},}) or "/targetenemy [noharm]\n/cleartarget [dead]\n/use ")..(Get_Spell({{"Circle of Healing","[@mouseover,help,nodead][]",""},{"Holy Word: Chastise","[@mouseover,harm,nodead][]",""},}) or ""))
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use "..(Get_Spell({{"Penance","[mod:ctrl,@party4,help,nodead]",";"},{"Prayer of Mending","[mod:ctrl,@party4,help,nodead]",";"},}) or "").."[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14")
				EditMacro("WSxGen6",nil,nil,"#show\n/stopspelltarget\n/targetenemy [noexists]\n/cleartarget [dead]\n/use "..(Get_Spell({{"Divine Hymn","[mod:ctrl]",";"},{"Shadowfiend","[mod:ctrl]",";"},}) or "")..(Get_Spell({{"Holy Nova","",""},{"Divine Star","",""},{"Halo","",""},}) or "Shadow Word: Pain"))
				EditMacro("WSxSGen+6",nil,nil,"/use "..(Get_Spell({{"Prayer of Healing","[@mouseover,help,nodead][]",""},{"Power Word: Radiance","[@mouseover,help,nodead][]",""},{"Apotheosis","",""},{"Divine Star","",""},{"Halo","",""},{"Mindgames","",""},}) or "").."\n/use Cursed Feather of Ikzan\n/use [nocombat]Dead Ringer\n/targetenemy [noexists]")
				EditMacro("WSxGen7",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell({{"Holy Word: Sanctify","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Shadow Crash","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Divine Star","",""},{"Halo","",""},{"Power Word: Life","[@mouseover,help,nodead][]",""},{"Schism","",""},}) or "").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..(Get_Spell({{"Evangelism","[mod:shift]",";"},{"Lightwell","[@player,mod:shift]",";"},{"Power Infusion","[mod:shift,@focus,help,nodead][mod:shift,@mouseover,help,nodead][mod:shift]",";"},}) or "")..(Get_Spell({{"Void Torrent","",""},{"Divine Word","";""},{"Rapture","",""},{"Mindgames","[@mouseover,harm,nodead][]",""},{"Shadowfiend","",""},{"Power Infusion","",""},}) or ""))
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..(Get_Spell({{"Power Infusion","[mod:shift,@focus,help,nodead][mod:shift,@mouseover,help,nodead][mod:shift]",";"},}) or "")..(Get_Spell({{"Apotheosis","",""},{"Holy Word: Salvation","",""},{"Mindgames","[@mouseover,harm,nodead][]",""},{"Vampiric Embrace","",""},{"Evangelism","",""},{"Power Word: Barrier","",""},{"Rapture","",""},{"Shadow Covenant","[@mouseover,help,nodead][]",""},{"Apotheosis","",""},{"Holy Word: Salvation","",""},{"Void Torrent","",""},{"Power Infusion","",""},}) or ""))
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead,nospec:3][@party1,help,nodead,nospec:3][@targettarget,help,nodead,nospec:3]Purify;[mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Purify Disease\n/use Brynja's Beacon")
				EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Shadow Word: Pain;[mod:alt,@party4,help,nodead,nospec:3][@party2,help,nodead,nospec:3]Purify;[mod:alt,@party4,help,nodead][@party2,help,nodead]Purify Disease\n/use [nocombat,noharm]Forgotten Feather")
				EditMacro("WSxCSGen+4",nil,nil,"/use [spec:3,@focus,harm,nodead]Vampiric Touch;[mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Power Word: Shield;[nocombat]Romantic Picnic Basket\n/use [@party1]Apexis Focusing Shard")
				EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,spec:3,harm,nodead]Devouring Plague;[mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]Power Word: Shield\n/use Battle Standard of Coordination\n/use [@party2]Apexis Focusing Shard")
				EditMacro("WSxGenQ",nil,nil,"#show\n/use "..(Get_Spell({{"Mind Control","[mod:alt,@focus,harm,nodead]",";"},{"Dominate Mind","[mod:alt,@focus,harm,nodead]",";"},}) or "")..(Get_Spell("Void Shift","[@mouseover,help,nodead][help,nodead]",";") or "")..(Get_Spell({{"Silence","[@mouseover,harm,nodead][]",""},{"Mind Control","[@mouseover,harm,nodead][]",""},{"Dominate Mind","[@mouseover,harm,nodead][]",""},}) or "").."\n/use Forgotten Feather")
				EditMacro("WSxGenE",nil,nil,"#show "..(Get_Spell({{"Psychic Scream","",""},{"Holy Nova","",""},}) or "").."\n/stopspelltarget\n/use "..(Get_Spell("Mass Dispel","[mod:alt,@mouseover,exists,nodead][mod:alt,@cursor]",";") or "").."[nomod,nocombat,noexists]Party Totem"..(Get_Spell({{"Psychic Scream","\n/use [nomod]",""},{"Holy Nova","\n/use [nomod]",""},}) or ""))
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use Desperate Prayer\n/use [@mouseover,help,nodead][help,nodead][@player]Power Word: Life\n/use A Collection Of Me"..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..(Get_Spell("Mass Dispel","[mod:alt,@player]",";") or "")..(Get_Spell("Psychic Scream","[@mouseover,harm,nodead][]","") or "").."\n/use Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
				EditMacro("WSxGenR",nil,nil,"/use "..(Get_Spell("Void Tendrils","[mod:shift]",";") or "")..(Get_Spell({{"Angelic Feather","[mod:ctrl,@player][@cursor]",""},{"Power Word: Shield","[mod:ctrl,@player][@mouseover,help,nodead][]",""},}) or "").."\n/stopspelltarget")
				EditMacro("WSxGenT",nil,nil,"#show "..(Get_Spell({{"Holy Word: Chastise","",""},{"Psychic Horror","",""},{"Power Word: Barrier","",""},{"Evangelism","",""},}) or "")..swapblaster.."\n/stopspelltarget"..(Get_Spell("Mind Soothe","\n/use [mod:alt,@player][@mouseover,exists,nodead][@cursor]","") or ""))				
				EditMacro("WSxSGen+T",nil,nil,"#show "..(Get_Spell({{"Void Tendrils","",""},{"Leap of Faith","",""},}) or "").."\n/use "..(Get_Spell({{"Psychic Horror","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";"},{"Holy Word: Chastise","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";"},}) or "[@mouseover,harm,nodead][harm,nodead]Shadow Word: Pain;")..(Get_Spell("Leap of Faith","[mod:alt,@focus,help,nodead][@mouseover,help,nodead][help,nodead]",";") or "").."\n/use Shadowy Disguise")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..(Get_Spell("Renew","[@party4,help,nodead,mod:alt][@focus,help,nodead][@party2,help,nodead]",";") or "Fade"))
				EditMacro("WSxGenU",nil,nil,"#show Desperate Prayer\n/use "..(Get_Spell("Premonition","","") or "Fade"))
				EditMacro("WSxSGen+F",nil,nil,"#show "..(Get_Spell({{"Shackle Undead","",""},}) or "").."\n/use "..(Get_Spell("Shackle Undead","[@focus,harm,nodead]",";") or "").."[help,nocombat,mod:alt]B. F. F. Necklace;[nocombat,noexists,mod:alt]Gastropod Shell;Mind Vision\n/use [nocombat,noexists]Tickle Totem\n/cancelaura [mod:alt]Shadowform")
				EditMacro("WSxCGen+F",nil,nil,"#show "..(Get_Spell({{"Symbol of Hope","",""},{"Rapture","",""},{"Psychic Scream","",""},}) or "").."\n/use [nocombat,noexists]Piccolo of the Flaming Fire;"..(Get_Spell({{"Vampiric Embrace","",""},{"Rapture","",""},}) or "").."\n/cancelaura Twice-Cursed Arakkoa Feather\n/cancelaura Spirit Shell\n/use Xan'tish's Flute\n/use Leather Love Seat")
				EditMacro("WSxCAGen+F",nil,nil,"#show "..(Get_Spell("Vampiric Embrace","","") or "Levitate").."\n/targetfriendplayer\n/use [help,nodead]Power Infusion;Starlight Beacon\n/targetlasttarget")
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]Darkmoon Gazer;"..(Get_Spell("Dispel Magic","[@mouseover,harm,nodead]",";") or "")..(Get_Spell({{"Purify","[@mouseover,help,nodead][]",";"},{"Purify Disease","[@mouseover,help,nodead][]",";"},}) or "Power Word: Fortitude"))
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(Get_Spell("Dispel Magic","[@mouseover,harm,nodead][harm,nodead]",";") or "").."Personal Spotlight\n/use [noexists,nocombat] Flaming Hoop\n/targetenemy [noexists]")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(Get_Spell("Renew","[@party3,help,nodead,mod:alt][@focus,help,nodead][@party1,help,nodead]","") or "").."\n/use Panflute of Pandaria\n/use Puzzle Box of Yogg-Saron\n/use Spectral Visage")
				EditMacro("WSxCSGen+G",nil,nil,"#show Fade\n/use [@focus,harm,nodead]Dispel Magic;[nospec:3,@focus,help,nodead][nospec:3]Purify;[@focus,help,nodead][]Purify Disease\n/cancelaura Dispersion\n/cancelaura Spirit of Redemption\n/use Tickle Totem")
				EditMacro("WSxGenH",nil,nil,"#show "..(Get_Spell({{"Evangelism","",""},{"Leap of Faith","",""},}) or "").."\n/use [nocombat,noexists]Don Carlos' Famous Hat"..(Get_Spell({{"Evangelism",";",""},{"Power Word: Life",";[@mouseover,help,nodead][]",""},}) or "").."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;"..(Get_Spell("Power Word: Barrier","[mod,@player]",";") or "")..(Get_Spell({{"Pain Suppression","[@mouseover,help,nodead][]",""},{"Guardian Spirit","[@mouseover,help,nodead][]",""},{"Dispersion","!",""},}) or "").."\n/use [nochanneling:Penance]Soul Evacuation Crystal")
				EditMacro("WSxGenX",nil,nil,"/use [mod:shift]Fade;"..(Get_Spell({{"Mind Control","[mod:ctrl,harm,nodead]",";"},{"Dominate Mind","[mod:ctrl,harm,nodead]",";"},}) or "").."[mod:ctrl]Unstable Portal Emitter"..(Get_Spell("Power Word: Shield",";[@mouseover,help,nodead][]","") or "").."\n/use [nocombat]Bubble Wand\n/use Void Totem\n/cancelaura Bubble Wand")
				EditMacro("WSxGenC",nil,nil,"/use "..(Get_Spell({{"Shackle Undead","[@mouseover,harm,nodead,mod:ctrl][mod:ctrl]",";"},{"Mind Control","[@mouseover,harm,nodead,mod:ctrl][mod:ctrl]",";"},{"Dominate Mind","[@mouseover,harm,nodead,mod:ctrl][mod:ctrl]",";"},}) or "")..(Get_Spell({{"Rapture","[mod:shift]",";"},{"Symbol of Hope","[mod:shift]",";"},}) or "")..(Get_Spell({{"Prayer of Mending","[@mouseover,help,nodead][]",""},{"Renew","[@mouseover,help,nodead][]",""},{"Shadowfiend","",""},{"Mindbender","",""},}) or ""))
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use [nocombat,noexists]Sturdy Love Fool\n/run PetDismiss();\n/cry")		
				EditMacro("WSxGenV",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell({{"Renew","[@mouseover,help,nodead][]",""},{"Void Shift","[@mouseover,help,nodead][]",""},}) or "[@mouseover,exists,nodead][@cursor,nodead]Mind Soothe").."\n/cancelaura Rhan'ka's Escape Plan")
				EditMacro("WSxCAGen+B",nil,nil,"")
				EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxCGen+T\",nil,nil,\"\\#show Power Infusion\\n/use [@\"..N..\"]Power Infusion\\n/stopspelltarget\", nil)print(\"PI set to : \"..N)else print(\"Nöpe!\")end")
			-- Death Knight, DK, diky
			-- Start off here
			elseif class == "DEATHKNIGHT" then
				EditMacro("WSxGen1",nil,nil,"#show\n/cast [@mouseover,help,dead][help,dead]Raise Ally;"..(Get_Spell({{"Frostwyrm's Fury","",""},{"Apocalypse","",""},{"Consumption","",""},{"Blooddrinker","[@mouseover,harm,nodead][]",""},{"Tombstone","",""},{"Breath of Sindragosa","!",""}}) or "Death Strike").."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+1",nil,nil,"#show\n/use "..(Get_Spell("Horn of Winter","","") or  "[@mouseover,exists][]Raise Ally").."\n/use Stolen Breath")
				EditMacro("WSxGen2",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use "..(Get_Spell("Corpse Exploder","[harm,dead,nocombat]",";") or "")..(Get_Spell({{"Heart Strike","",""},{"Howling Blast","[@mouseover,harm,nodead][]",""},{"Scourge Strike","[@mouseover,harm,nodead][]",""},}) or "").."\n/use [nocombat]Stolen Breath\n/startattack")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use Death Strike\n/use Gnomish X-Ray Specs\n/cancelaura X-Ray Specs")
				EditMacro("WSxGen3",nil,nil,"#show\n/use [nocombat,noexists]Sack of Spectral Spiders;"..(Get_Spell({{"Soul Reaper","",""},{"Empower Rune Weapon","",""},{"Abomination Limb","",""},{"Scourge Strike","",""},{"Breath of Sindragosa","",""},{"Obliterate","",""},{"Rune Strike","",""},{"Marrowrend","",""},}) or "").."\n/startattack")
				EditMacro("WSxSGen+3",nil,nil,"/use "..(Get_Spell({{"Death's Caress","[@mouseover,harm,nodead][]",""},{"Glacial Advance","[@mouseover,harm,nodead][]",""},{"Howling Blast","[@mouseover,harm,nodead][]",""},{"Outbreak","[@mouseover,harm,nodead][]",""},}) or "").."\n/startattack\n/stopspelltarget")
				EditMacro("WSxGen4",nil,nil,"#show\n/use [spec:2,noexists]Vrykul Drinking Horn;"..(Get_Spell({{"Marrowrend","",""},{"Obliterate","",""},{"Rune Strike","",""},{"Festering Strike","",""},}) or "").."\n/startattack\n/cancelaura Vrykul Drinking Horn")
				EditMacro("WSxSGen+4",nil,nil,"#show Death and Decay\n/stopspelltarget\n/use [spec:1,nocombat,noexists]Krastinov's Bag of Horrors\n/use [@focus,mod:alt]Death Coil;[@mouseover,exists,nodead][@cursor]Death and Decay\n/targetenemy [noexists]")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/cast "..(Get_Spell({{"Bonestorm","",""},{"Unholy Assault","",""},{"Summon Gargoyle","",""},{"Apocalypse","",""},{"Breath of Sindragosa","!",""},{"Empower Rune Weapon","",""},}) or "").."\n/use [spec:1,nocombat]For da Blood God!;[nospec:1,nocombat]Will of Northrend\n/startattack")
				EditMacro("WSxGen5",nil,nil,"/use "..(Get_Spell("Anti-Magic Zone","[mod:ctrl,@cursor]",";") or "")..(Get_Spell("Frost Strike") or "[@mouseover,exists,nodead][]Death Coil").."\n/startattack\n/cleartarget [dead]\n/use [nospec:2]Aqir Egg Cluster")
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use "..(Get_Spell({{"Mark of Blood","",""},{"Tombstone","",""},{"Unholy Blight","",""},}) or "[@mouseover,exists,nodead][exists,nodead]Death Coil").."\n/use Angry Beehive\n/startattack")
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..(Get_Spell({{"Dancing Rune Weapon","[mod:ctrl]",";"},{"Pillar of Frost","[mod:ctrl]",";"},{"Army of the Dead","[mod:ctrl]",";"},}) or "")..(Get_Spell({{"Heart Strike","",""},{"Epidemic","",""},{"Remorseless Winter","",""},}) or "[@player]Death and Decay").."\n/use [mod:ctrl]Angry Beehive")
				EditMacro("WSxSGen+6",nil,nil,"#show "..(Get_Spell({{"Vile Contagion","",""},{"Sacrificial Pact","",""},{"Army of the Dead","",""},}) or "").."\n/use [@player]Death and Decay\n/use [noexists,nocombat,spec:1]Vial of Red Goo\n/stopspelltarget\n/cancelaura Secret of the Ooze")
				EditMacro("WSxGen7",nil,nil,"#show\n/use "..(Get_Spell("Vile Contagion","[mod:shift]",";") or "")..(Get_Spell({{"Blood Boil","",""},{"Frostscythe","",""},{"Horn of Winter","",""},{"Summon Gargoyle","",""},{"Pillar of Frost","",""},}) or ""))
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..(Get_Spell("Sacrificial Pact","[mod:shift]",";") or "")..(Get_Spell({{"Chill Streak","[@mouseover,harm,nodead][]",""},{"Army of the Dead","",";"},{"Dark Transformation","[nopet]Raise Dead;[pet]",""},{"Sacrificial Pact","",""},{"Empower Rune Weapon","",""},{"Death's Caress","",""},}) or ""))
				if covA == "Abomination Limb" then
					override = (Get_Spell({{"Empower Rune Weapon","",""},{"Sacrificial Pact","",""},{"Army of the Dead","",""},{"Breath of Sindragosa","!",""},{"Bone Storm","",""},{"Anti-Magic Zone","",""},}) or "")
				else
					override = (Get_Spell({{"Abomination Limb","",""},{"Empower Rune Weapon","",""},{"Sacrificial Pact","",""},{"Army of the Dead","",""},{"Breath of Sindragosa","!",""},{"Bone Storm","",""},{"Anti-Magic Zone","",""},}) or "")
				end
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..override)
				EditMacro("WSxCSGen+2",nil,nil,"")
				EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noharm]Spirit Wand;[@focus,exists,harm,nodead,spec:3]Outbreak;[@focus,exists,harm,nodead,spec:2]Howling Blast\n/stopspelltarget")
				EditMacro("WSxCSGen+4",nil,nil,"/use [nocombat]Lilian's Warning Sign")
				EditMacro("WSxCSGen+5",nil,nil,"/clearfocus [dead]\n/use Stolen Breath")
				EditMacro("WSxGenQ",nil,nil,"/use "..(Get_Spell("Asphyxiate","[mod:alt,@focus,harm,nodead]",";") or "").."[mod:shift]Lichborne;"..(Get_Spell("Mind Freeze","[@mouseover,harm,nodead][]","") or ""))
				EditMacro("WSxGenE",nil,nil,"#show\n/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Death Grip\n/startattack\n/cleartarget [dead]\n/targetenemy [noharm]")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(Get_Spell({{"Horn of Winter","",""},{"Blood Tap","",""},}) or "")..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show "..(Get_Spell({{"Blinding Sleet","",""},{"Rune Tap","",""},{"Blood Tap","",""},}) or "").."\n/use "..(Get_Spell("Gorefiend's Grasp","[mod:alt,@player]",";") or "")..(Get_Spell({{"Blinding Sleet","",""},{"Rune Tap","",""},{"Blood Tap","",""},}) or ""))
				EditMacro("WSxGenR",nil,nil,"#show\n/use "..(Get_Spell("Gorefiend's Grasp","[@mouseover,exists,nodead,mod:shift][mod:shift]",";") or "")..(Get_Spell("Wraith Walk","[mod:ctrl]!",";") or "")..(Get_Spell("Chains of Ice","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]","") or "").."\n/targetenemy [noexists]")
				if playerSpec == 3 then override = "[nopet]Raise Dead;[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][pet]Leap"
				else 
					override = (Get_Spell({{"Blood Tap","",""},{"Horn of Winter","",""},{"Gorefiend's Grasp","",""},}) or "Death Grip")
				end
				EditMacro("WSxGenT",nil,nil,"/use "..override..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]\n/petattack [@mouseover,exists,nodead][]")
				EditMacro("WSxSGen+T",nil,nil,"#show\n/use Dark Command\n/use Blight Boar Microphone")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..(Get_Spell("Raise Dead","[nopet]",";") or "").."\n/use "..(Get_Spell("Sacrificial Pact","[]","") or ""))
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..(Get_Spell({{"Raise Ally","",""},{"Horn of Winter","",""},{"Wraith Walk","",""},{"Rune Tap","",""},{"Blinding Sleet","",""},{"Corpse Exploder","",""},}) or "Corpse Exploder"))
				EditMacro("WSxGenF",nil,nil,"#show Corpse Exploder\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Legion Communication Orb;[@focus,harm,nodead]Mind Freeze")
				EditMacro("WSxSGen+F",nil,nil,"#show "..(Get_Spell("Death Pact") or "").."\n/petautocasttoggle [mod:alt]Claw\n/use "..(Get_Spell({{"Dark Transformation","[nopet]Raise Dead;[pet,@focus,harm,nodead][pet,harm,nodead]",";Gastropod Shell\n/use [pet,@focus,harm,nodead][pet,harm,nodead]!Leap\n/petattack [@focus,harm,nodead]"},{"Blood Tap","[nocombat,noexists]Gastropod Shell;",""},}) or ""))
				EditMacro("WSxCGen+F",nil,nil,"#show\n/use "..(Get_Spell({{"Horn of Winter","",""},{"Vampiric Blood","",""},{"Rune Tap","",""},{"Blinding Sleet","",""},}) or "[pet]Huddle"))
				if playerSpec == 3 and Get_Spell("Raise Dead") then 
					override = "[nopet]Raise Dead;[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][pet]Gnaw\n/petattack [harm,nodead]"
				else 
					override = (Get_Spell("Rune Tap","","") or "Death Grip")
				end
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt,nocombat,noexists]S.F.E. Interceptor;"..override)
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(Get_Spell({{"Asphyxiate","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]",""},{"Blinding Sleet","",""},}) or "[@mouseover,harm,nodead][]Death Grip").."\n/use [noexists,nocombat] Flaming Hoop")				
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(Get_Spell("Death Pact","[]","") or ""))
				EditMacro("WSxCSGen+G",nil,nil,"#show "..(Get_Spell({{"Control Undead","",""},{"Anti-Magic Zone","",""},}) or "").."\n/cancelaura Lichborne\n/cancelaura Blessing of Protection")
				EditMacro("WSxGenH",nil,nil,"#show\n/use [nocombat,noexists]Death Gate;"..(Get_Spell("Gorefiend's Grasp","",";") or "[spec:3,nopet]Raise Dead;[@mouseover,harm,nodead,spec:3][spec:3,pet]Gnaw;").."[nomounted]Death Gate\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;"..(Get_Spell("Anti-Magic Zone","[@player,mod:shift]",";") or "")..(Get_Spell("Icebound Fortitude","","") or ""))
				EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt]Runeforging;"..(Get_Spell("Control Undead","[mod:ctrl,harm,nodead]",";") or "").."[mod:ctrl]Death Gate;"..(Get_Spell("Wraith Walk","[mod:shift]",";") or "")..(Get_Spell("Anti-Magic Shell","","") or ""))
				EditMacro("WSxGenC",nil,nil,"#show "..(Get_Spell({{"Blinding Sleet","",""},{"Asphyxiate","",""},{"Horn of Winter","",""},{"Death Pact","",""},{"Death Grip","",""},}) or "").."\n/use "..(Get_Spell("Control Undead","[mod:ctrl]",";") or "")..(Get_Spell("Lichborne","[mod:shift]","\n/use [@player,mod:shift][@pet,pet,nodead]Death Coil;[nopet][pet,dead]Raise Dead") or "")..(Get_Spell({{"Horn of Winter","",""},{"Death Pact","",""},{"Blinding Sleet","",""},{"Asphyxiate","",""},{"Death Grip","",""},}) or ""))
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use Sylvanas' Music Box\n/run PetDismiss();\n/cry")
				EditMacro("WSxGenV",nil,nil,"#show\n/use !Death's Advance\n/use Ancient Elethium Coin\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
			-- Warrior, warror
			elseif class == "WARRIOR" then
				overrideModAlt = ""
				if Get_Spell("Berserker Stance") then overrideModAlt = "\n/use [nostance:2]!Berserker Stance"
				end
				if Get_Spell("Colossus Smash") then override = "Colossus Smash"
				elseif Get_Spell("Rampage") then override = "[noequipped:Shields]Rampage\n/equipset [equipped:Shields,spec:2]DoubleGate"..overrideModAlt
				elseif playerSpec == 2 then override = "[noequipped:Shields]Slam\n/equipset [equipped:Shields,spec:2]DoubleGate"..overrideModAlt
				else override = "Shield Block"
				end
				EditMacro("WSxGen1",nil,nil,"#show\n/use [nocombat,help]Corbyn's Beacon;"..override.."\n/targetenemy [noexists]\n/startattack\n/use Chalice of Secrets")
				EditMacro("WSxSGen+1",nil,nil,"/use "..(Get_Spell({{"Ignore Pain","",""},{"Bitter Immunity","",""},}) or "").."\n/use Chalice of Secrets\n/targetexact Aerylia")
			   	overrideModAlt = ""
			   	if Get_Spell("Battle Stance") then overrideModAlt = "\n/use [nostance:2]!Battle Stance" 
			   	end
			   	override = Get_Spell({{"Mortal Strike","[noequipped:Shields]","\n/equipset [equipped:Shields,spec:1]Noon!"..overrideModAlt..""},{"Bloodthirst","",""},{"Devastate","[known:Devastator,@mouseover,harm,nodead][known:Devastator]Heroic Throw;",""},}) or ""
				EditMacro("WSxGen2",nil,nil,"/use [nocombat,noexists]Vrykul Drinking Horn;"..override.."\n/targetenemy [noexists]\n/cleartarget [noharm]\n/startattack\n/cancelaura Vrykul Drinking Horn")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use Victory Rush\n/use [noexists,nocombat,nochanneling]Gnomish X-Ray Specs\n/targetenemy [noharm]\n/startattack")
				EditMacro("WSxGen3",nil,nil,"#show\n/use Execute\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]\n/use Banner of the Burning Blade")			
				EditMacro("WSxSGen+3",nil,nil,"/use "..(Get_Spell({{"Rend","",""},{"Thunderous Roar","",""},{"Bladestorm","",""},{"Thunder Clap","",""},}) or "Whirlwind").."\n/startattack")
				EditMacro("WSxGen4",nil,nil,"#show\n/use [spec:3][equipped:Shields,spec:2]Shield Slam;"..(Get_Spell({{"Overpower","",""},{"Raging Blow","",""},}) or "Slam").."\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
				EditMacro("WSxSGen+4",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell({{"Ravager","[@mouseover,exists,nodead][@cursor]",""},{"Skullsplitter","",""},{"Siegebreaker","",""},{"Sweeping Strikes","",""},}) or "Slam").."\n/use Muradin's Favor\n/startattack")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..(Get_Spell({{"Odyn's Fury","",""},{"Bladestorm","",""},{"Shield Charge","",""},{"Thunderous Roar","",""},{"Avatar","",""},{"Recklessness","",""},}) or "").."\n/startattack\n/cleartarget [dead]\n/use [nocombat,noexists]Tosselwrench's Mega-Accurate Simulation Viewfinder;Frenzyheart Brew")
				EditMacro("WSxGen5",nil,nil,"/use "..(Get_Spell("Rallying Cry","[mod:ctrl]",";") or "").."[equipped:Shields,nospec:3]Shield Slam;"..(Get_Spell({{"Onslaught","",""},{"Revenge","",""},}) or "Slam").."\n/startattack\n/cleartarget [dead]\n/stopmacro [nomod]\n/use [mod]Gamon's Braid\n/roar")
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use "..(Get_Spell({{"Shockwave","",""},{"Thunderous Roar","",""},{"Avatar","",""},{"Bladestorm","",""},}) or "[spec:2]Slam;Whirlwind").."\n/startattack")		
				if playerSpec == 3 and Get_Spell("Thunder Clap") then
					override = "Thunder Clap"
				else
					override = Get_Spell("Whirlwind","","") or ""
				end		
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..(Get_Spell({{"Bladestorm","[mod:ctrl]",";"},{"Recklessness","[mod:ctrl]",";"},{"Avatar","[mod:ctrl]",";"},}) or "")..override.."\n/startattack\n/use Words of Akunda")
				EditMacro("WSxSGen+6",nil,nil,"/use "..(Get_Spell({{"Ravager","[@player]",""},{"Bladestorm","",""},{"Rampage","",""},{"Sweeping Strikes","",""},{"Slam","",""},}) or "[spec:3]Shield Block").."\n/targetenemy [noexists]\n/startattack")
				EditMacro("WSxGen8",nil,nil,"#show \n/use "..(Get_Spell({{"Recklessness","",""},{"Skullsplitter","",""},{"Cleave","",""},{"Sweeping Strikes","",""},{"Champion's Spear","[@player,mod][@cursor]",""},{"Challenging Shout","",""},{"Whirlwind","",""},}) or ""))
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..(Get_Spell({{"Champion's Spear","[@player,mod][@cursor]",""},{"Cleave","",""},{"Sweeping Strikes","",""},}) or "Slam"))
				EditMacro("WSxCSGen+2",nil,nil,"")
				EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Rend;Vrykul Toy Boat\n/use [nocombat]Vrykul Toy Boat Kit")
				EditMacro("WSxCSGen+4",nil,nil,"/use [mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Intervene")
				EditMacro("WSxCSGen+5",nil,nil,"//use [mod:alt,@party4,help,nodead][@party2,help,nodead][@targettarget,help,nodead]Intervene")
				EditMacro("WSxGenQ",nil,nil,"#show Pummel\n/use "..(Get_Spell("Storm Bolt","[mod:alt,@focus,harm,nodead]",";") or "")..(Get_Spell("Berserker Rage","[mod:shift]",";") or "").."[@mouseover,harm,nodead,nomod]Charge\n/use [@mouseover,harm,nodead,nomod][nomod]Pummel\n/use Mote of Light\n/use World Shrinker")
				EditMacro("WSxGenE",nil,nil,"#show\n/use [@mouseover,harm,nodead][]Charge\n/use [noexists,nocombat]Arena Master's War Horn\n/startattack\n/cleartarget [dead][help]\n/targetenemy [noharm]\n/use Prismatic Bauble")
				EditMacro("WSxCGen+E",nil,nil,"#show Battle Shout\n/use "..(Get_Spell("Last Stand","","") or "").."\n/use Outrider's Bridle Chain"..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..(Get_Spell({{"Intimidating Shout","[@mouseover,harm,nodead][]",""},{"Demoralizing Shout","[@mouseover,harm,nodead][]",""},}) or "").."\n/startattack\n/targetenemy [noexists]\n/targetlasttarget")
				EditMacro("WSxGenR",nil,nil,"#show\n/use "..(Get_Spell("Avatar","[mod:ctrl]",";") or "")..(Get_Spell("Piercing Howl","[mod:shift]",";") or "")..(Get_Spell("Intervene","[@mouseover,help,nodead,nomod][help,nodead,nomod]","") or "").."\n/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Hamstring\n/startattack")
				EditMacro("WSxGenT",nil,nil,"#show "..(Get_Spell("Challenging Shout","","") or "").."\n/use [@mouseover,harm,nodead][]Heroic Throw"..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]\n/use Blight Boar Microphone")
				EditMacro("WSxSGen+T",nil,nil,"#show Taunt\n/use [nocombat,noexists]Blight Boar Microphone;Taunt\n/targetenemy [noexists]")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..(Get_Spell("Challenging Shout","","") or ""))
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..(Get_Spell({{"Intervene","",""},{"Intimidating Shout","",""},{"Rallying Cry","",""},}) or ""))
				EditMacro("WSxGenF",nil,nil,"#show "..(Get_Spell({{"Berserker Rage","",""},{"Intimidating Shout","",""},}) or "Farwater Conch").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Pummel")
				EditMacro("WSxSGen+F",nil,nil,"#show "..(Get_Spell("Spell Block","","") or "").."\n/use [@focus,harm,nodead]Charge\n/use [@focus,harm,nodead]Pummel\n/use [help,nocombat,mod:alt]B.B.F. Fist;[nocombat,noexists,mod:alt]Gastropod Shell;Faintly Glowing Flagon of Mead")
				EditMacro("WSxCGen+F",nil,nil,"#show\n/use "..(Get_Spell("Demoralizing Shout") or "Battle Shout"))
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]S.F.E. Interceptor;"..(Get_Spell({{"Shattering Throw","[@mouseover,harm,nodead][harm,nodead]",";"},{"Wrecking Throw","[@mouseover,harm,nodead][harm,nodead]",";"},{"Storm Bolt","[@mouseover,harm,nodead][harm,nodead]",";"},}) or "").."B.B.F. Fist\n/targetenemy [combat,noharm]")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(Get_Spell("Storm Bolt") or "Victory Rush").."\n/use [noexists,nocombat]Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(Get_Spell("Spell Block") or ""))
				EditMacro("WSxCSGen+G",nil,nil,"#show\n/use [nocombat,noexists]Hraxian's Unbreakable Will;"..(Get_Spell("Bitter Immunity","","") or "Fyrakk's Frenzy").."\n/cancelaura Blessing of Protection\n/cancelaura Words of Akunda")
				EditMacro("WSxGenH",nil,nil,"#show Battle Shout\n/use [nomounted]Darkmoon Gazer;"..(Get_Spell("Bitter Immunity") or "").."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenX",nil,nil,"#show\n/use "..(Get_Spell("Defensive Stance","[mod:alt,nostance:1]!",";") or "")..(Get_Spell({{"Battle Stance","[mod:alt]!",";"},{"Berserker Stance","[mod:alt]!",";"},}) or "")..(Get_Spell({{"Last Stand","[nomod]",";"},{"Intimidating Shout","[nomod]",";"},{"Rallying Cry","[nomod]",";"},}) or "")..(Get_Spell({{"Intervene","\n/targetfriend [mod:shift,nohelp]\n/use [mod:shift,help,nodead]","\n/targetlasttarget [mod:shift]"},{"Avatar","[mod:shift]",""},}) or ""))	
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use Sylvanas' Music Box\n/run PetDismiss();\n/cry")
				EditMacro("WSxGenV",nil,nil,"/cast "..(Get_Spell("Heroic Leap","[@cursor]","") or "").."\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
			-- Druid, dodo
			elseif class == "DRUID" then
				EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,dead][help,dead]Rebirth;"..(Get_Spell("Innervate","[@mouseover,help,nodead][help,nodead]",";") or "").."[@mouseover,harm,nodead][harm,nodead]Moonfire;Druid and Priest Statue Set\n/use [nocombat,noform:1/4]!Prowl\n/targetenemy [noexists]")
				EditMacro("WSxSGen+1",nil,nil,"#show "..(Get_Spell({{"Sunfire","",""},{"Tranquility","",""},}) or "Mark of the Wild").."\n/use [mod:alt,@party3,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Regrowth;Kalytha's Haunted Locket")
				EditMacro("WSxGen2",nil,nil,"/use [form:2]Shred;[form:1]Mangle;"..(Get_Spell("Sunfire","[@mouseover,harm,nodead][harm,nodead]",";") or "")..(Get_Spell("Invigorate","[@mouseover,help,nodead][help,nodead]",";") or "").."Moonfeather Statue\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/cancelaura X-Ray Specs\n/use [mod:alt,@party4,nodead][@mouseover,help,nodead][]Regrowth\n/use Gnomish X-Ray Specs")
				EditMacro("WSxGen3",nil,nil,"#show\n/use "..(Get_Spell("Rake","[form:2]",";") or "")..(Get_Spell("Ironfur","[form:1]",";") or "")..(Get_Spell("Starsurge","","") or "").."\n/targetenemy [noexists]\n/use Desert Flute")
				EditMacro("WSxSGen+3",nil,nil,"#show "..(Get_Spell("Rake","[]",";") or "").."Moonfire"..(Get_Spell({{"Fluid Form","\n/use !Prowl\n/use Rake;",""},{"Rake","\n/use !Prowl\n/use [noform:2]Cat Form;[form:2]",""},}) or "")..(Get_Spell("Lifebloom","\n/use [@mouseover,help,nodead][]","") or "")..(Get_Spell("Thrash","\n/use [form:1/2]","\n/use [noform:1]Bear Form;[form:1]","") or ""))
				EditMacro("WSxGen4",nil,nil,"/use "..(Get_Spell("Rip","[form:2]",";") or "")..(Get_Spell("Pulverize","[form:1]",";") or "").."[form:2]Shred;[form:1]Mangle;"..(Get_Spell("Starfire","[@mouseover,harm,nodead][]","") or "").."\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,nostealth,noform:1/4]!Prowl")
				overrideModAlt = ""
				if playerSpec == 4 and Get_Spell("Rejuvenation") then overrideModAlt = "[@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Rejuvenation;"
				elseif Get_Spell("Rejuvenation") then overrideModAlt = "[@party1,help,nodead,mod:alt]Rejuvenation;"
				end
				if playerSpec == 1 and Get_Spell("Moonkin Form") then overrideModCtrl = "[noform:4]!Moonkin Form;"
				elseif playerSpec == 2 then overrideModCtrl = "[noform:2]!Cat Form;"
				elseif playerSpec == 3 then overrideModCtrl = "[noform:1]!Bear Form;"
				else overrideModCtrl = ""
				end
				EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noexists]\n/use "..overrideModAlt..overrideModCtrl..(Get_Spell({{"Stellar Flare","[nomod:alt,harm,nodead]","\n/use [nomod:alt]Bushel of Mysterious Fruit\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Stellar Flare\n/targetlasttarget"},{"New Moon","[harm,nodead]","\n/use Bushel of Mysterious Fruit"},{"Fury of Elune","[harm,nodead]","\n/use Bushel of Mysterious Fruit"},{"Tiger's Fury","[form:2]","\n/use Bushel of Mysterious Fruit"},{"Bristling Fur","[form:1]","\n/use Bushel of Mysterious Fruit"},{"Lifebloom","[@mouseover,help,nodead][]","\n/use Bushel of Mysterious Fruit"},}) or "\n/use Bushel of Mysterious Fruit"))
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..(Get_Spell("Rejuvenation","[@party3,help,nodead,mod:alt]",";") or "")..(Get_Spell({{"Heart of the Wild","",""},{"Grove Guardians","[@mouseover,help,nodead][]",""},{"Nourish","[@mouseover,help,nodead][]",""},{"Nature's Vigil","",""},{"Convoke the Spirits","[@mouseover,exists,nodead][]",""},{"Stampeding Roar","",""},}) or ""))	
				EditMacro("WSxGen5",nil,nil,"#show\n/use "..(Get_Spell("Renewal","[mod:ctrl]",";") or "")..(Get_Spell({{"Raze","[noform:1]Bear Form;[form:1,harm,nodead]",";"},{"Lunar Beam","[noform:1]Bear Form;[form:1,harm,nodead]",";"},}) or "[form:1,harm,nodead]Mangle;").."[form:2,harm,nodead]Ferocious Bite;"..(Get_Spell({{"Nourish","[@mouseover,help,nodead][help,nodead]",";"},{"Grove Guardians","[@mouseover,help,nodead][help,nodead]",";"},}) or "").."Wrath\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use "..(Get_Spell("Rejuvenation","[@focus,help,nodead,mod:alt][@party2,help,nodead,mod:alt]",";") or "").."[nocombat,help,nodead]Corbyn's Beacon;"..(Get_Spell({{"Lunar Beam","",""},{"Flourish","",""},{"Feral Frenzy","[noform:2]Cat Form;[form:2]",""},{"Tiger's Fury","[noform:2]Cat Form;[form:2]",""},{"Nourish","[@mouseover,help,nodead][]",""},{"Grove Guardians","[@mouseover,help,nodead][]",""},{"Warrior of Elune","",""},{"Force of Nature","[mod:alt,@player][@cursor]",""},{"Wild Mushroom","",""},{"Cenarion Ward","[@mouseover,help,nodead][]",""},}) or "").."\n/use [spec:2/3]Bloodmane Charm;Compendium of the New Moon")
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod:ctrl,@party4,help,nodead]Rejuvenation;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14")
				EditMacro("WSxGen6",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell({{"Celestial Alignment","[mod,@mouseover,exists,nodead][mod,@cursor]",";"},{"Incarnation: Chosen of Elune","[mod,@mouseover,exists,nodead][mod,@cursor]!",";"},{"Incarnation: Avatar of Ashamane","[mod]!",";"},{"Incarnation: Guardian of Ursoc","[mod]!",";"},{"Berserk","[mod]",";"},{"Tranquility","[mod]",";"},{"Incarnation: Tree of Life","[mod]!",";"},}) or "")..(Get_Spell("Thrash","[form:1/2]",";[spec:2,noform:1/2]Cat Form;[spec:3,noform:1/2]Bear Form;") or "")..(Get_Spell("Starfall","[]",";") or "")..(Get_Spell("Sunfire","[@mouseover,harm,nodead][harm,nodead]","") or "")..(Get_Spell("Nature's Swiftness","[]","") or "")..(Get_Spell("Tranquility","\n/stopmacro\n/use ","") or ""))
				EditMacro("WSxSGen+6",nil,nil,"#show "..(Get_Spell("Primal Wrath","[noform:2]Cat Form;[form:2]",";") or "")..(Get_Spell({{"Wild Growth","[@mouseover,help,nodead][]",""},{"Celestial Alignment","[@mouseover,exists,nodead][@cursor]",""},{"Incarnation: Chosen of Elune","[@mouseover,exists,nodead][@cursor]!",";"},}) or "").."\n/stopspelltarget\n/use Kaldorei Wind Chimes\n/use [nocombat,noexists]Friendsurge Defenders\n/use "..(Get_Spell("Primal Wrath","[noform:2]Cat Form;[form:2]",";") or "")..(Get_Spell({{"Wild Growth","[@mouseover,help,nodead][]",""},{"Celestial Alignment","[@mouseover,exists,nodead][@cursor]",""},{"Incarnation: Chosen of Elune","[@mouseover,exists,nodead][@cursor]!",";"},}) or "").."")
				EditMacro("WSxGen7",nil,nil,"/stopspelltarget\n/use "..(Get_Spell({{"Efflorescence","[mod,@player][@mouseover,exists,nodead,noform:1/2][@cursor,noform:1/2]",";"},{"Wild Mushroom","[mod,@player,noform:1/2][noform:1/2]",";"},}) or "")..(Get_Spell({{"Fury of Elune","[@mouseover,harm,nodead,noform:1/2][noform:1/2]",";"},{"Starfall","[noform:1/2]",";"},}) or "")..(Get_Spell("Swipe","[noform:1/2]Cat Form;[form:1/2]","") or ""))
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..(Get_Spell("Invigorate","[@mouseover,help,nodead,mod][mod]",";") or "")..(Get_Spell({{"Fury of Elune","",""},{"New Moon","",""},{"Incarnation: Tree of Life","!",""},{"Convoke the Spirits","",""},{"Adaptive Swarm","[@mouseover,exists,nodead][]",""},{"Cenarion Ward","",""},{"Overgrowth","[@mouseover,help,nodead][]",""},{"Nature's Vigil","",""},{"Ironfur","",""},{"Starfall","",""},}) or ""))
				if Get_Spell("Starfall") and (covA ~= "Ravenous Frenzy" or covA ~= "Kindred Spirits" or covA ~= "Adaptive Swarm") then override = "Starfall"
				else
					override = (Get_Spell({{"Rage of the Sleeper","[noform:1]Bear Form;[form:1]",""},{"Adaptive Swarm","[@mouseover,exists,nodead][]",""},{"Incarnation: Tree of Life","!",""},{"Convoke the Spirits","",""},{"Astral Communion","",""},{"Tiger's Fury","",""},{"Bristling Fur","",""},{"Cyclone","",""},}) or "")
				end
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..override)
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,spec:4,@party3,help,nodead][spec:4,@party1,help,nodead][spec:4,@targettarget,help,nodead]Nature's Cure;[mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Remove Corruption\n/use [nocombat]Spirit of Bashiok")
				EditMacro("WSxCSGen+3",nil,nil,"/use [mod:alt,spec:4,@party4,help,nodead][spec:4,@party2,help,nodead]Nature's Cure;[mod:alt,@party4,help,nodead][@party2,help,nodead]Remove Corruption")
				EditMacro("WSxCSGen+4",nil,nil,"/use "..(Get_Spell("Stellar Flare","[spec:1,@focus,harm,nodead]",";") or "").."[mod:alt,@party3,help,nodead,spec:4][@focus,spec:4,help,nodead][@party1,help,nodead,spec:4]Lifebloom;[mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead]Rejuvenation") 
				EditMacro("WSxCSGen+5",nil,nil,"/use [mod:alt,@party4,help,nodead,spec:4][@focus,spec:4,help,nodead][@party2,help,nodead,spec:4][@targettarget,help,nodead,spec:4]Lifebloom;[mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead][@targettarget,help,nodead]Rejuvenation")
				EditMacro("WSxGenQ",nil,nil,"/use "..(Get_Spell("Cyclone","[mod:alt,@focus,harm,nodead]",";") or "")..(Get_Spell({{"Skull Bash","[@mouseover,harm,nodead,form:1/2][form:1/2]",";[noform:1/2]Cat Form"},{"Solar Beam","[@mouseover,harm,nodead][]",""},{"Ursol's Vortex","[@cursor]",""},}) or ""))
				EditMacro("WSxGenE",nil,nil,"#show "..(Get_Spell({{"Incapacitating Roar","",""},{"Mighty Bash","",""},{"Ursol's Vortex","",""},{"Mass Entanglement","",""},{"Cyclone","",""},}) or "").."\n/use "..(Get_Spell("Frenzied Regeneration","[noform:1,mod:alt]Bear Form;[form:1,mod:alt]",";") or "")..(Get_Spell("Wild Charge","[help,nodead,noform][form:1/2]","") or "").."\n/use [combat,noform:1/2]Bear Form(Shapeshift);[noform:1]!Prowl\n/targetenemy [noexists]\n/cancelform [help,nodead]\n/use [nostealth]Prismatic Bauble")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(Get_Spell("Solar Beam","[mod:alt,@focus,harm,nodead]",";") or "")..(Get_Spell({{"Nature's Swiftness","",""},{"Renewal","",""},{"Frenzied Regeneration","[noform:1]Bear Form;[form:1]",""},}) or "").."\n/use [nocombat]Mylune's Call"..oOtas..covToys)	
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..(Get_Spell({{"Ursol's Vortex","[mod:alt,@player]",";"},{"Solar Beam","[mod:alt,@focus,harm,nodead]",";"},}) or "")..(Get_Spell({{"Incapacitating Roar","",""},{"Mighty Bash","",""},{"Solar Beam","[@mouseover,harm,nodead][]",""},}) or "").."\n/use [nomod]!Prowl")
				EditMacro("WSxGenR",nil,nil,(Get_Spell("Wild Charge","/cancelform [form,@mouseover,help,nodead,nomod]\n/use [@mouseover,help,nodead,nomod]","\n") or "").."/use "..(Get_Spell("Stampeding Roar","[mod:ctrl]",";") or "")..(Get_Spell("Typhoon","[nomod:shift]",";") or "")..(Get_Spell({{"Ursol's Vortex","[@cursor,mod:shift][nomod,@cursor]",""},{"Mass Entanglement","[mod:shift][nomod]",""},}) or "[@mouseover,harm,nodead][]Entangling Roots"))
				EditMacro("WSxGenT",nil,nil,"#show "..(Get_Spell("Frenzied Regeneration") or "Entangling Roots").."\n/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]Entangling Roots"..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+T",nil,nil,"#show [nocombat,noform:1]Prowl;Growl\n/use "..(Get_Spell("Fluid Form","\n/use Mangle;","") or "[noform:1]Bear form(Shapeshift);Growl").."\n/use [spec:3]Highmountain War Harness\n/cancelaura [noform:1]Highmountain War Harness\n/use Hunter's Call")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..(Get_Spell({{"Cenarion Ward","[@party4,help,nodead,mod:alt][@mouseover,help,nodead][help,nodead][@party2,help,nodead][]",""},{"Invigorate","[@party4,help,nodead,mod:alt][@mouseover,help,nodead][help,nodead][@party2,help,nodead][]",""},}) or ""))
				EditMacro("WSxGenU",nil,nil,"#show "..(Get_Spell("Renewal","[]",";") or "").."[resting]Treant Form;Prowl\n/use Treant Form")
				EditMacro("WSxGenF",nil,nil,"#show Barkskin\n/focus [@mouseover,exists]mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;"..(Get_Spell({{"Skull Bash","[@focus,harm,nodead,form:1/2]",";[@focus,harm,nodead,noform:1/2]Bear Form;"},{"Solar Beam","[@focus,harm,nodead]",";"},}) or "").."Charm Woodland Creature")
				EditMacro("WSxSGen+F",nil,nil,"#show [exists,nocombat]Charm Woodland Creature"..(Get_Spell("Stampeding Roar",";","") or "").."\n/cancelform [mod:alt]\n/use [mod:alt,nocombat]Gastropod Shell;"..(Get_Spell("Wild Charge","[nomod:alt,form:3/6]",";") or "").."[nomod:alt,noform:3/6]Travel Form(Shapeshift)\n/stopspelltarget\n/use Prismatic Bauble")
				EditMacro("WSxCGen+F",nil,nil,"#show [nocombat,noexists]Mushroom Chair"..(Get_Spell({{"Cenarion Ward",";",""},{"Nature's Vigil",";",""},{"Heart of the Wild",";",""},}) or "").."\n/use [nocombat,noexists]Mushroom Chair"..(Get_Spell({{"Nature's Vigil",";",""},{"Heart of the Wild",";",""},}) or ""))
				EditMacro("WSxCAGen+F",nil,nil,"#show "..(Get_Spell({{"Innervate","",""},{"Renewal","",""},}) or "Mark of the Wild").."\n/use [nocombat,noexists]Tear of the Green Aspect\n/targetfriend [nohelp,nodead]\n/cancelform [help,nodead]\n/use [help,nodead]Wild Charge\n/targetlasttarget\n/use Prismatic Bauble")
				EditMacro("WSxGenG",nil,nil,"/use [nocombat,noexists,mod]Darkmoon Gazer;"..(Get_Spell("Stampeding Roar","[mod]",";") or "")..(Get_Spell({{"Nature's Cure","[@mouseover,help,nodead][]",""},{"Remove Corruption","[@mouseover,help,nodead][]",""},{"Soothe","[@mouseover,harm,nodead][]",""},}) or "Mark of the Wild").."\n/use Poison Extraction Totem")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(Get_Spell("Maim","[form:2]",";") or "")..(Get_Spell("Soothe","[]","") or "").."\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]") 
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(Get_Spell({{"Overgrowth","[@party3,help,nodead,mod:alt][@mouseover,help,nodead][help,nodead][@party1,help,nodead][]",""},{"Invigorate","[@party3,help,nodead,mod:alt][@mouseover,help,nodead][help,nodead][@party1,help,nodead][]",""},{"Cenarion Ward","[@party3,help,nodead,mod:alt][@mouseover,help,nodead][help,nodead][@party1,help,nodead][]",""},}) or ""))
				EditMacro("WSxCSGen+G",nil,nil,"#show Dash\n/use [spec:4,@focus,help,nodead]Nature's Cure;[@focus,help,nodead]Remove Corruption\n/use Choofa's Call\n/cancelaura Blessing of Protection\n/cancelaura Enthralling")
				EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt,nocombat]Nature's Beacon;[mod]Barkskin;"..(Get_Spell({{"Ironbark","[@mouseover,help,nodead][]",""},{"Survival Instincts","",""},{"Frenzied Regeneration","[noform:1]Bear Form;[form:1]",""},}) or "Barkskin").."\n/use [mod:alt]Gateway Control Shard")
				EditMacro("WSxGenX",nil,nil,"/use [mod:alt]Mount Form;[noform:2,mod:shift]!Cat Form;[mod:shift]Dash;"..(Get_Spell("Hibernate","[mod:ctrl,harm,nodead]",";") or "")..(Get_Spell({{"Dreamwalk","[mod:ctrl]",";"},{"Teleport: Moonglade","[mod:ctrl]",";"},}) or "")..(Get_Spell("Ironfur","[form:1]",";") or "")..(Get_Spell("Swiftmend","[@mouseover,help,nodead][]","") or "").."\n/stopmacro [stealth]\n/use Path of Elothir\n/use Prismatic Bauble")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use "..(Get_Spell("Frenzied Regeneration","[noform:1]Bear Form;[form:1]","") or "").."\n/run PetDismiss();")
				EditMacro("WSxGenV",nil,nil,"#show "..(Get_Spell("Wild Charge","","") or "").."\n/use "..(Get_Spell("Moonkin Form","[noform:4]",";") or "")..(Get_Spell("Wild Charge","[@mouseover,exists,nodead][]","") or "").."\n/use Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
			-- Demon Hunter, DH, Fannyvision, Dihy 
			elseif class == "DEMONHUNTER" then
				EditMacro("WSxGen1",nil,nil,"#show\n/use [@cursor]Fel Rush\n/targetenemy [noexists]\n/startattack\n/use Prismatic Bauble")
				EditMacro("WSxSGen+1",nil,nil,"#show\n/use Skull of Corruption")
				EditMacro("WSxGen2",nil,nil,"#show\n/use [nocombat,noexists]Verdant Throwing Sphere\n/targetlasttarget [noexists,nocombat]\n/use [harm,dead,nocombat,nomod]Soul Inhaler;[spec:1]Demon's Bite;[spec:2]Shear\n/cleartarget [dead]\n/targetenemy [noexists]\n/startattack")
				EditMacro("WSxSGen+2",nil,nil,"#show "..(Get_Spell({{"Fel Eruption","",""},{"Fel Devastation","",""},}) or "Gnomish X-Ray Specs").."\n/use Gnomish X-Ray Specs\n/use "..(Get_Spell({{"Fel Eruption","",""},{"Fel Devastation","",""},}) or "Gnomish X-Ray Specs").."\n/startattack\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGen3",nil,nil,"#show\n/use "..(Get_Spell({{"Felblade","",""},{"Demon Spikes","",""},}) or "[@mouseover,harm,nodead][]Throw Glaive").."\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]\n/use Imp in a Ball")
				EditMacro("WSxSGen+3",nil,nil,"#show\n/use [@mouseover,harm,nodead,nomod:alt][nomod:alt]Throw Glaive;[nocombat]Legion Pocket Portal\n/targetenemy [noexists]\n/startattack\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Throw Glaive\n/targetlasttarget")
				EditMacro("WSxGen4",nil,nil,"#show\n/use "..(Get_Spell({{"Demon Spikes","",""},{"Eye Beam","",""},}) or "").."\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxSGen+4",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell({{"Sigil of Flame","[@mouseover,exists,nodead][@cursor]",""},{"Glaive Tempest","",""},{"Fel Barrage","",""},{"Shear","",""},}) or "").."\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..(Get_Spell({{"The Hunt","[@mouseover,harm,nodead][]",""},{"Bulk Extraction","",""},{"Soul Barrier","",""},{"Fel Barrage","",""},{"Glaive Tempest","",""},{"Darkness","",""},{"Fiery Brand","[@mouseover,harm,nodead][]",""},{"Fel Blade","",""},}) or "Shadowy Disguise").."\n/targetenemy [noexists]\n/startattack")
				EditMacro("WSxGen5",nil,nil,"#show\n/use "..(Get_Spell("Darkness","[mod:ctrl]",";") or "").."Chaos Strike\n/use [mod:ctrl]Shadescale\n/startattack\n/targetenemy [noexists]")
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use [spec:2,@player]Infernal Strike;"..(Get_Spell({{"Essence Break","",""},{"Glaive Tempest","",""},{"Chaos Nova","",""},}) or "").."\n/targetenemy [noexists]\n/startattack")
				EditMacro("WSxGen6",nil,nil,"#show "..(Get_Spell({{"Soul Carver","",""},{"Blade Dance","",""},{"Immolation Aura","",""},}) or "").."\n/use [mod:ctrl]Shadowy Disguise\n/use [mod:ctrl]Shadow Slicing Shortsword\n/stopspelltarget\n/use [mod:ctrl,@mouseover,exists,nodead][mod:ctrl,@cursor]Metamorphosis;"..(Get_Spell({{"Soul Carver","",""},{"Blade Dance","",""},{"Immolation Aura","",""},}) or "").."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+6",nil,nil,"#show\n/use "..(Get_Spell({{"Sigil of Flame","[@player]",""},{"Demon Spikes","",""},{"Immolation Aura","",""},}) or "").."\n/stopspelltarget")
				EditMacro("WSxGen7",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell("Sigil of Spite","[@player,mod:shift]",";") or "")..(Get_Spell({{"Spirit Bomb","",""},{"Soul Carver","",""},{"Immolation Aura","",""},}) or "").."\n/targetenemy [noexists]")
				EditMacro("WSxGen8",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell({{"Sigil of Spite","[@player,mod:shift][@mouseover,exists,nodead][@cursor]",""},{"Glaive Tempest","",""},{"Fel Barrage","",""},{"Immolation Aura","",""},}) or ""))
				EditMacro("WSxGen9",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell({{"Fel Barrage","",""},{"Chaos Nova","",""},}) or "Immolation Aura"))
				EditMacro("WSxCSGen+2",nil,nil,"")
				EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noexists]The Perfect Blossom;[@focus,harm,nodead]Throw Glaive;Fel Petal;")
				EditMacro("WSxCSGen+4",nil,nil,"")
				EditMacro("WSxCSGen+5",nil,nil,"/clearfocus")
				EditMacro("WSxGenQ",nil,nil,"/use "..(Get_Spell("Imprison","[mod:alt,@focus,harm,nodead]",";") or "").."[@mouseover,harm,nodead][]Disrupt")
				EditMacro("WSxGenE",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell("Sigil of Misery","[@mouseover,exists,nodead,nomod:alt][@cursor,nomod:alt]",";") or "")..(Get_Spell("Chaos Nova","[mod:alt][]","") or ""))
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(Get_Spell("Sigil of Misery","[mod:alt,@player]","") or "")..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..(Get_Spell({{"Sigil of Silence","[mod:alt,@player][@cursor]",""},{"Sigil of Misery","[mod:alt,@player][@cursor]",""},}) or ""))
				EditMacro("WSxGenR",nil,nil,"#show\n/use "..(Get_Spell("Netherwalk","[mod:ctrl]!",";") or "")..(Get_Spell("Sigil of Chains","[mod:ctrl,@player][mod:shift,@cursor]",";") or "").."[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Throw Glaive\n/startattack")
				EditMacro("WSxGenT",nil,nil,"#show\n/use !Spectral Sight"..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+T",nil,nil,"#show Torment\n/use "..(Get_Spell("Sigil of Chains","[mod:alt,@player]",";") or "").."Torment\n/targetenemy [noexists]\n/cleartarget [dead]")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use ")
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..(Get_Spell({{"Darkness","",""},{"Chaos Nova","",""},}) or ""))
				EditMacro("WSxGenF",nil,nil,"#show "..(Get_Spell("Sigil of Misery") or "").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,exists,nodead]All-Seer's Eye;[mod:alt]Legion Communication Orb;[@focus,harm,nodead]Disrupt;[nocombat,noexists]Micro-Artillery Controller")
				EditMacro("WSxSGen+F",nil,nil,"#show "..(Get_Spell({{"Sigil of Silence","",""},{"Chaos Nova","",""},{"Netherwalk","!",""},}) or "").."\n/use [help,nocombat,mod:alt]B. F. F. Necklace;[nocombat,noexists,mod:alt]Gastropod Shell\n/cancelaura Spectral Sight")
				EditMacro("WSxCGen+F",nil,nil,"#show Glide\n/cancelaura Wyrmtongue Disguise")
				EditMacro("WSxCAGen+F",nil,nil,"#show "..(Get_Spell("Sigil of Chains","","") or "Fel Rush").."\n/run if not InCombatLockdown() then if C_Spell.GetSpellCharges(195072).currentCharges>=1 then "..tpPants.." else "..noPants.." end end")
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]S.F.E. Interceptor;"..(Get_Spell("Consume Magic","[@mouseover,harm,nodead][]","") or "").."\n/use Mirror of Humility")
				EditMacro("WSxSGen+G",nil,nil,"/use "..(Get_Spell({{"Fel Eruption","",""},{"Chaos Nova","",""},{"Consume Magic","",""},}) or "").."\n/use [noexists,nocombat] Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use ")
				EditMacro("WSxCSGen+G",nil,nil,"#show\n/use "..(Get_Spell("Consume Magic","[@focus,harm,nodead]",";") or "")..(Get_Spell("Chaos Nova") or "").."\n/use Wisp Amulet\n/cancelaura Netherwalk\n/cancelaura Spectral Sight\n/cancelaura Blessing of Protection")
				EditMacro("WSxGenH",nil,nil,"#show Spectral Sight\n/use Wisp Amulet\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;"..(Get_Spell({{"Fiery Brand","[@mouseover,harm,nodead][]",""},{"Blur","",""},{"Darkness","",""},}) or ""))
				EditMacro("WSxGenX",nil,nil,"#show\n/use "..(Get_Spell({{"Netherwalk","[mod:shift][]!",""},{"Soul Barrier","",""},{"Bulk Extraction","",""},}) or "").."\n/use Shadescale")
				EditMacro("WSxGenC",nil,nil,"#show\n/use "..(Get_Spell("Imprison","[@mouseover,harm,nodead][]","") or "").."\n/cancelaura X-Ray Specs")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/run PetDismiss();\n/cry")
				EditMacro("WSxGenV",nil,nil,"#show\n/use "..(Get_Spell("Vengeful Retreat","","") or "").."\n/use Panflute of Pandaria\n/use Haw'li's Hot & Spicy Chili\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
			-- Evoker, Dracthyr, Debra, Dragon, augussy, lizzy
			elseif class == "EVOKER" then
				EditMacro("WSxGen1",nil,nil,"#show\n/use "..(Get_Spell({{"Timelessness","[@mouseover,help,nodead][]",""},{"Echo","[@mouseover,help,nodead][]",""},{"Engulf","[@mouseover,exists,nodead][]",""},{"Pyre","[@mouseover,harm,nodead][]",""},}) or "Hover").."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+1",nil,nil,"#show "..(Get_Spell("Blessing of the Bronze") or "Living Flame").."\n/use [mod:alt,@party3,help,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Living Flame")
				EditMacro("WSxGen2",nil,nil,"#show Azure Strike\n/use Gnomish X-Ray Specs\n/use [@mouseover,harm,nodead][]Azure Strike\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxSGen+2",nil,nil,"/use [mod:alt,@party4,help,nodead][@mouseover,help,nodead][help,nodead][@player]Living Flame\n/targetlasttarget [noexists,nocombat]\n/use [help,nodead]Rainbow Generator\n/use Prismatic Bauble\n/cleartarget [dead]")
				EditMacro("WSxGen3",nil,nil,"#show\n/use "..(Get_Spell({{"Upheaval","[@mouseover,harm,nodead][]",""},{"Eternity Surge","[@mouseover,harm,nodead][]",""},{"Spiritbloom","[@mouseover,help,nodead][]",""},}) or "Fire Breath(Red)").."\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxGen4",nil,nil,"#show\n/use [@mouseover,harm,nodead][]Disintegrate\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxSGen+4",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell({{"Prescience","[@party1,help,nodead,mod:alt]",";"},{"Reversion","[@party1,help,nodead,mod:alt]",";"},}) or "")..(Get_Spell({{"Ebon Might","",""},{"Shattering Star","",""},{"Firestorm","[@mouseover,exists,nodead][@cursor]",""},{"Pyre","",""},{"Temporal Anomaly","",""},}) or "").."\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/stopspelltarget\n/use [@party3,help,nodead,mod:alt]Reversion;[@mouseover,exists,nodead][@cursor]Deep Breath\n/targetenemy [noexists]\n/startattack")
				EditMacro("WSxGen5",nil,nil,"#show "..(Get_Spell({{"Zephyr","[mod:ctrl]",";"},{"Cauterizing Flame","[mod:ctrl]",";"},{"Time Spiral","[mod:ctrl]",";"},{"Spatial Paradox","[mod:ctrl]",";"},}) or "").."Living Flame\n/use "..(Get_Spell({{"Zephyr","[mod:ctrl]",";"},{"Cauterizing Flame","[mod:ctrl]",";"},{"Time Spiral","[mod:ctrl]",";"},{"Spatial Paradox","[mod:ctrl]",";"},}) or "").."[@mouseover,harm,nodead][harm,nodead]Living Flame\n/targetenemy [noexists]\n/use [mod:ctrl] Golden Dragon Goblet")
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use "..(Get_Spell({{"Prescience","[@party2,help,nodead,mod:alt]",";"},{"Reversion","[@party2,help,nodead,mod:alt]",";"},}) or "")..(Get_Spell("Tip the Scales","","") or "").."\n/targetenemy [noexists]\n/startattack")
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod:ctrl,@party4,help,nodead]Reversion;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14")
				EditMacro("WSxGen6",nil,nil,"#show\n/cast "..(Get_Spell({{"Time Skip","[mod:ctrl]",";"},{"Dragonrage","[mod:ctrl]",";"},{"Emerald Communion","[mod:ctrl]!",";"},}) or "").."Fire Breath(Red)".."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+6",nil,nil,"#show\n/cast "..(Get_Spell({{"Dream Breath","",""},{"Rewind","",""},{"Firestorm","[@player]",""},{"Emerald Blossom","[@mouseover,help,nodead][help,nodead][@player]",""},}) or ""))
				EditMacro("WSxGen7",nil,nil,"#show\n/stopspelltarget\n/cast "..(Get_Spell({{"Firestorm","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Dream Flight(Green)","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Pyre","[@mouseover,harm,nodead][]",""},{"Emerald Blossom","[mod:shift,@player][@mouseover,help,nodead][help,nodead][@cursor]",""},{"Echo","[@mouseover,help,nodead][]",""},}) or "[@mouseover,harm,nodead][]Azure Strike").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..(Get_Spell({{"Prescience","",""},{"Rewind","",""},}) or "[@mouseover,harm,nodead][]Azure Strike").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..(Get_Spell({{"Spatial Paradox","",""},{"Pyre","",""},{"Obsidian Scales","",""},}) or ""))
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead,spec:2][@party1,help,nodead,spec:2][@targettarget,help,nodead,spec:2]Naturalize;[mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Expunge")
				EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Living Flame;[mod:alt,@party4,help,nodead,spec:2][@party2,help,nodead,spec:2]Naturalize;[mod:alt,@party4,help,nodead][@party2,help,nodead]Expunge\n/use [nocombat,noharm]Forgotten Feather")
				EditMacro("WSxCSGen+4",nil,nil,"/use "..(Get_Spell("Blistering Scales","[mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]","") or "")..(Get_Spell("Echo","[mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]","") or "").."\n/use [@party1]Apexis Focusing Shard")
				EditMacro("WSxCSGen+5",nil,nil,"/use "..(Get_Spell("Blistering Scales","[mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]","\n/use ") or "")..(Get_Spell("Echo","[mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]","\n/use ") or "").."Battle Standard of Coordination\n/use [@party2]Apexis Focusing Shard")
				EditMacro("WSxGenQ",nil,nil,"/use "..(Get_Spell("Sleep Walk","[mod:alt,@focus,harm,nodead]",";") or "")..(Get_Spell("Quell","[@mouseover,harm,nodead][]","") or ""))
				EditMacro("WSxGenE",nil,nil,"#show\n/use Tail Swipe")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(Get_Spell("Oppressing Roar","","") or "Hover")..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use [@mouseover,help,nodead][help,nodead][@player]Emerald Blossom")
				EditMacro("WSxGenR",nil,nil,"#show\n/stopspelltarget\n/use "..(Get_Spell({{"Time Spiral","[mod:ctrl]",";"},{"Spatial Paradox","[mod:ctrl]",";"},}) or "[mod:ctrl]Hover;")..(Get_Spell("Landslide","[@mouseover,exists,nodead,nomod][@cursor,nomod]",";") or "[nomod]Wing Buffet;").."[mod:shift]Wing Buffet\n/startattack")
				EditMacro("WSxGenT",nil,nil,"#show\n/use "..(Get_Spell("Verdant Embrace","[@mouseover,help,nodead][]","") or "")..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+T",nil,nil,"#show"..(Get_Spell("Rescue","\n/stopspelltarget\n/targetfriendplayer [nohelp,nodead]\n/use [@cursor]","") or "").."\n/cleartarget [dead]\n/use Seafarer's Slidewhistle")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..(Get_Spell("Verdant Embrace","[mod:alt,@party4,nodead][@party2,nodead]","") or ""))
				EditMacro("WSxGenU",nil,nil,"#show "..(Get_Spell({{"Sleep Walk","",""},{"Mass Return","",""},}) or "Return"))
				EditMacro("WSxGenF",nil,nil,"#show Wing Buffet\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,exists,nodead]All-Seer's Eye;[mod:alt]Farwater Conch;"..(Get_Spell("Quell","[@focus,harm,nodead]","") or ""))
				EditMacro("WSxSGen+F",nil,nil,"#show [nocombat,noexists]Soar;Wing Buffet\n/use [help,nocombat,mod:alt]B. F. F. Necklace;[nocombat,noexists,mod:alt]Gastropod Shell\n/use Soar\n/use Hover")
				EditMacro("WSxCGen+F",nil,nil,"#show\n/use "..(Get_Spell({{"Spatial Paradox","[@mouseover,help,nodead][]",""},{"Rewind","",""},{"Zephyr","",""},{"Tip the Scales","",""},}) or "Fire Festival Batons"))
				EditMacro("WSxCAGen+F",nil,nil,"#show Emerald Blossom\n/use [nocombat,noexists]Tear of the Green Aspect"..(Get_Spell("Verdant Embrace","\n/targetfriend [nohelp,nodead]\n/use [help,nodead]","\n/targetlasttarget") or "").."\n/use Prismatic Bauble")
				EditMacro("WSxGenG",nil,nil,"/use [mod:alt]Darkmoon Gazer;"..(Get_Spell("Unravel","[@mouseover,harm,nodead]",";") or "")..(Get_Spell("Naturalize","[spec:2,@mouseover,help,nodead][spec:2]",";") or "")..(Get_Spell("Expunge","[@mouseover,help,nodead][]","") or "").."\n/targetenemy [noexists]\n/use Poison Extraction Totem")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(Get_Spell("Unravel","[@mouseover,harm,nodead][harm,nodead]",";") or "").."Expunge\n/use [noexists,nocombat]Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(Get_Spell("Verdant Embrace","[mod:alt,@party3,nodead][@party1,nodead]","") or ""))
				EditMacro("WSxCSGen+G",nil,nil,"#show\n/use [@focus,help,nodead,spec:2]Naturalize;"..(Get_Spell("Expunge","[@focus,help,nodead]",";") or "").."\n/use Choofa's Call")
				EditMacro("WSxGenH",nil,nil,"#show\n/use "..(Get_Spell("Cauterizing Flame","[@mouseover,help,nodead][]",";") or "Wisp Amulet").."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenZ",nil,nil,"#show\n/use "..(Get_Spell("Black Attunement","[mod:alt,nostance:1]!",";") or "")..(Get_Spell("Bronze Attunement","[mod:alt,stance:1]!",";") or "")..(Get_Spell("Time Dilation","[@mouseover,help,nodead,nomod][nomod]",";") or "")..(Get_Spell("Obsidian Scales","[mod:shift][]","") or "").."\n/use [mod:alt]Gateway Control Shard")
				EditMacro("WSxGenX",nil,nil,"#show\n/use "..(Get_Spell("Bestow Weyrnstone","[@mouseover,help,nodead,mod:alt][mod:alt]",";") or "")..(Get_Spell("Recall","[mod:shift]",";") or "")..(Get_Spell("Renewing Blaze","","") or "Emerald Blossom").."\n/use Shadescale")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/run PetDismiss();\n/cry")
				EditMacro("WSxGenV",nil,nil,"#show\n/use Hover\n/use [nomod]Panflute of Pandaria\n/use Haw'li's Hot & Spicy Chili\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble\n/use Whelps on Strings")
				if playerSpec == 3 then
					EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxCGen+G\",nil,nil,\"\\#show Prescience\\n/use [@\"..N..\"]Prescience\\n/stopspelltarget\", nil)print(\"PSci 1 : \"..N)else print(\"Combat?\")end")
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxCGen+T\",nil,nil,\"\\#show Prescience\\n/use [@\"..N..\"]Prescience\\n/stopspelltarget\", nil)print(\"PSci 2 : \"..N)else print(\"Combat?\")end")
				end 
			end -- avslutar class
		end	-- avslutar racials[race]			
	end -- events
end

ZigiAllButtons:SetScript("OnEvent", function(self, event)
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
			ZigiAllButtons:UnregisterEvent("PLAYER_REGEN_ENABLED")
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