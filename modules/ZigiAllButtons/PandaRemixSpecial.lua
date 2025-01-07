function pandaremixSpecial(spellType)
	if PlayerGetTimerunningSeasonID() == 1 then
		-- Timerunning active		
		if spellType == "throughputAbilities" then
			local throughputAbilities = {
				[447598] = "Bulwark of the Black Ox",
				[426268] = "Chi-ji, the Red Crane",
				[443389] = "Locus of Power",
				[437011] = "Lifestorm",
				[447566] = "Funeral Pyre",
				[435313] = "Oblivion Sphere",
				[444954] = "Precipice of Madness",
				[444622] = "Ward of Salvation",
				[426748] = "Thundering Orb",
				[444677] = "Soul Tether",
				[444128] = "Tireless Spirit",
			}
			for k,v in pairs(throughputAbilities) do
				if IsSpellKnownOrOverridesKnown(k) then
					spellType = "Meta Gem"
				end
			end	
			if spellType ~= "Meta Gem" then
				spellType = "Artist's Easel"
			end
			return spellType
		end
		if spellType == "movementAbilties" then
			local movementAbilties = {
				[441741] = "Dark Pact",
				[441749] = "Death's Advance",
				[441299] = "Disengage",
				[441569] = "Door of Shadows",
				[427033] = "Heroic Leap",
				[441467] = "Leap of Faith",
				[427026] = "Roll",
				[441576] = "Spirit Walk",
				[441617] = "Spiritwalker's Grace",
				[427030] = "Sprint",
				[441493] = "Stampeding Roar",
				[441348] = "Trailblazer",
				[441479] = "Vanish",
				[427053] = "Blink",
				[441759] = "Soulshape", 
				[441564] = "Pursuit of Justice",		
			}
			for k,v in pairs(movementAbilties) do
				if IsSpellKnownOrOverridesKnown(k) then
					spellType = "Cogwheel Gem" 
				end
			end
			if spellType ~= "Cogwheel Gem" then
				spellType = "Darkmoon Seesaw"
			end
			return spellType
		end
		if spellType == "resItem" then
			if ZG.Item_Count("Timeless Scroll of Resurrection") >= 1 then
				spellType = "Timeless Scroll of Resurrection"
			return spellType
			end 
		end
		if spellType == "meteorChip" then
			if ZG.Item_Count("Meteor Chip") >= 1 then 
				spellType = "\n/use Meteor Chip"
			return spellType
			end
		end
		if spellType == "bottleBees" then
			if ZG.Item_Count("Bottle of Bees") >= 1 then
				spellType = "Bottle of Bees"
				return spellType
			end
		end
		if spellType == "pandaTaxi" then
			local pandaTaxiUsables = {"Tuft of Yak Fur"}
			for i, pandaTaxiUsables in pairs(pandaTaxiUsables) do
				if ZG.Item_Count(pandaTaxiUsables) >= 1 then
					spellType = "\n/use "..pandaTaxiUsables
				end
			end
			return spellType
		end
	else
		-- No Panda Remix, reverting to default panda
		if spellType == "pandaTaxi" then
			local pandaTaxiUsables = {
				"Tuft of Yak Fur",
				"Bag of Kafa Beans"
			}
			for i, pandaTaxiUsables in pairs(pandaTaxiUsables) do
				if ZG.Item_Count(pandaTaxiUsables) >= 1 then
					spellType = "\n/use "..pandaTaxiUsables
				end
			end
			return spellType
		end
	end
end