-- This file is loaded from "ZigiAllButtons.toc"

-- This addon sets all the desired Cvars for Targeting to desired levels and make it less shitty.
-- It's purpose is also to consolidate my macros and make them change relevancy upon the event PLAYER_ENTERING_WORLD.

-- Healthstone 


local frame = CreateFrame("FRAME", "ZigiAllButtons")

frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PET_SPECIALIZATION_CHANGED")
frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
frame:RegisterEvent("BAG_UPDATE_DELAYED")
--frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

-- Putting this event on hold for now, seems to cause problems maybe - i'm going to have to see if  applied changes solves it, then remove this part: frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

-- Seem to be logging taints from this section due to being able to attempt to run it in combat, could we add a way to stop it from doing that in combat?

-- Giving credit to Leo Bolinski for the Healthstone addon :) Thank you, Noon!

local function eventHandler(self, event) 
--	SetCVar("cameraDistanceMaxZoomFactor", 2.6)
--	SetCVar("nameplateMaxDistance", 40) 
--	SetCVar("nameplateOtherTopInset", -1) 
--	SetCVar("nameplateOtherBottomInset", -1)
--	SetCVar("TargetNearestUseOld", 1)
--  SetCVar("TargetPriorityValueBank", 0)
SetCVar("nameplateShowAll", 0)
SetCVar("nameplateShowEnemies", 1)
SetCVar("nameplateShowFriends", 0)
SetCVar("Sound_EnableMusic", 0)
--This stops the annoying buy when in Order Hall and can't press escape to log out...
--SetBinding("ESCAPE","TOGGLEGAMEMENU") SaveBindings(GetCurrentBindingSet())


