function hsBuilder(type, macroCond, semiCol, class, slBP, z, eLevel, playerSpec, race, playerName)
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
			["PALADIN"] = covHS[ZG.slBP()],
			["HUNTER"] = covHS[ZG.slBP()],
			["ROGUE"] = covHS[ZG.slBP()],
			["PRIEST"] = covHS[ZG.slBP()],
			["DEATHKNIGHT"] = covHS[ZG.slBP()],
			["WARRIOR"] = "The Innkeeper's Daughter",
			["DRUID"] = "Noble Gardener's Hearthstone",
			["DEMONHUNTER"] = "Ethereal Portal",
			["EVOKER"] = "Timewalker's Hearthstone",
		}

		if (ZG.class == "MAGE" and ZG.playerSpec == 3) or (ZG.class == "DEATHKNIGHT" and ZG.playerSpec == 2) then
				HS[ZG.class] = "Greatfather Winter's Hearthstone"
		-- elseif (ZG.class == "MAGE" and playerSpec == 1) then
		-- 	HS[ZG.class] = "Tome of Town Portal"
		elseif (ZG.class == "WARLOCK" and ZG.playerName == "Voidlisa") then
			HS[ZG.class] = "Venthyr Sinstone"
		elseif (ZG.class == "MONK" and ZG.playerSpec ~= 1) then 
			HS[ZG.class] = covHS[ZG.ZG.slBP]
		elseif (ZG.class == "PALADIN" and ZG.playerSpec ~=3) or (ZG.class == "PRIEST" and ZG.playerSpec == 2) then
			HS[ZG.class] = "Path of the Naaru"
		elseif ZG.classk == "PIRATE" then
			HS[ZG.class] = "Stone of the Hearth"
		elseif ZG.classk == "SENTINEL_HUNTER" or ZG.classk == "SENTINEL_WARRIOR" then
			HS[ZG.class] = "Night Fae Hearthstone"
		elseif ZG.classk == "DARKRANGER" then
			HS[ZG.class] = "Dominated Hearthstone"
		elseif (ZG.class == "HUNTER" and ZG.playerSpec == 2) then 
			HS[ZG.class] = "Holographic Digitalization Hearthstone"
		elseif (ZG.class == "PRIEST" and ZG.playerSpec == 1) then
			HS[ZG.class] = "Eternal Traveler's Hearthstone"
		elseif ZG.class == "DRUID" then
			if ZG.playerSpec == 1 then
				HS[ZG.class] = "Lunar Elder's Hearthstone"
			elseif ZG.playerSpec == 4 then
				HS[ZG.class] = "Noble Gardener's Hearthstone"
			end
		end

		if ZG.race == "Draenei" or ZG.race == "LightforgedDraenei" then
			HS[ZG.class] = "Draenic Hologem"
		end

		if ZG.GWE() == "Lunar Festival" then
			HS[ZG.class] = "Lunar Elder's Hearthstone"
		elseif ZG.GWE() == "Love is in the Air" then
			HS[ZG.class] = "Peddlefeet's Lovely Hearthstone"
		elseif ZG.GWE() == "Noblegarden" then
			HS[ZG.class] = "Noble Gardener's Hearthstone"
		elseif ZG.GWE() == "Children's Week" then
			-- HS[ZG.class] = "Lunar Elder's Hearthstone"
		elseif ZG.GWE() == "Midsummer Fire Festival" then
			HS[ZG.class] = "Fire Eater's Hearthstone"
		elseif ZG.GWE() == "Brewfest" then
			HS[ZG.class] = "Brewfest Reveler's Hearthstone"
		elseif ZG.GWE() == "Hallow's End" then
			HS[ZG.class] = "Headless Horseman's Hearthstone"
		elseif ZG.GWE() == "Pilgrim's Bounty" then
			-- HS[ZG.class] = "Lunar Elder's Hearthstone"
		elseif ZG.GWE() == "Feast of Winter Veil" then
			HS[ZG.class] = "Greatfather Winter's Hearthstone"
		end

		if ZG.z == "Alterac Valley" and ZG.eLevel > 57 then
			-- race == horde races, else stormpike
			if faction == "Horde" then
				HS[ZG.class] = "Frostwolf Insignia"
			else 
				HS[ZG.class] = "Stormpike Insignia"
			end
		end
		type = HS[ZG.class]
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

		if ZG.classk == "EVOKER" then
			local randomHoloviewer = {
				"Holoviewer: The Timeless One",
				"Holoviewer: The Scarlet Queen",
				"Holoviewer: The Lady of Dreams",
			} 
			randomHoloviewer = randomHoloviewer[random(#randomHoloviewer)]
			hsToy[ZG.classk] = "\n/use "..randomHoloviewer.."\n/use A Collection Of Me"
		end

		type = hsToy[ZG.classk] 
		return (type or "")
	end
end