function consumableBuilder(consumable,macroCond,semiCol)
	
	local class = ZG.Player_Info("class")
	local z = ZG.Player_Info("z")
	local instanceType = ZG.Instance_Info("instanceType")
	local difficultyID = ZG.Instance_Info("difficultyID")
	local race = ZG.Player_Info("race")
	local playerSpec = ZG.Player_Info("playerSpec")
	local playerName = ZG.Player_Info("playerName")

	if consumable == "invispot" then
		-- hasInvisPot parser
		local hasInvisPot = {
	    	"Potion of the Hushed Zephyr"
		}
		local hasInvisPotInBags = ""
		for i, hasInvisPot in pairs(hasInvisPot) do
			if ZG.Item_Count(hasInvisPot) >= 1 then
		    	hasInvisPotInBags = hasInvisPot
			end
		end
		if ZG.Item_Count("Overengineered Sleeve Extenders") >= 1 and playerName == "Voidlisa" then
			hasInvisPot = "9"
		end
		hasInvisPot = hasInvisPotInBags
		if (instanceType == "pvp") then
			hasInvisPot = "Potion of Trivial Invisibility"
		end 
		if hasInvisPot == "" then
			hasInvisPot = "Malfunctioning Stealthman 54"
		end
		return (hasInvisPot or "")
	end

	if consumable == "tonic" then
		-- macroCond = playerName, semiCol = instanceType
		local hasTonics = {
			"Man'ari Training Amulet",
			"Eternal Woven Ivy Necklace",
			"Eternal Will of the Martyr",	
			"Eternal Talisman of Evasion",
			"Eternal Horizon Choker",
			"Eternal Emberfury Talisman",
			"Eternal Amulet of the Redeemed",
		}
		local neckIsEquipped = ""
		for i, hasTonics in pairs(hasTonics) do
			if IsEquippedItem(hasTonics) == true then
				neckIsEquipped = hasTonics
			end	
		end
		if neckIsEquipped == "" then
			hasTonics = {
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
				"Refreshing Healing Potion",
				"Dreamwalker's Healing Potion",
				"item:137222",
				"Powerful Flask of Renewal",
				"Timerunner's Draught of Health",
				"Cavedweller's Delight",
				"Algari Healing Potion",
			}
			for i, hasTonics in pairs(hasTonics) do
				if ZG.Item_Count(hasTonics) >= 1 then
			    	neckIsEquipped = hasTonics
				end
			end
			if neckIsEquipped == "" then
				neckIsEquipped = hasScrapper
			elseif z == "Brawl'gar Arena" then
				neckIsEquipped = "Brawler's Coastal Healing Potion"
			elseif instanceType == "pvp" and ZG.Item_Count("\"Third Wind\" Potion") >= 1 then 
				neckIsEquipped = "\"Third Wind\" Potion"
			end
		end
		return (macroCond or "")..(neckIsEquipped or "")..(semiCol or "")
	end

	if consumable == "potion" then
		local hasPot = ""
    	-- Throughput Potion parser
		if instanceType == "pvp" and ZG.Item_Count("Saltwater Potion", false, true) >= 1 then
			hasPot = "Saltwater Potion"
		elseif IsInJailersTower() == true and ZG.Item_Count("Fleeting Frenzy Potion", false, true) >= 1 then
			hasPot = "Fleeting Frenzy Potion"
		elseif IsInJailersTower() == true and ZG.Item_Count("Mirror of the Conjured Twin", false, true) >= 1 then
			hasPot = "Mirror of the Conjured Twin"
		else

			

			  -- Role definition scope for dps potions
			local primary = "int"
			if (class == "DEMONHUNTER") or (class == "DRUID" and (playerSpec == 2 or playerSpec == 3)) or (class == "HUNTER") or (class == "MONK" and playerSpec ~= 2) or (class == "ROGUE") or (class == "SHAMAN" and playerSpec == 2) then
				primary = "agi"
			elseif (class == "DEATHKNIGHT") or (class == "WARRIOR") or (class == "PALADIN" and playerSpec ~= 1) then
				primary = "str"
			end
			local hasPotInBags = ""
			hasPot = {
				[171273] = "int",
				[169299] = "int",
				[168498] = "int",
				[168489] = "agi",
				[168500] = "str",
				[163222] = "int",
				[163223] = "agi",
				[163224] = "str",
			}
			for k, v in pairs(hasPot) do
			    if ZG.Item_Count(hasPot[k]) >= 1 and primary == hasPot[v] then
			        hasPotInBags = "item:"..hasPot[k]
			    end
			end
			if hasPotInBags == "" then
				hasPot = {
					171349,
					169299,
					191383,
					191389,
					191388,
					191387,
					191382,
					191381,
					142117,
					217904,
					212264,

				}
				for i, hasPot in pairs(hasPot) do
				    if ZG.Item_Count(hasPot) >= 1 then
				        hasPotInBags = "item:"..hasPot
				    end
				end
				hasPot = hasPotInBags
			end	
		end
		return (macroCond or "")..(hasPot or "")..(semiCol or "")
	end

	if consumable == "bandages" then
		-- First Aid Bandages Parser
        local hasBandages = {
	        "Tidespray Linen Bandage",
	        "Deep Sea Bandage",
	        "Shrouded Cloth Bandage",
	        "Heavy Shrouded Cloth Bandage",
	        "Wildercloth Bandage",
	        "Timerunner's Bandage",
	        "Weavercloth Bandage",
 	   	}
 	   	local hasBandagesInBags = ""
 	   	for i, hasBandages in pairs(hasBandages) do 
	 	   	if ZG.Item_Count(hasBandages) >= 1 then
	 	   		hasBandagesInBags = hasBandages
	 	   	end
	 	end
	 	if ZG.Item_Count(hasBandagesInBags) < 1 then
	 		macroCond = ""
	 	end
	 	return (macroCond or "")..(hasBandagesInBags or "")..(semiCol or "")
	end

	if consumable == "manapot" then
		-- Mana Potion Parser
        consumable = {
	        "Potion of Frozen Focus",
	        "Aerated Mana Potion",
	        "Timerunner's Vial",
 	   	}
 	   	local hasManaPotsInBag = ""
 	   	for i, consumable in pairs(consumable) do 
	 	   	if ZG.Item_Count(consumable) >= 1 then
	 	   		hasManaPotsInBags = consumable
	 	   	end
	 	end
	 	consumable = hasManaPotsInBags
	 	if hasManaPotsInBags == "" or hasManaPotsInBags == nil then
	 		macroCond = ""
	 		semiCol = ""
	 	end
	 	return (macroCond or "")..(consumable or "")..(semiCol or "")
	end

	if consumable == "water" then
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
		    "Grub Grub",
		    "item:170068",
		    "item:169763",
		    "Seafoam Coconut Water",
		    "Rockskip Mineral Water",
		    "Purified Skyspring Water",
		    "Ethereal Pomegranate",
		    "Shadespring Water",
		    "Stygian Stew",
		    "Azure Leywine",
		    "Delicious Dragon Spittle",
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
		    if ZG.Item_Count(hasWaters) >= 1 then
		        hasWaterInBags = hasWaters
		    end
		end
		if ZG.Item_Count(hasWaterInBags) < 1 and class == "MAGE" then 
			hasWaters = "Conjure Refreshment"
		end
		if hasWaterInBags == "" or hasWaterInBags == nil then
			macroCond = ""
			semiCol = ""
		end
		return (macroCond or "")..(hasWaterInBags or "")..(semiCol or "")	
	end

	if consumable == "managem" then
		if ZG.Item_Count(36799) >= 1 then
			hasManaGem = "item:36799"		
		elseif Get_Spell("Displacement") == "Displacement" then 
			hasManaGem = "Displacement"
			--Arcane
		elseif ZG.Item_Count(87257) >= 1 then
			hasManaGem = "item:87257"
			--Fiery
		elseif ZG.Item_Count(87258) >= 1 then
			hasManaGem = "item:87258"
			--Icy
		elseif ZG.Item_Count(87259) >= 1 then
			hasManaGem = "item:87259"
		else 
			hasManaGem = "Conjure Mana Gem"
		end
		return (macroCond or "")..(hasManaGem or "")..(semiCol or "")
	end

	if consumable == "nimblebrew" then
		local nimbleBrew = "Magic Pet Mirror"
		if ZG.Item_Count("Nimble Brew") >= 1 then 
			nimbleBrew = "Nimble Brew"
		end
		return (macroCond or "")..(nimbleBrew or "")..(semiCol or "") 
	end

	if consumable == "bladlast" then
		local faction = ZG.Player_Info("faction")
		-- consumable = , macroCond = faction, semiCol = instanceType
		consumable = {
			"Drums of Rage",
			"Drums of Fury",
			"Drums of the Mountain",
			"Drums of the Maelstrom",
			"Drums of Deathly Ferocity",
			"Feral Hide Drums",
			"Timeless Drums",
		}
		local hasDrumsInBags = "Hot Buttered Popcorn"
		for i, consumable in pairs(consumable) do
		    if ZG.Item_Count(consumable) >= 1 then
		        hasDrumsInBags = consumable
		    end
		end
		local name = ZG.Player_Aura("Lone Wolf") 
		if class == "SHAMAN" and macroCond == "Alliance" and Get_Spell("Heroism") then 
	    	hasDrumsInBags = "Heroism"
		elseif class == "SHAMAN" and Get_Spell("Bloodlust") then 
			hasDrumsInBags = "Bloodlust"
		elseif class == "MAGE" and Get_Spell("Time Warp") then 
			hasDrumsInBags = "Time Warp"
		elseif class == "HUNTER" then
			if IsSpellKnownOrOverridesKnown(272678) == true then
				hasDrumsInBags = "[nopet]Call Pet 5;[pet]Primal Rage"
			-- hunter med bl drums
			elseif (name ~= "Lone Wolf" and (IsSpellKnownOrOverridesKnown(272678) == false) and ZG.Item_Count(hasDrumsInBags) >= 1) then
				hasDrumsInBags = "[nopet]Call Pet 5;[pet]"..hasDrumsInBags
			-- hunter med bl pet
			-- elseif (name == nil and petSpec == 1) then
			-- 	bladlast = "[nopet]Call Pet 5;[pet]Command Pet" 
			-- lone wolf hunter med bl drums
			elseif name == "Lone Wolf" then
				hasDrumsInBags = "[nopet]"..hasDrumsInBags..";[pet]Command Pet" 
			end
		elseif class == "EVOKER" and Get_Spell("Fury of the Aspects") then 
			hasDrumsInBags = "Fury of the Aspects\n/use Prismatic Bauble\n/targetfriendplayer\n/use [help,nodead]Rainbow Generator\n/targetlasttarget [exists]"
		end
		return hasDrumsInBags or ""
	end
end