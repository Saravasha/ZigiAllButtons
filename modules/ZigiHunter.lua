local frame = CreateFrame("FRAME", "ZigiHunter")


frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
frame:RegisterUnitEvent("PET_SPECIALIZATION_CHANGED")
frame:RegisterEvent("PET_STABLE_CLOSED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("VARIABLES_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

function ZigiHunterTrack(order)
    if order == nil then order = true end

    local TrackOrder = {
        [1] = "Track Humanoids",
        [2] = "Track Hidden",
        [3] = "Track Beasts",
        [4] = "Track Demons",
        [5] = "Track Dragonkin",
        [6] = "Track Elementals",
        [7] = "Track Giants",
        [8] = "Track Undead",
    }
    if IsPlayerSpell(229533) then
        table.insert(TrackOrder, #TrackOrder+1, "Track Mechanicals")
    end
    if IsPlayerSpell(43308) then
        table.insert(TrackOrder, #TrackOrder+1, "Find Fish")
    end
    local IsTracked = tInvert(TrackOrder)
    local ActiveTracking = {}
    local cache = {}

    for index = 1, C_Minimap.GetNumTrackingTypes() do
        local info = C_Minimap.GetTrackingInfo(index)
        local name, active = info.name, info.active
        
        if IsTracked[name] then
            cache[IsTracked[name]] = index
            if active then
                ActiveTracking[IsTracked[name]] = true
            end

            C_Minimap.SetTracking(index, false)
        end
    end

    local current = 0
    for i = 1, #TrackOrder do
        if ActiveTracking[i] then
            current = i
        end
    end

    local prev, next = current-1, current+1
    if prev < 1 then prev = #TrackOrder end
    if next > #TrackOrder then next = 1 end

    C_Minimap.SetTracking(order and cache[next] or cache[prev], true)
end


local function eventHandler(self, event)

    if InCombatLockdown() then
        frame:RegisterEvent("PLAYER_REGEN_ENABLED")
    else
        frame:UnregisterEvent("PLAYER_REGEN_ENABLED")
        local _,class = UnitClass("player")
        -- Hunter Misc pet parser
        if class == "HUNTER" and (event == "PET_STABLE_CLOSED" or event == "PLAYER_LOGIN") then
            local petAbilityMacro, petExoticMacro = "/use [mod,@player]Flare;[nopet]Call Pet 4;", "/use [mod:alt]Eyes of the Beast;[nopet]Call Pet 5;"
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
                ["Hopper"] = "Swarm of Flies",
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
                ["Water Strider"] = "Surface Trot",
                ["Worm"] = "Burrow Attack",
            }

            local gotSac = ""
            if IsPlayerSpell(53480) then
                gotSac = C_Spell.GetSpellInfo(53480).name
            end
            -- Hunter Pets
            local petCV = ""
            for index = 1, 5 do
                local petInfo = C_StableInfo.GetStablePetInfo(index) or ""
                local family = petInfo.familyName

                if family and petAbilities[family] then
                    petAbilityMacro = petAbilityMacro .. "[pet:" .. family .. "]" .. petAbilities[family] .. ";"
                end

                if family and petExoticAbilities[family] then
                    if family == "Spirit Beast" then
                        petExoticMacro = petExoticMacro .. "[pet:Spirit Beast,nocombat]Spirit Walk;[pet:Spirit Beast]Spirit Shock;"
                    else
                        petExoticMacro = petExoticMacro .. "[pet:" .. family .. "]" .. petExoticAbilities[family] .. ";"
                    end
                    if (family == "Water Strider" or family == "Feathermane") then
                        petCV = petCV .. "[pet:" .. family .. "]" .. petExoticAbilities[family] .. ";"
                    end
                end
            end
            -- print(petCV)
            -- Call Pet 4, keybind: "H"
            petAbilityMacro = petAbilityMacro .. "\n/use Hunter's Call\n/use [nocombat,noexists,resting]Flaming Hoop" 
            -- keybind: "G"
            petExoticMacro = petExoticMacro .. gotSac .. "\n/use Whole-Body Shrinka'\n/use Poison Extraction Totem" 
            EditMacro("WSxGenH", nil, nil, petAbilityMacro, 1, 1)
            EditMacro("WSxGenG", nil, nil, petExoticMacro, 1, 1)
            local _,_, body = GetMacroInfo("WSxCGen+V")
            -- print(body) 
            if body then    
                EditMacro("WSxCGen+V",nil, nil, body..petCV)
                DEFAULT_CHAT_FRAME:AddMessage("ZigiHunter: Updating Active Pets! :D",0.5,1.0,0.0)
            end 
        end 
    end
end
frame:SetScript("OnEvent", eventHandler)