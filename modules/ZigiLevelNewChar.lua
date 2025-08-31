SLASH_ZIGILEVELNEWCHAR1 = "/zigiplz"
local frame = CreateFrame("FRAME", "ZigiLevelNewChar")

local EQS = {
		[1] = "Noon!",
		[2] = "DoubleGate",
		[3] = "Menkify!",
		[4] = "Supermenk",
	}

local icons = {
	["Casual"] = 134411,
	["Speedy"] = 132307,
	["Tipipants"] = 134589,
	["Fishy!"] = 136245,
	["Cooky!"] = 133971,
	-- ["Timewalking"] = 463446,
	["PvP:Alliance"] = 463448,
	["PvP:Horde"] = 463449,
	["DEATHKNIGHT:1"] = 135770,
	["DEATHKNIGHT:2"] = 135773,
	["DEATHKNIGHT:3"] = 135775,
	["DEMONHUNTER:1"] = 1247264,
	["DEMONHUNTER:2"] = 1247265,
	["DRUID:1"] = 136096,
	["DRUID:2"] = 132115,
	["DRUID:3"] = 132276,
	["DRUID:3"] = 132276,
	["DRUID:4"] = 136041,
	["EVOKER:1"] = 4511811,
	["EVOKER:2"] = 4511812,
	["EVOKER:3"] = 5198700,
	["HUNTER:1"] = 461112,
	["HUNTER:2"] = 236179,
	["HUNTER:3"] = 461113,
	["MAGE:1"] = 135932,
	["MAGE:2"] = 135810,
	["MAGE:3"] = 135846,
	["MONK:1"] = 608951,
	["MONK:2"] = 608952,
	["MONK:3"] = 608953,
	["PALADIN:1"] = 135920,
	["PALADIN:2"] = 236264,
	["PALADIN:3"] = 135873,
	["PRIEST:1"] = 135940,
	["PRIEST:2"] = 237542,
	["PRIEST:3"] = 136207,
	["ROGUE:1"] = 236270,
	["ROGUE:2"] = 236286,
	["ROGUE:3"] = 132320,
	["SHAMAN:1"] = 136048,
	["SHAMAN:2"] = 237581,
	["SHAMAN:3"] = 136052,
	["WARLOCK:1"] = 136145,
	["WARLOCK:2"] = 136172,
	["WARLOCK:3"] = 136186,
	["WARRIOR:1"] = 132355,
	["WARRIOR:2"] = 132347,
	["WARRIOR:3"] = 132341,
}

function MakeEqSet(name, icon)
	if not icon then icon = icons[name] end

	if not C_EquipmentSet.GetEquipmentSetID(name) then 
		C_EquipmentSet.CreateEquipmentSet(name, icon)
	end
end

function ZigiLearnDragonriding()
    if InCombatLockdown() then
        print("You are in combat - try again after leaving combat")
    else
        GenericTraitUI_LoadUI()
        GenericTraitFrame:SetSystemID(1)
        if not GenericTraitFrame:IsShown() then ToggleFrame(GenericTraitFrame) end

        local gatherer = false
        for i = 1, 2 do
            local index = select(i, GetProfessions()) or 0
            if index and index > 0 then
                local skillLine = select(7, GetProfessionInfo(index))
                if skillLine == 182 or skillLine == 186 then -- Herbalism or Mining
                    gatherer = true
                end
            end
        end

        if C_AddOns.IsAddOnLoaded("Blizzard_GenericTraitUI") and GenericTraitFrame:IsShown() then
            local c = C_Traits.GetConfigIDBySystemID(1)

            for x = 1, 10 do
                for i, n in ipairs(C_Traits.GetTreeNodes(672)) do
                    local f = C_Traits.GetNodeInfo(c, n)
                    if #f.entryIDs < 2 then -- Single trait
                        C_Traits.PurchaseRank(c, n)
                    else -- Choice node
                        --print(f.ID)

                        if gatherer and f.ID == 64062 then -- Dragonrider's Cultivation/Dragonrider's Hunt
                            C_Traits.SetSelection(c, n, f.entryIDs[1]) -- We have Herbalism or Mining, purchase Dragonrider's Cultivation
                        else -- Any other choice node
                            C_Traits.SetSelection(c, n, f.entryIDs[2]) -- Otherwise always purchase the second choice
                        end
                    end
                end
            end
            -- Save changes
            C_Traits.CommitConfig(c)
            ToggleFrame(GenericTraitFrame)
        else
            print("Could not open Dragonriding UI")
        end
    end
end

local function ZigiSave()
	ZigiLevelNewCharDB = {}
	for i = 1, 125 do
		local actionType, id, subType = GetActionInfo(i)
		
		if actionType == "macro" then
			macroName = GetActionText(i)
			ZigiLevelNewCharDB[i] = macroName
		else
			ZigiLevelNewCharDB[i] = "---"
		end
	end

	DEFAULT_CHAT_FRAME:AddMessage("ZigiLevelNewChar: Current layout has been saved",0.5,1.0,0.0)