-- Basic Scope, copy paste for each new ability you want to add and change editmacro and macroname.
-- 		if class == "SHAMAN" then
-- 			EditMacro("MacroName",nil,nil,"")
-- 		elseif class == "MAGE" then
-- 			EditMacro("MacroName",nil,nil,"")
-- 		elseif class == "WARLOCK" then
-- 			EditMacro("MacroName",nil,nil,"")
-- 		elseif class == "MONK" then
-- 			EditMacro("MacroName",nil,nil,"")
-- 		elseif class == "PALADIN" then
-- 			EditMacro("MacroName",nil,nil,"")
-- 		elseif class == "HUNTER" then
-- 			EditMacro("MacroName",nil,nil,"")
-- 		elseif class == "ROGUE" then
-- 			EditMacro("MacroName",nil,nil,"")
-- 		elseif class == "PRIEST" then
-- 			EditMacro("MacroName",nil,nil,"")
-- 		elseif class == "DEATHKNIGHT" then
-- 			EditMacro("MacroName",nil,nil,"")
-- 		elseif class == "WARRIOR" then
-- 			EditMacro("MacroName",nil,nil,"")
-- 		elseif class == "DRUID" then
-- 			EditMacro("MacroName",nil,nil,"")
-- 		elseif class == "DEMONHUNTER" then
-- 			EditMacro("MacroName",nil,nil,"")
-- 		end

    -- Main Chunk of code for addon functions. 
	
	if event == "BAG_UPDATE_DELAYED" then
		if InCombatLockdown() == false then
	    	if GetItemCount("Healthstone") >= 1 then
	        	-- Healthstone found in bags
	        	EditMacro("WShow",nil,nil,"#showtooltip\n/use [mod:ctrl] Tome of Town Portal; [mod:shift]Silkweave Bandage;[nomod]Healthstone\n/use [nomod] Winning Hand\n/script PlaySound(15160)\n/glare")
	    	elseif GetItemCount("Astral Healing Potion") >= 1 and UnitLevel("player") >= 110 then
	        	-- Astral Healing Potion found in bags and level 110+
	        	EditMacro("WShow",nil,nil,"#showtooltip\n/use [mod:ctrl] Tome of Town Portal; [mod:shift]Silkweave Bandage;[nomod]Astral Healing Potion\n/use [nomod] Winning Hand\n/script PlaySound(15160)\n/glare")
	    	elseif GetItemCount("Aged Health Potion") >= 1 and UnitLevel("player") >= 100 then
	        	-- Aged Health Potion found in bags and level 100+ (for Rogues mostly)
	        	EditMacro("WShow",nil,nil,"#showtooltip\n/use [mod:ctrl] Tome of Town Portal; [mod:shift]Silkweave Bandage;[nomod]Aged Health Potion\n/use [nomod] Winning Hand\n/script PlaySound(15160)\n/glare")
	    	elseif GetItemCount("Ancient Healing Potion") >= 1 and UnitLevel("player") >= 100 then
	        	-- Ancient Healing Potion found in bags and level 100+
	        	EditMacro("WShow",nil,nil,"#showtooltip\n/use [mod:ctrl] Tome of Town Portal; [mod:shift]Silkweave Bandage;[nomod]Ancient Healing Potion\n/use [nomod] Winning Hand\n/script PlaySound(15160)\n/glare")
	    	elseif UnitLevel("player") <= 109 then
	       		-- Below level 110, assume heirloom neck
	        	EditMacro("WShow",nil,nil,"#showtooltip\n/use [mod:ctrl] Tome of Town Portal; [mod:shift]Silkweave Bandage;[nomod]2\n/use [nomod] Winning Hand\n/script PlaySound(15160)\n/glare")
	    	else
	        	-- No useable WShow
	        	EditMacro("WShow",nil,nil,"#showtooltip\n/use [mod:ctrl] Tome of Town Portal; [mod:shift]Silkweave Bandage;[nomod]Healthstone\n/use [nomod] Winning Hand\n/script PlaySound(15160)\n/glare")
            end
        end
    end	

  	if event == "ACTIVE_TALENT_GROUP_CHANGED" or
  	   event == "PLAYER_ENTERING_WORLD" or
  	   event == "PET_SPECIALIZATION_CHANGED" then
		local _,race = UnitRace("player")
		local _,class = UnitClass("player")
  		local playerspec = GetSpecialization(false,false)
  		local petspec = GetSpecialization(false,true)

				-- Healthstones, First Aid, Hearthstone, etc.
	
		-- Alt+J, Swapper Pet Swapper and Toy Using for class/specs.
	
		-- Shaman checks for race aswell.
		if class == "SHAMAN" then
			if race == "Orc" then
				EditMacro("WSxSwapper",nil,nil,"#show [spec:1]Earth Elemental;Purge\n/run local a={\"Snowfang\",\"Frostwolf Ghostpup\",\"Bound Stream\",\"Pebble\",\"Soul of the Forge\",\"Zephyrian Prince\",\"Lost Netherpup\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end") 
		 	elseif race == "Troll" then
				EditMacro("WSxSwapper",nil,nil,"#show [spec:1]Earth Elemental;Purge\n/run local a={\"Voodoo Figurine\",\"Lashtail Hatchling\",\"Drafty\",\"Searing Scorchling\",\"Bound Stream\",\"Mojo\",\"Lumpy\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			end
		end
		
		if class == "MAGE" then
			if playerspec == 1 then
				EditMacro("WSxSwapper",nil,nil,"#showtooltip Frost Nova\n/run local a={\"Lil' Tarecgosa\",\"Trashy\",\"Wondrous Wisdomball\",\"Stardust\",\"Noblegarden Bunny\",\"Feline Familiar\",\"Magical Crawdad\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			elseif playerspec == 2 then
				EditMacro("WSxSwapper",nil,nil,"#showtooltip Frost Nova\n/run local a={\"Lil' Tarecgosa\",\"Trashy\",\"Nethaera's Light\",\"Phoenix Hatchling\",\"Stardust\",\"Noblegarden Bunny\",\"Feline Familiar\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			else
				EditMacro("WSxSwapper",nil,nil,"#showtooltip Frost Nova\n/run local a={\"Lil' Tarecgosa\",\"Mr. Chilly\",\"Tiny Snowman\",\"Stardust\",\"Noblegarden Bunny\",\"Feline Familiar\",\"Frigid Frostling\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			end
		end
			
		if class == "WARLOCK" then
			EditMacro("WSxSwapper",nil,nil,"#show Soul Leech\n/run local a={\"Rebellious Imp\",\"Lesser Voidcaller\",\"Netherspace Abyssal\",\"Horde Fanatic\",\"Cross Gazer\",\"Sister of Temptation\",\"Nibbles\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
		elseif class == "MONK" then
			EditMacro("WSxSwapper",nil,nil,"#show Zen Flight\n/run local a={\"Chi-Chi, Hatchling of Chi-Ji\",\"Yu'la, Broodling of Yu'lon\",\"Xu-Fu, Cub of Xuen\",\"Zao, Calfling of Niuzao\",\"Ban-Fu, Cub of Ban-Lu\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
		elseif class == "PALADIN" then
			EditMacro("WSxSwapper",nil,nil,"#showtooltip [spec:1/2][spec:3,talent:1/3]Consecration;[spec:3,talent:1/2]Execution Sentence;[spec:3]Greater Blessing of Kings;\n/summonpet [spec:1/3]K'ute;[spec:2]Draenei Micro Defender;\n/use Burning Blade\n/use [spec:3]Blazing Wings")
		end

		if class == "HUNTER" then
			if petspec == 1 then
				EditMacro("WSxSwapper",nil,nil,"#showtooltip Heart of the Phoenix\n/run local a={\"Rocket Chicken\",\"Blackfuse Bombling\",\"Baby Elderhorn\",\"Nuts\",\"Tito\",\"Stormwing\",\"Fox Kit\",\"Son of Skum\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			elseif petspec == 2 then
				EditMacro("WSxSwapper",nil,nil,"#showtooltip Last Stand\n/run local a={\"Rocket Chicken\",\"Blackfuse Bombling\",\"Baby Elderhorn\",\"Alarm-o-Bot\",\"Tito\",\"Stormwing\",\"Fox Kit\",\"Son of Skum\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			else
				EditMacro("WSxSwapper",nil,nil,"#showtooltip Bullheaded\n/run local a={\"Rocket Chicken\",\"Blackfuse Bombling\",\"Baby Elderhorn\",\"Nuts\",\"Tito\",\"Stormwing\",\"Fox Kit\",\"Son of Skum\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end") 
			end
		end

		if class == "ROGUE" then
			EditMacro("WSxSwapper",nil,nil,"#showtooltip Vanish\n/run local a={\"Disgusting Oozeling\",\"Pocket Cannon\",\"Gilnean Raven\",\"Sneaky Marmot\",\"Giant Sewer Rat\",\"Creepy Crate\",\"Crackers\",\"Hopling\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
		end

		if class == "PRIEST" then
			if playerspec == 1 then 
				EditMacro("WSxSwapper",nil,nil,"#showtooltip Mass Dispel\n/run local a={\"Nightmare Bell\",\"Argi\",\"K'ute\",\"Dread Hatchling\",\"Argent Gruntling\",\"Shadow\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			elseif playerspec == 2 then
				EditMacro("WSxSwapper",nil,nil,"#showtooltip Mass Dispel\n/run local a={\"Argi\",\"K'ute\",\"Argent Gruntling\",\"Argi\",\"Sunborne Val'kyr\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			else
				EditMacro("WSxSwapper",nil,nil,"#showtooltip Mass Dispel\n/run local a={\"Shadow\",\"K'ute\",\"Hungering Claw\",\"Creeping Tentacle\",\"Dread Hatchling\",\"Faceless Minion\",\"Grasping Manifestation\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			end
		end

		if class == "DEATHKNIGHT" then
			if playerspec == 1 then
				EditMacro("WSxSwapper",nil,nil,"#show On a Pale Horse\n/run local a={\"Bloodbrood Whelpling\",\"Lost of Lordaeron\",\"Blightbreath\",\"Boneshard\",\"Grotesque\",\"Stinkrot\",\"Unborn Val'kyr\",\"Naxxy\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			elseif playerspec == 2 then
				EditMacro("WSxSwapper",nil,nil,"#show On a Pale Horse\n/run local a={\"Frostbrood Whelpling\",\"Lost of Lordaeron\",\"Mr. Bigglesworth\",\"Boneshard\",\"Landro's Lichling\",\"Unborn Val'kyr\",\"Naxxy\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			else
				EditMacro("WSxSwapper",nil,nil,"#show On a Pale Horse\n/run local a={\"Vilebrood Whelpling\",\"Lost of Lordaeron\",\"Boneshard\",\"Grotesque\",\"Stinkrot\",\"Unborn Val'kyr\",\"Mr. Bigglesworth\",\"Naxxy\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			end
		end

		if class == "WARRIOR" then
			EditMacro("WSxSwapper",nil,nil,"#showtooltip [spec:1/2,talent:2/1][spec:3,talent:1/1]Shockwave;[spec:3,talent:1/2][spec:1/2,talent:2/2]Storm Bolt;[spec:2]Piercing Howl;Charge;\n/use Darkspear Pride\n/summonpet [spec:1]Darkmoon Rabbit;[spec:2]Sunborne Val'kyr;[spec:3]Tuskarr Kite")
		end
		
		if class == "DRUID" then
			if playerspec == 1 then
				EditMacro("WSxSwapper",nil,nil,"#show Regrowth\n/run local a={\"Moonkin Hatchling\",\"Stardust\",\"Singing Sunflower\",\"Sun Darter Hatchling\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			elseif playerspec == 2 then
				EditMacro("WSxSwapper",nil,nil,"#show Regrowth\n/run local a={\"Cinder Kitten\",\"Lashtail Hatchling\",\"Singing Sunflower\",\"Sen'Jin Fetish\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			elseif playerspec == 3 then
				EditMacro("WSxSwapper",nil,nil,"#show Regrowth\n/run local a={\"Moonkin Hatchling\",\"Hyjal Cub\",\"Ashmaw Cub\",\"Singing Sunflower\",\"Sun Darter Hatchling\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			else
				EditMacro("WSxSwapper",nil,nil,"#show Regrowth\n/run local a={\"Blossoming Ancient\",\"Stardust\",\"Broot\",\"Singing Sunflower\",\"Nightmare Treant\",\"Sun Darter Hatchling\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
			end
		end

		if class == "DEMONHUNTER" then
			EditMacro("WSxSwapper",nil,nil,"#show Chaos Nova\n/run local a={\"Murkidan\",\"Emmigosa\",\"Abyssius\",\"Micronax\",\"Wyrmy Tunkins\",\"Fragment of Desire\",\"Eye of the Legion\",\"Mischief\"}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")
		end

		-- Change Spec for all classes, specs and titles button "Y" 

		-- SHAMAN Orc "specs" "y"
		if class == "SHAMAN" then
			if race == "Orc" then
				if playerspec == 1 then
					EditMacro("WSpecs!",nil,nil,"/settitle [spec:1]Defender\n/equipset [spec:1]Noon!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
				elseif playerspec == 2 then
					EditMacro("WSpecs!",nil,nil,"/settitle [spec:2]Storm's End\n/equipset [spec:2]DoubleGate\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
				else
					EditMacro("WSpecs!",nil,nil,"/settitle [spec:3]Mistwalker\n/equipset [spec:3]Menkify!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
				end
			end
		end

		-- SHAMAN Troll "specs" "y"
		if class == "SHAMAN" then
			if race == "Troll" then
				if playerspec == 1 then
					EditMacro("WSpecs!",nil,nil,"/settitle [spec:1]Gorgeous\n/equipset [spec:1]Noon!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
				elseif playerspec == 2 then
					EditMacro("WSpecs!",nil,nil,"/settitle [spec:2]Storm's End\n/equipset [spec:2]DoubleGate\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
				else
					EditMacro("WSpecs!",nil,nil,"/settitle [spec:3]Gorgeous\n/equipset [spec:3]Menkify!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
				end
			end
		end
		
		-- MAGE "specs" "y"
		if class == "MAGE" then
			if playerspec == 1 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:1]Headmistress\n/equipset [spec:1]Noon!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			elseif playerspec == 2 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:2]Flame Keeper\n/equipset [spec:2]DoubleGate\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			else
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:3]Merrymaker\n/equipset [spec:3]Menkify!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			end
		end

		-- WARLOCK "specs" "y"
			if class == "WARLOCK" then
				if playerspec == 1 then
					EditMacro("WSpecs!",nil,nil,"/settitle [spec:1]Of The Black Harvest\n/equipset [spec:1]Noon!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
				elseif playerspec == 2 then
					EditMacro("WSpecs!",nil,nil,"/settitle [spec:2]Matron\n/equipset [spec:2]DoubleGate\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
				else
					EditMacro("WSpecs!",nil,nil,"/settitle [spec:3]Netherlord\n/equipset [spec:3]Menkify!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
				end
			end

		-- MONK "specs" "y"
		if class == "MONK" then
			if playerspec == 1 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:1]Brewmaster\n/equipset [spec:1]Noon!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			elseif playerspec == 2 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:2]the Tranquil Master\n/equipset [spec:2]DoubleGate\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			else
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:3]Shado\n/equipset [spec:3]Menkify!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			end
		end

		-- PALADIN "specs" "y"
		if class == "PALADIN" then
			if playerspec == 1 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:1]The Lightbringer\n/equipset [spec:1]Noon!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			elseif playerspec == 2 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:2]Highlord\n/equipset [spec:2]DoubleGate\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			else
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:3]Lady of War\n/equipset [spec:3]Menkify!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			end
		end

		-- HUNTER "specs" "y"								
		if class == "HUNTER" then
			if playerspec == 1 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:1]Zookeeper\n/equipset [spec:1]Noon!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			elseif playerspec == 2 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:2]The Patient\n/equipset [spec:2]DoubleGate\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			else
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:3]Predator\n/equipset [spec:3]Menkify!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			end
		end

		-- ROGUE "specs" "y"
		if class == "ROGUE" then
			if playerspec == 1 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:1]The Kingslayer\n/equipset [spec:1]Noon!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			elseif playerspec == 2 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:2]Captain\n/equipset [spec:2]DoubleGate\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			else
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:3]Shadowblade\n/equipset [spec:3]Menkify!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			end
		end

		-- PRIEST "specs" "y"
		if class == "PRIEST" then
			if playerspec == 1 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:1]Empire's Twilight\n/equipset [spec:1]Noon!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			elseif playerspec == 2 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:2]Gorgeous\n/equipset [spec:2]DoubleGate\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			else
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:3]The Insane\n/equipset [spec:3]Menkify!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			end
		end

		-- DEATH KNIGHT "specs" "y"		
		if class == "DEATHKNIGHT" then
			if playerspec == 1 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:1]Bane of the Fallen King\n/equipset [spec:1]Noon!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			elseif playerspec == 2 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:2]Champion of the Frozen Wastes\n/equipset [spec:2]DoubleGate\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			else
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:3]Deathlord\n/equipset [spec:3]Menkify!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			end
		end

		-- WARRIOR "specs" "y"
		if class == "WARRIOR" then
			if playerspec == 1 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:1]The Savage Hero\n/equipset [spec:1]Noon!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			elseif playerspec == 2 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:2]Battlelord\n/equipset [spec:2]DoubleGate\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			else
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:3]The Proven Defender\n/equipset [spec:3]Menkify!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			end
		end

		-- DRUID "specs" "y"				
		if class == "DRUID" then
			if playerspec == 1 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:1]Starcaller\n/equipset [spec:1]Noon!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 elseif(IsModifierKeyDown())then x=4 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			elseif playerspec == 2 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:2]the Crazy Cat Lady\n/equipset [spec:2]DoubleGate\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 elseif(IsModifierKeyDown())then x=4 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			elseif playerspec == 3 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:3]Guardian of Cenarius\n/equipset [spec:3]Menkify!\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 elseif(IsModifierKeyDown())then x=4 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			else
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:4]the Dreamer\n/equipset [spec:4]Supermenk\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 elseif(IsModifierKeyDown())then x=4 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			end
		end

		-- DEMON HUNTER "specs" "y"		
		if class == "DEMONHUNTER" then
			if playerspec == 1 then
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:1]Demonslayer\n/equipset [spec:1]Noon!\n/run x=1 if(IsShiftKeyDown())then x=2 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			else
				EditMacro("WSpecs!",nil,nil,"/settitle [spec:2]Vengeance Incarnate\n/equipset [spec:2]DoubleGate\n/run x=1 if(IsShiftKeyDown())then x=2 end if(x~=GetSpecialization())then SetSpecialization(x) end")
			end
		end
	
		-- Racist Stuns Button, Alt+V "Alt+v" - shows tooltip of racial and does mount favorite mount on use.
  		if race == "BloodElf" then
  			EditMacro("Wx6RacistAlt+V",nil,nil,"#showtooltip Arcane Torrent\n/run C_MountJournal.SummonByID(0)\n/use [noexists,nocombat] Prismatic Bauble\n/use [nocombat,noexists] Sparklepony XL")
  		elseif race == "Troll" then
  			EditMacro("Wx6RacistAlt+V",nil,nil,"#showtooltip Berserking\n/run C_MountJournal.SummonByID(0)\n/use [noexists,nocombat] Prismatic Bauble\n/use [nocombat,noexists] Sparklepony XL")
  		elseif race == "Orc" then
  			EditMacro("Wx6RacistAlt+V",nil,nil,"#showtooltip Blood Fury\n/run C_MountJournal.SummonByID(0)\n/use [noexists,nocombat] Prismatic Bauble\n/use [nocombat,noexists] Sparklepony XL")
		elseif race == "Scourge" then
  			EditMacro("Wx6RacistAlt+V",nil,nil,"#showtooltip Will of the Forsaken\n/run C_MountJournal.SummonByID(0)\n/use [noexists,nocombat] Prismatic Bauble; [combat] Will of the Forsaken;\n/use [nocombat,noexists] Sparklepony XL;")
  		elseif race == "Tauren" then
  			EditMacro("Wx6RacistAlt+V",nil,nil,"#showtooltip War Stomp\n/run C_MountJournal.SummonByID(0)\n/use [noexists,nocombat] Prismatic Bauble; [combat] War Stomp;\n/use [nocombat,noexists] Sparklepony XL;")
  		elseif race == "Goblin" then
  			EditMacro("Wx6RacistAlt+V",nil,nil,"#showtooltip Rocket Jump\n/run C_MountJournal.SummonByID(0)\n/use [noexists,nocombat] Prismatic Bauble; [combat] Rocket Jump;\n/use [nocombat,noexists] Sparklepony XL;")
		end
		
		-- Class Artifact Button, Completed
		if class == "SHAMAN" then
			EditMacro("WArtifactCDs",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [help,dead]Cremating Torch;[spec:1] Stormkeeper; [spec:2] Doom Winds; [spec:3,@cursor] Gift of the Queen;")
		elseif class == "MAGE" then
			EditMacro("WArtifactCDs",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [help,dead]Cremating Torch;[spec:1] Mark of Aluneth; [spec:2] Phoenix's Flames; [spec:3] Ebonbolt;\n/equip [spec:1] Aluneth")
		elseif class == "WARLOCK" then
			EditMacro("WArtifactCDs",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [help,dead]Cremating Torch;[spec:1] Reap Souls; [spec:2] Thal'kiel's Consumption; [spec:3] Dimensional Rift;")
		elseif class == "MONK" then
			EditMacro("WArtifactCDs",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [help,dead]Cremating Torch;[spec:1,@cursor] Exploding Keg; [@mouseover,help,nodead,spec:2][spec:2] Sheilun's Gift; [spec:3] Strike of the Windlord;")
		elseif class == "PALADIN" then
			EditMacro("WArtifactCDs",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [help,dead]Cremating Torch;[spec:1,@mouseover,help,nodead][spec:1] Tyr's Deliverance; [spec:2] Eye of Tyr; [spec:3] Wake of Ashes;")
		elseif class == "HUNTER" then
			EditMacro("WArtifactCDs",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [help,dead]Cremating Torch;[spec:1] Titan's Thunder; [spec:2] Windburst; [spec:3] Fury of the Eagle;\n/use [nocombat,noexists]Ruthers' Harness")
		elseif class == "ROGUE" then
			EditMacro("WArtifactCDs",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [help,dead]Cremating Torch;[spec:1] Kingsbane; [spec:2] Curse of the Dreadblades; [spec:3] Goremaw's Bite;")
		elseif class == "PRIEST" then
			EditMacro("WArtifactCDs",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [help,dead]Cremating Torch;[spec:1] Light's Wrath(Artifact); [spec:2,@mouseover,help,nodead][spec:2] Light of T'uure; [spec:3] !Void Torrent;")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WArtifactCDs",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [help,dead]Cremating Torch;[spec:1] Consumption; [spec:2] Sindragosa's Fury; [spec:3] Apocalypse(Artifact);")
		elseif class == "WARRIOR" then
			EditMacro("WArtifactCDs",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [help,dead]Cremating Torch;[spec:1] Warbreaker; [spec:2] Odyn's Fury; [spec:3] Neltharion's Fury;")
		elseif class == "DRUID" then
			EditMacro("WArtifactCDs",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [help,dead]Cremating Torch;[spec:1] New Moon; [spec:2] Ashamane's Frenzy; [spec:3] Rage of the Sleeper; [spec:4] Essence of G'Hanir;")
		elseif class == "DEMONHUNTER" then
			EditMacro("WArtifactCDs",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [help,dead]Cremating Torch;[spec:1] Fury of the Illidari; [spec:2] Soul Carver;")
		end

		-- Alt+§, Potion Showtooltip and use throughput potion.
		if class == "SHAMAN" then
			EditMacro("Wx3ShowPot",nil,nil,"#showtooltip Potion of Prolonged Power\n/use [nogroup] Kafa Press\n/use Potion of Prolonged Power")
		elseif class == "MAGE" then
			EditMacro("Wx3ShowPot",nil,nil,"#showtooltip Potion of Prolonged Power\n/use [nogroup] Kafa Press\n/use Potion of Prolonged Power")
		elseif class == "WARLOCK" then
			EditMacro("Wx3ShowPot",nil,nil,"#showtooltip Potion of Prolonged Power\n/use [nogroup] Kafa Press\n/use Potion of Prolonged Power")
		elseif class == "MONK" then
			EditMacro("Wx3ShowPot",nil,nil,"#showtooltip Potion of Prolonged Power\n/use [nogroup] Kafa Press\n/use Potion of Prolonged Power")
		elseif class == "PALADIN" then
			EditMacro("Wx3ShowPot",nil,nil,"#showtooltip Potion of Prolonged Power\n/use [nogroup] Kafa Press\n/use Potion of Prolonged Power")
		elseif class == "HUNTER" then
			EditMacro("Wx3ShowPot",nil,nil,"#showtooltip Potion of Prolonged Power\n/use Brawler's Potion of Prolonged Power\n/use [nogroup] Kafa Press\n/use Potion of Prolonged Power")
		elseif class == "ROGUE" then
			EditMacro("Wx3ShowPot",nil,nil,"#showtooltip Potion of Prolonged Power\n/use [nogroup] Kafa Press\n/use Potion of Prolonged Power")
		elseif class == "PRIEST" then
			EditMacro("Wx3ShowPot",nil,nil,"#showtooltip Potion of Prolonged Power\n/use [nogroup] Kafa Press\n/use Potion of Prolonged Power")
		elseif class == "DEATHKNIGHT" then
			EditMacro("Wx3ShowPot",nil,nil,"#showtooltip Potion of Prolonged Power\n/use [nogroup] Kafa Press\n/use Potion of Prolonged Power")
		elseif class == "WARRIOR" then
			EditMacro("Wx3ShowPot",nil,nil,"#showtooltip Potion of Prolonged Power\n/use [nogroup] Kafa Press\n/use Potion of Prolonged Power")
		elseif class == "DRUID" then
			EditMacro("Wx3ShowPot",nil,nil,"#showtooltip Potion of Prolonged Power\n/use [nogroup] Kafa Press\n/use Potion of Prolonged Power")
		elseif class == "DEMONHUNTER" then
			EditMacro("Wx3ShowPot",nil,nil,"#showtooltip Potion of Prolonged Power\n/use [nogroup] Kafa Press\n/use Potion of Prolonged Power")
		end
		
		-- Ctrl+Q, "ctrl+q" Skillbomb for all classes, Completed
		if class == "SHAMAN" then
			if race == "Orc" then
				EditMacro("WSkillbomb",nil,nil,"/use [spec:1]Fire Elemental;[spec:2]Feral Spirit\n/use Ascendance\n/use Elemental Mastery\n/use Blood fury\n/use Rukhmar's Sacred Memory\n/use 13\n/use Flippable Table\n/use Adopted Puppy Crate\n/use Xan'tish's Flute\n/use Big Red Raygun") 
			elseif race == "Troll" then
				EditMacro("WSkillbomb",nil,nil,"/use [spec:1]Fire Elemental;[spec:2]Feral Spirit\n/use Ascendance\n/use Elemental Mastery\n/use Berserking\n/use Rukhmar's Sacred Memory\n/use 13\n/use Flippable Table\n/use Adopted Puppy Crate\n/use Xan'tish's Flute\n/use Big Red Raygun")
			end
		end

		if class == "MAGE" then
			EditMacro("WSkillbomb",nil,nil,"#showtooltip\n/use [spec:3]Icy Veins;[spec:1]Arcane Power;[spec:2]Combustion;\n/use Berserking\n/use Rukhmar's Sacred Memory\n/use 13\n/use Mirror Image\n/use Hearthstone Board\n/use Big Red Raygun")
		elseif class == "WARLOCK" then
			EditMacro("WSkillbomb",nil,nil,"#showtooltip\n/use [talent:4/3]Soul Harvest\n/use 13\n/use Jewel of Hellfire\n/use Combat Ally\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/cancelaura Ring of Broken Promises")
		elseif class == "MONK" then
			EditMacro("WSkillbomb",nil,nil,"#showtooltip [spec:3]Storm, Earth, and Fire;[spec:2]Revival;[spec:1]Fortifying Brew;\n/use Invoke Xuen, the White Tiger\n/use Storm, Earth, and Fire\n/use Rukhmar's Sacred Memory\n/use 13\n/use Celestial Defender's Medallion")
		elseif class == "PALADIN" then
			EditMacro("WSkillbomb",nil,nil,"#showtooltip\n/use Avenging Wrath\n/use 13\n/use Sha'tari Defender's Medallion\n/use Gnawed Thumb Ring")
		end

		if class == "HUNTER" then
			if race == "Orc" then
				EditMacro("WSkillbomb",nil,nil,"showtooltip\n/use [spec:1]Bestial Wrath;[spec:2]Trueshot;[spec:3]Aspect of the Eagle;\n/use Bloodmane Charm\n/use Blood Fury\n/use 13\n/use Adopted Puppy Crate\n/use Xan'tish's Flute\n/use Ruthers' Harness\n/use Big Red Raygun\n/use Aspect of the Wild")
			elseif race == "Troll" then
				EditMacro("WSkillbomb",nil,nil,"#showtooltip\n/use [spec:1]Bestial Wrath;[spec:2]Trueshot;[spec:3]Aspect of the Eagle;\n/use Bloodmane Charm\n/use Berserking\n/use 13\n/use Adopted Puppy Crate\n/use Xan'tish's Flute\n/use Ruthers' Harness\n/use Big Red Raygun\n/use Aspect of the Wild") 
			end
		end

		if class == "ROGUE" then
			EditMacro("WSkillbomb",nil,nil,"/use [spec:1]Vendetta;[spec:2]Adrenaline Rush;Shadow Blades;\n/stopmacro [stealth]\n/use Will of Northrend\n/use Berserking\n/use Rukhmar's Sacred Memory\n/use 13\n/use Adopted Puppy Crate\n/use Xan'tish's Flute\n/use Big Red Raygun")  
		elseif class == "PRIEST" then
			EditMacro("WSkillbomb",nil,nil,"#showtooltip\n/use [nospec:2]Shadowfiend\n/use Power Infusion\n/use Berserking\n/use Rukhmar's Sacred Memory\n/use 13\n/use Adopted Puppy Crate\n/use Xan'tish's Flute\n/use Big Red Raygun")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSkillbomb",nil,nil,"#showtooltip\n/use [spec:1]Dancing Rune Weapon;[spec:2]Pillar of Frost;[spec:3] Summon Gargoyle\n/use 13\n/use Combat Ally\n/use Angry Beehive\n/use Pendant of the Scarab Storm\n/use Adopted Puppy Crate\n/use Big Red Raygun")
		elseif class == "WARRIOR" then
			EditMacro("WSkillbomb",nil,nil,"#showtooltip Battle Cry\n/use Bloodbath\n/use Dragon Roar\n/use Avatar\n/use Will of Northrend\n/use 13\n/use [nospec:2,talent:7/3,@player]Ravager;Bladestorm\n/use [nocombat]Flippable Table\n/use Demoralizing Shout;")
		elseif class == "DRUID" then
			EditMacro("WSkillbomb",nil,nil,"#show\n/use [spec:1]Celestial Alignment;[spec:4,talent:5/2]!Incarnation: Tree of Life;[spec:3,talent:5/2]Incarnation: Guardian of Ursoc;Berserk;\n/use Berserking\n/use Rukhmar's Sacred Memory\n/use 13\n/use [@cursor]Force of Nature\n/use Big Red Raygun")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSkillbomb",nil,nil,"/use [@player] Metamorphosis\n/castsequence [harm,nodead] Nemesis, Chaos Blades\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun")
		end
		
		-- Resurrect for all classes, completed.
		if class == "SHAMAN" then
			EditMacro("WRessMix",nil,nil,"/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[harm,dead]Horde Flag of Victory;Ancestral Spirit;\n/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Ancestral Vision\n/use [mod:ctrl]Brazier of Awakening")
		elseif class == "MAGE" then
			EditMacro("WRessMix",nil,nil,"/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[harm,dead]Horde Flag of Victory;Ultimate Gnomish Army Knife;\n/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Brazier of Awakening")
		elseif class == "WARLOCK" then
			EditMacro("WRessMix",nil,nil,"/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[harm,dead]Horde Flag of Victory;Ultimate Gnomish Army Knife;\n/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Brazier of Awakening")
		elseif class == "MONK" then
			EditMacro("WRessMix",nil,nil,"/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[harm,dead]Horde Flag of Victory;Resuscitate;\n/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Reawaken\n/use [mod:ctrl]Brazier of Awakening")
		elseif class == "PALADIN" then
			EditMacro("WRessMix",nil,nil,"/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[harm,dead]Horde Flag of Victory;Redemption;\n/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Absolution\n/use [mod:ctrl]Brazier of Awakening")
		elseif class == "HUNTER" then
			EditMacro("WRessMix",nil,nil,"/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[harm,dead]Horde Flag of Victory;Ultimate Gnomish Army Knife;\n/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Brazier of Awakening")
		elseif class == "ROGUE" then
			EditMacro("WRessMix",nil,nil,"/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[harm,dead]Horde Flag of Victory;Ultimate Gnomish Army Knife;\n/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Brazier of Awakening")
		elseif class == "PRIEST" then
			EditMacro("WRessMix",nil,nil,"/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[harm,dead]Horde Flag of Victory;Resurrection;\n/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Mass Resurrection\n/use [mod:ctrl]Brazier of Awakening")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WRessMix",nil,nil,"/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[harm,dead]Horde Flag of Victory;Ultimate Gnomish Army Knife;\n/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Brazier of Awakening")
		elseif class == "WARRIOR" then
			EditMacro("WRessMix",nil,nil,"/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[harm,dead]Horde Flag of Victory;Ultimate Gnomish Army Knife;\n/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Brazier of Awakening")
		elseif class == "DRUID" then
			EditMacro("WRessMix",nil,nil,"/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[harm,dead]Horde Flag of Victory;Revive;\n/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/cancelaura Flap\n/use [mod:ctrl]Revitalize\n/use [mod:ctrl]Brazier of Awakening")
		elseif class == "DEMONHUNTER" then
			EditMacro("WRessMix",nil,nil,"/use [mod:alt]Jeeves;[mod:ctrl]15;[mod:shift]6;[harm,dead]Horde Flag of Victory;Ultimate Gnomish Army Knife;\n/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/cancelaura Glide\n/use [mod:ctrl]Brazier of Awakening")
		end
		
		-- T15 Talents, Ctrl+J, Stealthman 54 invis.
		if class == "SHAMAN" then
			EditMacro("WSxT15",nil,nil,"#showtooltip [spec:3,talent:1/2]Unleash Life;[spec:1,talent:1/3]Totem Mastery;[spec:2,talent:1/1]Windsong;[spec:1/3]Flame Shock;Lightning Bolt;\n/use [group:party,nocombat,indoors] Draenic Invisibility Potion;[nocombat,outdoors]Stealthman 54;")
		elseif class == "MAGE" then
			EditMacro("WSxT15",nil,nil,"#showtooltip [spec:3,talent:1/1]Ray of Frost;[spec:1,talent:1/2]Presence of Mind;[spec:1,talent:1/1]Arcane Familiar\n/use [nocombat,outdoors]Stealthman 54;Brazier of Dancing Flames;")
		elseif class == "WARLOCK" then
			EditMacro("WSxT15",nil,nil,"#showtooltip [spec:1,talent:1/1]Haunt;[spec:1]Corruption;[spec:3,talent:1/3]Shadowburn;[spec:3]Immolate;[spec:2,talent:1/2]Shadowflame;Shadow bolt;\n/use [group:party,nocombat,indoors] Draenic Invisibility Potion;[nocombat,outdoors]Stealthman 54;")
		elseif class == "MONK" then
			EditMacro("WSxT15",nil,nil,"#showtooltip [spec:2,talent:1/2]Zen Pulse;[talent:1/3]Chi Wave;[talent:1/1]Chi Burst;\n/use [group:party,nocombat,indoors] Draenic Invisibility Potion;[nocombat,outdoors]Stealthman 54;")
		elseif class == "PALADIN" then
			EditMacro("WSxT15",nil,nil,"#showtooltip [spec:1,talent:1/1]Bestow Faith;[spec:1,talent:1/2]Light's Hammer;[spec:3,talent:1/2]Execution Sentence;[spec:3,talent:1/3][spec:1/2]Consecration;Judgment\n/use [group:party,nocombat,indoors] Draenic Invisibility Potion;[outdoors]Stealthman 54")
		elseif class == "HUNTER" then
			EditMacro("WSxT15",nil,nil,"#showtooltip [spec:3,talent:1/2] Throwing Axes;[spec:1]Aspect of the Wild;[spec:2]Bursting Shot;\n/use [group:party,nocombat,indoors] Draenic Invisibility Potion;[nocombat,outdoors]Stealthman 54;")
		elseif class == "ROGUE" then
			EditMacro("WSxT15",nil,nil,"#showtooltip [spec:2,talent:1/1]Ghostly Strike;;[spec:1,talent:1/3]Hemorrhage;[spec:3,talent:1/3]Gloomblade;The Golden Banana;")
		elseif class == "PRIEST" then
			EditMacro("WSxT15",nil,nil,"#showtooltip [spec:3,talent:1/3]Shadow Word: Void;[spec:1,talent:1/3]Schism;\n/use [group:party,nocombat,indoors] Draenic Invisibility Potion;[nocombat,outdoors]Stealthman 54;")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxT15",nil,nil,"#showtooltip [spec:1,talent:1/3]Blooddrinker\n/use [group:party,nocombat,indoors] Draenic Invisibility Potion;[nocombat,outdoors]Stealthman 54;")
		elseif class == "WARRIOR" then
			EditMacro("WSxT15",nil,nil,"#showtooltip [spec:1,talent:1/2]Overpower;[spec:3,talent:1/1]Shockwave;[spec:3,talent:1/2]Storm Bolt;\n/use [group:party,nocombat,indoors] Draenic Invisibility Potion;[nocombat,outdoors]Stealthman 54;")
		elseif class == "DRUID" then
			EditMacro("WSxT15",nil,nil,"#showtooltip [spec:1,talent:1/1]Force of Nature;[spec:1,talent:1/2]Warrior of Elune;[spec:4,talent:1/2]Cenarion Ward;[spec:3,noform:1,talent:1/2]Bear Form;[spec:3,talent:1/2]Bristling Fur;Treant Form;") 
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxT15",nil,nil,"#showtooltip [spec:1,notalent:1/2]Fel Rush;[spec:1,talent:1/2]Felblade;\n/use [group:party,nocombat,indoors] Draenic Invisibility Potion;[nocombat,outdoors]Stealthman 54;")
		end
		
		-- T30 Talents, "Ctrl+E", Illusions
		if class == "SHAMAN" then
			EditMacro("WSxT30",nil,nil,"#show [talent:2/3]Wind Rush Totem;[spec:1/3,talent:2/1]Gust of Wind;[spec:1,talent:2/2]Ancestral Guidance;[spec:2,talent:2/2]Feral Lunge;[spec:2,talent:2/1]Rainfall\n/use [spec:3]Spiritwalker's Grace;[spec:2,help,nodead]Bloodlust\n/use Orb of the Sin'dorei")
		elseif class == "MAGE" then
			EditMacro("WSxT30",nil,nil,"#showtooltip\n/use [spec:2,talent:2/1] Blast Wave;\n/use [spec:3,talent:2/2]Ice Floes;\n/use Blazing Wings\n/use Orb of the Sin'dorei\n/use [nocombat,noexists]Cooking School Bell")
		elseif class == "WARLOCK" then
			EditMacro("WSxT30",nil,nil,"#showtooltip [spec:2,talent:2/3]Implosion;[spec:1/3,talent:2/3]Mana Tap;[spec:3,talent:2/2]Cataclysm;Life tap;\n/use [talent:6/2]Grimoire: Felhunter;\n/use [nocombat] Orb of Deception\n/use [nocombat]Cooking School Bell")
		elseif class == "MONK" then
			EditMacro("WSxT30",nil,nil,"#showtooltip [talent:2/2]Tiger's Lust;Roll;\n/use [nocombat,noexists] Trans-Dimensional Bird Whistle\n/use [nocombat,noexists] Cooking School Bell\n/use Orb of Deception")
		elseif class == "PALADIN" then
			EditMacro("WSxT30",nil,nil,"#showtooltip [spec:1,talent:2/3]Rule of Law;[spec:2,talent:2/2]Bastion of Light;Lay on Hands;\n/use Lay on Hands;\n/use Vindicator's Armor Polish Kit\n/use Orb of Deception\n/use [nocombat,noexists]Cooking School Bell")
		elseif class == "HUNTER" then
			EditMacro("WSxT30",nil,nil,"#showtooltip [spec:1,talent:2/3]Chimaera Shot;[spec:3,talent:2/1]A Murder of Crows;[spec:3,talent:2/3]Snake Hunter;[spec:2,talent:2/2]Black Arrow;Fetch;\n/use [pet,@pet]Misdirection;\n/use Cooking School Bell\n/use Orb of the Sin'dorei")
		elseif class == "ROGUE" then
			EditMacro("WSxT30",nil,nil,"#showtooltip [spec:2,talent:2/1]Grappling Hook;[spec:1/3]Shadowstep;Sprint;\n/use [@focus,help,nodead][@mouseover,help,nodead][help,nodead][@party1,exists]Tricks of the Trade;\n/train\n/use [nostealth] Orb of the Sin'dorei\n/use Seafarer's Slidewhistle")
		elseif class == "PRIEST" then
			EditMacro("WSxT30",nil,nil,"#showtooltip [spec:1/2,talent:2/1]Angelic Feather;[spec:2,talent:2/2]Body and Mind;[spec:2,talent:2/3]Desperate Prayer;Power Word: Shield;\n/use Orb of Deception")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxT30",nil,nil,"#showtooltip [spec:1,talent:2/2]Soulgorge;[spec:2,talent:2/3]Horn of Winter;[spec:3,talent:2/3]Blighted Rune Weapon;[spec:3,talent:2/1]Epidemic;\n/use Orb of Deception\n/use [nocombat,noexists]Cooking School Bell")
		elseif class == "WARRIOR" then
			EditMacro("WSxT30",nil,nil,"#showtooltip [spec:1/2,talent:2/1]Shockwave;[spec:1/2,talent:2/2]Storm Bolt;\n/use Outrider's Bridle Chain\n/use Orb of the Sin'dorei\n/use [nocombat,noexists]Cooking School Bell")
		elseif class == "DRUID" then
			EditMacro("WSxT30",nil,nil,"#show [talent:2/3]Wild Charge;[talent:2/2]Displacer Beast;Renewal\n/use Orb of the Sin'dorei\n/use [nocombat]Mylune's Call\n/use [nocombat,noexists]Cooking School Bell\n/use [spec:2,nocombat,nostealth]Bloodmane Charm;[nocombat,nostealth] Will of Northrend")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxT30",nil,nil,"/use Orb of Deception\n/use [nocombat,noexists]Cooking School Bell")
		end

		-- T45 Talents, "Shift+E".
		if class == "SHAMAN" then
			EditMacro("WSxT45",nil,nil,"#showtooltip [spec:3]Healing Stream Totem;[talent:3/1]Lightning Surge Totem;[talent:3/2]Earthgrab Totem;[talent:3/3]Voodoo Totem;\n/cast Healing Stream Totem\n/use Totem of Spirits;\n/use [noexists,nocombat]Arena Master's War Horn;")
		elseif class == "MAGE" then
			EditMacro("WSxT45",nil,nil,"#showtooltip [mod:shift]Frost Nova;[talent:3/2]Rune of Power;[talent:3/1]Mirror Image;Polymorph;\n/use Frost Nova")
		elseif class == "WARLOCK" then
			EditMacro("WSxT45",nil,nil,"#showtooltip [mod:shift]Arcane Torrent;[talent:3/1]Demonic Circle;[spec:1,talent:3/3]Howl of Terror;[talent:3/3]Shadowfury;[talent:3/2]Mortal Coil;Fear;\n/use Arcane Torrent")
		elseif class == "MONK" then
			EditMacro("WSxT45",nil,nil,"#showtooltip [mod:shift]Arcane Torrent;[spec:1,talent:3/2]Black Ox Brew;[spec:3,talent:3/1]Energizing Elixir;Paralysis;\n/use Arcane Torrent")
		elseif class == "PALADIN" then
			EditMacro("WSxT45",nil,nil,"#showtooltip [mod:shift]Arcane Torrent;[talent:3/3]Blinding Light;[talent:3/2]Repentance;Hammer of Justice;\n/use Arcane Torrent")
		elseif class == "HUNTER" then
			EditMacro("WSxT45",nil,nil,"#showtooltip [mod:shift,nospec:3]Misdirection;Stopping Power\n/use [help,nodead][@focus,help,nodead][pet,@pet,nospec:3]Misdirection;[spec:3]Stopping Power;\n/use [nocombat,noexists] Angler's Fishing Spear\n/use [nocombat,noexists]Goblin Fishing Bomb")
		elseif class == "ROGUE" then
			EditMacro("WSxT45",nil,nil,"#showtooltip\n/use [spec:3,stance:0,combat]Shadow Dance;[nospec:3,stance:0,combat]Vanish;[stance:0,nocombat]Stealth;[mod:alt,@focus,harm,nodead,nostance:0][nostance:0][]Cheap Shot;\n/use [nostealth] Hourglass of Eternity")
		end
		
		-- Prist T45 "Shift+E" CC Tier
		if class == "PRIEST" then
			if race == "Troll" then
			EditMacro("WSxT45",nil,nil,"#showtooltip [nospec:2,mod:shift]Psychic Scream;[spec:1/2,talent:3/1]Shining Force;Mind Control;\n/use [nospec:2]Psychic Scream;")
			elseif race == "BloodElf" then
			EditMacro("WSxT45",nil,nil,"#showtooltip [nospec:2,mod:shift]Psychic Scream;[spec:1/2,talent:3/1]Shining Force;Mind Control;\n/use Arcane Torrent")
			end
		end

		if class == "DEATHKNIGHT" then
			EditMacro("WSxT45",nil,nil,"#showtooltip [mod:shift]Arcane Torrent;[spec:1,talent:3/2]Blood Tap;Raise Ally;\n/use Arcane Torrent")
		elseif class == "WARRIOR" then
			EditMacro("WSxT45",nil,nil,"#showtooltip [mod:shift,nospec:3]Intimidating Shout;[talent:3/3]Avatar;[talent:3/2]Rend;[spec:3]Demoralizing Shout;Execute;\n/use [spec:3]Demoralizing Shout;[@mouseover,exists,nodead][nospec:3]Intimidating Shout;\n/startattack\n/targetenemy [nospec:3]")
		elseif class == "DRUID" then
			EditMacro("WSxT45",nil,nil,"#showtooltip\n/use [spec:2,form:2,talent:5/2]Rake;[nospec:4,@mouseover,help,nodead,talent:3/3][spec:4,@mouseover,help,nodead][nospec:4,talent:3/3][spec:4]Healing Touch;Dreamwalk;\n/use [spec:2,talent:5/2]!Prowl")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxT45",nil,nil,"#showtooltip [mod:shift]Arcane Torrent;[spec:2,talent:3/1]Felblade;[spec:2,talent:3/3]Fel Eruption;[spec:2]Demon Spikes;Throw Glaive;\n/use Arcane Torrent")
		end
		
		-- T60 Talents, "Alt+C", dismiss pet
		if class == "SHAMAN" then
			EditMacro("WSxT60",nil,nil,"#showtooltip [spec:2,talent:4/3]Frostbrand;[spec:2,talent:4/1]Lightning Shield;[spec:3,talent:4/2]Ancestral Guidance;[spec:1,talent:4/3]Elemental Mastery;Vol'Jin's Serpent Totem;\n/use Vol'Jin's Serpent Totem;\n/click TotemFrameTotem1 RightButton\n/cry")
		elseif class == "MAGE" then
			EditMacro("WSxT60",nil,nil,"#showtooltip [spec:3,talent:4/1]Ice Nova;[spec:1,talent:4/1]Supernova;[spec:3,talent:4/2]Frozen Touch;[spec:1,talent:4/2]Charged up;[spec:2,talent:4/2]Flame On;\n/use Worn Doll\n/script PetDismiss();\n/cry")
		elseif class == "WARLOCK" then
			EditMacro("WSxT60",nil,nil,"#showtooltip [nocombat,noexists]Spire of Spite;[spec:1,talent:4/1]Phantom Singularity;[talent:4/3]Soul Harvest; Demonic Gateway;\n/use Spire of Spite\n/script PetDismiss();\n/cry")
		elseif class == "MONK" then
			EditMacro("WSxT60",nil,nil,"#showtooltip [spec:1,talent:4/2]Summon Black Ox Statue;[spec:2,talent:4/2]Song of Chi-Ji;[talent:4/3]Leg Sweep;[talent:4/1]Ring of Peace;\n/click TotemFrameTotem1 RightButton\n/script PetDismiss();\n/cry")
		elseif class == "PALADIN" then 
			EditMacro("WSxT60",nil,nil,"#showtooltip [mod] Sylvanas' Music Box;Blessing of Protection\n/use Sylvanas' Music Box\n/script PetDismiss();\n/cry")
		elseif class == "HUNTER" then
			EditMacro("WSxT60",nil,nil,"#showtooltip [spec:2,talent:4/1]Explosive Shot;[spec:2,talent:4/2]Sentinel;Dismiss Pet;\n/use Dismiss Pet\n/click TotemFrameTotem1 RightButton\n/use Crashin' Thrashin' Robot")
		elseif class == "ROGUE" then
			EditMacro("WSxT60",nil,nil,"#showtooltip\n/use [spec:1,talent:4/1,stealth]Leeching Poison\n/castsequence reset=15 Pack of Battle Potions, Smoky Boots \n/script PetDismiss();\n/cry")
		elseif class == "PRIEST" then
			EditMacro("WSxT60",nil,nil,"#showtooltip\n/use [spec:2,talent:4/3]Symbol of Hope;[spec:1,talent:4/1]Power Word: Solace;[nocombat,noexists]Sturdy Love Fool;\n/script PetDismiss();\n/cry")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxT60",nil,nil,"#showtooltip [spec:1,talent:4/3]Tombstone;[spec:1,talent:4/1]Mark of Blood;[spec:2,talent:4/2]Blinding Sleet;[spec:3,talent:4/1,pet:Abomination]Smash;[spec:1][talent:4/2]Asphyxiate;\n/use Sylvanas' Music Box\n/script PetDismiss();\n/cry")
		elseif class == "WARRIOR" then
			EditMacro("WSxT60",nil,nil,"#showtooltip [mod] Sylvanas' Music Box;[spec:1,talent:4/3]Defensive Stance\n/use Sylvanas' Music Box\n/script PetDismiss();\n/cry")
		elseif class == "DRUID" then
			EditMacro("WSxT60",nil,nil,"#showtooltip [talent:4/3]Typhoon;[talent:4/2]Mass Entanglement;[talent:4/1]Mighty Bash;\n/script PetDismiss();\n/cry")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxT60",nil,nil,"#showtooltip [spec:1,talent:4/1]Netherwalk;[spec:2,talent:4/2]Fracture;Spire of Spite;\n/use [nocombat,noexists]Spire of Spite\n/script PetDismiss();\n/cry")
		end
		
		-- T75 Talents, "Ctrl+7" bind Bloodlusts etc. Biggest Dick in the game.
		if class == "SHAMAN" then
			EditMacro("WSxT75",nil,nil,"#showtooltip [mod]Bloodlust;[spec:3,talent:5/2]Earthen Shield Totem;[spec:3,talent:5/1]Ancestral Protection Totem;[spec:1,talent:5/3]Elemental Blast;Bloodlust;\n/use Bloodlust\n/use [nocombat]Thunderstorm")
		elseif class == "MAGE" then
			EditMacro("WSxT75",nil,nil,"#showtooltip [mod]Time Warp;[talent:5/2]Ring of Frost;[talent:5/1]Ice Floes;Polymorph;\n/use Time Warp")
		elseif class == "WARLOCK" then
			EditMacro("WSxT75",nil,nil,"#showtooltip [mod]Drums of the Mountain;[talent:5/3]Dark Pact;[talent:5/2]Burning Rush;[talent:5/1]Demonic Circle\n/use Drums of the Mountain\n/use Drums of Fury")
		elseif class == "MONK" then
			EditMacro("WSxT75",nil,nil,"#showtooltip [mod]Drums of the Mountain;[nospec:3]Fortifying Brew;[talent:5/1]Healing Elixir;[talent:5/2]Diffuse Magic;[talent:5/3]Dampen Harm;\n/use Drums of the Mountain\n/use Drums of Fury")
		elseif class == "PALADIN" then
			EditMacro("WSxT75",nil,nil,"#showtooltip [mod]Drums of the Mountain;[spec:3,talent:5/1]Justicar's Vengeance;[spec:3,talent:5/2]Eye for an Eye;[spec:3,talent:5/3]Word of Glory;[spec:1,talent:5/2]Holy Avenger;[spec:1,talent:5/3]Holy Prism\n/use Drums of the Mountain\n/use Drums of Fury")
		elseif class == "HUNTER" then
			EditMacro("WSxT75",nil,nil,"/use [nopet]Call Pet 5\n/use [pet:Core Hound]Ancient Hysteria;[pet:Nether Ray]Netherwinds;[pet,combat][spec:2,talent:1/1]Drums of Fury;\n/use [pet,combat][spec:2,talent:1/1] Drums of the Mountain")
		elseif class == "ROGUE" then
			EditMacro("WSxT75",nil,nil,"#showtooltip\n/use Drums of the Mountain\n/use Drums of Fury")
		elseif class == "PRIEST" then
			EditMacro("WSxT75",nil,nil,"#showtooltip [mod]Drums of the Mountain;[spec:1,talent:5/1]Clarity of Will;[spec:1,talent:5/2]Shadow Covenant;\n/use Drums of the Mountain\n/use Drums of Fury")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxT75",nil,nil,"#showtooltip [mod]Drums of the Mountain;[spec:3,talent:5/2]Corpse Shield;\n/use Drums of the Mountain\n/use Drums of Fury")
		elseif class == "WARRIOR" then
			EditMacro("WSxT75",nil,nil,"#showtooltip [mod]Drums of the Mountain;[spec:1,talent:5/3]Focused Rage\n/use Drums of the Mountain\n/use Drums of Fury")
		elseif class == "DRUID" then
			EditMacro("WSxT75",nil,nil,"#showtooltip [spec:1]Celestial Alignment;[spec:2,talent:5/3]Savage Roar;[spec:2]Berserk;[spec:3,talent:5/2]Incarnation: Guardian of Ursoc;[spec:4,talent:5/2]Incarnation: Tree of Life(Talent, Shapeshift)\n/use Drums of the Mountain\n/use Drums of Fury")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxT75",nil,nil,"#showtooltip [mod]Drums of the Mountain;[spec:1,talent:5/2]Fel Eruption;[spec:1,talent:5/3]Nemesis;[spec:2,talent:5/2]Sigil of Chains;\n/use Drums of the Mountain\n/use Drums of Fury")
		end
		
		-- T90 Talents -- Keybind "Shift+T" Taunts etc
		if class == "SHAMAN" then
			EditMacro("WSxT90",nil,nil,"#show [spec:2,talent:6/2]Fury of Air;[spec:2,talent:6/3]Sundering;[spec:3,talent:6/2]CloudBurst Totem;[spec:1,talent:6/1]Liquid Magma Totem;\n/use [harm,nocombat]Hozen Idol;[nocombat,noexists] Critter Hand Cannon;\n/target [nocombat,noexists]Squirrel")
		elseif class == "MAGE" then
			EditMacro("WSxT90",nil,nil,"#showtooltip [nocombat,noexists]Ancient Mana Basin;[spec:3,talent:6/1]Frost Bomb;[spec:1,talent:6/1]Nether Tempest;[spec:2,talent:6/1]Living Bomb;\n/use Ancient Mana Basin\n/mountspecial")
		elseif class == "WARLOCK" then
			EditMacro("WSxT90",nil,nil,"#showtooltip [nospec:2,talent:6/3]Grimoire of Sacrifice;[talent:6/2]Grimoire: Imp;\n/use [nocombat,noexists]Ritual of Doom")
		elseif class == "MONK" then
			EditMacro("WSxT90",nil,nil,"#show [spec:2,talent:6/1]Refreshing Jade Wind;[talent:6/1]Rushing Jade Wind;[spec:3,talent:6/2]Invoke Xuen, the White Tiger;[spec:2,talent:6/2] Invoke Chi-Ji, the Red Crane;[talent:6/2]Invoke Niuzao, the Black Ox;Summon Jade Serpent Statue;\n/use Provoke")
		elseif class == "PALADIN" then
			EditMacro("WSxT90",nil,nil,"#showtooltip [spec:3,talent:6/3]Seal of Light;[spec:2,talent:6/1]Aegis of Light;[spec:1,talent:6/1]Fervent Martyr;[spec:1,talent:6/2]Sanctified Wrath;[spec:1,talent:6/3]Judgment of Light;")
		elseif class == "HUNTER" then
			EditMacro("WSxT90",nil,nil,"#showtooltip [spec:1/2,talent:6/2]Barrage;[spec:1/2,talent:6/3]Volley;[spec:1/2,talent:6/1]A Murder of Crows;[spec:3,talent:6/2]Dragonsfire Grenade;\n/use Growl\n/use Hatchet Toss\n/use [noexists,nocombat] Flaming Hoop")
		elseif class == "ROGUE" then
			EditMacro("WSxT90",nil,nil,"#showtooltip [spec:2,talent:6/1]Cannonball Barrage;[spec:2,talent:6/3]Killing Spree;[spec:3,talent:6/3]Enveloping Shadows;[spec:1,talent:6/1]Agonizing Poison;[spec:1,talent:6/3]Exsanguinate;\n/use [nocombat]Trans-Dimensional Bird Whistle\n/mountspecial")
		elseif class == "PRIEST" then
			EditMacro("WSxT90",nil,niRl,"#showtooltip [spec:3,talent:6/1]Power Infusion;[spec:1,talent:6/1]Shadow Word: Pain;[nospec:3,talent:6/2]Divine Star;[nospec:3,talent:6/3]Halo;\n/use Milling\n/mountspecial")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxT90",nil,nil,"#showtooltip [spec:2,talent:6/1]Frostscythe;[spec:1,talent:6/2]Rune Tap;\n/use Dark Command\n/use Blight Boar Microphone")
		elseif class == "WARRIOR" then
			EditMacro("WSxT90",nil,nil,"#showtooltip [spec:2,talent:6/1]Bloodbath\n/use [exists,nodead] Taunt\n/use Leystone Ore\n/use Felslate\n/use Prospecting")
		elseif class == "DRUID" then
			EditMacro("WSxT90",nil,nil,"#showtooltip [spec:1,talent:6/3]Blessing of the Ancients;[spec:1,talent:6/2]Astral Communion;[spec:2,talent:6/3]Elune's Guidance;Prowl;\n/use Growl\n/dance")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxT90",nil,nil,"#showtooltip [spec:2,talent:6/1]Fel Devastation;[spec:2,talent:6/3]Spirit Bomb;\n/use [spec:2]Torment")
		end
		
		-- T100 Talents
		if class == "SHAMAN" then
			EditMacro("WSxT100",nil,nil,"#showtooltip [mod:ctrl]Bloodlust;[talent:7/1]Ascendance;[spec:2,talent:7/3]Earthen Spike;[spec:3,talent:7/2]Wellspring;[spec:1,talent:7/3]Icefury;")
		elseif class == "MAGE" then
			EditMacro("WSxT100",nil,nil,"#showtooltip [spec:3,talent:7/2]Glacial Spike;[spec:3,talent:7/3]Comet Storm;[spec:1,talent:7/3]Arcane Orb;[spec:2,talent:7/2]Cinderstorm;[spec:2,talent:7/3]Meteor;")
		elseif class == "WARLOCK" then
			EditMacro("WSxT100",nil,nil,"#showtooltip [spec:2,talent:7/1]Summon Darkglare;[spec:3,talent:7/2]Channel Demonfire;[spec:1,talent:7/2]Siphon Life;Demonic Gateway;")
		elseif class == "MONK" then
			EditMacro("WSxT100",nil,nil,"#showtooltip [spec:3,talent:7/2]Whirling Dragon Punch;[spec:3,talent:7/3]Serenity;[spec:2,talent:7/1]Mana Tea;")
		elseif class == "PALADIN" then
			EditMacro("WSxT100",nil,nil,"#showtooltip [spec:3,talent:7/3]Holy Wrath;[spec:1,talent:7/1]Beacon of Faith;[spec:1,talent:7/3]Beacon of Virtue;[spec:2,talent:7/2]Seraphim;")
		elseif class == "HUNTER" then
			EditMacro("WSxT100",nil,nil,"#showtooltip [spec:1,talent:7/1]Stampede;[spec:3,talent:7/1]Spitting Cobra;[spec:2,talent:7/1]Sidewinders;[spec:2,talent:7/2]Piercing Shot;")
		elseif class == "ROGUE" then
			EditMacro("WSxT100",nil,nil,"#showtooltip [talent:7/2]Marked for Death;[talent:7/3]Death from Above;")
		elseif class == "PRIEST" then
			EditMacro("WSxT100",nil,nil,"#showtooltip [spec:3,talent:7/3]Surrender to Madness;[spec:3,talent:7/2]Shadow Crash;[spec:2,talent:7/1]Apotheosis;[spec:2,talent:7/3]Circle of Healing;[spec:1,talent:7/1]Power Infusion;[spec:1,talent:7/3]Power Word: Radiance;")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxT100",nil,nil,"#showtooltip [spec:2,talent:7/1]Obliteration;[spec:2,talent:7/2]Breath of Sindragosa;[spec:2]Glacial Advance;[spec:3,talent:7/1]Dark Arbiter;[spec:3,talent:7/2]Defile;[spec:3]Soul Reaper;[spec:1,talent:7/1]Bonestorm;[spec:1,talent:7/2]Blood Mirror;")
		elseif class == "WARRIOR" then
			EditMacro("WSxT100",nil,nil,"#showtooltip [spec:2,talent:7/1][spec:1]Bladestorm;[spec:2,talent:7/3]Dragon Roar;[spec:3,talent:7/3]Ravager;")
		elseif class == "DRUID" then
			EditMacro("WSxT100",nil,nil,"#showtooltip [spec:1,talent:7/1]Fury of Elune;[spec:4,talent:7/3]Flourish;[spec:3,talent:7/3]Pulverize;[spec:3,talent:7/2]Lunar Beam;Prowl;")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxT100",nil,nil,"#showtooltip [spec:1,talent:7/1]Chaos Blades;[spec:1,talent:7/2]Fel Barrage;[spec:1,talent:7/3]Eye Beam;")
		end

		-- Pvp Trinket "Alt+5", alt+5.

		if class == "SHAMAN" then
			EditMacro("Wx1Trinkit",nil,nil,"#showtooltip\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Honorable Pennant")
		elseif class == "MAGE" then
			EditMacro("Wx1Trinkit",nil,nil,"#showtooltip\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Honorable Pennant")
		elseif class == "WARLOCK" then
			EditMacro("Wx1Trinkit",nil,nil,"#showtooltip\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Honorable Pennant")
		elseif class == "MONK" then
			EditMacro("Wx1Trinkit",nil,nil,"#show\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Honorable Pennant\n/run local j,p,_=C_PetJournal _,p=j.FindPetIDByName(\"Alterac Brew-Pup\") if p and j.GetSummonedPetGUID()~=p then j.SummonPetByGUID(p) end")
		elseif class == "PALADIN" then
			EditMacro("Wx1Trinkit",nil,nil,"#showtooltip\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Honorable Pennant")
		elseif class == "HUNTER" then
			EditMacro("Wx1Trinkit",nil,nil,"#showtooltip\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Honorable Pennant")
		end

		
		if class == "ROGUE" then
			if playerspec == 1 then
				EditMacro("Wx1Trinkit",nil,nil,"#showtooltip\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Honorable Pennant\n/cancelaura [nospec:2] A Mighty Pirate")
			elseif playerspec == 2 then
				EditMacro("Wx1Trinkit",nil,nil,"#showtooltip\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Jolly Roger\n/cancelaura [spec:2] Honorable Pennant")
			else 
				EditMacro("Wx1Trinkit",nil,nil,"#showtooltip\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Honorable Pennant\n/cancelaura [nospec:2] A Mighty Pirate")
			end
		end

		if class == "PRIEST" then
			EditMacro("Wx1Trinkit",nil,nil,"#showtooltip\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Honorable Pennant")
		elseif class == "DEATHKNIGHT" then
			EditMacro("Wx1Trinkit",nil,nil,"#showtooltip\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Honorable Pennant")
		elseif class == "WARRIOR" then
			EditMacro("Wx1Trinkit",nil,nil,"#showtooltip\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Honorable Pennant")
		elseif class == "DRUID" then
			EditMacro("Wx1Trinkit",nil,nil,"#showtooltip\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Honorable Pennant")
		elseif class == "DEMONHUNTER" then
			EditMacro("Wx1Trinkit",nil,nil,"#showtooltip\n/use Honorable Medallion\n/use [nocombat] Wand of Simulated Life\n/use Attraction Sign\n/use Honorable Pennant")
		end
		
		-- Class PvP Honor Talent 1, Completed, "Ctrl+G" bind.
		if class == "SHAMAN" then
			EditMacro("Wx9PvP1",nil,nil,"#showtooltip [pvptalent:3/1]Skyfury Totem;[pvptalent:3/2]Counterstrike Totem;[pvptalent:3/3]Windfury Totem;\n/use [nocombat,noexists]Whole-Body Shrinka';[@focus,harm,nodead]Purge;[spec:3,@focus,help,nodead]Purify Spirit; [@focus,help,nodead]Cleanse Spirit;")
		elseif class == "MAGE" then
			EditMacro("Wx9PvP1",nil,nil,"#showtooltip\n/use [@focus,harm,nodead][]Spellsteal;\n/use Poison Extraction Totem")
		elseif class == "WARLOCK" then
			EditMacro("Wx9PvP1",nil,nil,"#showtooltip [pvptalent:3/3]Curse of Fragility;[pvptalent:3/2]Curse of Weakness;[pvptalent:3/1]Curse of Tongues;[talent:6/2]Grimoire: Imp;\n/use [nopet]Summon Felhunter;\n/use [talent:6/2]Grimoire: Imp\n/use Poison Extraction Totem")
		elseif class == "MONK" then
			EditMacro("Wx9PvP1",nil,nil,"#showtooltip\n/use [@focus,help,nodead]Detox;[nocombat,noexists] Mystery Keg;\n/use [nocombat,noexists]Jin Warmkeg's Breww")
		elseif class == "PALADIN" then
			EditMacro("Wx9PvP1",nil,nil,"#showtooltip\n/use [@focus,help,nodead]Cleanse;Hand of Reckoning")
		end
		-- Hunter Pvp1 pet spec show
		if class == "HUNTER" then
			if petspec == 1 then 
				EditMacro("Wx9PvP1",nil,nil,"#showtooltip\n/use Heart of the Phoenix\n/use [nopet]Call Pet 4\n/use [nocombat,noexists]Whole-Body Shrinka'")
			elseif petspec == 2 then
				EditMacro("Wx9PvP1",nil,nil,"#showtooltip\n/use Last Stand\n/use [nopet]Call Pet 4\n/use [nocombat,noexists]Whole-Body Shrinka'\n/stopmacro [nopet:Crab][combat]\n/target pet\n/use [pet:Crab,nocombat,help,nodead]Crab Shank\n/targetlasttarget")
			else
				EditMacro("Wx9PvP1",nil,nil,"#showtooltip\n/use [pet,help,nodead][pet,@player]Roar of Sacrifice\n/use [nopet]Call Pet 4;\n/use [nocombat,noexists]Whole-Body Shrinka'") 
			end
		end

		if class == "ROGUE" then
			EditMacro("Wx9PvP1",nil,nil,"#showtooltip\n/use Totem of Spirits")
		elseif class == "PRIEST" then
			EditMacro("Wx9PvP1",nil,nil,"#showtooltip\n/use [@focus,harm,nodead]Dispel Magic;[nospec:3,@focus,help,nodead][nospec:3]Purify;[@focus,help,nodead][]Purify Disease;")
		elseif class == "DEATHKNIGHT" then
			EditMacro("Wx9PvP1",nil,nil,"#showtooltip\n/use Dark Command\n/use Blight Boar Microphone")
		elseif class == "WARRIOR" then
			EditMacro("Wx9PvP1",nil,nil,"#showtooltip\n/use Taunt\n/use Burning Blade")
		elseif class == "DRUID" then
			EditMacro("Wx9PvP1",nil,nil,"#showtooltip [spec:4,pvptalent:3/2]Thorns;Growl;\n/use [spec:4,@focus,help,nodead]Nature's Cure;[@focus,help,nodead]Remove Corruption;\n/use [harm,nocombat]Hozen Idol;[nocombat,noexists] Critter Hand Cannon;\n/target [nocombat,noexists]Squirrel")
		elseif class == "DEMONHUNTER" then
			EditMacro("Wx9PvP1",nil,nil,"#showtooltip\n/use Torment\n/use Wisp Amulet")
		end
		
		-- Class PvP Honor Talent 2, Completed, "Ctrl+T" bind.
		if class == "SHAMAN" then
			EditMacro("Wz10PvP2",nil,nil,"#show\n/use [spec:2,pvptalent:4/3]Ethereal Form;[spec:3]Spirit Link Totem;Haunting Memento;\n/use Bottled Tornado\n/kneel")
		elseif class == "MAGE" then
			EditMacro("Wz10PvP2",nil,nil,"#showtooltip\n/use Home Made Party Mask\n/use [nocombat,noexists]Nat's Fishing Chair\n/stopmacro [combat]\n/kneel")
		elseif class == "WARLOCK" then
			EditMacro("Wz10PvP2",nil,nil,"#showtooltip\n/use [pvptalent:4/3]Nether Ward;[pvptalent:4/2]Casting Circle;\n/use [harm,nocombat]Fractured Necrolyte Skull;[nocombat,noexists] Critter Hand Cannon;\n/target [nocombat,noexists]Squirrel\n/stopmacro [combat]\n/kneel")
		elseif class == "MONK" then
			EditMacro("Wz10PvP2",nil,nil,"#showtooltip\n/use [spec:2,pvptalent:4/3]Ancient Mistweaver Arts;[spec:2,pvptalent:4/2]Way of the Crane;[pvptalent:4/3]Zen Moment;[pvptalent:4/2]Fortifying Elixir;\n/use Bottled Tornado\n/stopmacro [combat]\n/kneel")
		elseif class == "PALADIN" then
			EditMacro("Wz10PvP2",nil,nil,"#showtooltip\n/use [spec:1,pvptalent:2/3] Divine Favor;[spec:2,pvptalent:3/1]Shield of Virtue;\n/stopmacro [combat]\n/kneel\n/use Sylvanas' Music Box")
		elseif class == "HUNTER" then
			EditMacro("Wz10PvP2",nil,nil,"#showtooltip\n/use [nocombat,noexists]Nat's Fishing Chair;[pvptalent:4/1]Viper Sting;[pvptalent:4/2]Scorpid Sting;[pvptalent:4/3]Spider Sting;\n/stopmacro [combat]\n/kneel")
		elseif class == "ROGUE" then
			EditMacro("Wz10PvP2",nil,nil,"#showtooltip\n/cancelaura Burgy Blackheart's Handsome Hat\n/use [nocombat,noexists]Burgy Blackheart's Handsome Hat;[spec:3,pvptalent:4/3]Smoke Bomb\n/stopmacro [combat]\n/kneel")
		elseif class == "PRIEST" then
			EditMacro("Wz10PvP2",nil,nil,"#showtooltip\n/use \n/use [nocombat,noexists]]Don Carlos' Famous Hat;[spec:2,pvptalent:3/3]Holy Ward\n/stopmacro [combat]\n/kneel")
		elseif class == "DEATHKNIGHT" then
			EditMacro("Wz10PvP2",nil,nil,"#showtooltip\n/use [pvptalent:3/2]Dark Simulacrum;[pvptalent:3/3]Anti-Magic Zone;\n/stopmacro [combat]\n/kneel\n/use Sylvanas' Music Box")
		elseif class == "WARRIOR" then
			EditMacro("Wz10PvP2",nil,nil,"#showtooltip\n/use [spec:3,pvptalent:3/3]Bodyguard;Tournament Favor;\n/stopmacro [combat]\n/kneel\n/use Sylvanas' Music Box\n/cancelaura Tournament Favor")
		elseif class == "DRUID" then
			EditMacro("Wz10PvP2",nil,nil,"#showtooltip\n/use [spec:3,pvptalent:4/3]Demoralizing Roar;[spec:4,pvptalent:4/1]Cylcone;\n/stopmacro [combat]\n/kneel\n/use Wisp Amulet")
		elseif class == "DEMONHUNTER" then
			EditMacro("Wz10PvP2",nil,nil,"\n/use [harm,nocombat]Fractured Necrolyte Skull;[nocombat,noexists] Critter Hand Cannon;\n/target [nocombat,noexists]Squirrel\n/stopmacro [combat]\n/kneel")
		end
		
		-- Class PvP Honor Talent 3, Completed. "Ctrl+Shift+F" bind.
		if class == "SHAMAN" then
			EditMacro("Wz11PvP3",nil,nil,"#showtooltip\n/use [nocombat,noexists] Mrgrglhjorn;[spec:1,pvptalent:5/3]Control of Lava;[spec:3,pvptalent:5/3]Grounding Totem;Purge;")
		elseif class == "MAGE" then
			EditMacro("Wz11PvP3",nil,nil,"#showtooltip\n/use [nocombat,noexists] Mrgrglhjorn;[pvptalent:4/1]Temporal Shield;")
		elseif class == "WARLOCK" then
			EditMacro("Wz11PvP3",nil,nil,"#showtooltip\n/use [nocombat,noexists]Legion Invasion Simulator;[spec:1,pvptalent:5/3]Soulburn;[spec:3,pvptalent:5/3]Firestone;[pvptalent:5/3]Singe Magic;[pvptalent:5/2]Call Felhunter;")
		elseif class == "MONK" then
			EditMacro("Wz11PvP3",nil,nil,"#showtooltip\n/use [nocombat,noexists] Mrgrglhjorn;[spec:1,pvptalent:5/1]Guard;[spec:1,pvptalent:5/3]Craft: Nimble Brew;")
		elseif class == "PALADIN" then
			EditMacro("Wz11PvP3",nil,nil,"#showtooltip\n/use [spec:3,pvptalent:5/2]Blessing of Sanctuary;")
		elseif class == "HUNTER" then
			EditMacro("Wz11PvP3",nil,nil,"#showtooltip\n/use [spec:2,pvptalent:5/2]Scatter Shot;[spec:2,pvptalent:5/3]Freezing Arrow;[spec:3,pvptalent:5/2]Mending Bandage;[spec:3,pvptalent:5/3]Master's Call;")
		elseif class == "ROGUE" then
			EditMacro("Wz11PvP3",nil,nil,"#showtooltip\n/use [nocombat,noexists]Crashin' Thrashin' Cannon Controller;[spec:1,pvptalent:5/3]Shiv;[spec:3,pvptalent:5/3]Cold Blood;[pvptalent:5/3]Create: Crimson Vial;")
		elseif class == "PRIEST" then
			EditMacro("Wz11PvP3",nil,nil,"#showtooltip\n/use [spec:1,pvptalent:4/2]Premonition;[spec:2,pvptalent:4/3]Greater Fade;[nocombat,noexists]Thistleleaf Branch;")
		elseif class == "DEATHKNIGHT" then
			EditMacro("Wz11PvP3",nil,nil,"#showtooltip\n/use [spec:1,pvptalent:5/3]Strangulate;")
		elseif class == "WARRIOR" then
			EditMacro("Wz11PvP3",nil,nil,"#showtooltip\n/use [spec:1/2,pvptalent:4/2][spec:3]Spell Reflection;")
		elseif class == "DRUID" then
			EditMacro("Wz11PvP3",nil,nil,"#showtooltip\n/use [spec:3,pvptalent:5/2]Enraged Mangle;Nature's Beacon")
		elseif class == "DEMONHUNTER" then
			EditMacro("Wz11PvP3",nil,nil,"#showtooltip\n/use [nocombat,noexists]Legion Invasion Simulator;[pvptalent:4/2]Reverse Magic;[pvptalent:4/3]Eye of Leotheras;")
		end
	
		-- Class PvP Honor Talent 4, Completed. "Ctrl+Shift+G" bind.
		if class == "SHAMAN" then
			EditMacro("Wz12PvP4",nil,nil,"#showtooltip\n/use [spec:1,pvptalent:6/2]Thunderstorm;[spec:1,pvptalent:6/3]Lightning Lasso;[spec:3,pvptalent:6/2]Earth Shield;[spec:3,pvptalent:6/3]Spirit Link;[pvptalent:6/1]Bloodlust;[pvptalent:6/3]Thundercharge;")
		elseif class == "MAGE" then
			EditMacro("Wz12PvP4",nil,nil,"#showtooltip\n/use [spec:2,pvptalent:6/3]Greater Pyroblast;[spec:1,pvptalent:6/3]Mass Invisibility;[pvptalent:6/3]Ice Form;")
		elseif class == "WARLOCK" then
			EditMacro("Wz12PvP4",nil,nil,"#showtooltip\n/use [nocombat,noexists]Micro-Artillery Controller;[spec:1,pvptalent:6/3]Soul Swap;[spec:3,pvptalent:6/3]Bane of Havoc;[pvptalent:6/3]Call Observer;[pvptalent:6/2]Call Fel Lord;")
		elseif class == "MONK" then
			EditMacro("Wz12PvP4",nil,nil,"#showtooltip\n/use [spec:1,pvptalent:6/1]Incendiary Brew;[spec:1,pvptalent:6/2]Double Barrel;[spec:1,pvptalent:6/3]Mighty Ox Kick;[spec:2,pvptalent:6/3]Healing Sphere;[pvptalent:6/2]Grapple Weapon;[pvptalent:6/3]Spinning Fire Blossom;")
		elseif class == "PALADIN" then
			EditMacro("Wz12PvP4",nil,nil,"#showtooltip\n/use [spec:2,pvptalent:6/3]Guardian of the Forgotten Queen;[spec:1,pvptalent:6/3]Avenging Crusader;[pvptalent:6/3]Hammer of Reckoning;")
		elseif class == "HUNTER" then
			EditMacro("Wz12PvP4",nil,nil,"#showtooltip\n/use [spec:2,pvptalent:6/3]Sniper Shot;[spec:3,pvptalent:6/3]Tracker's Net;[pvptalent:6/2]Dire Beast: Hawk;[pvptalent:6/3]Dire Beast: Basilisk;")
		elseif class == "ROGUE" then
			EditMacro("Wz12PvP4",nil,nil,"#showtooltip\n/use [spec:1]The Golden Banana;[spec:3,pvptalent:6/3]Shadowy Duel;[pvptalent:6/2]Dismantle;[pvptalent:6/3]Plunder Armor;")
		elseif class == "PRIEST" then
			EditMacro("Wz12PvP4",nil,nil,"#showtooltip\n/use [spec:3,pvptalent:6/1]Psyfiend;[spec:3,pvptalent:6/3]Void Shift;[spec:2,pvptalent:6/2]Spirit of the Redeemer;[spec:2,pvptalent:6/3]Ray of Hope;[pvptalent:6/1]Power Word: Fortitude;[pvptalent:6/2]Archangel;[pvptalent:6/3]Dark Archangel;")
		elseif class == "DEATHKNIGHT" then
			EditMacro("Wz12PvP4",nil,nil,"#showtooltip\n/use [spec:1,pvptalent:6/2]Blood for Blood;[spec:1,pvptalent:6/3]Death Chain;[spec:3,pvptalent:6/2]Reanimation;[spec:3,pvptalent:6/3]Necrotic Strike;[pvptalent:6/3]Chill Streak;")
		elseif class == "WARRIOR" then
			EditMacro("Wz12PvP4",nil,nil,"#showtooltip\n/use [spec:3,pvptalent:6/3]Dragon Charge;[spec:2,pvptalent:6/3]Death Wish;[pvptalent:6/3]Sharpen Blade;")
		elseif class == "DRUID" then
			EditMacro("Wz12PvP4",nil,nil,"#showtooltip\n/use [spec:3,pvptalent:6/3]Overrun;[spec:4,pvptalent:6/1]Focused Growth;[spec:4,pvptalent:6/3]Overgrowth;[spec:2,pvptalent:6/3]Rip and Tear;[pvptalent:6/1]Cyclone;[pvptalent:6/3]Faerie Swarm;")
		elseif class == "DEMONHUNTER" then
			EditMacro("Wz12PvP4",nil,nil,"#showtooltip\n/use [nocombat,noexists]Micro-Artillery Controller;[spec:2,pvptalent:6/1]Demonic Trample;[spec:2,pvptalent:6/3]Illidan's Grasp;[pvptalent:6/1]Rain from Above;[pvptalent:6/3]Mana Break;")
		end
		
		-- Macro for button 1 "1"
		if class == "SHAMAN" then
			EditMacro("WSxGen1",nil,nil,"#showtooltip\n/castsequence [spec:1,talent:1/3] reset=combat/5 Totem Mastery,Lava Surge\n/use [spec:3,talent:1/2]Unleash Life;[spec:2,talent:1/1]Windsong;[@mouseover,harm,nodead,nospec:2][nospec:2]Flame Shock;Lightning Bolt;\n/targetenemy [noexists]")
		elseif class == "MAGE" then
			EditMacro("WSxGen1",nil,nil,"/targetenemy [noharm]\n/use [nocombat,noexists]Dazzling Rod;[spec:3,talent:1/1]Ray of Frost;[spec:2]Combustion;[spec:1,talent:1/2]Presence of Mind;[spec:1,talent:1/1]Arcane Familiar;Ice Lance;\n/use 13")
		elseif class == "WARLOCK" then
			EditMacro("WSxGen1",nil,nil,"#showtooltip\n/focus [@boss2,exists,nodead] boss2\n/use [noexists,nocombat]Copy of Daglop's Contract;[spec:2]Demonic Empowerment;[spec:3,@focus,exists,nodead]Havoc;[spec:1,talent:1/1]Haunt;[spec:1]Drain Soul;[nospec:1]Drain Life;")
		elseif class == "MONK" then
			EditMacro("WSxGen1",nil,nil,"#showtooltip\n/use [spec:3,talent:7/2]Whirling Dragon Punch;[spec:3,talent:7/3]Serenity;[spec:2]Essence Font;[spec:1]Expel Harm;Crackling Jade Lightning\n/targetenemy [noexists\n/use [nocombat,noexists]Ruthers' Harness")
		elseif class == "PALADIN" then
			EditMacro("WSxGen1",nil,nil,"/use [spec:3,talent:5/1]Justicar's Vengeance;[spec:3,talent:5/2]Eye for an Eye;[spec:2,talent:2/2]Bastion of Light;[spec:1,@mouseover,help,nodead][spec:1]Holy Shock;Judgment;")
		elseif class == "HUNTER" then
			EditMacro("WSxGen1",nil,nil,"#showtooltip\n/use [harm,dead]Fetch;[spec:3,talent:2/1][nospec:3,talent:6/1]A Murder of Crows;[nospec:3,talent:6/2]Barrage;[nospec:3,talent:6/3]Volley;[spec:3,talent:2/3]Snake Hunter;Fetch;\n/targetenemy [noexists]")
		elseif class == "ROGUE" then
			EditMacro("WSxGen1",nil,nil,"#showtooltip\n/use [stance:0,nocombat]Stealth;[spec:2,talent:6/1,@player]Cannonball Barrage;[spec:3]Symbols of Death;[spec:2]Pistol Shot;[spec:1]Garrote;\n/targetenemy [noexists]\n/startattack [combat]")
		elseif class == "PRIEST" then
			EditMacro("WSxGen1",nil,nil,"#showtooltip\n/use [help,nodead]The Heartbreaker;[spec:1,talent:4/1]Power Word: Solace;[spec:2]Holy Fire;[spec:3,talent:1/3]Shadow Word: Void;[spec:3]Vampiric Touch;[spec:1,talent:1/3]Schism;The Heartbreaker;\n/targetenemy [noexists]")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxGen1",nil,nil,"#showtooltip\n/use [@mouseover,help,dead][help]Raise Ally;[spec:1,talent:1/3]Blooddrinker;Death Strike;\n/targetenemy [noexists]")
		elseif class == "WARRIOR" then
			EditMacro("WSxGen1",nil,nil,"/use [spec:1]Colossus Smash;[spec:2]Rampage;[spec:3]Shield Block;\n/startattack\n/targetenemy [spec:2]")
		elseif class == "DRUID" then
			EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,dead][help,dead]Rebirth;[form:2,spec:2,talent:1/1][form:2,spec:2,talent:1/2]Rake;[@mouseover,harm,nodead][harm,nodead]Moonfire(Lunar);Druid and Priest Statue Set;\n/startattack\n/use [nocombat,noform:1/4]!Prowl")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxGen1",nil,nil,"/use [spec:2]Demon Spikes;Fel Rush\n/cleartarget [spec:1]\n/targetenemy [noexists]\n/startattack")
		end
		
		-- Shift+1 [mod:ctrl]Party2 and Focus/Party1 Do Spell, Completed, not tested
		if class == "SHAMAN" then
			EditMacro("WSxSGen+1",nil,nil,"#showtooltip [noexists,nocombat]Haunted War Drum;Bloodlust;\n/use [mod:ctrl,@party2,exists,nodead][@focus,help,nodead][@party1,exists,nodead]Healing Surge;[noexists,nocombat]Haunted War Drum;\n/target Reaves")
		elseif class == "MAGE" then
			EditMacro("WSxSGen+1",nil,nil,"/use [mod:ctrl,@party2target,exists,nodead][@focustarget,exists,nodead][@party1target,exists,nodead]Polymorph;[noexists,nocombat]Manastorm's Duplicator;\n/target Reaves")
		elseif class == "WARLOCK" then
			EditMacro("WSxSGen+1",nil,nil,"#showtooltip\n/use [spec:3,pvptalent:6/2]Firestone;[spec:1,pvptalent:6/3]Soul Swap;[spec:2,talent:6/2]Grimoire: Felguard;\n/target Reaves\n/stopmacro [nospec:3,nomod:alt]\n/target focus\n/targetlasttarget\n/focus target\n/targetlasttarget")
		elseif class == "MONK" then
			EditMacro("WSxSGen+1",nil,nil,"/use [mod:ctrl,@party2,exists,nodead][@focus,help,nodead][@party1,exists,nodead]Effuse;[nocombat,noexists] Honorary Brewmaster Keg;\n/targetexact Reaves")
		elseif class == "PALADIN" then
			EditMacro("WSxSGen+1",nil,nil,"#showtooltip Blessing of Protection\n/use [mod:ctrl,@party2,exists,nodead][@focus,help,nodead][@party1,exists,nodead]Flash of Light\n/target Reaves")
		elseif class == "HUNTER" then
			EditMacro("WSxSGen+1",nil,nil,"#show Aspect of the Cheetah\n/use [noexists,nocombat]Whitewater Carp;[mod:ctrl,@party2,exists,nodead][@focus,help,nodead][@party1,exists,nodead]Spirit Mend;\n/targetexact Talua\n/target Reaves")
		elseif class == "ROGUE" then
			EditMacro("WSxSGen+1",nil,nil,"#showtooltip Tricks of the Trade\n/use [mod:ctrl,@party2,exists,nodead,spec:1/3][@focus,help,nodead,spec:1/3][@party1,exists,nodead,spec:1/3]Shadowstep\n/targetexact Lucian Trias\n/target Reaves")
		elseif class == "PRIEST" then
			EditMacro("WSxSGen+1",nil,nil,"/use [mod:ctrl,@party2,exists,nodead,spec:2][@focus,help,nodead,spec:2][@party1,exists,nodead,spec:2]Flash Heal;[mod:ctrl,@party2,exists,nodead][@focus,help,nodead][@party1,exists,nodead]Shadow Mend; [noexists,nocombat]Kaldorei Light Globe\n/target Reaves")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxSGen+1",nil,nil,"#showtooltip [spec:1,talent:6/2]Rune Tap;[spec:3]Army of the Dead;Corpse Explosion;\n/use [spec:1,talent:6/2]Rune Tap;Corpse Explosion;\n/use Stolen Breath\n/target Reaves")
		elseif class == "WARRIOR" then
			EditMacro("WSxSGen+1",nil,nil,"/use [mod:ctrl,@focustarget,exists,nodead][mod:ctrl,@party2target,exists,nodead]Charge;[spec:3]Ignore Pain;[@party1target,exists,nodead]Charge\n/use Chalice of Secrets\n/targetexact Aerylia\n/target Reaves")
		elseif class == "DRUID" then
			EditMacro("WSxSGen+1",nil,nil,"#showtooltip [spec:4] Tranquility; Regrowth;\n/use [mod:ctrl,@party2,exists,nodead][@focus,help,nodead][@party1,exists,nodead]Regrowth\n/target Reaves")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxSGen+1",nil,nil,"/use Skull of Corruption\n/target Reaves")
		end
		
		-- Macro for button 2, "2" "Fill"
		-- if class == "SHAMAN" then
		-- 	EditMacro("WSxGen2",nil,nil,"/use Sack of White Turnips\n/use Sack of Red Blossom Leeks\n/use Sack of Juicycrunch Carrots\n/use Sack of Mogu Pumpkins\n/use Sack of Green Cabbages\n/use Sack of Witchberries\n/use Sack of Jade Squash\n/use Chilled Satchel of Vegetables")
		-- elseif class == "MAGE" then
		-- 	EditMacro("WSxGen2",nil,nil,"/use Sack of White Turnips\n/use Sack of Red Blossom Leeks\n/use Sack of Juicycrunch Carrots\n/use Sack of Mogu Pumpkins\n/use Sack of Green Cabbages\n/use Sack of Witchberries\n/use Sack of Jade Squash\n/use Chilled Satchel of Vegetables")
		-- elseif class == "WARLOCK" then
		-- 	EditMacro("WSxGen2",nil,nil,"/use Sack of White Turnips\n/use Sack of Red Blossom Leeks\n/use Sack of Juicycrunch Carrots\n/use Sack of Mogu Pumpkins\n/use Sack of Green Cabbages\n/use Sack of Witchberries\n/use Sack of Jade Squash\n/use Chilled Satchel of Vegetables")
		-- elseif class == "MONK" then
		-- 	EditMacro("WSxGen2",nil,nil,"/use Sack of White Turnips\n/use Sack of Red Blossom Leeks\n/use Sack of Juicycrunch Carrots\n/use Sack of Mogu Pumpkins\n/use Sack of Green Cabbages\n/use Sack of Witchberries\n/use Sack of Jade Squash\n/use Chilled Satchel of Vegetables")
		-- elseif class == "PALADIN" then
		-- 	EditMacro("WSxGen2",nil,nil,"/use Sack of White Turnips\n/use Sack of Red Blossom Leeks\n/use Sack of Juicycrunch Carrots\n/use Sack of Mogu Pumpkins\n/use Sack of Green Cabbages\n/use Sack of Witchberries\n/use Sack of Jade Squash\n/use Chilled Satchel of Vegetables")
		-- elseif class == "HUNTER" then
		-- 	EditMacro("WSxGen2",nil,nil,"/use Sack of White Turnips\n/use Sack of Red Blossom Leeks\n/use Sack of Juicycrunch Carrots\n/use Sack of Mogu Pumpkins\n/use Sack of Green Cabbages\n/use Sack of Witchberries\n/use Sack of Jade Squash\n/use Chilled Satchel of Vegetables")
		-- elseif class == "ROGUE" then
		-- 	EditMacro("WSxGen2",nil,nil,"/use Sack of White Turnips\n/use Sack of Red Blossom Leeks\n/use Sack of Juicycrunch Carrots\n/use Sack of Mogu Pumpkins\n/use Sack of Green Cabbages\n/use Sack of Witchberries\n/use Sack of Jade Squash\n/use Chilled Satchel of Vegetables")
		-- elseif class == "PRIEST" then
		-- 	EditMacro("WSxGen2",nil,nil,"/use Sack of White Turnips\n/use Sack of Red Blossom Leeks\n/use Sack of Juicycrunch Carrots\n/use Sack of Mogu Pumpkins\n/use Sack of Green Cabbages\n/use Sack of Witchberries\n/use Sack of Jade Squash\n/use Chilled Satchel of Vegetables")
		-- elseif class == "DEATHKNIGHT" then
		-- 	EditMacro("WSxGen2",nil,nil,"/use Sack of White Turnips\n/use Sack of Red Blossom Leeks\n/use Sack of Juicycrunch Carrots\n/use Sack of Mogu Pumpkins\n/use Sack of Green Cabbages\n/use Sack of Witchberries\n/use Sack of Jade Squash\n/use Chilled Satchel of Vegetables")
		-- elseif class == "WARRIOR" then
		-- 	EditMacro("WSxGen2",nil,nil,"/use Sack of White Turnips\n/use Sack of Red Blossom Leeks\n/use Sack of Juicycrunch Carrots\n/use Sack of Mogu Pumpkins\n/use Sack of Green Cabbages\n/use Sack of Witchberries\n/use Sack of Jade Squash\n/use Chilled Satchel of Vegetables")
		-- elseif class == "DRUID" then
		-- 	EditMacro("WSxGen2",nil,nil,"/use Sack of White Turnips\n/use Sack of Red Blossom Leeks\n/use Sack of Juicycrunch Carrots\n/use Sack of Mogu Pumpkins\n/use Sack of Green Cabbages\n/use Sack of Witchberries\n/use Sack of Jade Squash\n/use Chilled Satchel of Vegetables")
		-- elseif class == "DEMONHUNTER" then
		-- 	EditMacro("WSxGen2",nil,nil,"/use Sack of White Turnips\n/use Sack of Red Blossom Leeks\n/use Sack of Juicycrunch Carrots\n/use Sack of Mogu Pumpkins\n/use Sack of Green Cabbages\n/use Sack of Witchberries\n/use Sack of Jade Squash\n/use Chilled Satchel of Vegetables")
		-- end

		-- Macro for button 2, "2" "Fill"
		if class == "SHAMAN" then
			EditMacro("WSxGen2",nil,nil,"#showtooltip\n/use [nocombat,noexists]Raging Elemental Stone;[spec:2]Rockbiter;Lightning Bolt;\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
		elseif class == "MAGE" then
			EditMacro("WSxGen2",nil,nil,"#showtooltip\n/use [noexists,nocombat]Akazamzarak's Spare Hat;[spec:3]Frostbolt;[spec:2]Scorch;[spec:1]Arcane Blast;\n/targetenemy [noharm]\n/cleartarget [dead]")
		elseif class == "WARLOCK" then
			EditMacro("WSxGen2",nil,nil,"#showtooltip\n/targetlasttarget [noexists,nocombat]\n/use [harm,dead,nocombat]Soul Inhaler;[spec:1]Agony;[spec:2]Shadow bolt;[spec:3]Incinerate;\n/use Accursed Tome of the Sargerei\n/startattack\n/clearfocus [dead]")
		elseif class == "MONK" then
			EditMacro("WSxGen2",nil,nil,"#showtooltip\n/use [nocombat,noexists]Brewfest Keg Pony;[@mouseover,harm,nodead][]Tiger Palm;\n/targetenemy [noexists]\n/cleartarget [dead]")
		elseif class == "PALADIN" then
			EditMacro("WSxGen2",nil,nil,"#showtooltip\n/use Crusader Strike\n/startattack\n/targetenemy [noexists]\n/cleartarget [dead]")
		elseif class == "HUNTER" then
			EditMacro("WSxGen2",nil,nil,"#showtooltip\n/targetlasttarget [noexists,nocombat,nodead]\n/startattack\n/use [harm,dead]Mother's Skinning Knife;[@mouseover,harm,nodead,spec:1][spec:1]Dire Beast;[spec:2]Aimed Shot;[spec:3]Raptor Strike;\n/use Gnomish X-Ray Specs")
		elseif class == "ROGUE" then
			EditMacro("WSxGen2",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [stance:0,nocombat]Stealth;[stealth,nostance:3,nodead]Pick Pocket;[spec:2]Saber Slash;[spec:1,talent:1/3]Hemorrhage;[spec:1]Mutilate;[spec:3]Shadowstrike;\n/cleartarget [exists,dead]\n/stopspelltarget")
		elseif class == "PRIEST" then
			EditMacro("WSxGen2",nil,nil,"#showtooltip [spec:2]Smite;[spec:1]Power Word: Barrier;Vampiric Touch;\n/cancelaura Fling Rings\n/use [nocombat] Darkmoon Ring-Flinger\n/use [nospec:3,help,nodead] Holy Lightsphere;Smite\n/targetenemy [noexists]\n/cleartarget [dead]")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxGen2",nil,nil,"#showtooltip\n/use [noexists,nocombat,spec:1] Vial of Red Goo;[spec:1]Heart Strike;[spec:3]Scourge Strike;[spec:2,@mouseover,harm,nodead][spec:2]Howling Blast;\n/startattack\n/cancelaura Secret of the Ooze\n/cleartarget [dead]")
		elseif class == "WARRIOR" then
			EditMacro("WSxGen2",nil,nil,"#showtooltip\n/use [nocombat,noexists]Vrykul Drinking Horn;[spec:1]Mortal Strike;[spec:2]Bloodthirst;[spec:3]Devastate;\n/targetenemy [noexists]\n/cleartarget [noharm]\n/startattack")
		end

		if class == "DRUID" then
			if playerspec == 1 then
				EditMacro("WSxGen2",nil,nil,"/use [talent:3/1,form:2]Shred;[talent:3/2,form:1]Mangle;Sunfire(Solar);\n/targetenemy [noexists]\n/cleartarget [dead]")
			elseif playerspec == 2 then
				EditMacro("WSxGen2",nil,nil,"/use [form:2]Shred;[talent:3/2,form:1]Mangle;[talent:3/1,noform:4]Moonkin Form;[talent:3/1,form:4][@mouseover,harm,nodead,form:4][form:4,harm,nodead]Sunfire(Solar);[talent:3/3,noform]Healing Touch;[noform:2]!Cat Form;\n/targetenemy [noexists]")
			elseif playerspec == 3 then
				EditMacro("WSxGen2",nil,nil,"/use [form:1]Mangle;[talent:3/1,noform:4]Moonkin Form;[talent:3/1,form:4]Sunfire;[talent:3/2,noform:2]!Cat Form;[talent:3/2,form:2]Shred;[@mouseover,help,nodead,talent:3/3][talent:3/3]Healing Touch;\n/targetenemy [noexists]\n/cleartarget [dead]")
			elseif playerspec == 4 then
				EditMacro("WSxGen2",nil,nil,"/use [talent:3/3,form:1]Mangle;[talent:3/2,form:2]Shred;[@mouseover,harm,nodead][harm,nodead][]Sunfire(Solar);\n/targetenemy [noexists]\n/cleartarget [dead]")
			end
		end

		if class == "DEMONHUNTER" then
			EditMacro("WSxGen2",nil,nil,"#showtooltip\n/use [nocombat,noexists]Verdant Throwing Sphere;[spec:2]Shear;[spec:1]Demon's Bite;\n/cleartarget [spec:1,talent:2/2]\n/targetenemy [noexists]\n/startattack")
		end
		
		-- Shift+2
		if class == "SHAMAN" then
			EditMacro("WSxSGen+2",nil,nil,"#showtooltip\n/use [@mouseover,help,nodead][]Healing Surge\n/use Gnomish X-Ray Specs")
		elseif class == "MAGE" then
			EditMacro("WSxSGen+2",nil,nil,"/use [spec:3,pet:Water Elemental,harm,nodead]Water Jet;[spec:1,combat]Evocation;Conjured Mana Bun;\n/use Gnomish X-Ray Specs\n/stopcasting [spec:2]\n/use [nocombat] Conjure Refreshment;\n/targetenemy [noharm]")
		elseif class == "WARLOCK" then
			EditMacro("WSxSGen+2",nil,nil,"#showtooltip\n/use [spec:1,nomod]Agony;[nospec:1]Drain Life;\n/targetenemy [noharm]\n/cleartarget [dead]\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Agony\n/targetlasttarget")
		elseif class == "MONK" then
			EditMacro("WSxSGen+2",nil,nil,"/use [@mouseover,help,nodead][]Effuse")
		elseif class == "PALADIN" then
			EditMacro("WSxSGen+2",nil,nil,"/use [@mouseover,help,nodead][]Flash of Light")
		elseif class == "HUNTER" then
			EditMacro("WSxSGen+2",nil,nil,"/use [spec:3,pvptalent:5/2]Mending Bandage;[spec:2,talent:1/1][spec:1,pet,nopet:Spirit Beast]Dismiss Pet;[nopet,spec:1]Call Pet 2;[nopet,nospec:1]Call Pet 5;[@mouseover,help,nodead,pet][pet,help,nodead][pet,@player]Spirit Mend;\n/use Totem of Spirits")
		elseif class == "ROGUE" then
			EditMacro("WSxSGen+2",nil,nil,"#showtooltip\n/use Crimson Vial\n/use [nostealth] Totem of Spirits\n/use [nostealth] Hourglass of Eternity;\n/use [nocombat,nostealth,spec:2] Don Carlos' Famous Hat")
		elseif class == "PRIEST" then
			EditMacro("WSxSGen+2",nil,nil,"/use [spec:1/3,@mouseover,help,nodead][spec:1/3]Shadow Mend;[@mouseover,help,nodead][]Flash Heal;\n/use Gnomish X-Ray Specs")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxSGen+2",nil,nil,"#showtooltip\n/use [spec:3,talent:5/2]Corpse Shield;[spec:1,talent:3/2]Blood Tap;[dead,help]Raise Ally;Death Strike;\n/startattack")
		elseif class == "WARRIOR" then
			EditMacro("WSxSGen+2",nil,nil,"/use [dead,exists]Cannibalize;[nospec:2]Victory Rush;Cannibalize;")
		elseif class == "DRUID" then
			EditMacro("WSxSGen+2",nil,nil,"/use [@mouseover,help,nodead][]Regrowth")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxSGen+2",nil,nil,"#showtooltip\n/use [spec:2,talent:6/1]Fel Devastation;[spec:2,talent:6/3]Spirit Bomb;Glide;\n/startattack\n/targetenemy [noexists]\n/cleartarget [dead]\n/use Gnomish X-Ray Specs")
		end
		
		-- Ctrl+Shift+2
		if class == "SHAMAN" then
			EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead][@party1,exists,nodead]Cleanse Spirit;")
		elseif class == "MAGE" then
			EditMacro("WSxCSGen+2",nil,nil,"")
		elseif class == "WARLOCK" then
			EditMacro("WSxCSGen+2",nil,nil,"/use [spec:1,@focus,harm]Agony;\n/targetenemy [noharm]\n/cleartarget [dead]")
		elseif class == "MONK" then
			EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead][@party1,exists,nodead]Detox;")
		elseif class == "PALADIN" then
			EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead][@party1,exists,nodead]Cleanse;")
		elseif class == "HUNTER" then
			EditMacro("WSxCSGen+2",nil,nil,"#showtooltip Aspect of the Cheetah\n/use [@focus,help,nodead][@party1,exists,nodead]Roar of Sacrifice;")
		elseif class == "ROGUE" then
			EditMacro("WSxCSGen+2",nil,nil,"#showtooltip Tricks of the Trade")
		elseif class == "PRIEST" then
			EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead][@party1,exists,nodead]Power Word: Shield;")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxCSGen+2",nil,nil,"")
		elseif class == "WARRIOR" then
			EditMacro("WSxCSGen+2",nil,nil,"")
		elseif class == "DRUID" then
			EditMacro("WSxCSGen+2",nil,nil,"/use [spec:4,@focus,help,nodead][spec:4,@party1,exists,nodead]Nature's Cure;[@focus,help,nodead][@party1,exists,nodead]Remove Corruption;")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxCSGen+2",nil,nil,"")
		end
		
		-- -- Macro for button 3, "3" "Exec" "turnips, delete soon"
		-- if class == "SHAMAN" then
		-- 	EditMacro("WSxGen3",nil,nil,"/use Sack of Pink Turnips\n/use Sack of Scallions\n/use Sack of Striped Melons\n/use ")
		-- elseif class == "MAGE" then
		-- 	EditMacro("WSxGen3",nil,nil,"/use Sack of Pink Turnips\n/use Sack of Scallions\n/use Sack of Striped Melons\n/use ")
		-- elseif class == "WARLOCK" then
		-- 	EditMacro("WSxGen3",nil,nil,"/use Sack of Pink Turnips\n/use Sack of Scallions\n/use Sack of Striped Melons\n/use ")
		-- elseif class == "MONK" then
		-- 	EditMacro("WSxGen3",nil,nil,"/use Sack of Pink Turnips\n/use Sack of Scallions\n/use Sack of Striped Melons\n/use ")
		-- elseif class == "PALADIN" then
		-- 	EditMacro("WSxGen3",nil,nil,"/use Sack of Pink Turnips\n/use Sack of Scallions\n/use Sack of Striped Melons\n/use ")
		-- elseif class == "HUNTER" then
		-- 	EditMacro("WSxGen3",nil,nil,"/use Sack of Pink Turnips\n/use Sack of Scallions\n/use Sack of Striped Melons\n/use ")
		-- elseif class == "ROGUE" then
		-- 	EditMacro("WSxGen3",nil,nil,"/use Sack of Pink Turnips\n/use Sack of Scallions\n/use Sack of Striped Melons\n/use ")
		-- elseif class == "PRIEST" then
		-- 	EditMacro("WSxGen3",nil,nil,"/use Sack of Pink Turnips\n/use Sack of Scallions\n/use Sack of Striped Melons\n/use ")
		-- elseif class == "DEATHKNIGHT" then
		-- 	EditMacro("WSxGen3",nil,nil,"/use Sack of Pink Turnips\n/use Sack of Scallions\n/use Sack of Striped Melons\n/use ")
		-- elseif class == "WARRIOR" then
		-- 	EditMacro("WSxGen3",nil,nil,"/use Sack of Pink Turnips\n/use Sack of Scallions\n/use Sack of Striped Melons\n/use ")
		-- elseif class == "DRUID" then
		-- 	EditMacro("WSxGen3",nil,nil,"/use Sack of Pink Turnips\n/use Sack of Scallions\n/use Sack of Striped Melons\n/use ")
		-- elseif class == "DEMONHUNTER" then
		-- 	EditMacro("WSxGen3",nil,nil,"/use Sack of Pink Turnips\n/use Sack of Scallions\n/use Sack of Striped Melons\n/use ")
		-- end

		-- Macro for button 3, "3" "Exec"
		if class == "SHAMAN" then
			EditMacro("WSxGen3",nil,nil,"#showtooltip\n/startattack\n/targetenemy [noexists]\n/use [nocombat,noexists]Tadpole Cloudseeder;[spec:2]Stormstrike;Lava Burst;\n/cleartarget [dead]")
		elseif class == "MAGE" then
			EditMacro("WSxGen3",nil,nil,"/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,noexists]Shado-Pan Geyser Gun;[spec:3,@cursor]Frozen Orb;[@mouseover,harm,nodead,spec:2][spec:2]Pyroblast;[talent:7/3]Arcane Orb;Evocation\n/stopmacro [combat][exists]\n/click ExtraActionButton1") 
		elseif class == "WARLOCK" then
			EditMacro("WSxGen3",nil,nil,"#showtooltip\n/use [nocombat,noexists]Pocket Fel Spreader;[spec:1]Drain Soul;[spec:2]Call Dreadstalkers;[@mouseover,harm,nodead,talent:1/3][talent:1/3]Shadowburn;Immolate;\n/targetenemy [noexists]\n/cleartarget [dead]")
		elseif class == "MONK" then
			EditMacro("WSxGen3",nil,nil,"#showtooltip\n/use [spec:2,@mouseover,help,nodead][spec:2]Enveloping Mist;[spec:3]Touch of Death;[spec:1,talent:6/2]Invoke Niuzao, the Black Ox;[talent:6/1]Rushing Jade Wind;[spec:1]Blackout Kick;\n/targetenemy [noexists]\n/cleartarget [dead]")
		elseif class == "PALADIN" then
			EditMacro("WSxGen3",nil,nil,"#showtooltip\n/use [spec:1,@mouseover,help,nodead][spec:1]Light of the Martyr;[nocombat,noexists]Contemplation;[spec:2]Avenger's Shield;Blade of Justice\n/use [nocombat,noexists]Contemplation\n/targetenemy [noexists]\n/stopspelltarget\n/cleartarget [dead]")
		elseif class == "HUNTER" then
			EditMacro("WSxGen3",nil,nil,"#showtooltip\n/use [nocombat,noexists]Mrgrglhjorn;[spec:2,talent:2/2]Black Arrow;[spec:2]Bursting Shot;[spec:1,talent:2/3]Chimaera Shot;[spec:3]Flanking Strike;Cobra Shot;\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
		elseif class == "ROGUE" then
			EditMacro("WSxGen3",nil,nil,"/use [stance:0,nocombat]Stealth;[stance:0,combat,spec:3]Shadow Dance;[nostance:0,spec:3]Shadowstrike;[spec:2,talent:6/1]Cannonball Barrage;[spec:2,talent:6/3]Killing Spree;[spec:2]Between The Eyes;[talent:6/3]Exsanguinate;[talent:6/1]Toxic Blade;Mutilate;")
		elseif class == "PRIEST" then
			EditMacro("WSxGen3",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [exists,nocombat]Scarlet Confessional Book;[spec:3,@mouseover,harm,nodead][spec:3]Shadow Word: Death;[spec:2]Holy Word: Chastise;[spec:1]Rapture;\n/petattack\n/use Ivory Feather") 
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxGen3",nil,nil,"#showtooltip\n/use [nocombat,noexists]Sack of Spectral Spiders;[spec:3,talent:7/3]Soul Reaper;[spec:3]Scourge Strike;[spec:2,talent:7/3]Glacial Advance;[spec:2,talent:7/2]Breath of Sindragosa;[spec:2,talent:7/1]Obliteration;[spec:1]Marrowrend;\n/startattack")
		elseif class == "WARRIOR" then
			EditMacro("WSxGen3",nil,nil,"#showtooltip\n/use [spec:3]Revenge;Execute;\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
		elseif class == "DRUID" then
			EditMacro("WSxGen3",nil,nil,"#showtooltip\n/use [noexists,nocombat]Moonfeather Statue;[spec:3,talent:7/3,form:1]Pulverize;[spec:3,talent:7/2,form:1]Lunar Beam;[spec:4,talent:3/1,noform:4]Moonkin Form;[form:2]Rip;[nospec:1,talent:3/1][spec:1]Starsurge;Regrowth\n/targetenemy [noexists]")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxGen3",nil,nil,"#showtooltip\n/use [spec:1,talent:1/2][spec:2,talent:3/1] Felblade;[spec:2,talent:3/3]Fel Eruption;[spec:2]Demon Spikes;Throw Glaive;\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
		end
		
		-- shift+3, dots, flame shock etc
		if class == "SHAMAN" then
			EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/cleartarget [dead]\n/targetenemy [noexists]\n/use [nospec:2,@mouseover,harm,nodead,nomod][nospec:2,nomod]Flame Shock;Frostbrand\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Flame Shock\n/targetlasttarget") 
		elseif class == "MAGE" then
			EditMacro("WSxSGen+3",nil,nil,"/use [nocombat,noexists]Archmage Vargoth's Spare Staff;[notalent:6/1,spec:1]Evocation;[spec:3,talent:6/1]Frost Bomb;[spec:1,talent:6/1]Nether Tempest;[spec:2,talent:6/1]Living Bomb;\n/targetenemy [noexists]")
		end
		-- Warlock Shift+3
		if class == "WARLOCK" then
			if playerspec == 1 then
				EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead,nomod][nomod]Corruption\n/use Totem of Spirits\n/use [nocombat,noexists]Verdant Throwing Sphere\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Corruption\n/targetlasttarget")
			elseif playerspec == 2 then
				EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead,nomod][nomod]Doom\n/use Totem of Spirits\n/use [nocombat,noexists]Verdant Throwing Sphere\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Doom\n/targetlasttarget")
			else
				EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead,nomod][nomod]Immolate\n/use Totem of Spirits\n/use [nocombat,noexists]Verdant Throwing Sphere\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Immolate\n/targetlasttarget")
			end
		end

		if class == "MONK" then 
			EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/use [nocombat,noexists] Brewfest Pony Keg;[spec:2,talent:6/1]Refreshing Jade Wind;[spec:1,talent:3/2]Black Ox Brew;")
		elseif class == "PALADIN" then
			EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/use [spec:1,talent:2/3]Rule of Law;[spec:2,talent:6/1]Aegis of Light;[spec:1/2][spec:3,talent:1/3]Consecration;[spec:3,talent:1/2]Execution Sentence;\n/targetenemy [noexists]")
		elseif class == "HUNTER" then
			EditMacro("WSxSGen+3",nil,nil,"/use [nocombat,noexists]Everlasting Horde Firework;[spec:3]Lacerate;[spec:1,talent:7/1]Stampede;[spec:2,talent:7/2]Piercing Shot;Arcane Shot;\n/use Everlasting Darkmoon Firework\n/use Power Converter\n/use Pandaren Firework Launcher\n/startattack")
		elseif class == "ROGUE" then
			EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/use [spec:3]Nightblade;[spec:1]Rupture;Bribe;\n/targetenemy [noexists]")
		elseif class == "PRIEST" then
			EditMacro("WSxSGen+3",nil,nil,"/targetenemy [noexists]\n/stopspelltarget\n/cleartarget [dead]\n/use [@mouseover,harm,nodead,nospec:2][nomod,nospec:2]Shadow Word: Pain\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [nospec:2]Shadow Word: Pain\n/targetlasttarget")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/use [spec:2,talent:2/3]Horn of Winter;[spec:3,@mouseover,harm,nodead][spec:3]Outbreak;[spec:1,@mouseover,harm,nodead][spec:1]Death's Caress;[spec:2]Howling Blast;\n/targetenemy [noexists]\n/startattack\n/stopspelltarget")
		elseif class == "WARRIOR" then
			EditMacro("WSxSGen+3",nil,nil,"/use [talent:3/3]Avatar;[spec:1,talent:3/2]Rend;[spec:3]Demoralizing Shout;\n/startattack")
		end
		
		if class == "DRUID" then
			if playerspec == 1 then
				EditMacro("WSxSGen+3",nil,nil,"/use [noform:2]!Cat Form;[form:2]Rake;\n/use [nocombat]!Prowl;") 
			elseif playerspec == 2 then
				EditMacro("WSxSGen+3",nil,nil,"/use [noform:2]!Cat Form;[form:2]Rake;\n/use [nocombat]!Prowl;")
			elseif playerspec == 3 then
				EditMacro("WSxSGen+3",nil,nil,"/use Thrash\n/use [nocombat]!Prowl;")
			elseif playerspec == 4 then
				EditMacro("WSxSGen+3",nil,nil,"/use [spec:4,@mouseover,help,nodead][spec:4,@focus,help,nodead][spec:4]Lifebloom;")
			end
		end

		if class == "DEMONHUNTER" then
			EditMacro("WSxSGen+3",nil,nil,"#showtooltip\n/use [nocombat,noexists]Legion Pocket Portal;[@mouseover,harm,nodead,nomod][nomod]Throw Glaive\n/startattack\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Throw Glaive\n/targetlasttarget")
		end
		
		-- Ctrl+Shift+3
		if class == "SHAMAN" then
			EditMacro("WSxCSGen+3",nil,nil,"/use [nospec:2,@focus,harm,nodead]Flame Shock;[@party2,exists,nodead]Cleanse Spirit;[nocombat,noharm]Spirit Wand;\n/cleartarget [dead]\n/stopspelltarget")
		elseif class == "MAGE" then
			EditMacro("WSxCSGen+3",nil,nil,"#showtooltip\n/use [nocombat,noharm]Magical Saucer")
		elseif class == "WARLOCK" then
			EditMacro("WSxCSGen+3",nil,nil,"/use [spec:1,@focus,harm,nodead]Corruption;[spec:3,@focus,harm,nodead]Immolate;[spec:2,@focus,harm,nodead]Doom;Fel Petal;\n/targetenemy [noharm]\n/cleartarget [dead]")
		elseif class == "MONK" then
			EditMacro("WSxCSGen+3",nil,nil,"/use [@party2,exists,nodead]Detox;")
		elseif class == "PALADIN" then
			EditMacro("WSxCSGen+3",nil,nil,"/use [@party2,exists,nodead]Cleanse;")
		elseif class == "HUNTER" then
			EditMacro("WSxCSGen+3",nil,nil,"#showtooltip Exhilaration\n/use [@party2,exists,nodead]Roar of Sacrifice")
		elseif class == "ROGUE" then
			EditMacro("WSxCSGen+3",nil,nil,"")
		elseif class == "PRIEST" then
			EditMacro("WSxCSGen+3",nil,nil,"/use [spec:1/3,@focus,harm,nodead]Shadow Word: Pain;[@party2,exists,nodead]Power Word: Shield;[nocombat,noharm]Spirit Wand;\n/stopspelltarget")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noharm]Spirit Wand;[@focus,exists,harm,nodead,spec:3]Outbreak;[@focus,exists,harm,nodead,spec:2]Howling Blast;\n/stopspelltarget")
		elseif class == "WARRIOR" then
			EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Rend;Vrykul Toy Boat;")
		elseif class == "DRUID" then
			EditMacro("WSxCSGen+3",nil,nil,"/use [@party2,exists,nodead,spec:4]Nature's Cure;[@party2,exists,nodead]Remove Corruption")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Throw Glaive;Fel Petal;")
		end
		
		-- Macro for button 4, "4" "Hard"
		if class == "SHAMAN" then
			EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [spec:3,@mouseover,help,nodead][spec:3]Chain Heal;[spec:2]Flametongue;[spec:1,talent:7/3]Frost Shock;[spec:1,talent:5/3]Elemental Blast;[spec:1]Earth Shock;\n/targetenemy [noexists]\n/cleartarget [dead]")
		-- if class == "SHAMAN" then
		-- 	EditMacro("WSxGen4",nil,nil,"/use Empty Red Blossom Leek Container\n/use Empty Scallions Container\n/use Empty Striped Melon Container\n/use Empty White Turnip Container\n/use Empty Witchberries Container\n/use Empty Jade Squash Container\n/use Empty Juicycrunch Carrot Container")
		elseif class == "MAGE" then
			EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [nocombat,noexists]Memory Cube;[spec:3]Flurry;[spec:1]Arcane Missiles;[spec:2]Fireball;\n/targetenemy [noexists]\n/cleartarget [dead]")
		elseif class == "WARLOCK" then
			EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [nocombat,noexists]Crystalline Eye of Undravius;[spec:2]Hand of Gul'Dan;[spec:3]Chaos Bolt;[spec:1]Unstable Affliction;\n/targetenemy [noexists]\n/cleartarget [dead]")
		elseif class == "MONK" then
			EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [nocombat,noexists]Totem of Harmony;[spec:1]Keg Smash;Rising Sun Kick;\n/use Piccolo of the Flaming Fire\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
		elseif class == "PALADIN" then
			EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [nospec:2,help,nodead,nocombat]Holy Lightsphere;[spec:2,help,nodead,nocombat]Dalaran Disc;Judgment;\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
		end

		-- Hunter "Hard" "4" "hunter hard"
		if class == "HUNTER" then
			if playerspec == 1 then
				EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [noexists,nocombat]Puntable Marmot;[help,nodead]Dalaran Disc;[spec:1,@pettarget]Kill Command;\n/targetenemy [noexists]\n/startattack\n/cancelaura Aspect of the Turtle\n/cleartarget [dead]\n/petattack")
			elseif playerspec == 2 then
				EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [noexists,nocombat]Puntable Marmot;[help,nodead]Dalaran Disc;[spec:2]Marked Shot;\n/targetenemy [noexists]\n/startattack\n/cancelaura Aspect of the Turtle\n/cleartarget [dead]\n/petattack")
			else
				EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [noexists,nocombat]Puntable Marmot;[help,nodead]Dalaran Disc;[spec:3,talent:1/2]Throwing Axes;[spec:3]Raptor Strike;\n/targetenemy [noexists]\n/startattack\n/cancelaura Aspect of the Turtle\n/cleartarget [dead]\n/petattack")
			end
		end
		
		if class == "ROGUE" then
			EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [stance:0,nocombat]Stealth;[spec:2,stance:1/2/3]Ambush;[spec:2,talent:1/1]Ghostly Strike;[spec:3]Backstab;[spec:1]Mutilate;Pistol Shot\n/targetenemy [noexists]\n/cleartarget [dead]")
		elseif class == "PRIEST" then
			EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [spec:3]Mind Blast;[spec:2,@mouseover,help,nodead][spec:2]Holy Word: Serenity;[spec:1,@mouseover,help,nodead][spec:1]Penance;\n/targetenemy [noexists]\n/cancelaura Dispersion\n/cleartarget [dead]")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxGen4",nil,nil,"#showtooltip\n/targetlasttarget [spec:3,noexists,nocombat]\n/use [spec:3,harm,dead,nocombat]Corpse Explosion;[spec:1,talent:4/3]Tombstone;[spec:1,talent:4/1]Mark of Blood;[spec:1]Death Strike;[spec:2]Obliterate;[spec:3]Festering Strike;\n/startattack")
		elseif class == "WARRIOR" then
			EditMacro("WSxGen4",nil,nil,"#showtooltip\n/use [spec:1]Slam;[spec:2]Raging Blow;[spec:3]Shield Slam;\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
		end

		if class == "DRUID" then
			if playerspec == 1 then
				EditMacro("WSxGen4",nil,nil,"/use [talent:3/1,form:2]Rake;[talent:3/2,form:1]Thrash;[form:4,@mouseover,harm,nodead][]Lunar Strike;\n/targetenemy [noexists]\n/cleartarget [dead]")
			elseif playerspec == 2 then
				EditMacro("WSxGen4",nil,nil,"/use [talent:3/2,noform:1/2]Bear Form;[form:1/2]Thrash;[talent:3/1,noform:4]Moonkin Form;[talent:3/1,form:4]Lunar Strike;[talent:3/3,@mouseover,help,nodead][talent:3/3]Healing Touch;\n/targetenemy [noexists]\n/cleartarget [dead]")
			elseif playerspec == 3 then
				EditMacro("WSxGen4",nil,nil,"/use [form:1]Thrash;[talent:3/2,noform]!Cat Form;[talent:3/2,form:2]Rake;[talent:3/1,noform:4]Moonkin Form;[talent:3/1,form:4]Lunar Strike;[talent:3/3,@mouseover,help,nodead][talent:3/3]Healing Touch;\n/targetenemy [noexists]\n/cleartarget [dead]")
			elseif playerspec == 4 then
				EditMacro("WSxGen4",nil,nil,"/use [talent:3/2,form:2]Rake;[talent:3/3,form:1]Thrash;[@mouseover,talent:3/1,form:4,harm,nodead][talent:3/1,form:4]Lunar Strike;[@mouseover,help,nodead][]Healing Touch;\n/targetenemy [noexists]\n/cleartarget [dead]")
			end
		end

		if class == "DEMONHUNTER" then
			EditMacro("WSxGen4",nil,nil,"/use Eye Beam\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
		end
		
		-- Shift+4, talent macro keybind, often t90
		if class == "SHAMAN" then
			EditMacro("WSxSGen+4",nil,nil,"/use [noexists,nocombat]Sen'jin Spirit Drum;[spec:1,talent:5/3]Elemental Blast;[spec:1,talent:5/2,pet]Gale Force;[spec:1]Fire Elemental;[spec:2,talent:6/3]Sundering;[spec:2,talent:6/2]!Fury of Air;[spec:3,talent:6/2]Cloudburst Totem\n/targetenemy [noexists]")
		-- if class == "SHAMAN" then
		-- 	EditMacro("WSxSGen+4",nil,nil,"/use Empty Juicycrunch Carrot Container\n/use Empty Green Cabbage Container\n/use Empty Striped Melon Container")
		elseif class == "MAGE" then
			EditMacro("WSxSGen+4",nil,nil,"/use [spec:3,talent:7/2]Glacial Spike;[spec:3,talent:7/3]Comet Storm;[spec:2,talent:7/2]Cinderstorm;[spec:2,talent:7/3,@cursor]Meteor;[spec:1,talent:7/3]Arcane Orb;[spec:2,talent:4/2]Flame On;Polymorph\n/targetenemy [noharm]")
		elseif class == "WARLOCK" then
			EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noexists]\n/use [spec:1,nomod]Siphon Life;[spec:2,talent:7/1]Summon Darkglare;[spec:2,talent:2/3]Implosion;Phantom Singularity;\n/stopmacro [spec:2,nomod:alt]\n/targetlasttarget\n/use [spec:1]Siphon Life;[spec:3]Havoc;\n/targetlasttarget")
		elseif class == "MONK" then 
			EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/use [spec:2,talent:1/2]Zen Pulse;[talent:1/3]Chi Wave;[talent:1/1]Chi Burst;\n/stopspelltarget\n/targetenemy [noexists]")
		elseif class == "PALADIN" then
			EditMacro("WSxSGen+4",nil,nil,"#showtooltip [spec:1,talent:5/2]Holy Avenger;[spec:1,talent:5/3]Holy Prism; Blessing of Freedom;\n/use [spec:1,talent:5/2]Holy Avenger;[spec:1,talent:5/3]Holy Prism;\n/targetenemy [noexists]")
		elseif class == "HUNTER" then
			EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/use [spec:2,talent:4/1]Explosive Shot;[spec:2,talent:4/2,@cursor]Sentinel;[spec:3,talent:6/2]Dragonsfire Grenade;[nocombat,noexists]Adopted Puppy Crate;[spec:3,@player]Tar Trap;Misdirection;\n/use [noexists,nocombat]Leather Pet Bed\n/stopspelltarget")
		elseif class == "ROGUE" then
			EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/use [nocombat,noexists,nostealth]Hozen Beach Ball;[talent:7/2]Marked for Death;[talent:7/3]Death from Above;\n/targetenemy [noexists]\n/startattack [combat]\n/cleartarget [dead]")
		elseif class == "PRIEST" then
			EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [spec:3,noform]Shadowform;[spec:1,nomod]Schism;[@mouseover,harm,nodead][nomod]Vampiric Touch;\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Vampiric Touch\n/targetlasttarget")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/use [spec:1,nocombat,noexists]Krastinov's Bag of Horrors;[spec:2,talent:6/1]Frostscythe;[spec:1/3]Death and Decay;Obliterate;\n/startattack\n/cleartarget [dead]\n/targetenemy [noform]")
		elseif class == "WARRIOR" then
			EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/use [nospec:3,talent:2/1][spec:3,talent:1/1]Shockwave;[nospec:3,talent:2/2][spec:3,talent:1/2]Storm Bolt;Muradin's Favor;\n/startattack")
		end

		if class == "DRUID" then
			if playerspec == 1 then
				EditMacro("WSxSGen+4",nil,nil,"/use [spec:1,noform:4]Moonkin Form;[spec:1,talent:5/3]Stellar Flare; Charm Woodland Creature")
			elseif playerspec == 2 then
				EditMacro("WSxSGen+4",nil,nil,"/use [spec:2,noform:2]Cat Form;[spec:2]Tiger's Fury; Charm Woodland Creature")
			elseif playerspec == 3 then
				EditMacro("WSxSGen+4",nil,nil,"/use [spec:3,noform:1]Bear Form;[spec:3,talent:1/2]Bristling Fur; Charm Woodland Creature")
			elseif playerspec == 4 then
				EditMacro("WSxSGen+4",nil,nil,"/use [spec:4,talent:1/2]Cenarion Ward;[spec:4,talent:3/2,noform:2]!Cat Form;[spec:4,talent:3/2,form:2]Rake;Charm Woodland Creature\n/use [nocombat]!Prowl;")
			end
		end

		if class == "DEMONHUNTER" then
			EditMacro("WSxSGen+4",nil,nil,"#showtooltip\n/use [spec:1,talent:5/2]Fel Eruption;[spec:1,talent:5/3]Nemesis;[talent:4/2,spec:2]Fracture;Glide;\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
		end
		
		-- Macro "Ctrl+4" for button Ctrl+4, Extra Combat button. Verkar saknas en hel del binds till Ctrl+4? WTF?
		if class == "SHAMAN" then
			EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [talent:7/1]Ascendance;[spec:2,talent:7/3]Earthen Spike;[spec:3,talent:7/2]Wellspring;[spec:1,talent:7/3]Icefury;\n/use [nocombat,noexists] Gastropod Shell\n/use [nocombat,noexists] Tickle Totem")
		elseif class == "MAGE" then
			EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [nocombat,noexists]Faded Wizard Hat;[spec:1,talent:3/3]Evocation;[talent:3/1]Mirror Image;[talent:3/2]Rune of Power;\n/use [nocombat,noexists] Gastropod Shell;")
		elseif class == "WARLOCK" then -- PvP curses maybe?
			EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [nocombat,noexists] Gastropod Shell;[pvptalent:3/3]Curse of Fragility;[pvptalent:3/2]Curse of Weakness;[pvptalent:3/1]Curse of Tongues\n/targetenemy [noexists]\n/cleartarget [dead]")
		elseif class == "MONK" then
			EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/target [spec:1]Black Ox\n/use [spec:1,help,nodead]Provoke;[spec:1,@cursor]Summon Black Ox Statue;[spec:2,talent:6/3,@cursor]Summon Jade Serpent Statue;[spec:3]Storm, Earth, and Fire;\n/targetlasttarget [spec:1]\n/startattack")
		elseif class == "PALADIN" then
			EditMacro("WSxCGen+4",nil,nil,"/use [spec:1,@mouseover,help,nodead,talent:7/1][spec:1,talent:7/1]Beacon of Faith;[spec:1,@mouseover,help,nodead][spec:1]Beacon of Light;[spec:2,talent:7/2]Seraphim;[spec:3,talent:7/3]Holy Wrath;\n/targetenemy [noexists]\n/use Soul Evacuation Crystal")
		elseif class == "HUNTER" then
			EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [@pet,pet:Spirit Beast]Spirit Mend;[spec:3,talent:7/1]Spitting Cobra;\n/use [nocombat,noexists] Gastropod Shell")
		elseif class == "ROGUE" then
			EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [spec:1]Vendetta;[spec:2]Adrenaline Rush;Shadow Dance;\n/targetenemy [noexists,nocombat]\n/use [nocombat,noexists] Gastropod Shell")
		elseif class == "PRIEST" then
			EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [spec:2,talent:7/1]Apotheosis;[spec:2,talent:7/3]Circle of Healing;[spec:3,talent:7/3]Surrender to Madness;[spec:1,talent:5/2]Clarity of Will;[spec:1,talent:5/3]Shadow Covenant;Smite;\n/targetenemy [noexists]\n/cleartarget [dead]")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [spec:1,talent:7/1]Bonestorm;[spec:1,talent:7/2]Blood Mirror;[spec:1]Marrowrend;[spec:2]Empower Rune Weapon;[spec:3]Dark Transformation;\n/use [combat]Will of Northrend\n/startattack\n/use [nocombat,noexists] Gastropod Shell")
		elseif class == "WARRIOR" then
			EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use Battle Cry\n/use [nocombat]Tournament Favor\n/startattack\n/cleartarget [dead]\n/cancelaura Tournament Favor")
		elseif class == "DRUID" then
			EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [spec:1,talent:6/3]Blessing of the Ancients;[spec:1,talent:6/2]Astral Communion;[spec:2,talent:5/3]Savage Roar;[spec:4,@cursor]Efflorescence;[spec:3]Incapacitating Roar;Gastropod Shell;")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxCGen+4",nil,nil,"#showtooltip\n/use [spec:1,talent:7/1]Chaos Blades;[spec:1,talent:7/2]Fel Barrage;[spec:2,talent:7/2]Demonic Infusion;[spec:2,talent:7/3]Soul Barrier;[spec:1]Darkness;\n/targetenemy [noexists]\n/use [nocombat,noexists] Gastropod Shell\n/startattack")
		end
		
		-- Ctrl+Shift+4
		if class == "SHAMAN" then
			EditMacro("WSxCSGen+4",nil,nil,"")
		elseif class == "MAGE" then
			EditMacro("WSxCSGen+4",nil,nil,"/use Pink Gumball\n/stopspelltarget")
		elseif class == "WARLOCK" then
			EditMacro("WSxCSGen+4",nil,nil,"/use [spec:1,@focus,harm,nodead]Siphon Life\n/targetenemy [noharm]\n/cleartarget [dead]")
		elseif class == "MONK" then
			EditMacro("WSxCSGen+4",nil,nil,"")
		elseif class == "PALADIN" then
			EditMacro("WSxCSGen+4",nil,nil,"")
		elseif class == "HUNTER" then
			EditMacro("WSxCSGen+4",nil,nil,"#showtooltip Play Dead\n/run SetTracking(8,true);")
		elseif class == "ROGUE" then
			EditMacro("WSxCSGen+4",nil,nil,"")
		elseif class == "PRIEST" then
			EditMacro("WSxCSGen+4",nil,nil,"/use [spec:3,@focus,harm,nodead]Vampiric Touch")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxCSGen+4",nil,nil,"")
		elseif class == "WARRIOR" then
			EditMacro("WSxCSGen+4",nil,nil,"")
		elseif class == "DRUID" then
			EditMacro("WSxCSGen+4",nil,nil,"/run SetTracking(3,true);")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxCSGen+4",nil,nil,"")
		end
		
		-- Macro for button 5 "Dump" "5"
		if class == "SHAMAN" then
			EditMacro("WSxGen5",nil,nil,"/use [spec:1,mod:ctrl]Earth Elemental;[mod:ctrl,talent:5/2,@cursor]Earthen Shield Totem;[mod:ctrl,talent:5/1,@cursor]Ancestral Protection Totem;[spec:1]Earth Shock;[spec:2]Lava Lash;[@mouseover,help,nodead][]Healing Wave;\n/targetenemy [noexists]")
		-- if class == "SHAMAN" then
		-- 	EditMacro("WSxGen5",nil,nil,"/use Sack of Crocolisk Belly\n/use Sack of Emperor Salmon\n/use Sack of Wildfowl Breasts\n/use Sack of Raw Tiger Steaks\n/use Sack of Raw Turtle Meat\n/use Sack of Mushan Ribs\n/use Sack of Raw Crab Meat\n/use Sack of Krasarang Paddlefish")
		elseif class == "MAGE" then
			EditMacro("WSxGen5",nil,nil,"#showtooltip\n/targetenemy [noharm]\n/use [noexists,nocombat]Hearthstation;[spec:1]Arcane Barrage;[spec:2,@mouseover,harm,nodead][spec:2]Fire Blast;[spec:3,@mouseover,harm,nodead][spec:3]Ice Lance;\n/cleartarget [dead]")
		elseif class == "WARLOCK" then
			EditMacro("WSxGen5",nil,nil,"/use [mod:ctrl,@cursor]Summon Infernal;[nocombat,noexists]Fire-Eater's Vial;[spec:1,talent:4/1]Phantom Singularity;[spec:1,talent:7/2]Siphon Life;[spec:1]Corruption;[spec:3]Conflagrate;[spec:2,talent:1/2]Shadowflame;Shadow bolt;\n/targetenemy [noexists]")
		elseif class == "MONK" then
			EditMacro("WSxGen5",nil,nil,"/use [mod:ctrl,spec:1]Zen Meditation;[mod:ctrl,spec:2]Thunder Focus Tea; [noexists,nocombat]Brewfest Banner; Blackout Kick\n/targetenemy [noexists]\n/cleartarget [dead]")
		elseif class == "PALADIN" then
			EditMacro("WSxGen5",nil,nil,"/use [spec:2,mod:ctrl]Ardent Defender;[spec:1,mod:ctrl]Aura Mastery;[spec:3]Templar's Verdict;[spec:2,nocombat,noexists]Barrier Generator;[spec:2]Shield of the Righteous;[@mouseover,help,nodead][]Holy Light;\n/targetenemy [noexists]\n/cleartarget [dead]") 
		elseif class == "HUNTER" then
			EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [mod:ctrl]Exhilaration;[help,nodead]Silver-Plated Turkey Shooter;[spec:1]Cobra Shot;[spec:2]Arcane Shot;[spec:3]Mongoose Bite;\n/startattack\n/use [mod:ctrl] Skoller's Bag of Squirrel Treats\n/cleartarget [dead]\n/targetenemy [noexists]")
		elseif class == "ROGUE" then
			EditMacro("WSxGen5",nil,nil,"/use [mod:ctrl,spec:3,pvptalent:4/3]Smoke Bomb;[nocombat,nostealth,noexists]Autographed Hearthstone Card;[spec:1]Envenom;[spec:2]Run Through;Eviscerate;\n/targetenemy [noexists]\n/stopmacro [nomod:ctrl]\n/use [mod,combat]Mr. Smite's Brass Compass\n/roar")
		elseif class == "PRIEST" then
			EditMacro("WSxGen5",nil,nil,"/use [mod:ctrl]Fade;[spec:3,@mouseover,harm,nodead][spec:3]Void Eruption;[spec:2,@mouseover,help,nodead][spec:2]Heal;[spec:1,talent:5/2]Clarity of Will;[spec:1,@mouseover,help,nodead][spec:1]Plea;\n/targetenemy [noexists]")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [mod:ctrl,spec:3]Army of the Dead;[spec:1]Death Strike;[spec:2]Frost Strike;[@mouseover,harm,nodead][]Death Coil;\n/startattack\n/cleartarget [dead]") 
		elseif class == "WARRIOR" then
			EditMacro("WSxGen5",nil,nil,"/use [mod,spec:3]Last Stand;[mod]Commanding Shout;[spec:1,talent:1/2]Overpower;[spec:1,talent:6/3]Focused Rage;[spec:1]Slam;[spec:2]Furious Slash;[spec:3]Thunder Clap;\n/use [mod:ctrl]Gamon's Braid\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
		end

		if class == "DRUID" then
-- [talent:3/3,@mouseover,help,nodead][talent:3/3,help,nodead]Healing Touch;
			if playerspec == 1 then
				EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [mod:ctrl]Treant Form;[talent:3/1,form:2]Ferocious Bite;Solar Wrath;\n/targetenemy [noexists]\n/cleartarget [dead]")
-- [noform,talent:3/3]Healing Touch;			
			elseif playerspec == 2 then
				EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [mod:ctrl]Treant Form;[noform]!Cat Form;[form:2]Ferocious Bite;[form:1]Thrash;\n/targetenemy [noexists]\n/cleartarget [dead]")
-- [talent:3/3,help,nodead]Healing Touch;
			elseif playerspec == 3 then
				EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [mod:ctrl]Treant Form;[noform]Bear Form;[talent:3/2,form:2]Ferocious Bite;[form:1]Maul;\n/targetenemy [noexists]\n/cleartarget [dead]")
			elseif playerspec == 4 then
				EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [spec:4,mod:ctrl]!Incarnation: Tree of Life;[mod:ctrl]Treant Form;[talent:3/2,form:2]Ferocious Bite;Solar Wrath;\n/targetenemy [noexists]\n/cleartarget [dead]")
			end
		end

		if class == "DEMONHUNTER" then
			EditMacro("WSxGen5",nil,nil,"#showtooltip\n/use [spec:2,mod:ctrl]Metamorphosis;[mod:ctrl]Darkness;[spec:1]Chaos Strike;[spec:2]Soul Cleave;\n/startattack\n/cleartarget [spec:1,talent:2/2]\n/targetenemy [noexists]")
		end
		
		-- Shift+5
		if class == "SHAMAN" then
			EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/use [spec:3,combat]Healing Stream Totem;Deceptia's Smoldering Boots\n/run local z=IsEquippedItem(\"Roots of Shaladrassil\");if not z then UseEquipmentSet(\"HPants\") end\n/equipset [spec:1]Noon!;[spec:2]DoubleGate;Menkify!;")
		elseif class == "MAGE" then
			EditMacro("WSxSGen+5",nil,nil,"/targetenemy [noharm]\n/use [spec:1,talent:4/2]Charged Up;[spec:2,talent:4/2]Flame On;Kalec's Image Crystal;\n/use Kalec's Image Crystal")
		elseif class == "WARLOCK" then
			EditMacro("WSxSGen+5",nil,nil,"#showtooltip Summon Doomguard\n/clearfocus [@focus,dead]\n/focus [@focus,noexists,nodead,noharm,nomod]target\n/targetenemy")
		elseif class == "MONK" then 
			EditMacro("WSxSGen+5",nil,nil,"#showtooltip [noexists,nocombat]Displacer Meditation Stone;[spec:2] Thunder Focus Tea\n/clearfocus [@focus,dead]\n/focus [@focus,noexists,nodead,noharm,nomod] target\n/targetenemy [nomod]\n/use [noexists,nocombat]Displacer Meditation Stone")
		elseif class == "PALADIN" then
			EditMacro("WSxSGen+5",nil,nil,"#showtooltip [nospec:3] Blessing of Sacrifice; Blessing of Freedom;\n/use [spec:1,@player]Holy Shock\n/use [nocombat,noexists]Light in the Darkness")
		elseif class == "HUNTER" then
			EditMacro("WSxSGen+5",nil,nil,"#showtooltip [nocombat]The SHadow Hunter's Voodoo Mask;Play Dead\n/run local zigi = IsEquippedItem(\"The Shadow Hunter's Voodoo Mask\"); if not zigi then UseEquipmentSet(\"SHHeal\") end\n/use Feign Death\n/equipset [spec:1]Noon!;[spec:2]DoubleGate;Menkify!;")
		elseif class == "ROGUE" then
			EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/use [spec:3]Shadow Dance;[spec:2]Roll the Bones;Titanium Seal of Dalaran;\n/use [nocombat,nostealth]Titanium Seal of Dalaran")
		elseif class == "PRIEST" then
			EditMacro("WSxSGen+5",nil,nil,"#showtooltip\n/focus target [@focus,noexists,nomod]\n/cleartarget [dead]\n/clearfocus [dead]\n/use [spec:2,talent:4/3]Symbol of Hope;[nocombat,noexists]Soul Evacuation Crystal;[spec:2]Mass Dispel;[spec:1,@player]Penance;Voidform;")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxSGen+5",nil,nil,"/use [nocombat,noexists][spec:2]Haunting Memento;[spec:1,talent:2/2]Soulgorge;[spec:3]Blighted Rune Weapon;\n/startattack")
		elseif class == "WARRIOR" then
			EditMacro("WSxSGen+5",nil,nil,"/use [spec:2,talent:6/1]Bloodbath;[nospec:2,talent:7/3]Ravager;[spec:1]Bladestorm;\n/startattack")
		elseif class == "DRUID" then
			EditMacro("WSxSGen+5",nil,nil,"/use [spec:1,talent:1/1]Force of Nature;[spec:1,talent:1/2]Warrior of Elune;[spec:2,talent:6/3]Elune's Guidance;[spec:4]Ironbark;Charm Woodland Creature;")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxSGen+5",nil,nil,"/use [spec:2,@player] Infernal Strike")
		end
		
		-- Ctrl+Shift+5, Also #showtooltip
		if class == "SHAMAN" then
			EditMacro("WSxCSGen+5",nil,nil,"/clearfocus")
		elseif class == "MAGE" then
			EditMacro("WSxCSGen+5",nil,nil,"#showtooltip Ice Block")
		elseif class == "WARLOCK" then
			EditMacro("WSxCSGen+5",nil,nil,"/use [spec:1,@focus,harm,nodead]Siphon Life\n/targetenemy [noharm]\n/cleartarget [dead]")
		elseif class == "MONK" then
			EditMacro("WSxCSGen+5",nil,nil,"/clearfocus")
		elseif class == "PALADIN" then
			EditMacro("WSxCSGen+5",nil,nil,"/clearfocus")
		elseif class == "HUNTER" then
			EditMacro("WSxCSGen+5",nil,nil,"/run SetTracking(2,true);SetTracking(3,true);SetTracking(4,true);SetTracking(5,true);SetTracking(6,true);SetTracking(9,true);SetTracking(10,true);")
		elseif class == "ROGUE" then
			EditMacro("WSxCSGen+5",nil,nil,"/clearfocus")
		elseif class == "PRIEST" then
			EditMacro("WSxCSGen+5",nil,nil,"/clearfocus")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxCSGen+5",nil,nil,"#showtooltip [spec:3]Army of the Dead;[spec:2,talent:6/1]Frostscythe;[spec:1,talent:7/1]Bonestorm;[spec:1,talent:7/2]Blood Mirror;Blood Boil;\n/clearfocus")
		elseif class == "WARRIOR" then
			EditMacro("WSxCSGen+5",nil,nil,"/clearfocus")
		elseif class == "DRUID" then
			EditMacro("WSxCSGen+5",nil,nil,"#showtooltip [spec:4]Tranquility;[spec:1]Celestial Alignment;[spec:2]Berserk;[spec:3,talent:5/2]Incarnation:Guardian of Ursoc;\n/clearfocus\n/run SetTracking(2,true);SetTracking(4,true);")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxCSGen+5",nil,nil,"/clearfocus")
		end
		
		-- Macro for button 6, "6" "AE"
		if class == "SHAMAN" then
			EditMacro("WSxGen6",nil,nil,"#showtooltip\n/use [mod:ctrl,spec:2]Feral Spirit;[mod:ctrl,spec:3]Spiritwalker's Grace;[mod:ctrl]Fire Elemental;[spec:2]Crash Lightning;[spec:3,@cursor]Healing Rain;[@mouseover,harm,nodead][]Chain Lightning;\n/targetenemy [noexists]\n/cleartarget [dead]")
		-- if class == "SHAMAN" then
		-- 	EditMacro("WSxGen6",nil,nil,"/use Sack of Jade Lungfish\n/use Sack of Giant Mantis Shrimp\n/use Sack of Redbelly Mandarin\n/use Sack of Reef Octopus")
		elseif class == "MAGE" then
			EditMacro("WSxGen6",nil,nil,"#showtooltip\n/use [spec:3,mod:ctrl]Icy Veins;[spec:1,mod:ctrl]Arcane Power;[spec:2,mod:ctrl]Combustion;[spec:3,@cursor]Blizzard;[spec:1]Arcane Explosion;[spec:2,@cursor]Flamestrike;/stopspelltarget [spec:2]")
		elseif class == "WARLOCK" then
			EditMacro("WSxGen6",nil,nil,"#showtooltip\n/use [mod:ctrl]Summon Doomguard; [spec:1] Seed of Corruption; [spec:2] Demonwrath; [spec:3] Rain of Fire;\n/targetenemy [noexists]")
		elseif class == "MONK" then
			EditMacro("WSxGen6",nil,nil,"#showtooltip [spec:3]Fists of Fury;[spec:1]Breath of Fire;[spec:2]Vivify;\n/use [spec:3,mod:ctrl] Storm, Earth, and Fire;[spec:1]Breath of Fire;!Spinning Crane Kick;")
		elseif class == "PALADIN" then
			EditMacro("WSxGen6",nil,nil,"#showtooltip\n/use [spec:2,mod:ctrl,talent:6/1]Aegis of Light;[spec:3]Divine Storm;[spec:1]Light of Dawn;[spec:2]Consecration;\n/use [mod:ctrl] 19\n/targetenemy [noexists]")
		elseif class == "HUNTER" then
			EditMacro("WSxGen6",nil,nil,"#showtooltip\n/use [spec:1,mod:ctrl]Bestial Wrath;[spec:3,mod:ctrl]Aspect of the Eagle;[spec:2,mod:ctrl]Trueshot;[spec:3]Carve;[@mouseover,harm,nodead][]Multi-Shot;\n/startattack [nomod]")
		elseif class == "ROGUE" then
			EditMacro("WSxGen6",nil,nil,"#showtooltip\n/use [spec:1,mod:ctrl]Vendetta;[spec:2,mod:ctrl]Adrenaline Rush;[spec:3,mod:ctrl]Shadow Blades;[spec:1]Fan of Knives;[spec:2]!Blade Flurry;[spec:3]Shuriken Storm;")
		elseif class == "PRIEST" then
			EditMacro("WSxGen6",nil,nil,"#showtooltip\n/use [mod:ctrl]Divine Hymn;[nospec:3,talent:6/2]Divine Star;[nospec:3,talent:6/3]Halo;[spec:2]Holy Nova;[spec:3,talent:7/2]Shadow Crash;Shadowfiend;\n/targetenemy [noexists]\n/petattack")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxGen6",nil,nil,"#showtooltip\n/use [spec:2,mod:ctrl]Pillar of Frost;[spec:3,mod:ctrl]Summon Gargoyle;[spec:1]Heart Strike;[spec:3,talent:2/1]Epidemic;[spec:3]Death and Decay;[spec:2]Remorseless Winter\n/use [mod:ctrl] Angry Beehive")
		elseif class == "WARRIOR" then
			EditMacro("WSxGen6",nil,nil,"#show [spec:3]Thunder clap;Whirlwind;\n/use [spec:2,talent:7/1,mod:ctrl][spec:1,mod:ctrl]Bladestorm;[spec:3,talent:7/3,mod:ctrl]Ravager;[nospec:3]Whirlwind;[spec:3]Thunder Clap;\n/startattack\n/use [mod:ctrl] Arena Master's War Horn")
		elseif class == "DRUID" then
			EditMacro("WSxGen6",nil,nil,"/use [spec:2,mod]Berserk;[spec:1,mod]Celestial Alignment;[spec:4,mod]Tranquility;[mod,talent:5/2]Incarnation: Guardian of Ursoc;[spec:2,noform:1/2]Cat form;[spec:3,noform:1/2]Bear form;[form:1/2]Swipe;[spec:4]Wild Growth;[spec:1,@cursor]Starfall;")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxGen6",nil,nil,"#showtooltip\n/targetlasttarget [noexists,nocombat]\n/use [mod:ctrl] Metamorphosis;[harm,dead,nocombat,nomod]Soul Inhaler;Blade Dance;\n/targetenemy [noexists]")
		end
		
		-- Shift+6
		if class == "SHAMAN" then
			EditMacro("WSxSGen+6",nil,nil,"/use [spec:2,talent:6/2]Fury of Air;[spec:3]Healing Tide Totem;[spec:1,talent:6/1,@cursor]Liquid Magma Totem;[spec:1,talent:6/2,nopet]Fire Elemental;[spec:1,talent:6/2,pet]Gale Force;[spec:1,@player]Earthquake;\n/use [nocombat,noexists] Lava Fountain;")
		elseif class == "MAGE" then
			EditMacro("WSxSGen+6",nil,nil,"/use [nocombat,noexists] Mystical Frosh Hat;[spec:2,talent:7/3]Meteor;[spec:3,@player]Blizzard;")
		elseif class == "WARLOCK" then
			EditMacro("WSxSGen+6",nil,nil,"#showtooltip\n/use [spec:3,talent:7/2]Channel Demonfire;[spec:2,nopet]Summon Felguard;[spec:2,pet]!Command Demon;\n/stopmacro [pet,alive]\n/run PetDismiss();")
		elseif class == "MONK" then
			EditMacro("WSxSGen+6",nil,nil,"/targetenemy [spec:3]\n/use [noexists,nocombat,nospec:2]\"Purple Phantom\" Contender's Costume;[@mouseover,spec:3,harm,nodead][spec:3]Fists of Fury;[@mouseover,spec:2,harm,nodead][spec:2]Vivify;\n/stopmacro [combat][spec:2]\n/click ExtraActionButton1",1,1)
		elseif class == "PALADIN" then
			EditMacro("WSxSGen+6",nil,nil,"#showtooltip Divine Shield\n/use [spec:1,notalent:5/3,talent:1/2,@player]Light's Hammer;[spec:1,talent:5/3,@player]Holy Prism;")
		elseif class == "HUNTER" then
			EditMacro("WSxSGen+6",nil,nil,"#showtooltip\n/use [spec:2]Bursting Shot;[spec:3,@cursor]Explosive Trap;[nocombat,noexists]Fetch Ball;")
		elseif class == "ROGUE" then
			EditMacro("WSxSGen+6",nil,nil,"#showtooltip\n/cancelaura Blade Flurry\n/use Sticky Bombs\n/use [spec:3,stance:0,combat]Shadow Dance;[spec:3,stance:0,nocombat]Stealth;[spec:3]Shuriken Storm;\n/use [nostealth,spec:2,nocombat]Ghostly Iron Buccaneer's Hat")
		elseif class == "PRIEST" then
			EditMacro("WSxSGen+6",nil,nil,"#showtooltip\n/use [@mouseover,help,nodead,spec:2][spec:2]Prayer of Healing;[@mouseover,help,nodead,spec:1][spec:1]Power Word: Radiance;[exists,nodead]Shadowfiend;\n/use Battle Standard of Coordination\n/use Cursed Feather of Ikzan")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxSGen+6",nil,nil,"#showtooltip [spec:2,talent:4/2]Blinding Sleet;[spec:3,talent:4/1]Smash;[spec:1][talent:4/2]Asphyxiate;\n/use [spec:1/3,@player]Death and Decay;\n/stopspelltarget")
		elseif class == "WARRIOR" then
			EditMacro("WSxSGen+6",nil,nil,"#showtooltip\n/use [spec:3]Shield Block;[spec:1]Cleave;\n/targetenemy [noexists]\n/startattack")
		elseif class == "DRUID" then
			EditMacro("WSxSGen+6",nil,nil,"#show [spec:1]Celestial Alignment;[spec:2]Berserk;[spec:3,talent:5/2]Incarnation: Guardian of Ursoc;[spec:4,talent:5/2]Incarnation: Tree of Life(Talent, Shapeshift);Kaldorei Wind Chimes;\n/use [@player,spec:1]Starfall;Wild Growth;\n/use Kaldorei Wind Chimes")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxSGen+6",nil,nil,"/use [spec:2,@player]Sigil of Flame\n/stopspelltarget")
		end
		
		-- Macro for button 7 "7"
		if class == "SHAMAN" then
			if race == "Orc" then
				EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [mod:shift]Blood fury;[spec:2]Frostbrand;[spec:1,@cursor]Earthquake;Chain Lightning;\n/startattack\n/use Bom'bay's Color-Seein' Sauce\n/use [noexists,nocombat]Moonfang's Paw")
			elseif race == "Troll" then
				EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [mod:shift]Berserking;[spec:2]Frostbrand;[spec:1,@cursor]Earthquake;Chain Lightning;\n/startattack\n/use Bom'bay's Color-Seein' Sauce\n/use [noexists,nocombat]Moonfang's Paw")
			end
		end

		if class == "MAGE" then
			EditMacro("WSxGen7",nil,nil,"#show\n/use [nocombat,noexists]Pilfered Sweeper;[spec:2,talent:2/2]Blast Wave;[spec:1,talent:4/1]Supernova;[spec:1,talent:4/2]Charged up;[spec:3,talent:4/1]Ice Nova;[spec:3,talent:4/2]Frozen Touch;[spec:2]Flamestrike;[spec:1]Arcane Explosion;Cone of Cold;")
		elseif class == "WARLOCK" then
			EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [nopet,mod:shift]Summon Imp;[mod:shift]Flee;[spec:2,talent:2/3]Implosion;[spec:3,talent:2/2]Cataclysm;[nospec:2,talent:2/3]Mana Tap;Life tap;")
		elseif class == "MONK" then
			EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [spec:1]Ironskin Brew;[spec:2,talent:6/2]Invoke Chi-Ji, the Red Crane;[spec:3,talent:6/2]Invoke Xuen, the White Tiger;[spec:2,talent:6/1]Refreshing Jade Wind;[talent:6/1]Rushing Jade Wind;Spinning Crane Kick")
		elseif class == "PALADIN" then
			EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [mod:shift,talent:5/1]Holy Avenger;[nospec:3]Consecration;Crusader Strike;\n/targetenemy [noexists]")
		elseif class == "HUNTER" then
			EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [nocombat,noexists]Fireworks;[spec:1]Aspect of the Wild;[spec:3,talent:1/2]Throwing Axes;[spec:2]Bursting Shot;[spec:3,@player]Explosive Trap;\n/use Will of Northrend\n/use Bom'bay's Color-Seein' Sauce;")
		elseif class == "ROGUE" then
			EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [mod:shift] Barrel of Bandanas\n/use [mod:shift]Barrel of Eyepatches\n/use [nostealth,noexists,nomod] Worn Troll Dice;[spec:2,nomod]Between The Eyes;[spec:3,nomod]Shadow Blades;Feint;")
		elseif class == "PRIEST" then
			EditMacro("WSxGen7",nil,nil,"/use [mod:shift]Crate of Bobbers: Squeaky Duck;[spec:2,@cursor]Holy Word: Sanctify;[spec:3,talent:6/1][spec:1,talent:7/1]Power Infusion;[spec:1,talent:7/3]Evangelism;[noexists,nocombat]Romantic Picnic Basket;[spec:3,nochanneling]Void Eruption;Languages")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [spec:3,nopet]Raise Dead\n/use [nocombat,noexists]Champion's Salute;[spec:3,pet]Dark Transformation;[spec:2]Pillar of Frost;Blood Boil;\n/use [nocombat]Permanent Frost Essence\n/use [nocombat]Stolen Breath\n/stopspelltarget")
		elseif class == "WARRIOR" then
			EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [spec:1,talent:6/3]Focused Rage;[spec:2,talent:7/3]Dragon Roar;[spec:2,talent:7/1]Bladestorm;[nospec:2,talent:7/3,@player]Ravager;[spec:3]Ignore Pain;[]Whirlwind;\n/startattack\n/roar\n/use Mote of Light\n/use World Shrinker")
		elseif class == "DRUID" then
			EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [spec:1,talent:7/1]Fury of Elune;[spec:4,talent:7/3]Flourish;[spec:4,talent:3/2,noform:2]!Cat Form;[form:2,spec:4,talent:3/2]Swipe;[nocombat,noexists]Spirit of Bashiok;Barkskin;")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxGen7",nil,nil,"#showtooltip\n/use [nocombat,noexists]Golden Hearthstone Card: Lord Jaraxxus;Throw Glaive\n/targetenemy [noexists]")
		end
		
		-- Macro "QQ" for button Q, used for Interrupts
		if class == "SHAMAN" then
			EditMacro("WSxQQ",nil,nil,"/stopcasting [nomod:alt]\n/use [mod:alt,@focus,harm,nodead]Hex;[help]Foot Ball;[nocombat,noexists]The Golden Banana;[@mouseover,harm,nodead][]Wind shear;")
		elseif class == "MAGE" then
			EditMacro("WSxQQ",nil,nil,"#showtooltip\n/stopcasting [nomod]\n/use [mod:alt,@focus,harm,nodead]Polymorph;[mod:shift]Winning Hand;[@mouseover,harm,nodead][]Counterspell\n/use [mod:shift]Ice Block;")
		elseif class == "WARLOCK" then
			EditMacro("WSxQQ",nil,nil,"#showtooltip\n/cancelaura [mod:shift] Demonic Circle\n/stopcasting [nomod,nopet]\n/use [@focus,mod:alt,harm,nodead]Fear;[mod:shift]Demonic Circle;Command Demon;")
		elseif class == "MONK" then
			EditMacro("WSxQQ",nil,nil,"#showtooltip\n/use [mod:alt,@focus,harm,nodead][nomod,spec:2,exists,nodead]Paralysis;[mod:shift]Transcendence;[nocombat,noexists]The Golden Banana;[@mouseover,harm,nodead][]Spear Hand Strike;")
		elseif class == "PALADIN" then
			EditMacro("WSxQQ",nil,nil,"/use [mod:alt,@focus,harm,nodead][nomod,spec:1,talent:3/1]Hammer of Justice;[mod:shift]Divine Shield;[spec:2,@mouseover,harm,nodead]Avenger's Shield;[spec:1,talent:3/2]Repentance;[spec:1,talent:3/3]Blinding Light;[spec:3,@mouseover,harm,nodead][]Rebuke;")
		elseif class == "HUNTER" then
			EditMacro("WSxQQ",nil,nil,"/stopcasting [nomod:alt]\n/use [mod:alt,@focus,harm,nodead]Stopping Power;[noexists,noharm]The Golden Banana;[spec:3,@mouseover,harm,nodead][spec:3]Muzzle;[@mouseover,harm,nodead][]Counter shot;")
		elseif class == "ROGUE" then
			EditMacro("WSxQQ",nil,nil,"#showtooltip\n/use [mod:alt,@focus,harm,nodead]Blind;[mod:shift]Cloak of Shadows;[spec:2,nocombat,noexists]Rime of the Time-Lost Mariner;[@mouseover,harm,nodead][]Kick;\n/use [nocombat,noexists]Ravenbear Disguise")
		elseif class == "PRIEST" then
			EditMacro("WSxQQ",nil,nil,"/use [mod:alt,@focus,harm,nodead]Mind Control;[nospec:3,talent:3/1,nomod]Shining Force;[spec:2]Holy Word: Chastise;[spec:3,@mouseover,harm,nodead][spec:3]Silence;Mind Control;")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxQQ",nil,nil,"/use [mod:alt,@focus,harm,nodead]Asphyxiate;[@mouseover,harm,nodead][]Mind Freeze;")
		elseif class == "WARRIOR" then
			EditMacro("WSxQQ",nil,nil,"#showtooltip Pummel\n/use [mod:alt,@focus,exists,nodead]Storm Bolt;[mod:shift]Berserker Rage;[@mouseover,harm,nodead]Charge;\n/use [@mouseover,harm,nodead][]Pummel;")
		elseif class == "DRUID" then
			EditMacro("WSxQQ",nil,nil,"/use [mod:alt,@focus,harm,nodead]Cyclone;[spec:4]Ursol's Vortex;[spec:2,noform:1/2]Cat Form;[spec:3,noform:1/2]Bear Form;[@mouseover,harm,nodead,spec:2/3,form:1/2][spec:2/3,form:1/2]Skull Bash;[@mouseover,harm,nodead][]Solar Beam;")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxQQ",nil,nil,"/use [mod:alt,@focus,harm,nodead]Imprison;[@mouseover,harm,nodead][]Consume Magic")
		end
		
		-- Macro "Stuns" for button E, used for Stuns, "E". 
		if class == "SHAMAN" then
			EditMacro("WSxStuns",nil,nil,"/use [mod:alt,spec:3,@player]Healing Rain;[talent:3/1,@cursor]Lightning Surge Totem;[talent:3/2,@cursor]Earthgrab Totem;[talent:3/3,@cursor]Voodoo Totem;")
		elseif class == "MAGE" then
			EditMacro("WSxStuns",nil,nil,"#showtooltip\n/use [nocombat,noexists]Personal Hologram;[talent:5/2,@player]Ring of Frost;Frost Nova;")
		elseif class == "WARLOCK" then
			EditMacro("WSxStuns",nil,nil,"/use [spec:1,talent:3/3]Howl of Terror;[talent:3/3]Shadowfury;[talent:3/2]Mortal Coil;Fear;\n/use [nocombat,noexists] Orb of the Sin'Dorei") 
		elseif class == "MONK" then
			EditMacro("WSxStuns",nil,nil,"#showtooltip\n/use [nomod,spec:2]Soothing Mist;[nomod,spec:3]Flying Serpent Kick;[spec:1,talent:4/2]Summon Black Ox Statue;[spec:2,talent:4/2]Song of Chi-Ji;[talent:4/3]Leg Sweep;Ring of Peace\n/use [nomod,spec:2,pvptalent:4/3]Soothing Mist(Honor Talent)")
		elseif class == "PALADIN" then
			EditMacro("WSxStuns",nil,nil,"#showtooltip Hammer of Justice\n/use [mod:alt,talent:3/2,@focus,exists,nodead]Repentance;[mod:alt]Blinding Light;[nospec:1]Hammer of Justice;[@mouseover,help,nodead][]Holy Light;")
		elseif class == "HUNTER" then
			EditMacro("WSxStuns",nil,nil,"#showtooltip\n/use [mod:alt,@cursor]Flare;[spec:3,exists,nodead]Harpoon;[@cursor]!Stopping Power;\n/targetenemy [noexists]\n/startattack [combat]\n/cleartarget [dead]")
		elseif class == "ROGUE" then
			EditMacro("WSxStuns",nil,nil,"/use [stance:0,combat,spec:3]Shadow Dance;[stance:0,combat,nospec:3]Vanish;[stance:0,nocombat]Stealth;[stance:1/2/3][]Cheap Shot;\n/use [nostealth,spec:2,nocombat]Iron Buccaneer's Hat") 
		elseif class == "PRIEST" then
			EditMacro("WSxStuns",nil,nil,"#show\n/use [mod:alt]Mass Dispel;[spec:3,@mouseover,harm,nodead][spec:3]Psychic Scream;[nospec:3]Leap of Faith;\n/use [nomod] Orb of the Sin'Dorei\n/use [nomod,nocombat,noexists] Leather Love Seat")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxStuns",nil,nil,"#showtooltip\n/use [mod:alt,spec:2]Blinding Sleet;[@focus,mod:alt,harm,nodead,pet]Gnaw;[@mouseover,harm,nodead][]Death Grip;\n/startattack\n/petattack [mod:alt,@focus,exists,nodead]")
		elseif class == "WARRIOR" then
			EditMacro("WSxStuns",nil,nil,"/use [noexists,nocombat]Arena Master's War Horn;[@mouseover,harm,nodead][]Charge;\n/startattack\n/cleartarget [dead][help]\n/targetenemy [noharm]")
		elseif class == "DRUID" then
			EditMacro("WSxStuns",nil,nil,"#showtooltip\n/use [talent:2/3,help,nodead,noform][talent:2/3,form:1/2]Wild Charge\n/use [spec:2,talent:5/2][nocombat]!Prowl;[combat,noform:1/2]Bear Form;\n/targetenemy [noexists]\n/cancelform [help,nodead]")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxStuns",nil,nil,"#showtooltip\n/use [mod:alt] !Spectral Sight; [spec:2,@cursor]Sigil of Silence; [spec:1]Chaos Nova;")
		end
		
		-- Macro "RTS" for button R, used for roots.
		if class == "SHAMAN" then
			EditMacro("WSxRTS",nil,nil,"#show Earthbind Totem\n/use [mod:alt]MOLL-E;[mod:shift,@cursor]Earthbind Totem;[spec:2,@mouseover,talent:2/2,harm,nodead]Feral Lunge;[spec:2]Frostbrand;[spec:3]Spirit Link Totem;[spec:1]Frost Shock\n/targetenemy [noharm]\n/cleartarget [dead]")
		elseif class == "MAGE" then
			EditMacro("WSxRTS",nil,nil,"/use [spec:1,mod:alt,@focus,exists,nodead]Slow;[mod:alt]MOLL-E;[spec:3,mod,nopet]Summon Water Elemental;[spec:3,mod]Freeze;[spec:2,mod,@player]Flamestrike;[spec:3]Cone of Cold;[spec:2]Dragon's Breath;Slow;\n/stopmacro [@pet,nodead]\n/script PetDismiss();")
		elseif class == "WARLOCK" then
			EditMacro("WSxRTS",nil,nil,"/use [mod:ctrl,nopet]Summon Succubus;[mod:alt,@focus,harm,nodead,pet][@mouseover,harm,nodead,pet:doomguard][pet:doomguard]Cripple;[nomod]Command Demon;\n/targetenemy [noharm]\n/use [mod:alt,nocombat]Moll-E;[mod:ctrl,talent:6/2]Grimoire: Succubus")
		elseif class == "MONK" then
			EditMacro("WSxRTS",nil,nil,"#show\n/use [mod:shift,spec:2]Transcendence;[mod:alt,spec:3,@focus,harm,nodead][spec:3,nomod]Disable;[mod:alt]MOLL-E;[mod:ctrl,@player][@mouseover,help,nodead][help,nodead]Tiger's Lust;[mod:shift][nospec:3]Crackling Jade Lightning;\n/targetenemy [noexists]")
		elseif class == "PALADIN" then
			EditMacro("WSxRTS",nil,nil,"#showtooltip [spec:3] Hand of Hindrance; Blessing of Freedom;\n/use [mod:alt]MOLL-E;[mod:ctrl]Divine Steed;[@mouseover,help,nodead][help,nodead]Blessing of Freedom;[spec:3,@mouseover,harm,nodead][spec:3,harm,nodead]Hand of Hindrance;")
		elseif class == "HUNTER" then
			EditMacro("WSxRTS",nil,nil,"/targetenemy [noharm]\n/use [mod:alt,@focus,harm,nodead][nospec:3,nomod]Concussive Shot;[mod:alt]MOLL-E;[mod:ctrl,nopet]Call Pet 3;[mod:shift,@cursor]Tar Trap;Wing Clip\n/stopmacro [nomod:ctrl]\n/target pet\n/use [mod:ctrl]Crab Shank\n/targetlasttarget")
		elseif class == "ROGUE" then
			EditMacro("WSxRTS",nil,nil,"/use [mod:alt,@focus,spec:2,harm,nodead][nomod,spec:2]Pistol Shot;[mod:alt]MOLL-E;[@mouseover,help,nodead,nospec:2][nospec:2,help,nodead]Shadowstep;[spec:3]Shuriken Toss;[spec:1]Poisoned Knife;\n/targetenemy [noexists]")
		elseif class == "PRIEST" then
			EditMacro("WSxRTS",nil,nil,"/use [mod:alt]MOLL-E;[mod:shift,spec:1]Psychic Scream;[mod:ctrl,nospec:3,talent:2/1,@player][nospec:3,talent:2/1,@cursor]Angelic Feather;[spec:2,talent:2/2]Body and Mind;[mod:ctrl,@player][@mouseover,help,nodead][]Power Word: Shield\n/stopspelltarget")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxRTS",nil,nil,"#showtooltip \n/use [mod:ctrl,spec:1,@player][spec:1,nomod:alt]Gorefiend's Grasp;[mod:alt,@focus,harm,nodead][nomod,@mouseover,harm,nodead][nomod]Chains of Ice;[mod:alt]MOLL-E;[mod:ctrl]Wraith Walk;\n/targetenemy [noexists]")
		elseif class == "WARRIOR" then
			EditMacro("WSxRTS",nil,nil,"/use [mod:alt,spec:1,@focus,harm,nodead][spec:1,nomod]Hamstring;[mod:alt]MOLL-E;[spec:2,mod:shift]Piercing Howl;[@mouseover,help,nodead]Charge;[@mouseover,harm,nodead][]Heroic Throw;\n/startattack")
		elseif class == "DRUID" then
			EditMacro("WSxRTS",nil,nil,"/cancelform [talent:2/3,form,@mouseover,help,nodead]\n/use [mod:alt]MOLL-E;[spec:4,mod]Ursol's Vortex;[mod]Incapacitating Roar;[talent:2/3,noform,@mouseover,help,nodead]Wild Charge;[talent:4/3]Typhoon;[talent:4/2]Mass Entanglement;Mighty Bash")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxRTS",nil,nil,"#showtooltip\n/use [mod:shift,spec:2,talent:5/2]Sigil of Chains;[nomod,@mouseover,spec:1,talent:1/2,harm,nodead]Felblade;[mod:alt,@focus,harm,nodead][nomod,@mouseover,harm,nodead][nomod]Throw Glaive;[mod:alt]MOLL-E;\n/startattack")
		end
		
		-- Macro for button T, "T" "ClassT"	
		if class == "SHAMAN" then								  	
			EditMacro("WSxClassT",nil,nil,"/targetenemy [noexists]\n/cleartarget [dead]\n/use Orb of Deception\n/use [nocombat,noexists]Cooking School Bell\n/use [nocombat]Trans-Dimensional Bird Whistle\n/use [help]Swapblaster;[nocombat,noexists]Disenchant;[@mouseover,harm,nodead][]Lightning Bolt")
		elseif class == "MAGE" then
			EditMacro("WSxClassT",nil,nil,"#show [spec:3]Water Jet;Frost Nova\n/use [help,nodead]Swapblaster;[nocombat]Trans-Dimensional Bird Whistle\n/use [nocombat]Disenchant;[spec:1,talent:4/1]Supernova;[spec:2,talent:2/1]Blast Wave;[talent:4/1]Ice Nova\n/petattack [@mouseover,harm,nodead][]")
		elseif class == "WARLOCK" then
			EditMacro("WSxClassT",nil,nil,"/petattack [@mouseover,exists,nodead][exists,nodead]\n/use [help]Swapblaster;[pet:voidwalker]Suffering;[@mouseover,harm,nodead,pet][pet]!Pursuit;\n/targetenemy [noharm]\n/use [nocombat,noexists]A Tiny Set of Warglaives\n/use Ring of Broken Promises")
		elseif class == "MONK" then
			EditMacro("WSxClassT",nil,nil,"#showtooltip Transcendence: Transfer\n/use [help]Swapblaster;Crackling Jade Lightning;\n/startattack")
		elseif class == "PALADIN" then
			EditMacro("WSxClassT",nil,nil,"#show Hand of Reckoning\n/use [help]Swapblaster;Hand of Reckoning;\n/use Titanium Seal of Dalaran\n/use [nocombat]Trans-Dimensional Bird Whistle\n/use Wayfarer's Bonfire\n/startattack")
		end

		-- Hunter ClassT "ClassT" "T" för change tooltip till Charge/Dash+Dive om finns annars Growl + att den gör random petarray.
		if class == "HUNTER" then
			if petspec == 1 then
				EditMacro("WSxClassT",nil,nil,"/targetenemy [noexists]\n/use [help]Swapblaster;\n/petattack [@mouseover,harm][]\n/use [nocombat,noexists]Trans-Dimensional Bird Whistle;\n/use Dash")
			elseif petspec == 2 then
				EditMacro("WSxClassT",nil,nil,"/targetenemy [noexists]\n/use [help]Swapblaster;\n/petattack [@mouseover,harm][]\n/use [nocombat,noexists]Trans-Dimensional Bird Whistle;\n/use [@mouseover,harm][]Charge")
			else
				EditMacro("WSxClassT",nil,nil,"/targetenemy [noexists]\n/use [help]Swapblaster;\n/petattack [@mouseover,harm][]\n/use [nocombat,noexists]Trans-Dimensional Bird Whistle;\n/use Dash")
			end
		end

		if class == "ROGUE" then
			EditMacro("WSxClassT",nil,nil,"/targetenemy [noharm]\n/use [help]Swapblaster;[nocombat,nostance:1/2/3]Stealth;[stealth][nocombat]Distract;[spec:1]Poisoned Knife;[spec:2]Pistol Shot;[spec:3]Shuriken Toss\n/use [nocombat,noexists,nostealth]Cooking School Bell")
		elseif class == "PRIEST" then
			EditMacro("WSxClassT",nil,nil,"#show Fade\n/use [help,nocombat]Swapblaster;[nocombat,noexists]Trans-Dimensional Bird Whistle;[spec:1]Power Word: Barrier;[spec:2]Holy Nova;\n/use [nocombat,noexists]Personal Spotlight\n/cleartarget [dead]\n/use [nocombat,noexists]Cooking School Bell")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxClassT",nil,nil,"#showtooltip [help] Swapblaster; Dark Command;\n/use [help]Swapblaster;\n/use [nocombat,noexists]Trans-Dimensional Bird Whistle\n/petattack [@mouseover,exists,nodead][]\n/startattack\n/use [nocombat,noexists]Disenchant")
		elseif class == "WARRIOR" then
			EditMacro("WSxClassT",nil,nil,"#showtooltip Taunt\n/use [help]Swapblaster;[spec:3]Taunt;Heroic Throw;\n/use [nocombat]Trans-Dimensional Bird Whistle\n/startattack\n/use Blight Boar Microphone\n/use Orb of Deception")
		elseif class == "DRUID" then
			EditMacro("WSxClassT",nil,nil,"#showtooltip\n/use [help]Swapblaster;[noform:1]Bear form;Growl;\n/use [nocombat,noexists]Trans-Dimensional Bird Whistle\n/use Ravenbear Disguise\n/targetenemy [noexists]\n/use [spec:3]Highmountain War Harness\n/cancelaura [noform:1] Highmountain War Harness")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxClassT",nil,nil,"#showtooltip [help]Swapblaster;[nocombat,noexists]A Tiny Set of Warglaives;[spec:2]Seal of Misery;Throw Glaive;\n/use [help]Swapblaster;[nocombat,noexists]A Tiny Set of Warglaives;Throw Glaive\n/startattack\n/use [nocombat,noexists] Disenchant")
		end
		
		-- Macro "F" for button F, used for Focus Interrupts, fishing, surveying else fun glyph, like Contemplation, Corpse Explosion etc.
		if class == "SHAMAN" then
			EditMacro("WSxGenF",nil,nil,"#showtooltip\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@cursor]Far Sight;[@focus,harm,nodead]Wind Shear;\n/use Survey")
		elseif class == "MAGE" then
			EditMacro("WSxGenF",nil,nil,"#showtooltip [spec:3]Icy Veins;[spec:1]Displacement;[spec:2]Combustion;\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/stopcasting [nomod]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Counterspell;Survey;")
		elseif class == "WARLOCK" then
			EditMacro("WSxGenF",nil,nil,"/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/stopcasting [nomod,nopet]\n/use [mod:alt,exists,nodead]All-Seer's Eye;[mod:alt]Eye of Kilrogg;[@focus,pet:felguard/wrathguard,harm,nodead]Axe Toss;[@focus,harm,exists,nodead]Command Demon;")
		elseif class == "MONK" then
			EditMacro("WSxGenF",nil,nil,"#showtooltip\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[spec:2,@focus,harm,nodead]Paralysis;[@focus,harm,nodead]Spear Hand Strike;\n/targetenemy [noexists]")
		elseif class == "PALADIN" then
			EditMacro("WSxGenF",nil,nil,"#showtooltip Blessing of Freedom\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [spec:2,mod:alt,@focus,harm,nodead]Avenger's Shield;[mod:alt,@focus,exists]Repentance;[mod:alt]Farwater Conch;[@focus,harm,nodead]Rebuke;")
		elseif class == "HUNTER" then
			EditMacro("WSxGenF",nil,nil,"#showtooltip Tar Trap\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@cursor]!Eagle Eye;[spec:3,@focus,harm,nodead]Muzzle;[@focus,harm,nodead]Counter Shot;")
		elseif class == "ROGUE" then
			EditMacro("WSxGenF",nil,nil,"#show [spec:2,combat]Between The Eyes;[combat]Kidney Shot;Detection\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,spec:1,@focus,harm,nodead]Garrote;[mod:alt]Farwater Conch;[@focus,harm,nodead]Kick;Detection")
		elseif class == "PRIEST" then
			EditMacro("WSxGenF",nil,nil,"/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@focus,harm,nodead]Shackle Undead;[mod:alt,exists,nodead]Mind Vision;[mod:alt]Farwater Conch;[spec:3,@focus,harm,nodead]Silence;[help,nodead]True Love Prism;")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxGenF",nil,nil,"#showtooltip\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@focus,harm,nodead]Death Grip;[mod:alt]Legion Communication Orb;[@focus,harm,nodead]Mind Freeze;Fishing;\n/petattack [mod:alt,@focus,harm,nodead]") 
		elseif class == "WARRIOR" then
			EditMacro("WSxGenF",nil,nil,"#showtooltip Berserker Rage\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Pummel;Survey;")
		elseif class == "DRUID" then
			EditMacro("WSxGenF",nil,nil,"#showtooltip Rebirth\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[spec:1,@focus,harm,nodead]Solar Beam;[spec:4,@focus,harm,nodead]Cyclone;[@focus,harm,nodead]Skull Bash;Survey;")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxGenF",nil,nil,"#showtooltip Spectral Sight\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,exists,nodead]All-Seer's Eye;[mod:alt]S.F.E. Interceptor;[@focus,harm,nodead]Consume Magic;\n/cancelaura [mod:alt]Spectral Sight") 
		end
		
		-- Shift+F
		if class == "SHAMAN" then
			EditMacro("WSxSGen+F",nil,nil,"#showtooltip [spec:3]Spiritwalker's Grace;Totem of Harmony\n/use [nocombat,noexists]Totem of Harmony;[nomod,pvptalent:3/1]Skyfury Totem;[nomod,pvptalent:3/2]Counterstrike Totem;[nomod,pvptalent:3/3]Windfury Totem;\n/cancelform [mod:alt]")
		elseif class == "MAGE" then
			EditMacro("WSxSGen+F",nil,nil,"#showtooltip Familiar Stone\n/cancelaura Shado-Pan Geyser Gun\n/use [nomod]Arcane Familiar Stone\n/use [nomod]Fiery Familiar Stone\n/use [nomod]Icy Familiar Stone\n/use [nomod]Familiar Stone")
		elseif class == "WARLOCK" then
			EditMacro("WSxSGen+F",nil,nil,"/use [pet]Threatening Presence\n/use Burning Presence(Special Ability)\n/petautocasttoggle Threatening Presence\n/petautocasttoggle Suffering")
		elseif class == "MONK" then
			EditMacro("WSxSGen+F",nil,nil,"#showtooltip\n/cleartarget [spec:1]\n/target [nospec:2,talent:4/2]Black Ox;\n/use [nocombat]Mulled Alterac Brandy\n/use [nospec:2,talent:4/2,help]Provoke;[nospec:2,talent:4/2,nohelp,@cursor]Summon Black Ox Statue;\n/cancelaura [mod:alt]Purple Phantom")
		elseif class == "PALADIN" then
			EditMacro("WSxSGen+F",nil,nil,"/use \n/use [mod:alt,nocombat,noexists] Gastropod Shell;[spec:1]Gnawed Thumb Ring;[spec:2,@focus,harm,nodead]Avenger's Shield;")
		elseif class == "HUNTER" then
			EditMacro("WSxSGen+F",nil,nil,"#showtooltip Mend Pet\n/petautocasttoggle Growl\n/petautocasttoggle [mod:alt]Spirit Walk\n/use Robo-Gnomebulator")
		elseif class == "ROGUE" then
			EditMacro("WSxSGen+F",nil,nil,"/use [stance:0,nocombat]Stealth;[mod:alt,spec:1,stance:0,combat]Vanish;[mod:alt,spec:1,@focus,harm]Garrote;[mod:alt,spec:2,@focus,harm]Gouge;[nospec:2,@focus,harm,nodead][nospec:2]Shadowstep\n/use [nomod,nospec:2,@focus,harm][nomod,nospec:2]Kick;")
		elseif class == "PRIEST" then
			EditMacro("WSxSGen+F",nil,nil,"/use [nocombat,noexists,nomod]Tickle Totem;[nospec:3,talent:3/1,nomod,@player]Shining Force;\n/cancelaura [mod:alt]Shadowform\n/use [nocombat,noexists,mod:alt] Gastropod Shell\n/use [help,nocombat,mod:alt]B. F. F. Necklace")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxSGen+F",nil,nil,"#showtooltip [spec:1,pvptalent:5/3]Strangulate;[pet:abomination]Cleaver;Claw;\n/petautocasttoggle Claw\n/petautocasttoggle Cleaver")
		elseif class == "WARRIOR" then
			EditMacro("WSxSGen+F",nil,nil,"/use [@focus,harm,nodead]Charge\n/use [@focus,harm,nodead]Pummel\n/use [nocombat,noexists,mod:alt] Gastropod Shell;Faintly Glowing Flagon of Mead;")
		elseif class == "DRUID" then
			EditMacro("WSxSGen+F",nil,nil,"/cancelform [mod:alt]\n/use [nomod,form:3/6,talent:2/3]Wild Charge;[nomod,noform:3/6]Travel Form;\n/use [nomod] Wisp in a Bottle")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxSGen+F",nil,nil,"#showtooltip\n/use [spec:2,pvptalent:6/1]Demonic Trample;[spec:2,pvptalent:6/3]Illidan's Grasp;[pvptalent:6/1]Rain from Above;[pvptalent:5/2]Mana Break;")
		end
		
		-- Macro "Ctrl+F" for button Ctrl+F auxilliary function to F.
		if class == "SHAMAN" then
			EditMacro("WSxCGen+F",nil,nil,"#showtooltip [mod]Firefury Totem;[spec:2,talent:4/1]Lightning Shield;[spec:3,talent:4/2]Ancestral Guidance;Hex;\n/use Ancestral Guidance\n/use Firefury Totem")
		elseif class == "MAGE" then
			EditMacro("WSxCGen+F",nil,nil,"#showtooltip [mod] Arcano-Shower;Ice Block\n/use Arcano-Shower")
		elseif class == "WARLOCK" then
			EditMacro("WSxCGen+F",nil,nil,"#showtooltip\n/use [nocombat,noexists,pet:Succubus/Shivarra]Lesser Invisibility;[talent:6/2]Grimoire: Voidwalker;\n/use Firefury Totem")
		elseif class == "MONK" then
			EditMacro("WSxCGen+F",nil,nil,"#showtooltip\n/use [spec:3]Touch of Karma;[spec:2]Revival;[spec:1]Zen Meditation;")
		elseif class == "PALADIN" then
			EditMacro("WSxCGen+F",nil,nil,"#showtooltip Lay on Hands")
		elseif class == "HUNTER" then
			EditMacro("WSxCGen+F",nil,nil,"#showtooltip Flare\n/use Pendant of the Scarab Storm\n/run SetTracking(2,false);SetTracking(3,false);SetTracking(4,false);SetTracking(5,false);SetTracking(6,false);SetTracking(8,false);SetTracking(9,false);SetTracking(10,false);")
		elseif class == "ROGUE" then
			EditMacro("WSxCGen+F",nil,nil,"#showtooltip [talent:7/2]Marked for Death;[talent:7/3] Death From Above;[spec:2]Bribe;Cloak of Shadows;\n/use [help,exists]Ai-Li's Skymirror\n/summonpet Crackers\n/use Suspicious Crate\n/stopmacro [noexists]\n/whistle")
		elseif class == "PRIEST" then
			EditMacro("WSxCGen+F",nil,nil,"#showtooltip [spec:3] Mind Control; [spec:1] Psychic Scream; [spec:2,pvptalent:3/3]Holy Ward\n/use [nocombat,noexists]Piccolo of the Flaming Fire;[spec:3] Vampiric Embrace; [spec:1] Psychic Scream; [spec:2,pvptalent:3/3]Holy Ward")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxCGen+F",nil,nil,"#showtooltip\n/use [spec:1] Vampiric Blood;[pet:Abomination]Protective Bile;[pet]Huddle;")
		elseif class == "WARRIOR" then
			EditMacro("WSxCGen+F",nil,nil,"#showtooltip\n/use [spec:3]Demoralizing Shout")
		elseif class == "DRUID" then
			EditMacro("WSxCGen+F",nil,nil,"#showtooltip [spec:2/3]Stampeding Roar;[spec:1/4]Innervate;\n/use [spec:3,pvptalent:4/3]Demoralizing Roar;[spec:1,@focus]Innervate;Mushroom Chair;\n/run SetTracking(2,false);SetTracking(3,false);SetTracking(4,false);")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxCGen+F",nil,nil,"#showtooltip Glide")
		end
		
		-- Ctrl+Alt+F
		if class == "SHAMAN" then
			EditMacro("WSxCAGen+F",nil,nil,"#showtooltip [spec:3,talent:5/2] Earthen Shield Totem;[spec:3,talent:5/1]Ancestral Protection Totem;[spec:2]Spirit Walk;Goren \"Log\" Roller;\n/use [nocombat] Goren \"Log\" Roller;\n/cancelaura Ghost Wolf")
		elseif class == "MAGE" then
			EditMacro("WSxCAGen+F",nil,nil,"#showtooltip\n/use Illusion")
		elseif class == "WARLOCK" then
			EditMacro("WSxCAGen+F",nil,nil,"#showtooltip\n/use Legion Pocket Portal")
		elseif class == "MONK" then
			EditMacro("WSxCAGen+F",nil,nil,"#showtooltip\n/use Silversage Incense")
		elseif class == "PALADIN" then
			EditMacro("WSxCAGen+F",nil,nil,"#showtooltip [spec:1] Aura Mastery\n/use Reins of the Charger")
		elseif class == "HUNTER" then
			EditMacro("WSxCAGen+F",nil,nil,"#showtooltip Freezing Trap\n/use [noexists] X-52 Rocket Helmet\n/use Pandaren Scarecrow")
		elseif class == "ROGUE" then
			EditMacro("WSxCAGen+F",nil,nil,"#showtooltip [stealth]Shroud of Concealment; [nocombat,noexists]Twelve-String Guitar;Cloak of Shadows;\n/use Twelve-String Guitar")
		elseif class == "PRIEST" then
			EditMacro("WSxCAGen+F",nil,nil,"#show [spec:3]Vampiric Embrace;[spec:2]Divine Hymn;Power Word: Barrier;\n/target Ebon Gargoyle\n/targetlasttarget\n/target Ebon Gargoyle\n/use Shackle Undead\n/targetlasttarget\n/use [nocombat] Starlight Beacon")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxCAGen+F",nil,nil,"#showtooltip [spec:3,pet,talent:4/1]!Smash;[spec:3,pet]!Gnaw;Stolen Breath;\n/use Reins of the Deathcharger")
		elseif class == "WARRIOR" then
			EditMacro("WSxCAGen+F",nil,nil,"#showtooltip\n/use Throbbing Blood Orb")
		elseif class == "DRUID" then
			EditMacro("WSxCAGen+F",nil,nil,"#showtooltip [nocombat,noexists] Tear of the Green Aspect; [help,nodead]Wild Charge; Barkskin \n/use Tear of the Green Aspect\n/targetfriend [nohelp,nodead]\n/use [help,nodead]Wild Charge\n/cleartarget")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxCAGen+F",nil,nil,"#showtooltip [spec:2]Sigil of Chains")
		end
		
		-- Macro "GG" for button G, used for Dispel/Purge.
		if class == "SHAMAN" then
			EditMacro("WSxGG",nil,nil,"/use [mod:alt]Darkmoon Gazer;[@mouseover,harm,nodead]Purge;[spec:3,@mouseover,help,nodead][spec:3]Purify Spirit;[@mouseover,help,nodead][]Cleanse Spirit;\n/targetenemy [noexists]\n/use Poison Extraction Totem")
		elseif class == "MAGE" then
			EditMacro("WSxGG",nil,nil,"#showtooltip\n/targetenemy [noharm]\n/use [mod:alt]Darkmoon Gazer;[@mouseover,harm,nodead][exists,nodead]Spellsteal;[noexists,nocombat]Set of Matches;")
		elseif class == "WARLOCK" then
			EditMacro("WSxGG",nil,nil,"/use [mod:alt,pet:Voidwalker]Shadow Bulwark;[mod:alt]Legion Communication Orb;[pet:Succubus]Seduction;[pet:Shivarra]Mesmerize;[pet:felguard/wrathguard]Axe Toss;[@mouseover,help,nodead,pet:imp][help,nodead,pet:imp][@player,pet:imp]Singe Magic;Command Demon")
		elseif class == "MONK" then
			EditMacro("WSxGG",nil,nil,"#showtooltip\n/use [mod:alt]Nimble Brew;[@mouseover,help,nodead,nomod][nomod]Detox;\n/use [mod:alt]Darkmoon Gazer")
		elseif class == "PALADIN" then
			EditMacro("WSxGG",nil,nil,"#showtooltip\n/use [mod:alt]Darkmoon Gazer;[spec:1,@mouseover,help,nodead][spec:1]Cleanse;[@mouseover,help,nodead][]Cleanse Toxins;\n/cancelaura [mod:alt]Divine Shield\n/cancelaura [mod:alt]Hand of Protection")
		elseif class == "HUNTER" then
			EditMacro("WSxGG",nil,nil,"/use [mod:alt,nocombat]S.F.E. Interceptor;[mod:alt]Bullheaded;[harm,nocombat]Hozen Idol;[nocombat]Critter Hand Cannon;[pvptalent:4/1]Viper Sting;[pvptalent:4/2]Scorpid Sting;[pvptalent:4/3]Spider Sting;\n/target [nocombat,noexists]Squirrel")
		elseif class == "ROGUE" then 
			EditMacro("WSxGG",nil,nil,"#showtooltip\n/use [mod:alt]Darkmoon Gazer;[spec:1,pvptalent:5/3]Shiv;[spec:3,pvptalent:5/3]Cold Blood;[spec:2,harm,nodead]Gouge;[noexists]Pick Lock;")
		elseif class == "PRIEST" then
			EditMacro("WSxGG",nil,nil,"#showtooltip\n/use [mod:alt]Darkmoon Gazer;[@mouseover,harm,nodead]Dispel Magic;[nospec:3,@mouseover,help,nodead][nospec:3]Purify;[@mouseover,help,nodead][]Purify Disease;\n/use [nomod]Poison Extraction Totem")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxGG",nil,nil,"/use [mod:alt,@focus,harm,nodead]Dark Simulacrum;[mod:alt]S.F.E. Interceptor;[spec:3,nopet]Raise Dead;[nocombat,noexists]Lilian's Warning Sign[spec:3,talent:4/1,pet:Abomination]Hook;[spec:3,pet:Ghoul]Leap;[@focus,harm,nodead]Death Grip;")
		elseif class == "WARRIOR" then
			EditMacro("WSxGG",nil,nil,"#showtooltip\n/use [mod:alt]S.F.E. Interceptor;[talent:3/3]Avatar;[talent:3/2]Rend;[spec:3]Demoralizing Shout;Whirlwind;\n/targetenemy [noharm]")
		elseif class == "DRUID" then
			EditMacro("WSxGG",nil,nil,"#showtooltip\n/use [noform,nocombat,noexists,mod:alt]Darkmoon Gazer;[mod:alt,spec:2/3]Stampeding Roar;[spec:4,@mouseover,help,nodead][spec:4]Nature's Cure;[@mouseover,help,nodead][]Remove Corruption;")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxGG",nil,nil,"#showtooltip\n/use [mod:alt]Legion Communication Orb;[pvptalent:4/2]Reverse Magic;[pvptalent:4/3]Eye of Leotheras;")
		end
		
		-- Macro "Shift+G" for button Shift+G auxilliary function to G.
		if class == "SHAMAN" then
			EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use [noexists,nocombat] Flaming Hoop;Purge;\n/targetenemy [noexists]\n/use Poison Extraction Totem")
		elseif class == "MAGE" then
			EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use [noexists,nocombat] Flaming Hoop;[spec:1]Slow;Spellsteal;\n/targetenemy [noexists]") 
		elseif class == "WARLOCK" then
			EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use [pet:imp]Flee;[pet:voidwalker]Shadow Shield;[noexists,nocombat] Flaming Hoop;[pet:Felhunter]Devour Magic;[pet:Felguard/wrathguard]Axe Toss;[pet:Infernal,harm,nodead]Torch Magic;Command Demon\n/targetenemy [noexists]")
		elseif class == "MONK" then
			EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use [noexists,nocombat] Flaming Hoop;Grapple Weapon;\n/use [nocombat] Pandaren Scarecrow")
		elseif class == "PALADIN" then
			EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use [noexists,nocombat] Flaming Hoop;Hammer of Justice;\n/targetenemy [noexists]")
		elseif class == "HUNTER" then
			EditMacro("WSxSGen+G",nil,nil,"/use [nopet]Call Pet 4;[pet:Spirit Beast]Spirit Walk;[pet:Crane,@mouseover,exists][pet:Crane,exists]Gift of Chi-Ji;[pet:Crane]Trick;[pet:Fox]Play;[pet:Devilsaur]Feast;[pet:Rylak/Feathermane]Updraft;[pet:Crab]Harden Shell;[pet:Moth]Dust of Life;")
		elseif class == "ROGUE" then
			EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [stance:0,nocombat]Stealth;[spec:2,mod:alt,@focus,harm,nodead][spec:2]Between the Eyes;[mod:alt,@focus,exists,nodead][]Kidney Shot;\n/use [nocombat,noexists,stance:0]Flaming Hoop")
		elseif class == "PRIEST" then
			EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use [noexists,nocombat] Flaming Hoop;[@mouseover,harm,nodead][]Dispel Magic;\n/targetenemy [noexists]")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use [noexists,nocombat] Flaming Hoop;[pet,talent:4/1]!Smash;[pet]!Gnaw;\n/petattack [harm,nodead]")
		elseif class == "WARRIOR" then
			EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use [noexists,nocombat] Flaming Hoop;[spec:3]Demoralizing Shout;[talent:3/3]Avatar;[talent:3/2]Rend;")
		elseif class == "DRUID" then
			EditMacro("WSxSGen+G",nil,nil,"#showtooltip\n/use [spec:4,pvptalent:3/2]Thorns;[noexists,nocombat] Flaming Hoop;[spec:2,form:2]Maim;Charm Woodland Creature;\n/targetenemy [noexists]")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxSGen+G",nil,nil,"/use [noexists,nocombat] Flaming Hoop")
		end
		
		-- Macro "Def" for button Z, Primary Defensive Button.
		if class == "SHAMAN" then
			EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:shift,nocombat]Grand Expedition Yak;[mod:shift,@cursor]Spirit Link Totem;Astral Shift")
		elseif class == "MAGE" then
			EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:shift]Grand Expedition Yak;[spec:1,nocombat]Greater Invisibility;[nocombat]Invisibility;!Ice Block;")
		elseif class == "WARLOCK" then
			EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:alt,@cursor]Demonic Gateway;[mod:shift]Grand Expedition Yak;Unending Resolve\n/stopspelltarget")
		elseif class == "MONK" then
			EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [combat,mod:shift]Fortifying Brew;[mod:shift]Grand Expedition Yak;[talent:5/1]Healing Elixir;[nospec:1,talent:5/2]Diffuse Magic;[talent:5/3]Dampen Harm;\n/use Lao Chin's Last Mug")
		elseif class == "PALADIN" then
			EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:shift,help,nodead][mod:shift,combat]Blessing of Protection;[mod:shift]Grand Expedition Yak;[spec:1]Divine Protection;[spec:2]Guardian of Ancient Kings;[spec:3]Divine Shield;")
		elseif class == "HUNTER" then
			EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:alt]Hunter's Call;[mod:shift,nomounted]Play Dead;[nomod]Feign Death\n/use [mod:shift,nocombat]Grand Expedition Yak;")
		elseif class == "ROGUE" then
			EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:alt,spec:1]Wound Poison;[mod:ctrl,spec:1]Deadly Poison;[mod:shift]Grand Expedition Yak;[stance:0,nocombat]Stealth;[spec:2,combat]Riposte;[nospec:2,combat]Evasion;[stance:1]Shroud of Concealment;")
		elseif class == "PRIEST" then
			EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:shift]Grand Expedition Yak;[@mouseover,spec:1,help,nodead][spec:1]Pain Suppression;[@mouseover,spec:2,help,nodead][spec:2]Guardian Spirit;[spec:3]Dispersion;")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:shift,nocombat]Grand Expedition Yak;[spec:1,mod:shift]Dancing Rune Weapon;[mod:shift,spec:3,talent:5/2]Corpse Shield;Icebound Fortitude")
		elseif class == "WARRIOR" then 						 
			EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:shift]Grand Expedition Yak;[spec:1]Die By The Sword;[spec:2]Enraged Regeneration;[spec:3]Shield Wall;")
		elseif class == "DRUID" then
			EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:shift,nocombat]Grand Expedition Yak;[nomod,spec:4]Ironbark;[nomod,spec:2/3]Survival Instincts;[mod:shift][nomod,spec:1]Barkskin;")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxDef",nil,nil,"#showtooltip\n/use [mod:shift,nocombat]Grand Expedition Yak;[spec:2]Fiery Brand;[spec:1]Blur;")
		end

		-- Macro "Buffs" for button Ctrl+Z, Primary Buff button. 
		if class == "SHAMAN" then
			EditMacro("WSxCGen+Z",nil,nil,"/use Sightless Eye\n/use Repurposed Fel Focuser\n/use Seafarer's Slidewhistle\n/use [spec:3]Waterspeaker's Totem;Lightning Shield\n/use Haunting Memento")
		elseif class == "MAGE" then
			EditMacro("WSxCGen+Z",nil,nil,"/use Ogre Pinata\n/use Sightless Eye\n/use Repurposed Fel Focuser\n/use Seafarer's Slidewhistle\n/use Dalaran Initiates' Pin;\n/use [spec:1,combat]Greater Invisibility;[combat]Invisibility;")
		elseif class == "WARLOCK" then
			EditMacro("WSxCGen+Z",nil,nil,"#show\n/use Sightless Eye\n/use Repurposed Fel Focuser\n/use Seafarer's Slidewhistle\n/use Haunting Memento\n/stopspelltarget\n/use Lingering Wyrmtongue Essence\n/use The Perfect Blossom")
		elseif class == "MONK" then
			EditMacro("WSxCGen+Z",nil,nil,"/use Sightless Eye\n/use Repurposed Fel Focuser\n/use Seafarer's Slidewhistle")
		elseif class == "PALADIN" then
			EditMacro("WSxCGen+Z",nil,nil,"/use Lightforged Augment Rune\n/use Sightless Eye\n/use Repurposed Fel Focuser\n/use Greater Blessing of Kings\n/use 16\n/equip [spec:1]The Silver Hand;[spec:2]Truthguard;Ashbringer\n/equip [nocombat]Necromedes, the Death Resonator")
		elseif class == "HUNTER" then
			EditMacro("WSxCGen+Z",nil,nil,"/use [nocombat]Sightless Eye\n/use Aspect of the Chameleon\n/use Repurposed Fel Focuser\n/use Seafarer's Slidewhistle\n/use [nocombat]!Camouflage")
		elseif class == "ROGUE" then
			EditMacro("WSxCGen+Z",nil,nil,"/use Sightless Eye\n/use [combat]Vanish;[stance:0] Repurposed Fel Focuser\n/use [stance:0,nocombat]Stealth; [nostance:0,spec:1]Deadly Poison;\n/use [nocombat,noexists]Slightly-Chewed Insult Book")
		elseif class == "PRIEST" then
			EditMacro("WSxCGen+Z",nil,nil,"/use Lightforged Augment Rune\n/use Sightless Eye\n/use Repurposed Fel Focuser\n/use Panflute of Pandaria\n/use Power Word: Fortitude\n/use Haunting Memento")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxCGen+Z",nil,nil,"/use Sightless Eye\n/use Repurposed Fel Focuser\n/use Seafarer's Slidewhistle\n/use Haunting Memento")
		elseif class == "WARRIOR" then 						 
			EditMacro("WSxCGen+Z",nil,nil,"/use Sightless Eye\n/use Repurposed Fel Focuser\n/use Seafarer's Slidewhistle\n/use Defensive Stance\n/use Shard of Archstone\n/use Vrykul Toy Boat Kit")
		elseif class == "DRUID" then
			EditMacro("WSxCGen+Z",nil,nil,"/use Sightless Eye\n/use [nostealth] Repurposed Fel Focuser\n/use [nostealth] Panflute of Pandaria\n/use Fandral's Seed Pouch\n/use !Prowl")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxCGen+Z",nil,nil,"/use Sightless Eye\n/use Repurposed Fel Focuser\n/use Seafarer's Slidewhistle\n/use Lingering Wyrmtongue Essence\n/use The Perfect Blossom")
		end
		
		-- Macro "GND" for button X, Absorbing, Reflect or External Defensive Button.
		if class == "SHAMAN" then
			EditMacro("WSxGND",nil,nil,"/cast [mod:alt]Xan'tish's Flute;[mod:ctrl]Astral Recall;[spec:2,mod:shift]Spirit Walk;[spec:1,pvptalent:5/3]Control of Lava;[spec:3,pvptalent:5/3]Grounding Totem;[spec:3]Healing Stream Totem;\n/use Void Totem")
		elseif class == "MAGE" then
			EditMacro("WSxGND",nil,nil,"#showtooltip\n/use [mod:alt]Conjure Refreshment;[mod:ctrl]Teleport: Hall of the Guardian;[spec:1,mod:shift]Displacement;[spec:1]Prismatic Barrier;[spec:2]Blazing Barrier;[spec:3]Ice Barrier;")
		elseif class == "WARLOCK" then
			EditMacro("WSxGND",nil,nil,"/stopcasting [mod:shift]\n/use [mod:alt,group]Create Soulwell;[mod:alt]Create Healthstone;[mod:ctrl,harm,nodead]Enslave Demon;[mod:ctrl,group]Ritual of Summoning;[mod:shift]Demonic Circle;[talent:5/3]Dark Pact;[talent:5/2]Burning Rush;\n/use Void Totem")
		elseif class == "MONK" then
			EditMacro("WSxGND",nil,nil,"#showtooltip\n/use [mod:ctrl]Zen Pilgrimage;[mod:shift]Transcendence: Transfer;[spec:1]Fortifying Brew;[spec:3]Touch of Karma;[spec:2,@mouseover,help,nodead][spec:2,nodead]Life Cocoon;")
		elseif class == "PALADIN" then
			EditMacro("WSxGND",nil,nil,"/use [mod:alt]Greater Blessing of Wisdom;[mod:shift]Blessing of Freedom;[nospec:3,@mouseover,help,nodead][nospec:3,help,nodead]Blessing of Sacrifice;[@mouseover,help,nodead]Lay on Hands;[spec:2]Ardent Defender;[spec:3]Shield of Vengeance;Lay on Hands;")
		elseif class == "HUNTER" then
			EditMacro("WSxGND",nil,nil,"#showtooltip\n/use [mod:alt,exists]Beast Lore;[mod:alt]Xan'tish's Flute;[mod:ctrl,exists,nodead]Tame Beast;[mod]Aspect of the Cheetah;Aspect of the Turtle;\n/use Super Simian Sphere\n/use Angry Beehive")
		elseif class == "ROGUE" then
			EditMacro("WSxGND",nil,nil,"#showtooltip\n/use [spec:1,mod:alt]Crippling Poison;[mod:ctrl,spec:2,exists,nodead]Bribe;[mod:ctrl]Scroll of Teleport: Ravenholdt;[mod:shift]Sprint;Feint;\n/use [nostealth,mod:shift]Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
		elseif class == "PRIEST" then
			EditMacro("WSxGND",nil,nil,"/use [mod:alt]Xan'tish's Flute;[mod:ctrl]Mind Control;[mod:shift]Fade;[spec:2,@mouseover,help,nodead][spec:2]Prayer of Mending;[@mouseover,help,nodead][]Power Word: Shield;\n/use [nocombat]Bubble Wand\n/use [nocombat]Void Totem\n/cancelaura Bubble Wand")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxGND",nil,nil,"#showtooltip\n/use [mod:alt]Runeforging;[mod:ctrl,exists,nodead]Control Undead;[mod:ctrl]Death Gate;Anti-Magic Shell;")
		elseif class == "WARRIOR" then
			EditMacro("WSxGND",nil,nil,"#showtooltip\n/use [spec:1/2,pvptalent:4/2,nomod][spec:3,nomod]Spell Reflection;\n/targetfriend [mod:shift,nohelp,noexists]\n/use [mod:shift,@target]Charge\n/targetlasttarget [mod:shift]")
		elseif class == "DRUID" then
			EditMacro("WSxGND",nil,nil,"/use [mod:alt]Stag Form;[mod:ctrl,harm,nodead]Cyclone;[mod:ctrl]Dreamwalk;[mod,noform:2]Cat Form;[mod,form:2]Dash;[form:1]Ironfur;[@mouseover,help,nodead,spec:4][@mouseover,help,talent:3/3][spec:4][talent:3/3]Swiftmend\n/use [nostealth]Path of Elothir")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxGND",nil,nil,"#showtooltip\n/use [mod:shift,spec:2,talent:1/2]Eye Beam;[mod:shift,spec:1]Blur;[spec:1]Darkness;[spec:2]Empower Wards;")
		end
		
		-- Macro "CC" for button C, HoT spells, Crowd control, Auxilliary Cooldown Button.
		if class == "SHAMAN" then
			EditMacro("WSxCC",nil,nil,"/use [mod:ctrl]Hex;[spec:2]Feral Spirit;[spec:3,@mouseover,help,nodead][spec:3]Riptide;[spec:1]Thunderstorm;\n/use Thistleleaf Branch\n/cancelaura X-Ray Specs\n/cancelaura Thistleleaf Disguise")
		elseif class == "MAGE" then
			EditMacro("WSxCC",nil,nil,"#showtooltip [talent:3/2]Rune of Power;[talent:3/1]Mirror Image;Polymorph;\n/use [mod:shift,@player][nomod,talent:5/2]Ring of Frost;[mod:ctrl][]Polymorph;\n/cancelaura X-Ray Specs")
		elseif class == "WARLOCK" then
			EditMacro("WSxCC",nil,nil,"/use [mod:ctrl]Fear;[mod:shift]Life Tap;[nopet]Summon Voidwalker;Health Funnel;")
		elseif class == "MONK" then
			EditMacro("WSxCC",nil,nil,"/use [mod:shift,spec:2]Mana Tea;[mod]Paralysis;[spec:3,talent:3/1]Energizing Elixir;[spec:1]Purifying Brew;[spec:2,@mouseover,help,nodead][spec:2]Renewing Mist;Paralysis;")
		elseif class == "PALADIN" then
			EditMacro("WSxCC",nil,nil,"/use [mod,talent:3/2]Repentance;[spec:3,talent:5/3]Word of Glory;[spec:1,@mouseover,help,nodead,talent:1/1][spec:1,talent:1/1]Bestow Faith;[spec:1,talent:1/2]Light's Hammer;[@mouseover,spec:2,talent:5/1,help,nodead][spec:2]Light of the Protector;Judgment;")
		elseif class == "HUNTER" then
			EditMacro("WSxCC",nil,nil,"#showtooltip Exhilaration\n/use [mod:ctrl,@cursor]Freezing Trap;Revive Pet;\n/stopmacro [mod]\n/cancelaura X-Ray Specs\n/cancelaura Safari Hat\n/use [spec:1,nostealth]Safari Hat\n/use [nostealth]Poison Extraction Totem")
		elseif class == "ROGUE" then
			EditMacro("WSxCC",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [mod:ctrl]Blind;[mod:shift]Smoke Powder;[stance:0,nocombat]Stealth;[@focus,harm,nodead,stance:1/2/3][stance:1/2/3]Sap;Blind;\n/cancelaura Don Carlos' Famous Hat")
		elseif class == "PRIEST" then
			EditMacro("WSxCC",nil,nil,"#show\n/use [mod:ctrl]Shackle Undead;[mod:shift,@focus,help,nodead][spec:1,@mouseover,help,nodead][spec:1]Plea;[spec:2,mod:shift,talent:4/3]Symbol of Hope;[spec:2,@mouseover,help,nodead][spec:2]Renew;[mod:shift][]Shadowfiend;\n/cancelaura X-Ray Specs")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxCC",nil,nil,"#showtooltip\n/use [mod:ctrl,spec:2,talent:4/2]Blinding Sleet;[mod:ctrl]Asphyxiate;[spec:3,mod:shift,nopet]Raise Dead;[pvptalent:3/2]Dark Simulacrum;[pvptalent:3/3]Anti-Magic Zone;")
		elseif class == "WARRIOR" then
			EditMacro("WSxCC",nil,nil,"#showtooltip [spec:1/2]Intimidating Shout;Spell Reflection;\n/use [mod:ctrl]Intimidating Shout;Spell Reflection;\n/cancelaura Vrykul Drinking Horn")
		elseif class == "DRUID" then
			EditMacro("WSxCC",nil,nil,"/use [spec:1/4,mod:shift]Innervate;[form:1,nomod]Frenzied Regeneration;[@mouseover,help,nodead,nomod][mod:shift,talent:3/3,nospec:4,form][talent:3/3,nospec:4,noform:1,nomod][spec:4,nomod]Rejuvenation;[mod:ctrl][]Entangling Roots;")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxCC",nil,nil,"#showtooltip\n/use [spec:2,mod:ctrl,@cursor]Sigil of Misery;[mod:ctrl][]Imprison\n/cancelaura X-Ray Specs")
		end
	
		-- Macro "Move" for button V, "V", Movement related spells, Enviorment enhancement.
		if class == "SHAMAN" then
			EditMacro("WSxMove",nil,nil,"#showtooltip\n/use [talent:2/3,@cursor]Wind Rush Totem;[nospec:2,talent:2/1]Gust of Wind;[spec:1,talent:2/2]Ancestral Guidance;[spec:2,talent:2/1,@cursor]Rainfall;[spec:2,talent:2/2]Feral Lunge;Ghost Wolf\n/targetenemy [noexists]\n/cleartarget [dead]")
		elseif class == "MAGE" then
			EditMacro("WSxMove",nil,nil,"/use Blink\n/dismount [mounted]")
		elseif class == "WARLOCK" then
			EditMacro("WSxMove",nil,nil,"#showtooltip\n/use [noexists,nocombat]Golden Hearthstone Card: Lord Jaraxxus;[spec:2,talent:6/2]Grimoire: Felhunter;[spec:3,@mouseover,harm,nodead][spec:3]Havoc;[@mouseover,harm,nodead][]Soul Swap") 
		elseif class == "MONK" then
			EditMacro("WSxMove",nil,nil,"#showtooltip\n/use Roll")
		elseif class == "PALADIN" then
			EditMacro("WSxMove",nil,nil,"/use [spec:3,talent:6/3]Seal of Light;[spec:2/3]Divine Steed;[@mouseover,help,nodead][]Beacon of Light;")
		elseif class == "HUNTER" then
			EditMacro("WSxMove",nil,nil,"/use [spec:3,notalent:3/2]Harpoon;Disengage;\n/stopcasting\n/use Crashin' Thrashin' Robot")
		elseif class == "ROGUE" then
			EditMacro("WSxMove",nil,nil,"/use [spec:1/3]Shadowstep;[spec:2,talent:2/1,@cursor]Grappling Hook;Sprint;\n/targetenemy [noexists]")
		elseif class == "PRIEST" then
			EditMacro("WSxMove",nil,nil,"#showtooltip\n/use [nocombat,noexists]Puzzle Box of Yogg-Saron;[spec:2]Desperate Prayer;[pvptalent:6/3]Void Shift(Honor Talent);[pvptalent:6/1]Psyfiend(Honor Talent);\n/use Fade\n/use Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxMove",nil,nil,"#showtooltip [mod] Syxsehnz Rod; Wraith Walk;\n/use Syxsehnz Rod\n/use !Wraith Walk")
		elseif class == "WARRIOR" then
			EditMacro("WSxMove",nil,nil,"/use [@cursor] Heroic Leap")
		elseif class == "DRUID" then
			EditMacro("WSxMove",nil,nil,"/use [spec:1,noform:4][nospec:1,talent:2/3,talent:3/1,noform:4]Moonkin Form;[talent:2/3]Wild Charge;[talent:2/2]Displacer Beast;Renewal")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxMove",nil,nil,"#showtooltip\n/use [spec:2,@cursor]Infernal Strike;Vengeful Retreat;")
		end
		
		-- Macro for "Shift+V", Spec based mounts, "shift+v"
		-- Shaman mounts, shift+v
		if class == "SHAMAN" then
			EditMacro("WSxSGen+V",nil,nil,"/use [flyable]Farseer's Raging Tempest\n/castrandom [noflyable] Farseer's Raging Tempest, Vicious War Kodo, Vicious War Raptor, Garn Nighthowl, Swift Zulian Tiger,Wild Dreamrunner,Prestigious War Wolf\n/use [noform]Ghost Wolf;\n/use Death's Door Charm")
		end
		
		-- Mage mounts, shift+v
		if class == "MAGE" then
			if playerspec == 1 then
				EditMacro("WSxSGen+V",nil,nil,"/equipset [spec:1,mounted]Noon!\n/use [noflyable]Wild Dreamrunner;16;\n/castrandom [flyable]Archmage's Prismatic Disc,Leywoven Flying Carpet,Violet Spellwing,Arcanist's Manasaber\n/equip [spec:1,nomounted,nocombat,flyable]Dragonwrath, Tarecgosa's Rest\n/dismount [mounted]")
			elseif playerspec == 2 then
				EditMacro("WSxSGen+V",nil,nil,"/use [noflyable]Wild Dreamrunner\n/castrandom [flyable]Archmage's Prismatic Disc,Leywoven Flying Carpet,Ashes of Al'ar,Arcanist's Manasaber,Violet Spellwing\n/dismount [mounted]")
			else
				EditMacro("WSxSGen+V",nil,nil,"/use [noflyable]Wild Dreamrunner\n/castrandom [flyable]Archmage's Prismatic Disc,Leywoven Flying Carpet,Ashes of Al'ar,Arcanist's Manasaber,Violet Spellwing\n/dismount [mounted]")
			end
		end

		if class == "WARLOCK" then
			if race == "BloodElf" then	
				if playerspec == 1 then
					EditMacro("WSxSGen+V",nil,nil,"/castrandom [flyable]Headless Horseman's Mount,Netherlord's Accursed Wrathsteed,Antoran Gloomhound\n/castrandom [noflyable]Vicious Skeletal Warhorse,Wild Dreamrunner,Lucid Nightmare,Illidari Felstalker,Hellfire Infernal") 
				elseif playerspec == 2 then
					EditMacro("WSxSGen+V",nil,nil,"/castrandom [flyable]Headless Horseman's Mount,Netherlord's Chaotic Wrathsteed,Netherlord's Accursed Wrathsteed,Antoran Gloomhound\n/castrandom [noflyable]Vicious Skeletal Warhorse,Wild Dreamrunner,Lucid Nightmare,Illidari Felstalker,Hellfire Infernal")  
				else
					EditMacro("WSxSGen+V",nil,nil,"/castrandom [flyable]Headless Horseman's Mount,Netherlord's Brimstone Wrathsteed,Antoran Gloomhound,Netherlord's Chaotic Wrathsteed\n/castrandom [noflyable]Vicious Skeletal Warhorse,Wild Dreamrunner,Lucid Nightmare,Illidari Felstalker,Hellfire Infernal") 
				end	
			

			elseif race == "Troll" then	
				if playerspec == 1 then
					EditMacro("WSxSGen+V",nil,nil,"/castrandom [flyable]Headless Horseman's Mount,Netherlord's Accursed Wrathsteed\n/castrandom [noflyable]Swift Zulian Tiger,Wild Dreamrunner,Lucid Nightmare,Amani Battle Bear,Vicious War Raptor,Fossilized Raptor,Amani Battle Bear,Bloodfang Widow") 
				elseif playerspec == 2 then
					EditMacro("WSxSGen+V",nil,nil,"/castrandom [flyable]Netherlord's Chaotic Wrathsteed,Netherlord's Accursed Wrathsteed,Antoran Gloomhound\n/castrandom [noflyable]Swift Zulian Tiger,Wild Dreamrunner,Lucid Nightmare,Fossilized Raptor,Vicious War Raptor,Bloodfang Widow") 
				else
					EditMacro("WSxSGen+V",nil,nil,"/castrandom [flyable]Netherlord's Brimstone Wrathsteed,Netherlord's Chaotic Wrathsteed\n/castrandom [noflyable]Swift Zulian Tiger,Wild Dreamrunner,Lucid Nightmare,Fossilized Raptor,Vicious War Raptor,Amani Battle Bear,Bloodfang Widow") 
				end
			end
		end
			
		if class == "MONK" then
			EditMacro("WSxSGen+V",nil,nil,"#showtooltip\n/use [flyable] Ban-Lu, Grandmaster's Companion\n/castrandom [nospec:2]Wild Dreamrunner,Heavenly Azure Cloud Serpent,Astral Cloud Serpent,Swift Zulian Tiger,Clutch of Ji-Kun,Riding Turtle,Onyx Cloud Serpent\n/use [spec:2]Yu'lei, Daughter of Jade")
		end
		
		-- Paladin mounts, shift+v
		if class == "PALADIN" then
			if playerspec == 1 then
				EditMacro("WSxSGen+V",nil,nil,"/userandom [flyable]Highlord's Valorous Charger,Highlord's Golden Charger,Invincible, Lightforged Warframe\n/userandom Swift Zulian Tiger,Argent Charger,Summon Thalassian Warhorse,Highlord's Valorous Charger,Invincible,Avenging Felcrusher,Wild Dreamrunner")
			elseif playerspec == 2 then
				EditMacro("WSxSGen+V",nil,nil,"/userandom [flyable]Highlord's Vigilant Charger,Highlord's Golden Charger,Invincible, Lightforged Warframe\n/userandom Swift Zulian Tiger,Argent Charger,Summon Thalassian Warhorse,Highlord's Vigilant Charger,Invincible,Avenging Felcrusher,Wild Dreamrunner")
			else
				EditMacro("WSxSGen+V",nil,nil,"/userandom [flyable]Highlord's Vengeful Charger,Highlord's Golden Charger,Invincible, Lightforged Warframe\n/userandom Prestigious Bronze Courser,Argent Charger,Summon Thalassian Warhorse,Highlord's Vengeful Charger,Avenging Felcrusher,Wild Dreamrunner")
			end
		end

		-- Hunter mounts, shift+v
		if class == "HUNTER" then
			if playerspec == 1 then
				EditMacro("WSxSGen+V",nil,nil,"/castrandom [flyable]Mimiron's Head, Huntmaster's Loyal Wolfhawk,Armored Skyscreamer,Dread Raven,Darkmoon Dirigible,Geosynchronous World Spinner\n/castrandom Kor'kron Juggernaut,Spawn of Horridon,Spirit of Eche'ro,Brawler's Burly Basilisk,Llothien Prowler")
			elseif playerspec == 2  then
				EditMacro("WSxSGen+V",nil,nil,"/castrandom [flyable]Mimiron's Head, Huntmaster's Dire Wolfhawk,Armored Skyscreamer,Dread Raven\n/castrandom Kor'kron Juggernaut,Spawn of Horridon,Spirit of Eche'ro,Brawler's Burly Basilisk,Great Northern Elderhorn,Llothien Prowler,Highmountain Elderhorn")
			else
				EditMacro("WSxSGen+V",nil,nil,"/castrandom [flyable]Mimiron's Head, Huntmaster's Fierce Wolfhawk,Darkmoon Dirigible,Dread Raven\n/castrandom Kor'kron Juggernaut,Spawn of Horridon,Spirit of Eche'ro,Brawler's Burly Basilisk,Great Northern Elderhorn,Llothien Prowler,Highmountain Elderhorn")
			end	
		end

		-- Rogue mounts, shift+v
		if class == "ROGUE" then
			if playerspec == 1 then
				EditMacro("WSxSGen+V",nil,nil,"/targetfriend [nospec:2,nohelp,combat]\n/castrandom [flyable]Ironbound Wraithcharger,Shadowblade's Baneful Omen,Shadowblade's Murderous Omen\n/use Blue Shado-Pan Riding Tiger\n/cancelaura [nocombat]Stealth")
			elseif playerspec == 2 then
				EditMacro("WSxSGen+V",nil,nil,"/castrandom [flyable]Ironbound Wraithcharger,Shadowblade's Crimson Omen,Shadowblade's Murderous Omen,Infinite Timereaver\n/use Ratstallion\n/cancelaura [nocombat]Stealth")
			else 	
				EditMacro("WSxSGen+V",nil,nil,"/targetfriend [nospec:2,nohelp,combat]\n/castrandom [flyable]Ironbound Wraithcharger,Shadowblade's Lethal Omen,Shadowblade's Murderous Omen,Infinite Timereaver\n/use Infinite Timereaver\n/cancelaura [nocombat]Stealth")
			end
		end
		
		-- Prist mount, shift+v
		if class == "PRIEST" then
			if playerspec == 1 then
				EditMacro("WSxSGen+V",nil,nil,"/castrandom [flyable] High Priest's Lightsworn Seeker, Lightforged Warframe\n/use [spec:1]Trained Meadowstomper\n/use Death's Door Charm\n/dismount [mounted]")
			elseif playerspec == 2 then
				EditMacro("WSxSGen+V",nil,nil,"/castrandom [flyable] High Priest's Lightsworn Seeker, Lightforged Warframe\n/use [spec:2]Bone-White Primal Raptor\n/use Death's Door Charm\n/dismount [mounted]")
			else
				EditMacro("WSxSGen+V",nil,nil,"/castrandom [flyable] High Priest's Lightsworn Seeker, Dread Raven\n/castrandom [spec:3] Ultramarine Qiraji Battle Tank,Riddler's Mind-Worm,Lucid Nightmare\n/use Death's Door Charm\n/dismount [mounted]")	
			end
		end

		-- Diky mounts, shift+v
		if class == "DEATHKNIGHT" then
			EditMacro("WSxSGen+V",nil,nil,"#showtooltip\n/dismount [mounted]\n/castrandom [flyable] Deathlord's Vilebrood Vanquisher, Invincible; Deathlord's Vilebrood Vanquisher, Wild Dreamrunner, Invincible, Lucid Nightmare")
		end

		-- Warrior mounts, shift+v 
		if class == "WARRIOR" then
			if playerspec == 1 then
				EditMacro("WSxSGen+V",nil,nil,"/castrandom [flyable] Battlelord's Bloodthirsty War Wyrm,Invincible,Smoldering Ember Wyrm,Valarjar Stormwing\n/use Death's Door Charm\n/castrandom [noflyable] Bloodfang Widow, Warlord's Deathwheel, Arcadian War Turtle, Prestigious War Wolf")
			elseif playerspec == 2 then
				EditMacro("WSxSGen+V",nil,nil,"/castrandom [flyable] Battlelord's Bloodthirsty War Wyrm,Invincible,Smoldering Ember Wyrm,Valarjar Stormwing\n/use Death's Door Charm\n/castrandom [noflyable] Bloodfang Widow, Warlord's Deathwheel, Summon Chauffeur, Mechano-Hog, Arcadian War Turtle")
			else 
				EditMacro("WSxSGen+V",nil,nil,"/castrandom [flyable] Battlelord's Bloodthirsty War Wyrm,Invincible,Smoldering Ember Wyrm,Valarjar Stormwing\n/use Death's Door Charm\n/castrandom [noflyable] Bloodfang Widow, Warlord's Deathwheel, Summon Chauffeur, Mechano-Hog, Prestigious Bronze Courser")
			end
		end
		-- Druid Mounts, shift+v
		if class == "DRUID" then
			EditMacro("WSxSGen+V",nil,nil,"/cancelform [form:1/2/3]\n/use [flyable] Grove Warden\n/castrandom Astral Cloud Serpent,Vicious War Raptor,Darkmoon Dancing Bear,Spirit of Eche'ro,Wild Dreamrunner,Cloudwing Hippogryph,Lucid Nightmare")
		end
		-- Demon Hunter Mounts, shift+v
		if class == "DEMONHUNTER" then
			EditMacro("WSxSGen+V",nil,nil,"#showtooltip\n/castrandom [flyable] Arcanist's Manasaber, Slayer's Felbroken Shrieker, Felfire Hawk, Corrupted Dreadwing, Azure Drake, Cloudwing Hippogryph; Felsaber, Wild Dreamrunner, Lucid Nightmare, Illidari Felstalker")
		end

	
		-- Macro "Ctrl+V" for button Ctrl+V, Slow Fall, Waterwalking etc.
		if class == "SHAMAN" then
			EditMacro("WSxCGen+V",nil,nil,"/use [mod:alt]Orgrimmar Interceptor;[nocombat,noexists]Silversage Incense;\n/use [nomod] Water Walking\n/use [swimming] Barnacle-Encrusted Gem\n/use [nomod]Panflute of Pandaria\n/use [nomod] Whispers of Rai'Vosh") 
		elseif class == "MAGE" then
			EditMacro("WSxCGen+V",nil,nil,"#showtooltip Time Warp\n/use [mod:alt]Orgrimmar Interceptor;[swimming] Barnacle-Encrusted Gem;Slow Fall\n/use [nostealth,nomod]Panflute of Pandaria")
		elseif class == "WARLOCK" then
			EditMacro("WSxCGen+V",nil,nil,"/use [mod:alt]Orgrimmar Interceptor;[harm,nodead]Banish;[swimming,noexists] Barnacle-Encrusted Gem;Unending Breath;\n/use [nostealth,nomod]Panflute of Pandaria\n/use [nomod] Whispers of Rai'Vosh")
		elseif class == "MONK" then
			EditMacro("WSxCGen+V",nil,nil,"#showtooltip [spec:1]Fortifying Brew;[spec:2]Thunder Focus Tea;[spec:3]Storm, Earth, and Fire;\n/use [mod:alt]Orgrimmar Interceptor;[swimming] Barnacle-Encrusted Gem;Zen Flight\n/use [nostealth,nomod]Panflute of Pandaria\n/use [nomod] Whispers of Rai'Vosh")
		elseif class == "PALADIN" then
			EditMacro("WSxCGen+V",nil,nil,"#showtooltip\n/use [mod:alt]Orgrimmar Interceptor;[swimming] Barnacle-Encrusted Gem;Divine Steed;\n/use [nostealth,nomod]Panflute of Pandaria\n/use [nostealth,nomod] Seafarer's Slidewhistle\n/use [nomod] Whispers of Rai'Vosh")
		elseif class == "HUNTER" then
			EditMacro("WSxCGen+V",nil,nil,"/use [mod:alt]Orgrimmar Interceptor;[spec:1,pet,nopet:Water Strider]Dismiss Pet;[spec:1,nopet]Call Pet 1;[spec:1,pet:Water Strider]Surface Trot\n/use Barnacle-Encrusted Gem\n/use [nostealth,nomod]Panflute of Pandaria\n/use [nomod] Whispers of Rai'Vosh")
		elseif class == "ROGUE" then
			EditMacro("WSxCGen+V",nil,nil,"/use [mod:alt]Orgrimmar Interceptor;[swimming] Barnacle-Encrusted Gem;[harm,nodead]Poisoned Throwing Knives;Survivor's Bag of Coins\n/use [nostealth,nomod]Panflute of Pandaria\n/use [nomod] Whispers of Rai'Vosh")
		elseif class == "PRIEST" then
			EditMacro("WSxCGen+V",nil,nil,"/use [mod:alt]Orgrimmar Interceptor;[swimming,noexists,nocombat] Barnacle-Encrusted Gem;[exists][]Levitate\n/use [nomod]Seafarer's Slidewhistle\n/use [nomod]Thaumaturgist's Orb")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxCGen+V",nil,nil,"/use [mod:alt]Orgrimmar Interceptor;[swimming,noexists,nocombat] Barnacle-Encrusted Gem;[exists][]Path of Frost\n/use [nostealth,nomod]Panflute of Pandaria\n/use [nomod] Whispers of Rai'Vosh")
		elseif class == "WARRIOR" then
			EditMacro("WSxCGen+V",nil,nil,"/use [mod:alt]Orgrimmar Interceptor;[swimming] Barnacle-Encrusted Gem;Thistleleaf Branch\n/use [nostealth,nomod]Panflute of Pandaria\n/use Heroic Leap\n/use [nomod] Whispers of Rai'Vosh\n/cancelaura Thistleleaf Disguise")
		end
		
		if class == "DRUID" then 
			if playerspec == 1 then 
				EditMacro("WSxCGen+V",nil,nil,"#showtooltip\n/use [mod:alt]Orgrimmar Interceptor;[noform:4,nomod]Moonkin Form;[nomod]!Flap\n/cancelform [form:1/2]\n/cancelaura Prowl\n/use [nomod,nostealth]Seafarer's Slidewhistle\n/use [nomod] Whispers of Rai'Vosh")
			elseif playerspec == 2 then
				EditMacro("WSxCGen+V",nil,nil,"#showtooltip\n/use [mod:alt]Orgrimmar Interceptor;[talent:3/1,noform:4]Moonkin Form;[talent:3/1]!Flap;[noform]Stag Form;\n/cancelform [form:1/2]\n/cancelaura Prowl\n/use [nomod,nostealth]Seafarer's Slidewhistle\n/use [nomod] Whispers of Rai'Vosh")
			elseif playerspec == 3 then
				EditMacro("WSxCGen+V",nil,nil,"#showtooltip\n/use [mod:alt]Orgrimmar Interceptor;[talent:3/1,noform:4]Moonkin Form;[talent:3/1]!Flap;[noform]Stag Form;\n/cancelform [form:1/2]\n/cancelaura Prowl\n/use [nomod,nostealth]Seafarer's Slidewhistle\n/use [nomod] Whispers of Rai'Vosh")
			else
				EditMacro("WSxCGen+V",nil,nil,"#showtooltip\n/use [mod:alt]Orgrimmar Interceptor;[talent:3/1,noform:4]Moonkin Form;[talent:3/1]!Flap;[noform]Stag Form;\n/cancelform [form:1/2]\n/cancelaura Prowl\n/use [nomod,nostealth]Seafarer's Slidewhistle\n/use [nomod] Whispers of Rai'Vosh")
			end
		end

		if class == "DEMONHUNTER" then
			EditMacro("WSxCGen+V",nil,nil,"/use [mod:alt]Orgrimmar Interceptor;[swimming] Barnacle-Encrusted Gem;!Glide;\n/use [nostealth,nomod]Panflute of Pandaria\n/dismount [mounted]")
		end
		
		-- Macro "B" for button B and Shift+B, Earth Shield, Holy Shock on Tank etc. Need research on effective /cast @friendlytarget macros. Is it possible to use "/targetexact "..B" Earth Shield") - Edra Fixet syntax error with escaping quotes with \"\", genious; Have Ctrl+Alt+B keybind for WSxCAGen+B, then natural B for executing macro#2 with shift modifier allowed. Re-assign keybind for Openallbags and open character pane.
 
			if class == "SHAMAN" then
				EditMacro("WSxGen+B",nil,nil,"#showtooltip Far Sight")
				EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"\\#showtooltip Far Sight\\n/use [mod:shift,@\"..B..\"]Healing Surge;[@\"..B..\"]Riptide\", nil)print(\"Tank set to : \"..B)else print(\"Cannot change assist now!\")end")
			elseif class == "MAGE" then
				EditMacro("WSxGen+B",nil,nil,"#showtooltip Invisibility\n/use [pvptalent:4/1]Temporal Shield")
				EditMacro("WSxCAGen+B",nil,nil,"")
			elseif class == "WARLOCK" then
				EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use [nocombat,noexists]Tickle Totem;[spec:1,pvptalent:5/3]Soulburn;[spec:3,pvptalent:5/3,mod:shift]Firestone;[spec:3,talent:6/2]Grimoire: Felhunter;[pvptalent:5/3]Singe Magic;[pvptalent:5/2]Call Felhunter;Tickle Totem;")
				EditMacro("WSxCAGen+B",nil,nil,"")
			elseif class == "MONK" then
				EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Effuse;[@\"..B..\"]Enveloping Mist\", nil)print(\"Tank set to : \"..B)else print(\"Cannot change assist now!\")end")
				EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use Effuse")
			elseif class == "PALADIN" then
				EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"\\#showtooltip Lay on Hands\\n/use [mod:shift,@\"..B..\"]Flash of Light;[@\"..B..\"]Holy Shock\", nil)print(\"Tank set to : \"..B)else print(\"Combat Locked!\")end")
			elseif class == "HUNTER" then
				EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [@\"..B..\"]Misdirection\\n/stopspelltarget\", nil)print(\"Tank#1 set to : \"..B)else print(\"Error: Combat Lock!\")end")
				EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/use [nospec:3]Fetch Ball;[spec:3]Harpoon;")
			elseif class == "ROGUE" then
				EditMacro("WSxGen+B",nil,nil,"#showtooltip Sprint")
				EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"\\#showtooltip Sprint\\n/use [@\"..B..\"]Tricks of the Trade\\n/stopspelltarget\", nil)print(\"Tricks#1 set to : \"..B)else print(\"Combat Lockdown!\")end")
			end

		-- CTRL+ALT+B for Prist, "B" set frame for Maintank
			if class == "PRIEST" then
				if playerspec == 1 then
					EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Shadow Mend;[@\"..B..\"]Power Word: Shield\", nil)print(B..\" Is Tank\")else print(\"Combat!\")end")
					EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use Power Word: Shield")
				elseif playerspec == 2 then
					EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Flash Heal;[spec:2,@\"..B..\"]Prayer of Mending;[@\"..B..\"]Power Word: Shield\", nil)print(B..\" Is Tank\")else print(\"Combat!\")end")
					EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use Prayer of Mending")
				else
					EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Shadow Mend;[@\"..B..\"]Power Word: Shield\", nil)print(B..\" Is Tank\")else print(\"Combat!\")end")
					EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use Power Word: Shield")
				end
			end

			if class == "DEATHKNIGHT" then
				EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use [spec:1]Vampiric Blood;[spec:3,nopet]Raise Dead;[spec:3,talent:4/1,pet:Abomination,@focus,harm,nodead][spec:3,talent:4/1,pet:Abomination]Hook;[spec:3,pet:Ghoul,@focus,harm,nodead][spec:3,pet:Ghoul]Leap;[nocombat,noexists]Death Gate;")
				EditMacro("WSxCAGen+B",nil,nil,"")
			elseif class == "WARRIOR" then
				EditMacro("WSxGen+B",nil,nil,"#showtooltip [nospec:3]Commanding Shout;Last Stand;")
				EditMacro("WSxCAGen+B",nil,nil,"")
			end
			
			if class == "DRUID" then
				if playerspec == 1 then
					EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Regrowth;[@\"..B..\"]Regrowth\", nil)print(\"Tank set to : \"..B)else print(\"Cannot change assist now!\")end")
					EditMacro("WSxGen+B",nil,nil,"#showtooltip Languages")
				elseif playerspec == 2 then
					EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Regrowth;[@\"..B..\"]Regrowth\", nil)print(\"Tank set to : \"..B)else print(\"Cannot change assist now!\")end")
					EditMacro("WSxGen+B",nil,nil,"#showtooltip Languages")
				elseif playerspec == 3 then
					EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Regrowth;[@\"..B..\"]Regrowth\", nil)print(\"Tank set to : \"..B)else print(\"Cannot change assist now!\")end")
					EditMacro("WSxGen+B",nil,nil,"#showtooltip Languages")
				else
					EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen+B\",nil,nil,\"/use [mod:shift,@\"..B..\"]Regrowth;[@\"..B..\"]Lifebloom\\n/stopspelltarget\", nil)print(\"Tank set to : \"..B)else print(\"Cannot change assist now!\")end")
					EditMacro("WSxGen+B",nil,nil,"#showtooltip Languages")
				end
			end

			if class == "DEMONHUNTER" then
				EditMacro("WSxGen+B",nil,nil,"#showtooltip\n/use [spec:1talent:4/1]Netherwalk;Glide;")
				EditMacro("WSxCAGen+B",nil,nil,"")
			end

		-- Macro "N" for button N and Shift+N, Earth Shield, Holy Shock on Tank etc. Need research on effective /cast @friendlytarget macros. Is it possible to use "/targetexact "..N" Earth Shield") - Edra Fixet syntax error with escaping quotes with \"\", genious; Have Ctrl+Alt+N keybind for WSxCAGen+N, then natural N for executing macro#2 with shift modifier allowed. Re-assign keybind for Openallbags and open character pane.

			if class == "SHAMAN" then
				EditMacro("WSxGen+N",nil,nil,"#showtooltip Reincarnation")
				EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"\\#showtooltip Reincarnation\\n/use [mod:shift,@\"..N..\"]Healing Surge;[@\"..N..\"]Riptide\", nil)print(\"Tank#2 set to : \"..N)else print(\"Cannot change assist now!\")end")
			elseif class == "MAGE" then
				EditMacro("WSxGen+N",nil,nil,"#showtooltip [spec:3]Cold Snap;Invisibility\n/use Cold Snap")
				EditMacro("WSxCAGen+N",nil,nil,"")
			elseif class == "WARLOCK" then
				EditMacro("WSxGen+N",nil,nil,"#showtooltip\n/use [@mouseover,help,exists][]Soulstone")
				EditMacro("WSxCAGen+N",nil,nil,"")
			elseif class == "MONK" then
				EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Effuse;[@\"..N..\"]Enveloping Mist\", nil)print(\"Tank#2 set to : \"..N)else print(\"Cannot change assist now!\")end")
				EditMacro("WSxGen+N",nil,nil,"#showtooltip\n/use Effuse")
			elseif class == "PALADIN" then
				EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"\\#showtooltip Lay on Hands\\n/use [mod:shift,@\"..N..\"]Flash of Light;[@\"..N..\"]Holy Shock\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat Locked!\")end")
			elseif class == "HUNTER" then
				EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [@\"..N..\"]Misdirection\\n/stopspelltarget\", nil)print(\"Tank#2 set to : \"..N)else print(\"Error: Combat Lock!\")end")
				EditMacro("WSxGen+N",nil,nil,"#showtooltip [spec:3]Harpoon;Misdirection\n/use [spec:3] Harpoon\n/targetenemy [noexists]")
			elseif class == "ROGUE" then
				EditMacro("WSxGen+N",nil,nil,"#showtooltip Sprint")
				EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"\\#showtooltip Sprint\\n/use [@\"..N..\"]Tricks of the Trade\\n/stopspelltarget\", nil)print(\"Tricks#2 set to : \"..N)else print(\"Combat Lockdown!\")end")
			end

		-- Prist code for "N" offtank bind.
			if class == "PRIEST" then
				if playerspec == 1 then
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Shadow Mend;[@\"..N..\"]Power Word: Shield\", nil)print(N..\" Is Tank#2\")else print(\"Combat!\")end")
					EditMacro("WSxGen+N",nil,nil,"#showtooltip\n/use Power Word: Shield")
				elseif playerspec == 2 then
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Flash Heal;[spec:2,@\"..N..\"]Prayer of Mending;[@\"..N..\"]Power Word: Shield\", nil)print(N..\" Is Tank#2\")else print(\"Combat!\")end")
					EditMacro("WSxGen+N",nil,nil,"#showtooltip\n/use Prayer Of Mending")
				else
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Shadow Mend;[@\"..N..\"]Power Word: Shield\", nil)print(N..\" Is Tank#2\")else print(\"Combat!\")end")
					EditMacro("WSxGen+N",nil,nil,"#showtooltip\n/use Power Word: Shield")
				end
			end

			if class == "DEATHKNIGHT" then
				EditMacro("WSxGen+N",nil,nil,"#showtooltip\n/use [@mouseover,exists][]Raise Ally")
				EditMacro("WSxCAGen+N",nil,nil,"")
			elseif class == "WARRIOR" then
				EditMacro("WSxGen+N",nil,nil,"#showtooltip [nospec:3]Commanding Shout;Last Stand;")
				EditMacro("WSxCAGen+N",nil,nil,"")
			end
			
			if class == "DRUID" then
				if playerspec == 1 then
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Regrowth;[@\"..N..\"]Regrowth\", nil)print(\"Tank set to : \"..N)else print(\"Cannot change assist now!\")end")
					EditMacro("WSxGen+N",nil,nil,"#showtooltip Languages")
				elseif playerspec == 2 then
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Regrowth;[@\"..N..\"]Regrowth\", nil)print(\"Tank set to : \"..N)else print(\"Cannot change assist now!\")end")
					EditMacro("WSxGen+N",nil,nil,"#showtooltip Languages")
				elseif playerspec == 3 then
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Regrowth;[@\"..N..\"]Regrowth\", nil)print(\"Tank set to : \"..N)else print(\"Cannot change assist now!\")end")
					EditMacro("WSxGen+N",nil,nil,"#showtooltip Languages")
				else
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen+N\",nil,nil,\"/use [mod:shift,@\"..N..\"]Regrowth;[@\"..N..\"]Lifebloom\\n/stopspelltarget\", nil)print(\"Tank set to : \"..N)else print(\"Cannot change assist now!\")end")
					EditMacro("WSxGen+N",nil,nil,"#showtooltip Languages")
				end
			end

			if class == "DEMONHUNTER" then
				EditMacro("WSxGen+N",nil,nil,"#showtooltip Glide")
				EditMacro("WSxCAGen+N",nil,nil,"")
			end
		
		-- Macro for CCing Healers 1,2,3 with [mod:shift]CC2;CC1; Set CC bundet till Ctrl+Alt+10,11,12, set cc borde vara bundet till [mod:ctrl]Alt+10,11,12. target Wwbghealer+1,2,3 borde vara bundet till 10,11,12 nagaknapparna. set wwbghealer+1,2,3 borde vara bundet till [mod:ctrl,shift,alt] 10,11,12 nagaknapparna.
		if class == "SHAMAN" then
			EditMacro("WSxSCC+1",nil,nil,"/run if not InCombatLockdown()then local C=UnitName(\"target\") EditMacro(\"WSxCC+1\",nil,nil,\"/cleartarget\n/target \"..C..\"\n/use [mod]Hex;[nomod]Wind Shear;\n/targetlasttarget\", nil)print(\"CC1 : \"..C)else print(\"Cannot change assist now!\")end")
			EditMacro("WSxSCC+2",nil,nil,"/run if not InCombatLockdown()then local C=UnitName(\"target\") EditMacro(\"WSxCC+2\",nil,nil,\"/cleartarget\n/target \"..C..\"\n/use [mod]Hex;[nomod]Wind Shear;\n/targetlasttarget\", nil)print(\"CC2 : \"..C)else print(\"Cannot change assist now!\")end")
			EditMacro("WSxSCC+3",nil,nil,"/run if not InCombatLockdown()then local C=UnitName(\"target\") EditMacro(\"WSxCC+3\",nil,nil,\"/cleartarget\n/target \"..C..\"\n/use [mod]Hex;[nomod]Wind Shear;\n/targetlasttarget\", nil)print(\"CC3 : \"..C)else print(\"Cannot change assist now!\")end")
		elseif class == "MAGE" then
			EditMacro("WSxSCC+1",nil,nil,"")
		elseif class == "WARLOCK" then
			EditMacro("WSxSCC+1",nil,nil,"")
		elseif class == "MONK" then
			EditMacro("WSxSCC+1",nil,nil,"")
		elseif class == "PALADIN" then
			EditMacro("WSxSCC+1",nil,nil,"")
		elseif class == "HUNTER" then
			EditMacro("WSxSCC+1",nil,nil,"")
		elseif class == "ROGUE" then
			EditMacro("WSxSCC+1",nil,nil,"")
		elseif class == "PRIEST" then
			EditMacro("WSxSCC+1",nil,nil,"/run if not InCombatLockdown()then local C=UnitName(\"target\") EditMacro(\"WSxCC+1\",nil,nil,\"/cleartarget\n/target \"..C..\"\n/use [mod]Mind Bomb;[nomod]Silence;\n/targetlasttarget\", nil)print(\"CC1 : \"..C)else print(\"Cannot change assist now!\")end")
			EditMacro("WSxSCC+2",nil,nil,"/run if not InCombatLockdown()then local C=UnitName(\"target\") EditMacro(\"WSxCC+2\",nil,nil,\"/cleartarget\n/target \"..C..\"\n/use [mod]Mind Bomb;[nomod]Silence;\n/targetlasttarget\", nil)print(\"CC2 : \"..C)else print(\"Cannot change assist now!\")end")
			EditMacro("WSxSCC+3",nil,nil,"/run if not InCombatLockdown()then local C=UnitName(\"target\") EditMacro(\"WSxCC+3\",nil,nil,\"/cleartarget\n/target \"..C..\"\n/use [mod]Mind Bomb;[nomod]Silence;\n/targetlasttarget\", nil)print(\"CC3 : \"..C)else print(\"Cannot change assist now!\")end")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSxSCC+1",nil,nil,"")
		elseif class == "WARRIOR" then
			EditMacro("WSxSCC+1",nil,nil,"")
		elseif class == "DRUID" then
			EditMacro("WSxSCC+1",nil,nil,"")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSxSCC+1",nil,nil,"")
		end

		-- Arena Combat CC - Arena 1,2,3
		if class == "SHAMAN" then
			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1]Hex;[mod:ctrl,@arena1]Purge;[@arena1,exists][@boss1,exists]Wind Shear;\n/script SelectGossipOption(1, true)") 
			EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2]Hex;[mod:ctrl,@arena2]Purge;[@arena2,exists][@boss2,exists]Wind Shear;\n/script SelectGossipAvailableQuest(1);AcceptQuest(1);")
			EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3]Hex;[mod:ctrl,@arena3]Purge;[@arena3,exists][@boss3,exists]Wind Shear;\n/run SelectGossipActiveQuest(1);CompleteQuest();\n/click QuestFrameCompleteQuestButton")
		elseif class == "MAGE" then			
			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1]Polymorph;[mod:ctrl,@arena1]Spellsteal;[@arena1,exists][@boss1,exists]Counterspell;\n/script SelectGossipOption(1, true)")
			EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2]Polymorph;[mod:ctrl,@arena2]Spellsteal;[@arena2,exists][@boss2,exists]Counterspell;\n/script SelectGossipAvailableQuest(1);AcceptQuest(1);")
			EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3]Polymorph;[mod:ctrl,@arena3]Spellsteal;[@arena3,exists][@boss3,exists]Counterspell;\n/run SelectGossipActiveQuest(1); CompleteQuest();\n/click QuestFrameCompleteQuestButton")
		elseif class == "WARLOCK" then
			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1]Fear;[mod:ctrl,@arena1] Dispel Magic; [@arena1] Silence;\n/script SelectGossipOption(1, true)")
			EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2]Fear;[mod:ctrl,@arena2] Dispel Magic; [@arena2] Silence;\n/script SelectGossipAvailableQuest(1);AcceptQuest(1);")
			EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3]Fear;[mod:ctrl,@arena3] Dispel Magic; [@arena3] Silence;\n/run SelectGossipActiveQuest(1); CompleteQuest();\n/click QuestFrameCompleteQuestButton")
		elseif class == "MONK" then
			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1]Paralysis;[mod:ctrl,@arena1]Dispel Magic;[@arena1,exists][@boss1,exists]Spear Hand Strike;\n/script SelectGossipOption(1, true)")
			EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2]Paralysis;[mod:ctrl,@arena2]Dispel Magic;[@arena2,exists][@boss2,exists]\n/script SelectGossipAvailableQuest(1);AcceptQuest(1);")
			EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3]Paralysis;[mod:ctrl,@arena3]Dispel Magic;[@arena3,exists][@boss3,exists]\n/run SelectGossipActiveQuest(1); CompleteQuest();\n/click QuestFrameCompleteQuestButton")
		elseif class == "PALADIN" then
			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1,talent:3/2]Repentance;[mod:ctrl,@arena1]Dispel Magic;[@arena1,exists][@boss1,exists]Rebuke;\n/script SelectGossipOption(1, true)")
			EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2,talent:3/2]Repentance;[mod:ctrl,@arena2]Dispel Magic;[@arena2,exists][@boss2,exists]Rebuke;\n/script SelectGossipAvailableQuest(1);AcceptQuest(1);")
			EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3,talent:3/2]Repentance;[mod:ctrl,@arena3]Dispel Magic;[@arena3,exists][@boss3,exists]Rebuke;\n/run SelectGossipActiveQuest(1);CompleteQuest();\n/click QuestFrameCompleteQuestButton")
		elseif class == "HUNTER" then
			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1] Mind Bomb; [mod:ctrl,@arena1] Dispel Magic;[@arena1,exists][@boss1,exists]Counter Shot;\n/script SelectGossipOption(1, true)")
			EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2] Mind Bomb; [mod:ctrl,@arena2] Dispel Magic;[@arena2,exists][@boss2,exists]Counter Shot;\n/script SelectGossipAvailableQuest(1);AcceptQuest(1);")
			EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3] Mind Bomb; [mod:ctrl,@arena3] Dispel Magic;[@arena3,exists][@boss3,exists]Counter Shot;\n/run SelectGossipActiveQuest(1); CompleteQuest();\n/click QuestFrameCompleteQuestButton")
		elseif class == "ROGUE" then
			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1]Blind;[mod:ctrl,@arena1] Dispel Magic;[@arena1,exists][@boss1,exists]Kick;\n/use [@arena1,exists][@boss1,exists]Shadowstep;\n/script SelectGossipOption(1, true)")
			EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2]Blind;[mod:ctrl,@arena2] Dispel Magic;[@arena2,exists][@boss2,exists]Kick;\n/use [@arena2,exists][@boss2,exists]Shadowstep\n/script SelectGossipAvailableQuest(1);AcceptQuest(1);")
			EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3]Blind;[mod:ctrl,@arena3] Dispel Magic;[@arena3,exists][@boss3,exists]Kick;\n/use [@arena3,exists][@boss3,exists]Shadowstep\n/run SelectGossipActiveQuest(1); CompleteQuest();\n/click QuestFrameCompleteQuestButton")
		elseif class == "PRIEST" then
			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1]Mind Bomb;[mod:ctrl,@arena1]Dispel Magic;[@arena1]Silence;\n/script SelectGossipOption(1, true)")
			EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2]Mind Bomb;[mod:ctrl,@arena2]Dispel Magic;[@arena2]Silence;\n/script SelectGossipAvailableQuest(1);AcceptQuest(1);")
			EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3]Mind Bomb;[mod:ctrl,@arena3]Dispel Magic;[@arena3]Silence;\n/run SelectGossipActiveQuest(1);CompleteQuest();\n/click QuestFrameCompleteQuestButton")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1]Asphyxiate;[mod:ctrl,@arena1]Dark Simulacrum;[@arena1,exists][@boss1,exists]Mind Freeze;\n/script SelectGossipOption(1, true)")
			EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2]Asphyxiate;[mod:ctrl,@arena2]Dark Simulacrum;[@arena2,exists][@boss2,exists]Mind Freeze;\n/script SelectGossipAvailableQuest(1);AcceptQuest(1);")
			EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3]Asphyxiate;[mod:ctrl,@arena3]Dark Simulacrum;[@arena3,exists][@boss3,exists]Mind Freeze;\n/run SelectGossipActiveQuest(1); CompleteQuest();\n/click QuestFrameCompleteQuestButton")
		elseif class == "WARRIOR" then
			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1]Storm Bolt;[mod:ctrl,@arena1]Charge;[@arena1,exists][@boss1,exists]Pummel;\n/script SelectGossipOption(1, true)")
			EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2]Storm Bolt;[mod:ctrl,@arena2]Charge;[@arena2,exists][@boss2,exists]Pummel;\n/script SelectGossipAvailableQuest(1);AcceptQuest(1);")
			EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3]Storm Bolt;[mod:ctrl,@arena3]Charge;[@arena3,exists][@boss3,exists]Pummel;\n/run SelectGossipActiveQuest(1); CompleteQuest();\n/click QuestFrameCompleteQuestButton")
		elseif class == "DRUID" then
			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1]Cyclone;[mod:ctrl,@arena1]Entangling Roots;[spec:2/3,@arena1,exists][spec:2/3,@boss1,exists]Skull Bash;[@arena1,exists][@boss1,exists]Solar Beam;\n/script SelectGossipOption(1, true)")
			EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2]Cyclone;[mod:ctrl,@arena2]Entangling Roots;[spec:2/3,@arena2,exists][spec:2/3,@boss2,exists]Skull Bash;[@arena2,exists][@boss2,exists]Solar Beam;\n/script SelectGossipAvailableQuest(1);AcceptQuest(1);")
			EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3]Cyclone;[mod:ctrl,@arena3]Entangling Roots;[spec:2/3,@arena3,exists][spec:2/3,@boss3,exists]Skull Bash;[@arena3,exists][@boss3,exists]Solar Beam;\n/run SelectGossipActiveQuest(1); CompleteQuest();\n/click QuestFrameCompleteQuestButton")
		elseif class == "DEMONHUNTER" then
			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1]Imprison;[mod:ctrl,@arena1]Throw Glaive;[@arena1,exists][@boss1,exists]Consume Magic;\n/script SelectGossipOption(1, true)")
			EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2]Imprison;[mod:ctrl,@arena2]Throw Glaive;[@arena2,exists][@boss2,exists]Consume Magic;\n/script SelectGossipAvailableQuest(1);AcceptQuest(1);")
			EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3]Imprison;[mod:ctrl,@arena3]Throw Glaive;[@arena3,exists][@boss3,exists]Consume Magic;\n/run SelectGossipActiveQuest(1); CompleteQuest();\n/click QuestFrameCompleteQuestButton")
		end
			
		-- Party Dispels - Party 1,2,3
		if class == "SHAMAN" then
			EditMacro("WMPAlt+4",nil,nil,"/target [nomod]Boss1\n/target [nomod]Arena1\n/use [mod:ctrl,@party1]Cleanse Spirit\n/run DepositReagentBank();\n/use Ash-Covered Horn\n/use Majestic Elderhorn Hoof")
			EditMacro("WMPAlt+5",nil,nil,"/target [nomod]Boss2\n/target [nomod]Arena2\n/use [mod:ctrl,@party2]Cleanse Spirit\n/use Moroes' Famous Polish\n/use Darkmoon Cannon\n/use Emerald Winds\n/use Baarut the Brisk")
			EditMacro("WMPAlt+6",nil,nil,"/target [nomod]Boss3\n/target [nomod]Arena3\n/use [mod:ctrl,@party3]Cleanse Spirit\n/use Ever-Blooming Frond\n/use The \"Devilsaur\" Lunchbox\n/use Ley-Enriched Water\n/use Conjured Mana Bun")
		elseif class == "MAGE" then
			EditMacro("WMPAlt+4",nil,nil,"/target [nomod]Boss1\n/target [nomod]Arena1\n/use [mod:ctrl,@party1]\n/run DepositReagentBank();\n/use Ash-Covered Horn\n/use Majestic Elderhorn Hoof")
			EditMacro("WMPAlt+5",nil,nil,"/target [nomod]Boss2\n/target [nomod]Arena2\n/use [mod:ctrl,@party2]\n/use Moroes' Famous Polish\n/use Darkmoon Cannon\n/use Emerald Winds\n/use Baarut the Brisk")
			EditMacro("WMPAlt+6",nil,nil,"/target [nomod]Boss3\n/target [nomod]Arena3\n/use [mod:ctrl,@party3]\n/use Ever-Blooming Frond\n/use The \"Devilsaur\" Lunchbox\n/use Ley-Enriched Water\n/use Conjured Mana Bun")
		elseif class == "WARLOCK" then
			EditMacro("WMPAlt+4",nil,nil,"/target [nomod]Boss1\n/target [nomod]Arena1\n/use [mod:ctrl,@party1]Singe Magic\n/run DepositReagentBank();\n/use Ash-Covered Horn\n/use Majestic Elderhorn Hoof")
			EditMacro("WMPAlt+5",nil,nil,"/target [nomod]Boss2\n/target [nomod]Arena2\n/use [mod:ctrl,@party2]Singe Magic\n/use Moroes' Famous Polish\n/use Darkmoon Cannon\n/use Emerald Winds\n/use Baarut the Brisk")
			EditMacro("WMPAlt+6",nil,nil,"/target [nomod]Boss3\n/target [nomod]Arena3\n/use [mod:ctrl,@party3]Singe Magic\n/use Ever-Blooming Frond\n/use The \"Devilsaur\" Lunchbox\n/use Ley-Enriched Water\n/use Conjured Mana Bun")
		elseif class == "MONK" then
			EditMacro("WMPAlt+4",nil,nil,"/target [nomod]Boss1\n/target [nomod]Arena1\n/use [mod:ctrl,@party1]Detox\n/run DepositReagentBank();\n/use Ash-Covered Horn\n/use Majestic Elderhorn Hoof")
			EditMacro("WMPAlt+5",nil,nil,"/target [nomod]Boss2\n/target [nomod]Arena2\n/use [mod:ctrl,@party2]Detox\n/use Moroes' Famous Polish\n/use Darkmoon Cannon\n/use Emerald Winds\n/use Baarut the Brisk")
			EditMacro("WMPAlt+6",nil,nil,"/target [nomod]Boss3\n/target [nomod]Arena3\n/use [mod:ctrl,@party3]Detox\n/use Ever-Blooming Frond\n/use The \"Devilsaur\" Lunchbox\n/use Ley-Enriched Water\n/use Conjured Mana Bun")	
		elseif class == "PALADIN" then
			EditMacro("WMPAlt+4",nil,nil,"/target [nomod]Boss1\n/target [nomod]Arena1\n/use [mod:ctrl,@party1]Cleanse\n/run DepositReagentBank();\n/use Ash-Covered Horn\n/use Majestic Elderhorn Hoof")
			EditMacro("WMPAlt+5",nil,nil,"/target [nomod]Boss2\n/target [nomod]Arena2\n/use [mod:ctrl,@party2]Cleanse\n/use Moroes' Famous Polish\n/use Darkmoon Cannon\n/use Emerald Winds\n/use Baarut the Brisk")
			EditMacro("WMPAlt+6",nil,nil,"/target [nomod]Boss3\n/target [nomod]Arena3\n/use [mod:ctrl,@party3]Cleanse\n/use Ever-Blooming Frond\n/use The \"Devilsaur\" Lunchbox\n/use Ley-Enriched Water\n/use Conjured Mana Bun")
		elseif class == "HUNTER" then
			EditMacro("WMPAlt+4",nil,nil,"/target [nomod]Boss1\n/target [nomod]Arena1\n/use [mod:ctrl,@party1]Roar of Sacrifice\n/run DepositReagentBank();\n/use Ash-Covered Horn\n/use Majestic Elderhorn Hoof")
			EditMacro("WMPAlt+5",nil,nil,"/target [nomod]Boss2\n/target [nomod]Arena2\n/use [mod:ctrl,@party2]Roar of Sacrifice\n/use Moroes' Famous Polish\n/use Darkmoon Cannon\n/use Emerald Winds\n/use Baarut the Brisk")
			EditMacro("WMPAlt+6",nil,nil,"/target [nomod]Boss3\n/target [nomod]Arena3\n/use [mod:ctrl,@party3]Roar of Sacrifice\n/use Ever-Blooming Frond\n/use The \"Devilsaur\" Lunchbox\n/use Ley-Enriched Water\n/use Conjured Mana Bun")
		elseif class == "ROGUE" then
			EditMacro("WMPw",nil,nil,"/target [nomod]Boss1\n/target [nomod]Arena1\n/use [mod:ctrl,@party1]Tricks of the Trade\n/run DepositReagentBank();\n/use Ash-Covered Horn\n/use Majestic Elderhorn Hoof")
			EditMacro("WMPAlt+5",nil,nil,"/target [nomod]Boss2\n/target [nomod]Arena2\n/use [mod:ctrl,@party2]Tricks of the Trade\n/use Moroes' Famous Polish\n/use Darkmoon Cannon\n/use Emerald Winds\n/use Baarut the Brisk")
			EditMacro("WMPAlt+6",nil,nil,"/target [nomod]Boss3\n/target [nomod]Arena3\n/use [mod:ctrl,@party3]Tricks of the Trade\n/use Ever-Blooming Frond\n/use The \"Devilsaur\" Lunchbox\n/use Ley-Enriched Water\n/use Conjured Mana Bun")
		elseif class == "PRIEST" then
			EditMacro("WMPAlt+4",nil,nil,"/target [nomod]Boss1\n/target [nomod]Arena1\n/use [mod:ctrl,@party1]Purify Disease\n/run DepositReagentBank();\n/use Ash-Covered Horn\n/use Majestic Elderhorn Hoof")
			EditMacro("WMPAlt+5",nil,nil,"/target [nomod]Boss2\n/target [nomod]Arena2\n/use [mod:ctrl,@party2]Purify Disease\n/use Moroes' Famous Polish\n/use Darkmoon Cannon\n/use Emerald Winds\n/use Baarut the Brisk")
			EditMacro("WMPAlt+6",nil,nil,"/target [nomod]Boss3\n/target [nomod]Arena3\n/use [mod:ctrl,@party3]Purify Disease\n/use Ever-Blooming Frond\n/use The \"Devilsaur\" Lunchbox\n/use Ley-Enriched Water\n/use Conjured Mana Bun")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WMPAlt+4",nil,nil,"/target [nomod]Boss1\n/target [nomod]Arena1\n/use [mod:ctrl,@arena1]Chains of Ice\n/run DepositReagentBank();\n/use Ash-Covered Horn\n/use Majestic Elderhorn Hoof")
			EditMacro("WMPAlt+5",nil,nil,"/target [nomod]Boss2\n/target [nomod]Arena2\n/use [mod:ctrl,@arena2]Chains of Ice\n/use Moroes' Famous Polish\n/use Darkmoon Cannon\n/use Emerald Winds\n/use Baarut the Brisk")
			EditMacro("WMPAlt+6",nil,nil,"/target [nomod]Boss3\n/target [nomod]Arena3\n/use [mod:ctrl,@arena3]Chains of Ice\n/use Ever-Blooming Frond\n/use The \"Devilsaur\" Lunchbox\n/use Ley-Enriched Water\n/use Conjured Mana Bun")
		elseif class == "WARRIOR" then
			EditMacro("WMPAlt+4",nil,nil,"/target [nomod]Boss1\n/target [nomod]Arena1\n/use [mod:ctrl,@party1]Charge\n/run DepositReagentBank();\n/use Ash-Covered Horn\n/use Majestic Elderhorn Hoof")
			EditMacro("WMPAlt+5",nil,nil,"/target [nomod]Boss2\n/target [nomod]Arena2\n/use [mod:ctrl,@party2]Charge\n/use Moroes' Famous Polish\n/use Darkmoon Cannon\n/use Emerald Winds\n/use Baarut the Brisk")
			EditMacro("WMPAlt+6",nil,nil,"/target [nomod]Boss3\n/target [nomod]Arena3\n/use [mod:ctrl,@party3]Charge\n/use Ever-Blooming Frond\n/use The \"Devilsaur\" Lunchbox\n/use Ley-Enriched Water\n/use Conjured Mana Bun")
		elseif class == "DRUID" then
			EditMacro("WMPAlt+4",nil,nil,"/target [nomod]Boss1\n/target [nomod]Arena1\n/use [mod:ctrl,@party1]Remove Corruption\n/run DepositReagentBank();\n/use Ash-Covered Horn\n/use Majestic Elderhorn Hoof")
			EditMacro("WMPAlt+5",nil,nil,"/target [nomod]Boss2\n/target [nomod]Arena2\n/use [mod:ctrl,@party2]Remove Corruption\n/use Moroes' Famous Polish\n/use Darkmoon Cannon\n/use Emerald Winds\n/use Baarut the Brisk")
			EditMacro("WMPAlt+6",nil,nil,"/target [nomod]Boss3\n/target [nomod]Arena3\n/use [mod:ctrl,@party3]Remove Corruption\n/use Ever-Blooming Frond\n/use The \"Devilsaur\" Lunchbox\n/use Ley-Enriched Water\n/use Conjured Mana Bun")
		elseif class == "DEMONHUNTER" then
			EditMacro("WMPAlt+4",nil,nil,"/target [nomod]Boss1\n/target [nomod]Arena1\n/cry\n/run DepositReagentBank();\n/use Ash-Covered Horn\n/use Majestic Elderhorn Hoof")
			EditMacro("WMPAlt+5",nil,nil,"/target [nomod]Boss2\n/target [nomod]Arena2\n/cry\n/use Moroes' Famous Polish\n/use Darkmoon Cannon\n/use Emerald Winds\n/use Baarut the Brisk")
			EditMacro("WMPAlt+6",nil,nil,"/target [nomod]Boss3\n/target [nomod]Arena3\n/cry\n/use Ever-Blooming Frond\n/use The \"Devilsaur\" Lunchbox\n/use Ley-Enriched Water\n/use Conjured Mana Bun")
		end
		
		-- Addon to change content of Extra Action Button/Boss Button Depending on Zone, "ctrl+b"
	
SetMapToCurrentZone()
		local continent = GetCurrentMapContinent()

		if continent == 7 then
			-- Draenor is continent 7
			EditMacro("WSxCGen+B",nil,nil,"#showtooltip\n/cast [mod:shift]Garrison Ability\n/stopmacro [mod]\n/click ExtraActionButton1",1,1)
		elseif continent == 8 then
			-- Broken Isles is continent 8
			EditMacro("WSxCGen+B",nil,nil,"#showtooltip\n/cast [mod:shift]Combat Ally\n/stopmacro [mod]\n/click ExtraActionButton1",1,1)
		else
			EditMacro("WSxCGen+B",nil,nil,"/click ExtraActionButton1")
		end
	end
end

frame:SetScript("OnEvent", eventHandler)




