SLASH_ZIGIALLBUTTONS1 = "/zigi"
local frame = CreateFrame("FRAME", "ZigiAllButtons")
frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
frame:RegisterEvent("BAG_UPDATE_DELAYED")
frame:RegisterUnitEvent("PET_SPECIALIZATION_CHANGED")
frame:RegisterEvent("PET_STABLE_CLOSED")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("VARIABLES_LOADED")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("TRAIT_CONFIG_UPDATED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_LEVEL_UP")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
function SlashCmdList.ZIGIALLBUTTONS(msg, ...)
	if msg == "zonevars" then
		ZigiPrintZoneVars()
	else
		DEFAULT_CHAT_FRAME:AddMessage("Zigi: Known commands are:\n(ZigiAllButtons): zigi zonevars\n(ZigiLevelNewChar): zigiplz eq\n(ZigiLevelNewChar): zigiplz save\n(ZigiLevelNewChar): zigiplz load\n(ZigiLevelNewChar): zigiplz dragonzigi",0.5,1.0,0.0)
	end
end


--[[/use [nomounted]Eternal Black Diamond Ring
/run if IsControlKeyDown() then C_PartyInfo.LeaveParty() elseif IsShiftKeyDown() then LFGTeleport(IsInLFGDungeon()) end
--]]
local _,class = UnitClass("player")
local classSkillList = {
	["SHAMAN"] = { 
		[108285] = "Totemic Recall",
		[117014] = "Elemental Blast",
		[33757] = "Windfury Weapon",
		[8512] = "Windfury Totem",
		[157153] = "Cloudburst Totem",
		[188443] = "Chain Lightning",
		[51514] = "Hex",
		[192106] = "Lightning Shield",
		[198103] = "Earth Elemental",
		[198067] = "Fire Elemental",
		[192249] = "Storm Elemental",
		[370] = "Purge",
		[51533] = "Feral Spirit",
		[17364] = "Stormstrike",
		[974] = "Earth Shield",
		[108281] = "Ancestral Guidance",
		[428332] = "Primordial Wave",
		[375982] = "Primordial Wave",
		[51505] = "Lava Burst",
		[114050] = "Ascendance",
		[382021] = "Earthliving Weapon",
		[198838] = "Earthen Wall Totem",
		[191634] = "Stormkeeper",
		[192063] = "Gust of Wind",
		[61882] = "Earthquake",
		[51485] = "Earthgrab Totem",
		[108280] = "Healing Tide Totem",
		[77472] = "Healing Wave",
		[187874] = "Crash Lightning",
		[196884] = "Feral Lunge",
		[342240] = "Ice Strike",
		[210714] = "Icefury",
		[320125] = "Echoing Shock",
		[79206] = "Spiritwalker's Grace",
		[8042] = "Earth Shock",
		[192222] = "Liquid Magma Totem",
		[16191] = "Mana Tide Totem",
		[108271] = "Astral Shift",
		[8143] = "Tremor Totem",
		[98008] = "Spirit Link Totem",
		[197214] = "Sundering",
		[1064] = "Chain Heal",
		[73920] = "Healing Rain",
		[196840] = "Frost Shock",
		[384352] = "Doom Winds",
		[60103] = "Lava Lash",
		[381930] = "Mana Spring Totem",
		[333974] = "Fire Nova",
		[114051] = "Ascendance",
		[197995] = "Wellspring",
		[207399] = "Ancestral Protection Totem",
		[61295] = "Riptide",
		[192058] = "Capacitor Totem",
		[192077] = "Wind Rush Totem",
		[51490] = "Thunderstorm",
		[378081] = "Nature's Swiftness",
		[114052] = "Ascendance",
		[57994] = "Wind Shear",
		[52127] = "Water Shield",
		[305483] = "Lightning Lasso",
		[108287] = "Totemic Projection",
		[207778] = "Downpour",
		[51886] = "Cleanse Spirit",
		[383009] = "Stormkeeper",
		[383013] = "Poison Cleansing Totem",
		[383017] = "Stoneskin Totem",
		[320137] = "Stormkeeper",
		[382029] = "Ever-Rising Tide",
		[58875] = "Spirit Walk",
		[378773] = "Greater Purge",
		[320746] = "Surge of Earth",
		[383019] = "Tranquil Air Totem",
		[342243] = "Static Discharge",
		[117013] = "Primal Elementalist",
		[5394] = "Healing Stream Totem",
		[73685] = "Unleash Life",
		[546] = "Water Walking",
	},
	["MAGE"] = {
		[390612] = "Frost Bomb",
		[190319] = "Combustion", 
		[31661] = "Dragon's Breath", 
		[116011] = "Rune of Power", 
		[45438] = "Ice Block", 
		[31687] = "Summon Water Elemental", 
		[12472] = "Icy Veins", 
		[365350] = "Arcane Surge",
		[205022] = "Arcane Familiar", 
		[84714] = "Frozen Orb", 
		[110959] = "Greater Invisibility", 
		[30449] = "Spellsteal", 
		[5143] = "Arcane Missiles", 
		[321358] = "Focus Magic", 
		[55342] = "Mirror Image", 
		[153561] = "Meteor", 
		[190356] = "Blizzard", 
		[44425] = "Arcane Barrage", 
		[383121] = "Mass Polymorph", 
		[11366] = "Pyroblast", 
		[44614] = "Flurry", 
		[157997] = "Ice Nova",
		[116] = "Frostbolt", 
		[2120] = "Flamestrike", 
		[108853] = "Fire Blast",
		[319836] = "Fire Blast", 
		[157981] = "Blast Wave", 
		[108839] = "Ice Floes", 
		[12051] = "Evocation", 
		[199786] = "Glacial Spike", 
		[114923] = "Nether Tempest", 
		[66] = "Invisibility", 
		[321507] = "Touch of the Magi", 
		[44457] = "Living Bomb", 
		[759] = "Conjure Mana Gem", 
		[212653] = "Shimmer", 
		[11426] = "Ice Barrier", 
		[257541] = "Phoenix Flames", 
		[235313] = "Blazing Barrier", 
		[153595] = "Comet Storm", 
		[30455] = "Ice Lance", 
		[382440] = "Shifting Power", 
		[257537] = "Ebonbolt", 
		[113724] = "Ring of Frost", 
		[153626] = "Arcane Orb", 
		[235450] = "Prismatic Barrier", 
		[2948] = "Scorch", 
		[389713] = "Displacement", 
		[376103] = "Radiant Spark", 
		[31589] = "Slow", 
		[342245] = "Alter Time", 
		[205021] = "Ray of Frost", 
		[205025] = "Presence of Mind", 
		[235219] = "Cold Snap", 
		[475] = "Remove Curse", 
		[157980] = "Supernova",
		[1449] = "Arcane Explosion",
		[30451] = "Arcane Blast", 
		[120] = "Cone of Cold",
		[122] = "Frost Nova",
		[133] = "Fireball",
		[414664] = "Mass Invisibility",
		[414660] = "Mass Barrier",
	},
	["WARLOCK"] = {
		[105174] = "Hand of Gul'dan",
		[20707] = "Soulstone",
		[1122] = "Summon Infernal",
		[108503] = "Grimoire of Sacrifice",
		[205180] = "Summon Darkglare",
		[80240] = "Havoc",
		[111771] = "Demonic Gateway",
		[265187] = "Summon Demonic Tyrant",
		[48181] = "Haunt",
		[111400] = "Burning Rush",
		[386256] = "Summon Soulkeeper",
		[386344] = "Inquisitor's Gaze",
		[152108] = "Cataclysm",
		[324536] = "Malefic Rapture",
		[278350] = "Vile Taint",
		[104316] = "Call Dreadstalkers",
		[17877] = "Shadowburn",
		[116858] = "Chaos Bolt",
		[6789] = "Mortal Coil",
		[196277] = "Implosion",
		[6353] = "Soul Fire",
		[267217] = "Nether Portal",
		[710] = "Banish",
		[205179] = "Phantom Singularity",
		[196447] = "Channel Demonfire",
		[333889] = "Fel Domination",
		[27243] = "Seed of Corruption",
		[108416] = "Dark Pact",
		[386833] = "Guillotine",
		[316099] = "Unstable Affliction",
		[428344] = "Soul Strike",
		[5740] = "Rain of Fire",
		[30283] = "Shadowfury",
		[17962] = "Conflagrate",
		[267171] = "Demonic Strength",
		[264119] = "Summon Vilefiend",
		[111898] = "Grimoire: Felguard",
		[386997] = "Soul Rot",
		[267211] = "Bilescourge Bombers",
		[264178] = "Demonbolt",
		[385899] = "Soulburn",
		[5484] = "Howl of Terror",
		[603] = "Doom",
		[264130] = "Power Siphon",
		[328774] = "Amplify Curse",
		[387976] = "Dimensional Rift",
		[386951] = "Soul Swap",
		[384069] = "Shadowflame",
		[334275] = "Curse of Exhaustion",
		[1714] = "Curse of Tongues",
		[172] = "Corruption",
		[686] = "Shadow Bolt",
		[980] = "Agony",
		[63106] = "Siphon Life",
		[198590] = "Drain Soul",
	},
	["MONK"] = {
		[322101] = "Expel Harm",
		[399491] = "Sheilun's Gift",
		[261947] = "Fist of the White Tiger",
		[137639] = "Storm, Earth, and Fire",
		[107428] = "Rising Sun Kick",
		[115315] = "Summon Black Ox Statue",
		[115078] = "Paralysis",
		[124682] = "Enveloping Mist",
		[123904] = "Invoke Xuen, the White Tiger",
		[113656] = "Fists of Fury",
		[115175] = "Soothing Mist",
		[388686] = "Summon White Tiger Statue",
		[191837] = "Essence Font",
		[152175] = "Whirling Dragon Punch",
		[115313] = "Summon Jade Serpent Statue",
		[122783] = "Diffuse Magic",
		[115008] = "Chi Torpedo",
		[115151] = "Renewing Mist",
		[152173] = "Serenity",
		[101643] = "Transcendence",
		[123986] = "Chi Burst",
		[132578] = "Invoke Niuzao, the Black Ox",
		[116847] = "Rushing Jade Wind",
		[392983] = "Strike of the Windlord",
		[115098] = "Chi Wave",
		[116849] = "Life Cocoon",
		[116680] = "Thunder Focus Tea",
		[115176] = "Zen Meditation",
		[116844] = "Ring of Peace",
		[325197] = "Invoke Chi-Ji, the Red Crane",
		[119582] = "Purifying Brew",
		[116095] = "Disable",
		[116841] = "Tiger's Lust",
		[122470] = "Touch of Karma",
		[116705] = "Spear Hand Strike",
		[122278] = "Dampen Harm",
		[325153] = "Exploding Keg",
		[124081] = "Zen Pulse",
		[388193] = "Jadefire Stomp",
		[322507] = "Celestial Brew",
		[121253] = "Keg Smash",
		[115181] = "Breath of Fire",
		[322118] = "Invoke Yu'lon, the Jade Serpent",
		[115310] = "Revival",
		[386276] = "Bonedust Brew",
		[196725] = "Refreshing Jade Wind",
		[387184] = "Weapons of Order",
		[115294] = "Mana Tea",
		[115399] = "Black Ox Brew",
		[388615] = "Restoral",
		[101545] = "Flying Serpent Kick",
		[198898] = "Song of Chi-Ji",
		[324312] = "Clash",
		[218164] = "Detox",
		[115450] = "Detox",
		[115288] = "Energizing Elixir",
		[122281] = "Healing Elixir",
		[119381] = "Leg Sweep",
		[115203] = "Fortifying Brew",
	},
	["PALADIN"] = {
		[121183] = "Contemplation",
		[183435] = "Retribution Aura",
		[85256] = "Templar's Verdict",
		[31884] = "Avenging Wrath",
		[53563] = "Beacon of Light",
		[183998] = "Light of the Martyr",
		[20271] = "Judgment",
		[26573] = "Consecration",
		[391054] = "Intercession",
		[35395] = "Crusader Strike",
		[1022] = "Blessing of Protection",
		[231895] = "Crusade",
		[152262] = "Seraphim",
		[6940] = "Blessing of Sacrifice",
		[20066] = "Repentance",
		[633] = "Lay on Hands",
		[31850] = "Ardent Defender",
		[498] = "Divine Protection",
		[403876] = "Divine Protection",
		[20473] = "Holy Shock",
		[343721] = "Final Reckoning",
		[184662] = "Shield of Vengeance",
		[1044] = "Blessing of Freedom",
		[204019] = "Blessed Hammer",
		[24275] = "Hammer of Wrath",
		[96231] = "Rebuke",
		[200652] = "Tyr's Deliverance",
		[86659] = "Guardian of Ancient Kings",
		[223306] = "Bestow Faith",
		[31935] = "Avenger's Shield",
		[31821] = "Aura Mastery",
		[216331] = "Avenging Crusader",
		[255937] = "Wake of Ashes",
		[200025] = "Beacon of Virtue",
		[190784] = "Divine Steed",
		[210294] = "Divine Favor",
		[343527] = "Execution Sentence",
		[215661] = "Justicar's Vengeance",
		[383185] = "Exorcism",
		[114158] = "Light's Hammer",
		[115750] = "Blinding Light",
		[375576] = "Divine Toll",
		[204018] = "Blessing of Spellwarding",
		[388007] = "Blessing of Summer",
		[85222] = "Light of Dawn",
		[82326] = "Holy Light",
		-- [105809] = "Holy Avenger",
		[148039] = "Barrier of Faith",
		[184575] = "Blade of Justice",
		[378974] = "Bastion of Light",
		[156910] = "Beacon of Faith",
		[183218] = "Hand of Hindrance",
		[327193] = "Moment of Glory",
		[387174] = "Eye of Tyr",
		[53595] = "Hammer of the Righteous",
		[53385] = "Divine Storm",
		[389539] = "Sentinel",
		[10326] = "Turn Evil",
		[214202] = "Rule of Law",
		[205191] = "Eye for an Eye",
		[213644] = "Cleanse Toxins",
		[114165] = "Holy Prism",
		[414273] = "Hand of Divinity",
		[414170] = "Daybreak",
	},
	["HUNTER"] = {
		[272651] = "Command Pet",
		[321297] = "Eyes of the Beast",
		[61648] = "Aspect of the Chameleon",
		[125050] = "Fetch",
		[388045] = "Sentinel Owl",
		[321530] = "Bloodshed",
		[193530] = "Aspect of the Wild",
		[217200] = "Barbed Shot",
		[212431] = "Explosive Shot",
		[34477] = "Misdirection",
		[120360] = "Barrage",
		[120679] = "Dire Beast",
		[34026] = "Kill Command",
		[199483] = "Camouflage",
		[19434] = "Aimed Shot",
		[259489] = "Kill Command",
		[288613] = "Trueshot",
		[19574] = "Bestial Wrath",
		[264735] = "Survival of the Fittest",
		[187698] = "Tar Trap",
		[53209] = "Chimaera Shot",
		[131894] = "A Murder of Crows",
		[109248] = "Binding Shot",
		[260402] = "Double Tap",
		[257044] = "Rapid Fire",
		[53351] = "Kill Shot",
		[19577] = "Intimidation",
		[203415] = "Fury of the Eagle",
		[2643] = "Multi-Shot",
		[19801] = "Tranquilizing Shot",
		[147362] = "Counter Shot",
		[193455] = "Cobra Shot",
		[260243] = "Volley",
		[5116] = "Concussive Shot",
		[375891] = "Death Chakram",
		[213691] = "Scatter Shot",
		[212436] = "Butchery",
		[201430] = "Stampede",
		[236776] = "High Explosive Trap",
		[271788] = "Serpent Sting",
		[320976] = "Kill Shot",
		[359844] = "Call of the Wild",
		[360952] = "Coordinated Assault",
		[186270] = "Raptor Strike",
		[269751] = "Flanking Strike",
		[259387] = "Mongoose Bite",
		[259495] = "Wildfire Bomb",
		[162488] = "Steel Trap",
		[190925] = "Harpoon",
		[186387] = "Bursting Shot",
		[392060] = "Wailing Arrow",
		[360966] = "Spearhead",
		[187708] = "Carve",
		[257620] = "Multi-Shot",
		[1513] = "Scare Beast",
		[342049] = "Chimaera Shot",
		[186289] = "Aspect of the Eagle",
		[187707] = "Muzzle",
		[400456] = "Salvo",
		-- [259391] = "Chakrams",
	},
	["ROGUE"] = {
		[315341] = "Between the Eyes",
		[426591] = "Goremaw's Bite", 
		[8679] = "Wound Poison",
		[315584] = "Instant Poison",
		[1856] = "Vanish",
		[185313] = "Shadow Dance",
		[1833] = "Cheap Shot",
		[36554] = "Shadowstep",
		[185565] = "Poisoned Knife",
		[185763] = "Pistol Shot",
		[114014] = "Shuriken Toss",
		[703] = "Garrote",
		[343142] = "Dreadblades",
		[51723] = "Fan of Knives",
		[13877] = "Blade Flurry",
		[197835] = "Shuriken Storm",
		[13750] = "Adrenaline Rush",
		[360194] = "Deathmark",
		[31224] = "Cloak of Shadows",
		[381637] = "Atrophic Poison",
		[315508] = "Roll the Bones",
		[196937] = "Ghostly Strike",
		[2094] = "Blind",
		[137619] = "Marked for Death",
		[121411] = "Crimson Tempest",
		[57934] = "Tricks of the Trade",
		[5938] = "Shiv",
		[200758] = "Gloomblade",
		[385616] = "Echoing Reprimand",
		[381664] = "Amplifying Poison",
		[381623] = "Thistle Tea",
		[6770] = "Sap",
		[195457] = "Grappling Hook",
		[385627] = "Kingsbane",
		-- [381802] = "Indiscriminate Carnage",
		[1966] = "Feint",
		[1776] = "Gouge",
		[381989] = "Keep It Rolling",
		[121471] = "Shadow Blades",
		[280719] = "Secret Technique",
		[5761] = "Numbing Poison",
		[385424] = "Serrated Bone Spike",
		[2823] = "Deadly Poison",
		[384631] = "Flagellation",
		[5277] = "Evasion",
		[382245] = "Cold Blood",
		[319175] = "Black Powder",
		[51690] = "Killing Spree",
		[200806] = "Exsanguinate",
		[271877] = "Blade Rush",
		[385408] = "Sepsis",
		[277925] = "Shuriken Tornado",
	},
	["PRIEST"] = {
		[139] = "Renew",
		[316262] = "Thoughtsteal",
		[17] = "Power Word: Shield",
		[8122] = "Psychic Scream",
		[453] = "Mind Soothe",	
		[19236] = "Desperate Prayer",
		[589] = "Shadow Word: Pain",
		[2060] = "Heal",
		[47540] = "Penance",
		[34914] = "Vampiric Touch",
		[232698] = "Shadowform",
		[8092] = "Mind Blast",
		[14914] = "Holy Fire",
		[10060] = "Power Infusion",
		[373481] = "Power Word: Life",
		[34433] = "Shadowfiend",
		[605] = "Mind Control",
		[48045] = "Mind Sear",
		[528] = "Dispel Magic",
		[123040] = "Mindbender",
		[32375] = "Mass Dispel",
		[73510] = "Mind Spike",
		[391109] = "Dark Ascension",
		[139] = "Renew",
		[33206] = "Pain Suppression",
		[204197] = "Purge the Wicked",
		[121536] = "Angelic Feather",
		[372760] = "Divine Word",
		[596] = "Prayer of Healing",
		[47788] = "Guardian Spirit",
		[9484] = "Shackle Undead",
		[424509] = "Schism",
		[228260] = "Void Eruption",
		[64901] = "Symbol of Hope",
		[335467] = "Devouring Plague",
		[372616] = "Empyreal Blaze",
		[15286] = "Vampiric Embrace",
		[73325] = "Leap of Faith",
		[205385] = "Shadow Crash",
		[33076] = "Prayer of Mending",
		[32379] = "Shadow Word: Death",
		[120517] = "Halo",
		[194509] = "Power Word: Radiance",
		[375901] = "Mindgames",
		[110744] = "Divine Star",
		[263165] = "Void Torrent",
		[265202] = "Holy Word: Salvation",
		[2050] = "Holy Word: Serenity",
		[200183] = "Apotheosis",
		[88625] = "Holy Word: Chastise",
		[200174] = "Mindbender",
		[132157] = "Holy Nova",
		[204883] = "Circle of Healing",
		[373178] = "Light's Wrath",
		[62618] = "Power Word: Barrier",
		[108968] = "Void Shift",
		[34861] = "Holy Word: Sanctify",
		[246287] = "Evangelism",
		[47536] = "Rapture",
		[129250] = "Power Word: Solace",
		[64843] = "Divine Hymn",
		[314867] = "Shadow Covenant",
		[205364] = "Dominate Mind",
		[15487] = "Silence",
		[120644] = "Halo",
		[108920] = "Void Tendrils",
		[64044] = "Psychic Horror",
		[47585] = "Dispersion",
		[263346] = "Dark Void",
		[372835] = "Lightwell",
		[213634] = "Purify Disease",
		[122121] = "Divine Star",
		[421453] = "Ultimate Penitence",
	},
	["DEATHKNIGHT"] = {
		[127344] = "Corpse Exploder",
		[49039] = "Lichborne",
		[47568] = "Empower Rune Weapon",
		[316239] = "Rune Strike",
		[42650] = "Army of the Dead",
		[49206] = "Summon Gargoyle",
		[152279] = "Breath of Sindragosa",
		[63560] = "Dark Transformation",
		[343294] = "Soul Reaper",
		[212552] = "Wraith Walk",
		[49028] = "Dancing Rune Weapon",
		[115989] = "Unholy Blight",
		[46584] = "Raise Dead",
		[49184] = "Howling Blast",
		[195182] = "Marrowrend",
		[206930] = "Heart Strike",
		[206931] = "Blooddrinker",
		[51052] = "Anti-Magic Zone",
		[219809] = "Tombstone",
		[207230] = "Frostscythe",
		[383269] = "Abomination Limb",
		[111673] = "Control Undead",
		[221562] = "Asphyxiate",
		[195292] = "Death's Caress",
		[207289] = "Unholy Assault",
		[49998] = "Death Strike",
		[221699] = "Blood Tap",
		[108199] = "Gorefiend's Grasp",
		[85948] = "Festering Strike",
		[390279] = "Vile Contagion",
		[207317] = "Epidemic",
		[194679] = "Rune Tap",
		[207311] = "Clawing Shadows",
		[279302] = "Frostwyrm's Fury",
		[50842] = "Blood Boil",
		[51271] = "Pillar of Frost",
		[196770] = "Remorseless Winter",
		[207167] = "Blinding Sleet",
		[45524] = "Chains of Ice",
		[194913] = "Glacial Advance",
		[77575] = "Outbreak",
		[48792] = "Icebound Fortitude",
		[275699] = "Apocalypse",
		[305392] = "Chill Streak",
		[55233] = "Vampiric Blood",
		[108194] = "Asphyxiate",
		[48707] = "Anti-Magic Shell",
		[194844] = "Bonestorm",
		[49143] = "Frost Strike",
		[55090] = "Scourge Strike",
		[49020] = "Obliterate",
		[327574] = "Sacrificial Pact",
		[46585] = "Raise Dead",
		[47528] = "Mind Freeze",
		[152280] = "Defile",
		[57330] = "Horn of Winter",
		[48743] = "Death Pact",
		[206940] = "Mark of Blood",
		[321995] = "Hypothermic Presence",
		[274156] = "Consumption",
	},
	["WARRIOR"] = {
		[20243] = "Devastate",
		[1719] = "Recklessness",
		[227847] = "Bladestorm",
		[401150] = "Avatar",
		[107574] = "Avatar",
		[190456] = "Ignore Pain",
		[772] = "Rend",
		[280772] = "Siegebreaker",
		[6572] = "Revenge",
		[23881] = "Bloodthirst",
		[23920] = "Spell Reflection",
		[167105] = "Colossus Smash",
		[85288] = "Raging Blow",
		[97462] = "Rallying Cry",
		[184367] = "Rampage",
		[152277] = "Ravager",
		[12294] = "Mortal Strike",
		[1160] = "Demoralizing Shout",
		[202168] = "Impending Victory",
		[118038] = "Die by the Sword",
		[385059] = "Odyn's Fury",
		[5246] = "Intimidating Shout",
		[384318] = "Thunderous Roar",
		[6544] = "Heroic Leap",
		[6343] = "Thunder Clap",
		[396719] = "Thunder Clap",
		[18499] = "Berserker Rage",
		[871] = "Shield Wall",
		[845] = "Cleave",
		[7384] = "Overpower",
		[197690] = "Defensive Stance",
		[383762] = "Bitter Immunity",
		[385952] = "Shield Charge",
		[184364] = "Enraged Regeneration",
		[386208] = "Defensive Stance",
		[46924] = "Bladestorm",
		[228920] = "Ravager",
		[260708] = "Sweeping Strikes",
		[118000] = "Dragon Roar",
		[262161] = "Warbreaker",
		[386164] = "Battle Stance",
		[386196] = "Berserker Stance",
		[3411] = "Intervene",
		[315720] = "Onslaught",
		[107570] = "Storm Bolt",
		[46968] = "Shockwave",
		[394062] = "Rend",
		[12975] = "Last Stand",
		[376079] = "Champion's Spear",
		[64382] = "Shattering Throw",
		[12323] = "Piercing Howl",
		[384090] = "Titanic Throw",
		[392966] = "Spell Block",
		[262228] = "Deadly Calm",
		[1161] = "Challenging Shout",
		[260643] = "Skullsplitter",
		[384110] = "Wrecking Throw",
		[384100] = "Berserker Shout",
		[386071] = "Disrupting Shout",
	},
	["DRUID"] = { 
		[18960] = "Teleport: Moonglade",
		[193753] = "Dreamwalk",
		[339] = "Entangling Roots",
		[50334] = "Berserk",
		[88423] = "Nature's Cure",
		[194223] = "Celestial Alignment",
		[106951] = "Berserk",
		[213764] = "Swipe",
		[102401] = "Wild Charge",
		[124974] = "Nature's Vigil",
		[1822] = "Rake",
		[202770] = "Fury of Elune",
		[191034] = "Starfall",
		[774] = "Rejuvenation",
		[2637] = "Hibernate",
		[1079] = "Rip",
		[274837] = "Feral Frenzy",
		[24858] = "Moonkin Form",
		[33786] = "Cyclone",
		[202347] = "Stellar Flare",
		[29166] = "Innervate",
		[22842] = "Frenzied Regeneration",
		[78674] = "Starsurge",
		[33763] = "Lifebloom",
		[5217] = "Tiger's Fury",
		[197721] = "Flourish",
		[205636] = "Force of Nature",
		[48438] = "Wild Growth",
		[319454] = "Heart of the Wild",
		[200851] = "Rage of the Sleeper",
		[52610] = "Savage Roar",
		[391528] = "Convoke the Spirits",
		[93402] = "Sunfire",
		[106839] = "Skull Bash",
		[285381] = "Primal Wrath",
		[61336] = "Survival Instincts",
		[102351] = "Cenarion Ward",
		[33891] = "Incarnation: Tree of Life",
		[102560] = "Incarnation: Chosen of Elune",
		[102543] = "Incarnation: Avatar of Ashamane",
		[102558] = "Incarnation: Guardian of Ursoc",
		[252216] = "Tiger Dash",
		[18562] = "Swiftmend",
		[391888] = "Adaptive Swarm",
		[132158] = "Nature's Swiftness",
		[145205] = "Efflorescence",
		[88747] = "Wild Mushroom",
		[202359] = "Astral Communion",
		[194153] = "Starfire",
		[102342] = "Ironbark",
		[202028] = "Brutal Slash",
		[108238] = "Renewal",
		[2908] = "Soothe",
		[78675] = "Solar Beam",
		[192081] = "Ironfur",
		[740] = "Tranquility",
		[202425] = "Warrior of Elune",
		[102793] = "Ursol's Vortex",
		[99] = "Incapacitating Roar",
		[5211] = "Mighty Bash",
		[6807] = "Maul",
		[2782] = "Remove Corruption",
		[106832] = "Thrash",
		[132469] = "Typhoon",
		[274281] = "New Moon",
		[22570] = "Maim",
		[106898] = "Stampeding Roar",
		[102359] = "Mass Entanglement",
		[80313] = "Pulverize",
		[155835] = "Bristling Fur",
		[392160] = "Invigorate",
		[203651] = "Overgrowth",
		[197626] = "Starsurge",
		[197628] = "Starfire",
		[50464] = "Nourish",
		[102693] = "Grove Guardians",
		[204066] = "Lunar Beam",
		[197625] = "Moonkin Form",
	},
	["DEMONHUNTER"] = {
		[198589] = "Blur",
		[258920] = "Immolation Aura",
		[203720] = "Demon Spikes",
		[198013] = "Eye Beam",
		[258860] = "Essence Break",
		[247454] = "Spirit Bomb",
		[198793] = "Vengeful Retreat",
		[342817] = "Glaive Tempest",
		[204021] = "Fiery Brand",
		[278326] = "Consume Magic",
		[207684] = "Sigil of Misery",
		[217832] = "Imprison",
		[370965] = "The Hunt",
		[204596] = "Sigil of Flame",
		[196718] = "Darkness",
		[196555] = "Netherwalk",
		[212084] = "Fel Devastation",
		[263642] = "Fracture",
		[232893] = "Felblade",
		[207407] = "Soul Carver",
		[179057] = "Chaos Nova",
		[202137] = "Sigil of Silence",
		[211881] = "Fel Eruption",
		[202138] = "Sigil of Chains",
		[390163] = "Elysian Decree",
		[258925] = "Fel Barrage",
		[263648] = "Soul Barrier",
		[320341] = "Bulk Extraction",
	},
	["EVOKER"] = { 
		[364343] = "Echo",
		[374968] = "Time Spiral",
		[370452] = "Shattering Star",
		[375087] = "Dragonrage",
		[360995] = "Verdant Embrace",
		[359073] = "Eternity Surge",
		[368432] = "Unravel",
		[363534] = "Rewind",
		[372048] = "Oppressing Roar",
		[370665] = "Rescue",
		[374227] = "Zephyr",
		[363916] = "Obsidian Scales",
		[357170] = "Time Dilation",
		[351338] = "Quell",
		[357211] = "Pyre",
		[355936] = "Dream Breath",
		[374251] = "Cauterizing Flame",
		[365585] = "Expunge",
		[370553] = "Tip the Scales",
		[360806] = "Sleep Walk",
		[358385] = "Landslide",
		[367226] = "Spiritbloom",
		[368847] = "Firestorm",
		[370537] = "Stasis",
		[373861] = "Temporal Anomaly",
		[359816] = "Dream Flight(Green)",
		[366155] = "Reversion",
		[369459] = "Source of Magic",
		[370960] = "Emerald Communion",
		[374348] = "Renewing Blaze",
		[407876] = "Accretion",
		[407869] = "Anachronism",
		[407243] = "Aspects' Favor",
		[408233] = "Bestow Weyrnstone",
		[360827] = "Blistering Scales",
		[403631] = "Breath of Eons",
		[409676] = "Chrono Ward",
		[404195] = "Defy Fate",
		[403264] = "Black Attunement",
		[403265] = "Bronze Attunement",
		[414969] = "Dream of Spring",
		[395152] = "Ebon Might",
		[410784] = "Echoing Strike",
		[395160] = "Eruption",
		[375722] = "Essence Attunement",
		[396187] = "Essence Burst",
		[412774] = "Fate Mirror",
		[408083] = "Font of Magic",
		[410787] = "Geomancy",
		[375796] = "Hoarded Power",
		[408775] = "Ignition Rush",
		[371016] = "Imposing Presence",
		[410261] = "Inferno's Blessing",
		[412713] = "Interwoven Threads",
		[410643] = "Molten Blood",
		[408004] = "Momentum Shift",
		[409267] = "Motes of Possibility",
		[410260] = "Overlord",
		[410253] = "Perilous Fate",
		[407866] = "Plot the Future",
		[369908] = "Power Nexus",
		[409311] = "Prescience",
		[410687] = "Prolong Life",
		[407814] = "Pupil of Alexstrasza",
		[409329] = "Reactive Hide",
		[406907] = "Regenerative Chitin",
		[406659] = "Ricocheting Pyroclast",
		[408543] = "Seismic Slam",
		[406732] = "Spatial Paradox",
		[410352] = "Stretch Time",
		[410685] = "Symbiotic Bloom",
		[408002] = "Tectonic Locus",
		[404977] = "Time Skip",
		[412710] = "Timelessness",
		[412723] = "Tomorrow, Today",
		[412733] = "Unyielding Domain",
		[396286] = "Upheaval",
		[406904] = "Volcanism",
		[371806] = "Deep Breath",
	},
}
local commandPetAbilities = {
	["HUNTER"] = {
		[272682] = "Master's Call",
		[272679] = "Fortitude of the Bear",
	}
}

local function bPet(spellName, macroCond, semiCol)
	if not InCombatLockdown() then 
		for k,v in pairs(commandPetAbilities[class]) do
			if v == spellName then
				if IsSpellKnownOrOverridesKnown(k) then
					spellName = (select(1,GetSpellInfo(k)))
					if (macroCond == "" or macroCond == nil) and (semiCol == "" or semiCol == nil) then
						return spellName or ""
					else
						return (macroCond or "")..(spellName or "")..(semiCol or "")
					end
				end
			end
		end
		return fallback or ""
	end
end

-- bind to function
local function b(spellName, macroCond, semiCol)
	if not InCombatLockdown() then 
		for k,v in pairs(classSkillList[class]) do
			if v == spellName then
				if IsPlayerSpell(k) or IsSpellKnown(k) then
					spellName = (select(1,GetSpellInfo(k)))
					if (macroCond == "" or macroCond == nil) and (semiCol == "" or semiCol == nil) then
						return spellName or ""
					else
						return (macroCond or "")..(spellName or "")..(semiCol or "")
					end
				end
			end
		end
		return fallback or ""
	end
end
local function groupRosterBuilder(role)
	if role == "tank" then
		role = "help,nodead" 
		for i = 1, 5 do 
			if UnitGroupRolesAssigned("party"..i) == role then 
				role = "@".."party"..i 
			end 
		end
		return role or ""
	elseif role == "healer" then
		role = "help,nodead"
		for i = 1, 5 do  
			if UnitGroupRolesAssigned("party"..i) == role then 
				role = "@".."party"..i 
			end 
		end
		return role or ""
	end
end

local function hsBuilder(type, macroCond, semiCol, class, slBP, z, eLevel, playerSpec, race, playerName )
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
			["PALADIN"] = "Hearthstone",
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
		elseif (playerName == "Stabbin" and class == "HUNTER" and race == "Goblin") then
			HS[class] = "Stone of the Hearth"
		elseif race == "NightElf" and (class == "WARRIOR" or class == "HUNTER") then
			HS[class] = "Night Fae Hearthstone"
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

		-- Block for getting Calendar Dates for World Events, World Event Setter
		if C_Calendar and C_DateAndTime then
			C_Calendar.SetMonth(0)
			local gHI = C_Calendar.GetHolidayInfo(0, C_DateAndTime.GetCurrentCalendarTime().monthDay, 1) and C_Calendar.GetHolidayInfo(0, C_DateAndTime.GetCurrentCalendarTime().monthDay, 1).name or ""
			if gHI == "Lunar Festival" then
				HS[class] = "Lunar Elder's Hearthstone"
			elseif gHI == "Love is in the Air" then
				HS[class] = "Peddlefeet's Lovely Hearthstone"
			elseif gHI == "Noblegarden" then
				HS[class] = "Noble Gardener's Hearthstone"
			elseif gHI == "Children's Week" then
				-- HS[class] = "Lunar Elder's Hearthstone"
			elseif gHI == "Midsummer Fire Festival" then
				HS[class] = "Fire-Eater's Hearthstone"
			elseif gHI == "Brewfest" then
				HS[class] = "Brewfest Reveler's Hearthstone"
			elseif gHI == "Hallow's End" then
				HS[class] = "Headless Horseman's Hearthstone"
			elseif gHI == "Pilgrim's Bounty" then
				-- HS[class] = "Lunar Elder's Hearthstone"
			elseif gHI == "Feast of Winter Veil" then
				HS[class] = "Greatfather Winter's Hearthstone"
			end
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
			["HUNTER"] = "\n/use Tiny Mechanical Mouse\n/use The Super Shellkhan Gang",
			["ROGUE"] = "\n/use Cursed Spyglass",
			["PRIEST"] = "\n/use Steamy Romance Novel Kit\n/use For da Blood God!",
			["DEATHKNIGHT"] = "\n/use Coldrage's Cooler",
			["WARRIOR"] = "\n/cancelaura Tournament Favor\n/use Tournament Favor\n/use Kovork Kostume",
			["DRUID"] = "\n/cancelaura Make like a Tree\n/use Ancient's Bloom\n/use Primal Stave of Claw and Fur\n/use Dreamsurge Remnant",
			["DEMONHUNTER"] = "\n/cancelaura Golden Hearthstone Card: Lord Jaraxxus\n/use Golden Hearthstone Card: Lord Jaraxxus",
		}
		if class == "EVOKER" then
			local randomHoloviewer = {
				"Holoviewer: The Timeless One",
				"Holoviewer: The Scarlet Queen",
				"Holoviewer: The Lady of Dreams",
			} 
			randomHoloviewer = randomHoloviewer[random(#randomHoloviewer)]
			hsToy[class] = "\n/use "..randomHoloviewer.."\n/use A Collection Of Me"
		end

		if playerName == "Stabbin" and class == "HUNTER" and race == "Goblin" then
			hsToy[class] = "\n/use Slightly-Chewed Insult Book\n/use Cursed Spyglass"
		elseif race == "NightElf" and class == "WARRIOR" then
			hsToy[class] = "\n/use Owl Post"
		end
		type = hsToy[class] 
		return (type or "")
	end
end

local function itemBuilder(item,option,playerSpec)
	if item == "glider" then
		if GetItemCount("Goblin Glider Kit") >= 1 then
			item = "\n/use [mod:ctrl]Goblin Glider Kit"
		else 
			item = "\n/use [mod:ctrl]15"
		end
		return item or ""
	end
	if item == "brazier" then
		if GetItemCount("Brazier of Awakening") >= 1 then 
			item = "\n/use [mod:ctrl]Brazier of Awakening"
		else 
			item = ""
		end
		return item or ""
	end
	if item == "resItem" then
		if GetItemCount("Unstable Temporal Time Shifter") >= 1 then 
			item = "[help,dead,nomod]Unstable Temporal Time Shifter;"
		else 
			item = "[help,dead,nomod]9;"
		end
		return item or ""
	end
	if item == "augmentRune" then
		if option <= 70 and GetItemCount("Dreambound Augment Rune") == 1 then
			item = "\n/use [nostealth]Dreambound Augment Rune"
		elseif option <= 50 and GetItemCount("Lightforged Augment Rune") == 1 then
			item = "\n/use [nostealth]Lightforged Augment Rune"
		elseif option <= 60 and GetItemCount("Eternal Augment Rune") == 1 then
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
			local EquipmentSets = {"DoubleGate", "Menkify!"}
            local OffHands = {}
            for i, SetName in ipairs(EquipmentSets) do
                local SetID = C_EquipmentSet and C_EquipmentSet.GetEquipmentSetID(SetName)
                if not SetID then return end

                local ItemLocations = C_EquipmentSet.GetItemLocations(SetID)
                local OffHand = ItemLocations[17] or 1

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
            end
            weapon = (OffHands["Menkify!"] and ("\n/equipslot [noequipped:Shields,nomod:alt,nospec:1]17 "..OffHands["Menkify!"]) or "")
            if playerSpec == 1 then
                weapon = "\n/equipset [noequipped:shields,nomod:alt]Menkify!"
            end
            item = weapon
			return item or ""
		end
	end
	if item == "instrument" then
		if GetItemCount(39769) >= 1 and (select(2,GetItemCooldown(39769)) == 0) then
			item = 39769
		elseif GetItemCount(44924) >= 1 and (select(2,GetItemCooldown(44924)) == 0) then
			item = 44924
		elseif GetItemCount(151255) >= 1 and (select(2,GetItemCooldown(151255)) == 0) then
			item = 151255
		end
		item = "\n/run local _,d,_=GetItemCooldown("..item..") if d==0 then EquipItemByName("..item..") else "..option.." end\n/use 16"
		return item or "" 
	end
	if item == "fartToy" then
		item = "Foul Belly"
		if option == 4 then
			item = "Notfar's Favorite Food"
		elseif option == 1 and GetItemCount("item:177278") > 0 then  -- phial of serenity
			item = "item:177278"
		end
		return item or ""
	end
	if item == "broom" then
		item = "Worn Doll"
		if GetItemCount("Anti-Doom Broom") >= 1 then
			item = "Anti-Doom Broom"
		end
		return item or ""
	end
end
local function consumableBuilder(consumable,macroCond,semiCol)
	if consumable == "invispot" then
		-- hasInvisPot parser
		local hasInvisPot = {
	    	"Potion of the Hushed Zephyr"
		}
		local hasInvisPotInBags = ""
		for i, hasInvisPot in pairs(hasInvisPot) do
			if GetItemCount(hasInvisPot) >= 1 then
		    	hasInvisPotInBags = hasInvisPot
			end
		end
		if GetItemCount("Overengineered Sleeve Extenders") >= 1 and UnitName("player") == "Voidlisa" then
			hasInvisPot = "9"
		end
		hasInvisPot = hasInvisPotInBags
		if (select(2,GetInstanceInfo()) == "pvp") then
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
			}
			for i, hasTonics in pairs(hasTonics) do
				if GetItemCount(hasTonics) >= 1 then
			    	neckIsEquipped = hasTonics
				end
			end
			if neckIsEquipped == "" then
				neckIsEquipped = hasScrapper
			elseif z == "Brawl'gar Arena" then
				neckIsEquipped = "Brawler's Coastal Healing Potion"
			elseif instanceType == "pvp" and GetItemCount("\"Third Wind\" Potion") >= 1 then 
				neckIsEquipped = "\"Third Wind\" Potion"
			end
		end
		return (macroCond or "")..(neckIsEquipped or "")..(semiCol or "")
	end
	if consumable == "potion" then
		  -- Role definition scope for dps potions
		local primary = "int"
		if (class == "DEMONHUNTER") or (class == "DRUID" and (playerSpec == 2 or playerSpec == 3)) or (class == "HUNTER") or (class == "MONK" and playerSpec ~= 2) or (class == "ROGUE") or (class == "SHAMAN" and playerSpec == 2) then
			primary = "agi"
		elseif (class == "DEATHKNIGHT") or (class == "WARRIOR") or (class == "PALADIN" and playerSpec ~= 1) then
			primary = "str"
		end

		local hasPot = ""
    	-- Throughput Potion parser
		if instanceType == "pvp" and GetItemCount("Saltwater Potion", false, true) >= 1 then
			hasPot = "Saltwater Potion"
		elseif IsInJailersTower() == true and GetItemCount("Fleeting Frenzy Potion", false, true) >= 1 then
			hasPot = "Fleeting Frenzy Potion"
		elseif IsInJailersTower() == true and GetItemCount("Mirror of the Conjured Twin", false, true) >= 1 then
			hasPot = "Mirror of the Conjured Twin"
		else
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
			for k, v in ipairs(hasPot) do
			    if GetItemCount(hasPot[k]) >= 1 and primary == hasPot[v] then
			        hasPotInBags = "item:"..hasPot[k]
			    end
			end
			hasPot = {
				"item:171349",
				"item:169299",
				"item:191383",
				"item:191389",
				"item:191388",
				"item:191387",
				"item:191382",
				"item:191381",
				"item:142117",
			}
			for i, hasPot in pairs(hasPot) do
			    if GetItemCount(hasPot) >= 1 then
			        hasPotInBags = hasPot
			    end
			end
			hasPot = hasPotInBags
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
 	   	}
 	   	local hasBandagesInBags = ""
 	   	for i, hasBandages in pairs(hasBandages) do 
	 	   	if GetItemCount(hasBandages) >= 1 then
	 	   		hasBandagesInBags = hasBandages
	 	   	end
	 	end
	 	if GetItemCount(hasBandagesInBags) < 1 then
	 		macroCond = ""
	 	end
	 	return (macroCond or "")..(hasBandagesInBags or "")..(semiCol or "")
	end
	if consumable == "manapot" then
		-- Mana Potion Parser
        consumable = {
	        "Potion of Frozen Focus",
	        "Aerated Mana Potion",
 	   	}
 	   	local hasManaPotsInBag = ""
 	   	for i, consumable in pairs(consumable) do 
	 	   	if GetItemCount(consumable) >= 1 then
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
		    if GetItemCount(hasWaters) >= 1 then
		        hasWaterInBags = hasWaters
		    end
		end
		if GetItemCount(hasWaterInBags) < 1 and class == "MAGE" then 
			hasWaters = "Conjure Refreshment"
		end
		if hasWaterInBags == "" or hasWaterInBags == nil then
			macroCond = ""
			semiCol = ""
		end
		return (macroCond or "")..(hasWaterInBags or "")..(semiCol or "")	
	end
	if consumable == "managem" then
		if GetItemCount("36799") >= 1 then
			hasManaGem = "item:36799"		
		elseif b("Displacement") == "Displacement" then 
			hasManaGem = "Displacement"
			--Arcane
		elseif GetItemCount("87257") >= 1 then
			hasManaGem = "item:87257"
			--Fiery
		elseif GetItemCount("87258") >= 1 then
			hasManaGem = "item:87258"
			--Icy
		elseif GetItemCount("87259") >= 1 then
			hasManaGem = "item:87259"
		else 
			hasManaGem = "Conjure Mana Gem"
		end
		return (macroCond or "")..(hasManaGem or "")..(semiCol or "")
	end
	if consumable == "nimblebrew" then
		local nimbleBrew = "Magic Pet Mirror"
		if GetItemCount("Nimble Brew") >= 1 then 
			nimbleBrew = "Nimble Brew"
		end
		return (macroCond or "")..(nimbleBrew or "")..(semiCol or "") 
	end
	if consumable == "bladlast" then
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
		    if GetItemCount(consumable) >= 1 then
		        hasDrumsInBags = consumable
		    end
		end
		local name = AuraUtil.FindAuraByName("Lone Wolf", "player") 
		if (class == "SHAMAN" and macroCond == "Alliance") then 
	    	hasDrumsInBags = "Heroism" 
		elseif class == "SHAMAN" then 
			hasDrumsInBags = "Bloodlust"
		elseif class == "MAGE" then 
			hasDrumsInBags = "Time Warp"
		elseif class == "HUNTER" then
			if IsSpellKnownOrOverridesKnown(272678) == true then
				hasDrumsInBags = "[nopet]Call Pet 5;[pet]Primal Rage"
			-- hunter med bl drums
			elseif (name ~= "Lone Wolf" and (IsSpellKnownOrOverridesKnown(272678) == false) and GetItemCount(hasDrumsInBags) >= 1) then
				hasDrumsInBags = "[nopet]Call Pet 5;[pet]"..hasDrumsInBags
			-- hunter med bl pet
			-- elseif (name == nil and petSpec == 1) then
			-- 	bladlast = "[nopet]Call Pet 5;[pet]Command Pet" 
			-- lone wolf hunter med bl drums
			elseif name == "Lone Wolf" then
				hasDrumsInBags = "[nopet]"..hasDrumsInBags..";[pet]Command Pet" 
			end
		elseif class == "EVOKER" then 
			hasDrumsInBags = "Fury of the Aspects\n/use Prismatic Bauble\n/targetfriendplayer\n/use [help,nodead]Rainbow Generator\n/targetlasttarget [exists]"
		end
		return hasDrumsInBags or ""
	end
end

local function eventHandler(self, event)

	local faction = UnitFactionGroup("player")
	local _,race = UnitRace("player")
	local sex = UnitSex("player")
	local playerName = UnitName("player")
	local playerSpec = GetSpecialization(false,false)
	local petSpec = GetSpecialization(false,true)
	local level = UnitLevel("player")
	local eLevel = UnitEffectiveLevel("player")
	local z, m, mA, mP = GetZoneText(), "", "", ""
	local override = ""
 	local overrideModAlt = ""
 	local overrideModCtrl = ""
	local instanceName, instanceType, difficultyID, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance, mapID, instanceGroupSize = GetInstanceInfo()

	if InCombatLockdown() then
		frame:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		frame:UnregisterEvent("PLAYER_REGEN_ENABLED")

		-- Configure Battlefield Map
		if BattlefieldMapFrame then 
			BattlefieldMapFrame:SetScale(1.4)
			BattlefieldMapFrame:SetAlpha(.9)
			BattlefieldMapFrame:SetPoint("TOPLEFT")
			BattlefieldMapFrame.BorderFrame.CloseButton:Hide()
		end

		-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: ZONEw_CHANGED_NEW_AREA\nRecalibrating related macros :)",0.5,1.0,0.0)

		local pennantClass = "\n/use Honorable Pennant"
		if race == "Orc" then
			pennantClass = "\n/use Clan Banner"
		elseif class == "ROGUE" and playerSpec ~= 2 then
			pennantClass = "\n/use Honorable Pennant\n/cancelaura A Mighty Pirate"
		elseif class == "ROGUE" or (playerName == "Stabbin" and class == "HUNTER" and race == "Goblin") then 
			pennantClass = "\n/use Jolly Roger\n/cancelaura Honorable Pennant\n/use Swarthy Warning Sign"
		end
		
		-- Battle of Dazar'alor, Mercenary BG Racial parser
		local mercenaryRacial = {
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

		for k,v in pairs(mercenaryRacial) do
			if IsSpellKnown(k) == true then
				race = v
			end
		end

		-- Sätta overrides för 5 = Mawsworn och 6 = Enlightened, så får vi fler customisations options på klassnivå.
		local covenantsEnum = {
			1,
			2,
			3,
			4,
			5,
			6,
		}

		local bfaIsland = ((select(3, GetInstanceInfo())))	
		local slBP = C_Covenants.GetActiveCovenantID(covenantsEnum)
		
		local racials = {
			["BloodElf"] = "Arcane Torrent",
			["Draenei"] = "[@mouseover,help,nodead][]Gift of the Naaru",
			["DarkIronDwarf"] = "Fireblood",
			["Dwarf"] = "Stoneform",
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

		local dpsRacials = {
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

		local extraRacials = {
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

		if not extraRacials[race] and class == "SHAMAN" then
			if b("Wind Rush Totem") == "Wind Rush Totem" then 
				extraRacials[race] = "[@player]Wind Rush Totem"
			elseif b("Earthgrab Totem") == "Earthgrab Totem" then 
				extraRacials[race] = "[@player]Earthgrab Totem"
			else 
				extraRacials[race] = "Zandalari Effigy Amulet"
			end
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

		-- Outdoor zones where flying is disabled
		local groundAreas = {
			-- Kalimdor
			["Ammen Vale"] = true,
			["Azuremyst Isle"] = true,
			["Bloodmyst Isle"] = true,
			["The Exodar"] = true,
			-- Eastern Kingdoms
			["Sunstrider Isle"] = true,
			["Eversong Woods"] = true,
			["Ghostlands"] = true,
			["Silvermoon City"] = true,
			["Isle of Quel'Danas"] = true,
			-- Darkmoon Faire
			["Darkmoon Faire"] = true,
			["Darkmoon Island"] = true,
			-- Cataclysm
			["Tol Barad Peninsula"] = true,
			["Tol Barad"] = true,
			["Molten Front"] = true,
			-- Pandaria
			["Isle of Thunder"] = true,
			["Mogu Island Daily Area"] = true, -- Isle of Thunder
			["Isle of Giants"] = true,
			["Timeless Isle"] = true,
			-- Draenor
			["Tanaan Jungle Intro"] = true,
			-- Broken Isles
			["Helheim"] = true,
			["Niskara"] = true,
			-- Order Halls
			["The Maelstrom"] = true,
			["Mardum, the Shattered Abyss"] = true,
			["Skyhold"] = true,
			["The Wandering Isle"] = true,
			["Dreadscar Rift"] = true,
			["Emerald Dreamway"] = true,
			["Malorne's Nightmare"] = true, -- Druid Emerald Dream Scenario
			["Artifact - The Vortex Pinnacle - Shaman Order Hall"] = true, -- Shaman Skywall Scenario
			["Firelands_Artifact"] = true, -- Shaman Firelands Scenario
			["Death Knight Campaign - Scarlet Monastery"] = true, -- Death Knight Scarlet Monastery Scenario
			-- Argus
			["Krokuun"] = true,
			["Antoran Wastes"] = true,
			["Mac'Aree"] = true, -- Removed in 9.1.5 but still used in API in some places
			["Eredath"] = true,
			["Invasion Points"] = true,
			-- Battle for Azeroth
			["8.1 Darkshore Alliance Quests"] = true, -- Darkshore Unlock Scenario
			["8.1 Darkshore Horde Quests"] = true, -- Darkshore Unlock Scenario
			["Mechagon City"] = true,
			["The Great Sea Horde"] = true, -- Horde War Campaign Scenario
			["Crapapolis"] = true, -- Goblin Heritage
			["Crapapolis - Scenario"] = true,
			["Vale of Eternal Twilight"] = true, -- Vision of N'Zoth
			["Vision of the Twisting Sands"] = true, -- Vision of N'Zoth
			-- Shadowlands
			["Shadowlands"] = true,
			["Oribos"] = true,
			["Maldraxxus Broker Islands"] = true, -- Shattered Grove
			["The Maw"] = true,
			["Korthia"] = true,
			["Caverns of Contemplation"] = true, -- Korthia
			["Torghast"] = true,
			["Font of Fealty"] = true, -- Chains of Domination Campaign Scenario
			["Tazavesh, the Veiled Market"] = true,
		}

		-- Garrisons Map IDs
		local garrisonId = { [1152] = true, [1330] = true, [1153] = true, [1158] = true, [1331] = true, [1159] = true, }

		local dfZones = {
			["Ohn'ahran Plains"] = true,
			["Thaldraszus"] = true,
			["The Azure Span"] = true,
			["The Waking Shores"] = true,
			["The Forbidden Reach"] = true, 
			["Valdrakken"] = true,
			["The Roasted Ram"] = true,
			["The Dragon's Hoard"] = true,
			["Temporal Conflux"] = true,
			["The Primalist Future"] = true,
			["Zaralek Cavern"] = true,
			["Emerald Dream"] = true,
		}

		local slZones = {
			["Cosmic"] = true,
			["Bastion"] = true,
			["The Necrotic Wake"] = true,
			["Maldraxxus"] = true,
			["House of Plagues"] = true,
			["Ardenweald"] = true,
			["Revendreth"] = true,
			["The Shadowlands"] = true,
			["Oribos"] = true,
			["The Maw"] = true,
			["Sanctum of Domination"] = true,
			["Korthia"] = true,
			["Zereth Mortis"] = true,
		}

		local bfaZones = {
			["Zandalar"] = true,
			["Kul Tiras"] = true,
			["Zuldazar"] = true,
			["Boralus"] = true,
			["Dazar'alor"] = true,
			["Tiragarde Sound"] = true,
			["Nazjatar"] = true,
			["Damprock Cavern"] = true,
			["Boralus Harbor"] = true,
			["Tradewinds Market"] = true,
		}
		local cov = {
			[0] = "",
			[1] = "Kyrian",
			[2] = "Venthyr",
			[3] = "Night Fae",
			[4] = "Necrolord",
			[5] = "Mawsworn",
			[6] = "Enlightened",
		}

		 
		
        -- uses covEnum	
        local covToys = {
			[0] = {""},
			[1] = {"Steward's First Feather"},
			[2] = {"Rapid Recitation Quill"},
			[3] = {"Spring Florist's Pouch\n/use Seed of Renewed Souls"},
			[4] = {"Regenerating Slime Vial"},
			[5] = {"Box of Rattling Chains"},
			[6] = {"Blue-Covered Beanbag\n/use Sphere of Enlightened Cogitation"},
		}

       	-- CovToys
		covToys = covToys[slBP]
		covToys = covToys[random(#covToys)]
		covToys = "\n/use "..covToys

		if (slBP == 0 and ((level > 50 or eLevel > 50) and (level < 60 or eLevel < 60)) and slZones[z]) or (slBP == 0 and slZones[z]) then
			slBP = 5
		elseif slBP == 0 and ((level > 50 or eLevel > 50) and (level < 60 or eLevel < 60)) and not slZones[z] then
			slBP = 6
		end
		-- print("slBP is: ",slBP)

		local EQS = {
			[1] = "Noon!",
			[2] = "DoubleGate",
			[3] = "Menkify!",
			[4] = "Supermenk",
			[5] = "",
		}

		-- speciella item sets
		
		local tpPants, noPants = "Tipipants", EQS[playerSpec]
		-- print("noPants = ", EQS[playerSpec])
		if C_EquipmentSet.GetEquipmentSetID(tpPants) ~= nil and playerSpec ~= 5 then
			tpPants = C_EquipmentSet.GetEquipmentSetID(tpPants) or ""
			noPants = C_EquipmentSet.GetEquipmentSetID(noPants) or ""
			tpPants = "C_EquipmentSet.UseEquipmentSet("..tpPants..")" 
			noPants = "C_EquipmentSet.UseEquipmentSet("..noPants..")"
		end
		
		local oOtas = "\n/use Orb of Deception"
		if race ~= "BloodElf" and (level and eLevel) >= 25 then
			oOtas = "\n/use Orb of the Sin'dorei"
		end
		if (level and eLevel) < 20 then
			oOtas = oOtas.."\n/use Toy Armor Set\n/use Toy Weapon Set"
		else
			oOtas = oOtas
		end

		-- Target BG Healers and Set BG Healers // Helpful measures in non-bg areas
		local numaltbuff101112 = {
			["SHAMAN"] = b("Earth Shield"),
			["MAGE"] = "Polymorph",
			["WARLOCK"] = "Command Demon",
			["MONK"] = "Paralysis",
			["PALADIN"] = "Repentance",
			["HUNTER"] = "Intimidation",
			["ROGUE"] = "Blind",
			["PRIEST"] = b("Pain Suppression")..b("Guardian Spirit"),
			["DEATHKNIGHT"] = "Asphyxiate",
			["WARRIOR"] = "Storm Bolt",
			["DRUID"] = "Cyclone", 
			["DEMONHUNTER"] = "Imprison",
			["EVOKER"] = "Sleep Walk",
		}
		local numctrlbuff101112 = {
			["SHAMAN"] = "Purge",
			["MAGE"] = "Spellsteal",
			["WARLOCK"] = "Command Demon",
			["MONK"] = "Disable",
			["PALADIN"] = "Blessing of Protection",
			["HUNTER"] = "Harpoon",
			["ROGUE"] = "Shadowstep",
			["PRIEST"] = "Leap of Faith",
			["DEATHKNIGHT"] = "Dark Simulacrum",
			["WARRIOR"] = "Charge",
			["DRUID"] = "Entangling Roots", 
			["DEMONHUNTER"] = "Consume Magic",
			["EVOKER"] = "Unravel",
		}
		if class == "ROGUE" and playerSpec == 2 then 
			numctrlbuff101112[class] = "Kidney Shot"
		end
		local numnomodbuff101112 = {
			["SHAMAN"] = "Water Walking",
			["MAGE"] = "Slow Fall",
			["WARLOCK"] = "Unending Breath",
			["MONK"] = "Tiger's Lust",
			["PALADIN"] = "Blessing of Freedom",
			["HUNTER"] = "Master's Call",
			["ROGUE"] = "Shadowstep",
			["PRIEST"] = "Power Infusion",
			["DEATHKNIGHT"] = "Mind Freeze",
			["WARRIOR"] = "Intervene",
			["DRUID"] = "Wild Charge", 
			["DEMONHUNTER"] = "Disrupt",
			["EVOKER"] = "Time Dilation",
		}

		if class == "DRUID" then
			if (playerSpec == 2 or playerSpec == 3) then
				numnomodbuff101112[class] = "Skull Bash"
			elseif playerSpec == 4 then
				numnomodbuff101112[class] = "Cyclone"
			end
		end 

		-- Target BG Healers and Set BG Healers // Helpful measures in non-bg areas
		local numaltbuff789 = {
			["SHAMAN"] = b("Earth Shield"),
			["MAGE"] = "Polymorph",
			["WARLOCK"] = "Command Demon",
			["MONK"] = "Paralysis",
			["PALADIN"] = "Repentance",
			["HUNTER"] = "Intimidation",
			["ROGUE"] = "Blind",
			["PRIEST"] = "Rapture",
			["DEATHKNIGHT"] = "Asphyxiate",
			["WARRIOR"] = "Storm Bolt",
			["DRUID"] = "Cyclone", 
			["DEMONHUNTER"] = "Imprison",
			["EVOKER"] = "Sleep Walk",
		}
		local numctrlbuff789 = {
			["SHAMAN"] = "Purge",
			["MAGE"] = "Spellsteal",
			["WARLOCK"] = "Command Demon",
			["MONK"] = "Disable",
			["PALADIN"] = "Blessing of Protection",
			["HUNTER"] = "Harpoon",
			["ROGUE"] = "Shadowstep",
			["PRIEST"] = "Rapture",
			["DEATHKNIGHT"] = "Dark Simulacrum",
			["WARRIOR"] = "Charge",
			["DRUID"] = "Entangling Roots", 
			["DEMONHUNTER"] = "Consume Magic",
			["EVOKER"] = "Unravel",
		}
		if class == "ROGUE" and playerSpec == 2 then 
			numctrlbuff789[class] = "Kidney Shot"
		end
		local numnomodbuff789 = {
			["SHAMAN"] = "Water Walking",
			["MAGE"] = "Slow Fall",
			["WARLOCK"] = "Unending Breath",
			["MONK"] = "Tiger's Lust",
			["PALADIN"] = "Blessing of Freedom",
			["HUNTER"] = "Master's Call",
			["ROGUE"] = "Shadowstep",
			["PRIEST"] = "Power Word: Radiance",
			["DEATHKNIGHT"] = "Mind Freeze",
			["WARRIOR"] = "Intervene",
			["DRUID"] = "Wild Charge", 
			["DEMONHUNTER"] = "Disrupt",
			["EVOKER"] = "Time Dilation",
		}

		if class == "DRUID" then
			if (playerSpec == 2 or playerSpec == 3) then
				numnomodbuff789[class] = "Skull Bash"
			elseif playerSpec == 4 then
				numnomodbuff789[class] = "Cyclone"
			end
		end 

		-- Target BG Healers and Set BG Healers // Helpful measures in non-bg areas
		local modnumaltbuff789 = {
			["SHAMAN"] = b("Earth Shield"),
			["MAGE"] = "Polymorph",
			["WARLOCK"] = "Command Demon",
			["MONK"] = "Paralysis",
			["PALADIN"] = "Repentance",
			["HUNTER"] = "Intimidation",
			["ROGUE"] = "Blind",
			["PRIEST"] = "Rapture",
			["DEATHKNIGHT"] = "Asphyxiate",
			["WARRIOR"] = "Storm Bolt",
			["DRUID"] = "Cyclone", 
			["DEMONHUNTER"] = "Imprison",
			["EVOKER"] = "Sleep Walk",
		}
		local modnumctrlbuff789 = {
			["SHAMAN"] = "Purge",
			["MAGE"] = "Spellsteal",
			["WARLOCK"] = "Command Demon",
			["MONK"] = "Disable",
			["PALADIN"] = "Blessing of Protection",
			["HUNTER"] = "Harpoon",
			["ROGUE"] = "Shadowstep",
			["PRIEST"] = "Rapture",
			["DEATHKNIGHT"] = "Dark Simulacrum",
			["WARRIOR"] = "Charge",
			["DRUID"] = "Entangling Roots", 
			["DEMONHUNTER"] = "Consume Magic",
			["EVOKER"] = "Unravel",
		}
		if class == "ROGUE" and playerSpec == 2 then 
			modnumctrlbuff789[class] = "Kidney Shot"
		end
		local modnumnomodbuff789 = {
			["SHAMAN"] = "Water Walking",
			["MAGE"] = "Slow Fall",
			["WARLOCK"] = "Unending Breath",
			["MONK"] = "Tiger's Lust",
			["PALADIN"] = "Blessing of Freedom",
			["HUNTER"] = "Master's Call",
			["ROGUE"] = "Shadowstep",
			["PRIEST"] = "Rapture",
			["DEATHKNIGHT"] = "Mind Freeze",
			["WARRIOR"] = "Intervene",
			["DRUID"] = "Wild Charge", 
			["DEMONHUNTER"] = "Disrupt",
			["EVOKER"] = "Time Dilation",
		}
		if class == "DRUID" then
			if (playerSpec == 2 or playerSpec == 3) then
				modnumnomodbuff789[class] = "Skull Bash"
			elseif playerSpec == 4 then
				modnumnomodbuff789[class] = "Cyclone"
			end
		end 
		local zoneBasedUtilities = {
			[1] = "", 
			[2] = "",
			[3] = "",  
			[4] = "\n/use Element-Infused Rocket Helmet",
			[5] = "\n/use Goren \"Log\" Roller", 
			[6] = "", 
			[7] = "",
			[8] = "",
			[9] = "",
			[10] = "",
			[11] = "",
			[12] = "",
			[13] = "",
			[14] = "",
			[15] = "",
			[16] = "",
			[17] = "",
			[18] = "",
			[19] = "",
			[20] = "",
			[21] = "Loot-A-Rang",
			[22] = "Photo B.O.M.B.",
			[23] = "Citizens Brigade Whistle",
			[24] = "Signature Ability",
			[25] = "",
			[26] = "Covenant Ability",
			[27] = "",
			[28] = "\n/use [mod]item:177278",
			[29] = "[@mouseover,exists,nodead][@cursor]13",
			[30] = "",
			[31] = "",
			[32] = "Horde Flag of Victory",
			[33] = "Firefury Totem",
			[34] = "Darkspear Pride",
			[35] = "Everlasting Horde Firework",
			[36] = "Orgrimmar Interceptor",
			[37] = "",
			[38] = "[@mouseover,exists,nodead][]Command Demon",
			[39] = "",
			[40] = "[@focus,harm,nodead]Command Demon;",
		}

		hasCannon = zoneBasedUtilities[1]
		alt4 = zoneBasedUtilities[2]
		alt5 = zoneBasedUtilities[3]
		alt6 = zoneBasedUtilities[4]
		alt9 = zoneBasedUtilities[5]
		CZ = zoneBasedUtilities[6]
		AR = zoneBasedUtilities[7]
		conDB = zoneBasedUtilities[8]
		conEF = zoneBasedUtilities[9]
		conAF = zoneBasedUtilities[10]
		conVS = zoneBasedUtilities[11]
		conSET = zoneBasedUtilities[12]
		conST = zoneBasedUtilities[13]
		conSst = zoneBasedUtilities[14]
		conMW = zoneBasedUtilities[15]
		conMS = zoneBasedUtilities[16]
		conTE = zoneBasedUtilities[17]
		conBE = zoneBasedUtilities[18]
		conCE = zoneBasedUtilities[19]
		conRE = zoneBasedUtilities[20]
		LAR = zoneBasedUtilities[21] 
		hasShark = zoneBasedUtilities[22]
		hasScrapper = zoneBasedUtilities[23] 
		sigA = zoneBasedUtilities[24]
		sigB = zoneBasedUtilities[25]
		covA = zoneBasedUtilities[26]
		covB = zoneBasedUtilities[27]
		poS = zoneBasedUtilities[28]
		hoaEq = zoneBasedUtilities[29]
		hasHE = zoneBasedUtilities[30]
		slBPGen = zoneBasedUtilities[31]
		pwned = zoneBasedUtilities[32] 
		fftpar = zoneBasedUtilities[33] 
		factionPride = zoneBasedUtilities[34] 
		factionFireworks = zoneBasedUtilities[35] 
		passengerMount = zoneBasedUtilities[36] 
		warPvPExc = zoneBasedUtilities[37]
		locPvPQ = zoneBasedUtilities[38] 
		locPvPSThree = zoneBasedUtilities[39]
		locPvPF = zoneBasedUtilities[40] 

		if faction == "Alliance" then
			pwned = "Alliance Flag of Victory" 
			fftpar = "Touch of the Naaru"
			factionPride = "Gnomeregan Pride"
			factionFireworks = "Everlasting Alliance Firework"
			passengerMount = "Stormwind Skychaser" 
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
		-- array med klass abilities för varje klass, aC == Alt+456 Class ability
			-- Helpful Dispel Array ctrl+alt+num456, borde vara helpful utility
		local aC = {
			["SHAMAN"] = "Cleanse Spirit",
			["MAGE"] = "Remove Curse",
			["WARLOCK"] = "Singe Magic",
			["MONK"] = "Detox",
			["PALADIN"] = "Cleanse",
			["HUNTER"] = "Roar of Sacrifice",
			["ROGUE"] = "Tricks of the Trade",
			["PRIEST"] = "Void Shift",
			["DEATHKNIGHT"] = "Chains of Ice",
			["WARRIOR"] = "Intervene",
			["DRUID"] = "Remove Corruption", 
			["DEMONHUNTER"] = "Silver-Plated Turkey Shooter",
			["EVOKER"] = "Naturalize",
		}
		-- array med klass abilities för varje klass, PoA == Party or Arena
		local PoA = "@party"
		local arenaDots = {
			["SHAMAN"] = "Flame Shock",
			["MAGE"] = b("Nether Tempest")..b("Living Bomb")..b("Frost Bomb"),
			["WARLOCK"] = "Singe Magic",
			["MONK"] = "Detox",
			["PALADIN"] = "Cleanse",
			["HUNTER"] = "Roar of Sacrifice",
			["ROGUE"] = "Tricks of the Trade",
			["PRIEST"] = b("Vampiric Touch","[]",";").."Shadow Word: Pain",
			["DEATHKNIGHT"] = "Outbreak",
			["WARRIOR"] = "Rend",
			["DRUID"] = "Moonfire", 
			["DEMONHUNTER"] = "Throw Glaive",
			["EVOKER"] = "Pyre",
		}
		local altArenaDots = {
			["SHAMAN"] = "Flame Shock",
			["MAGE"] = b("Nether Tempest")..b("Living Bomb")..b("Frost Bomb"),
			["WARLOCK"] = "Singe Magic",
			["MONK"] = "Detox",
			["PALADIN"] = "Cleanse",
			["HUNTER"] = "Roar of Sacrifice",
			["ROGUE"] = "Tricks of the Trade",
			["PRIEST"] = "Shadow Word: Death",
			["DEATHKNIGHT"] = "Outbreak",
			["WARRIOR"] = "Rend",
			["DRUID"] = "Moonfire", 
			["DEMONHUNTER"] = "Throw Glaive",
			["EVOKER"] = "Pyre",
		}
		local ctrlArenaDots = {
			["SHAMAN"] = "Flame Shock",
			["MAGE"] = b("Nether Tempest")..b("Living Bomb")..b("Frost Bomb"),
			["WARLOCK"] = "Singe Magic",
			["MONK"] = "Detox",
			["PALADIN"] = "Cleanse",
			["HUNTER"] = "Roar of Sacrifice",
			["ROGUE"] = "Tricks of the Trade",
			["PRIEST"] = "Penance",
			["DEATHKNIGHT"] = "Outbreak",
			["WARRIOR"] = "Rend",
			["DRUID"] = "Moonfire", 
			["DEMONHUNTER"] = "Throw Glaive",
			["EVOKER"] = "Pyre",
		}
		-- Offensive Counter abilities Array 
		-- shift+alt+wmp456
		local wmpaltpurge = {
			["SHAMAN"] = "Purge",
			["MAGE"] = "Spellsteal",
			["WARLOCK"] = "Devour Magic",
			["MONK"] = "Disable",
			["PALADIN"] = "Hammer of Justice",
			["HUNTER"] = "Harpoon",
			["ROGUE"] = "Shadowstep",
			["PRIEST"] = "Dispel Magic",
			["DEATHKNIGHT"] = "Dark Simulacrum",
			["WARRIOR"] = "Charge",
			["DRUID"] = "Entangling Roots", 
			["DEMONHUNTER"] = "Consume Magic",
			["EVOKER"] = "Unravel",
		}
		-- shift+ctrl+wmp456
		local wmpctrlcc = {
			["SHAMAN"] = "Hex",
			["MAGE"] = "Polymorph",
			["WARLOCK"] = "Fear",
			["MONK"] = "Paralysis",
			["PALADIN"] = "Repentance",
			["HUNTER"] = "Intimidation",
			["ROGUE"] = "Blind",
			["PRIEST"] = b("Mind Control"),
			["DEATHKNIGHT"] = "Asphyxiate",
			["WARRIOR"] = "Storm Bolt",
			["DRUID"] = "Cyclone", 
			["DEMONHUNTER"] = "Imprison",
			["EVOKER"] = "Sleep Walk",
		}
		if class == "ROGUE" and playerSpec == 2 then
			wmpctrlcc[class] = "Kidney Shot"
		elseif class == "PRIEST" and b("Thoughtsteal") == "Thoughtsteal" then
			wmpctrlcc[class] = "Thoughtsteal"
		end
		local wmpnomodkick = {
			["SHAMAN"] = "Wind Shear",
			["MAGE"] = "Counterspell",
			["WARLOCK"] = locPvPQ,
			["MONK"] = "Spear Hand Strike",
			["PALADIN"] = "Rebuke",
			["HUNTER"] = "Counter Shot",
			["ROGUE"] = "Kick",
			["PRIEST"] = "Silence",
			["DEATHKNIGHT"] = "Mind Freeze",
			["WARRIOR"] = "Pummel",
			["DRUID"] = "Solar Beam", 
			["DEMONHUNTER"] = "Disrupt",
			["EVOKER"] = "Quell",
		}
		if (class == "PRIEST" and playerSpec ~= 3) then
			wmpnomodkick[class] = "Mindgames"
		elseif class == "DRUID" then
			if (playerSpec == 2 or playerSpec == 3) then
				wmpnomodkick[class] = "Skull Bash"
			else
				wmpnomodkick[class] = "Cyclone"
			end
		end 

		local covSpecial = ""
		-- Kyrian, 
		if cov[slBP] == "Kyrian" then
			covSpecial = "\n/use Bondable Val'kyr Diadem\n/use Acrobatic Steward\n/use Malfunctioning Goliath Gauntlet"
		-- Venthyr, 
		elseif cov[slBP] == "Venthyr" then
			covSpecial = "\n/use [exists,nodead]Tome of Small Sins;Bondable Sinstone"
		-- Night Fae,
		elseif cov[slBP] == "Night Fae" then
			covSpecial = "\n/use Sparkle Wings\n/use [nocombat,nostealth]Gormling in a Bag"
		-- Necrolord, 
		elseif cov[slBP] == "Necrolord" then
			covSpecial = "\n/use Apprentice Slimemancer's Boots"
		-- Mawsworn, 
		elseif cov[slBP] == "Mawsworn" then
			covSpecial = "\n/use Experimental Anima Cell"
		-- Enlightened, 
		elseif cov[slBP] == "Enlightened" then
			covSpecial = "\n/use Protological Cube"
		end
		-- Här börjar Events
		-- Login,zone,bag_update based event, Swapper, Alt+J parser, Call Companion, set class/spec toys.
		-- Zone och bag baserade events
		if (event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD") and not InCombatLockdown() then   
			-- if Instanced Content 
			if instanceType ~= "none" then
				SetBinding("A","STRAFELEFT")
				SetBinding("D","STRAFERIGHT")
			else
			-- else: InstanceType: "none"
				SetBinding("A","TURNLEFT")
				SetBinding("D","TURNRIGHT")
			end
		end
		if (event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_SPECIALIZATION_CHANGED" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "BAG_UPDATE_DELAYED" or event == "PET_SPECIALIZATION_CHANGED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LEVEL_UP") and not InCombatLockdown() then 
			-- Showtooltip on Alt+J

			local classText = ""
			if class == "SHAMAN" then
				classText = b("Earth Elemental","#show ","")
				if b("Mana Tide Totem") == "Mana Tide Totem" then
					classText = "#show Mana Tide Totem"
				end
			elseif class == "MAGE" then
				classText = "#show "..b("Arcane Familiar","[nocombat,noexists]",";")..b("Conjure Mana Gem","item:36799;","").."\n/use Pilfered Sweeper" 
			elseif class == "WARLOCK" then
				classText = ""
			elseif class == "MONK" then
				classText = "#show "..b("Black Ox Brew")
				if playerSpec == 2 then 
					classText = "#show "..b("Thunder Focus Tea")
				elseif playerSpec == 3 then
					classText = "#show "..b("Invoke Xuen, the White Tiger")
				end
			elseif class == "PALADIN" then
				classText = "#show "..b("Lay on Hands").."\n/use "..b("Contemplation","[]",";").."Holy Lightsphere"
			elseif class == "HUNTER" then
				classText = "#show Command Pet\n/use Zanj'ir Weapon Rack\n/use [spec:2]Dark Ranger's Spare Cowl"
			elseif class == "ROGUE" then
				if b("Shadow Dance") == "Shadow Dance" then 
					classText = "#show Shadow Dance"
				elseif b("Tricks of the Trade") == "Tricks of the Trade" then
					classText = "#show Tricks of the Trade"
				end
			elseif class == "PRIEST" then
				classText = "#show "..b("Mass Dispel")
			elseif class == "DEATHKNIGHT" then
				classText = "#show "..b("Raise Dead").."\n/use [nocombat]Permanent Frost Essence\n/use [nocombat]Stolen Breath\n/use [nocombat]Champion's Salute"
				if faction == "Alliance" then
					classText = "#show "..b("Raise Dead").."\n/use [nocombat]Stolen Breath\n/use [nocombat]Champion's Salute"
				end
			elseif class == "WARRIOR" then
				classText = "#show Shield Block\n/use "..factionPride.."\n/use Raise Banner"
			elseif class == "DRUID" then
				classText = "#show Rebirth\n/use Wisp in a Bottle"
			elseif class == "DEMONHUNTER" then
				classText = "#show "..b("Vengeful Retreat")
			elseif class == "EVOKER" then
				classText = "#show "..b("Time Spiral")
			end
			EditMacro("WSxSwapper",nil,nil,classText) 
			ZigiSetSwapper()
			
		  	
			EditMacro("WGrenade",nil,nil,"#show [mod:alt]"..hasScrapper..";"..hasShark.."\n/use Hot Buttered Popcorn\n/use [mod:alt]"..hasScrapper..";"..hasShark)
			        
			-- Map
			if C_Map and C_Map.GetBestMapForUnit("player") then
				local map = C_Map.GetMapInfo(C_Map.GetBestMapForUnit("player"))
				local parent = map.parentMapID and C_Map.GetMapInfo(map.parentMapID) or map
				local pp = parent and parent.name

				-- Gör ett nytt macro för ExtraActionButton1 som har en Vindicator Matrix ability bundet när du är på Argus, bind detta till CGenB
				-- Zone Ability
				local zA = "/use [@mouseover,exists,nodead][@cursor]Garrison Ability"
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
				elseif dfZones[z] then
					zA = "/use Hunting Companion\n/use Blessing of Ohn'ahra"
				end
				EditMacro("WSxCSGen+B",nil,nil,zA)
				EditMacro("WSxCGen+B",nil,nil,"#show\n/click ExtraActionButton1")
				local ink = "\n/use Moroes' Famous Polish"
				if GetItemCount("Darkmoon Cannon") == 1 then 
					hasCannon = "\n/use Darkmoon Cannon"
				end
    				alt4 = ink
					alt5 = hasCannon
					CZ = ""
    			if dfZones[z] then
					if GetItemCount("Fleeting Sands") > 0 then
						alt4 = alt4.."\n/use Fleeting Sands"
					end 
					if GetItemCount("Shikaar Hunting Horn") > 0 then
						alt6 = alt6.."\n/use Shikaar Hunting Horn"
					end 
					alt9 = "\n/use Element-Infused Rocket Helmet"
					if GetItemCount("Sticky Warp Grenade") >= 1 then
						hasShark = "Sticky Warp Grenade"
					end
					if GetItemCount("Gravitational Displacer") >= 1 then
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
					    if GetItemCount(torghastAnimaCell) >= 1 then
					        torghastAnimaCellInBags = torghastAnimaCell
					    end
					end
			    elseif ((z == "The Maw" and pp == "The Shadowlands") or (z == "The Rift" and pp == "The Shadowlands")) then
					alt4 = alt4.."\n/use Silver Shardhide Whistle"
					if (class == "PRIEST" or class == "MAGE" or class == "WARLOCK") then
						alt5 = "\n/use 9"
					elseif (class == "WARRIOR" or class == "DEATHKNIGHT" or class == "PALADIN" or class == "DRUID" or class == "MONK" or class == "ROGUE" or class == "DEMONHUNTER") then
						alt5 = alt5.."\n/use 10"
					else
						alt5 = alt5.."\n/use 8"
					end
					CZ = "[nostealth]Borr-Geth's Fiery Brimstone"
				elseif slZones[z] then
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
					    if GetItemCount(kyrianInstrument) >= 1 then
					        kyrianInBags = kyrianInstrument
					    end
					end
					if GetItemCount("Crumbling Pride Extractors") >= 1 then
						hasShark = "Crumbling Pride Extractors"
					end
					if GetItemCount("Shrieker's Voicebox") >= 1 then
						hasScrapper = "Shrieker's Voicebox"
					end
					CZ = "[nostealth]"..kyrianInBags.."\n/use [nostealth]Borr-Geth's Fiery Brimstone" 
					alt4 = alt4.."\n/use Silver Shardhide Whistle"
					alt6 = alt6.."\n/use Phial of Ravenous Slime"
				elseif bfaZones[z] then
					if GetItemCount("G99.99 Landshark") >= 1 then
						hasShark = "G99.99 Landshark"
					end
					if GetItemCount("Scrap Grenade") >= 1 then
						hasScrapper = "Scrap Grenade"
					end
					if GetItemCount("Exposed Fish") >= 1 then
						conEF = "\n/use Exposed Fish"
					end
					if GetItemCount("Alpha Fin") >= 1 then 
						conAF = "\n/use Alpha Fin"
					end
					if GetItemCount("Voltscale Shield") >= 1 then
						conVS = "\n/use Voltscale Shield"
					end
					if GetItemCount("Storm Elemental Totem") >= 1 then
						conSET = "\n/use Storm Elemental Totem"
					end
					if GetItemCount("Sea Totem") >= 1 then
						conST = "\n/use Sea Totem"
					end
					if GetItemCount("Seastorm Totem") >= 1 then
						conSst = "\n/use Seastorm Totem"
					end
					if GetItemCount("Mudwrap") >= 1 then
						conMW = "\n/use Mudwrap"
					end
					if GetItemCount("Muck Slime") >= 1 then
						conMS = "\n/use Muck Slime"
					end
					-- Nazjatar exclusive and Aquatic mount
					if z == "Nazjatar" then
						if GetItemCount("Deepcoral Pod") >= 1 then
							conDB = "\n/use Deepcoral Pod"
						end
					end
					alt4 = alt4..""..conDB..""..conEF..""..conAF
					alt5 = conSET..""..conST..""..conSst..""..conMS..""..conVS..""..hasCannon
					alt6 = conMW
					CZ = "Rhan'ka's Escape Plan"		
				-- Arathi Highlands
				elseif z == "Arathi Highlands" then
					if GetItemCount("Thundering Essence") >= 1 then 
						conTE = "\n/use Thundering Essence"
					end
					if GetItemCount("Burning Essence") >= 1 then 
						conBE = "\n/use Burning Essence"
					end
					if GetItemCount("Cresting Essence") >= 1 then 
						conCE = "\n/use Cresting Essence"
					end
					if GetItemCount("Rumbling Essence") >= 1 then 
						conRE = "\n/use Rumbling Essence"
					end
					alt5 = hasCannon..""..conTE..""..conBE..""..conCE..""..conRE
				-- Argus
				elseif pp == "Argus" then
					EditMacro("WSxCGen+B",nil,nil,"#show\n/use Vindicaar Matrix Crystal")
					alt4 = alt4.."\n/use Baarut the Brisk"
					alt6 = "/use The \"Devilsaur\" Lunchbox"
					CZ = "Sightless Eye"
				-- Broken Isles is continent 8
				elseif pp == "Broken Isles" then
					alt5 = "/use Emerald Winds"..hasCannon
					alt6 = "/use The \"Devilsaur\" Lunchbox"
					CZ = "Sightless Eye"
					if z == "Highmountain" then
						alt4 = alt4.."\n/use Majestic Elderhorn Hoof"
					end
				-- Draenor is continent 7
				elseif (pp == "Draenor") or (pp == "Frostfire Ridge") or (pp == "Shadowmoon Valley") or (pp == "Ashran") then
					alt4 = alt4.."\n/use Spirit of Shinri\n/use Skull of the Mad Chief"
					alt5 = "/use Breath of Talador\n/use Black Whirlwind"..hasCannon
					alt6 = alt6.."\n/use Ever-Blooming Frond"
					CZ = "Aviana's Feather\n/use Treessassin's Guise"
					LAR = "Findle's Loot-A-Rang"
				elseif pp == "Timeless Isle" then
					alt4 = alt4.."\n/use Cursed Swabby Helmet\n/use Ash-Covered Horn\n/use Battle Horn"
					alt5 = "/use Bottled Tornado"..hasCannon
					alt6 = "/use Eternal Warrior's Sigil"
					CZ = "[combat]Salyin Battle Banner" 
				-- Pandaria
				elseif (pp == "Pandaria") or (pp == "Vale of Eternal Blossoms") then
					alt4 = alt4.."\n/use Cursed Swabby Helmet\n/use Battle Horn"
					alt5 = "/use Bottled Tornado"..hasCannon
					alt6 = "/use Eternal Warrior's Sigil"
					CZ = "[combat]Salyin Battle Banner" 
				-- Northrend
				elseif pp == "Northrend" then
					alt4 = alt4.."\n/use Grizzlesnout's Fang"
				end
				EditMacro("WLoot pls",nil,nil,"/click StaticPopup1Button1\n/use Battle Standard of Coordination\n/target mouseover\n/targetlasttarget [noharm,nocombat]\n/use "..LAR.."\n/use [exists,nodead,nochanneling]Rainbow Generator\n/use Gin-Ji Knife Set")
				
				-- (Shaman är default/fallback)
				local ccz = "\n/use [nospec:3]Lightning Shield;Water Shield"
				if class == "MAGE" then
					ccz = "\n/use [combat,help,nodead][nocombat]Arcane Intellect;Invisibility"
				elseif class == "WARLOCK" then
					ccz = "\n/use Lingering Wyrmtongue Essence\n/use [nocombat,noexists]Heartsbane Grimoire"
				elseif class == "MONK" then
					ccz = "\n/use Mystical Orb of Meditation"
				elseif class == "PALADIN" then
					ccz = "\n/use Mystical Orb of Meditation\n/use Mark of Purity\n/use !Devotion Aura"
				elseif class == "HUNTER" then
					local chameleon = ""
					if b("Aspect of the Chameleon") == "Aspect of the Chameleon" then
						chameleon = "Aspect of the Chameleon"
					else 
						chameleon = "Hunter's Call"
					end 
					ccz = "\n/use "..chameleon.."\n/use [nocombat]!Camouflage;Feign Death" 
				elseif class == "ROGUE" then
					ccz = "\n/use [combat]Vanish;[stance:0,nocombat]Stealth"
				elseif class == "PRIEST" then
						ccz = "\n/use Power Word: Fortitude"
					-- if Kyrian Prist
					if cov[slBP] == "Kyrian" then
						ccz = ccz.."\n/use Mystical Orb of Meditation"
					end
				elseif class == "DEATHKNIGHT" then
					ccz = "\n/use Haunting Memento\n/use [nopet,spec:3]Raise Dead"
				elseif class == "WARRIOR" then
					ccz = "\n/use Battle Shout\n/use Shard of Archstone"
					if cov[slBP] == "Kyrian" then
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
				
				if ccz and CZ and AR then
					if CZ ~= "" then 
						CZ = "\n/use "..CZ
					end
					EditMacro("WSxCGen+Z",nil,nil,"/use Seafarer's Slidewhistle\n/use [nostealth]Repurposed Fel Focuser"..CZ..ccz..itemBuilder("augmentRune",eLevel)..covSpecial)
					function ZigiPrintZoneVars()
						DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Recalibrating zone based variables :)\nalt4 = "..alt4.."\nalt5 = "..alt5.."\nalt6 = "..alt6.."\nCZ = "..CZ.."\nccz = "..ccz.."\nPoA = "..PoA.."\nAR = "..itemBuilder("augmentRune",eLevel).."\nconTE = "..conTE.."\nconRE = "..conRE.."\nconBE = "..conBE.."\nconCE = "..conCE.."\nhasCannon = "..hasCannon.."\nz = "..z.."\nmap.name = "..map.name.."\nparent.name = "..parent.name.."\npp = "..pp,0.5,1.0,0.0)
					end
				end		
					
				if class == "DEATHKNIGHT" then
					PoA = "harm,nodead,@arena"
				else
					PoA = "help,nodead,@party"
				end    
	      		      		    
				EditMacro("WMPAlt+4",nil,nil,"/target [@boss1,exists,nodead,nomod:ctrl]\n/target [@arena1,exists,nodead,nomod:ctrl]\n/use [mod:ctrl,"..PoA.. "1,nodead]"..aC[class]..alt4)
				EditMacro("WMPAlt+5",nil,nil,"/target [@boss2,exists,nodead,nomod:ctrl]\n/target [@arena2,exists,nodead,nomod:ctrl]\n/use [mod:ctrl,"..PoA.. "2,nodead]"..aC[class]..alt5)
				EditMacro("WMPAlt+6",nil,nil,"/target [@boss3,exists,nodead,nomod:ctrl]\n/target [@arena3,exists,nodead,nomod:ctrl]\n/use [mod:ctrl,"..PoA.."3,nodead]"..aC[class]..alt6)
				EditMacro("WMPAlt+9",nil,nil,"/focus [@arena3,exists,nodead]\n/target [@boss6,exists]Boss6"..alt9)
				

				EditMacro("wWBGHealer1",nil,nil,"/use [mod:alt,@arena1,harm,nodead]"..altArenaDots[class]..";[mod:ctrl,@arena1,harm,nodead]"..ctrlArenaDots[class]..";[@arena1,harm,nodead]"..arenaDots[class])
				EditMacro("wWBGHealer2",nil,nil,"/use [mod:alt,@arena2,harm,nodead]"..altArenaDots[class]..";[mod:ctrl,@arena2,harm,nodead]"..ctrlArenaDots[class]..";[@arena2,harm,nodead]"..arenaDots[class])        
				EditMacro("wWBGHealer3",nil,nil,"/use [mod:alt,@arena3,harm,nodead]"..altArenaDots[class]..";[mod:ctrl,@arena3,harm,nodead]"..ctrlArenaDots[class]..";[@arena3,harm,nodead]"..arenaDots[class])
				-- numpad 7-8-9
				EditMacro("wWBGHealer4",nil,nil,"/use [mod:alt,"..PoA.."1]"..numaltbuff789[class]..";[mod:ctrl,"..PoA.."1]"..numctrlbuff789[class]..";["..PoA.."1]"..numnomodbuff789[class])
				EditMacro("wWBGHealer5",nil,nil,"/use [mod:ctrl,"..PoA.."2]"..numctrlbuff789[class]..";["..PoA.."2]"..numnomodbuff789[class])
				
				-- EditMacro("wWBGHealer4",nil,nil,"/use [mod:alt,@arena4,harm,nodead]"..altArenaDots[class]..";[@arena4,harm,nodead]"..arenaDots[class])

				-- shift+numpad 10-11-12
				EditMacro("wWBGHealerSet1",nil,nil,"/use [mod:alt,"..PoA.."1]"..numaltbuff101112[class]..";[mod:ctrl,"..PoA.."1]"..numctrlbuff101112[class]..";["..PoA.."1]"..numnomodbuff101112[class])
				EditMacro("wWBGHealerSet2",nil,nil,"/use [mod:alt,"..PoA.."2]"..numaltbuff101112[class]..";[mod:ctrl,"..PoA.."2]"..numctrlbuff101112[class]..";["..PoA.."2]"..numnomodbuff101112[class])        
				EditMacro("wWBGHealerSet3",nil,nil,"/use [mod:alt,"..PoA.."3]"..numaltbuff101112[class]..";[mod:ctrl,"..PoA.."3]"..numctrlbuff101112[class]..";["..PoA.."3]"..numnomodbuff101112[class])

				EditMacro("wWBGHealerSet4",nil,nil,"/use [mod:alt,"..PoA.."1]"..modnumaltbuff789[class]..";[mod:ctrl,"..PoA.."2]"..modnumctrlbuff789[class]..";["..PoA.."1]"..modnumnomodbuff789[class])
				
				-- shift + 4-5-6
				EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1,harm,nodead]"..wmpaltpurge[class]..";[mod:ctrl,@arena1,harm,nodead]"..wmpctrlcc[class]..";[@arena1,harm,nodead][@boss1,harm,nodead]"..wmpnomodkick[class]..";")
				EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2,harm,nodead]"..wmpaltpurge[class]..";[mod:ctrl,@arena2,harm,nodead]"..wmpctrlcc[class]..";[@arena2,harm,nodead][@boss2,harm,nodead]"..wmpnomodkick[class]..";")        
				EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3,harm,nodead]"..wmpaltpurge[class]..";[mod:ctrl,@arena3,harm,nodead]"..wmpctrlcc[class]..";[@arena3,harm,nodead][@boss3,harm,nodead]"..wmpnomodkick[class]..";")	
				
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
					EditMacro("wWBGHealer1",nil,nil,"/use [mod:alt,@boss1,harm,nodead]"..altArenaDots[class]..";[@boss1,harm,nodead]"..arenaDots[class])
					EditMacro("wWBGHealer2",nil,nil,"/use [mod:alt,@boss2,harm,nodead]"..altArenaDots[class]..";[@boss2,harm,nodead]"..arenaDots[class])        
					EditMacro("wWBGHealer3",nil,nil,"/use [mod:alt,@boss3,harm,nodead]"..altArenaDots[class]..";[@boss3,harm,nodead]"..arenaDots[class])	
					EditMacro("wWBGHealer4",nil,nil,"/cleartarget")
					EditMacro("wWBGHealer6",nil,nil,"/use [mod:alt,"..PoA.."4]"..numaltbuff101112[class]..";[mod:ctrl,"..PoA.."4]"..numctrlbuff101112[class]..";["..PoA.."4]"..numnomodbuff101112[class])				-- shift+numpad 10-11-12
					-- EditMacro("wWBGHealer6",nil,nil,"/cleartarget")
					EditMacro("wWBGHealerSet1",nil,nil,"/use [mod:alt,"..PoA.."1]"..numaltbuff101112[class]..";[mod:ctrl,"..PoA.."1]"..numctrlbuff101112[class]..";["..PoA.."1]"..numnomodbuff101112[class])
					EditMacro("wWBGHealerSet2",nil,nil,"/use [mod:alt,"..PoA.."2]"..numaltbuff101112[class]..";[mod:ctrl,"..PoA.."2]"..numctrlbuff101112[class]..";["..PoA.."2]"..numnomodbuff101112[class])        
					EditMacro("wWBGHealerSet3",nil,nil,"/use [mod:alt,"..PoA.."3]"..numaltbuff101112[class]..";[mod:ctrl,"..PoA.."3]"..numctrlbuff101112[class]..";["..PoA.."3]"..numnomodbuff101112[class])
					EditMacro("wWBGHealerSet6",nil,nil,"/use [mod:alt,"..PoA.."4]"..numaltbuff101112[class]..";[mod:ctrl,"..PoA.."4]"..numctrlbuff101112[class]..";["..PoA.."4]"..numnomodbuff101112[class])
					-- EditMacro("wWBGHealerSet4",nil,nil,"/use [mod:alt,"..PoA.."4]"..numaltbuff789[class]..";[mod:ctrl,"..PoA.."4]"..numctrlbuff789[class]..";["..PoA.."4]"..numnomodbuff789[class])
					-- EditMacro("wWBGHealerSet6",nil,nil,"/use [mod:alt,"..PoA.."6]"..numaltbuff789[class]..";[mod:ctrl,"..PoA.."6]"..numctrlbuff789[class]..";["..PoA.."6]"..numnomodbuff789[class])
				end
				--DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Talent change detected! :)",0.5,1.0,0.0)
			end -- map
		end
		-- item, zone, covenant, spec
		if (event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_SPECIALIZATION_CHANGED" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "TRAIT_CONFIG_UPDATED" or event == "BAG_UPDATE_DELAYED" or event == "PLAYER_ENTERING_WORLD") and not InCombatLockdown() then
			-- Byta talent eller zone events
 
		    -- Class Artifact Button, "§" Completed, note: Kanske kan hooka Heart Essence till fallback från Cov och Signature Ability? Sedan behöver vi hooka Ritual of Doom till Warlock Order Hall också.
			-- Covenant and Signature Ability parser
			-- Kyrian, "Summon Steward", phial of serenity

			if cov[slBP] == "Kyrian" then
				poS = "\n/use [mod]item:177278"
				sigA = "Summon Steward"
				if class == "SHAMAN" then
					covA = "Vesper Totem"
				elseif class == "MAGE" then
					covA = "Radiant Spark"
				elseif class == "WARLOCK" then
					covA = "Scouring Tithe"
				elseif class == "MONK" then
					covA = "Weapons of Order"
				elseif class == "PALADIN" then
					covA = "Divine Toll"
				elseif class == "HUNTER" then
					covA = "Resonating Arrow"
				elseif class == "ROGUE" then
					covA = "Echoing Reprimand"
				elseif class == "PRIEST" then
					covA = "Boon of the Ascended"
				elseif class == "DEATHKNIGHT" then
					covA = "Shackle the Unworthy"
				elseif class == "WARRIOR" then
					covA = "Spear of Bastion"
				elseif class == "DRUID" then
					covA = "Kindred Spirits"
				elseif class == "DEMONHUNTER" then
					covA = "Elysian Decree"
				end
			-- Necrolord, "Fleshcraft" 
			elseif cov[slBP] == "Necrolord" then
				poS = ""
				sigA = "Fleshcraft"
				if class == "SHAMAN" then
					covA = "Primordial Wave"
				elseif class == "MAGE" then
					covA = "Deathborne"
				elseif class == "WARLOCK" then
					covA = "Decimating Bolt"
				elseif class == "MONK" then
					covA = "Bonedust Brew"
				elseif class == "PALADIN" then
					covA = "Vanquisher's Hammer"
				elseif class == "HUNTER" then
					covA = "Death Chakram"
				elseif class == "ROGUE" then
					covA = "Serrated Bone Spike"
				elseif class == "PRIEST" then
					covA = "Unholy Nova"
				elseif class == "DEATHKNIGHT" then
					covA = "Abomination Limb"
				elseif class == "WARRIOR" then
					covA = "Conqueror's Banner"
				elseif class == "DRUID" then
					covA = "Adaptive Swarm(Necrolord)"
				elseif class == "DEMONHUNTER" then
					covA = "Fodder to the Flame"
				end
			-- Night Fae, "Soulshape"
			elseif cov[slBP] == "Night Fae" then
				poS = ""
				sigA = "Soulshape"
				if class == "SHAMAN" then
					covA = "Fae Transfusion"
				elseif class == "MAGE" then
					covA = "Shifting Power"
				elseif class == "WARLOCK" then
					covA = "Soul Rot"
				elseif class == "MONK" then
					covA = "Faeline Stomp"
				elseif class == "PALADIN" then
					covA = "Blessing of Summer"
				elseif class == "HUNTER" then
					covA = "Wild Spirits"
				elseif class == "ROGUE" then
					covA = "Sepsis"
				elseif class == "PRIEST" then
					covA = "Fae Guardians"
				elseif class == "DEATHKNIGHT" then
					covA = "Death's Due"
				elseif class == "WARRIOR" then
					covA = "Ancient Aftershock"
				elseif class == "DRUID" then
					covA = "Convoke the Spirits"
				elseif class == "DEMONHUNTER" then
					covA = "The Hunt"
				end
			-- Venthyr, "Door of Shadows"
			elseif cov[slBP] == "Venthyr" then
				poS = ""
				sigA = "Door of Shadows"
				if class == "SHAMAN" then
					covA = "Chain Harvest"
				elseif class == "MAGE" then
					covA = "Mirrors of Torment"
				elseif class == "WARLOCK" then
					covA = "Impending Catastrophe"
				elseif class == "MONK" then
					covA = "Fallen Order"
				elseif class == "PALADIN" then
					covA = "Ashen Hallow"
				elseif class == "HUNTER" then
					covA = "Flayed Shot"
				elseif class == "ROGUE" then
					covA = "Flagellation"
				elseif class == "PRIEST" then
					covA = "Mindgames"
				elseif class == "DEATHKNIGHT" then
					covA = "Swarming Mist"
				elseif class == "WARRIOR" then
					covA = "Condemn"
				elseif class == "DRUID" then
					covA = "Ravenous Frenzy"
				elseif class == "DEMONHUNTER" then
					covA = "Sinful Brand"
				end
			end
		
			-- hard exceptions

			if class == "EVOKER" then 
				covA = "Boon of the Covenants"
			end
					
			sigB = "[@mouseover,exists,nodead,mod][@cursor,mod]"..sigA
			covB = "[@mouseover,exists,nodead][@cursor]"..covA..poS
			hoaEq = "[@mouseover,exists,nodead][@cursor]Heart Essence"
			
			if ((slBP == 2 and class == "WARRIOR") and IsEquippedItem("Heart of Azeroth") and not slZones[z]) then
				slBPGen = sigB..";"..hoaEq
			-- elseif (slBP == 2 and class == "WARRIOR") then 
			-- 	hoaEq = "13"
			-- 	slBPGen = sigB..";"..hoaEq
			elseif (IsEquippedItem("Heart of Azeroth") and (not slZones[z])) then
				sigA = "The Golden Banana"
				covA = "Murglasses"
				if slBP == 3 then
					sigA = "Seed of Renewed Souls"
				end
				sigB = "[@mouseover,exists,nodead,mod][@cursor,mod]"..sigA
				slBPGen = sigB..";"..hoaEq
			elseif (slBP and not slZones[z]) then
			-- elseif (slBP ~= 0 and not slZones[z]) then
				sigA = "The Golden Banana"
				covA = "Murglasses"
				if slBP == 3 then
					sigA = "Seed of Renewed Souls"
				end
				if class == "SHAMAN" then
					sigA = b("Nature's Swiftness")
					if b("Primordial Wave") == "Primordial Wave" then
						covA = b("Primordial Wave")
						sigA = b("Primordial Wave")
					elseif b("Doom Winds") == "Doom Winds" then
						covA = b("Doom Winds")
					end
				elseif class == "MAGE" then
					covA = b("Mirror Image") 
					if b("Radiant Spark") == "Radiant Spark" then
						covA = b("Radiant Spark")
					elseif b("Glacial Spike") == "Glacial Spike" then
						covA = b("Glacial Spike")
					elseif b("Meteor") == "Meteor" then
						covA = b("Meteor")
					end
					if b("Shifting Power") == "Shifting Power" then
						sigA = b("Shifting Power")
					elseif b("Mirror Image") == "Mirror Image" then
						sigA = b("Mirror Image")
					elseif b("Cold Snap") == "Cold Snap" then
						sigA = b("Cold Snap")
					elseif b("Meteor") == "Meteor" then
						sigA = b("Meteor")
					end
				elseif class == "WARLOCK" then
					if b("Summon Soulkeeper") == "Summon Soulkeeper" then
						covA = b("Summon Soulkeeper")
					elseif b("Soul Rot") == "Soul Rot" then
						covA = b("Soul Rot")
					elseif b("Guillotine") == "Guillotine" then
						covA = b("Guillotine")
					elseif b("Dimensional Rift") == "Dimensional Rift" then
						covA = b("Dimensional Rift")
					elseif b("Inquisitor's Gaze") == "Inquisitor's Gaze" then
						covA = b("Inquisitor's Gaze")
					end
					if b("Soul Rot") == "Soul Rot" then
						sigA = b("Soul Rot")
					elseif b("Dimensional Rift") == "Dimensional Rift" then
						sigA = b("Dimensional Rift")
					elseif b("Guillotine") == "Guillotine" then
						sigA = b("Guillotine")
					elseif b("Summon Soulkeeper") == "Summon Soulkeeper" then
						sigA = b("Summon Soulkeeper")
					elseif b("Inquisitor's Gaze") == "Inquisitor's Gaze" then
						sigA = b("Inquisitor's Gaze")
					end
				elseif class == "MONK" then
					if b("Sheilun's Gift") == "Sheilun's Gift" then
						covA = b("Sheilun's Gift")
					elseif b("Bonedust Brew") == "Bonedust Brew" then
						covA = b("Bonedust Brew")
					elseif b("Jadefire Stomp") == "Jadefire Stomp" then
						covA = b("Jadefire Stomp")
					elseif b("Strike of the Windlord") == "Strike of the Windlord" then
						covA = b("Strike of the Windlord")
					end
					if b("Weapons of Order") == "Weapons of Order" then
						sigA = b("Weapons of Order")
					elseif b("Jadefire Stomp") == "Jadefire Stomp" then
						sigA = b("Jadefire Stomp")
					elseif b("Bonedust Brew") == "Bonedust Brew" then
						sigA = b("Bonedust Brew")
					elseif b("Sheilun's Gift") == "Sheilun's Gift" then
						sigA = b("Sheilun's Gift")
					end
				elseif class == "PALADIN" then
					if b("Blessing of Summer") == "Blessing of Summer" then
						covA = b("Blessing of Summer")
					elseif b("Divine Toll") == "Divine Toll" then
						covA = b("Divine Toll")
					end
					if b("Divine Toll") == "Divine Toll" then
						sigA = b("Divine Toll")
					elseif b("Blessing of Summer") == "Blessing of Summer" then
						sigA = b("Blessing of Summer")
					end
				elseif class == "HUNTER" then
					if b("Death Chakram") == "Death Chakram" then
						covA = b("Death Chakram")
					elseif b("Stampede") == "Stampede" then
						covA = b("Stampede")
					end
				elseif class == "ROGUE" then
					if b("Flagellation") == "Flagellation" then
						covA = b("Flagellation")
					elseif b("Sepsis") == "Sepsis" then
						covA = b("Sepsis")
					elseif b("Serrated Bone Spike") == "Serrated Bone Spike" then
						covA = b("Serrated Bone Spike")
					elseif b("Ghostly Strike") == "Ghostly Strike" then
						covA = b("Ghostly Strike")
					elseif b("Echoing Reprimand") == "Echoing Reprimand" then
						covA = b("Echoing Reprimand")
					elseif b("Goremaw's Bite") == "Goremaw's Bite" then
						covA = b("Goremaw's Bite")
					end
					if b("Echoing Reprimand") == "Echoing Reprimand" then
						sigA = b("Echoing Reprimand")
					elseif b("Serrated Bone Spike") == "Serrated Bone Spike" then
						sigA = b("Serrated Bone Spike")
					elseif b("Ghostly Strike") == "Ghostly Strike" then
						sigA = b("Ghostly Strike")
					elseif b("Sepsis") == "Sepsis" then
						sigA = b("Sepsis")
					elseif b("Flagellation") == "Flagellation" then
						sigA = b("Flagellation")
					elseif b("Goremaw's Bite") == "Goremaw's Bite" then
						sigA = b("Goremaw's Bite")
					end
				elseif class == "PRIEST" then
					if b("Mindgames") == "Mindgames" then
						covA = b("Mindgames")
					elseif b("Power Word: Life") == "Power Word: Life" then
						covA = b("Power Word: Life")
					end
					if b("Empyreal Blaze") == "Empyreal Blaze" then
						sigA = b("Empyreal Blaze")
					elseif b("Void Torrent") == "Void Torrent" then
						sigA = b("Void Torrent")
					elseif b("Rapture") == "Rapture" then
						sigA = b("Rapture")
					end
				elseif class == "DEATHKNIGHT" then
					if b("Blood Tap") == "Blood Tap" then
						covA = b("Blood Tap")
					elseif b("Abomination Limb") == "Abomination Limb" then
						covA = b("Abomination Limb")
					elseif b("Empower Rune Weapon") == "Empower Rune Weapon" then
						covA = b("Empower Rune Weapon")
					end
					if b("Rune Tap") == "Rune Tap" then
						sigA = b("Rune Tap")
					elseif b("Horn of Winter") == "Horn of Winter" then
						sigA = b("Horn of Winter")
					elseif b("Abomination Limb") == "Abomination Limb" then
						sigA = b("Abomination Limb")
					end
				elseif class == "WARRIOR" then
					if b("Champion's Spear") == "Champion's Spear" then
						covA = b("Champion's Spear")
					elseif b("Odyn's Fury") == "Odyn's Fury" then
						covA = b("Odyn's Fury")
					end
					if b("Odyn's Fury") == "Odyn's Fury" then
						sigA = b("Odyn's Fury")
					end
				elseif class == "DRUID" then
					if b("Adaptive Swarm") == "Adaptive Swarm" then
						covA = b("Adaptive Swarm")
					elseif b("Rage of the Sleeper") == "Rage of the Sleeper" then
						covA = b("Rage of the Sleeper")
					elseif b("Convoke the Spirits") == "Convoke the Spirits" then
						covA = b("Convoke the Spirits")
					end
					if b("Astral Communion") == "Astral Communion" then
						sigA = b("Astral Communion")
					elseif b("Convoke the Spirits") == "Convoke the Spirits" then
						sigA = b("Convoke the Spirits")
					elseif b("Adaptive Swarm") == "Adaptive Swarm" then
						sigA = b("Adaptive Swarm")
					end
				elseif class == "DEMONHUNTER" then
					if b("Elysian Decree") == "Elysian Decree" then
						covA = b("Elysian Decree")
					elseif b("Soul Carver") == "Soul Carver" then
						covA = b("Soul Carver")
					end
					if b("Soul Carver") == "Soul Carver" then
						sigA = b("Soul Carver")
					elseif b("Immolation Aura") == "Immolation Aura" then
						sigA = b("Immolation Aura")
					end
					if b("Fel Barrage") == "Fel Barrage" then
						covA = b("Fel Barrage")
					end
				elseif class == "EVOKER" then
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
			if (IsEquippedItem("Heart of Azeroth") and (not slZones[z])) then
				hoaEq = "\n/stopspelltarget\n/stopspelltarget\n/use [mod,@player][@mouseover,exists,nodead][@cursor]Heart Essence"
				if class == "MAGE" then
					hasHE = "\n/castsequence Mirror Image, Heart Essence"
				else
					hasHE = "\n/use Heart Essence" 
				end
			elseif class == "SHAMAN" then 
				hoaEq = b("Spirit Link Totem","[]",";").."Far Sight"
			elseif class == "MAGE" then
				hoaEq = b("Mass Polymorph","[]",";").."Polymorph"
			elseif class == "WARLOCK" then
				hoaEq = b("Demonic Gateway")
			elseif class == "MONK" then 
				hoaEq = b("Song of Chi-Ji")..b("Ring of Peace")
			elseif class == "PALADIN" then 
				hoaEq = b("Divine Steed")
			elseif class == "HUNTER" then 
				hoaEq = b("Misdirection","[]","")
			elseif class == "ROGUE" then 
				hoaEq = "Shroud of Concealment"
			elseif class == "PRIEST" then 
				hoaEq = b("Evangelism","[]",";").."Mind Soothe"
			elseif class == "DEATHKNIGHT" then 
				hoaEq = b("Wraith Walk","[]",";")..b("Anti-Magic Zone","[]","")
			elseif class == "WARRIOR" then 
				hoaEq = b("Piercing Howl")
			elseif class == "DRUID" then 
				hoaEq = b("Ursol's Vortex","[]",";")..b("Mass Entanglement","[]",";").."Barkskin"
			elseif class == "DEMONHUNTER" then 
				hoaEq = "Shattered Souls"
			elseif class == "EVOKER" then 
				hoaEq = b("Oppressing Roar","[]",";")..b("Obsidian Scales","[]","")
			end
			
			EditMacro("WArtifactCDs",nil,nil,"#show\n/stopspelltarget\n/stopspelltarget\n/cast "..itemBuilder("resItem")..slBPGen)
			EditMacro("WSxCAGen+§",nil,nil,"/cast [@player,mod:shift]"..sigA..";[@player][@mouseover,exists,nodead][@cursor]"..covA)

			local weaponNames = {
				"Iridal, the Earth's Master",
				"Dreambinder, Loom of the Great Cycle",
			}

			local weaponEquipped = ""
			for i, weaponNames in pairs(weaponNames) do
				if IsEquippedItem(weaponNames) == true then
					weaponEquipped = "\n/use "..weaponNames
				end
			end

			EditMacro("WSxAGen+4",nil,nil,"#showtooltip 13"..weaponEquipped.."\n/use [@mouseover,exists,nodead][@cursor][]13")
			EditMacro("Wx1Trinkit",nil,nil,"#show "..hoaEq.."\n/use [nocombat,noexists]Wand of Simulated Life\n/stopmacro [combat,channeling]\n/use Attraction Sign\n/use Rallying War Banner"..pennantClass)
		
		end
		-- consumablebuilder(bladlast
		if (event == "TRAIT_CONFIG_UPDATED" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PLAYER_SPECIALIZATION_CHANGED" or event == "BAG_UPDATE_DELAYED" or event == "PET_SPECIALIZATION_CHANGED" or event == "PLAYER_ENTERING_WORLD") and not InCombatLockdown() then
	
			EditMacro("WSxBladlast",nil,nil,"#show\n/use " ..consumableBuilder("bladlast",faction))
			-- #show Bloodlust, Time Warp, Netherwinds, Drums and Favorite mount - Ctrl+Shift+V
			EditMacro("WSxFavMount",nil,nil,"#show " ..consumableBuilder("bladlast",faction).. "\n/run C_MountJournal.SummonByID(0)\n/dismount [mounted]\n/cancelaura Bear Form\n/cancelaura Cat Form\n/cancelaura Zen Flight\n/cancelaura Flaming Hoop\n/cancelaura Prowl\n/use Celebration Firework\n/cancelaura Stealth")
			if class == "HUNTER" then
				EditMacro("WSxGenR",nil,nil,"/stopspelltarget\n/use "..b("Tar Trap","[mod:shift,@mouseover,exists,nodead][mod:shift,@cursor]",";")..bPet("Master's Call","[mod:ctrl,@player][@mouseover,help,nodead,nomod][help,nodead,nomod]",";")..bPet("Fortitude of the Bear","[mod:ctrl]",";").."[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Wing Clip\n/targetenemy [noharm]")
			end
		end

		-- itembuilder, consumablebuilder
		if (event == "BAG_UPDATE_DELAYED" or event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_SPECIALIZATION_CHANGED" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD") and not InCombatLockdown() then
		
								
			EditMacro("Wx3ShowPot", nil, "INV_MISC_QUESTIONMARK", nil, 1, 1)
			EditMacro("Wx3ShowPot",nil, nil,"/use "..consumableBuilder("potion","","\n/use Hell-Bent Bracers\n/doom"))
			if GetItemCount(consumableBuilder("potion")) < 1 then
				EditMacro("Wx3ShowPot", nil, 132380, "#show\n/oops", 1, 1)
			end
			EditMacro("WTonic",nil,nil,"#show [mod:shift]"..itemBuilder("fartToy",slBP)..";"..consumableBuilder("tonic").."\n/use "..itemBuilder("fartToy",slBP).."\n/use "..consumableBuilder("tonic"))
			EditMacro("WSxCGen+J",nil,nil,"#show\n/use "..consumableBuilder("invispot"))
		    EditMacro("Wx2Garrisons",nil,nil,"#show\n/use [nocombat,noexists,nomod:alt]Mobile Banking(Guild Perk);[mod:shift]Narcissa's Mirror;"..consumableBuilder("nimblebrew"))
			if GetItemCount(consumableBuilder("water")) > 0 then
				EditMacro("WWeyrnstone",nil,nil,consumableBuilder("water","/use "))
			else
				EditMacro("WWeyrnstone",nil,nil,"/use Whispers of Rai'Vosh\n/helpme")
			end
			if GetItemCount("Weyrnstone") >= 1 then
				EditMacro("WWeyrnstone",nil,nil,"/use Weyrnstone\n/run PlaySound(15160)")
			end
			EditMacro("WFirstAid",nil,nil,"/run local c,g = GetTitleName(GetCurrentTitle()),GetCurrentTitle() if not((c == \"Field Medic\") or (g == 372)) then SetTitleByName(\"Field Medic\") end\n/use "..consumableBuilder("bandages",""))
			if GetItemCount("Healthstone", false) >= 1 then
				EditMacro("WShow",nil,nil,"/use "..consumableBuilder("water","[mod:alt,nocombat]",";")..consumableBuilder("manapot","[mod:alt]",";")..((hsBuilder("HS","[mod:ctrl]",";",class, slBP, z, eLevel, playerSpec, race, playerName) or "") or "")..consumableBuilder("bandages","[mod]",";").."Healthstone\n/stopmacro [mod]"..((hsBuilder("hsToy","","",class, slBP, z, eLevel, playerSpec, race, playerName) or "") or "").."\n/run PlaySound(15160)\n/glare")
			else
				EditMacro("WShow",nil,nil,"/use "..consumableBuilder("water","[mod:alt,nocombat]",";")..consumableBuilder("manapot","[mod:alt]",";")..((hsBuilder("HS","[mod:ctrl]",";",class, slBP, z, eLevel, playerSpec, race, playerName) or "") or "")..consumableBuilder("bandages","[mod]").."\n/stopmacro [mod]"..((hsBuilder("hsToy","","",class, slBP, z, eLevel, playerSpec, race, playerName) or "") or "").."\n/use Healthstone\n/run PlaySound(15160)\n/cry", 1, 1)
			end  
			if class == "SHAMAN" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Ancestral Spirit;"..pwned.."\n/use [mod:ctrl]Ancestral Vision"..itemBuilder("brazier"))
			elseif class == "MAGE" then
				if b("Arcane Barrage") == "Arcane Barrage" then override = "[@mouseover,harm,nodead][harm,nodead]Arcane Barrage;"
				elseif b("Ice Lance") == "Ice Lance" then override = "[@mouseover,harm,nodead][harm,nodead]Ice Lance;"
				elseif b("Fire Blast") == "Fire Blast" then override = "[@mouseover,harm,nodead][harm,nodead]Fire Blast;"
				end 
				EditMacro("WSxGen5",nil,nil,"/stopspelltarget [@mouseover,harm,nodead][harm,nodead][exists,nodead]\n/targetenemy [noexists]\n/use "..b("Alter Time", "[mod]!",";")..override..itemBuilder("broom"))
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..itemBuilder("brazier"))
				EditMacro("WSxSGen+1",nil,nil,"/run local c=C_Container for i=0,4 do for x=1,c.GetContainerNumSlots(i)do y=c.GetContainerItemLink(i,x)if y and GetItemInfo(y)==\""..consumableBuilder("water").."\"then c.PickupContainerItem(i,x)DropItemOnUnit(\"target\")return end end end\n/click TradeFrameTradeButton")
				EditMacro("WSxSGen+2",nil,nil,"#show "..b("Presence of Mind","[combat][harm,nodead]",";")..consumableBuilder("water").."\n/use [nocombat,noexists]"..consumableBuilder("water").."\n/use Gnomish X-Ray Specs\n/stopcasting [spec:2]\n/use "..b("Presence of Mind","[combat][harm,nodead]",";").."[nocombat]Conjure Refreshment")
				EditMacro("WSxGenU",nil,nil,"#showtooltip\n/use "..consumableBuilder("managem"))
				EditMacro("WSxSGen+F",nil,nil,"#show Familiar Stone\n/cancelaura [mod:alt]Shado-Pan Geyser Gun\n/use [help,nocombat,mod:alt]B. F. F. Necklace;[nocombat,noexists,mod:alt]Gastropod Shell;[nomod:alt]"..consumableBuilder("managem").."\n/use [nomod:alt]Familiar Stone")
			elseif class == "WARLOCK" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..itemBuilder("brazier"))
			elseif class == "MONK" then 
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Resuscitate;"..pwned.."\n/use [mod:ctrl]Reawaken"..itemBuilder("brazier"))
			elseif class == "PALADIN" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Redemption;"..pwned.."\n/use [mod:ctrl]Absolution"..itemBuilder("brazier"))
				EditMacro("WSxCAGen+F",nil,nil,b("Blessing of Summer","/targetfriendplayer\n/use [help,nodead]",";Strength of Conviction\n/targetlasttarget").."\n/stopmacro [combat,exists]"..itemBuilder("instrument",noPants))
			elseif class == "HUNTER" then
				EditMacro("WSxGen3",nil,nil,"/targetlasttarget [noexists,nocombat,nodead]\n/use "..b("Kill Shot","[@mouseover,harm,nodead][harm,nodead]",";")..((itemBuilder("flyingSkinner") or "") or "").."Imaginary Gun\n/targetenemy [noharm]\n/cleartarget [dead]"..((itemBuilder("inject",class,playerSpec) or "") or "").."\n/targetlasttarget [dead]")
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..itemBuilder("brazier"))
			elseif class == "ROGUE" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..itemBuilder("brazier"))
			elseif class == "PRIEST" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Resurrection;"..pwned.."\n/use [mod:ctrl]Mass Resurrection"..itemBuilder("brazier"))
			elseif class == "DEATHKNIGHT" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..itemBuilder("brazier"))
				EditMacro("WSxCAGen+F",nil,nil,"#show Lichborne"..itemBuilder("instrument",noPants))
			elseif class == "WARRIOR" then
				if playerSpec ~= 3 and b("Thunder Clap") == "Thunder Clap" then override = "Thunder Clap"
				elseif b("Bladestorm") == "Bladestorm" then override = "Bladestorm"
				elseif b("Sweeping Strikes") == "Sweeping Strikes" then override = "Sweeping Strikes"
				elseif playerSpec == 3 then override = "Whirlwind"
				else override = "Slam"
				end
				EditMacro("WSxGen7",nil,nil,"/use [mod]Shield Block;"..override.."\n/use "..b("Defensive Stance","[mod,nostance:1]!","").."\n/startattack"..(itemBuilder("inject",class,playerSpec) or "") or "")
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..itemBuilder("brazier"))
				EditMacro("WSxCAGen+F",nil,nil,"#show "..b("Rallying Cry","[]","").."\n/use [nocombat]Throbbing Blood Orb\n/stopmacro [combat,exists]"..itemBuilder("instrument",noPants))
				if b("Die by the Sword") == "Die by the Sword" then override = "Die by the Sword"
				elseif b("Enraged Regeneration") == "Enraged Regeneration" then override = "Enraged Regeneration"
				elseif b("Shield Wall") == "Shield Wall" then override = "Shield Wall"
				end
				EditMacro("WSxGenZ",nil,nil,"/use "..b("Defensive Stance","[mod:alt][mod:shift]!",";").."[mod:shift]Shield Block;"..override..(itemBuilder("inject",class,playerSpec) or "").."\n/use Stormforged Vrykul Horn\n/use [mod:alt]Gateway Control Shard")
			elseif class == "DRUID" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant\n/cancelaura Flap"..itemBuilder("glider")..";[mod]6;[nocombat]Revive;"..pwned.."\n/use [mod:ctrl]Revitalize"..itemBuilder("brazier"))
			elseif class == "DEMONHUNTER" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant\n/cancelaura Glide"..itemBuilder("glider")..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..itemBuilder("brazier"))
			elseif class == "EVOKER" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant\n/cancelaura Glide"..itemBuilder("glider")..";[mod]6;[nocombat]Return;"..pwned.."\n/use [mod:ctrl]Mass Return"..itemBuilder("brazier"))
			end
		end

		--grouprosterbuilder, group roster update or spec talent change or on load
		if (event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_SPECIALIZATION_CHANGED" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD") and not InCombatLockdown() then
			
			override = ""
			overrideModCtrl = ""
			overrideModAlt = ""
			if class == "SHAMAN" then
				if b("Windfury Weapon") == "Windfury Weapon" then overrideModAlt = "[mod:alt]Windfury Weapon;"
				elseif b("Earthliving Weapon") == "Earthliving Weapon" then overrideModAlt = "[mod:alt]Earthliving Weapon;"
				end
				if b("Spirit Walk") == "Spirit Walk" then override = "[mod:shift]Spirit Walk;"
				elseif b("Spiritwalker's Grace") == "Spiritwalker's Grace" then override = "[mod:shift]Spiritwalker's Grace;"
				end
				EditMacro("WSxGenX",nil,nil,"/use "..overrideModAlt.."[mod:ctrl]Astral Recall;"..override..b("Earth Shield","[@mouseover,help,nodead]["..groupRosterBuilder("tank").."][]",";")..b("Lightning Shield").."\n/use Void Totem\n/use Deceptia's Smoldering Boots")
			elseif class == "MAGE" then 
			elseif class == "WARLOCK" then
			elseif class == "MONK" then 
				EditMacro("WSxGenH",nil,nil,"#show "..b("Paralysis").."\n/use "..b("Life Cocoon","[mod:shift,"..groupRosterBuilder("tank").."]",";")..b("Healing Elixir","[]","").."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
			elseif class == "PALADIN" then
				if b("Retribution Aura") == "Retribution Aura" then overrideModAlt = "[mod:alt]!Retribution Aura;"
				elseif b("Concentration Aura") == "Concentration Aura" then overrideModAlt = "[mod:alt]!Concentration Aura;"
				end
				if b("Barrier of Faith") == "Barrier of Faith" then override = "[@mouseover,help,nodead]["..groupRosterBuilder("tank").."][]Barrier of Faith"
				elseif b("Divine Favor") == "Divine Favor" then override = "Divine Favor"
				elseif b("Hand of Divinity") == "Hand of Divinity" then override = "Hand of Divinity"
				elseif b("Ardent Defender") == "Ardent Defender" then override = "Ardent Defender"
				elseif b("Shield of Vengeance") == "Shield of Vengeance" then override = "Shield of Vengeance"
				elseif b("Lay on Hands") == "Lay on Hands" then override = "[@mouseover,help,nodead][]Lay on Hands"
				end
				EditMacro("WSxGenX",nil,nil,"#show\n/use "..overrideModAlt..b("Blessing of Freedom","[mod:shift]",";")..override)
				overrideModAlt = ""
				if b("Repentance") == "Repentance" then overrideModAlt = "[mod:ctrl,@mouseover,harm,nodead][mod:ctrl]Repentance;"
				end
				if playerSpec == 1 and b("Blessing of Summer") == "Blessing of Summer" then overrideModCtrl = "[mod:shift,known:Blessing of Spring][mod:shift,known:Blessing of Winter][mod:shift,known:Blessing of Winter,@player][mod:shift,known:Blessing of Spring,"..groupRosterBuilder("tank").."]Blessing of Summer;"
				elseif playerSpec == 2 and b("Blessing of Spellwarding") == "Blessing of Spellwarding" then overrideModCtrl = "[mod:shift,"..groupRosterBuilder("healer").."][@mouseover,help,nodead]Blessing of Spellwarding;"
				elseif (playerSpec == 2 or playerSpec == 3) and b("Blessing of Protection") == "Blessing of Protection" then overrideModCtrl = "[mod:shift,"..groupRosterBuilder("healer").."][@mouseover,help,nodead]Blessing of Protection;"
				elseif playerSpec == 3 and b("Blessing of Protection") == "Blessing of Protection" then
					overrideModCtrl = "[mod:shift,"..groupRosterBuilder("healer").."][@mouseover,help,nodead]Blessing of Protection;"
				end
				if (playerSpec == 1 or playerSpec == 3) and b("Blessing of Sacrifice") == "Blessing of Sacrifice" then override = "["..groupRosterBuilder("tank").."][]Blessing of Sacrifice"
				elseif playerSpec == 2 and b("Blessing of Sacrifice") == "Blessing of Sacrifice" then override = "["..groupRosterBuilder("healer").."][]Blessing of Sacrifice"
				end
				EditMacro("WSxGenC",nil,nil,"/use "..overrideModAlt..overrideModCtrl..override)
			elseif class == "HUNTER" then
			elseif class == "ROGUE" then
			elseif class == "PRIEST" then
				overrideModAlt = ""
				if b("Void Shift") == "Void Shift" then overrideModAlt = "Void Shift"
				elseif b("Power Word: Life") == "Power Word: Life" then overrideModAlt = "Power Word: Life"
				end
				if b("Pain Suppression") == "Pain Suppression" then override = "["..groupRosterBuilder("tank").."]Pain Suppression;"
				elseif b("Guardian Spirit") == "Guardian Spirit" then override = "["..groupRosterBuilder("tank").."]Guardian Spirit;"
				elseif b("Silence") == "Silence" then override = "[@focus,harm,nodead]Silence;"
				end
				EditMacro("WSxGenF",nil,nil,"#show "..overrideModAlt.."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod,exists,nodead]Mind Vision;[mod]Farwater Conch;"..override.."[help,nodead]True Love Prism;Doomsayer's Robes")
			elseif class == "DEATHKNIGHT" then
			elseif class == "WARRIOR" then
				EditMacro("WSxGenC",nil,nil,"#show\n/use "..b("Intimidating Shout","[mod:ctrl]",";")..b("Intervene","[mod:shift,"..groupRosterBuilder("healer").."]",";")..b("Spell Reflection").."\n/use Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
			elseif class == "DRUID" then
				overrideModAlt = ""
			 	if b("Nature's Swiftness") == "Nature's Swiftness" then overrideModAlt = "Nature's Swiftness"
				elseif b("Ironbark") == "Ironbark" then overrideModAlt = "Ironbark"
				end
				override = ""
			 	if b("Ironbark") == "Ironbark" then override = "["..groupRosterBuilder("tank").."]Ironbark"
				elseif b("Nature's Swiftness") == "Nature's Swiftness" then override = "Nature's Swiftness"
				end
				EditMacro("WSxGenH",nil,nil,"#show "..overrideModAlt.."\n/use "..override.."\n/use Wisp Amulet\n/stopmacro [combat][mod:ctrl]\n/run if IsMounted() or GetShapeshiftFormID() ~= nil then DoEmote(\"mountspecial\") end")
			 	if b("Cyclone") == "Cyclone" then overrideModCtrl = "[@mouseover,harm,nodead,mod][mod]Cyclone;"
				elseif b("Entangling Roots") == "Entangling Roots" then overrideModCtrl = "[@mouseover,harm,nodead,mod][mod]Entangling Roots;"
				end
				if b("Rejuvenation") == "Rejuvenation" then override = "[@mouseover,help,nodead][noform:1]Rejuvenation"
				elseif b("Astral Communion") == "Astral Communion" then override = "[noform:4]Moonkin Form"
				elseif b("Frenzied Regeneration") == "Frenzied Regeneration" then override = "[noform:1]Bear Form;[form:1]Frenzied Regeneration"
				end
		 		EditMacro("WSxGenC",nil,nil,"/use "..b("Innervate","[mod:shift,"..groupRosterBuilder("healer").."][mod:shift,@player]",";")..overrideModCtrl..b("Frenzied Regeneration","[form:1]",";")..b("Astral Communion","[form:4]",";")..override.."\n/use Totem of Spirits\n/cancelform [mod:shift,form:2]")
			elseif class == "DEMONHUNTER" then
			elseif class == "EVOKER" then
				if b("Blistering Scales") == "Blistering Scales" then override = "[@mouseover,help,nodead]["..groupRosterBuilder("tank").."][]Blistering Scales"
				elseif b("Stasis") == "Stasis" then override = "Stasis"
				elseif b("Pyre") == "Pyre" then override = "[@mouseover,harm,nodead][]Pyre"
				else override = "Hover"
				end
				EditMacro("WSxSGen+3",nil,nil,"#show\n/use "..override.."\n/targetenemy [noexists]")
				if b("Reversion") == "Reversion" then override = "[@mouseover,help,nodead][]Reversion"
				else override = "[@mouseover,help,nodead][]Emerald Blossom"
				end
				EditMacro("WSxGenC",nil,nil,"#show\n/use "..b("Sleep Walk","[@mouseover,harm,nodead,mod:ctrl][mod:ctrl]",";")..b("Source of Magic","[mod:shift][mod:shift,"..groupRosterBuilder("healer").."]",";")..override.."\n/cancelaura X-Ray Specs")
			end
		end

		if (event == "PLAYER_SPECIALIZATION_CHANGED" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD") and not InCombatLockdown() then
			if (class == "WARLOCK" or class == "DEMONHUNTER") then
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use 14\n/use [nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Fractured Necrolyte Skull;[help,dead,nocombat]Cremating Torch;Eternal Black Diamond Ring")
			else
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use 14\n/use [nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;Eternal Black Diamond Ring")
			end
			
			if race == "VoidElf" then
				EditMacro("Wx6RacistAlt+V",nil,nil,"#show " ..racials.."\n/use Prismatic Bauble\n/use Sparklepony XL\n/castsequence reset=9 "..racials..",Languages")
			else
				EditMacro("Wx6RacistAlt+V",nil,nil,"#show " ..racials.."\n/use Prismatic Bauble\n/use Sparklepony XL\n/use "..racials)
			end

			-- Main Class configuration
			-- Shaman, Raxxy
			if class == "SHAMAN" then
				EditMacro("WSxGen1",nil,nil,"#show\n/use "..b("Ice Strike","[harm,nodead]",";")..b("Unleash Life","[@mouseover,help,nodead][help,nodead]",";")..b("Frost Shock","[@mouseover,harm,nodead][harm,nodead]",";").."Xan'tish's Flute\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+1",nil,nil,"#show [nospec:2]Healing Stream Totem;Frost Shock\n/use [mod:alt,@party3,help,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Healing Surge\n/use [nocombat]Haunted War Drum")
				if b("Lava Lash") == "Lava Lash" then override = "Lava Lash" 
				else override = "[@mouseover,harm,nodead][]Lightning Bolt"
				end
				EditMacro("WSxGen2",nil,nil,"#show\n/use [nocombat,noexists]Raging Elemental Stone;"..override.."\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use [mod:alt,@party4,help,nodead][@mouseover,help,nodead][]Healing Surge\n/cancelaura X-Ray Specs\n/use Gnomish X-Ray Specs")
				if b("Stormstrike") == "Stormstrike" then override = "Stormstrike" 
				elseif b("Lava Burst") == "Lava Burst" then override = "[@mouseover,harm,nodead][]Lava Burst" 
				else override = "Primal Strike" 
				end
				EditMacro("WSxGen3",nil,nil,"#show\n/stopspelltarget\n/startattack\n/targetenemy [noexists]\n/use [nocombat,noexists]Tadpole Cloudseeder;"..override.."\n/cleartarget [dead]\n/use Words of Akunda")
				EditMacro("WSxSGen+3",nil,nil,"#show Flame Shock\n/cleartarget [dead]\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead,nomod:alt][nomod:alt]Flame Shock\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Flame Shock\n/targetlasttarget")
				if b("Wellspring") == "Wellspring" then override = "Wellspring" 
				elseif b("Icefury") == "Icefury" then override = "Icefury" 
				elseif playerSpec ~= 3 and b("Lava Burst") == "Lava Burst" then override = "[@mouseover,harm,nodead][]Lava Burst" 
				elseif b("Chain Heal") == "Chain Heal" then override = "[@mouseover,help,nodead][]Chain Heal"
				elseif b("Sundering") == "Sundering" then override = "Sundering"
				end
				EditMacro("WSxGen4",nil,nil,"#show\n/use "..override.."\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,noexists,nospec:3]Smolderheart\n/startattack")
				if b("Riptide") == "Riptide" then overrideModAlt = "[@party1,help,nodead,mod:alt]Riptide;" 
				elseif b("Chain Heal") == "Chain Heal" then overrideModAlt = "[@party1,help,nodead,mod:alt]Chain Heal;" 
				else overrideModAlt = "[@party1,help,nodead,mod:alt]Healing Surge;"
				end
				if b("Sundering") == "Sundering" then override = "Sundering" 
				elseif playerSpec ~= 3 and b("Primordial Wave") == "Primordial Wave" then override = "[@mouseover,harm,nodead][]Primordial Wave"
				elseif b("Healing Tide Totem") == "Healing Tide Totem" then override = "Healing Tide Totem" 
				elseif b("Stormkeeper") == "Stormkeeper" then override = "Stormkeeper" 
				elseif b("Downpour") == "Downpour" then override = "Downpour" 
				elseif b("Storm Elemental") == "Storm Elemental" then override = "[pet:Storm Elemental]Tempest;Storm Elemental" 
				elseif b("Fire Elemental") == "Fire Elemental" then override = "[pet:Fire Elemental,@mouseover,harm,nodead][pet:Fire Elemental]Meteor;Fire Elemental" 
				end
				EditMacro("WSxSGen+4",nil,nil,"#show\n/targetenemy [noexists]\n/use "..overrideModAlt..override.."\n/use [nocombat,noexists]Sen'jin Spirit Drum\n/cleartarget [dead]")
				if b("Ascendance") == "Ascendance" then override = "Ascendance" 
				elseif b("Stormkeeper") == "Stormkeeper" then override = "Stormkeeper" 
				elseif b("Wellspring") == "Wellspring" then override = "Wellspring" 
				elseif b("Totemic Projection") == "Totemic Projection" then override = "[@cursor]Totemic Projection" 
				elseif b("Downpour") == "Downpour" then override = "[@cursor]Downpour"
				end
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use [@party3,help,nodead,mod:alt]Riptide;"..override.."\n/targetenemy [noexists]\n/use Trawler Totem")
				if b("Spirit Link Totem") == "Spirit Link Totem" then overrideModAlt = "[mod,@cursor]Spirit Link Totem" 
				elseif b("Earth Elemental") == "Earth Elemental" then overrideModAlt = "[mod,@pet,help,nodead][mod,help,nodead]Healing Surge;[mod]Earth Elemental\n/use [mod]Tiny Box of Tiny Rocks\n/targetlasttarget [mod,exists]"
				end
				if b("Earth Shock") == "Earth Shock" then override = "Earth Shock" elseif b("Healing Wave") == "Healing Wave" then override = "[@mouseover,help,nodead][]Healing Wave" else override = "Lightning Bolt" 
				end
				override = "\n/use "..override
				EditMacro("WSxGen5",nil,nil,"/targetenemy [noexists,nomod]\n/target [@Greater Earth,mod]\n/use "..overrideModAlt..override)
				if b("Riptide") == "Riptide" then overrideModAlt = "[@party2,help,nodead,mod:alt]Riptide;" 
				elseif b("Chain Heal") == "Chain Heal" then overrideModAlt = "[@party2,help,nodead,mod:alt]Chain Heal;" 
				else overrideModAlt = "[@party2,help,nodead,mod:alt]Healing Surge;"
				end
				if b("Storm Elemental") == "Storm Elemental" then override = "[pet:Storm Elemental]Tempest;Storm Elemental" 
				elseif b("Fire Elemental") == "Fire Elemental" then override = "[pet:Fire Elemental,@mouseover,harm,nodead][pet:Fire Elemental]Meteor;Fire Elemental" 
				elseif b("Doom Winds") == "Doom Winds" then override = "Doom Winds" 
				elseif b("Stormkeeper") == "Stormkeeper" then override = "Stormkeeper" 
				elseif b("Healing Stream Totem") == "Healing Stream Totem" then override = "Healing Stream Totem" 
				elseif b("Frost Shock") == "Frost Shock" then override = "Frost Shock"
				end
				EditMacro("WSxSGen+5",nil,nil,"#show ".."\n/cast [nocombat,noexists]Lava Fountain\n/stopspelltarget\n/cast "..overrideModAlt..override)
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod:ctrl,@party4,help,nodead]Riptide;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14\n/use Eternal Black Diamond Ring")
				if b("Feral Spirit") == "Feral Spirit" then overrideModAlt = "\n/use [mod:ctrl]Feral Spirit;" 
				elseif b("Fire Elemental") == "Fire Elemental" then overrideModAlt = "\n/use [mod:ctrl]Fire Elemental;" 
				elseif b("Storm Elemental") == "Storm Elemental" then overrideModAlt = "\n/use [mod:ctrl]Storm Elemental;" 
				elseif b("Earth Elemental") == "Earth Elemental" then overrideModAlt = "\n/target [@Greater Earth Ele,mod:ctrl]\n/use [help,mod:ctrl,nodead]Healing Surge;[mod:ctrl]Earth Elemental\n/use [mod:ctrl]Tiny Box of Tiny Rocks\n/targetlasttarget [mod:ctrl]\n/use "
				end
				if b("Healing Rain") == "Healing Rain" then override = "[@cursor]Healing Rain" elseif b("Crash Lightning") == "Crash Lightning" then override = "Crash Lightning" elseif playerSpec ~= 3 then override = "[@mouseover,harm,nodead][]Chain Lightning" else override = "[@mouseover,help,nodead]Chain Heal;[@mouseover,harm,nodead][harm,nodead]Chain Lightning;Chain Heal"
				end
				EditMacro("WSxGen6",nil,nil,"/targetenemy [noexists,nomod]"..overrideModAlt..override)
				if b("Earthen Wall Totem") == "Earthen Wall Totem" then override = "Earthen Wall Totem" elseif b("Ancestral Protection Totem") == "Ancestral Protection Totem" then override = "Ancestral Protection Totem" elseif b("Feral Lunge") == "Feral Lunge" then override = "Feral Lunge"
				end
				EditMacro("WSxSGen+6",nil,nil,"#show "..override.."\n/use [@mouseover,help,nodead]Chain Heal;[@mouseover,harm,nodead][harm,nodead]Chain Lightning;Chain Heal\n/use [nocombat,noexists]Goren \"Log\" Roller\n/use Orb of Deception\n/leavevehicle\n/targetenemy [noexists]")
				if b("Healing Rain") == "Healing Rain" then overrideModAlt = "[mod:shift,@player]Healing Rain;" 
				elseif b("Earthquake") == "Earthquake" then overrideModAlt = "[mod:shift,@player][@cursor]Earthquake;" 
				elseif b("Windfury Totem") == "Windfury Totem" then overrideModAlt = "[mod:shift]Windfury Totem;"
				end
				EditMacro("WSxGen7",nil,nil,"/use "..overrideModAlt.."[@mouseover,harm,nodead][]Chain Lightning\n/startattack")
				if b("Liquid Magma Totem") == "Liquid Magma Totem" then overrideModAlt = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Liquid Magma Totem;" 
				elseif b("Downpour") == "Downpour" then overrideModAlt = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Downpour;" 
				elseif b("Healing Rain") == "Healing Rain" then overrideModAlt = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Healing Rain;"
				end
				if b("Fire Nova") == "Fire Nova" then override = "Fire Nova" 
				elseif b("Primordial Wave") == "Primordial Wave" then override = "[@focus,harm,nodead][]Primordial Wave"
				else override = "Frost Shock" 
				end
				EditMacro("WSxGen8",nil,nil,"#show\n/stopspelltarget\n/use "..overrideModAlt..override)
				if b("Primordial Wave") == "Primordial Wave" then override = "Primordial Wave" 
				elseif b("Healing Stream Totem") == "Healing Stream Totem" then override = "Healing Stream Totem" 
				elseif b("Windfury Totem") == "Windfury Totem" then override = "Windfury Totem" 
				elseif b("Ice Strike") == "Ice Strike" then override = "Ice Strike" 
				elseif b("Fire Nova") == "Fire Nova" then override = "Fire Nova" 
				elseif b("Earthliving Weapon") == "Earthliving Weapon" then override = "Earthliving Weapon" 
				elseif b("Spirit Link Totem") == "Spirit Link Totem" then override = "Spirit Link Totem" 
				elseif b("Tremor Totem") == "Tremor Totem" then override = "Tremor Totem" 
				elseif b("Downpour") == "Downpour" then override = "[@cursor]Downpour" 
				elseif b("Water Walking") == "Water Walking" then override = "Water Walking"
				end
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..override)
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,spec:3,@party3,help,nodead][spec:3,@party1,help,nodead][spec:3,@targettarget,help,nodead]Purify Spirit;[mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Cleanse Spirit;[nocombat,noharm]Spirit Wand")
				EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Flame Shock;[mod:alt,spec:3,@party4,help,nodead][spec:3,@party2,help,nodead]Purify Spirit;[mod:alt,@party4,help,nodead][@party2,help,nodead]Cleanse Spirit;[nocombat,noharm]Cranky Crab;\n/cleartarget [dead]\n/stopspelltarget")
				EditMacro("WSxCSGen+4",nil,nil,"/use [mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Chain Heal")
				EditMacro("WSxCSGen+5",nil,nil,"/use [mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead][@targettarget,help,nodead]Chain Heal\n/use [spec:3]Waterspeaker's Totem")
				EditMacro("WSxGenQ",nil,nil,"/stopcasting [nomod:alt]\n/use "..b("Hex","[mod:alt,@focus,harm,nodead]",";")..b("Tremor Totem","[mod:shift]",";").."[help,nodead]Foot Ball;[nocombat,noexists]The Golden Banana;"..b("Wind Shear","[@mouseover,harm,nodead][]","").."\n/use [nocombat,spec:3]Bubble Wand\n/cancelaura Bubble Wand")
				EditMacro("WSkillbomb",nil,nil,"/use "..b("Fire Elemental")..b("Storm Elemental")..b("Feral Spirit")..b("Earth Elemental","\n/use ","\n/use Tiny Box of Tiny Rocks").."\n/use Rukhmar's Sacred Memory"..b("Ascendance","\n/use ","")..""..dpsRacials.."\n/use [@player]13\n/use 13\n/use Flippable Table\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")	
				EditMacro("WSxGenE",nil,nil,"#show [nocombat,noexists]Party Totem;Capacitor Totem\n/use "..b("Capacitor Totem","[@cursor]","").."\n/use Haunting Memento\n/use [nocombat,noexists]Party Totem")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..b("Capacitor Totem","[mod:alt,@player]",";")..b("Nature's Swiftness")..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use [mod:alt,@player]Earthbind Totem;"..b("Healing Stream Totem").."\n/use Arena Master's War Horn\n/use Totem of Spirits\n/use [nocombat]Void-Touched Souvenir Totem")
				EditMacro("WSxGenR",nil,nil,"#show Earthbind Totem\n/stopspelltarget\n/use "..b("Totemic Projection","[mod:ctrl,@cursor]",";").."[@mouseover,exists,nodead,mod:shift][@cursor,mod:shift]Earthbind Totem;"..b("Frost Shock","[@mouseover,harm,nodead][]",";").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				
				if b("Thunderstorm") == "Thunderstorm" then override = "[@mouseover,exists,nodead][]Thunderstorm" 
				elseif b("Frost Shock") == "Frost Shock" then override = "[@mouseover,harm,nodead][]Frost Shock"
				end
				EditMacro("WSxGenT",nil,nil,"/use "..override.."\n/use [help,nodead]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
				-- print("override = ", override)
				-- Såhär långt har vi kommit.
				if b("Lightning Lasso") == "Lightning Lasso" then override = "[@mouseover,harm,nodead][]Lightning Lasso" 
				elseif b("Totemic Projection") == "Totemic Projection" then override = "[mod:alt,@player][@mouseover,exists,nodead][@cursor]Totemic Projection"
				elseif b("Thunderstorm") == "Thunderstorm" then override = "[@mouseover,exists,nodead][]Thunderstorm"
				elseif b("Earthquake") == "Earthquake" then override = "[@cursor]Earthquake"
				elseif b("Purge") == "Purge" then override = "[@mouseover,harm,nodead][]Purge"
				elseif b("Greater Purge") == "Greater Purge" then override = "[@mouseover,harm,nodead][]Greater Purge"
				elseif b("Frost Shock") == "Frost Shock" then override = "[@mouseover,harm,nodead][]Frost Shock"
				elseif b("Wind Rush Totem") == "Wind Rush Totem" then override = "[mod:alt,@player][@mouseover,exists,nodead][@cursor]Wind Rush Totem"
				end
				EditMacro("WSxSGen+T",nil,nil,"#show\n/stopspelltarget\n/use "..override)
				if b("Wind Rush Totem") == "Wind Rush Totem" then override = "[@mouseover,exists,nodead][@cursor]Wind Rush Totem"
				elseif b("Earthgrab Totem") == "Earthgrab Totem" then override = "[@mouseover,exists,nodead][@cursor]Earthgrab Totem" 
			    end
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/stopspelltarget\n/use "..override)
				EditMacro("WSxGenU",nil,nil,"#show\n/use Reincarnation")
				EditMacro("WSxGenF",nil,nil,"#show "..b("Totemic Projection").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@cursor]Far Sight;"..b("Wind Shear","[@focus,harm,nodead]",";").."Mrgrglhjorn")
				if b("Stoneskin Totem") == "Stoneskin Totem" then override = "[@cursor]Stoneskin Totem"
				elseif b("Tranquil Air Totem") == "Tranquil Air Totem" then override = "[@cursor]Tranquil Air Totem"
				elseif b("Gust of Wind") == "Gust of Wind" then override = "Gust of Wind"
				elseif b("Spirit Walk") == "Spirit Walk" then override = "Spirit Walk"
				end
				EditMacro("WSxSGen+F",nil,nil,"#show\n/use [help,nocombat,mod:alt]B.B.F. Fist;[nocombat,noexists,mod:alt]Gastropod Shell;[nocombat,noexists]Totem of Harmony;"..override.."\n/cancelform [mod:alt]")
				if b("Ancestral Guidance") == "Ancestral Guidance" then override = "Ancestral Guidance"
				elseif b("Totemic Projection") == "Totemic Projection" then override = "Totemic Projection"
				end
				EditMacro("WSxCGen+F",nil,nil,"#show "..override.."\n/use "..b("Ancestral Guidance").."\n/use "..fftpar.."\n/cancelaura Thistleleaf Disguise\n/use Bom'bay's Color-Seein' Sauce")
				if b("Tremor Totem") == "Tremor Totem" then override = "Tremor Totem"
				else override = "Water Walking"
				end
				EditMacro("WSxCAGen+F",nil,nil,"#show "..override.."\n/run if not InCombatLockdown() then if GetSpellCooldown(198103)==0 then "..tpPants.." else "..noPants.." end end\n/use Gateway Control Shard")
				if b("Purge") == "Purge" then overrideModAlt = "[@mouseover,harm,nodead]Purge;"
				elseif b("Greater Purge") == "Greater Purge" then overrideModAlt = "[@mouseover,harm,nodead]Greater Purge;"
				end	
				if b("Cleanse Spirit") == "Cleanse Spirit" then override = "[@mouseover,help,nodead][]Cleanse Spirit"
				elseif playerSpec == 3 then override = "[spec:3,@mouseover,help,nodead][spec:3]Purify Spirit"
				elseif b("Frost Shock") == "Frost Shock" then override = "[@mouseover,harm,nodead][]Frost Shock"
				else override = "Darkmoon Gazer"
				end	
				EditMacro("WSxGenG",nil,nil,"/use [mod:alt]Darkmoon Gazer;"..overrideModAlt..override.."\n/targetenemy [noexists]\n/use Poison Extraction Totem")
				if b("Purge") == "Purge" then override = "[@mouseover,harm,nodead][harm,nodead]Purge"
				elseif b("Greater Purge") == "Greater Purge" then override = "[@mouseover,harm,nodead][harm,nodead]Greater Purge"
				elseif b("Healing Stream Totem") == "Healing Stream Totem" then override = "Healing Stream Totem"
				end	
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..override.."\n/use Flaming Hoop\n/targetenemy [noexists]\n/cleartarget [dead]")
				if b("Earthen Wall Totem") == "Earthen Wall Totem" then override = "[@cursor]Earthen Wall Totem"
				elseif b("Ancestral Protection Totem") == "Ancestral Protection Totem" then override = "[@cursor]Ancestral Protection Totem"
				elseif b("Stoneskin Totem") == "Stoneskin Totem" then override = "[@cursor]Stoneskin Totem"
				elseif b("Tranquil Air Totem") == "Tranquil Air Totem" then override = "[@cursor]Tranquil Air Totem"
				end	
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..override)
			    if b("Purge") == "Purge" then overrideModAlt = "[@focus,harm,nodead]Purge;"
				elseif b("Greater Purge") == "Greater Purge" then overrideModAlt = "[@focus,harm,nodead]Greater Purge"
				end
				if b("Poison Cleansing Totem") == "Poison Cleansing Totem" then override = "Poison Cleansing Totem"
				elseif b("Tremor Totem") == "Tremor Totem" then override = "Tremor Totem"
				elseif b("Capacitor Totem") == "Capacitor Totem" then override = "Capacitor Totem"
				end	
				EditMacro("WSxCSGen+G",nil,nil,"/use "..overrideModAlt.."[spec:3,@mouseover,help,nodead][spec:3]Purify Spirit;"..b("Cleanse Spirit","[@focus,help,nodead]",";")..override.."\n/cancelaura Whole-Body Shrinka'\n/cancelaura Growing Pains\n/cancelaura Words of Akunda")
				if b("Totemic Recall") == "Totemic Recall" then override = "Totemic Recall"
				elseif b("Stoneskin Totem") == "Stoneskin Totem" then override = "[@cursor]Stoneskin Totem"
				elseif b("Tranquil Air Totem") == "Tranquil Air Totem" then override = "[@cursor]Tranquil Air Totem"
				elseif b("Hex") == "Hex" then override = "Hex"
				end
				EditMacro("WSxGenH",nil,nil,"#show\n/use "..override.."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				if b("Spirit Link Totem") == "Spirit Link Totem" then override = "[mod:shift,@player]Spirit Link Totem;"
				elseif b("Earthen Wall Totem") == "Earthen Wall Totem" then override = "[mod:shift,@player]Earthen Wall Totem;"
				elseif b("Ancestral Protection Totem") == "Ancestral Protection Totem" then override = "[mod:shift,@player]Ancestral Protection Totem;"
				elseif b("Stoneskin Totem") == "Stoneskin Totem" then override = "[mod:shift,@player]Stoneskin Totem;"
				elseif b("Tranquil Air Totem") == "Tranquil Air Totem" then override = "[mod:shift,@player]Tranquil Air Totem;"
				end	
				EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Flametongue Weapon;"..override..b("Astral Shift","[nomod]","").."\n/use Whole-Body Shrinka'\n/use [mod:alt]Gateway Control Shard\n/use Moonfang's Paw")
				override = ""
				overrideModAlt = ""
				if b("Mana Tide Totem") == "Mana Tide Totem" then overrideModAlt = "[mod]Mana Tide Totem;"
				elseif b("Totemic Recall") == "Totemic Recall" then overrideModAlt = "[mod]Totemic Recall;"
				end
				if b("Riptide") == "Riptide" then override = "[@mouseover,help,nodead][]Riptide"
				elseif b("Hex") == "Hex" then override = "Hex"
				elseif b("Thunderstorm") == "Thunderstorm" then override = "[@mouseover,exists,nodead][]Thunderstorm"
				end
				EditMacro("WSxGenC",nil,nil,"/use [help,nodead,nocombat]Chasing Storm".."\n/use "..b("Hex","[@mouseover,exists,nodead,mod:ctrl][mod:ctrl]",";")..overrideModAlt..override.."\n/use Thistleleaf Branch")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use [nocombat,noexists]Vol'Jin's Serpent Totem\n/use "..b("Totemic Recall","").."\n/click TotemFrameTotem1 RightButton\n/cry\n/cancelaura Chasing Storm")
				if b("Feral Lunge") == "Feral Lunge" then override = "[@mouseover,harm,nodead][]Feral Lunge"
				elseif b("Gust of Wind") == "Gust of Wind" then override = "Gust of Wind"
				elseif b("Spiritwalker's Grace") == "Spiritwalker's Grace" then override = "Spiritwalker's Grace"
				elseif b("Spirit Walk") == "Spirit Walk" then override = "Spirit Walk"
				elseif b("Ghost Wolf") == "Ghost Wolf" then override = "[noform]Ghost Wolf"
				end
				EditMacro("WSxGenV",nil,nil,"#show "..b("Spiritwalker's Grace").."\n/use "..override.."\n/use Panflute of Pandaria\n/use Croak Crock\n/cancelaura Rhan'ka's Escape Plan\n/use Desert Flute\n/use Sparklepony XL")
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@mouseover,help,nodead][nomod:alt]Water Walking\n/use [swimming,nomod:alt]Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")   

			-- Mage, maggi, nooniverse
			elseif class == "MAGE" then
				if b("Ray of Frost") == "Ray of Frost" then override = "Ray of Frost"
				elseif b("Radiant Spark") == "Radiant Spark" then override = "[@mouseover,harm,nodead][]Radiant Spark"
				elseif b("Ice Lance") == "Ice Lance" then override = "[@mouseover,harm,nodead][]Ice Lance"
				elseif b("Phoenix Flames") == "Phoenix Flames" then override = "[@mouseover,harm,nodead][]Phoenix Flames"
				elseif b("Frostbolt") == "Frostbolt" then override = "Frostbolt"
				end
				EditMacro("WSxGen1",nil,nil,"/targetenemy [noharm,nodead]\n/use [nocombat,noexists]Dazzling Rod\n/use "..override)
				if b("Arcane Blast") == "Arcane Blast" then override = "[harm,nodead]Arcane Blast;"
				elseif b("Scorch") == "Scorch" then override = "[@mouseover,harm,nodead][harm,nodead]Scorch;"
				elseif b("Frostbolt") == "Frostbolt" then override = "[harm,nodead]Frostbolt;"
				end
				EditMacro("WSxGen2",nil,nil,"/use "..override.."Akazamzarak's Spare Hat\n/targetenemy [noharm]\n/cleartarget [dead]\n/use Kalec's Image Crystal\n/use Archmage Vargoth's Spare Staff")
				if b("Pyroblast") == "Pyroblast" then override = "[@mouseover,harm,nodead][harm,nodead]Pyroblast"
				elseif b("Arcane Surge") == "Arcane Surge" then override = "Arcane Surge"
				elseif b("Glacial Spike") == "Glacial Spike" then override = "Glacial Spike"
				end
				EditMacro("WSxGen3",nil,nil,"/use "..override.."\n/use [spec:2]Smolderheart\n/use Dalaran Initiates' Pin\n/targetenemy [noexists]")
				if b("Nether Tempest") == "Nether Tempest" then override = "[nomod:alt]Nether Tempest"
				elseif b("Arcane Blast") == "Arcane Blast" then override = "[nomod:alt]Arcane Blast"
				elseif b("Living Bomb") == "Living Bomb" then override = "[nomod:alt]Living Bomb\n/use [nocombat]Brazier of Dancing Flames"
				elseif b("Icy Veins") == "Icy Veins" then override = "[pet:Water Elemental,@mouseover,harm,nodead][pet:Water Elemental]Water Jet;[nomod:alt]Frostbolt;Icy Veins"
				elseif b("Pyroblast") == "Pyroblast" then override = "[nomod:alt]Pyroblast\n/use [nocombat]Brazier of Dancing Flames\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [mod:alt]Pyroblast\n/targetlasttarget"
				end
				EditMacro("WSxSGen+3",nil,nil,"/targetenemy [noexists]\n/use [nocombat,noexists]Archmage Vargoth's Spare Staff;"..override)
				if b("Fireball") == "Fireball" then override = "[@mouseover,harm,nodead][harm,nodead]Fireball;"
				elseif b("Flurry") == "Flurry" then override = "[harm,nodead]Flurry;"
				elseif b("Arcane Missiles") == "Arcane Missiles" then override = "[harm,nodead]Arcane Missiles;"
				end
				EditMacro("WSxGen4",nil,nil,"/use "..override.."Memory Cube\n/targetenemy [noexists]\n/cleartarget [dead]\n/stopspelltarget")
				if b("Touch of the Magi") == "Touch of the Magi" then override = "[nomod:alt]Arcane Barrage\n/use [nomod:alt]Touch of the Magi"
				elseif b("Comet Storm") == "Comet Storm" then override = "[nomod:alt]Comet Storm"
				elseif b("Ebonbolt") == "Ebonbolt" then override = "[nomod:alt]Ebonbolt"
				elseif b("Meteor") == "Meteor" then override = "[@mouseover,exists,nodead,nomod:alt,spec:2][@cursor,nomod:alt,spec:2]Meteor"
				elseif b("Dragon's Breath") == "Dragon's Breath" then override = "[nomod:alt]Dragon's Breath"
				elseif b("Frostbolt") == "Frostbolt" then override = "[nomod:alt]Frostbolt"
				elseif b("Fireball") == "Fireball" then override = "\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [mod:alt]Fireball\n/targetlasttarget"
				end
				EditMacro("WSxSGen+4",nil,nil,"#showtooltip "..b("Touch of the Magi").."\n/stopspelltarget\n/use "..override)
				if b("Mass Invisibility") == "Mass Invisibility" then override = "Mass Invisibility"
				elseif b("Mass Barrier") == "Mass Barrier" then override = "Mass Barrier"
				end
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..override.."\n/use [nocombat,noexists]Faded Wizard Hat")
				if b("Icy Veins") == "Icy Veins" then override = "[mod:alt,pet:Water Elemental,@player][@mouseover,exists,nodead,pet:Water Elemental][pet:Water Elemental,@cursor]Freeze;[@mouseover,harm,nodead][]Fire Blast;Icy Veins"
				elseif b("Evocation") == "Evocation" then override = "Evocation"
				elseif b("Pyroblast") == "Pyroblast" then override = "[@mouseover,harm,nodead][]Fire Blast;Pyroblast"
				end
				EditMacro("WSxSGen+5",nil,nil,"/stopspelltarget\n/targetenemy [noexists]\n/cleartarget [dead]\n/use "..override)
				if b("Icy Veins") == "Icy Veins" then overrideModAlt = "[mod:ctrl]Icy Veins"
				elseif b("Arcane Surge") == "Arcane Surge" then overrideModAlt = "[mod:ctrl]Arcane Surge"
				elseif b("Combustion") == "Combustion" then overrideModAlt = "[mod:ctrl]Combustion"
				end
				if b("Frozen Orb") == "Frozen Orb" then override = "[@cursor]Frozen Orb"
				elseif b("Arcane Orb") == "Arcane Orb" then override = "Arcane Orb"
				elseif b("Supernova") == "Supernova" then override = "[@mouseover,exists,nodead][]Supernova"
				elseif b("Dragon's Breath") == "Dragon's Breath" then override = "Dragon's Breath"
				elseif b("Arcane Explosion") == "Arcane Explosion" then override = "Arcane Explosion"
				end
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..overrideModAlt.."\n/use "..b("Mirror Image","[mod:ctrl]",";")..override)
				if b("Meteor") == "Meteor" then override = "[@player,spec:2]Meteor"
				elseif b("Dragon's Breath") == "Dragon's Breath" then override = "[@mouseover,exists,nodead][]Dragon's Breath"
				end
				EditMacro("WSxSGen+6",nil,nil,"#show\n/use [nocombat,noexists]Mystical Frosh Hat\n/use "..override)
				if b("Blizzard") == "Blizzard" then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Blizzard"
				elseif b("Flamestrike") == "Flamestrike" then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Flamestrike"
				elseif b("Supernova") == "Supernova" then override = "[@mouseover,exists,nodead][]Supernova"
				elseif b("Arcane Orb") == "Arcane Orb" then override = "Arcane Orb"
				elseif b("Ice Nova") == "Ice Nova" then override = "Ice Nova"
				elseif b("Arcane Explosion") == "Arcane Explosion" then override = "Arcane Explosion"
				elseif b("Touch of the Magi") == "Touch of the Magi" then override = "Touch of the Magi"
				end
				EditMacro("WSxGen7",nil,nil,"#show\n/stopspelltarget\n/use "..override)
				if b("Arcane Explosion") == "Arcane Explosion" then override = "Arcane Explosion"
				end
				EditMacro("WSxGen8",nil,nil,"#show\n/stopspelltarget\n/use "..override)
				if b("Shifting Power") == "Shifting Power" then override = "Shifting Power" 
				elseif b("Dragon's Breath") == "Dragon's Breath" then override = "Dragon's Breath"
				elseif b("Meteor") == "Meteor" then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Meteor"
				elseif b("Arcane Familiar") == "Arcane Familiar" then override = "[nocombat,noexists]Arcane Familiar"
				elseif b("Arcane Explosion") == "Arcane Explosion" then override = "[spec:2]Arcane Explosion"
				end
				overrideModAlt = ""
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..override)
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Remove Curse")
				EditMacro("WSxCSGen+3",nil,nil,"#show\n/use "..b("Pyroblast","[@focus,harm,nodead]",";").."[mod:alt,@party4,help,nodead][@party2,help,nodead]Remove Curse;[exists,nodead]Magical Saucer\n/targetenemy [noharm]\n/cleartarget [dead][nocombat,noharm]\n/stopspelltarget")
				EditMacro("WSxCSGen+4",nil,nil,"/use [spec:2,@focus,harm,nodead]Fireball;[mod:alt,@party3,help,nodead][@party1,help,nodead]Slow Fall;Pink Gumball\n/targetenemy [noharm]\n/cleartarget [dead][nocombat,noharm]\n/stopspelltarget\n/use [nocombat,noexists]Ogre Pinata")
				EditMacro("WSxCSGen+5",nil,nil,"#show Ice Block\n/use [mod:alt,@party4,help,nodead][@party2,help,nodead]Slow Fall\n/use [nocombat,noexists]Shado-Pan Geyser Gun\n/cancelaura [combat]Shado-Pan Geyser Gun\n/stopmacro [combat]\n/click ExtraActionButton1")
				EditMacro("WSxGenQ",nil,nil,"#show\n/stopcasting [nomod]\n/use [mod:alt,@focus,harm,nodead]Polymorph;[mod:shift]Winning Hand;[@mouseover,harm,nodead][harm,nodead]Counterspell;Nightborne Guard's Vigilance\n/use [mod:shift]Ice Block;")
				EditMacro("WSkillbomb",nil,nil,"#show\n/use "..b("Combustion","[]",";")..b("Icy Veins","[]",";")..b("Mirror Image").."\n/use "..b("Arcane Surge")..""..dpsRacials.."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13\n/use Hearthstone Board\n/use Gleaming Arcanocrystal\n/use Big Red Raygun"..hasHE)
				if b("Mass Polymorph") == "Mass Polymorph" then override = "[mod:alt]Mass Polymorph;"
				elseif b("Blast Wave") == "Blast Wave" then override = "[mod:alt]Blast Wave;"
				else override = ""
				end
				EditMacro("WSxGenE",nil,nil,"#show\n/use "..override..b("Frost Nova").."\n/use Manastorm's Duplicator")
				if b("Ice Floes") == "Ice Floes" then override = "Ice Floes"
				elseif b("Ice Nova") == "Ice Nova" then override = "Ice Nova"
				end
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..override.."\n/use [spec:2]Blazing Wings"..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use [mod:alt,@player,pet]Freeze;"..b("Ice Nova"))
				if b("Slow") == "Slow" then override = "Slow"
				elseif b("Frostbolt") == "Frostbolt" then override = "Frostbolt"
				end
				EditMacro("WSxGenR",nil,nil,"#show "..b("Cone of Cold").."\n/use "..b("Cone of Cold","[mod:shift]",";")..override.."\n/targetenemy [noexists]")
				if b("Fire Blast") == "Fire Blast" then override = "[@mouseover,harm,nodead][harm,nodead]Fire Blast;"
				end
				EditMacro("WSxGenT",nil,nil,"/use "..override.."[help,nocombat]Swapblaster\n/targetenemy [noexists]\n/use Titanium Seal of Dalaran\n/cleartarget [dead]\n/petattack [@mouseover,harm,nodead][]")
				if b("Blast Wave") == "Blast Wave" then override = "Blast Wave" else override = "Frostbolt" 
				end
				EditMacro("WSxSGen+T",nil,nil,"#show\n/use "..override)
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/stopspelltarget\n/use "..b("Ring of Frost","[mod:alt,@player][@mouseover,exists,nodead][@cursor]",""))
				EditMacro("WSxGenF",nil,nil,"#show "..b("Mirror Image").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/stopcasting [nomod]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Counterspell;Mrgrglhjorn")
				EditMacro("WSxCGen+F",nil,nil,"#show "..b("Invisibility","[combat]","")..";"..b("Ice Block")..b("Alter Time","\n/use ",""))
				if b("Ring of Frost") == "Ring of Frost" then override = "Ring of Frost"
				elseif b("Mirror Image") == "Mirror Image" then override = "Mirror Image"
				end
				EditMacro("WSxCAGen+F",nil,nil,"#show "..override.."\n/use !Blink\n/use Alter Time\n/cancelaura Alter Time")
				EditMacro("WSxGenG",nil,nil,"#show\n/targetenemy [noharm]\n/use [mod:alt]Darkmoon Gazer"..b("Spellsteal",";[@mouseover,harm,nodead]",";")..b("Remove Curse","[@mouseover,help,nodead][]","").."\n/use [noexists,nocombat]Set of Matches")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..b("Spellsteal","[@mouseover,harm,nodead][]","").."\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]\n/use Poison Extraction Totem")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..b("Arcane Familiar"))
			    if b("Cold Snap") == "Cold Snap" then override = "Cold Snap"
				elseif b("Greater Invisibility") == "Greater Invisibility" then override = "Greater Invisibility"
				end
				EditMacro("WSxCSGen+G",nil,nil,"#show "..override.."\n/use "..b("Spellsteal","[@focus,harm,nodead]","").."\n/use Poison Extraction Totem")
				EditMacro("WSxGenH",nil,nil,"#show "..b("Ice Nova").."\n/targetenemy [noharm]\n/use Nat's Fishing Chair\n/use Home Made Party Mask\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") else C_MountJournal.SummonByID(1727) end end")
				overrideModAlt = ""
				if b("Arcane Familiar") == "Arcane Familiar" then overrideModAlt = "[mod:alt]Arcane Familiar;" 
				end
				EditMacro("WSxGenZ",nil,nil,"#show\n/use "..overrideModAlt..b("Invisibility","[nocombat]",";")..b("Ice Block","!","").."\n/use [mod:alt]Gateway Control Shard")
				if b("Displacement") == "Displacement" then overrideModAlt = "[mod:shift]Displacement;"
				elseif b("Alter Time") == "Alter Time" then overrideModAlt = "[mod:shift]Alter Time;"
				end
				if b("Prismatic Barrier") == "Prismatic Barrier" then override = "Prismatic Barrier"
				elseif b("Blazing Barrier") == "Blazing Barrier" then override = "Blazing Barrier"
				elseif b("Ice Barrier") == "Ice Barrier" then override = "Ice Barrier"
				end
				EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt]Conjure Refreshment;[mod:ctrl]Teleport: Hall of the Guardian;"..overrideModAlt..override.."\n/use [nomod,spec:1]Arcano-Shower;[nomod,spec:2]Blazing Wings")
				override = ""
				if b("Cold Snap") == "Cold Snap" then override = "[mod:shift]Cold Snap;"
				elseif b("Conjure Mana Gem") == "Conjure Mana Gem" then override = "[mod:shift]Mana Gem;"
				end
				overrideModAlt = ""
				if b("Conjure Mana Gem") == "Conjure Mana Gem" then overrideModAlt = "[mod:shift]Conjure Mana Gem" 
				end
				EditMacro("WSxGenC",nil,nil,"/use "..override..b("Mirror Image","[nomod]",";").."[@mouseover,harm,nodead,mod][mod][]Polymorph\n/use "..overrideModAlt.."\n/cancelaura X-Ray Specs\n/ping [mod:ctrl,@mouseover,harm,nodead][mod:ctrl,harm,nodead]onmyway")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use Worn Doll\n/run PetDismiss();\n/cry")
				EditMacro("WSxGenV",nil,nil,"#show\n/use Blink\n/dismount [mounted]\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Illusion\n/use Prismatic Bauble\n/use Choofa's Call")
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@mouseover,help,nodead][noswimming]Slow Fall;Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")
			-- Warlock, vårlök
			elseif class == "WARLOCK" then
				if b("Soul Fire") == "Soul Fire" then override = "Soul Fire"
				elseif b("Havoc") == "Havoc" then override = "[@mouseover,harm,nodead][]Havoc"
				elseif b("Soul Strike") == "Soul Strike" then override = "[@mouseover,harm,nodead][]Soul Strike"
				elseif b("Summon Vilefiend") == "Summon Vilefiend" then override = "Summon Vilefiend"
				elseif b("Soul Swap") == "Soul Swap" then override = "[@mouseover,harm,nodead][]Soul Swap"
				elseif b("Drain Life") == "Drain Life" then override = "Drain Life"
				elseif b("Corruption") == "Corruption" then override = "[@mouseover,harm,nodead][]Corruption"
				end
				EditMacro("WSxGen1",nil,nil,"/use "..b("Soulstone","[@mouseover,help,dead][help,dead]",";")..override.."\n/use Copy of Daglop's Contract\n/targetenemy [noexists]\n/use Imp in a Ball\n/cancelaura Ring of Broken Promises")
				EditMacro("WSxSGen+1",nil,nil,"/run local c=C_Container for i=0,4 do for x=1,c.GetContainerNumSlots(i) do y=c.GetContainerItemLink(i,x) if y and GetItemInfo(y)==\"Healthstone\" then c.PickupContainerItem(i,x) DropItemOnUnit(\"target\") return end end end\n/click TradeFrameTradeButton")
				if b("Incinerate") == "Incinerate" then override = "Incinerate"
				elseif b("Agony") == "Agony" then override = "[@mouseover,harm,nodead,nomod:alt][nomod:alt]Agony"
				elseif b("Shadow Bolt") == "Shadow Bolt" then override = "Shadow Bolt"
				end
				EditMacro("WSxGen2",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use [harm,dead,nocombat]Soul Inhaler;"..override.."\n/use Accursed Tome of the Sargerei\n/startattack\n/clearfocus [dead]\n/use Haunting Memento\n/use Verdant Throwing Sphere\n/use Totem of Spirits")
				EditMacro("WSxSGen+2",nil,nil,"/use [nomod:alt,harm,nodead]Drain Life;[nomod:alt]Healthstone\n/use [noexists,nomod:alt]Create Healthstone\n/use [nocombat,noexists]Gnomish X-Ray Specs\n/cleartarget [dead]"..b("Unstable Affliction","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use ","\n/targetlasttarget"))
				if b("Shadowburn") == "Shadowburn" then override = "[@mouseover,harm,nodead][]Shadowburn"
				elseif b("Call Dreadstalkers") == "Call Dreadstalkers" then override = "[@mouseover,harm,nodead][]Call Dreadstalkers"
				elseif b("Malefic Rapture") == "Malefic Rapture" then override = "Malefic Rapture"
				elseif b("Immolate") == "Immolate" then override = "[@mouseover,harm,nodead][]Immolate"
				elseif b("Shadow Bolt") == "Shadow Bolt" then override = "[@mouseover,harm,nodead][]Shadow Bolt"
				end
				EditMacro("WSxGen3",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use [nocombat,noexists]Pocket Fel Spreader;[harm,dead]Narassin's Soul Gem;"..override.."\n/targetenemy [noexists]")
				if b("Doom") == "Doom" then overrideModAlt = "[@mouseover,harm,nodead,nomod:alt][nomod:alt]Doom"
				elseif b("Immolate") == "Immolate" then overrideModAlt = "[@mouseover,harm,nodead,nomod:alt][nomod:alt]Immolate"
				elseif b("Corruption") == "Corruption" then overrideModAlt = "[@mouseover,harm,nodead,nomod:alt][nomod:alt]Corruption"
				end
				if b("Doom") == "Doom" then override = "Doom"
				elseif b("Immolate") == "Immolate" then override = "Immolate"
				elseif b("Corruption") == "Corruption" then override = "Corruption"
				end
				EditMacro("WSxSGen+3",nil,nil,"/targetenemy [noexists]\n/use "..overrideModAlt.."\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use "..override.."\n/targetlasttarget")
				if b("Hand of Gul'dan") == "Hand of Gul'dan" then override = "Hand of Gul'dan"
				elseif b("Chaos Bolt") == "Chaos Bolt" then override = "Chaos Bolt"
				elseif b("Haunt") == "Haunt" then override = "[@mouseover,harm,nodead][]Haunt"
				elseif b("Unstable Affliction") == "Unstable Affliction" then override = "[@mouseover,harm,nodead][]Unstable Affliction"
				end
				EditMacro("WSxGen4",nil,nil,"/use [nocombat,noexists]Crystalline Eye of Undravius;"..override.."\n/targetenemy [noexists]\n/cleartarget [dead]\n/cancelaura Crystalline Eye of Undravius\n/use Poison Extraction Totem")
				if b("Havoc") == "Havoc" then overrideModAlt = "[@mouseover,harm,nodead,nomod:alt][nomod:alt]Havoc"
				elseif b("Unstable Affliction") == "Unstable Affliction" then overrideModAlt = "[@mouseover,harm,nodead,nomod:alt][nomod:alt]Unstable Affliction"
				elseif b("Power Siphon") == "Power Siphon" then overrideModAlt = "Power Siphon"
				elseif b("Corruption") == "Corruption" then overrideModAlt = "[@mouseover,harm,nodead,nomod:alt][nomod:alt]Corruption"
				end
				if b("Agony") == "Agony" then override = "Agony"
				elseif b("Havoc") == "Havoc" then override = "Havoc"
				elseif b("Corruption") == "Corruption" then override = "Corruption"
				end
				EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noexists]\n/use "..overrideModAlt.."\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use "..override.."\n/targetlasttarget")
				if b("Nether Portal") == "Nether Portal" then override = "Nether Portal"
				elseif b("Soul Fire") == "Soul Fire" then override = "Soul Fire"
				elseif b("Demonic Gateway") == "Demonic Gateway" then override = "[@cursor]Demonic Gateway"
				end
				EditMacro("WSxCGen+4",nil,nil,"/use "..override.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				
				if b("Demonbolt") == "Demonbolt" then override = "[@mouseover,harm,nodead][]Demonbolt"
				elseif b("Conflagrate") == "Conflagrate" then override = "[@mouseover,harm,nodead][]Conflagrate"
				else override = "Shadow Bolt"
				end
				EditMacro("WSxGen5",nil,nil,"/use [pet:Voidwalker,mod:ctrl]Suffering;[mod:ctrl]Fel Domination;[nocombat,noexists]Fire-Eater's Vial\n/use [nopet:Voidwalker,mod:ctrl]Summon Voidwalker;"..override.."\n/targetenemy [noexists]")
				if b("Summon Infernal") == "Summon Infernal" then overrideModAlt = "[mod:alt,@cursor]Summon Infernal"
				elseif b("Grimoire: Felguard") == "Grimoire: Felguard" then overrideModAlt = "[nomod:alt]Grimoire: Felguard"
				elseif b("Bilescourge Bombers") == "Bilescourge Bombers" then overrideModAlt = "[@player,nomod:alt]Bilescourge Bombers"
				elseif b("Demonic Strength") == "Demonic Strength" then overrideModAlt = "[pet:Felguard/Wrathguard,nomod:alt]Demonic Strength"
				elseif b("Channel Demonfire") == "Channel Demonfire" then overrideModAlt = "[nomod:alt]Channel Demonfire"
				elseif b("Siphon Life") == "Siphon Life" then overrideModAlt = "[@mouseover,harm,nodead,nomod:alt][nomod:alt]Siphon Life"
				end
				if b("Demonbolt") == "Demonbolt" then override = "Demonbolt"
				elseif b("Siphon Life") == "Siphon Life" then override = "Siphon Life"
				end
				EditMacro("WSxSGen+5",nil,nil,"/targetenemy [noexists]\n/use "..overrideModAlt.."\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use "..override.."\n/targetlasttarget")
				if b("Summon Darkglare") == "Summon Darkglare" then overrideModAlt = "[mod]Summon Darkglare;"
				elseif b("Summon Demonic Tyrant") == "Summon Demonic Tyrant" then overrideModAlt = "[mod]Summon Demonic Tyrant;"
				elseif b("Summon Infernal") == "Summon Infernal" then overrideModAlt = "[mod,@cursor]Summon Infernal;"
				end
				if b("Seed of Corruption") == "Seed of Corruption" then override = "[@mouseover,harm,nodead][]Seed of Corruption"
				elseif b("Implosion") == "Implosion" then override = "[@mouseover,harm,nodead][]Implosion"
				elseif b("Soul Strike") == "Soul Strike" then override = "[@mouseover,harm,nodead][]Soul Strike"
				elseif b("Rain of Fire") == "Rain of Fire" then override = "[@cursor]Rain of Fire"
				end
				EditMacro("WSxGen6",nil,nil,"/use "..overrideModAlt..override.."\n/startattack")
				override = ""
				if b("Rain of Fire") == "Rain of Fire" then override = "[@player]Rain of Fire;"
				elseif b("Malefic Rapture") == "Malefic Rapture" then override = "Malefic Rapture;"
				end
				EditMacro("WSxSGen+6",nil,nil,"/use "..override.."[spec:2,nopet:Felguard/Wrathguard]Summon Felguard;[pet:Felguard/Wrathguard]!Felstorm;Command Demon\n/stopmacro [@pet,nodead]\n/run PetDismiss()")
				overrideModAlt = ""
				if b("Guillotine") == "Guillotine" then 
					overrideModAlt = "[@player,mod:shift]Guillotine;"
				end
				if b("Cataclysm") == "Cataclysm" then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Cataclysm"
				elseif b("Phantom Singularity") == "Phantom Singularity" then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Phantom Singularity"
				elseif b("Vile Taint") == "Vile Taint" then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Vile Taint"
				elseif b("Bilescourge Bombers") == "Bilescourge Bombers" then override = "[@player,mod:shift][@mouseover,exists,nodead][@cursor]Bilescourge Bombers"
				overrideModAlt = ""
				elseif b("Demonic Strength") == "Demonic Strength" then override = "[@mouseover,harm,nodead][]Demonic Strength"
				elseif b("Guillotine") == "Guillotine" then override = "[@mouseover,exists,nodead][@cursor]Guillotine"
				overrideModAlt = ""
				end
				EditMacro("WSxGen7",nil,nil,"#showtooltip\n/stopspelltarget\n/use "..overrideModAlt..override.."\n/targetenemy [noexists]")
				if b("Guillotine") == "Guillotine" then override = "[@player,mod:shift][@mouseover,exists,nodead][@cursor]Guillotine"
				elseif b("Soul Rot") == "Soul Rot" then override = "[@mouseover,harm,nodead][]Soul Rot"
				elseif b("Summon Soulkeeper") == "Summon Soulkeeper" then override = "[@player,mod][@mouseover,exists,nodead][@cursor]Summon Soulkeeper"
				elseif b("Implosion") == "Implosion" then override = "[@mouseover,harm,nodead][]Implosion"
				else override = "Subjugate Demon"
				end
				EditMacro("WSxGen8",nil,nil,"#showtooltip\n/stopspelltarget\n/use "..override)
				if b("Summon Soulkeeper") == "Summon Soulkeeper" then override = "[@player,mod][@mouseover,exists,nodead][@cursor]Summon Soulkeeper"
				elseif b("Inquisitor's Gaze") == "Inquisitor's Gaze" then override = "Inquisitor's Gaze"	
				elseif b("Implosion") == "Implosion" then override = "Implosion"
				else override = "Create Soulwell"
				end
				EditMacro("WSxGen9",nil,nil,"#show\n/stopspelltarget\n/use "..override)
				EditMacro("WSxCSGen+2",nil,nil,"/use [spec:1,@focus,harm,nodead]Unstable Affliction;[@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Singe Magic;[nocombat,noexists]Legion Invasion Simulator\n/targetenemy [noharm]\n/cleartarget [dead]")
				EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noexists]The Perfect Blossom;[spec:1,@focus,harm,nodead]Corruption;[spec:2,@focus,harm,nodead]Doom;[spec:3,@focus,harm,nodead]Immolate;[@party2,help,nodead]Singe Magic;Fel Petal;\n/targetenemy [noharm]\n/cleartarget [dead]")
				EditMacro("WSxCSGen+4",nil,nil,"/use [spec:1,@focus,harm,nodead]Agony;[spec:3,@focus,harm,nodead]Havoc\n/targetenemy [noharm]\n/cleartarget [dead]\n/use [nocombat]Micro-Artillery Controller")
				if b("Siphon Life") == "Siphon Life" then override = "[@focus,harm,nodead]Siphon Life"
				elseif b("Demonbolt") == "Demonbolt" then override = "[@focus,harm,nodead]Demonbolt"
				end
				EditMacro("WSxCSGen+5",nil,nil,"/use "..override.."\n/cleartarget [dead]\n/use Battle Standard of Coordination\n/stopmacro [combat]\n/use S.F.E. Interceptor")
				EditMacro("WSxGenQ",nil,nil,"#show\n/stopcasting [nomod,nopet]\n/use [@focus,mod:alt,harm,nodead]Fear;[mod:shift]Demonic Circle;"..locPvPQ.."\n/use [nocombat,noexists]Vixx's Chest of Tricks\n/cancelaura Wyrmtongue Collector Disguise")
				EditMacro("WSkillbomb",nil,nil,"#show\n/use "..b("Summon Demonic Tyrant","[]",";")..b("Nether Portal","[]",";")..b("Summon Infernal","[@player]",";")..b("Summon Darkglare","[]",";").."\n/use Jewel of Hellfire\n/use [@player]13\n/use 13"..dpsRacials.."\n/use Shadescale\n/use Adopted Puppy Crate\n/use Big Red Raygun")
				if b("Shadowfury") == "Shadowfury" then overrideModAlt = "[@mouseover,exists,nodead,nocombat,nomod][@cursor,nomod]Shadowfury;"
				end
				if b("Soulburn") == "Soulburn" then override = "Soulburn"
				elseif b("Amplify Curse") == "Amplify Curse" then override = "Amplify Curse"
				end
				EditMacro("WSxGenE",nil,nil,"/stopspelltarget\n/use "..overrideModAlt..override)
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..b("Shadowfury","[mod:alt,@player]",";")..b("Fel Domination")..""..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show [nopet:Felhunter]Summon Felhunter;Spell Lock\n/use [mod:alt,@focus,harm,nodead,pet:Felhunter/Observer][@mouseover,harm,nodead,pet:Felhunter/Observer][pet:Felhunter/Observer]Spell Lock;Fel Domination\n/use [nopet:Felhunter/Observer]Summon Felhunter")
				EditMacro("WSxGenR",nil,nil,"/use [mod:ctrl]Summon Sayaad;[mod:ctrl,pet]Lesser Invisibility;"..b("Shadowflame","[mod:shift]",";")..b("Curse of Exhaustion","[@mouseover,harm,nodead,nomod:ctrl][nomod:ctrl]","").."\n/targetenemy [noexists,nomod]\n/stopmacro [nomod:ctrl][nopet]\n/target pet\n/kiss\n/targetlasttarget [exists]")
				EditMacro("WSxGenT",nil,nil,"/use [pet:Incubus/Succubus/Shivarra]Whiplash;[@mouseover,harm,nodead,pet:Felguard/Wrathguard][pet:Felguard/Wrathguard]!Pursuit\n/use [nocombat]Legion Communication Orb\n/petattack [@mouseover,harm,nodead][]\n/targetenemy [noexists]\n/cleartarget [dead]")
				override = ""
				if b("Shadowflame") == "Shadowflame" then override = "Shadowflame"
				else override = "Curse of Weakness"
				end
				EditMacro("WSxSGen+T",nil,nil,"#show "..override.."\n/use [@mouseover,harm,nodead][harm,nodead]Curse of Weakness;[help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use [@mouseover,help][]Soulstone")
				EditMacro("WSxGenU",nil,nil,"#show [help]Soulstone;[nopet]Summon Imp;"..b("Amplify Curse","[]",";").."Soulstone\n/use "..b("Amplify Curse","[]",";").."[nopet]Summon Imp")
				EditMacro("WSxGenF",nil,nil,"#show Demonic Circle\n/focus [@mouseover,exists]mouseover\n/stopmacro [@mouseover,exists]\n/stopcasting [nomod,nopet]\n/use [mod,exists,nodead]All-Seer's Eye;"..locPvPF.."\n/use [noexists,nocombat,nomod]Tickle Totem")
				EditMacro("WSxSGen+F",nil,nil,"/use [mod:alt,nocombat,noexists]Gastropod Shell;[pet:Felguard/Wrathguard]Threatening Presence;[pet:Imp]Flee;[pet:Voidwalker]Suffering\n/use B. F. F. Necklace\n/petautocasttoggle [mod:alt]Legion Strike;[pet:Voidwalker]Suffering;Threatening Presence")
				EditMacro("WSxCGen+F",nil,nil,"#show [nocombat]Ritual of Doom;"..b("Amplify Curse","[]","").."\n/use [group,nocombat]Ritual of Doom;"..b("Amplify Curse","[]","").."\n/use Bewitching Tea Set\n/use "..fftpar.."\n/cancelaura Wyrmtongue Disguise\n/cancelaura Burning Rush\n/cancelaura Heartsbane Curse")
				EditMacro("WSxCAGen+F",nil,nil,"#show "..b("Soulburn","[]",";")..
					--\n/run if not InCombatLockdown() then if GetSpellCooldown(111771)==0 then "..tpPants.." else "..noPants.." end end
					"\n/stopcasting\n/use "..b("Soulburn","[]",";").."\n/use "..b("Demonic Gateway","[@cursor]","").."\n/use Gateway Control Shard")
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]Eye of Kilrogg;[@mouseover,harm,nodead,pet:Felhunter][pet:Felhunter,harm,nodead]Devour Magic;[@mouseover,exists,nodead][]Command Demon\n/stopspelltarget")
				if b("Mortal Coil") == "Mortal Coil" then override = "[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Mortal Coil"
				elseif b("Howl of Terror") == "Howl of Terror" then override = "Howl of Terror"
				end
				EditMacro("WSxSGen+G",nil,nil,"/use "..override.."\n/use Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use [help,nodead,pet:Imp/Fel Imp][@player,pet:Imp/Fel Imp]Singe Magic;Fel Domination\n/use [nopet:Imp/Fel Imp]Summon Imp\n/use Legion Pocket Portal")
				if b("Grimoire of Sacrifice") == "Grimoire of Sacrifice" then overrideModAlt = "Grimoire of Sacrifice;"
				elseif b("Dark Pact") == "Dark Pact" then overrideModAlt = "Dark Pact;"
				end
				if b("Grimoire of Sacrifice") == "Grimoire of Sacrifice" then override = "[pet]Grimoire of Sacrifice;"
				end
				EditMacro("WSxCSGen+G",nil,nil,"#show [mod]Create Soulwell;"..overrideModAlt.."Summon Felhunter\n/use "..override.."[nopet][combat]Summon Felhunter;Create Soulwell\n/use [nopet]Summon Felhunter")
				EditMacro("WSxGenH",nil,nil,"#show Demonic Circle: Teleport\n/run if not InCombatLockdown() then if IsMounted()then DoEmote(\"mountspecial\")end end"..b("Soulburn","\n/use ","\n/castsequence [mod,nomounted]reset=5 Demonic Circle,Demonic Circle: Teleport\n/use [nomod,nomounted]Demonic Circle: Teleport"))
				EditMacro("WSxGenZ",nil,nil,"/use "..b("Demonic Gateway","[mod:alt,@cursor]",";")..b("Dark Pact","[mod:shift]",";").."Unending Resolve")
	    		if b("Burning Rush") == "Burning Rush" then override = "!Burning Rush;"
				elseif b("Dark Pact") == "Dark Pact" then override = "Dark Pact;"
				end
				EditMacro("WSxGenX",nil,nil,"/use [mod:alt,group]Create Soulwell;[mod:alt]Create Healthstone;[mod:shift]Demonic Circle: Teleport;[mod,harm,nodead]Subjugate Demon;[mod,group]Ritual of Summoning;[mod]Unstable Portal Emitter;"..override.."Demonic Circle: Teleport")
				EditMacro("WSxGenC",nil,nil,"/use [mod,@mouseover,harm,nodead][mod]Fear;[nopet]Summon Voidwalker;Ring of Broken Promises\n/use Smolderheart\n/use Health Funnel\n/cancelaura X-Ray Specs\n/ping [mod:ctrl,@mouseover,harm,nodead][mod:ctrl,harm,nodead]onmyway")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use Spire of Spite\n/run PetDismiss();\n/cry")
				EditMacro("WSxGenV",nil,nil,"#show "..b("Banish","[mod]",";")..b("Curse of Tongues").."\n/use "..b("Curse of Tongues","[@mouseover,harm,nodead][]","").."\n/use [nomod]Panflute of Pandaria\n/use Haw'li's Hot & Spicy Chili\n/cancelaura Rhan'ka's Escape Plan\n/use Void Totem\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@focus,harm,nodead,mod:alt][@mouseover,harm,nodead][harm,nodead]Banish;[@mouseover,help,nodead][]Unending Breath\n/use [mod:alt]Stylish Black Parasol")
				EditMacro("WSxCAGen+B",nil,nil,"")
				EditMacro("WSxCAGen+N",nil,nil,"")
			-- Monk, menk, Happyvale
			elseif class == "MONK" then
				if b("Soothing Mist") == "Soothing Mist" then override = "[@mouseover,help,nodead,nochanneling:Soothing Mist][nochanneling:Soothing Mist]Soothing Mist;[@mouseover,help,nodead][]Vivify"
				else override = "Expel Harm"
				end
				EditMacro("WSxGen1",nil,nil,"#show\n/use [nocombat,noexists]Mrgrglhjorn\n/use "..override.."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+1",nil,nil,"/use "..b("Soothing Mist","[mod:ctrl,@party2,help,nodead,nochanneling:Soothing Mist][@party1,help,nodead,nochanneling:Soothing Mist]",";").."[mod:ctrl,@party2,help,nodead][@party1,help,nodead]Vivify;Honorary Brewmaster Keg")
				EditMacro("WSxGen2",nil,nil,"#show\n/use [channeling,@mouseover,help,nodead][channeling:Soothing Mist]Vivify;[nocombat,noexists]Brewfest Keg Pony;Tiger Palm\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use "..b("Soothing Mist","[mod:alt,@party3,nodead,nochanneling:Soothing Mist]",";").."[@party3,nodead,mod:alt][@mouseover,help,nodead][]Vivify\n/use [nochanneling]Gnomish X-Ray Specs")
				EditMacro("WSxGen3",nil,nil,"/use "..b("Enveloping Mist","[channeling,@mouseover,help,nodead][channeling:Soothing Mist]",";").."[@mouseover,harm,nodead][]Touch of Death\n/use [nocombat,noexists]Mystery Keg\n/use [nocombat,noexists]Jin Warmkeg's Brew\n/targetenemy [noexists]\n/cleartarget [dead]")  
				EditMacro("WSxSGen+3",nil,nil,"/use "..b("Rushing Jade Wind","[]",";")..b("Soothing Mist","[mod:alt,@party4,nodead,nochanneling:Soothing Mist]",";").."[@party4,nodead,mod:alt]Vivify;"..b("Enveloping Mist","[@mouseover,help,nodead][]",";").."Crackling Jade Lightning")
				EditMacro("WSxGen4",nil,nil,"#show\n/use [nocombat,noexists]Brewfest Pony Keg;"..b("Rising Sun Kick","[]","").."\n/use Piccolo of the Flaming Fire\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
				if b("Chi Wave") == "Chi Wave" then override = "Chi Wave;"
				elseif b("Chi Burst") == "Chi Burst" then override = "Chi Burst;"
				end
				EditMacro("WSxSGen+4",nil,nil,"#show\n/use [@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Renewing Mist;"..override.."Tiger Palm\n/stopspelltarget\n/targetenemy [noexists]")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use [mod:alt,@party3,help,nodead]Renewing Mist;Expel Harm\n/targetenemy [nocombat,noexists]")
				override = ""
				if b("Zen Meditation") == "Zen Meditation" then override = "[mod:ctrl]Zen Meditation;"
				elseif b("Thunder Focus Tea") == "Thunder Focus Tea" then override = "[mod:ctrl]Thunder Focus Tea;"
				end
				EditMacro("WSxGen5",nil,nil,"#show "..override.."Blackout Kick\n/use [noexists,nocombat]Brewfest Banner\n/use "..override.."Blackout Kick\n/targetenemy [noexists]\n/cleartarget [dead]")
				if b("Strike of the Windlord") == "Strike of the Windlord" then override = "Strike of the Windlord"
				elseif b("Energizing Elixir") == "Energizing Elixir" then override = "Energizing Elixir"
				elseif b("Zen Pulse") == "Zen Pulse" then override = "[@mouseover,help,nodead][]Zen Pulse"
				elseif b("Keg Smash") == "Keg Smash" then override = "Keg Smash"
				elseif b("Thunder Focus Tea") == "Thunder Focus Tea" then override = "Thunder Focus Tea"
				elseif b("Jadefire Stomp") == "Jadefire Stomp" then override = "Jadefire Stomp"
				end
				EditMacro("WSxSGen+5",nil,nil,"/use "..b("Renewing Mist","[@party2,help,nodead,mod:alt]",";")..override.."\n/use Displacer Meditation Stone\n/targetenemy [noexists]")
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod:ctrl,@party4,help,nodead]Renewing Mist;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14\n/use Eternal Black Diamond Ring")
				if b("Storm, Earth, and Fire") == "Storm, Earth, and Fire" then override = "[mod]Storm, Earth, and Fire;"
				elseif b("Serenity") == "Serenity" then override = "[mod]Serenity;"
				elseif b("Invoke Xuen, the White Tiger") == "Invoke Xuen, the White Tiger" then override = "[mod]Invoke Xuen, the White Tiger;"
				elseif b("Invoke Yu'lon, the Jade Serpent") == "Invoke Yu'lon, the Jade Serpent" then override = "[mod]Invoke Yu'lon, the Jade Serpent;"
				elseif b("Invoke Chi-Ji, the Red Crane") == "Invoke Chi-Ji, the Red Crane" then override = "[mod]Invoke Chi-Ji, the Red Crane;"
				elseif b("Invoke Niuzao, the Black Ox") == "Invoke Niuzao, the Black Ox" then override = "[mod]Invoke Niuzao, the Black Ox;"
				end
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..override.."!Spinning Crane Kick\n/use Words of Akunda")
				if b("Fists of Fury") == "Fists of Fury" then override = "[@mouseover,harm,nodead][]Fists of Fury"
				elseif b("Essence Font") == "Essence Font" then override = "Essence Font"
				elseif b("Breath of Fire") == "Breath of Fire" then override = "Breath of Fire"
				elseif b("Black Ox Brew") == "Black Ox Brew" then override = "Black Ox Brew"
				end
				EditMacro("WSxSGen+6",nil,nil,"/use [noexists,nocombat,spec:3]\"Purple Phantom\" Contender's Costume;"..override.."\n/targetenemy [noexists]\n/stopmacro [combat]\n/click ExtraActionButton1",1,1)
				if b("Exploding Keg") == "Exploding Keg" then override = "[mod:shift,@player][@cursor]Exploding Keg"
				elseif b("Whirling Dragon Punch") == "Whirling Dragon Punch" then override = "Whirling Dragon Punch"
				elseif b("Bonedust Brew") == "Bonedust Brew" then override = "[mod:shift,@player][@cursor]Bonedust Brew"
				elseif b("Jadefire Stomp") == "Jadefire Stomp" then override = "Jadefire Stomp"
				elseif b("Summon White Tiger Statue") == "Summon White Tiger Statue" then override = "[mod:shift,@player][@cursor]Summon White Tiger Statue"
				elseif b("Storm, Earth, and Fire") == "Storm, Earth, and Fire" then override = "Storm, Earth, and Fire"
				elseif b("Serenity") == "Serenity" then override = "Serenity"
				elseif b("Summon Jade Serpent Statue") == "Summon Jade Serpent Statue" then override = "[@cursor]Summon Jade Serpent Statue"
				else override = "!Spinning Crane Kick"
				end
				EditMacro("WSxGen7",nil,nil,"#show\n/use "..override)
				if b("Summon White Tiger Statue") == "Summon White Tiger Statue" then override = "[mod:shift,@player][@cursor]Summon White Tiger Statue"
				elseif b("Weapons of Order") == "Weapons of Order" then override = "Weapons of Order"
				elseif b("Refreshing Jade Wind") == "Refreshing Jade Wind" then override = "Refreshing Jade Wind"
				elseif b("Summon Jade Serpent Statue") == "Summon Jade Serpent Statue" then override = "[mod:shift,@player][@cursor]Summon Jade Serpent Statue"
				elseif b("Jadefire Stomp") == "Jadefire Stomp" then override = "Jadefire Stomp"

				elseif b("Bonedust Brew") == "Bonedust Brew" then override = "Bonedust Brew"
				elseif b("Thunder Focus Tea") == "Thunder Focus Tea" then override = "Thunder Focus Tea"
				elseif b("Rushing Jade Wind") == "Rushing Jade Wind" then override = "Rushing Jade Wind"
				elseif b("Invoke Xuen, the White Tiger") == "Invoke Xuen, the White Tiger" then override = "Invoke Xuen, the White Tiger"
				elseif b("Storm, Earth, and Fire") == "Storm, Earth, and Fire" then override = "Storm, Earth, and Fire"
				elseif b("Serenity") == "Serenity" then override = "Serenity"
				else override = "!Spinning Crane Kick"
				end
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..override)
				if b("Bonedust Brew") == "Bonedust Brew" then override = "[mod:shift,@player][@cursor]Bonedust Brew"
				elseif b("Invoke Xuen, the White Tiger") == "Invoke Xuen, the White Tiger" then override = "Invoke Xuen, the White Tiger"
				elseif b("Storm, Earth, and Fire") == "Storm, Earth, and Fire" then override = "Storm, Earth, and Fire"
				elseif b("Serenity") == "Serenity" then override = "Serenity"
				elseif b("Sheilun's Gift") == "Sheilun's Gift" then override = "Sheilun's Gift"
				elseif b("Revival") == "Revival" then override = "Revival"
				elseif b("Restoral") == "Restoral" then override = "Restoral"
				elseif b("Weapons of Order") == "Weapons of Order" then override = "Weapons of Order"
				elseif b("Invoke Niuzao, the Black Ox") == "Invoke Niuzao, the Black Ox" then override = "Invoke Niuzao, the Black Ox"
				end
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..override)
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Detox")
				EditMacro("WSxCSGen+3",nil,nil,"/use [mod:alt,@party4,help,nodead][@party2,help,nodead]Detox;Mulled Alterac Brandy\n/run if not InCombatLockdown() then local j,p,_=C_PetJournal _,p=j.FindPetIDByName(\"Alterac Brew-Pup\") if p and j.GetSummonedPetGUID()~=p then j.SummonPetByGUID(p) end end")
				EditMacro("WSxCSGen+4",nil,nil,"/use "..b("Enveloping Mist","[mod:alt,@party3,help,nodead,nochanneling:Soothing Mist][@party1,help,nodead,nochanneling:Soothing Mist]Soothing Mist;[mod:alt,@party3,help,nodead][@party1,help,nodead]","").."\n/use [nocombat,noexists]Totem of Harmony")
				EditMacro("WSxCSGen+5",nil,nil,"/use "..b("Enveloping Mist","[mod:alt,@party4,help,nodead,nochanneling:Soothing Mist][@party2,nodead,nochanneling:Soothing Mist]Soothing Mist;[mod:alt,@party4,help,nodead][@party2,help,nodead]","").."\n/use [nocombat,noexists]Pandaren Brewpack\n/cancelaura Pandaren Brewpack")
				EditMacro("WSxGenQ",nil,nil,"#show\n/use "..b("Transcendence","[mod:shift]",";")..b("Spear Hand Strike","[@mouseover,harm,nodead,nomod][harm,nodead,nomod]",";")..b("Paralysis","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";").."The Golden Banana")
				if b("Storm, Earth, and Fire") == "Storm, Earth, and Fire" then overrideModAlt = "\n/use Storm, Earth, and Fire"
				elseif b("Serenity") == "Serenity" then overrideModAlt = "\n/use Serenity"
				end
				if b("Invoke Xuen, the White Tiger") == "Invoke Xuen, the White Tiger" then override = "\n/use Invoke Xuen, the White Tiger"
				elseif b("Invoke Yu'lon, the Jade Serpent") == "Invoke Yu'lon, the Jade Serpent" then override = "\n/use Invoke Yu'lon, the Jade Serpent"
				elseif b("Invoke Chi-Ji, the Red Crane") == "Invoke Chi-Ji, the Red Crane" then override = "\n/use Invoke Chi-Ji, the Red Crane"
				elseif b("Invoke Niuzao, the Black Ox") == "Invoke Niuzao, the Black Ox" then override = "\n/use Invoke Niuzao, the Black Ox"
				end
				EditMacro("WSkillbomb",nil,nil,"#show"..overrideModAlt..override..dpsRacials.."\n/use Rukhmar's Sacred Memory\n/use Adopted Puppy Crate\n/use [@player]13\n/use 13\n/use Celestial Defender's Medallion\n/use Big Red Raygun\n/use Piccolo of the Flaming Fire\n/use [@player]Summon White Tiger Statue")
				if b("Clash") == "Clash" then override = "[@mouseover,harm,nodead][harm,nodead]Clash"
				elseif b("Flying Serpent Kick") == "Flying Serpent Kick" then override = "Flying Serpent Kick"
				elseif b("Soothing Mist") == "Soothing Mist" then override = "[@mouseover,help,nodead][]Soothing Mist"
				elseif b("Song of Chi-Ji") == "Song of Chi-Ji" then override = "Song of Chi-Ji"
				elseif b("Ring of Peace") == "Ring of Peace" then override = "Ring of Peace"
				end
				EditMacro("WSxGenE",nil,nil,"#show "..override.."\n/use Prismatic Bauble\n/use [mod:alt]Leg Sweep;"..override.."\n/targetenemy [noexists]")
				EditMacro("WSxCGen+E",nil,nil,"#show Roll\n/use Expel Harm"..oOtas..covToys.."\n/use A Collection Of Me")
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..b("Ring of Peace","[mod:alt,@player]",";")..b("Song of Chi-Ji","[]",";")..b("Summon Black Ox Statue","\n/target Black Ox\n/use [@cursor,nomod:alt]","\n/use [help,nodead]Provoke\n/targetlasttarget"))
				if b("Ring of Peace") == "Ring of Peace" then override = "[mod:shift,@cursor]Ring of Peace;"
				elseif b("Song of Chi-Ji") == "Song of Chi-Ji" then override = "[mod:shift]Song of Chi-Ji;"
				end
				EditMacro("WSxGenR",nil,nil,"#show\n/use "..override..b("Tiger's Lust","[mod:ctrl,@player][@mouseover,help,nodead][help,nodead]",";")..b("Disable","[]",";").."[@mouseover,harm,nodead][]Crackling Jade Lightning")
				if b("Revival") == "Revival" then override = "[]Revival;"
				elseif b("Restoral") == "Restoral" then override = "[]Restoral;"
				elseif b("Black Ox Brew") == "Black Ox Brew" then override = "[]Black Ox Brew;"
				elseif b("Summon Jade Serpent Statue") == "Summon Jade Serpent Statue" then override = "[]Summon Jade Serpent Statue;"
				elseif b("Summon Black Ox Statue") == "Summon Black Ox Statue" then override = "[]Summon Black Ox Statue;"
				end
				EditMacro("WSxGenT",nil,nil,"#show "..override.."Mystic Touch\n/use [@mouseover,harm,nodead][harm,nodead]Crackling Jade Lightning;[help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+T",nil,nil,"#show\n/targetenemy [noexists]\n/cleartarget [dead]\n/use Provoke")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..b("Summon Black Ox Statue","\n/target Black Ox\n/use [mod:alt,@player][@cursor]","\n/use [help,nodead]Provoke\n/targetlasttarget")..b("Summon Jade Serpent Statue","[mod:alt,@player][@cursor]",";")..b("Summon White Tiger Statue","[mod:alt,@player][@cursor]",";").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..b("Tiger's Lust","[]",";").."Roll")
				EditMacro("WSxGenF",nil,nil,"#show Transcendence: Transfer\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;"..b("Spear Hand Strike","[@focus,harm,nodead]",";")..b("Paralysis","[@focus,harm,nodead]","").."\n/targetenemy [noexists]")
				if b("Dampen Harm") == "Dampen Harm" then override = "Dampen Harm"
				elseif b("Diffuse Magic") == "Diffuse Magic" then override = "Diffuse Magic"
				elseif b("Jadefire Stomp") == "Jadefire Stomp" then override = "Jadefire Stomp"
				end
				EditMacro("WSxSGen+F",nil,nil,"/use [help,nocombat,mod:alt]B. B. F. Fist;[nocombat,noexists,mod:alt]Gastropod Shell;"..override.."\n/use [nocombat]Mulled Alterac Brandy\n/cancelaura [mod]Purple Phantom")
				if b("Touch of Karma") == "Touch of Karma" then overrideModAlt = "Touch of Karma"
				elseif b("Mana Tea") == "Mana Tea" then overrideModAlt = "Mana Tea"
				elseif b("Zen Meditation") == "Zen Meditation" then overrideModAlt = "Zen Meditation"
				end
				if b("Touch of Karma") == "Touch of Karma" then override = "Touch of Karma"
				elseif b("Revival") == "Revival" then override = "Revival"
				elseif b("Restoral") == "Restoral" then override = "Restoral"
				elseif b("Zen Meditation") == "Zen Meditation" then override = "Zen Meditation"
				end
				EditMacro("WSxCGen+F",nil,nil,"#show "..overrideModAlt.."\n/use "..override.."\n/cancelaura Celestial Defender")
				EditMacro("WSxCAGen+F",nil,nil,"#show "..b("Leg Sweep","[combat][exists,nodead]",";").."Silversage Incense\n/targetfriendplayer\n/use [help,nodead]Tiger's Lust;Silversage Incense\n/targetlasttarget")
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt,nomounted,nocombat,noexists]Darkmoon Gazer;[mod:alt]Nimble Brew;"..b("Detox","[@mouseover,help,nodead][]",""))
				if b("Diffuse Magic") == "Diffuse Magic" then override = "Diffuse Magic"
				elseif b("Dampen Harm") == "Dampen Harm" then override = "Dampen Harm"
				end
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..override.."\n/use Pandaren Scarecrow\n/use [noexists,nocombat]Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..b("Summon White Tiger Statue","[mod:alt,@player][@cursor]",";")..b("Summon Black Ox Statue","\n/target Black Ox\n/use [mod:alt,@player][@cursor]","\n/use [help,nodead]Provoke\n/targetlasttarget")..b("Summon Jade Serpent Statue","[mod:alt,@player][@cursor]",";").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxCSGen+G",nil,nil,"#show Transcendence\n/use [@focus,help,nodead]Detox\n/cancelaura Blessing of Protection\n/cancelaura Words of Akunda")
				EditMacro("WSxGenZ",nil,nil,"#show "..b("Fortifying Brew").."\n/use [mod:alt]Gateway Control Shard;"..b("Healing Elixir","[nomod]",";")..b("Dampen Harm","[nomod]",";")..b("Fortifying Brew","[mod:shift][nomod]",";")..b("Diffuse Magic","[mod:shift][nomod]","").."\n/use Lao Chin's Last Mug")
				if b("Celestial Brew") == "Celestial Brew" then override = "Celestial Brew"
				elseif b("Touch of Karma") == "Touch of Karma" then override = "Touch of Karma"
				elseif b("Life Cocoon") == "Life Cocoon" then override = "[@mouseover,help,nodead][nodead]Life Cocoon"
				end
				EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt]Tumblerun Brew;[mod:ctrl]Zen Pilgrimage;[mod:shift]Transcendence: Transfer;"..override)
				override = ""
				overrideModAlt = ""
				if b("Mana Tea") == "Mana Tea" then overrideModAlt = "[mod:shift]Mana Tea;"
				elseif b("Black Ox Brew") == "Black Ox Brew" then overrideModAlt = "[mod:shift]Black Ox Brew;"
				end
				if b("Purifying Brew") == "Purifying Brew" then override = "[nomod]Purifying Brew;"
				elseif b("Renewing Mist") == "Renewing Mist" then override = "[@mouseover,help,nodead,nomod][nomod]Renewing Mist;"
				elseif b("Soothing Mist") == "Soothing Mist" then override = "[@mouseover,help,nodead,nomod][nomod]Soothing Mist;"
				end
				EditMacro("WSxGenC",nil,nil,"#show\n/use "..overrideModAlt..override..b("Paralysis","[mod,@mouseover,harm,nodead][mod][@mouseover,harm,nodead][]",";").."\n/cancelaura X-Ray Specs")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/click TotemFrameTotem1 RightButton\n/run PetDismiss()\n/use [noexists,nocombat]Turnip Punching Bag")
				EditMacro("WSxGenV",nil,nil,"#show\n/use Roll\n/use Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Ruthers' Harness\n/use Prismatic Bauble")
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem;!Zen Flight\n/use [mod:alt]Delicate Jade Parasol\n/use Mystical Orb of Meditation")
			-- Paladin, bvk, palajong
			elseif class == "PALADIN" then
				EditMacro("WSxGen1",nil,nil,"/use "..b("Intercession","[@mouseover,help,dead][help,dead]",";")..b("Holy Shock","[@mouseover,exists,nodead][exists,nodead]",";").."!Devotion Aura\n/use Pretty Draenor Pearl\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+1",nil,nil,"#show "..b("Blessing of Protection").."\n/use [mod:alt,@party3,help,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Flash of Light\n/use Vindicator's Armor Polish Kit")
				EditMacro("WSxGen2",nil,nil,"#show\n/use "..b("Blessing of Summer","[@mouseover,help,nodead][help,nodead]",";")..b("Crusader Strike","[known:404542,@mouseover,harm,nodead][known:404542]Judgment;","").."\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]\n/cancelaura X-Ray Specs")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use [@party4,help,nodead,mod:alt][@mouseover,help,nodead][]Flash of Light\n/use Gnomish X-Ray Specs")
				EditMacro("WSxGen3",nil,nil,"/use "..b("Light of the Martyr","[@mouseover,help,nodead][help,nodead]",";")..b("Hammer of Wrath","[@mouseover,harm,nodead][harm,nodead]",";")..b("Contemplation").."\n/targetenemy [noexists]\n/stopspelltarget")
				if b("Daybreak") == "Daybreak" then override = "Daybreak"
				elseif b("Execution Sentence") == "Execution Sentence" then override = "Execution Sentence"
				elseif b("Consecration") == "Consecration" then override = "Consecration"
				end
				EditMacro("WSxSGen+3",nil,nil,"/use "..override.."\n/targetenemy [noexists]\n/use Soul Evacuation Crystal")
				if b("Avenger's Shield") == "Avenger's Shield" then override = "[@mouseover,harm,nodead][]Avenger's Shield"
				elseif b("Blade of Justice") == "Blade of Justice" then override = "Blade of Justice"
				elseif b("Judgment") == "Judgment" then override = "Judgment"
				end
				EditMacro("WSxGen4",nil,nil,"/use [spec:2,help,nodead,nocombat]Dalaran Disc;[help,nodead,nocombat]Holy Lightsphere;"..override.."\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
				if b("Holy Shock") == "Holy Shock" then overrideModAlt = "[@focus,help,nodead,mod:alt][@party1,nodead,mod:alt]Holy Shock;"
				end
				if b("Moment of Glory") == "Moment of Glory" then override = "Moment of Glory"
				elseif b("Final Reckoning") == "Final Reckoning" then override = "[@mouseover,exists,nodead][@cursor]Final Reckoning"
				elseif b("Tyr's Deliverance") == "Tyr's Deliverance" then override = "[@mouseover,help,nodead][]Tyr's Deliverance"
				end
				EditMacro("WSxSGen+4",nil,nil,"#show\n/stopspelltarget\n/use "..overrideModAlt..override.."\n/targetenemy [noexists]")
				if b("Holy Shock") == "Holy Shock" then overrideModAlt = "[@party3,help,nodead,mod:alt]Holy Shock;"
				end
				if b("Beacon of Faith") == "Beacon of Faith" then override = "[@mouseover,help,nodead][]Beacon of Faith"
				elseif b("Beacon of Light") == "Beacon of Light" then override = "[@mouseover,help,nodead][]Beacon of Light"
				else override = "!Devotion Aura"
				end
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..overrideModAlt..override.."\n/startattack [combat]")
				if b("Ardent Defender") == "Ardent Defender" then overrideModAlt = "[mod:ctrl]Ardent Defender;"
				elseif b("Aura Mastery") == "Aura Mastery" then overrideModAlt = "[mod:ctrl]Aura Mastery;"
				end
				if b("Templar's Verdict") == "Templar's Verdict" then override = "Templar's Verdict"
				elseif b("Holy Light") == "Holy Light" then override = "[@mouseover,help,nodead][]Holy Light"
				else override = "[spec:2,nocombat,noexists]Barrier Generator;[spec:2]Shield of the Righteous"
				end
				EditMacro("WSxGen5",nil,nil,"/use "..overrideModAlt..override.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				overrideModAlt = ""
				if b("Divine Favor") == "Divine Favor" then overrideModAlt = "Divine Favor"
				elseif b("Hand of Divinity") == "Hand of Divinity" then overrideModAlt = "Hand of Divinity"
				end	
				if b("Holy Shock") == "Holy Shock" then override = "[@party2,help,nodead,mod:alt][@player]Holy Shock"
				elseif b("Bastion of Light") == "Bastion of Light" then override = "Bastion of Light"
				elseif b("Consecration") == "Consecration" then override = "Consecration"
				elseif b("Judgment") == "Judgment" then override = "Judgment"
				end
				EditMacro("WSxSGen+5",nil,nil,"#show "..overrideModAlt.."\n/use "..override.."\n/use [nocombat,noexists]Light in the Darkness")
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod:ctrl,@party4,help,nodead]Holy Shock;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14\n/use Eternal Black Diamond Ring")
				if b("Avenging Wrath") == "Avenging Wrath" then overrideModAlt = "[mod:ctrl]Avenging Wrath;"
				end
				if b("Divine Storm") == "Divine Storm" then override = "Divine Storm"
				else override = "Shield of the Righteous"
				end
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..overrideModAlt..override.."\n/use [mod:ctrl] 19\n/targetenemy [noexists]")
				if b("Final Reckoning") == "Final Reckoning" then override = "[@player]Final Reckoning"
				elseif b("Eye of Tyr") == "Eye of Tyr" then override = "Eye of Tyr"
				elseif b("Light of Dawn") == "Light of Dawn" then override = "Light of Dawn"
				elseif b("Consecration") == "Consecration" then override = "Consecration"
				end
				EditMacro("WSxSGen+6",nil,nil,"#show\n/use "..override)
				if b("Divine Toll") == "Divine Toll" then overrideModAlt = "[mod,@player]Divine Toll;"
				end
				if b("Wake of Ashes") == "Wake of Ashes" then override = "Wake of Ashes"
				elseif b("Consecration") == "Consecration" then override = "Consecration"
				end
				EditMacro("WSxGen7",nil,nil,"#show\n/stopspelltarget\n/use "..overrideModAlt..override.."\n/targetenemy [noexists]")
				override = ""
				overrideModAlt = ""
				if b("Holy Prism") == "Holy Prism" then 
					override = "[mod,@player][@mouseover,exists,nodead][exists,nodead]Holy Prism"
					overrideModAlt = "Holy Prism"
				elseif b("Light's Hammer") == "Light's Hammer" then 
					override = "[mod,@player][@mouseover,exists,nodead][@cursor]Light's Hammer"
					overrideModAlt = "Light's Hammer"
				else override = "Shield of the Righteous"
				end
				EditMacro("WSxGen8",nil,nil,"#show "..overrideModAlt.."\n/stopspelltarget\n/use "..override)
				if covA == "Divine Toll" then
					if b("Blessing of Summer") == "Blessing of Summer" then override = "Blessing of Summer"
					elseif b("Consecration") == "Consecration" then override = "Consecration"
					end
					EditMacro("WSxGen9",nil,nil,"#show\n/use "..override)
				else
					if b("Divine Toll") == "Divine Toll" then override = "[@mouseover,exists,nodead][]Divine Toll"
					elseif b("Consecration") == "Consecration" then override = "Consecration"
					end
					EditMacro("WSxGen9",nil,nil,"#show\n/use "..override)
				end
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,spec:1,@party3,help,nodead][spec:1,@party1,help,nodead][spec:1,@targettarget,help,nodead]Cleanse;"..b("Cleanse Toxins","[mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]",""))
				EditMacro("WSxCSGen+3",nil,nil,"/use [mod:alt,spec:1,@party4,help,nodead][spec:1,@party2,help,nodead]Cleanse;"..b("Cleanse Toxins","[mod:alt,@party4,help,nodead][@party2,help,nodead]","").."\n/use [nocombat,noharm]Forgotten Feather")
				EditMacro("WSxCSGen+4",nil,nil,"/use [mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Word of Glory")
				EditMacro("WSxCSGen+5",nil,nil,"/use [mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]Word of Glory")
				EditMacro("WSxGenQ",nil,nil,"/use "..b("Repentance","[mod:alt,@focus,harm,nodead]",";").."[mod:shift]Divine Shield;"..b("Rebuke","[@mouseover,harm,nodead][]",";")..b("Hammer of Justice","[@mouseover,harm,nodead][]",";"))
				EditMacro("WSkillbomb",nil,nil,"#show\n/use "..b("Avenging Wrath","[]","").."\n/use [@player]13\n/use 13\n/use Sha'tari Defender's Medallion"..dpsRacials.."\n/use Gnawed Thumb Ring\n/use Echoes of Rezan")
				if b("Divine Favor") == "Divine Favor" then overrideModAlt = "[mod:alt]Divine Favor;"
				elseif b("Hand of Divinity") == "Hand of Divinity" then overrideModAlt = "[mod:alt]Hand of Divinity;"
				end
				EditMacro("WSxGenE",nil,nil,"#show\n/use "..overrideModAlt.."[@mouseover,help,nodead][]Word of Glory")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use [@mouseover,help,nodead][]Lay on Hands\n/use [help,nodead]Apexis Focusing Shard\n/stopspelltarget"..oOtas..covToys)
				if b("Repentance") == "Repentance" then override = "Repentance"
				elseif b("Blinding Light") == "Blinding Light" then override = "Blinding Light"
				else override = "Hammer of Justice"
				end
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..override)
				if b("Avenger's Shield") == "Avenger's Shield" then override = "[@mouseover,harm,nodead][]Avenger's Shield"
				else override = "Judgment"
				end
				if b("Aura Mastery") == "Aura Mastery" then overrideModAlt = "#show Aura Mastery\n"
				end
				EditMacro("WSxGenR",nil,nil,overrideModAlt.."/use "..b("Divine Steed","[mod:ctrl]",";")..b("Blessing of Freedom","[@mouseover,help,nodead][help,nodead]",";")..override.."\n/use [mod:ctrl]Prismatic Bauble")
				overrideModAlt = ""
				override = ""
				if b("Turn Evil") == "Turn Evil" then 
					override = "[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]Turn Evil;"
				end
				EditMacro("WSxGenT",nil,nil,"/use "..override.."[help,nocombat]Swapblaster\n/use Titanium Seal of Dalaran\n/use \n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat]Wayfarer's Bonfire")
				EditMacro("WSxSGen+T",nil,nil,"#show\n/use Hand of Reckoning")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..b("Bestow Faith","[mod:alt,@party2,nodead]",";").."[@party4,help,nodead]Word of Glory")
			    if b("Repentance") == "Repentance" then override = "Repentance"
				elseif b("Blinding Light") == "Blinding Light" then override = "Blinding Light"
				else override = "Hammer of Justice"
				end
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..b("Repentance","[]",";")..b("Blinding Light","[]",";").."Hammer of Justice")
				EditMacro("WSxGenF",nil,nil,"#show "..b("Blessing of Freedom").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;"..b("Rebuke","[@focus,harm,nodead]",";").."[exists,nodead]Apexis Focusing Shard")
				override = ""
				if b("Divine Favor") == "Divine Favor" then override = "[nomod:alt]Divine Favor;"
				elseif b("Hand of Divinity") == "Hand of Divinity" then override = "[nomod:alt]Hand of Divinity;"
				elseif b("Avenger's Shield") == "Avenger's Shield" then override = "[nomod:alt,@focus,harm,nodead]Avenger's Shield;"
				end
				EditMacro("WSxSGen+F",nil,nil,"#show\n/use "..override.."[help,nocombat]B. F. F. Necklace;[nocombat,noexists]Gastropod Shell")
				override = ""
				EditMacro("WSxCGen+F",nil,nil,"#show "..override.."\n/use Sense Undead")
				if b("Cleanse Toxins") == "Cleanse Toxins" then override = ";[@mouseover,help,nodead][]Cleanse Toxins"
				else override = ";[spec:1,@mouseover,help,nodead][spec:1]Cleanse"
				end
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]Darkmoon Gazer"..override)
			    EditMacro("WSxSGen+G",nil,nil,"#show\n/use [mod:alt,@focus,harm,nodead][]Hammer of Justice\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]")
				EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..b("Bestow Faith","[mod:alt,@party1,nodead]",";").."[@party3,help,nodead]Word of Glory;")
				EditMacro("WSxCSGen+G",nil,nil,"#show Divine Shield\n/use [@focus,help,nodead]Cleanse\n/cancelaura Divine Shield\n/cancelaura Blessing of Protection")
				EditMacro("WSxGenH",nil,nil,"#show Intercession\n/use [nomounted]Darkmoon Gazer\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				if b("Divine Protection") == "Divine Protection" then override = "Divine Protection"
				elseif b("Guardian of Ancient Kings") == "Guardian of Ancient Kings" then override = "Guardian of Ancient Kings"
				else override = "Divine Shield"
				end
				EditMacro("WSxGenZ",nil,nil,"/use [mod:alt]!Devotion Aura;"..b("Blessing of Protection","[@mouseover,help,nodead,mod:shift][mod:shift]",";")..b("Blessing of Sacrifice","[@mouseover,help,nodead][help,nodead]",";")..override.."\n/use [mod:alt]Gateway Control Shard")
				EditMacro("WSxAGen+C",nil,nil,"#show [mod]Sylvanas' Music Box;Lay on Hands\n/use !Concentration Aura\n/use Sylvanas' Music Box")
				if playerSpec ~= 1 and b("Divine Steed") == "Divine Steed" then override = "Divine Steed"
				elseif b("Beacon of Light") == "Beacon of Light" then override = "[@mouseover,help,nodead][]Beacon of Light"
				end
				EditMacro("WSxGenV",nil,nil,"#show\n/use "..override.."\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use [nospec:1]Prismatic Bauble")
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";"..b("Turn Evil","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";").."[swimming]Barnacle-Encrusted Gem\n/use [nomod:alt]Seafarer's Slidewhistle\n/use [mod:alt]Weathered Purple Parasol")
				EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxCGen+G\",nil,nil,\"/use [@\"..B..\",known:Blessing of Summer]Blessing of Summer\\n/stopspelltarget\", nil)print(\"BoS set to : \"..B)else print(\"Nope!\")end")
				EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxCGen+T\",nil,nil,\"/use [@\"..N..\",known:Blessing of Autumn]Blessing of Summer\\n/stopspelltarget\", nil)print(\"BoA set to : \"..N)else print(\"Nööp!\")end")	
			-- Hunter, hanter 
			elseif class == "HUNTER" then
				EditMacro("WSxGen1",nil,nil,"/use "..b("Misdirection","[@mouseover,help,nodead][help,nodead]",";").."[known:127933,nocombat,noexists]Fireworks;[spec:1]Arcane Shot;Steady Shot\n/targetenemy [noexists]\n/equipset [noequipped:Bows/Crossbows/Guns]DoubleGate\n/use [nocombat,noexists]Mrgrglhjorn")
				EditMacro("WSxSGen+1",nil,nil,"#show Aspect of the Cheetah\n/use [mod:ctrl,@party2,help,nodead][mod:shift,@pet][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Spirit Mend\n/use [noexists,nocombat]Whitewater Carp\n/targetexact Talua")
				if b("Barbed Shot") == "Barbed Shot" then override = "[@mouseover,harm,nodead][harm,nodead]Barbed Shot;"
				elseif b("Rapid Fire") == "Rapid Fire" then override = "[@mouseover,harm,nodead][harm,nodead]Rapid Fire;"
				elseif b("Serpent Sting") == "Serpent Sting" then override = "[@mouseover,harm,nodead][harm,nodead]Serpent Sting;"
				elseif b("Harpoon") == "Harpoon" then override = "[@mouseover,harm,nodead][harm,nodead]Harpoon;"
				elseif b("Barrage") == "Barrage" then override = "[@mouseover,harm,nodead,known:265895][harm,nodead,known:265895]Barrage;"
				elseif b("Explosive Shot") == "Explosive Shot" then override = "[@mouseover,harm,nodead][harm,nodead]Explosive Shot;"
				end
				EditMacro("WSxGen2",nil,nil,"/use "..override.."[harm,dead]Fetch;Corbyn's Beacon\n/targetlasttarget [noharm,nodead,nocombat]\n/targetenemy [noharm]")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use [spec:1,pet,nopet:Spirit Beast][spec:3,pet]Dismiss Pet;[nopet]Call Pet 2;[@mouseover,help,nodead,pet:Spirit Beast][pet:Spirit Beast,help,nodead][pet:Spirit Beast,@player]Spirit Mend;[spec:3]Arcane Shot;Dismiss Pet\n/use Totem of Spirits")
				if b("Wildfire Bomb") == "Wildfire Bomb" then override = "[@mouseover,harm,nodead,nomod:alt][nomod:alt]Wildfire Bomb\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [mod:alt]Wildfire Bomb\n/targetlasttarget"
				elseif b("A Murder of Crows") == "A Murder of Crows" then override = "A Murder of Crows"
				elseif b("Bloodshed") == "Bloodshed" then override = "Bloodshed"
				elseif b("Serpent Sting") == "Serpent Sting" then override = "Serpent Sting"
				elseif b("Stampede") == "Stampede" then override = "Stampede"
				elseif b("Death Chakram") == "Death Chakram" then override = "Death Chakram"
				elseif b("Dire Beast") == "Dire Beast" then override = "Dire Beast"
				elseif b("Wailing Arrow") == "Wailing Arrow" then override = "Wailing Arrow"
				else override = "Hunter's Call"
				end
				EditMacro("WSxSGen+3",nil,nil,"/startattack\n/use "..override)
				if b("Aimed Shot") == "Aimed Shot" then override = "[harm,nodead]Aimed Shot;"
				elseif b("Kill Command") == "Kill Command" then override = "[@mouseover,harm,nodead][harm,nodead]Kill Command;"
				end
				EditMacro("WSxGen4",nil,nil,"#show\n/use [help,nodead]Dalaran Disc;"..override.."Puntable Marmot\n/target Puntable Marmot\n/targetenemy [noexists]\n/startattack [harm,combat]\n/cleartarget [dead]\n/use Squeaky Bat")
				if b("Steel Trap") == "Steel Trap" then override = "[@cursor,nomod:alt]Steel Trap"
				elseif b("Flanking Strike") == "Flanking Strike" then override = "[nomod:alt]Flanking Strike"
				elseif b("Dire Beast") == "Dire Beast" then override = "Dire Beast"
				elseif b("Wailing Arrow") == "Wailing Arrow" then override = "Wailing Arrow"
				elseif b("Chimaera Shot") == "Chimaera Shot" then override = "Chimaera Shot"
				elseif b("Serpent Sting") == "Serpent Sting" then override = "[nomod:alt]Serpent Sting"
				elseif b("Misdirection") == "Misdirection" then override = "[nomod:alt]Misdirection"
				elseif b("Kill Command") == "Kill Command" then override = "[nomod:alt]Kill Command\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [mod:alt]Kill Command\n/targetlasttarget"
				end
				if (playerName == "Stabbin" and class == "HUNTER" and race == "Goblin") then
					EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noharm]\n/cleartarget [dead]\n/use "..override)
				else
					EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noharm]\n/cleartarget [dead]\n/use [nocombat,noexists]Owl Post;"..override)
				end
				if b("Call of the Wild") == "Call of the Wild" then override = "Call of the Wild"
				elseif b("Salvo") == "Salvo" then override = "Salvo"
				elseif b("Fury of the Eagle") == "Fury of the Eagle" then override = "Fury of the Eagle"
				elseif b("Spearhead") == "Spearhead" then override = "Spearhead"
				elseif b("Death Chakram") == "Death Chakram" then override = "Death Chakram"
				elseif b("Stampede") == "Stampede" then override = "Stampede"
				elseif b("Barrage") == "Barrage" then override = "Barrage"
				elseif b("Eyes of the Beast") == "Eyes of the Beast" then override = "Eyes of the Beast"
				else override = "Hunter's Call"
				end
				EditMacro("WSxCGen+4",nil,nil,"/stopspelltarget\n/cast "..overrideModAlt..override)
				EditMacro("WSxGen5",nil,nil,"/use [mod]Exhilaration\n/use [mod]Fortitude of the Bear;[help,nodead]Silver-Plated Turkey Shooter;"..b("Raptor Strike","[equipped:Two-Hand]",";").."[spec:1]Steady Shot;Arcane Shot\n/use [mod]Skoller's Bag of Squirrel Treats\n/cleartarget [dead]\n/targetenemy [noexists]")
				override = "Hunter's Mark"
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use [nocombat,noexists]Pandaren Scarecrow;"..override.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				if b("Bestial Wrath") == "Bestial Wrath" then overrideModAlt = "[mod]Bestial Wrath;"
				elseif b("Trueshot") == "Trueshot" then overrideModAlt = "[mod]Trueshot;"
				elseif b("Coordinated Assault") == "Coordinated Assault" then overrideModAlt = "[mod]Coordinated Assault;"
				end
				if b("Carve") == "Carve" then override = "Carve"
				elseif b("Butchery") == "Butchery" then override = "Butchery"
				elseif b("Multi-Shot") == "Multi-Shot" then override = "[@mouseover,harm,nodead][]Multi-Shot"
				end
				EditMacro("WSxGen6",nil,nil,"/use "..overrideModAlt.."[nocombat,noexists]Twiddle Twirler: Sentinel's Glaive;"..override.."\n/startattack\n/equipset [noequipped:Two-Hand,spec:3]Menkify!")
				
				if b("Steel Trap") == "Steel Trap" then overrideModAlt = "[@player]Steel Trap"
				elseif b("Aspect of the Wild") == "Aspect of the Wild" then overrideModAlt = "Aspect of the Wild"
				elseif b("Aspect of the Eagle") == "Aspect of the Eagle" then overrideModAlt = "Aspect of the Eagle"
				elseif b("Stampede") == "Stampede" then overrideModAlt = "Stampede"
				elseif b("Death Chakram") == "Death Chakram" then overrideModAlt = "Death Chakram"
				elseif b("A Murder of Crows") == "A Murder of Crows" then overrideModAlt = "A Murder of Crows"
				elseif b("Bloodshed") == "Bloodshed" then overrideModAlt = "Bloodshed"
				elseif b("Rapid Fire") == "Rapid Fire" then overrideModAlt = "Rapid Fire"
				elseif b("Carve") == "Carve" then overrideModAlt = "Carve"
				elseif b("Butchery") == "Butchery" then overrideModAlt = "Butchery"
				end
				EditMacro("WSxSGen+6",nil,nil,"#show\n/use [nocombat,noexists]Laser Pointer\n/use "..override)
				overrideModAlt = ""
				if b("Volley") == "Volley" then overrideModAlt = "[mod:shift,@player]Volley;"
				end
				if b("Aspect of the Wild") == "Aspect of the Wild" then override = "Aspect of the Wild"
				elseif b("Aspect of the Eagle") == "Aspect of the Eagle" then override = "Aspect of the Eagle"
				elseif b("Barrage") == "Barrage" then override = "Barrage"
				elseif b("Explosive Shot") == "Explosive Shot" then override = "Explosive Shot"
				elseif b("Stampede") == "Stampede" then override = "Stampede"
				elseif b("Death Chakram") == "Death Chakram" then override = "Death Chakram"
				elseif b("Rapid Fire") == "Rapid Fire" then override = "Rapid Fire"				
				end
				EditMacro("WSxGen7",nil,nil,"/use "..overrideModAlt..override.."\n/use [nochanneling]Champion's Salute\n/use [nochanneling]Words of Akunda\n/use [nochanneling]Chasing Storm")
				if b("Aspect of the Eagle") == "Aspect of the Eagle" then override = "Aspect of the Eagle"
				elseif b("Volley") == "Volley" then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Volley"
				elseif b("Wailing Arrow") == "Wailing Arrow" then override = "Wailing Arrow"
				elseif b("Stampede") == "Stampede" then override = "Stampede"
				elseif b("Death Chakram") == "Death Chakram" then override = "Death Chakram"
				end
				overrideModAlt = ""
				if b("Salvo") == "Salvo" then overrideModAlt = "Salvo\n/use "
				end
				EditMacro("WSxGen8",nil,nil,"#show "..override.."\n/stopspelltarget\n/use "..overrideModAlt..override)
				if b("Sentinel Owl") == "Sentinel Owl" then override = ";Sentinel Owl"
				elseif b("Aspect of the Wild") == "Aspect of the Wild" then override = ";Aspect of the Wild"
				elseif b("Kill Command") == "Kill Command" then override = ";Kill Command"
				else override = ";Hunter's Call"
				end
				EditMacro("WSxGen9",nil,nil,"#show\n/use [mod:shift]Command Pet"..override)
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Misdirection")
				EditMacro("WSxCSGen+3",nil,nil,"/use [mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]Misdirection;[nocombat,noharm]Cranky Crab")
				EditMacro("WSxCSGen+4",nil,nil,"/use [nospec:3,nomounted]Safari Hat;[nomounted]Gnomish X-Ray Specs\n/run ZigiHunterTrack(not IsAltKeyDown())")
				EditMacro("WSxCSGen+5",nil,nil,"/run local c,arr = C_Minimap,{12,11,10,9,8,6,5,4,7,1} for _,v in pairs(arr) do local name, _, active = c.GetTrackingInfo(v) if (name and active ~= true) then active = true c.SetTracking(v,true) return active end end\n/use Overtuned Corgi Goggles")
				EditMacro("WSxGenQ",nil,nil,"/use [mod:alt,@player]Freezing Trap;[mod:shift]!Aspect of the Turtle;[nocombat,noexists]The Golden Banana;"..b("Muzzle","[@mouseover,harm,nodead][]","")..b("Counter Shot","[@mouseover,harm,nodead][]","").."\n/use Angler's Fishing Spear")
				if b("Bestial Wrath") == "Bestial Wrath" then override = "Bestial Wrath"
				elseif b("Trueshot") == "Trueshot" then override = "Trueshot"
				elseif b("Coordinated Assault") == "Coordinated Assault" then override = "Coordinated Assault"
				else override = "Hunter's Call"
				end
				EditMacro("WSkillbomb",nil,nil,"#show\n/use "..override.."\n/use Will of Northrend"..dpsRacials.."\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Pendant of the Scarab Storm\n/use Big Red Raygun\n/use Echoes of Rezan")
				if b("Bursting Shot") == "Bursting Shot" then override = "Bursting Shot;"
				elseif b("Harpoon") == "Harpoon" then override = "[@mouseover,harm,nodead][harm,nodead]Harpoon;"
				elseif b("Intimidation") == "Intimidation" then override = "[@mouseover,harm,nodead][harm,nodead]Intimidation;"
				elseif b("Binding Shot") == "Binding Shot" then override = "[@mouseover,exists,nodead][@cursor]Binding Shot;"
				elseif b("Kill Command") == "Kill Command" then override = "[@mouseover,exists,nodead][@cursor]Kill Command;"	
				end
				EditMacro("WSxGenE",nil,nil,"/targetenemy [noharm]\n/stopspelltarget\n/use [mod:alt,@mouseover,exists,nodead][mod:alt,@cursor]Flare;"..override.."[nocombat]Party Totem\n/cleartarget [dead]\n/equipset [noequipped:Two-Hand,spec:3,nomod]Menkify!")
				override = ""
				if b("Binding Shot") == "Binding Shot" then override = "[mod:alt,@player]Binding Shot;"
				elseif b("Scatter Shot") == "Scatter Shot" then override = "[mod:alt,@focus,harm,nodead]Scatter Shot;"
				end
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..override..b("Misdirection","[@mouseover,help,nodead][help,nodead][@focus,help,nodead][pet,@pet]","")..oOtas..covToys)
				if b("Binding Shot") == "Binding Shot" then override = "[@mouseover,exists,nodead][@cursor]Binding Shot"
				elseif b("Scatter Shot") == "Scatter Shot" then override = "Scatter Shot"
				else override = "[@player]Flare"
				end
				EditMacro("WSxSGen+E",nil,nil,"/stopspelltarget\n/use "..b("Tar Trap","[mod:alt,@player]",";")..override.."\n/use [nocombat,noexists]Goblin Fishing Bomb\n/use Bloodmane Charm")
				EditMacro("WSxGenT",nil,nil,"#show Feign Death\n/use [@mouseover,harm,nodead][harm,nodead]Hunter's Mark;Hunter's Call\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]\n/petattack [@mouseover,harm,nodead][harm,nodead]")
				override = ""
				if b("Intimidation") == "Intimidation" then override = "[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Intimidation"
				elseif b("High Explosive Trap") == "High Explosive Trap" then override = "[mod:alt,@player][@mouseover,exists,nodead][@cursor]High Explosive Trap"
				elseif b("Fetch") == "Fetch" then override = "Fetch"
				else override = "Hunter's Call"
				end
				EditMacro("WSxSGen+T",nil,nil,"/stopspelltarget\n/use "..override)
			    EditMacro("WSxCGen+T",nil,nil,"/stopspelltarget\n/use "..b("Sentinel Owl","[mod:alt,@player][@mouseover,exists,nodead][@cursor]",";").."\n/use Everlasting Darkmoon Firework\n/use Pandaren Firework Launcher\n/use Azerite Firework Launcher\n/use "..factionFireworks)
			    if b("Binding Shot") == "Binding Shot" then override = "Binding Shot"
				elseif b("Scatter Shot") == "Scatter Shot" then override = "Scatter Shot"
				end
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..override)
				if b("Muzzle") == "Muzzle" then override = "[@focus,harm,nodead]Muzzle;"
				elseif b("Counter Shot") == "Counter Shot" then override = "[@focus,harm,nodead]Counter Shot;"
				end
				EditMacro("WSxGenF",nil,nil,"#show "..b("Tar Trap").."\n/focus [@mouseover,exists]mouseover\n/stopmacro [@mouseover,exists]\n/use [@cursor,mod,known:Eagle Eye]!Eagle Eye;"..override.."[@mouseover,harm,nodead][]Hunter's Mark\n/targetenemy [noharm][dead]")
				EditMacro("WSxSGen+F",nil,nil,"#show Freezing Trap\n/targetenemy [noexists]Robo-Gnomebulator\n/use [nocombat,noexists]Gastropod Shell\n/use \n/stopmacro [mod:ctrl]\n/petautocasttoggle Growl\n/petautocasttoggle [mod:alt]Spirit Walk")
				EditMacro("WSxCGen+F",nil,nil,"#show Flare\n/run for i = 4,12 do C_Minimap.SetTracking(i,false) end C_Minimap.SetTracking(1,false);\n/cancelaura [nospec:3]Safari Hat;X-Ray Specs\n/cancelaura Will of the Taunka\n/cancelaura Will of the Vrykul\n/cancelaura Will of the Iron Dwarves")
				EditMacro("WSxCAGen+F",nil,nil,"#show Exhilaration\n/run if not InCombatLockdown() then if GetSpellCooldown(5384)==0 then "..tpPants.." else "..noPants.." end end")
				if b("Tranquilizing Shot") == "Tranquilizing Shot" then override = "[@mouseover,harm,nodead][]Tranquilizing Shot"
				elseif b("Eyes of the Beast") == "Eyes of the Beast" then override = "Eyes of the Beast"
				else override = "Hunter's Call"
				end
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..override.."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use Feign Death")
			    if b("Camouflage") == "Camouflage" then override = "Camouflage"
				elseif b("Scare Beast") == "Scare Beast" then override = "Scare Beast"
				end
				EditMacro("WSxCSGen+G",nil,nil,"#show "..override.."\n/cancelaura Whole-Body Shrinka'\n/cancelaura Growing Pains\n/cancelaura Aspect of the Turtle\n/use Choofa's Call\n/cancelaura Chasing Storm\n/cancelaura Enthralling\n/cancelaura Words of Akunda")
			    if b("Survival of the Fittest") == "Survival of the Fittest" then override = "[nomod]Survival of the Fittest"
				else override = "[nomod]Feign Death"
				end
				EditMacro("WSxGenZ",nil,nil,"#show [mod,pet,@pet,nodead]Play Dead;[mod]Revive Pet;"..override.."\n/use [mod:alt]Gateway Control Shard;[mod,pet,@pet,nodead]Play Dead;[mod]Revive Pet;Personal Hologram\n/use "..override)
				EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt,exists]Beast Lore;[mod:ctrl,exists,nodead]Tame Beast;[mod]Aspect of the Cheetah;!Aspect of the Turtle\n/use Super Simian Sphere\n/use Angry Beehive\n/use Xan'tish's Flute")
				EditMacro("WSxGenC",nil,nil,"/target [@pet,pet:Crab]\n/stopspelltarget\n/use [mod,@mouseover,exists,nodead][mod,@cursor]Freezing Trap;[nopet]Call Pet 3;[pet:Crab,help,pet,nocombat]Crab Shank;[pet,nodead]Mend Pet\n/use Totem of Spirits\n/targetlasttarget [help,nodead,pet,pet:Crab]")
				EditMacro("WSxAGen+C",nil,nil,"#show [mod]Hunter's Mark;Play Dead\n/use [mod:ctrl,@player]Freezing Trap;Dismiss Pet\n/stopmacro [mod:ctrl]\n/click TotemFrameTotem1 RightButton\n/use Crashin' Thrashin' Robot")
				EditMacro("WSxGenV",nil,nil,"#show\n/use Disengage\n/stopcasting\n/use Crashin' Thrashin' Robot\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Ruthers' Harness\n/use Bom'bay's Color-Seein' Sauce\n/use Prismatic Bauble\n/use Desert Flute")
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@mouseover,harm,nodead][harm,nodead]Scare Beast;[nopet]Call Pet 1;[swimming]Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")
				EditMacro("WSxCAGen+B",nil,nil,"")
				EditMacro("WSxCAGen+N",nil,nil,"")	
			-- Rogue, rogge, rouge, raxicil
			elseif class == "ROGUE" then
				if b("Echoing Reprimand") == "Echoing Reprimand" then override = "Echoing Reprimand"
				elseif b("Pistol Shot") == "Pistol Shot" then override = "Pistol Shot"
				elseif b("Thistle Tea") == "Thistle Tea" then override = "Thistle Tea"
				end
				EditMacro("WSxGen1",nil,nil,"/use [nocombat,nostealth]Xan'tish's Flute\n/use "..b("Tricks of the Trade","[@mouseover,help,nodead][help,nodead]",";").."[stance:0,nocombat]Stealth;"..override.."\n/targetenemy [noexists]\n/startattack [combat]")
				EditMacro("WSxSGen+1",nil,nil,"#show Vanish\n/use "..b("Shadowstep","[mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][]",";")..b("Tricks of the Trade","[]","").."\n/targetexact Lucian Trias")
				EditMacro("WSxGen2",nil,nil,"/targetenemy [noexists]\n/use [stealth,nostance:3,nodead]Pick Pocket;Sinister Strike\n/use !Stealth\n/cleartarget [exists,dead]\n/stopspelltarget")
				if b("Shuriken Tornado") == "Shuriken Tornado" then override = "Shuriken Tornado"
				end
				EditMacro("WSxSGen+2",nil,nil,"#show "..override.."\n/cast Crimson Vial\n/use [nostealth] Totem of Spirits\n/use [nostealth]Hourglass of Eternity\n/use [nocombat,nostealth,spec:2]Don Carlos' Famous Hat;[nocombat,nostealth]Dark Ranger's Spare Cowl")
				EditMacro("WSxGen3",nil,nil,"/use [stance:0,nocombat]Stealth;"..b("Shadow Dance","[spec:3,harm,nodead]Symbols of Death\n/use [stance:0,combat]",";[@mouseover,harm,nodead][]Ambush;")..b("Kingsbane","[]",";").."[spec:2]Between the Eyes;[spec:1]Shiv\n/targetenemy [noexists]")
				EditMacro("WSxSGen+3",nil,nil,"#show\n/use [@mouseover,harm,nodead,nospec:2][nospec:2]Rupture;[spec:2]Between the Eyes\n/targetenemy [noexists]\n/use [spec:2,nocombat]Ghostly Iron Buccaneer's Hat;[nospec:2]Ravenbear Disguise")
				EditMacro("WSxGen4",nil,nil,"/use [nocombat,noexists,spec:2,nostealth]Dead Ringer\n/use [spec:1]Shiv;"..b("Ghostly Strike","[]",";").."[@mouseover,harm,nodead][]Ambush\n/use !Stealth\n/targetenemy [noexists]\n/cleartarget [dead]")
				if b("Garrote") == "Garrote" then override = "[@mouseover,harm,nodead][]Garrote"
				elseif b("Cold Blood") == "Cold Blood" then override = "Cold Blood"
				elseif b("Between the Eyes") == "Between the Eyes" then override = "Between the Eyes"
				elseif b("Pistol Shot") == "Pistol Shot" then override = "Pistol Shot"
				else override = "Feint"
				end
				EditMacro("WSxSGen+4",nil,nil,"/use [nocombat,noexists,nostealth]Barrel of Eyepatches\n/use "..override.."\n/use [nostealth,nospec:2]Hozen Beach Ball;[nostealth]Titanium Seal of Dalaran\n/targetenemy [noexists]\n/startattack [combat]\n/cleartarget [dead]")
				if b("Killing Spree") == "Killing Spree" then override = "Killing Spree"
				elseif b("Dreadblades") == "Dreadblades" then override = "Dreadblades"
				elseif b("Keep It Rolling") == "Keep It Rolling" then override = "Keep It Rolling"
				elseif b("Goremaw's Bite") == "Goremaw's Bite" then override = "Goremaw's Bite"
				elseif b("Shuriken Tornado") == "Shuriken Tornado" then override = "Shuriken Tornado"
				elseif b("Kingsbane") == "Kingsbane" then override = "Kingsbane"
				elseif b("Cold Blood") == "Cold Blood" then override = "Cold Blood"
				elseif b("Thistle Tea") == "Thistle Tea" then override = "Thistle Tea"
				elseif b("Deathmark") == "Deathmark" then override = "Deathmark"
				elseif b("Adrenaline Rush") == "Adrenaline Rush" then override = "Adrenaline Rush"
				elseif b("Shadow Blades") == "Shadow Blades" then override = "Shadow Blades"
				end
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..override.."\n/targetenemy [noexists,nocombat]\n/use [nocombat,noexists]Gastropod Shell")
				EditMacro("WSxGen5",nil,nil,"#show\n/use [combat,mod:ctrl]Vanish;Eviscerate\n/use !Stealth\n/targetenemy [noexists]\n/stopmacro [nomod:ctrl]\n/use [spec:2]Mr. Smite's Brass Compass;Shadescale\n/roar")
				EditMacro("WSxSGen+5",nil,nil,"/use [nocombat,noexists,nostealth]Barrel of Bandanas\n/use Slice and Dice\n/use [nocombat,noexists,nostealth] Worn Troll Dice")					
				if b("Deathmark") == "Deathmark" then overrideModAlt = "[mod:ctrl]Deathmark;"
				elseif b("Adrenaline Rush") == "Adrenaline Rush" then overrideModAlt = "[mod:ctrl]Adrenaline Rush;"
				elseif b("Shadow Blades") == "Shadow Blades" then overrideModAlt = "[mod:ctrl]Shadow Blades;"
				end
				if b("Fan of Knives") == "Fan of Knives" then override = "Fan of Knives"
				elseif b("Blade Flurry") == "Blade Flurry" then override = "Blade Flurry"
				elseif b("Shuriken Storm") == "Shuriken Storm" then override = "Shuriken Storm"
				end
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..overrideModAlt..override)
				if b("Crimson Tempest") == "Crimson Tempest" then override = "Crimson Tempest"
				elseif b("Secret Technique") == "Secret Technique" then override = "Secret Technique"
				elseif b("Shuriken Tornado") == "Shuriken Tornado" then override = "Shuriken Tornado"
				elseif b("Black Powder") == "Black Powder" then override = "Black Powder"
				elseif b("Roll the Bones") == "Roll the Bones" then override = "Roll the Bones"
				elseif b("Blade Flurry") == "Blade Flurry" then override = "Blade Flurry"
				end
				EditMacro("WSxSGen+6",nil,nil,"/use "..override.."\n/stopmacro\n/use Vanish")
				if b("Shuriken Tornado") == "Shuriken Tornado" then overrideModAlt = "[mod:shift]Shuriken Tornado;"
				elseif b("Keep It Rolling") == "Keep It Rolling" then overrideModAlt = "[mod:shift]Keep It Rolling;"
				end
				if b("Black Powder") == "Black Powder" then override = "Black Powder"
				elseif b("Blade Rush") == "Blade Rush" then override = "Blade Rush"
				elseif b("Ghostly Strike") == "Ghostly Strike" then override = "Ghostly Strike"
				elseif b("Pistol Shot") == "Pistol Shot" then override = "Pistol Shot"
				elseif b("Thistle Tea") == "Thistle Tea" then override = "Thistle Tea"
				elseif b("Cold Blood") == "Cold Blood" then override = "Cold Blood"
				end
				EditMacro("WSxGen7",nil,nil,"#show\n/use [nocombat,help]Corbyn's Beacon;"..overrideModAlt..override.."\n/use Autographed Hearthstone Card\n/use !Stealth")
				if b("Exsanguinate") == "Exsanguinate" then override = "Exsanguinate"
				elseif b("Sepsis") == "Sepsis" then override = "Sepsis"
				elseif b("Ghostly Strike") == "Ghostly Strike" then override = "Ghostly Strike"
				elseif b("Shuriken Tornado") == "Shuriken Tornado" then override = "Shuriken Tornado"
				elseif b("Cold Blood") == "Cold Blood" then override = "Cold Blood"
				elseif b("Thistle Tea") == "Thistle Tea" then override = "Thistle Tea"
				else override = "Sprint"
				end
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..override)
				if b("Flagellation") == "Flagellation" then override = "Flagellation"
				elseif b("Serrated Bone Spike") == "Serrated Bone Spike" then override = "Serrated Bone Spike"
				elseif b("Keep It Rolling") == "Keep It Rolling" then override = "Keep It Rolling"
				elseif b("Sepsis") == "Sepsis" then override = "Sepsis"
				elseif b("Ghostly Strike") == "Ghostly Strike" then override = "Ghostly Strike"
				elseif b("Shadow Dance") == "Shadow Dance" then override = "Shadow Dance"
				elseif b("Numbing Poison") == "Numbing Poison" then override = "Numbing Poison"
				elseif b("Echoing Reprimand") == "Echoing Reprimand" then override = "Echoing Reprimand"
				else override = "Evasion"
				end
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..override)
				EditMacro("WSxCSGen+2",nil,nil,"/use [@party1,help,nodead][@targettarget,help,nodead]Tricks of the Trade")
				EditMacro("WSxCSGen+3",nil,nil,"/use [@party2,help,nodead]Tricks of the Trade")
				EditMacro("WSxCSGen+4",nil,nil,"/use [mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead]Tricks of the Trade;[nocombat,noexists]Crashin' Thrashin' Cannon Controller")
				EditMacro("WSxCSGen+5",nil,nil,"/use [mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]Tricks of the Trade")
				EditMacro("WSxGenQ",nil,nil,"#show\n/use "..b("Blind","[mod:alt,@focus,harm,nodead]",";")..b("Cloak of Shadows","[mod:shift]",";").."[@mouseover,harm,nodead][harm,nodead]Kick;The Golden Banana\n/use [spec:2]Rime of the Time-Lost Mariner;Sira's Extra Cloak\n/use Poison Extraction Totem")
				if b("Deathmark") == "Deathmark" then override = "Deathmark"
				elseif b("Adrenaline Rush") == "Adrenaline Rush" then override = "Adrenaline Rush"
				elseif b("Shadow Blades") == "Shadow Blades" then override = "Shadow Blades"
				end
				EditMacro("WSkillbomb",nil,nil,"/use "..override.."\n/stopmacro [stealth]\n/use Will of Northrend"..dpsRacials.."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13"..hasHE.."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
				EditMacro("WSxGenE",nil,nil,"/use "..b("Cheap Shot","[mod:alt,@focus,harm,nodead,nostance:0][nostance:0]",";")..b("Shadow Dance","[stance:0,combat]",";")..b("Vanish","[stance:0,combat]",";").."\n/use !Stealth\n/use [nostealth,spec:2,nocombat]Iron Buccaneer's Hat")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..b("Tricks of the Trade","[@focus,help,nodead][@mouseover,help,nodead][help,nodead][@party1,help,nodead]","").."\n/use Seafarer's Slidewhistle"..oOtas..covToys)
				if b("Garrote") == "Garrote" then override = "[mod:alt,@focus,harm,nodead,nostance:0][nostance:0]Garrote;"
				elseif b("Cheap Shot") == "Cheap Shot" then override = "[mod:alt,@focus,harm,nodead,nostance:0][nostance:0]Cheap Shot;"
				end
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..override..b("Shadow Dance","[stance:0,combat]",";")..b("Vanish","[stance:0,combat]","").."\n/use !Stealth\n/use [nostealth]Hourglass of Eternity")
				if b("Poisoned Knife") == "Poisoned Knife" then override = "[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]Poisoned Knife;"
				elseif b("Pistol Shot") == "Pistol Shot" then override = "[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]Pistol Shot;"
				elseif b("Shuriken Toss") == "Shuriken Toss" then override = "[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]Shuriken Toss;"
				end
				EditMacro("WSxGenR",nil,nil,"/stopspelltarget\n/use [@mouseover,exists,nodead,mod:ctrl][@cursor,mod:ctrl]Distract;"..override..b("Shadowstep","[@mouseover,help,nodead][help,nodead]",";").."Horse Head Costume\n/targetenemy [noexists]")
				EditMacro("WSxGenT",nil,nil,"/use "..b("Gouge","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";").."[help,nocombat]Swapblaster\n/stopattack\n/targetenemy [noexists]\n/cleartarget [dead]\n/stopspelltarget\n/use !Stealth")
				if b("Tricks of the Trade") == "Tricks of the Trade" then override = "Tricks of the Trade"
				elseif b("Shadowstep") == "Shadowstep" then override = "Shadowstep"
				end
				EditMacro("WSxSGen+T",nil,nil,"#show "..override.."\n/stopspelltarget\n/use Titanium Seal of Dalaran\n/use [@mouseover,exists,nodead][@cursor]Grappling Hook\n/targetenemy [noexists]")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/stopspelltarget\n/use "..b("Grappling Hook","[@mouseover,exists,nodead][@cursor]",";").."[mod:alt,@player][@mouseover,exists,nodead][@cursor]Distract")
				EditMacro("WSxGenU",nil,nil,"#show\n/use Sprint")
				EditMacro("WSxGenF",nil,nil,"#show\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Kick;[exists,nodead,spec:1]Detoxified Blight Grenade;Detection")
				if b("Grappling Hook") == "Grappling Hook" then override = "Grappling Hook"
				elseif b("Gouge") == "Gouge" then override = "Gouge"
				else override = "Kick"
				end
				EditMacro("WSxSGen+F",nil,nil,"#show "..override.."\n/use "..b("Shadowstep","[@focus,harm,nodead]","\n/use [@focus,harm,nodead]Kick\n/use [@cursor]Grappling Hook"))
				if b("Garrote") == "Garrote" then override = "[nostance:0]Garrote;"
				elseif b("Cheap Shot") == "Cheap Shot" then override = "[nostance:0]Cheap Shot;"
				end
				EditMacro("WSxCGen+F",nil,nil,"#show "..b("Cloak of Shadows","[]","").."\n/use "..override..b("Vanish","[stance:0,combat]",";").."\n/use !Stealth")
				EditMacro("WSxCAGen+F",nil,nil,"#show [nocombat,noexists,resting]Twelve-String Guitar;Distract\n/targetfriend [nohelp,nodead]\n/use [help,nodead]Shadowstep;[nocombat,noexists]Twelve-String Guitar\n/targetlasttarget")
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt,nocombat,noexists]Darkmoon Gazer;[@mouseover,harm,nodead][harm,nodead]Shiv;Pick Lock")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/targetenemy [noexists]\n/use [stance:0,nocombat]Stealth;[mod:alt,@focus,exists,nodead][]Kidney Shot\n/use [nocombat,noexists,stance:0]Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..b("Cheap Shot","[mod:alt,@focus,harm,nodead,nostance:0][nostance:0]",";")..b("Vanish","[stance:0,combat]",";").."\n/use !Stealth")
				EditMacro("WSxCSGen+G",nil,nil,"#show Blind\n/use Totem of Spirits\n/use [@focus,harm,nodead]Gouge")	
				EditMacro("WSxGenH",nil,nil,"#show\n/use Crimson Vial\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				if b("Deadly Poison") == "Deadly Poison" then overrideModAlt = "[mod]Deadly Poison;"
				elseif b("Instant Poison") == "Instant Poison" then overrideModAlt = "[mod]Instant Poison;"
				end
				EditMacro("WSxGenZ",nil,nil,"/use "..b("Wound Poison","[mod:alt]",";")..overrideModAlt..b("Evasion","[combat]",";").."[stance:1]Shroud of Concealment\n/use !Stealth\n/use [mod:alt]Gateway Control Shard\n/use [spec:2,mod]Slightly-Chewed Insult Book;[mod]Shadowy Disguise")
				EditMacro("WSxGenX",nil,nil,"/use [mod:alt]Crippling Poison;[mod:ctrl]Scroll of Teleport: Ravenholdt;[mod:shift]Sprint;"..b("Feint","[]","").."\n/use [nostealth,mod:shift]Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
				EditMacro("WSxGenC",nil,nil,"#show\n/targetenemy [noexists]\n/use "..b("Blind","[mod:ctrl,@mouseover,harm,nodead][mod:ctrl]",";")..b("Amplifying Poison","[mod:shift]",";").."[@mouseover,harm,nodead,nostance:0][nostance:0]Sap;Blind\n/use !Stealth\n/cancelaura Don Carlos' Famous Hat")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use "..b("Numbing Poison","[]",";")..b("Atrophic Poison","[]","").."\n/run PetDismiss();")
				if b("Shadowstep") == "Shadowstep" then override = "[@mouseover,exists,nodead][]Shadowstep"
				elseif b("Grappling Hook") == "Grappling Hook" then override = "[@cursor]Grappling Hook"
				end
				EditMacro("WSxGenV",nil,nil,"/use "..override.."\n/targetenemy [noexists]\n/use [nostealth]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use [nostealth]Prismatic Bauble")
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem;Survivor's Bag of Coins\n/use [mod:alt]Weathered Purple Parasol")	
			-- Priest, Prist
			elseif class == "PRIEST" then
				if playerSpec == 2 and b("Mind Blast") == "Mind Blast" then override = "[@mouseover,harm,nodead][harm,nodead]Mind Blast"
				elseif b("Schism") == "Schism" then override = "[@mouseover,harm,nodead][harm,nodead]Schism"
				elseif b("Void Torrent") == "Void Torrent" then override = "[@mouseover,harm,nodead][harm,nodead]Void Torrent"
				else override = "[@mouseover,harm,nodead][harm,nodead]Shadow Word: Pain"
				end
				EditMacro("WSxGen1",nil,nil,"/use [help,nodead,nocombat]The Heartbreaker;"..b("Power Infusion","[@mouseover,help,nodead][help,nodead]",";")..override.."\n/startattack\n/use Xan'tish's Flute")
				if b("Power Infusion") == "Power Infusion" then override = "Power Infusion"
				else override = "Shadow Word: Pain"
				end
				EditMacro("WSxSGen+1",nil,nil,"#show "..override.."\n/use [mod:alt,@party3,nodead][mod:ctrl,@party2,exists][@focus,help][@party1,exists][@targettarget,exists]Flash Heal;Kaldorei Light Globe")
				EditMacro("WSxGen2",nil,nil,"/cancelaura Fling Rings\n/use [nospec:3,help,nodead,nocombat]Holy Lightsphere;[help,nodead,nocombat]Corbyn's Beacon\n/use "..b("Power Word: Life","[@mouseover,help,nodead][help,nodead]",";").."[@mouseover,harm,nodead][]Smite\n/use [nocombat]Darkmoon Ring-Flinger\n/use Haunting Memento\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use [mod:alt,@party4,nodead][@mouseover,help,nodead][]Flash Heal\n/use [nocombat,noexists,resting]Gnomish X-Ray Specs\n/cancelaura Don Carlos' Famous Hat\n/cancelaura X-Ray Specs")
				EditMacro("WSxGen3",nil,nil,"/targetenemy [noexists]\n/cleartarget [dead]\n/use "..b("Shadow Word: Death","[@mouseover,harm,nodead][harm,nodead]",";")..b("Power Word: Life","[@mouseover,help,nodead,combat][help,nodead,combat]","").."\n/use Scarlet Confessional Book\n/use [nocombat,noexists,spec:3]Twitching Eyeball")
				EditMacro("WSxSGen+3",nil,nil,"/targetenemy [noexists]\n/stopspelltarget\n/cleartarget [dead]\n/use "..b("Shadow Word: Pain","[@mouseover,harm,nodead,nomod:alt][nomod:alt]","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Shadow Word: Pain\n/targetlasttarget").."\n/use Totem of Spirits")
				if b("Penance") == "Penance" then override = "[@mouseover,exists,nodead][]Penance"
				elseif b("Holy Word: Serenity") == "Holy Word: Serenity" then override = "[@mouseover,help,nodead][]Holy Word: Serenity"
				elseif b("Mind Blast") == "Mind Blast" then override = "Mind Blast"
				end
				EditMacro("WSxGen4",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,noexists,nochanneling]Pretty Draenor Pearl\n/use "..override)	
				if b("Penance") == "Penance" then overrideModAlt = "[@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Penance;"
				elseif b("Prayer of Mending") == "Prayer of Mending" then overrideModAlt = "[@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Prayer of Mending;"
				end
				if playerSpec ~= 3 and b("Divine Star") == "Divine Star" then override = "Divine Star"
				elseif playerSpec ~= 3 and b("Halo") == "Halo" then override = "Halo"
				elseif b("Prayer of Healing") == "Prayer of Healing" then override = "[@mouseover,help,nodead][]Prayer of Healing"
				elseif b("Vampiric Touch") == "Vampiric Touch" then override = "[@mouseover,harm,nodead,nomod:alt][nomod:alt]Vampiric Touch\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Vampiric Touch\n/targetlasttarget"
				elseif b("Mindgames") == "Mindgames" then override = "Mindgames"
				end
				EditMacro("WSxSGen+4",nil,nil,"/stopspelltarget\n/targetenemy [noexists]\n/use "..overrideModAlt..b("Shadowform","[noform]",";")..override)
				if b("Penance") == "Penance" then overrideModAlt = "[mod:alt,@party3,help,nodead]Penance;"
				end
				if b("Ultimate Penitence") == "Ultimate Penitence" then override = "[@mouseover,help,nodead][]Ultimate Penitence"
				elseif b("Rapture") == "Rapture" then override = "Rapture"
				elseif b("Lightwell") == "Lightwell" then override = "[@cursor]Lightwell"
				elseif b("Divine Word") == "Divine Word" then override = "Divine Word"
				elseif b("Apotheosis") == "Apotheosis" then override = "Apotheosis"
				elseif b("Holy Word: Salvation") == "Holy Word: Salvation" then override = "Holy Word: Salvation"
				elseif b("Dark Void") == "Dark Void" then override = "Dark Void"
				elseif b("Void Torrent") == "Void Torrent" then override = "Void Torrent"
				elseif b("Mindgames") == "Mindgames" then override = "Mindgames"
				elseif b("Power Infusion") == "Power Infusion" then override = "Power Infusion"
				elseif b("Empyreal Blaze") == "Empyreal Blaze" then override = "Empyreal Blaze"
				end
				EditMacro("WSxCGen+4",nil,nil,"#show\n/cast "..overrideModAlt..override.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				if b("Power Word: Barrier") == "Power Word: Barrier" then overrideModAlt = "[mod:ctrl,@cursor]Power Word: Barrier;"
				elseif b("Symbol of Hope") == "Symbol of Hope" then overrideModAlt = "[mod:ctrl]Symbol of Hope;"
				elseif b("Desperate Prayer") == "Desperate Prayer" then overrideModAlt = "[mod:ctrl]Desperate Prayer;"
				end
				if b("Void Eruption") == "Void Eruption" then override = "[@mouseover,harm,nodead][]Void Eruption"
				elseif b("Dark Ascension") == "Dark Ascension" then override = "Dark Ascension"
				elseif b("Heal") == "Heal" then override = "[@mouseover,help,nodead][]Heal"
				elseif b("Mind Blast") == "Mind Blast" then override = "[@mouseover,harm,nodead][]Mind Blast"	
				end
				EditMacro("WSxGen5",nil,nil,"/use "..overrideModAlt..override.."\n/use [help,nodead]Apexis Focusing Shard\n/targetenemy [noexists]\n/use [nocombat]Thaumaturgist's Orb\n/use [spec:3]Shadescale")
				if b("Devouring Plague") == "Devouring Plague" then override = "[@mouseover,harm,nodead,nomod:alt][harm,nodead,nomod:alt]Devouring Plague\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Devouring Plague\n/targetlasttarget"
				elseif b("Penance") == "Penance" then override = "[@party2,help,nodead,mod:alt][@player]Penance"
				elseif b("Prayer of Mending") == "Prayer of Mending" then override = "[@party2,help,nodead,mod:alt][@player]Prayer of Mending"
				elseif b("Circle of Healing") == "Circle of Healing" then override = "[@mouseover,help,nodead][]Circle of Healing"
				end
				EditMacro("WSxSGen+5",nil,nil,"/use "..override.."\n/targetenemy [noharm]\n/cleartarget [dead]")
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use "..b("Penance","[mod:ctrl,@party4,help,nodead]",";").."[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14\n/use Eternal Black Diamond Ring")
				if b("Divine Hymn") == "Divine Hymn" then overrideModAlt = "[mod:ctrl]Divine Hymn;"
				elseif b("Shadowfiend") == "Shadowfiend" then overrideModAlt = "[mod:ctrl]Shadowfiend;"
				end
				if b("Holy Nova") == "Holy Nova" then override = "Holy Nova"
				elseif b("Divine Star") == "Divine Star" then override = "Divine Star"
				elseif b("Halo") == "Halo" then override = "Halo"
				else override = "Shadow Word: Pain"
				end
				EditMacro("WSxGen6",nil,nil,"#show\n/stopspelltarget\n/use "..overrideModAlt..override.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				if b("Prayer of Healing") == "Prayer of Healing" then override = "[@mouseover,help,nodead][]Prayer of Healing"
				elseif b("Power Word: Radiance") == "Power Word: Radiance" then override = "[@mouseover,help,nodead][]Power Word: Radiance"
				elseif b("Divine Star") == "Divine Star" then override = "Divine Star"
				elseif b("Halo") == "Halo" then override = "Halo"
				end
				EditMacro("WSxSGen+6",nil,nil,"/use "..override.."\n/use Cursed Feather of Ikzan\n/use [nocombat]Dead Ringer\n/targetenemy [noexists]")
				if b("Holy Word: Sanctify") == "Holy Word: Sanctify" then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Holy Word: Sanctify"
				elseif b("Shadow Crash") == "Shadow Crash" then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Shadow Crash"
				elseif b("Empyreal Blaze") == "Empyreal Blaze" then override = "Empyreal Blaze"
				elseif b("Power Word: Life") == "Power Word: Life" then override = "[@mouseover,help,nodead][]Power Word: Life"
				elseif b("Schism") == "Schism" then override = "Schism"
				end
				EditMacro("WSxGen7",nil,nil,"#show\n/stopspelltarget\n/use "..override.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				if b("Evangelism") == "Evangelism" then overrideModAlt = "[mod:shift]Evangelism;"
				elseif b("Lightwell") == "Lightwell" then overrideModAlt = "[@player,mod:shift]Lightwell;"
				elseif b("Power Infusion") == "Power Infusion" then overrideModAlt = "[mod:shift,@focus,help,nodead][mod:shift,@mouseover,help,nodead][mod:shift]Power Infusion;"
				end
				if b("Void Torrent") == "Void Torrent" then override = "Void Torrent"
				elseif b("Rapture") == "Rapture" then override = "Rapture"
				elseif b("Mindgames") == "Mindgames" then override = "[@mouseover,harm,nodead][]Mindgames"
				elseif b("Shadowfiend") == "Shadowfiend" then override = "Shadowfiend"
				end
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..overrideModAlt..override)
				if b("Power Infusion") == "Power Infusion" then overrideModAlt = "[mod:shift,@focus,help,nodead][mod:shift,@mouseover,help,nodead][mod:shift]Power Infusion;"
				end
				if b("Mindgames") == "Mindgames" then override = "[@mouseover,harm,nodead][]Mindgames"
				elseif b("Vampiric Embrace") == "Vampiric Embrace" then override = "Vampiric Embrace"
				elseif b("Evangelism") == "Evangelism" then override = "Evangelism"
				elseif b("Power Word: Barrier") == "Power Word: Barrier" then override = "Power Word: Barrier"
				elseif b("Rapture") == "Rapture" then override = "Rapture"
				elseif b("Shadow Covenant") == "Shadow Covenant" then override = "[@mouseover,help,nodead][]Shadow Covenant"
				elseif b("Empyreal Blaze") == "Empyreal Blaze" then override = "Empyreal Blaze"
				elseif b("Apotheosis") == "Apotheosis" then override = "Apotheosis"
				elseif b("Holy Word: Salvation") == "Holy Word: Salvation" then override = "Holy Word: Salvation"
				elseif b("Void Torrent") == "Void Torrent" then override = "Void Torrent"
				elseif b("Power Infusion") == "Power Infusion" then override = "Power Infusion"
				end
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..overrideModAlt..override)
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead,nospec:3][@party1,help,nodead,nospec:3][@targettarget,help,nodead,nospec:3]Purify;[mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Purify Disease\n/use Brynja's Beacon")
				EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Shadow Word: Pain;[mod:alt,@party4,help,nodead,nospec:3][@party2,help,nodead,nospec:3]Purify;[mod:alt,@party4,help,nodead][@party2,help,nodead]Purify Disease\n/use [nocombat,noharm]Forgotten Feather")
				EditMacro("WSxCSGen+4",nil,nil,"/use [spec:3,@focus,harm,nodead]Vampiric Touch;[mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Power Word: Shield;[nocombat]Romantic Picnic Basket\n/use [@party1]Apexis Focusing Shard")
				EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,spec:3,harm,nodead]Devouring Plague;[mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]Power Word: Shield\n/use Battle Standard of Coordination\n/use [@party2]Apexis Focusing Shard")
				override = ""
				if b("Mind Control") == "Mind Control" then overrideModAlt = "[mod:alt,@focus,harm,nodead]Mind Control;"
				elseif b("Dominate Mind") == "Dominate Mind" then overrideModAlt = "[mod:alt,@focus,harm,nodead]Dominate Mind;"
				end
				if b("Silence") == "Silence" then override = "[@mouseover,harm,nodead][]Silence"
				elseif b("Mind Control") == "Mind Control" then override = "[@mouseover,harm,nodead][]Mind Control"
				elseif b("Dominate Mind") == "Dominate Mind" then override = "[@mouseover,harm,nodead][]Dominate Mind"
				end
				EditMacro("WSxGenQ",nil,nil,"#show\n/use "..overrideModAlt..b("Void Shift","[@mouseover,help,nodead][help,nodead]",";")..override.."\n/use Forgotten Feather")
				EditMacro("WSkillbomb",nil,nil,"/use "..b("Shadowfiend","[]","")..dpsRacials.."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
				if b("Psychic Scream") == "Psychic Scream" then override = "Psychic Scream"
				elseif b("Holy Nova") == "Holy Nova" then override = "Holy Nova"
				end
				EditMacro("WSxGenE",nil,nil,"#show "..override.."\n/stopspelltarget\n/use "..b("Mass Dispel","[mod:alt,@mouseover,exists,nodead][mod:alt,@cursor]",";").."[nomod,nocombat,noexists]Party Totem\n/use [nomod]"..override)
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use Desperate Prayer\n/use [@player]Power Word: Life\n/use A Collection Of Me"..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..b("Mass Dispel","[mod:alt,@player]",";")..b("Psychic Scream","[@mouseover,harm,nodead][]","").."\n/use Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
				if b("Angelic Feather") == "Angelic Feather" then override = "[mod:ctrl,@player][@cursor]Angelic Feather"
				elseif b("Power Word: Shield") == "Power Word: Shield" then override = "[mod:ctrl,@player][@mouseover,help,nodead][]Power Word: Shield"
				end
				EditMacro("WSxGenR",nil,nil,"/use "..b("Void Tendrils","[mod:shift]",";")..override.."\n/stopspelltarget")
				if b("Holy Word: Chastise") == "Holy Word: Chastise" then override = "Holy Word: Chastise"
				elseif b("Psychic Horror") == "Psychic Horror" then override = "Psychic Horror"
				elseif b("Power Word: Barrier") == "Power Word: Barrier" then override = "Power Word: Barrier"
				elseif b("Evangelism") == "Evangelism" then override = "Evangelism"
				end
				EditMacro("WSxGenT",nil,nil,"#show "..override.."\n/use [help,nocombat]Swapblaster\n/stopspelltarget"..b("Mind Soothe","\n/use [@mouseover,exists,nodead][@cursor]",";"))
				overrideModAlt = ""
				if b("Void Tendrils") == "Void Tendrils" then overrideModAlt = "Void Tendrils"
				elseif b("Leap of Faith") == "Leap of Faith" then overrideModAlt = "Leap of Faith"
				end
				if b("Psychic Horror") == "Psychic Horror" then override = "[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]Psychic Horror;"
				elseif b("Holy Word: Chastise") == "Holy Word: Chastise" then override = "[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]Holy Word: Chastise;"
				else override = "[@mouseover,harm,nodead][harm,nodead]Shadow Word: Pain;"
				end
				EditMacro("WSxSGen+T",nil,nil,"#show "..overrideModAlt.."\n/use "..override..b("Leap of Faith","[mod:alt,@focus,help,nodead][@mouseover,help,nodead][help,nodead]",";").."\n/use Shadowy Disguise")
				
				if b("Renew") == "Renew" then override = "[@party4,help,nodead,mod:alt][@focus,help,nodead][@party2,help,nodead]Renew;"
				end
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..override)
				EditMacro("WSxGenU",nil,nil,"#show Desperate Prayer\n/use "..b("Empyreal Blaze","[]",";").."Fade")
				override = ""
				if b("Empyreal Blaze") == "Empyreal Blaze" then override = "Empyreal Blaze"
				elseif b("Shackle Undead") == "Shackle Undead" then override = "Shackle Undead"
				end
				EditMacro("WSxSGen+F",nil,nil,"#show "..override.."\n/use "..b("Shackle Undead","[@focus,harm,nodead]",";").."[help,nocombat,mod:alt]B. F. F. Necklace;[nocombat,noexists,mod:alt]Gastropod Shell;Mind Vision\n/use [nocombat,noexists]Tickle Totem\n/cancelaura [mod:alt]Shadowform")
				if b("Symbol of Hope") == "Symbol of Hope" then overrideModAlt = "Symbol of Hope"
				elseif b("Rapture") == "Rapture" then overrideModAlt = "Rapture"
				elseif b("Psychic Scream") == "Psychic Scream" then overrideModAlt = "Psychic Scream"
				end
				if b("Vampiric Embrace") == "Vampiric Embrace" then override = "Vampiric Embrace"
				elseif b("Rapture") == "Rapture" then override = "Rapture"
				end
				EditMacro("WSxCGen+F",nil,nil,"#show "..override.."\n/use [nocombat,noexists]Piccolo of the Flaming Fire;"..override.."\n/cancelaura Twice-Cursed Arakkoa Feather\n/cancelaura Spirit Shell\n/use Xan'tish's Flute\n/use Leather Love Seat")
				overrideModAlt = ""
				if b("Vampiric Embrace") == "Vampiric Embrace" then overrideModAlt = "Vampiric Embrace"
				else overrideModAlt = "Levitate"
				end
				EditMacro("WSxCAGen+F",nil,nil,"#show "..overrideModAlt.."\n/targetfriendplayer\n/use [help,nodead]Power Infusion;Starlight Beacon\n/targetlasttarget")
				if playerSpec ~= 3 then 
					override = "[@mouseover,help,nodead][]Purify;"
				elseif b("Purify Disease") == "Purify Disease" then override = "[@mouseover,help,nodead][]Purify Disease;"
				end
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]Darkmoon Gazer;"..b("Dispel Magic","[@mouseover,harm,nodead]",";")..override.."Power Word: Fortitude")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..b("Dispel Magic","[@mouseover,harm,nodead][harm,nodead]",";").."Personal Spotlight\n/use [noexists,nocombat] Flaming Hoop\n/targetenemy [noexists]")
				if b("Renew") == "Renew" then override = "[@party3,help,nodead,mod:alt][@focus,help,nodead][@party1,help,nodead]Renew;"
				end
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..override.."\n/use Panflute of Pandaria\n/use Puzzle Box of Yogg-Saron\n/use Spectral Visage")
				EditMacro("WSxCSGen+G",nil,nil,"#show Fade\n/use [@focus,harm,nodead]Dispel Magic;[nospec:3,@focus,help,nodead][nospec:3]Purify;[@focus,help,nodead][]Purify Disease\n/cancelaura Dispersion\n/cancelaura Spirit of Redemption\n/use Tickle Totem")
				if b("Evangelism") == "Evangelism" then overrideModAlt = "Evangelism"
				elseif b("Leap of Faith") == "Leap of Faith" then overrideModAlt = "Leap of Faith"
				end
				if b("Evangelism") == "Evangelism" then override = ";Evangelism"
				elseif b("Power Word: Life") == "Power Word: Life" then override = ";[@mouseover,help,nodead][]Power Word: Life"
				end
				EditMacro("WSxGenH",nil,nil,"#show "..overrideModAlt.."\n/use [nocombat,noexists]Don Carlos' Famous Hat"..override.."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				override = ""	    
				if b("Pain Suppression") == "Pain Suppression" then override = "[@mouseover,help,nodead][]Pain Suppression"
				elseif b("Guardian Spirit") == "Guardian Spirit" then override = "[@mouseover,help,nodead][]Guardian Spirit"
				elseif b("Dispersion") == "Dispersion" then override = "!Dispersion"
				end
				EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;"..b("Power Word: Barrier","[mod,@player]",";")..override.."\n/use [nochanneling:Penance]Soul Evacuation Crystal")
				override = ""
				if b("Mind Control") == "Mind Control" then override = "[mod:ctrl,harm,nodead]Mind Control;"
				elseif b("Dominate Mind") == "Dominate Mind" then override = "[mod:ctrl,harm,nodead]Dominate Mind;"
				end
				EditMacro("WSxGenX",nil,nil,"/use [mod:shift]Fade;"..override.."[mod:ctrl]Unstable Portal Emitter"..b("Power Word: Shield",";[@mouseover,help,nodead][]","").."\n/use [nocombat]Bubble Wand\n/use Void Totem\n/cancelaura Bubble Wand")
				overrideModAlt = ""	
				if b("Rapture") == "Rapture" then overrideModAlt = "[mod:shift]Rapture;"
				elseif b("Symbol of Hope") == "Symbol of Hope" then overrideModAlt = "[mod:shift]Symbol of Hope;"
				end
				if b("Prayer of Mending") == "Prayer of Mending" then override = "[@mouseover,help,nodead][]Prayer of Mending"
				elseif b("Renew") == "Renew" then override = "[@mouseover,help,nodead][]Renew"
				elseif b("Shadowfiend") == "Shadowfiend" then override = "Shadowfiend"
				elseif b("Mindbender") == "Mindbender" then override = "Mindbender"
				end
				EditMacro("WSxGenC",nil,nil,"/use "..b("Shackle Undead","[@mouseover,harm,nodead,mod:ctrl][mod:ctrl]",";")..overrideModAlt..override)
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use [nocombat,noexists]Sturdy Love Fool\n/run PetDismiss();\n/cry")
				if b("Renew") == "Renew" then override = "[@mouseover,help,nodead][]Renew" 
				elseif b("Void Shift") == "Void Shift" then override = "[@mouseover,help,nodead][]Void Shift"
				else override = "[@mouseover,exists,nodead][@cursor,nodead]Mind soothe"		
				end		
				EditMacro("WSxGenV",nil,nil,"#show\n/stopspelltarget\n/use "..override.."\n/cancelaura Rhan'ka's Escape Plan")
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming,noexists,nocombat]Barnacle-Encrusted Gem;Levitate\n/use [nomod:alt]Seafarer's Slidewhistle\n/use [mod:alt]Weathered Purple Parasol")
				EditMacro("WSxCAGen+B",nil,nil,"")
				EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxCGen+T\",nil,nil,\"\\#show Power Infusion\\n/use [@\"..N..\"]Power Infusion\\n/stopspelltarget\", nil)print(\"PI set to : \"..N)else print(\"Nöpe!\")end")
			-- Death Knight, DK, diky
			elseif class == "DEATHKNIGHT" then
				if b("Frostwyrm's Fury") == "Frostwyrm's Fury" then override = "Frostwyrm's Fury"
				elseif b("Apocalypse") == "Apocalypse" then override = "Apocalypse"
				elseif b("Consumption") == "Consumption" then override = "Consumption"
				elseif b("Blooddrinker") == "Blooddrinker" then override = "[@mouseover,harm,nodead][]Blooddrinker"
				elseif b("Tombstone") == "Tombstone" then override = "Tombstone"
				elseif b("Breath of Sindragosa") == "!Breath of Sindragosa" then override = "Breath of Sindragosa"
				else override = "Death Strike"
				end
				EditMacro("WSxGen1",nil,nil,"#show\n/cast [@mouseover,help,dead][help,dead]Raise Ally;"..override.."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+1",nil,nil,"#show Raise Ally\n/use [@mouseover,exists][]Raise Ally\n/use Stolen Breath")
				overrideModAlt = ""
				if b("Corpse Exploder") == "Corpse Exploder" then
					overrideModAlt = "[harm,dead,nocombat]Corpse Exploder;"
				end
				if b("Heart Strike") == "Heart Strike" then override = "Heart Strike"
				elseif b("Howling Blast") == "Howling Blast" then override = "[@mouseover,harm,nodead][]Howling Blast"
				elseif b("Scourge Strike") == "Scourge Strike" then override = "[@mouseover,harm,nodead][]Scourge Strike"
				end
				EditMacro("WSxGen2",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use "..overrideModAlt..override.."\n/startattack")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use Death Strike\n/use Gnomish X-Ray Specs\n/cancelaura X-Ray Specs")
				if b("Soul Reaper") == "Soul Reaper" then override = "Soul Reaper"
				elseif b("Empower Rune Weapon") == "Empower Rune Weapon" then override = "Empower Rune Weapon"
				elseif b("Abomination Limb") == "Abomination Limb" then override = "Abomination Limb"
				elseif b("Scourge Strike") == "Scourge Strike" then override = "Scourge Strike"
				elseif b("Breath of Sindragosa") == "Breath of Sindragosa" then override = "!Breath of Sindragosa"
				elseif b("Obliterate") == "Obliterate" then override = "Obliterate"
				elseif b("Marrowrend") == "Marrowrend" then override = "Marrowrend"
				end
				EditMacro("WSxGen3",nil,nil,"#show\n/use [nocombat,noexists]Sack of Spectral Spiders;"..override.."\n/startattack")
				if b("Glacial Advance") == "Glacial Advance" then override = "Glacial Advance"
				elseif b("Outbreak") == "Outbreak" then override = "[@mouseover,harm,nodead][]Outbreak"
				elseif b("Death's Caress") == "Death's Caress" then override = "[@mouseover,harm,nodead][]Death's Caress"
				elseif b("Howling Blast") == "Howling Blast" then override = "Howling Blast"
				end
				EditMacro("WSxSGen+3",nil,nil,"/use "..override.."\n/startattack\n/stopspelltarget")
				if b("Festering Strike") == "Festering Strike" then override = "Festering Strike"
				elseif b("Obliterate") == "Obliterate" then override = "Obliterate"
				elseif b("Marrowrend") == "Marrowrend" then override = "Marrowrend"
				end
				EditMacro("WSxGen4",nil,nil,"#show\n/use [spec:2,noexists]Vrykul Drinking Horn;"..override.."\n/startattack\n/cancelaura Vrykul Drinking Horn")
				EditMacro("WSxSGen+4",nil,nil,"#show Death and Decay\n/stopspelltarget\n/use [spec:1,nocombat,noexists]Krastinov's Bag of Horrors\n/use [@focus,mod:alt]Death Coil;[@mouseover,exists,nodead][@cursor]Death and Decay\n/targetenemy [noexists]")
				if b("Bonestorm") == "Bonestorm" then override = "Bonestorm"
				elseif b("Unholy Assault") == "Unholy Assault" then override = "Unholy Assault"
				elseif b("Summon Gargoyle") == "Summon Gargoyle" then override = "Summon Gargoyle"
				elseif b("Apocalypse") == "Apocalypse" then override = "Apocalypse"
				elseif b("Breath of Sindragosa") == "!Breath of Sindragosa" then override = "Breath of Sindragosa"
				elseif b("Empower Rune Weapon") == "Empower Rune Weapon" then override = "Empower Rune Weapon"
				end
				EditMacro("WSxCGen+4",nil,nil,"#show\n/cast "..override.."\n/use [spec:1,nocombat]For da Blood God!;[nospec:1,nocombat]Will of Northrend\n/startattack")
				if b("Frost Strike") == "Frost Strike" then override = "Frost Strike"
				else override = "[@mouseover,exists,nodead][]Death Coil"
				end
				EditMacro("WSxGen5",nil,nil,"/use "..b("Anti-Magic Zone","[mod:ctrl,@cursor]",";")..override.."\n/startattack\n/cleartarget [dead]\n/use [nospec:2]Aqir Egg Cluster")
				if b("Mark of Blood") == "Mark of Blood" then override = "Mark of Blood"
				elseif b("Tombstone") == "Tombstone" then override = "Tombstone"
				elseif b("Unholy Blight") == "Unholy Blight" then override = "Unholy Blight"
				else override = "[@mouseover,exists,nodead][exists,nodead]Death Coil"
				end
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use "..override.."\n/use Angry Beehive\n/startattack")
				if b("Dancing Rune Weapon") == "Dancing Rune Weapon" then overrideModAlt = "[mod:ctrl]Dancing Rune Weapon;"
				elseif b("Pillar of Frost") == "Pillar of Frost" then overrideModAlt = "[mod:ctrl]Pillar of Frost;"
				elseif b("Army of the Dead") == "Army of the Dead" then overrideModAlt = "[mod:ctrl,@player]Army of the Dead;"
				end
				if b("Heart Strike") == "Heart Strike" then override = "Heart Strike"
				elseif b("Epidemic") == "Epidemic" then override = "Epidemic"
				elseif b("Remorseless Winter") == "Remorseless Winter" then override = "Remorseless Winter"
				end
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..overrideModAlt..override.."\n/use [mod:ctrl]Angry Beehive")
				overrideModAlt = ""
				if b("Vile Contagion") == "Vile Contagion" then overrideModAlt = "Vile Contagion"
				elseif b("Sacrificial Pact") == "Sacrificial Pact" then overrideModAlt = "Sacrificial Pact"
				end
				EditMacro("WSxSGen+6",nil,nil,"#show "..overrideModAlt.."\n/use [@player]Death and Decay\n/use [noexists,nocombat,spec:1]Vial of Red Goo\n/stopspelltarget\n/cancelaura Secret of the Ooze")
				override = ""
				overrideModAlt = ""
				if b("Vile Contagion") == "Vile Contagion" then overrideModAlt = "[mod:shift]Vile Contagion;"
				end
				if b("Blood Boil") == "Blood Boil" then override = "Blood Boil"
				elseif b("Frostscythe") == "Frostscythe" then override = "Frostscythe"
				elseif b("Horn of Winter") == "Horn of Winter" then override = "Horn of Winter"
				elseif b("Summon Gargoyle") == "Summon Gargoyle" then override = "Summon Gargoyle"
				end
				EditMacro("WSxGen7",nil,nil,"#show\n/use "..overrideModAlt..override)
				if b("Chill Streak") == "Chill Streak" then override = "[@mouseover,harm,nodead][]Chill Streak"
				elseif b("Dark Transformation") == "Dark Transformation" then override = "[pet]Dark Transformation;[spec:3,nopet]Raise Dead"
				elseif b("Sacrificial Pact") == "Sacrificial Pact" then override = "Sacrificial Pact"
				elseif b("Empower Rune Weapon") == "Empower Rune Weapon" then override = "Empower Rune Weapon"
				elseif b("Death's Caress") == "Death's Caress" then override = "Death's Caress"
				end
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..b("Sacrificial Pact","[mod:shift]",";")..override)
				if covA == "Abomination Limb" then
					if b("Empower Rune Weapon") == "Empower Rune Weapon" then override = "Empower Rune Weapon"
					elseif b("Sacrificial Pact") == "Sacrificial Pact" then override = "Sacrificial Pact"
					elseif b("Army of the Dead") == "Army of the Dead" then override = "Army of the Dead"
					elseif b("Breath of Sindragosa") == "Breath of Sindragosa" then override = "!Breath of Sindragosa"
					elseif b("Bone Storm") == "Bone Storm" then override = "Bone Storm"
					elseif b("Anti-Magic Zone") == "Anti-Magic Zone" then override = "Anti-Magic Zone"
					end
				else
					if b("Abomination Limb") == "Abomination Limb" then override = "Abomination Limb"
					elseif b("Empower Rune Weapon") == "Empower Rune Weapon" then override = "Empower Rune Weapon"
					elseif b("Sacrificial Pact") == "Sacrificial Pact" then override = "Sacrificial Pact"
					elseif b("Army of the Dead") == "Army of the Dead" then override = "Army of the Dead"
					elseif b("Breath of Sindragosa") == "Breath of Sindragosa" then override = "!Breath of Sindragosa"
					elseif b("Bone Storm") == "Bone Storm" then override = "Bone Storm"
					elseif b("Anti-Magic Zone") == "Anti-Magic Zone" then override = "Anti-Magic Zone"
					end
				end
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..override)
				EditMacro("WSxCSGen+2",nil,nil,"")
				EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noharm]Spirit Wand;[@focus,exists,harm,nodead,spec:3]Outbreak;[@focus,exists,harm,nodead,spec:2]Howling Blast\n/stopspelltarget")
				EditMacro("WSxCSGen+4",nil,nil,"/use [nocombat]Lilian's Warning Sign")
				EditMacro("WSxCSGen+5",nil,nil,"/clearfocus [dead]\n/use Permanent Frost Essence\n/use Stolen Breath")
				EditMacro("WSxGenQ",nil,nil,"/use "..b("Asphyxiate","[mod:alt,@focus,harm,nodead]",";").."[mod:shift]Lichborne;"..b("Mind Freeze","[@mouseover,harm,nodead][]",""))
				if b("Dancing Rune Weapon") == "Dancing Rune Weapon" then override = "Dancing Rune Weapon"
				elseif b("Pillar of Frost") == "Pillar of Frost" then override = "Pillar of Frost"
				elseif b("Dark Transformation") == "Dark Transformation" then override = "[nopet]Raise Dead;Dark Transformation"
				end
				EditMacro("WSkillbomb",nil,nil,"#show\n/cast "..override..dpsRacials.."\n/use [@player]13\n/use 13\n/use Raise Dead\n/use Pendant of the Scarab Storm\n/use Adopted Puppy Crate\n/use Big Red Raygun")
				EditMacro("WSxGenE",nil,nil,"#show\n/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Death Grip\n/startattack\n/cleartarget [dead]\n/targetenemy [noharm]")
				if b("Horn of Winter") == "Horn of Winter" then override = "Horn of Winter"
				elseif b("Blood Tap") == "Blood Tap" then override = "Blood Tap"
				end
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..override..oOtas..covToys)
				if b("Blinding Sleet") == "Blinding Sleet" then override = "Blinding Sleet"
				elseif b("Rune Tap") == "Rune Tap" then override = "Rune Tap"
				elseif b("Blood Tap") == "Blood Tap" then override = "Blood Tap"
				end
				EditMacro("WSxSGen+E",nil,nil,"#show "..override.."\n/use "..b("Gorefiend's Grasp","[mod:alt,@player]",";")..override)
				EditMacro("WSxGenR",nil,nil,"#show\n/use "..b("Gorefiend's Grasp","[@player,mod:ctrl][@mouseover,exists,nodead,mod:shift][mod:shift]",";")..b("Wraith Walk","[mod:ctrl]!",";")..b("Chains of Ice","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]","").."\n/targetenemy [noexists]")
				if playerSpec == 3 then override = "[nopet]Raise Dead;[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][pet]Leap"
				elseif b("Blood Tap") == "Blood Tap" then override = "Blood Tap"
				elseif b("Horn of Winter") == "Horn of Winter" then override = "Horn of Winter"
				elseif b("Gorefiend's Grasp") == "Gorefiend's Grasp" then override = "Gorefiend's Grasp"
				else override = "Death Grip"
				end
				EditMacro("WSxGenT",nil,nil,"/use "..override.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]\n/petattack [@mouseover,exists,nodead][]")
				EditMacro("WSxSGen+T",nil,nil,"#show\n/use Dark Command\n/use Blight Boar Microphone")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..b("Raise Dead","[nopet]",";").."\n/use "..b("Sacrificial Pact","[]",""))
				if b("Horn of Winter") == "Horn of Winter" then override = "Horn of Winter"
				elseif b("Wraith Walk") == "Wraith Walk" then override = "Wraith Walk"
				elseif b("Rune Tap") == "Rune Tap" then override = "Rune Tap"
				elseif b("Blinding Sleet") == "Blinding Sleet" then override = "Blinding Sleet"
				end
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..override)
				EditMacro("WSxGenF",nil,nil,"#show Corpse Exploder\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Legion Communication Orb;[@focus,harm,nodead]Mind Freeze")
				if b("Dark Transformation") == "Dark Transformation" then override = "[nopet]Raise Dead;[pet,@focus,harm,nodead][pet,harm,nodead]Dark Transformation;Gastropod Shell\n/use [pet,@focus,harm,nodead][pet,harm,nodead]!Leap\n/petattack [@focus,harm,nodead]"
				elseif b("Blood Tap") == "Blood Tap" then override = "[nocombat,noexists]Gastropod Shell;Blood Tap"
				end
				EditMacro("WSxSGen+F",nil,nil,"#show "..b("Death Pact").."\n/petautocasttoggle [mod:alt]Claw\n/use "..override)
				if b("Horn of Winter") == "Horn of Winter" then override = "Horn of Winter"
				elseif b("Vampiric Blood") == "Vampiric Blood" then override = "Vampiric Blood"
				elseif b("Rune Tap") == "Rune Tap" then override = "Rune Tap"
				elseif b("Blinding Sleet") == "Blinding Sleet" then override = "Blinding Sleet"
				else override = "[pet]Huddle"
				end
				EditMacro("WSxCGen+F",nil,nil,"#show\n/use "..override)
				if playerSpec == 3 and b("Raise Dead") == "Raise Dead" then override = "[nopet]Raise Dead;[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][pet]Gnaw\n/petattack [harm,nodead]"
				elseif b("Rune Tap") == "Rune Tap" then override = "Rune Tap"
				else override = "Death Grip"
				end
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt,nocombat,noexists]S.F.E. Interceptor;"..override)
				if b("Asphyxiate") == "Asphyxiate" then override = "[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Asphyxiate"
				elseif b("Blinding Sleet") == "Blinding Sleet" then override = "Blinding Sleet"
				end
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..override.."\n/use [noexists,nocombat] Flaming Hoop")				
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..b("Death Pact","[]",""))
			 
				if b("Control Undead") == "Control Undead" then override = "Control Undead"
				elseif b("Anti-Magic Zone") == "Anti-Magic Zone" then override = "Anti-Magic Zone"
				end
				EditMacro("WSxCSGen+G",nil,nil,"#show "..override.."\n/cancelaura Lichborne\n/cancelaura Blessing of Protection")
				EditMacro("WSxGenH",nil,nil,"#show\n/use [nocombat,noexists]Death Gate;[spec:3,nopet]Raise Dead;[@mouseover,harm,nodead,spec:3][spec:3,pet]Gnaw;[nomounted]Death Gate\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;"..b("Anti-Magic Zone","[@player,mod:shift]",";")..b("Icebound Fortitude","[]",""))
				EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt]Runeforging;"..b("Control Undead","[mod:ctrl,harm,nodead]",";").."[mod:ctrl]Death Gate;"..b("Wraith Walk","[mod:shift]",";")..b("Anti-Magic Shell","[]",""))
				if b("Lichborne") == "Lichborne" then overrideModAlt = "[mod:shift]Lichborne\n/use [@player,mod:shift][@pet,pet,nodead]Death Coil;"
				end
				if b("Horn of Winter") == "Horn of Winter" then override = "Horn of Winter"
				elseif b("Death Pact") == "Death Pact" then override = "Death Pact"
				elseif b("Blinding Sleet") == "Blinding Sleet" then override = "Blinding Sleet"
				elseif b("Asphyxiate") == "Asphyxiate" then override = "Asphyxiate"
				elseif b("Death Grip") == "Death Grip" then override = "Death Grip"
				end
				EditMacro("WSxGenC",nil,nil,"#show "..override.."\n/use "..b("Control Undead","[mod:ctrl]",";")..overrideModAlt..override)
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use Sylvanas' Music Box\n/run PetDismiss();\n/cry")
				EditMacro("WSxGenV",nil,nil,"#show\n/use !Death's Advance\n/use Ancient Elethium Coin\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[nomod:alt]Path of Frost\n/use [swimming]Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")
			-- Warrior, warror
			elseif class == "WARRIOR" then
				overrideModAlt = ""
				if b("Berserker Stance") == "Berserker Stance" then overrideModAlt = "\n/use [nostance:2]!Berserker Stance"
				end
				if b("Colossus Smash") == "Colossus Smash" then override = "Colossus Smash"
				elseif b("Rampage") == "Rampage" then override = "[noequipped:Shields]Rampage\n/equipset [equipped:Shields,spec:2]DoubleGate"..overrideModAlt
				else override = "Shield Block"
				end
				EditMacro("WSxGen1",nil,nil,"#show\n/use [nocombat,help]Corbyn's Beacon;"..override.."\n/targetenemy [noexists]\n/startattack\n/use Chalice of Secrets")
			   	if b("Ignore Pain") == "Ignore Pain" then override = "Ignore Pain"
				elseif b("Bitter Immunity") == "Bitter Immunity" then override = "Bitter Immunity"
				end
				EditMacro("WSxSGen+1",nil,nil,"/use "..override.."\n/use Chalice of Secrets\n/targetexact Aerylia")
			   	overrideModAlt = ""
			   	if b("Battle Stance") == "Battle Stance" then overrideModAlt = "\n/use [nostance:2]!Battle Stance" 
			   	end
				if b("Mortal Strike") == "Mortal Strike" then override = "[noequipped:Shields]Mortal Strike\n/equipset [equipped:Shields,spec:1]Noon!"..overrideModAlt
				elseif b("Bloodthirst") == "Bloodthirst" then override = "Bloodthirst"
				elseif b("Devastate") == "Devastate" then override = "[known:Devastator,@mouseover,harm,nodead][known:Devastator]Heroic Throw;Devastate"
			   	end
				EditMacro("WSxGen2",nil,nil,"/use [nocombat,noexists]Vrykul Drinking Horn;"..override.."\n/targetenemy [noexists]\n/cleartarget [noharm]\n/startattack\n/cancelaura Vrykul Drinking Horn")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use Victory Rush\n/use [noexists,nocombat,nochanneling]Gnomish X-Ray Specs\n/targetenemy [noharm]\n/startattack")
				EditMacro("WSxGen3",nil,nil,"#show\n/use Execute\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]\n/use Banner of the Burning Blade")
				if b("Rend") == "Rend" then override = "Rend"
				elseif b("Thunderous Roar") == "Thunderous Roar" then override = "Thunderous Roar"
				elseif b("Bladestorm") == "Bladestorm" then override = "Bladestorm"
				elseif b("Thunder Clap") == "Thunder Clap" then override = "Thunder Clap"
				else override = "Whirlwind"
				end
				EditMacro("WSxSGen+3",nil,nil,"/use "..override.."\n/startattack")
				if b("Overpower") == "Overpower" then override = "Overpower"
				elseif b("Raging Blow") == "Raging Blow" then override = "Raging Blow"
				else override = "Slam"
				end
				EditMacro("WSxGen4",nil,nil,"#show\n/use [spec:3][equipped:Shields,spec:2]Shield Slam;"..override.."\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
			 	override = ""
			 	if b("Ravager") == "Ravager" then override = "[@mouseover,exists,nodead][@cursor]Ravager"
				elseif b("Skullsplitter") == "Skullsplitter" then override = "Skullsplitter"
				elseif b("Siegebreaker") == "Siegebreaker" then override = "Siegebreaker"
				end
				EditMacro("WSxSGen+4",nil,nil,"#show\n/stopspelltarget\n/use "..override.."\n/use Muradin's Favor\n/startattack")
				if b("Odyn's Fury") == "Odyn's Fury" then override = "Odyn's Fury"
				elseif b("Bladestorm") == "Bladestorm" then override = "Bladestorm"
				elseif b("Shield Charge") == "Shield Charge" then override = "Shield Charge"
				elseif b("Thunderous Roar") == "Thunderous Roar" then override = "Thunderous Roar"
				elseif b("Avatar") == "Avatar" then override = "Avatar"
				elseif b("Recklessness") == "Recklessness" then override = "Recklessness"
				end
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..override.."\n/startattack\n/cleartarget [dead]\n/use [nocombat,noexists]Tosselwrench's Mega-Accurate Simulation Viewfinder")
				if b("Rallying Cry") == "Rallying Cry" then overrideModAlt = "[mod:ctrl]Rallying Cry;"
			   	end
			   	if b("Onslaught") == "Onslaught" then override = "Onslaught"
				elseif b("Revenge") == "Revenge" then override = "Revenge"
				else override = "Slam"
				end
				EditMacro("WSxGen5",nil,nil,"/use "..overrideModAlt.."[equipped:Shields,nospec:3]Shield Slam;"..override.."\n/startattack\n/cleartarget [dead]\n/stopmacro [nomod]\n/use [mod]Gamon's Braid\n/roar")
				if b("Shockwave") == "Shockwave" then override = "Shockwave"
				elseif b("Thunderous Roar") == "Thunderous Roar" then override = "Thunderous Roar"
				elseif b("Avatar") == "Avatar" then override = "Avatar"
				elseif b("Bladestorm") == "Bladestorm" then override = "Bladestorm"
				elseif playerSpec == 2 then override = "Slam"
				else override = "Whirlwind"
				end
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use "..override.."\n/startattack")
				if b("Bladestorm") == "Bladestorm" then overrideModAlt = "[mod:ctrl]Bladestorm;"
				elseif b("Recklessness") == "Recklessness" then overrideModAlt = "[mod:ctrl]Recklessness;"
				elseif b("Avatar") == "Avatar" then overrideModAlt = "[mod:ctrl]Avatar;"
				end
				if playerSpec == 3 and  b("Thunder Clap") == "Thunder Clap" then override = "Thunder Clap"
				else override = "Whirlwind"
				end
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..overrideModAlt..override.."\n/startattack\n/use Words of Akunda")
				override = ""
				if b("Ravager") == "Ravager" then override = "[@player]Ravager"
				elseif b("Rampage") == "Rampage" then override = "Rampage"
				elseif b("Sweeping Strikes") == "Sweeping Strikes" then override = "Sweeping Strikes"
				elseif playerSpec == 3 then override = "Shield Block"
				end
				EditMacro("WSxSGen+6",nil,nil,"/use "..override.."\n/targetenemy [noexists]\n/startattack")
				if b("Recklessness") == "Recklessness" then override = "Recklessness"
				elseif b("Cleave") == "Cleave" then override = "Cleave"
				elseif b("Challenging Shout") == "Challenging Shout" then override = "Challenging Shout"
				end
				EditMacro("WSxGen8",nil,nil,"#show \n/use "..override)
			   	if b("Champion's Spear") == "Champion's Spear" then override = "[@player,mod][@cursor]Champion's Spear"
				elseif b("Cleave") == "Cleave" then override = "Cleave"
				elseif b("Sweeping Strikes") == "Sweeping Strikes" then override = "Sweeping Strikes"
				else override = "Slam"
				end
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..override)
				EditMacro("WSxCSGen+2",nil,nil,"")
				EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Rend;Vrykul Toy Boat\n/use [nocombat]Vrykul Toy Boat Kit")
				EditMacro("WSxCSGen+4",nil,nil,"/use [mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Intervene")
				EditMacro("WSxCSGen+5",nil,nil,"//use [mod:alt,@party4,help,nodead][@party2,help,nodead][@targettarget,help,nodead]Intervene")
				EditMacro("WSxGenQ",nil,nil,"#show Pummel\n/use "..b("Storm Bolt","[mod:alt,@focus,harm,nodead]",";")..b("Berserker Rage","[mod:shift]",";").."[@mouseover,harm,nodead,nomod]Charge\n/use [@mouseover,harm,nodead,nomod][nomod]Pummel\n/use Mote of Light\n/use World Shrinker")
				EditMacro("WSkillbomb",nil,nil,"#show "..b("Avatar","\n/use ","")..b("Recklessness","\n/use ","")..b("Battle Stance","\n/use [nostance:2]","")..b("Berserker Stance","\n/use [nostance:2]","").."\n/use Flippable Table"..dpsRacials..hasHE.."\n/use Will of Northrend\n/use [@player]13\n/use 13"..b("Thunderous Roar","\n/use ","")..b("Bladestorm","\n/use ","")..b("Ravager","\n/use [@player]","").."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
				EditMacro("WSxGenE",nil,nil,"#show\n/use [@mouseover,harm,nodead][]Charge\n/use [noexists,nocombat]Arena Master's War Horn\n/startattack\n/cleartarget [dead][help]\n/targetenemy [noharm]\n/use Prismatic Bauble")
				EditMacro("WSxCGen+E",nil,nil,"#show Battle Shout\n/use "..b("Last Stand","[]","").."\n/use Outrider's Bridle Chain"..oOtas..covToys)
			   	if b("Intimidating Shout") == "Intimidating Shout" then override = "[@mouseover,harm,nodead][]Intimidating Shout"
				elseif b("Demoralizing Shout") == "Demoralizing Shout" then override = "[@mouseover,harm,nodead][]Demoralizing Shout"
				end
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..override.."\n/startattack\n/targetenemy [noexists]\n/targetlasttarget")
				EditMacro("WSxGenR",nil,nil,"#show "..b("Spell Reflection","[spec:3]",";").."Hamstring\n/use "..b("Piercing Howl","[mod:shift]",";")..b("Intervene","[@mouseover,help,nodead,nomod][help,nodead,nomod]","").."\n/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Hamstring\n/startattack")
				EditMacro("WSxGenT",nil,nil,"#show\n/use [@mouseover,harm,nodead][]Heroic Throw\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]\n/use Blight Boar Microphone")
				EditMacro("WSxSGen+T",nil,nil,"#show Taunt\n/use [nocombat,noexists]Blight Boar Microphone;Taunt\n/targetenemy [noexists]")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..b("Challenging Shout","[]",""))
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..b("Intervene","[]",";")..b("Intimidating Shout","[]",""))
				EditMacro("WSxGenF",nil,nil,"#show "..b("Berserker Rage","[]",";")..b("Intimidating Shout","[]","").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Pummel")
				EditMacro("WSxSGen+F",nil,nil,"#show "..b("Spell Block","[]","").."\n/use [@focus,harm,nodead]Charge\n/use [@focus,harm,nodead]Pummel\n/use [help,nocombat,mod:alt]B.B.F. Fist;[nocombat,noexists,mod:alt]Gastropod Shell;Faintly Glowing Flagon of Mead")
			   	if b("Demoralizing Shout") == "Demoralizing Shout" then override = "Demoralizing Shout"
				else override = "Battle Shout"
				end
				EditMacro("WSxCGen+F",nil,nil,"#show\n/use "..override)					
			   	if b("Shattering Throw") == "Shattering Throw" then override = "[@mouseover,harm,nodead][harm,nodead]Shattering Throw;"
				elseif b("Wrecking Throw") == "Wrecking Throw" then override = "[@mouseover,harm,nodead][harm,nodead]Wrecking Throw;"
				elseif b("Storm Bolt") == "Storm Bolt" then override = "[@mouseover,harm,nodead][harm,nodead]Storm Bolt;"
				end
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]S.F.E. Interceptor;"..override.."B.B.F. Fist\n/targetenemy [combat,noharm]")
				if b("Storm Bolt") == "Storm Bolt" then override = "Storm Bolt"
				else override = "Victory Rush"
				end
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..override.."\n/use [noexists,nocombat]Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..b("Spell Block"))
				EditMacro("WSxCSGen+G",nil,nil,"#show\n/use [nocombat,noexists]Hraxian's Unbreakable Will"..b("Bitter Immunity",";","").."\n/cancelaura Blessing of Protection\n/cancelaura Words of Akunda")
				EditMacro("WSxGenH",nil,nil,"#show Battle Shout\n/use [nomounted]Darkmoon Gazer;"..b("Bitter Immunity").."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				if b("Battle Stance") == "Battle Stance" then overrideModAlt = "[mod:alt]!Battle Stance;"
				elseif b("Berserker Stance") == "Berserker Stance" then overrideModAlt = "[mod:alt]!Berserker Stance;"
				end
				if b("Last Stand") == "Last Stand" then override = "[nomod]Last Stand"
				elseif b("Intimidating Shout") == "Intimidating Shout" then override = "[nomod]Intimidating Shout"
				end
				EditMacro("WSxGenX",nil,nil,"#show\n/use "..b("Defensive Stance","[mod:alt,nostance:1]!",";")..overrideModAlt..override.."\n/targetfriend [mod:shift,nohelp]\n/use [mod:shift,help,nodead]Intervene\n/targetlasttarget [mod:shift]")	
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use Sylvanas' Music Box\n/run PetDismiss();\n/cry")
				EditMacro("WSxGenV",nil,nil,"/use "..b("Heroic Leap","[@cursor]","").."\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[nomod:alt]Heroic Leap\n/use [swimming]Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")
			-- Druid, dodo
			elseif class == "DRUID" then
				EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,dead][help,dead]Rebirth;"..b("Innervate","[@mouseover,help,nodead][help,nodead]",";").."[@mouseover,harm,nodead][harm,nodead]Moonfire;Druid and Priest Statue Set\n/use [nocombat,noform:1/4]!Prowl\n/targetenemy [noexists]")
			   	if b("Sunfire") == "Sunfire" then override = "Sunfire"
				elseif b("Tranquility") == "Tranquility" then override = "Tranquility"
				else override = "Mark of the Wild"
				end
				EditMacro("WSxSGen+1",nil,nil,"#show "..override.."\n/use [mod:alt,@party3,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Regrowth;Kalytha's Haunted Locket")
				EditMacro("WSxGen2",nil,nil,"/use [form:2]Shred;[form:1]Mangle;"..b("Sunfire","[@mouseover,harm,nodead][harm,nodead]",";")..b("Invigorate","[@mouseover,help,nodead][help,nodead]",";").."Moonfeather Statue\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/cancelaura X-Ray Specs\n/use [mod:alt,@party4,nodead][@mouseover,help,nodead][]Regrowth\n/use Gnomish X-Ray Specs")
				EditMacro("WSxGen3",nil,nil,"#show\n/use "..b("Rake","[form:2]",";")..b("Ironfur","[form:1]",";")..b("Starsurge","[]",";").."\n/targetenemy [noexists]\n/use Desert Flute")
				EditMacro("WSxSGen+3",nil,nil,"#show "..b("Rake","[]",";").."Moonfire"..b("Rake","\n/use [noform:2]Cat Form;[form:2]","\n/use !Prowl")..b("Lifebloom","\n/use [@mouseover,help,nodead][]","")..b("Thrash","\n/use [form:1/2]","\n/use [noform:1]Bear Form;[form:1]",""))
				EditMacro("WSxGen4",nil,nil,"/use "..b("Rip","[form:2]",";")..b("Pulverize","[form:1]",";").."[form:2]Shred;[form:1]Mangle;"..b("Starfire","[@mouseover,harm,nodead][]","").."\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,nostealth,noform:1/4]!Prowl")
				overrideModAlt = ""
				if playerSpec == 4 and b("Rejuvenation") == "Rejuvenation" then overrideModAlt = "[@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Rejuvenation;"
				elseif b("Rejuvenation") == "Rejuvenation" then overrideModAlt = "[@party1,help,nodead,mod:alt]Rejuvenation;"
				end
				if playerSpec == 1 and b("Moonkin Form") == "Moonkin Form" then overrideModCtrl = "[noform:4]!Moonkin Form;"
				elseif playerSpec == 2 then overrideModCtrl = "[noform:2]!Cat Form;"
				elseif playerSpec == 3 then overrideModCtrl = "[noform:1]!Bear Form;"
				else overrideModCtrl = ""
				end
				if b("Stellar Flare") == "Stellar Flare" then override = "[nomod:alt,harm,nodead]Stellar Flare\n/use [nomod:alt]Bushel of Mysterious Fruit\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Stellar Flare\n/targetlasttarget"
				elseif b("New Moon") == "New Moon" then override = "[harm,nodead]New Moon\n/use Bushel of Mysterious Fruit"
				elseif b("Fury of Elune") == "Fury of Elune" then override = "[harm,nodead]Fury of Elune\n/use Bushel of Mysterious Fruit"
				elseif b("Tiger's Fury") == "Tiger's Fury" then override = "[form:2]Tiger's Fury\n/use Bushel of Mysterious Fruit"
				elseif b("Bristling Fur") == "Bristling Fur" then override = "[form:1]Bristling Fur\n/use Bushel of Mysterious Fruit"
				elseif b("Lifebloom") == "Lifebloom" then override = "[@mouseover,help,nodead][]Lifebloom\n/use Bushel of Mysterious Fruit"
				else override = "\n/use Bushel of Mysterious Fruit"
				end
				EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noexists]\n/use "..overrideModAlt..overrideModCtrl..override.."")
				override = ""
				overrideModAlt = ""
				if b("Rejuvenation") == "Rejuvenation" then overrideModAlt = "[@party3,help,nodead,mod:alt]Rejuvenation;"
				end
				if b("Heart of the Wild") == "Heart of the Wild" then override = "Heart of the Wild"
				elseif b("Grove Guardians") == "Grove Guardians" then override = "[@mouseover,help,nodead][]Grove Guardians"
				elseif b("Nourish") == "Nourish" then override = "[@mouseover,help,nodead][]Nourish"	
				elseif b("Nature's Vigil") == "Nature's Vigil" then override = "Nature's Vigil"
				elseif b("Convoke the Spirits") == "Convoke the Spirits" then override = "[@mouseover,exists,nodead][]Convoke the Spirits"
				elseif b("Stampeding Roar") == "Stampeding Roar" then override = "Stampeding Roar"
				end
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..overrideModAlt..override)	
				override = ""
				if b("Nourish") == "Nourish" then override = "[@mouseover,help,nodead][help,nodead]Nourish;"
				elseif b("Grove Guardians") == "Grove Guardians" then override = "[@mouseover,help,nodead][help,nodead]Grove Guardians;"
				elseif b("Maul") == "Maul" then override = "[noform:1]Bear Form;[form:1,harm,nodead]Maul;"
				end
				EditMacro("WSxGen5",nil,nil,"#show\n/use "..b("Renewal","[mod:ctrl]",";").."[form:1,harm,nodead]Mangle;[form:2,harm,nodead]Ferocious Bite;"..override.."Wrath\n/targetenemy [noexists]\n/cleartarget [dead]")
				override = ""
				overrideModAlt = ""
				if b("Rejuvenation") == "Rejuvenation" then overrideModAlt = "[@focus,help,nodead,mod:alt][@party2,help,nodead,mod:alt]Rejuvenation;"
				end
				if b("Lunar Beam") == "Lunar Beam" then override = "Lunar Beam"
				elseif b("Flourish") == "Flourish" then override = "Flourish"
				elseif b("Feral Frenzy") == "Feral Frenzy" then override = "[noform:2]Cat Form;[form:2]Feral Frenzy"
				elseif b("Tiger's Fury") == "Tiger's Fury" then override = "[noform:2]Cat Form;[form:2]Tiger's Fury"
				elseif b("Nourish") == "Nourish" then override = "[@mouseover,help,nodead][]Nourish"
				elseif b("Grove Guardians") == "Grove Guardians" then override = "[@mouseover,help,nodead][]Grove Guardians"
				elseif b("Warrior of Elune") == "Warrior of Elune" then override = "Warrior of Elune"
				elseif b("Force of Nature") == "Force of Nature" then override = "[@cursor]Force of Nature"
				elseif b("Wild Mushroom") == "Wild Mushroom" then override = "Wild Mushroom"
				elseif b("Cenarion Ward") == "Cenarion Ward" then override = "[@mouseover,help,nodead][]Cenarion Ward"
				end
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use "..overrideModAlt.."[nocombat,help,nodead]Corbyn's Beacon;"..override.."\n/use [spec:2/3]Bloodmane Charm;Compendium of the New Moon")
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod:ctrl,@party4,help,nodead]Rejuvenation;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14\n/use Eternal Black Diamond Ring")
				if b("Celestial Alignment") == "Celestial Alignment" then overrideModAlt = "[mod,@cursor]Celestial Alignment;"
				elseif b("Incarnation: Chosen of Elune") == "Incarnation: Chosen of Elune" then overrideModAlt = "[mod]!Incarnation: Chosen of Elune;"
				elseif b("Incarnation: Avatar of Ashamane") == "Incarnation: Avatar of Ashamane" then overrideModAlt = "[mod]!Incarnation: Avatar of Ashamane;"
				elseif b("Incarnation: Guardian of Ursoc") == "Incarnation: Guardian of Ursoc" then overrideModAlt = "[mod]!Incarnation: Guardian of Ursoc;"
				elseif b("Berserk") == "Berserk" then overrideModAlt = "[mod]Berserk;"
				elseif b("Tranquility") == "Tranquility" then overrideModAlt = "[mod]Tranquility;"
				elseif b("Incarnation: Tree of Life") == "Incarnation: Tree of Life" then overrideModAlt = "[mod]!Incarnation: Tree of Life;"
				end
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..overrideModAlt..b("Thrash","[form:1/2]",";[spec:2,noform:1/2]Cat Form;[spec:3,noform:1/2]Bear Form;")..b("Starfall","[]",";")..b("Sunfire","[@mouseover,harm,nodead][harm,nodead]","")..b("Nature's Swiftness","[]","")..b("Tranquility","\n/stopmacro\n/use ",""))
				EditMacro("WSxSGen+6",nil,nil,"#show\n/use "..b("Primal Wrath","[form:2]",";")..b("Wild Growth","[@mouseover,help,nodead][]","").."\n/use Kaldorei Wind Chimes\n/use [nocombat,noexists]Friendsurge Defenders")
				override = ""
				if b("Efflorescence") == "Efflorescence" then overrideModAlt = "[mod,@player][@mouseover,exists,nodead,noform:1/2][@cursor,noform:1/2]Efflorescence;"
				elseif b("Wild Mushroom") == "Wild Mushroom" then overrideModAlt = "[mod,@player,noform:1/2][noform:1/2]Wild Mushroom;"
				end
				if b("Fury of Elune") == "Fury of Elune" then override = "[@mouseover,harm,nodead,noform:1/2][noform:1/2]Fury of Elune;"
				elseif b("Starfall") == "Starfall" then override = "[noform:1/2]Starfall;"
				end
				EditMacro("WSxGen7",nil,nil,"/stopspelltarget\n/use "..overrideModAlt..override..b("Swipe","[noform:1/2]Cat Form;[form:1/2]",""))
				overrideModAlt = ""
				if b("Invigorate") == "Invigorate" then overrideModAlt = "[@mouseover,help,nodead,mod][mod]Invigorate;"
				end
				override = ""
				if b("Fury of Elune") == "Fury of Elune" then override = "Fury of Elune"
				elseif b("New Moon") == "New Moon" then override = "New Moon"
				elseif b("Incarnation: Tree of Life") == "Incarnation: Tree of Life" then override = "!Incarnation: Tree of Life"
				elseif b("Convoke the Spirits") == "Convoke the Spirits" then override = "Convoke the Spirits"
				elseif b("Adaptive Swarm") == "Adaptive Swarm" then override = "[@mouseover,exists,nodead][]Adaptive Swarm"
				elseif b("Cenarion Ward") == "Cenarion Ward" then override = "Cenarion Ward"
				elseif b("Overgrowth") == "Overgrowth" then override = "[@mouseover,help,nodead][]Overgrowth"
				elseif b("Nature's Vigil") == "Nature's Vigil" then override = "Nature's Vigil"
				elseif b("Ironfur") == "Ironfur" then override = "Ironfur"
				elseif b("Starfall") == "Starfall" then override = "Starfall"
				end
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..overrideModAlt..override)
				if b("Starfall") == "Starfall" and covA ~= ("Ravenous Frenzy" or "Kindred Spirits" or "Adaptive Swarm") then override = "Starfall"
				elseif b("Rage of the Sleeper") == "Rage of the Sleeper" then override = "[noform:1]Bear Form;[form:1]Rage of the Sleeper"
				elseif b("Adaptive Swarm") == "Adaptive Swarm" then override = "[@mouseover,exists,nodead][]Adaptive Swarm"
				elseif b("Incarnation: Tree of Life") == "Incarnation: Tree of Life" then override = "!Incarnation: Tree of Life"
				elseif b("Convoke the Spirits") == "Convoke the Spirits" then override = "Convoke the Spirits"
				elseif b("Astral Communion") == "Astral Communion" then override = "Astral Communion"
				elseif b("Tiger's Fury") == "Tiger's Fury" then override = "Tiger's Fury"
				elseif b("Bristling Fur") == "Bristling Fur" then override = "Bristling Fur"
				elseif b("Cyclone") == "Cyclone" then override = "Cyclone"
				end
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..override)
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,spec:4,@party3,help,nodead][spec:4,@party1,help,nodead][spec:4,@targettarget,help,nodead]Nature's Cure;[mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Remove Corruption\n/use [nocombat]Spirit of Bashiok")
				EditMacro("WSxCSGen+3",nil,nil,"/use [mod:alt,spec:4,@party4,help,nodead][spec:4,@party2,help,nodead]Nature's Cure;[mod:alt,@party4,help,nodead][@party2,help,nodead]Remove Corruption")
				EditMacro("WSxCSGen+4",nil,nil,"/use "..b("Stellar Flare","[spec:1,@focus,harm,nodead]",";").."[mod:alt,@party3,help,nodead,spec:4][@focus,spec:4,help,nodead][@party1,help,nodead,spec:4]Lifebloom;[mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead]Rejuvenation") 
				EditMacro("WSxCSGen+5",nil,nil,"/use [mod:alt,@party4,help,nodead,spec:4][@focus,spec:4,help,nodead][@party2,help,nodead,spec:4][@targettarget,help,nodead,spec:4]Lifebloom;[mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead][@targettarget,help,nodead]Rejuvenation")
				if b("Skull Bash") == "Skull Bash" then override = "[@mouseover,harm,nodead,form:1/2][form:1/2]Skull Bash;[noform:1/2]Cat Form"
				elseif b("Solar Beam") == "Solar Beam" then override = "[@mouseover,harm,nodead][]Solar Beam"
				end
				EditMacro("WSxGenQ",nil,nil,"/use "..b("Cyclone","[mod:alt,@focus,harm,nodead]",";")..override)
				override = ""
				if b("Celestial Alignment") == "Celestial Alignment" then override = "\n/use [@cursor]Celestial Alignment"
				elseif b("Incarnation: Chosen of Elune") == "Incarnation: Chosen of Elune" then override = "\n/use !Incarnation: Chosen of Elune"
				elseif b("Incarnation: Avatar of Ashamane") == "Incarnation: Avatar of Ashamane" then override = "\n/use !Incarnation: Avatar of Ashamane"
				elseif b("Incarnation: Guardian of Ursoc") == "Incarnation: Guardian of Ursoc" then override = "\n/use !Incarnation: Guardian of Ursoc"
				elseif b("Berserk") == "Berserk" then override = "\n/use Berserk"
				elseif b("Incarnation: Tree of Life") == "Incarnation: Tree of Life" then override = "\n/use !Incarnation: Tree of Life"
				elseif b("Tranquility") == "Tranquility" then override = "\n/use Tranquility"
				end
				EditMacro("WSkillbomb",nil,nil,"#show "..override..b("Nature's Vigil","\n/use ","")..b("Force of Nature","\n/use [@player]","")..dpsRacials.."\n/use [spec:1/4]Rukhmar's Sacred Memory;Will of Northrend\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
				if b("Incapacitating Roar") == "Incapacitating Roar" then override = "Incapacitating Roar"
				elseif b("Mighty Bash") == "Mighty Bash" then override = "Mighty Bash"
				elseif b("Ursol's Vortex") == "Ursol's Vortex" then override = "Ursol's Vortex"
				elseif b("Mass Entanglement") == "Mass Entanglement" then override = "Mass Entanglement"
				elseif b("Cyclone") == "Cyclone" then override = "Cyclone"
				end
				EditMacro("WSxGenE",nil,nil,"#show "..override.."\n/use "..b("Frenzied Regeneration","[noform:1,mod:alt]Bear Form;[form:1,mod:alt]",";")..b("Wild Charge","[help,nodead,noform][form:1/2]","").."\n/use [noform:1]!Prowl\n/use [combat,noform:1/2]Bear Form(Shapeshift)\n/targetenemy [noexists]\n/cancelform [help,nodead]\n/use [nostealth]Prismatic Bauble")
				if b("Nature's Swiftness") == "Nature's Swiftness" then override = "Nature's Swiftness"
				elseif b("Renewal") == "Renewal" then override = "Renewal"
				elseif b("Frenzied Regeneration") == "Frenzied Regeneration" then override = "[noform:1]Bear Form;[form:1]Frenzied Regeneration"
				end
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..b("Solar Beam","[mod:alt,@focus,harm,nodead]",";")..override.."\n/use [nocombat]Mylune's Call"..oOtas..covToys)
				if b("Ursol's Vortex") == "Ursol's Vortex" then overrideModAlt = "[mod:alt,@player]Ursol's Vortex;"
				elseif b("Solar Beam") == "Solar Beam" then overrideModAlt = "[mod:alt,@focus,harm,nodead]Solar Beam;"
				end
				if b("Incapacitating Roar") == "Incapacitating Roar" then override = "Incapacitating Roar"
				elseif b("Mighty Bash") == "Mighty Bash" then override = "Mighty Bash"
				elseif b("Solar Beam") == "Solar Beam" then override = "[@mouseover,harm,nodead][]Solar Beam"
				end
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..overrideModAlt..override.."\n/use [nomod]!Prowl")
				if b("Ursol's Vortex") == "Ursol's Vortex" then override = "[@cursor,mod:shift][nomod,@cursor]Ursol's Vortex"
				elseif b("Mass Entanglement") == "Mass Entanglement" then override = "[mod:shift][nomod]Mass Entanglement"
				else override = "[@mouseover,harm,nodead][]Entangling Roots"
				end
				EditMacro("WSxGenR",nil,nil,b("Wild Charge","/cancelform [form,@mouseover,help,nodead,nomod]\n/use [@mouseover,help,nodead,nomod]","\n").."/use "..b("Stampeding Roar","[mod:ctrl]",";")..b("Typhoon","[nomod:shift]",";")..override)
				if b("Frenzied Regeneration") == "Frenzied Regeneration" then override = "Frenzied Regeneration"
				else override = "Entangling Roots"
				end
				EditMacro("WSxGenT",nil,nil,"#show "..override.."\n/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]Entangling Roots\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+T",nil,nil,"#show [nocombat,noform:1]Prowl;Growl\n/use [noform:1]Bear form(Shapeshift);Growl\n/use [spec:3]Highmountain War Harness\n/cancelaura [noform:1]Highmountain War Harness\n/use Hunter's Call")
				if b("Cenarion Ward") == "Cenarion Ward" then override = "[@party2,help,nodead,mod:alt][@mouseover,help,nodead][help,nodead][@party1,help,nodead][]Cenarion Ward"
				elseif b("Invigorate") == "Invigorate" then override = "[@party2,help,nodead,mod:alt][@mouseover,help,nodead][help,nodead][@party1,help,nodead][]Invigorate"
				end
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..override)
				EditMacro("WSxGenU",nil,nil,"#show "..b("Renewal","[]",";").."[resting]Treant Form;Prowl\n/use Treant Form")
				if b("Skull Bash") == "Skull Bash" then override = "[@focus,harm,nodead,form:1/2]Skull Bash;[@focus,harm,nodead,noform:1/2]Bear Form;"
				elseif b("Solar Beam") == "Solar Beam" then override = "[@focus,harm,nodead]Solar Beam;"
				end
				EditMacro("WSxGenF",nil,nil,"#show Barkskin\n/focus [@mouseover,exists]mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;"..override.."Charm Woodland Creature")
				EditMacro("WSxSGen+F",nil,nil,"#show [exists,nocombat]Charm Woodland Creature"..b("Stampeding Roar",";","").."\n/cancelform [mod:alt]\n/use [mod:alt,nocombat]Gastropod Shell;"..b("Wild Charge","[nomod:alt,form:3/6]",";").."[nomod:alt,noform:3/6]Travel Form(Shapeshift)\n/stopspelltarget\n/use Prismatic Bauble")
				if b("Nature's Vigil") == "Nature's Vigil" then override = "Nature's Vigil"
				elseif b("Heart of the Wild") == "Heart of the Wild" then override = "Heart of the Wild"
				end
				EditMacro("WSxCGen+F",nil,nil,"#show\n/use [nocombat,noexists]Mushroom Chair;"..b("Cenarion Ward","[]","").."\n/use "..override)
				if b("Innervate") == "Innervate" then override = "Innervate"
				elseif b("Renewal") == "Renewal" then override = "Renewal"
				else override = "Mark of the Wild"
				end
				EditMacro("WSxCAGen+F",nil,nil,"#show "..override.."\n/use [nocombat,noexists]Tear of the Green Aspect\n/targetfriend [nohelp,nodead]\n/cancelform [help,nodead]\n/use [help,nodead]Wild Charge\n/targetlasttarget\n/use Prismatic Bauble")
				if b("Nature's Cure") == "Nature's Cure" then override = "[@mouseover,help,nodead][help,nodead]Nature's Cure"
				elseif b("Remove Corruption") == "Remove Corruption" then override = "[@mouseover,help,nodead][help,nodead]Remove Corruption"
				else override = "Mark of the Wild"
				end
				EditMacro("WSxGenG",nil,nil,"/use [nocombat,noexists,mod]Darkmoon Gazer;"..b("Stampeding Roar","[mod]",";")..b("Soothe","[@mouseover,harm,nodead][harm,nodead]",";")..override.."\n/use Poison Extraction Totem")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..b("Maim","[form:2]",";")..b("Soothe","[]","").."\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]") 
				if b("Overgrowth") == "Overgrowth" then override = "[@party2,help,nodead,mod:alt][@mouseover,help,nodead][help,nodead][@party1,help,nodead][]Overgrowth"
				elseif b("Invigorate") == "Invigorate" then override = "[@party2,help,nodead,mod:alt][@mouseover,help,nodead][help,nodead][@party1,help,nodead][]Invigorate"
				elseif b("Cenarion Ward") == "Cenarion Ward" then override = "[@party2,help,nodead,mod:alt][@mouseover,help,nodead][help,nodead][@party1,help,nodead][]Cenarion Ward"
				end
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..override)
				EditMacro("WSxCSGen+G",nil,nil,"#show Dash\n/use [spec:4,@focus,help,nodead]Nature's Cure;[@focus,help,nodead]Remove Corruption\n/use Choofa's Call\n/cancelaura Blessing of Protection\n/cancelaura Enthralling")
				if b("Ironbark") == "Ironbark" then override = "[@mouseover,help,nodead][]Ironbark"
				elseif b("Survival Instincts") == "Survival Instincts" then override = "Survival Instincts"
				elseif b("Frenzied Regeneration") == "Frenzied Regeneration" then override = "[noform:1]Bear Form;[form:1]Frenzied Regeneration"
				else override = "Barkskin"
				end
				EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt,nocombat]Nature's Beacon;[mod]Barkskin;"..override.."\n/use [mod:alt]Gateway Control Shard")
				override = ""
				if b("Dreamwalk") == "Dreamwalk" then
					override = "Dreamwalk"
				elseif b("Teleport: Moonglade") == "Teleport: Moonglade" then
					override = "Teleport: Moonglade"
				end
				EditMacro("WSxGenX",nil,nil,"/use [mod:alt]Mount Form;[noform:2,mod:shift]!Cat Form;[mod:shift]Dash;"..b("Hibernate","[mod:ctrl,harm,nodead]",";").."[mod:ctrl]"..override..";"..b("Ironfur","[form:1]",";")..b("Swiftmend","[@mouseover,help,nodead][]","").."\n/stopmacro [stealth]\n/use Path of Elothir\n/use Prismatic Bauble")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use "..b("Frenzied Regeneration","[noform:1]Bear Form;[form:1]","").."\n/run PetDismiss();")
				EditMacro("WSxGenV",nil,nil,"#show "..b("Wild Charge","[]","").."\n/use "..b("Moonkin Form","[noform:4]",";")..b("Wild Charge","[@mouseover,exists,nodead][]","").."\n/use Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
		 		EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";"..b("Moonkin Form","[noform:4]",";!Flap;")..b("Wild Charge","[noform]Mount Form;[form]",";").."\n/cancelform [form:1/2]\n/cancelaura Prowl\n/use [mod:alt]Weathered Purple Parasol")				
			-- Demon Hunter, DH, Fannyvision, Dihy 
			elseif class == "DEMONHUNTER" then
				EditMacro("WSxGen1",nil,nil,"#show\n/use [@cursor]Fel Rush\n/targetenemy [noexists]\n/startattack\n/use Prismatic Bauble")
				EditMacro("WSxSGen+1",nil,nil,"#show\n/use Skull of Corruption")
				EditMacro("WSxGen2",nil,nil,"#show\n/use [nocombat,noexists]Verdant Throwing Sphere\n/targetlasttarget [noexists,nocombat]\n/use [harm,dead,nocombat,nomod]Soul Inhaler;[spec:1]Demon's Bite;[spec:2]Shear\n/cleartarget [dead]\n/targetenemy [noexists]\n/startattack")
				if b("Fel Eruption") == "Fel Eruption" then override = "Fel Eruption"
				elseif b("Fel Devastation") == "Fel Devastation" then override = "Fel Devastation"
				else override = "Gnomish X-Ray Specs"
				end
				EditMacro("WSxSGen+2",nil,nil,"#show "..override.."\n/use Gnomish X-Ray Specs\n/use "..override.."\n/startattack\n/targetenemy [noexists]\n/cleartarget [dead]")
			 	if b("Felblade") == "Felblade" then override = "Felblade"
				elseif playerSpec == 2 then override = "Demon Spikes"
				else override = "[@mouseover,harm,nodead][]Throw Glaive"
				end
				EditMacro("WSxGen3",nil,nil,"#show\n/use "..override.."\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]\n/use Imp in a Ball")
				EditMacro("WSxSGen+3",nil,nil,"#show\n/use [@mouseover,harm,nodead,nomod:alt][nomod:alt]Throw Glaive;[nocombat]Legion Pocket Portal\n/targetenemy [noexists]\n/startattack\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Throw Glaive\n/targetlasttarget")
				if playerSpec == 2 then override = "Demon Spikes"
				elseif b("Eye Beam") == "Eye Beam" then override = "Eye Beam"
				end
				EditMacro("WSxGen4",nil,nil,"#show\n/use "..override.."\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
			 	if b("Sigil of Flame") == "Sigil of Flame" then override = "[@mouseover,exists,nodead][@cursor]Sigil of Flame"
				elseif b("Glaive Tempest") == "Glaive Tempest" then override = "Glaive Tempest"
				elseif b("Fel Barrage") == "Fel Barrage" then override = "Fel Barrage"
				elseif b("Shear") == "Shear" then override = "Shear"
				end
				EditMacro("WSxSGen+4",nil,nil,"#show\n/stopspelltarget\n/use "..override.."\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
			 	if b("The Hunt") == "The Hunt" then override = "[@mouseover,harm,nodead][]The Hunt"
				elseif b("Bulk Extraction") == "Bulk Extraction" then override = "Bulk Extraction"
				elseif b("Soul Barrier") == "Soul Barrier" then override = "Soul Barrier"
				elseif b("Fel Barrage") == "Fel Barrage" then override = "Fel Barrage"
				elseif b("Glaive Tempest") == "Glaive Tempest" then override = "Glaive Tempest"
				elseif b("Darkness") == "Darkness" then override = "Darkness"
				elseif b("Fiery Brand") == "Fiery Brand" then override = "Fiery Brand"
				end
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..override.."\n/targetenemy [noexists]\n/startattack")
				EditMacro("WSxGen5",nil,nil,"#show\n/use "..b("Darkness","[mod:ctrl]",";").."Chaos Strike\n/use [mod:ctrl]Shadescale\n/startattack\n/targetenemy [noexists]")
				if b("Essence Break") == "Essence Break" then override = "Essence Break"
				elseif b("Chaos Nova") == "Chaos Nova" then override = "Chaos Nova"
				end
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use [spec:2,@player]Infernal Strike;"..override.."\n/targetenemy [noexists]\n/startattack")
				if b("Soul Carver") == "Soul Carver" then override = "Soul Carver"
				elseif playerSpec == 2 and b("Immolation Aura") == "Immolation Aura" then override = "Immolation Aura"
				else override = "Blade Dance"
				end
				EditMacro("WSxGen6",nil,nil,"#show\n/stopspelltarget\n/use [mod:ctrl,@mouseover,exists,nodead][mod:ctrl,@cursor]Metamorphosis;"..override.."\n/targetenemy [noexists]")
				if b("Sigil of Flame") == "Sigil of Flame" then override = "[@player]Sigil of Flame"
				elseif playerSpec == 2 and  b("Demon Spikes") == "Demon Spikes" then override = "Demon Spikes"
				elseif b("Immolation Aura") == "Immolation Aura" then override = "Immolation Aura"
				end
				EditMacro("WSxSGen+6",nil,nil,"#show\n/use "..override.."\n/stopspelltarget")
				if b("Elysian Decree") == "Elysian Decree" then overrideModAlt = "[@player,mod:shift]Elysian Decree;"
				end
				if b("Spirit Bomb") == "Spirit Bomb" then override = "Spirit Bomb"
				elseif b("Soul Carver") == "Soul Carver" then override = "Soul Carver"
				elseif b("Immolation Aura") == "Immolation Aura" then override = "Immolation Aura"
				end
				EditMacro("WSxGen7",nil,nil,"#show\n/stopspelltarget\n/use "..overrideModAlt..override.."\n/targetenemy [noexists]")
				if b("Elysian Decree") == "Elysian Decree" then override = "[@player,mod:shift][@mouseover,exists,nodead][@cursor]Elysian Decree"
				elseif b("Glaive Tempest") == "Glaive Tempest" then override = "Glaive Tempest"
				elseif b("Fel Barrage") == "Fel Barrage" then override = "Fel Barrage"
				elseif b("Immolation Aura") == "Immolation Aura" then override = "Immolation Aura"
				end
				EditMacro("WSxGen8",nil,nil,"#show\n/stopspelltarget\n/use "..override)
				if b("Fel Barrage") == "Fel Barrage" then override = "Fel Barrage"
				else override = "Immolation Aura"
				end
				EditMacro("WSxGen9",nil,nil,"#show\n/stopspelltarget\n/use "..override)
				EditMacro("WSxCSGen+2",nil,nil,"")
				EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noexists]The Perfect Blossom;[@focus,harm,nodead]Throw Glaive;Fel Petal;")
				EditMacro("WSxCSGen+4",nil,nil,"")
				EditMacro("WSxCSGen+5",nil,nil,"/clearfocus")
				EditMacro("WSxGenQ",nil,nil,"/use "..b("Imprison","[mod:alt,@focus,harm,nodead]",";").."[@mouseover,harm,nodead][]Disrupt")
				EditMacro("WSkillbomb",nil,nil,"/use [@player]Metamorphosis\n/use [@player]13\n/use 13"..dpsRacials.."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
				EditMacro("WSxGenE",nil,nil,"#show\n/stopspelltarget\n/use "..b("Sigil of Misery","[@mouseover,exists,nodead,nomod:alt][@cursor,nomod:alt]",";")..b("Chaos Nova","[mod:alt][]",""))
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..b("Sigil of Misery","[mod:alt,@player]","")..oOtas..covToys)
				if b("Sigil of Silence") == "Sigil of Silence" then override = "[mod:alt,@player][@cursor]Sigil of Silence"
				elseif b("Sigil of Misery") == "Sigil of Misery" then override = "[mod:alt,@player][@cursor]Sigil of Misery"
				end
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..override)
				EditMacro("WSxGenR",nil,nil,"#show\n/use "..b("Netherwalk","[mod:ctrl]!",";")..b("Sigil of Chains","[mod:ctrl,@player][mod:shift,@cursor]",";").."[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Throw Glaive\n/startattack")
				EditMacro("WSxGenT",nil,nil,"#show\n/use !Spectral Sight\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+T",nil,nil,"#show Torment\n/use "..b("Sigil of Chains","[mod:alt,@player]",";").."Torment\n/targetenemy [noexists]\n/cleartarget [dead]")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use ")
			    override = ""
			    if b("Darkness") == "Darkness" then override = "Darkness"
			    elseif b("Chaos Nova") == "Chaos Nova" then override = "Chaos Nova"
				end
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..override)
				EditMacro("WSxGenF",nil,nil,"#show "..b("Sigil of Misery").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,exists,nodead]All-Seer's Eye;[mod:alt]Legion Communication Orb;[@focus,harm,nodead]Disrupt;[nocombat,noexists]Micro-Artillery Controller")
				if b("Sigil of Silence") == "Sigil of Silence" then override = "Sigil of Silence"
				elseif b("Netherwalk") == "Netherwalk" then override = "!Netherwalk"
				end
				EditMacro("WSxSGen+F",nil,nil,"#show "..override.."\n/use [help,nocombat,mod:alt]B. F. F. Necklace;[nocombat,noexists,mod:alt]Gastropod Shell\n/cancelaura Spectral Sight")
				EditMacro("WSxCGen+F",nil,nil,"#show Glide\n/cancelaura Wyrmtongue Disguise")
				if b("Sigil of Chains") == "Sigil of Chains" then override = "Sigil of Chains"
				else override = "Fel Rush"
				end
				EditMacro("WSxCAGen+F",nil,nil,"#show "..override.."\n/run if not InCombatLockdown() then if GetSpellCharges(195072)>=1 then "..tpPants.." else "..noPants.." end end")
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]S.F.E. Interceptor;"..b("Consume Magic","[@mouseover,harm,nodead][]","").."\n/use Mirror of Humility")
				if b("Fel Eruption") == "Fel Eruption" then override = "Fel Eruption"
				elseif b("Chaos Nova") == "Chaos Nova" then override = "Chaos Nova"
				elseif b("Consume Magic") == "Consume Magic" then override = "Consume Magic"
				end
				EditMacro("WSxSGen+G",nil,nil,"/use "..override.."\n/use [noexists,nocombat] Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use ")
				EditMacro("WSxCSGen+G",nil,nil,"#show\n/use "..b("Consume Magic","[@focus,harm,nodead]","").."\n/use Wisp Amulet\n/cancelaura Netherwalk\n/cancelaura Spectral Sight\n/cancelaura Blessing of Protection")
				EditMacro("WSxGenH",nil,nil,"#show Spectral Sight\n/use Wisp Amulet\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				if b("Fiery Brand") == "Fiery Brand" then override = "Fiery Brand"
				elseif b("Blur") == "Blur" then override = "Blur"
				elseif b("Darkness") == "Darkness" then override = "Darkness"
				end
				EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;"..override)
				if b("Netherwalk") == "Netherwalk" then override = "[mod:shift][]!Netherwalk"
				elseif b("Soul Barrier") == "Soul Barrier" then override = "Soul Barrier"
				elseif b("Bulk Extraction") == "Bulk Extraction" then override = "Bulk Extraction"
				end
				EditMacro("WSxGenX",nil,nil,"#show\n/use "..override.."\n/use Shadescale")
				EditMacro("WSxGenC",nil,nil,"#show\n/use "..b("Imprison","[@mouseover,harm,nodead][]","").."\n/cancelaura X-Ray Specs")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/run PetDismiss();\n/cry")
				EditMacro("WSxGenV",nil,nil,"#show\n/use "..b("Vengeful Retreat","[]","").."\n/use Panflute of Pandaria\n/use Haw'li's Hot & Spicy Chili\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem\n/use Prismatic Bauble\n/use !Glide\n/use [mod:alt]Weathered Purple Parasol\n/dismount [mounted]")
			-- Evoker, Dracthyr, Debra, Dragon, draktard, dtard, lizzy
			elseif class == "EVOKER" then
				if b("Timelessness") == "Timelessness" then override = "[@mouseover,help,nodead][]Timelessness"
				elseif b("Echo") == "Echo" then override = "[@mouseover,help,nodead][]Echo"
				else override = "Hover"
				end
				EditMacro("WSxGen1",nil,nil,"#show\n/use "..override.."\n/targetenemy [noexists]\n/startattack\n/use Prismatic Bauble")
				EditMacro("WSxSGen+1",nil,nil,"#show Blessing of the Bronze\n/use [mod:alt,@party3,help,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Living Flame")
				EditMacro("WSxGen2",nil,nil,"#show Azure Strike\n/use Gnomish X-Ray Specs\n/use [@mouseover,harm,nodead][]Azure Strike\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxSGen+2",nil,nil,"/use [mod:alt,@party4,help,nodead][@mouseover,help,nodead][help,nodead][@player]Living Flame\n/targetlasttarget [noexists,nocombat]\n/use [help,nodead]Rainbow Generator\n/use Prismatic Bauble\n/cleartarget [dead]")
				if b("Upheaval") == "Upheaval" then override = "[@mouseover,harm,nodead][]Upheaval"
				elseif b("Eternity Surge") == "Eternity Surge" then override = "[@mouseover,harm,nodead][]Eternity Surge"
				elseif b("Spiritbloom") == "Spiritbloom" then override = "[@mouseover,help,nodead][]Spiritbloom"
				else override = "Fire Breath(Red)"
				end
				EditMacro("WSxGen3",nil,nil,"#show\n/use "..override.."\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxGen4",nil,nil,"#show\n/use [@mouseover,harm,nodead][]Disintegrate\n/cleartarget [dead]\n/targetenemy [noexists]")
				if b("Prescience") == "Prescience" then overrideModAlt = "[@party1,help,nodead,mod:alt]Prescience;"
				elseif b("Reversion") == "Reversion" then overrideModAlt = "[@party1,help,nodead,mod:alt]Reversion;"
				end
				if b("Ebon Might") == "Ebon Might" then override = "Ebon Might"
				elseif b("Shattering Star") == "Shattering Star" then override = "Shattering Star"
				elseif b("Firestorm") == "Firestorm" then override = "[@mouseover,exists,nodead][@cursor]Firestorm"
				elseif b("Pyre") == "Pyre" then override = "Pyre"
				elseif b("Temporal Anomaly") == "Temporal Anomaly" then override = "Temporal Anomaly"
				end
				EditMacro("WSxSGen+4",nil,nil,"#show\n/stopspelltarget\n/use "..overrideModAlt..override.."\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/stopspelltarget\n/use [@party3,help,nodead,mod:alt]Reversion;[@mouseover,exists,nodead][@cursor]Deep Breath\n/targetenemy [noexists]\n/startattack")
				overrideModAlt = ""
				if b("Zephyr") == "Zephyr" then overrideModAlt = "[mod:ctrl]Zephyr;"
				elseif b("Cauterizing Flame") == "Cauterizing Flame" then overrideModAlt = "[mod:ctrl]Cauterizing Flame;"
				elseif b("Time Spiral") == "Time Spiral" then overrideModAlt = "[mod:ctrl]Time Spiral;"
				end
				EditMacro("WSxGen5",nil,nil,"#show "..overrideModAlt.."Living Flame\n/use "..overrideModAlt.."[@mouseover,harm,nodead][harm,nodead]Living Flame\n/targetenemy [noexists]\n/use [mod:ctrl] Golden Dragon Goblet")
				if b("Prescience") == "Prescience" then overrideModAlt = "[@party2,help,nodead,mod:alt]Prescience;"
				elseif b("Reversion") == "Reversion" then overrideModAlt = "[@party2,help,nodead,mod:alt]Reversion;"
				end
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use "..overrideModAlt..b("Tip the Scales","[]","").."\n/targetenemy [noexists]\n/startattack")
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod:ctrl,@party4,help,nodead]Reversion;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14\n/use Eternal Black Diamond Ring")
				if b("Time Skip") == "Time Skip" then overrideModAlt = "[mod:ctrl]Time Skip;"
				elseif b("Dragonrage") == "Dragonrage" then overrideModAlt = "[mod:ctrl]Dragonrage;"
				elseif b("Emerald Communion") == "Emerald Communion" then overrideModAlt = "[mod:ctrl]!Emerald Communion;"
				end
				EditMacro("WSxGen6",nil,nil,"#show\n/cast "..overrideModAlt.."Fire Breath(Red)".."\n/targetenemy [noexists]")
				if b("Dream Breath") == "Dream Breath" then override = "Dream Breath"
				elseif b("Zephyr") == "Zephyr" then override = "Zephyr"
				elseif b("Rewind") == "Rewind" then override = "Rewind"
				elseif b("Firestorm") == "Firestorm" then override = "[@player]Firestorm"
				else override = "[@mouseover,help,nodead][help,nodead][@player]Emerald Blossom"
				end
				EditMacro("WSxSGen+6",nil,nil,"#show\n/cast "..override)

				if b("Firestorm") == "Firestorm" then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Firestorm"
				elseif b("Dream Flight(Green)") == "Dream Flight(Green)" then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Dream Flight(Green)"
				elseif b("Echo") == "Echo" then override = "[@mouseover,help,nodead][]Echo"
				elseif b("Pyre") == "Pyre" then override = "[@mouseover,harm,nodead][]Pyre"
				else override = "[@mouseover,harm,nodead][]Azure Strike"
				end
				EditMacro("WSxGen7",nil,nil,"#show\n/stopspelltarget\n/cast "..override.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				if b("Prescience") == "Prescience" then override = "Prescience"
				else override = "[@mouseover,harm,nodead][]Azure Strike"
				end
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..override.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				if b("Spatial Paradox") == "Spatial Paradox" then override = "Spatial Paradox"
				elseif b("Pyre") == "Pyre" then override = "Pyre"
				elseif b("Obsidian Scales") == "Obsidian Scales" then override = "Obsidian Scales"
				end
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..override)
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead,spec:2][@party1,help,nodead,spec:2][@targettarget,help,nodead,spec:2]Naturalize;[mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Expunge")
				EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Living Flame;[mod:alt,@party4,help,nodead,spec:2][@party2,help,nodead,spec:2]Naturalize;[mod:alt,@party4,help,nodead][@party2,help,nodead]Expunge\n/use [nocombat,noharm]Forgotten Feather")
				EditMacro("WSxCSGen+4",nil,nil,"/use "..b("Blistering Scales","[mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]","")..b("Echo","[mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]","").."\n/use [@party1]Apexis Focusing Shard")
				EditMacro("WSxCSGen+5",nil,nil,"/use "..b("Blistering Scales","[mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]","\n/use ")..b("Echo","[mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]","\n/use ").."Battle Standard of Coordination\n/use [@party2]Apexis Focusing Shard")
				EditMacro("WSxGenQ",nil,nil,"/use "..b("Sleep Walk","[mod:alt,@focus,harm,nodead]",";")..b("Quell","[@mouseover,harm,nodead][]",""))
				if b("Dragonrage") == "Dragonrage" then override = "/use Dragonrage"
				elseif b("Emerald Communion") == "Emerald Communion" then override = "/use !Emerald Communion"
				elseif b("Time Skip") == "Time Skip" then override = "/use !Time Skip"
				end
				EditMacro("WSkillbomb",nil,nil,override.."\n/use [@player]13\n/use 13"..dpsRacials.."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
				EditMacro("WSxGenE",nil,nil,"#show\n/use Tail Swipe")
				if b("Oppressing Roar") == "Oppressing Roar" then override = "Oppressing Roar"
				else override = "Hover"
				end
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..override..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use [@mouseover,help,nodead][help,nodead][@player]Emerald Blossom")
				if b("Time Spiral") == "Time Spiral" then override = "[mod:ctrl]Time Spiral;"
				else override = "[mod:ctrl]Hover;"
				end
				EditMacro("WSxGenR",nil,nil,"#show\n/stopspelltarget\n/use "..override.."[mod:shift]Wing Buffet;"..b("Landslide","[@mouseover,exists,nodead][@cursor]","").."\n/startattack")
				EditMacro("WSxGenT",nil,nil,"#show Wing Buffet\n/use "..b("Verdant Embrace","[@mouseover,help,nodead][]","").."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+T",nil,nil,"#show"..b("Rescue","\n/stopspelltarget\n/targetfriendplayer [nohelp,nodead]\n/use [@cursor]","").."\n/cleartarget [dead]")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..b("Echo","[mod:alt,@party4,nodead]",";"))
				EditMacro("WSxGenU",nil,nil,"#show "..b("Sleep Walk","[]",";")..b("Mass Return","[]",";").."Return")
				if b("Source of Magic") == "Source of Magic" then override = "Source of Magic"
				elseif b("Quell") == "Quell" then override = "Quell"
				end
				EditMacro("WSxGenF",nil,nil,"#show "..override.."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,exists,nodead]All-Seer's Eye;[mod:alt]Farwater Conch;"..b("Quell","[@focus,harm,nodead]",";"))
				EditMacro("WSxSGen+F",nil,nil,"#show Soar\n/use [help,nocombat,mod:alt]B. F. F. Necklace;[nocombat,noexists,mod:alt]Gastropod Shell\n/use Soar\n/use Hover")
				if b("Spatial Paradox") == "Spatial Paradox" then override = "[@mouseover,help,nodead][]Spatial Paradox"
				elseif b("Rewind") == "Rewind" then override = "Rewind"
				elseif b("Cauterizing Flame") == "Cauterizing Flame" then override = "[@mouseover,help,nodead][]Cauterizing Flame"
				end
				EditMacro("WSxCGen+F",nil,nil,"#show\n/use "..override.."\n/cancelaura Red Dragon Head Costume")
				EditMacro("WSxCAGen+F",nil,nil,"#show Emerald Blossom\n/use [nocombat,noexists]Tear of the Green Aspect"..b("Verdant Embrace","\n/targetfriend [nohelp,nodead]\n/use [help,nodead]","\n/targetlasttarget").."\n/use Prismatic Bauble")
				EditMacro("WSxGenG",nil,nil,"/use [mod:alt]Darkmoon Gazer;"..b("Unravel","[@mouseover,harm,nodead]",";").."[spec:2,@mouseover,help,nodead][spec:2]Naturalize;"..b("Expunge","[@mouseover,help,nodead][]","").."\n/targetenemy [noexists]\n/use Poison Extraction Totem")
				EditMacro("WSxSGen+G",nil,nil,""..b("Unravel","#show ","\n").."/use "..b("Unravel","[@mouseover,harm,nodead][harm,nodead]",";").."Expunge\n/use [noexists,nocombat]Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..b("Echo","[mod:alt,@party3,nodead]",";")..b("Cauterizing Flame","[@mouseover,help,nodead][]",";"))
				EditMacro("WSxCSGen+G",nil,nil,"#show "..b("Cauterizing Flame","[]","").."\n/use [@focus,help,nodead,spec:2]Naturalize;"..b("Expunge","[@focus,help,nodead]",";").."\n/use Choofa's Call")
				EditMacro("WSxGenH",nil,nil,"#show "..b("Verdant Embrace").."\n/use "..b("Cauterizing Flame","[@mouseover,help,nodead][]",";").."Wisp Amulet\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenZ",nil,nil,"#show\n/use "..b("Black Attunement","[mod:alt,nostance:1]!",";")..b("Bronze Attunement","[mod:alt,stance:1]!",";")..b("Time Dilation","[@mouseover,help,nodead,nomod][nomod]",";")..b("Obsidian Scales","[mod:shift][nomod]","").."\n/use [mod:alt]Gateway Control Shard")
				if b("Renewing Blaze") == "Renewing Blaze" then override = "Renewing Blaze"
				else override = "Emerald Blossom"
				end
				EditMacro("WSxGenX",nil,nil,"#show\n/use "..b("Bestow Weyrnstone","[@mouseover,help,nodead,mod:alt][mod:alt]",";")..b("Deep Breath","[mod:shift]",";")..override.."\n/use Shadescale")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/run PetDismiss();\n/cry")
				EditMacro("WSxGenV",nil,nil,"#show\n/use Hover\n/use [nomod]Panflute of Pandaria\n/use Haw'li's Hot & Spicy Chili\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble\n/use Whelps on Strings")
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem\n/use Prismatic Bauble\n/use !Glide\n/use [mod:alt]Weathered Purple Parasol\n/dismount [mounted]")
				if playerSpec == 3 then
					EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxCGen+G\",nil,nil,\"\\#show Prescience\\n/use [@\"..N..\"]Prescience\\n/stopspelltarget\", nil)print(\"PSci 1 : \"..N)else print(\"Combat?\")end")
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxCGen+T\",nil,nil,\"\\#show Prescience\\n/use [@\"..N..\"]Prescience\\n/stopspelltarget\", nil)print(\"PSci 2 : \"..N)else print(\"Combat?\")end")
				end 
			end -- avslutar class
		end	-- avslutar racials[race]			
	end -- events	
end
frame:SetScript("OnEvent", eventHandler)