end

local function ZigiLoad()
	if ZigiLevelNewCharDB then
		for slot, macroName in pairs(ZigiLevelNewCharDB) do
			if GetActionText(slot) == macroName or macroName == "---" then
			else
				DEFAULT_CHAT_FRAME:AddMessage("ZigiLevelNewChar - ZigiAutoLoader - Updating: "..macroName.." @ "..slot,0.5,1.0,0.0)
				-- print(slot, macroName)
				PickupAction(slot)
				ClearCursor()


				if (macroName ~= "---") then
					PickupMacro(macroName)
					PlaceAction(slot)
					ClearCursor()
				end
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage("ZigiLevelNewChar: Saved layout has been deployed",0.5,1.0,0.0)
	else
		DEFAULT_CHAT_FRAME:AddMessage("ZigiLevelNewChar: There are no saved variables",0.5,1.0,0.0)
	end
end

local function ZigiAutoLoader()
	if ZigiLevelNewCharDB then
		for slot, macroName in pairs(ZigiLevelNewCharDB) do
			if GetActionText(slot) == macroName or macroName == "---" then
			else
				DEFAULT_CHAT_FRAME:AddMessage("ZigiLevelNewChar - ZigiAutoLoader - Updating: "..macroName.." @ "..slot,0.5,1.0,0.0)
				-- print(slot, macroName)
				PickupAction(slot)
				ClearCursor()


				if (macroName ~= "---") then
					PickupMacro(macroName)
					PlaceAction(slot)
					ClearCursor()
				end
			end
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("ZigiLevelNewChar - ZigiAutoLoader: There are no saved variables",0.5,1.0,0.0)
	end
end

local function ZigiEq()
	local class = select(2, UnitClass("player"))
	local faction = UnitFactionGroup("player")
	local specs = 3
	if class == "DEMONHUNTER" then
		specs = 2  
	elseif class == "DRUID" then 
		specs = 4 
	end

	for i = 1, specs do
		MakeEqSet(EQS[i], icons[class .. ":" .. i])
	end

	MakeEqSet("Speedy")
	MakeEqSet("Tipipants")
	MakeEqSet("Fishy!")
	MakeEqSet("Cooky!")
	MakeEqSet("Casual")
	-- MakeEqSet("Timewalking")
	MakeEqSet("PvP", icons["PvP:" .. faction])
	DEFAULT_CHAT_FRAME:AddMessage("ZigiLevelNewChar: Standard Noon equipment sets have been added",0.5,1.0,0.0)

end

function SlashCmdList.ZIGILEVELNEWCHAR(msg, ...)
	if not InCombatLockdown() then
		if msg == "eq" then
			ZigiEq()
		elseif msg == "save" then
			ZigiSave()
		elseif msg == "load" then
			ZigiLoad()
		elseif msg == "autoLoader" then
			ZigiAutoLoader()
		elseif msg == "dragonzigi" then
			ZigiLearnDragonriding()
		elseif msg == "new" then
			EditModeManagerFrame:SelectLayout(3)
			DEFAULT_CHAT_FRAME:AddMessage("ZigiLevelNewChar: Edit Mode Profile Applied",0.5,1.0,0.0)
			SetCVar("autoLootDefault", 1)
			DEFAULT_CHAT_FRAME:AddMessage("ZigiLevelNewChar: autoLootDefault set to 1",0.5,1.0,0.0)
			ZigiLoad()
			ZigiEq()
			ZigiLearnDragonriding()
			-- Configure Battlefield Map
			if not BattlefieldMapFrame then
				BattlefieldMap_LoadUI()
			end  
			if BattlefieldMapFrame then
				BattlefieldMapFrame:Show()
				BattlefieldMapFrame:SetScale(1.4)
				BattlefieldMapFrame:SetAlpha(.9)
				BattlefieldMapFrame:SetPoint("TOPLEFT")
				BattlefieldMapFrame.BorderFrame.CloseButton:Hide()
			end
			DEFAULT_CHAT_FRAME:AddMessage("ZigiLevelNewChar: BattlefieldMapFrame configured and set.",0.5,1.0,0.0)
			DEFAULT_CHAT_FRAME:AddMessage("ZigiLevelNewChar: We are all done here. Enjoy the leveling, Noon! :)",0.5,1.0,0.5)
		elseif msg == "" then
			DEFAULT_CHAT_FRAME:AddMessage("ZigiLevelNewChar: Zigi",0.5,1.0,0.0)
		else
			DEFAULT_CHAT_FRAME:AddMessage("ZigiLevelNewChar: Unacceptable Arguments to ZigiLevelNewChar.SlashCmdList",0.5,1.0,0.0)
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("ZigiLevelNewChar: Daddy blizerd doesn't want you to do that in combat, dippy doo! :)",0.5,1.0,0.0)
	end
end
