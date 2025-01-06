function hsBuilder(type, macroCond, semiCol, class, slBP, z, eLevel, playerSpec, race, playerName)
	
	local classk = ZG.Player_Info("classk")
	local gHI = ZG.World_Event()

	if type == "HS" then
		-- Covenant Hearthstone
		local covHS = {
			[0] = "Hearthstone",
			[1] = "Kyrian Hearthstone",
			[2] = "Venthyr Sinstone",
			[3] = "Night Fae Hearthstone",
			[4] = "Necrolord Hearthstone",
			[5] = "Dominated Hearthstone",
			[6] = "Enlightened Hearthstone",
		}
		-- Hearthstones
		local HS = {
			["SHAMAN"] = "Ohn'ir Windsage's Hearthstone",
			["MAGE"] = "Tome of Town Portal",
			["WARLOCK"] = "Headless Horseman's Hearthstone",
			["MONK"] = "Brewfest Reveler's Hearthstone",
			["PALADIN"] = covHS[slBP],
			["HUNTER"] = covHS[slBP],
			["ROGUE"] = covHS[slBP],
			["PRIEST"] = covHS[slBP],
			["DEATHKNIGHT"] = covHS[slBP],
			["WARRIOR"] = "The Innkeeper's Daughter",
			["DRUID"] = "Noble Gardener's Hearthstone",
			["DEMONHUNTER"] = "Ethereal Portal",
			["EVOKER"] = "Timewalker's Hearthstone",
		}


		if (class == "MAGE" and playerSpec == 3) or (class == "DEATHKNIGHT" and playerSpec == 2) then
				HS[class] = "Greatfather Winter's Hearthstone"
		-- elseif (class == "MAGE" and playerSpec == 1) then
		-- 	HS[class] = "Tome of Town Portal"
		elseif (class == "WARLOCK" and playerName == "Voidlisa") then
			HS[class] = "Venthyr Sinstone"
		elseif (class == "MONK" and playerSpec ~= 1) then 
			HS[class] = covHS[slBP]
		elseif (class == "PALADIN" and playerSpec ~=3) or (class == "PRIEST" and playerSpec == 2) then
			HS[class] = "Path of the Naaru"
		elseif classk == "PIRATE" then
			HS[class] = "Stone of the Hearth"
		elseif classk == "SENTINEL_HUNTER" or classk == "SENTINEL_WARRIOR" then
			HS[class] = "Night Fae Hearthstone"
		elseif classk == "DARKRANGER" then
			HS[class] = "Dominated Hearthstone"
		elseif (class == "HUNTER" and playerSpec == 2) then 
			HS[class] = "Holographic Digitalization Hearthstone"
		elseif (class == "PRIEST" and playerSpec == 1) then
			HS[class] = "Eternal Traveler's Hearthstone"
		elseif class == "DRUID" then
			if playerSpec == 1 then
				HS[class] = "Lunar Elder's Hearthstone"
			elseif playerSpec == 4 then
				HS[class] = "Noble Gardener's Hearthstone"
			end
		end

		if race == "Draenei" or race == "LightforgedDraenei" then
			HS[class] = "Draenic Hologem"
		end

		if gHI == "Lunar Festival" then
			HS[class] = "Lunar Elder's Hearthstone"
		elseif gHI == "Love is in the Air" then
			HS[class] = "Peddlefeet's Lovely Hearthstone"
		elseif gHI == "Noblegarden" then
			HS[class] = "Noble Gardener's Hearthstone"
		elseif gHI == "Children's Week" then
			-- HS[class] = "Lunar Elder's Hearthstone"
		elseif gHI == "Midsummer Fire Festival" then
			HS[class] = "Fire Eater's Hearthstone"
		elseif gHI == "Brewfest" then
			HS[class] = "Brewfest Reveler's Hearthstone"
		elseif gHI == "Hallow's End" then
			HS[class] = "Headless Horseman's Hearthstone"
		elseif gHI == "Pilgrim's Bounty" then
			-- HS[class] = "Lunar Elder's Hearthstone"
		elseif gHI == "Feast of Winter Veil" then
			HS[class] = "Greatfather Winter's Hearthstone"
		end

		if z == "Alterac Valley" and eLevel > 57 then
			-- race == horde races, else stormpike
			if faction == "Horde" then
				HS[class] = "Frostwolf Insignia"
			else 
				HS[class] = "Stormpike Insignia"
			end
		end
		type = HS[class]
		return (macroCond or "") .. (type or "") .. (semiCol or "")
	end
	if type == "hsToy" then
		local hsToy = {
			["SHAMAN"] = "\n/use Portable Audiophone\n/use Underlight Sealamp",
			["MAGE"] = "\n/use [harm,nodead]Gaze of the Darkmoon;Magic Fun Rock",
			["WARLOCK"] = "\n/cancelaura Golden Hearthstone Card: Lord Jaraxxus\n/use Golden Hearthstone Card: Lord Jaraxxus",
			["MONK"] = "\n/use Brewfest Chowdown Trophy",
			["PALADIN"] = "\n/use Jar of Sunwarmed Sand",
			["HUNTER"] = "\n/use Tiny Mechanical Mouse\n/use Xan'tish's Flute",
			["ROGUE"] = "\n/use Cursed Spyglass",
			["PRIEST"] = "\n/use Steamy Romance Novel Kit\n/use For da Blood God!",
			["DEATHKNIGHT"] = "\n/use Coldrage's Cooler",
			["WARRIOR"] = "\n/cancelaura Tournament Favor\n/use Tournament Favor\n/use Kovork Kostume",
			["DRUID"] = "\n/cancelaura Make like a Tree\n/use Ancient's Bloom\n/use Primal Stave of Claw and Fur\n/use Dreamsurge Remnant",
			["DEMONHUNTER"] = "\n/cancelaura Golden Hearthstone Card: Lord Jaraxxus\n/use Golden Hearthstone Card: Lord Jaraxxus",
			["PIRATE"] = "\n/use Slightly-Chewed Insult Book\n/use Cursed Spyglass",
			["SENTINEL_WARRIOR"] = "\n/use Owl Post",
		}

		if classk == "EVOKER" then
			local randomHoloviewer = {
				"Holoviewer: The Timeless One",
				"Holoviewer: The Scarlet Queen",
				"Holoviewer: The Lady of Dreams",
			} 
			randomHoloviewer = randomHoloviewer[random(#randomHoloviewer)]
			hsToy[classk] = "\n/use "..randomHoloviewer.."\n/use A Collection Of Me"
		end

		type = hsToy[classk] 
		return (type or "")
	end
end