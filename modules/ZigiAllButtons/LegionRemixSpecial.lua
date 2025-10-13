function legionremixSpecial(spellType)
	if PlayerGetTimerunningSeasonID() == 2 then
		-- Timerunning active		
		if spellType == "throughputAbilities" then
			local throughputAbilities = {
				[1233577] = "Call of the Forest",
				[1237711] = "Twisted Crusade",
				[1233775] = "Naran's Everdisc",
				[1233181] = "Tempest Wrath",
				[1251045] = "Vindicator's Judgment",
			}
			for k,v in pairs(throughputAbilities) do
				if IsSpellKnownOrOverridesKnown(k) then
					spellType = v
				end
			end	
			-- print("spellType: ",spellType)
			if spellType == "throughputAbilities" then
				spellType = "Artist's Easel"
			end
			return spellType
		end
		if spellType == "movementAbilties" then
			local movementAbilties = {
				[1236723] = "Remix Time(Infinite)",		
			}
			for k,v in pairs(movementAbilties) do
				if IsSpellKnownOrOverridesKnown(k) then
					spellType = v 
				end
			end
			-- print("spellType: ",spellType)
			if spellType == "movementAbilties" then
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
			if ZG.Item_Count("Fel Meteorite") >= 1 then 
				spellType = "\n/use Fel Meteorite"
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