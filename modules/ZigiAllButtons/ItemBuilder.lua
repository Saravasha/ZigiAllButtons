function itemBuilder(item,option,playerSpec)
	if item == "crKnife" then
		if ZG.Item_Count("Ultimate Gnomish Army Knife") >= 1 then 
			item = "[nocombat]Ultimate Gnomish Army Knife;"
			return item or ""
		else
			item = ""
		end
		return item or "" 
	end
	if item == "glider" then
		if ZG.Item_Count("Goblin Glider Kit") >= 1 then
			item = "\n/use [mod:ctrl]Goblin Glider Kit"
		else 
			item = "\n/use [mod:ctrl]15"
		end
		return item or ""
	end
	if item == "brazier" then
		if ZG.Item_Count("Brazier of Awakening") >= 1 then 
			item = "\n/use [mod:ctrl]Brazier of Awakening"
		else 
			item = ""
		end
		return item or ""
	end
	if item == "resItem" then
		if ZG.Item_Count("Unstable Temporal Time Shifter") >= 1 then 
			item = "[help,dead,nomod]Unstable Temporal Time Shifter;"
		else 
			item = "[help,dead,nomod]9;"
		end
		return item or ""
	end
	if item == "augmentRune" then
		if option <= 70 and ZG.Item_Count("Dreambound Augment Rune") == 1 then
			item = "\n/use [nostealth]Dreambound Augment Rune"
		elseif option <= 50 and ZG.Item_Count("Lightforged Augment Rune") == 1 then
			item = "\n/use [nostealth]Lightforged Augment Rune"
		elseif option <= 60 and ZG.Item_Count("Eternal Augment Rune") == 1 then
			item = "\n/use [nostealth]Eternal Augment Rune"
		else
			item = ""
		end
		return item or ""
	end
	if item == "flyingSkinner" then
		item = ""
		for i = 1, 2 do
            local index = select(i, GetProfessions()) or 0
            if index and index > 0 then
				local skillLine = select(7, GetProfessionInfo(index))
                if skillLine == 393 then -- Skinner
                    item = "[harm,dead]Mother's Skinning Knife;"
                end
            end
        end
        return item or ""
    end
	if item == "inject" then
		-- option = class, playerSpec = playerSpec
		playerSpec = ZG.Player_Info("playerSpec")
		if option == "HUNTER" then
			if playerSpec == 2 then
				item = "\n/use Hypnosis Goggles"
			elseif playerSpec == 3 then
				item = "\n/equipset [noequipped:Two-Hand]Menkify!"
			else
				item = ""
			end
			return item or ""
		elseif option == "WARRIOR" then
			item = "zigi"
			-- option = class, playerSpec = playerSpec
			local EquipmentSets = {"Noon!","DoubleGate", "Menkify!"}
            local OffHands = {}
            local MainHands = {}
            for i, SetName in ipairs(EquipmentSets) do
                local SetID = C_EquipmentSet and C_EquipmentSet.GetEquipmentSetID(SetName)
                if not SetID then return end

                local ItemLocations = C_EquipmentSet.GetItemLocations(SetID)
                local OffHand = ItemLocations[17] or 1
                local MainHand = ItemLocations[16] or 1
                if OffHand > 1 then 
                    -- Om mh är <= 1 så finns det ingen location att hämta
                    -- https://wowpedia.fandom.com/wiki/API_EquipmentManager_UnpackLocation
                    local player, bank, _, void, slot, bag = EquipmentManager_UnpackLocation(OffHand)
                    if player and slot then
                        local weapon = bag and C_Container.GetContainerItemInfo(bag, slot)
                        if weapon and weapon.itemID then
                            OffHands[EquipmentSets[i]] = GetItemInfo(weapon.itemID)
                           elseif player then
                            local itemID = GetInventoryItemID("player", slot)
                            OffHands[EquipmentSets[i]] = GetItemInfo(itemID)
                        end
                    end
                end
                if MainHand > 1 then
                    local player, bank, _, void, slot, bag = EquipmentManager_UnpackLocation(MainHand)
                    if player and slot then
                        local weapon = bag and C_Container.GetContainerItemInfo(bag, slot)
                        if weapon and weapon.itemID then
                            MainHands[EquipmentSets[i]] = GetItemInfo(weapon.itemID)
                           elseif player then
                            local itemID = GetInventoryItemID("player", slot)
                            MainHands[EquipmentSets[i]] = GetItemInfo(itemID)
                        end
                    end
                end
            end
            weapon = (OffHands["Menkify!"] and ("\n/equipslot [noequipped:Shields,mod:shift,nospec:1]17 "..OffHands["Menkify!"]) or "")
            if playerSpec == 1 then
                -- weapon = "\n/equipset [noequipped:shields,mod:shift]Menkify!"
                weapon = (MainHands["Menkify!"] and ("\n/equipslot [noequipped:One-Hand,mod:shift]16 "..MainHands["Menkify!"]) or "")..(OffHands["Menkify!"] and (";[noequipped:Shields,mod:shift]17 "..OffHands["Menkify!"]) or "")
            end
            item = weapon
			return item or ""
		end
	end
	if item == "instrument" then
		-- Arcanite Ripper
		if ZG.Item_Count(39769) >= 1 and (select(2,C_Container.GetItemCooldown(39769)) == 0) then
			item = 39769
		-- Phoenix Lute
		elseif ZG.Item_Count(44924) >= 1 and (select(2,C_Container.GetItemCooldown(44924)) == 0) then
			item = 44924
		-- Death Resonator
		elseif ZG.Item_Count(151255) >= 1 and (select(2,C_Container.GetItemCooldown(151255)) == 0) then
			item = 151255
		elseif ZG.Item_Count(39769) >=1 then
			item = 39769
		-- Phoenix Lute
		elseif ZG.Item_Count(44924) >=1 then
			item = 44924
		-- Death Resonator
		elseif ZG.Item_Count(151255) >=1 then
			item = 151255
		else
			item = 0
		end
		item = "\n/run if select(2,C_Container.GetItemCooldown("..item.."))==0 then EquipItemByName("..item..") else "..option.." end\n/use 16"
		return item or "" 
	end
	if item == "fartToy" then
		item = "Foul Belly"
		if option == 4 then
			item = "Notfar's Favorite Food"
		elseif option == 1 and ZG.Item_Count("item:177278") > 0 then  -- phial of serenity
			item = "item:177278"
		end
		return item or ""
	end
	if item == "broom" then
		item = "[nocombat,noexists]Worn Doll;"
		if ZG.Item_Count("Anti-Doom Broom") >= 1 then
			item = "[nocombat,noexists]Anti-Doom Broom;"
		end
		return item or ""
	end
end