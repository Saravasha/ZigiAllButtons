local frame = CreateFrame("FRAME", "ZigiAllButtons")

local throttled = false
local throttledMessage = false

frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
frame:RegisterEvent("BAG_UPDATE_DELAYED")
frame:RegisterUnitEvent("PET_SPECIALIZATION_CHANGED")
frame:RegisterEvent("PET_STABLE_CLOSED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("VARIABLES_LOADED")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("TRAIT_CONFIG_UPDATED")
--[[frame:RegisterEvent("PLAYER_ENTERING_WORLD")--]]
--frame:RegisterEvent("PLAYER_LEVEL_UP")

--[[/use [nomounted]Eternal Black Diamond Ring
/run if IsControlKeyDown() then C_PartyInfo.LeaveParty() elseif IsShiftKeyDown() then LFGTeleport(IsInLFGDungeon()) end
--]]

-- bind to function
local function b(spellName, macroCond, semiCol)

	local _,class = UnitClass("player")
	
	-- Class Spec Talent List
	local classSpecTalentList = {
		["SHAMAN"] = { 
			[108285] = "Totemic Recall",
			[117014] = "Elemental Blast",
			[33757] = "Windfury Weapon",
			[8512] = "Windfury Totem",
			[192249] = "Storm Elemental",
			[157153] = "Cloudburst Totem",
			[188443] = "Chain Lightning",
			[51514] = "Hex",
			[192106] = "Lightning Shield",
			[198103] = "Earth Elemental",
			[198067] = "Fire Elemental",
			[370] = "Purge",
			[51533] = "Feral Spirit",
			[17364] = "Stormstrike",
			[974] = "Earth Shield",
			[108281] = "Ancestral Guidance",
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
			[190319] = "Combustion", 
			[31661] = "Dragon's Breath", 
			[116011] = "Rune of Power", 
			[45438] = "Ice Block", 
			[31687] = "Summon Water Elemental", 
			[12472] = "Icy Veins", 
			[365350] = "Arcane Surge", 
			[84714] = "Frozen Orb", 
			[110959] = "Greater Invisibility", 
			[30449] = "Spellsteal", 
			[5143] = "Arcane Missiles", 
			[321358] = "Focus Magic", 
			[55342] = "Mirror Image", 
			[153561] = "Meteor", 
			[190356] = "Blizzard", 
			[205022] = "Arcane Familiar", 
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
		},
		["WARLOCK"] = {
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
			[387073] = "Soul Tap",
			[196447] = "Channel Demonfire",
			[333889] = "Fel Domination",
			[27243] = "Seed of Corruption",
			[108416] = "Dark Pact",
			[386833] = "Guillotine",
			[316099] = "Unstable Affliction",
			[264057] = "Soul Strike",
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
		},
		["MONK"] = {
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
			[388193] = "Faeline Stomp",
			[322507] = "Celestial Brew",
			[121253] = "Keg Smash",
			[115181] = "Breath of Fire",
			[322118] = "Invoke Yu'lon, the Jade Serpent",
			[115310] = "Revival",
			[386276] = "Bonedust Brew",
			[196725] = "Refreshing Jade Wind",
			[387184] = "Weapons of Order",
			[197908] = "Mana Tea",
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
			[105809] = "Holy Avenger",
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
		},
		["HUNTER"] = {
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
			[259391] = "Chakrams",
		},
		["ROGUE"] = { 
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
			[381802] = "Indiscriminate Carnage",
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
			[214621] = "Schism",
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
			[341374] = "Damnation",
			[64044] = "Psychic Horror",
			[47585] = "Dispersion",
			[263346] = "Dark Void",
			[372835] = "Lightwell",
			[213634] = "Purify Disease",
			[122121] = "Divine Star",
		},
		["DEATHKNIGHT"] = {
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
			[376079] = "Spear of Bastion",
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
			[197625] = "Moonkin Form",
		},
		["DEMONHUNTER"] = {
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
			[359816] = "Dream Flight",
			[366155] = "Reversion",
			[369459] = "Source of Magic",
			[370960] = "Emerald Communion",
			[374348] = "Renewing Blaze",
		},
	}
	classSpecTalentList = classSpecTalentList[class]
	for k,v in pairs(classSpecTalentList) do
		if v == spellName then
			if IsPlayerSpell(k) or IsSpellKnown(k) then
				-- return (select(1,GetSpellInfo(k)))
				-- v[1] = spellName
				-- v[2] = macroCond
				print(spellName)
 				return (macroCond or "")..((select(1,GetSpellInfo(k))) or "")..(semiCol or "")
			end 
		end
	end
	return fallback or ""
end

local function eventHandler(self, event)

	if InCombatLockdown() then
		frame:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		frame:UnregisterEvent("PLAYER_REGEN_ENABLED")


		-- Template Class Table

		-- if class == "SHAMAN" then
		-- elseif class == "MAGE" then 
		-- elseif class == "WARLOCK" then
		-- elseif class == "MONK" then 
		-- elseif class == "PALADIN" then
		-- elseif class == "HUNTER" then
		-- elseif class == "ROGUE" then
		-- elseif class == "PRIEST" then
		-- elseif class == "DEATHKNIGHT" then
		-- elseif class == "WARRIOR" then
		-- elseif class == "DRUID" then
		-- elseif class == "DEMONHUNTER" then
		-- elseif class == "EVOKER" then
		-- else

		-- Configure Battlefield Map
		if BattlefieldMapFrame then 
			BattlefieldMapFrame:SetScale(1.4)
			-- BattlefieldMapFrame:SetAlpha(1)
			BattlefieldMapFrame:SetPoint("TOPLEFT")
		end

		local faction = UnitFactionGroup("player")
		local _,race = UnitRace("player")
		local _,class = UnitClass("player")

		local level = UnitLevel("player")
		local eLevel = UnitEffectiveLevel("player")

		local z, m, mA, mP = GetZoneText(), "", "", ""

		local instanceName, instanceType, difficultyID, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance, mapID, instanceGroupSize = GetInstanceInfo()
		
		local playerspec = GetSpecialization(false,false)

		local petspec = GetSpecialization(false,true)
		local pwned = "Horde Flag of Victory"
		if faction == "Alliance" then 
			pwned = "Alliance Flag of Victory" 
		end
		if class == "WARLOCK" then
			pwned = "Drust Ritual Knife"
		end
		if class == "HUNTER" then
			pwned = "Warbeast Kraal Dinner Bell"
		end

		if class == "MAGE" and playerspec == 2 then
			pwned = "Cremating Torch"
		end

		local fftpar = "Firefury Totem"
		if faction == "Alliance" then
			fftpar = "Touch of the Naaru"
		end
		local factionMurloc = "Gillvanas"
		if faction == "Alliance" then
			factionMurloc = "Finduin"
		end
		local factionPride = "Darkspear Pride"
		if faction == "Alliance" then
			factionPride = "Gnomeregan Pride"
		end
		local factionFireworks = "Everlasting Horde Firework"
		if faction == "Alliance" then
			factionFireworks = "Everlasting Alliance Firework"
		end
		local passengerMount = "Orgrimmar Interceptor"

		local covenantsEnum = {
			1,
			2,
			3,
			4,
		}

		local bfaIsland = ((select(3, GetInstanceInfo())))	
		local slBP = C_Covenants.GetActiveCovenantID(covenantsEnum)
		if class == "PRIEST" then
			passengerMount = "The Hivemind"
		elseif faction == "Alliance" then 
			passengerMount = "Stormwind Skychaser" 
		end
		local one = ""
		local two = ""
		local tre = ""
		local glider = GetItemCount("Goblin Glider Kit") 
		local brazier = GetItemCount("Brazier of Awakening")
		-- Battle of Dazar'alor, Mercenary BG Racial parser
		if IsSpellKnown(28730) then 
			race = "BloodElf" 
		elseif IsSpellKnown(28880) then 
			race = "Draenei"
		elseif IsSpellKnown(265221) then 
			race = "DarkIronDwarf"
		elseif IsSpellKnown(20594) then 
			race = "Dwarf"
		elseif IsSpellKnown(20589) then 
			race = "Gnome"
		elseif (IsSpellKnown(69041) or IsSpellKnown(69070)) then 
			race = "Goblin"
		elseif IsSpellKnown(255654) then 
			race = "HighmountainTauren"
		elseif IsSpellKnown(59752) then 
			race = "Human"
		elseif IsSpellKnown(287712) then 
			race = "KulTiran"
		elseif IsSpellKnown(255647) then 
			race = "LightforgedDraenei"	
		elseif IsSpellKnown(274738) then 
			race = "MagharOrc"
		elseif IsSpellKnown(312924) then 
			race = "Mechagnome"
		elseif IsSpellKnown(260364) then 
			race = "Nightborne"
		elseif IsSpellKnown(58984) then 
			race = "NightElf"
		elseif IsSpellKnown(20572) then 
			race = "Orc"
		elseif IsSpellKnown(107079) then 
			race = "Pandaren"
		elseif IsSpellKnown(7744) then 
			race = "Scourge"
		elseif IsSpellKnown(20549) then 
			race = "Tauren"
		elseif IsSpellKnown(26297) then 
			race = "Troll"
		elseif IsSpellKnown(256948) then 
			race = "VoidElf"
		elseif IsSpellKnown(312411) then 
			race = "Vulpera"
		elseif IsSpellKnown(68992) then 
			race = "Worgen"
		elseif IsSpellKnown(291944) then 
			race = "ZandalariTroll"
		elseif IsSpellKnown(358733) then
			race = "Dracthyr"
		end

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
			["Vulpera"] = "[mod]Return to Camp;[@mouseover,exists,nodead][]Bag of Tricks",
			["Worgen"] = "Darkflight",
			["ZandalariTroll"] = "Regeneratin'",
			["Dracthyr"] = "Visage",
		}
		local dpsRacials = {
			["MagharOrc"] = "Ancestral Call",
			["Orc"] = "Blood Fury",
			["Troll"] = "Berserking",
			["DarkIronDwarf"] = "Fireblood",
			["Mechagnome"] = "Hyper Organic Light Originator",
		}
		if dpsRacials[race] then
			dpsRacials[race] = "\n/use "..dpsRacials[race]
		else 
			dpsRacials[race] = ""	
		end
		local extraRacials = {
			["DarkIronDwarf"] = "Mole Machine",
			["Goblin"] = "[@mouseover,harm,nodead][harm,nodead]Rocket Barrage;Pack Hobgoblin",
			["LightforgedDraenei"] = "Forge of Light",
			["Mechagnome"] = "Skeleton Pinkie",
			["Nightborne"] = "[nocombat,noexists]Cantrips;Nightborne Guard's Vigilance",
			["Scourge"] = "Cannibalize",
			["VoidElf"] = "Spatial Rift",
			["Vulpera"] = "[mod]Make Camp;Rummage Your Bag",
			["Worgen"] = "Two Forms",
			["Dracthyr"] = "Chosen Identity",
			["ZandalariTroll"] = "Pterrordax Swoop",
		}
		if not extraRacials[race] and class == "SHAMAN" then
			extraRacials[race] = b("Wind Rush Totem","[@player]","")..b("Earthgrab Totem","[@player]","")..";Zandalari Effigy Amulet"
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

		local cov = {
			[0] = "",
			[1] = "Kyrian",
			[2] = "Venthyr",
			[3] = "Night Fae",
			[4] = "Necrolord",
		}

		-- Covenant Hearthstone
		local covHS = {
			[0] = "Hearthstone",
			[1] = "Kyrian Hearthstone",
			[2] = "Venthyr Sinstone",
			[3] = "Night Fae Hearthstone",
			[4] = "Necrolord Hearthstone",
		} 
		

        local covPets = {
        	[0] = {""},
        	[1] = {"Ruffle","Lost Featherling","Steward Featherling","Courage","Purity","Larion Pouncer","Helpful Glimmerfly", },
        	[2] = {"Sinheart","Burdened Soul", "Dal", "Dredger Butler", "Will of Remornia", "Char"},
        	[3] = {"Trootie","Floofa", "Gloober, as G'huun", "Sir Reginald", "Lavender Nibbler", "Willowbreeze"},
        	[4] = {"Jiggles","Micromancer","Minimancer","Toenail","Shy Melvin","Oonar's Arm", "Sludge Feeler"},
        }
       	covPets = covPets[slBP]
       	covPets = covPets[random(#covPets)]
        		
		-- Hearthstones
		local HS = {
			["SHAMAN"] = "Eternal Traveler's Hearthstone",
			["MAGE"] = "Fire Eater's Hearthstone",
			["WARLOCK"] = "Headless Horseman's Hearthstone",
			["MONK"] = "Brewfest Reveler's Hearthstone",
			["PALADIN"] = "Hearthstone",
			["HUNTER"] = covHS[slBP],
			["ROGUE"] = covHS[slBP],
			["PRIEST"] = covHS[slBP],
			["DEATHKNIGHT"] = covHS[slBP],
			["WARRIOR"] = "The Innkeeper's Daughter",
			["DRUID"] = "Noble Gardener's Hearthstone",
			["DEMONHUNTER"] = covHS[slBP],
			["EVOKER"] = "",
		}
			
		local hsToy = {
			["SHAMAN"] = "\n/use Portable Audiophone\n/use Underlight Sealamp",
			["MAGE"] = "\n/use [harm,nodead]Gaze of the Darkmoon;Magic Fun Rock",
			["WARLOCK"] = "\n/cancelaura Golden Hearthstone Card: Lord Jaraxxus\n/use Golden Hearthstone Card: Lord Jaraxxus",
			["MONK"] = "\n/use Brewfest Chowdown Trophy",
			["PALADIN"] = "\n/use Jar of Sunwarmed Sand",
			["HUNTER"] = "\n/use Tiny Mechanical Mouse",
			["ROGUE"] = "\n/use Cursed Spyglass",
			["PRIEST"] = "\n/use Steamy Romance Novel Kit\n/cancelaura For da Blood God!\n/use For da Blood God!",
			["DEATHKNIGHT"] = "\n/use Coldrage's Cooler",
			["WARRIOR"] = "\n/cancelaura Tournament Favor\n/use Tournament Favor\n/use Kovork Kostume",
			["DRUID"] = "\n/cancelaura Make like a Tree\n/use Ancient's Bloom\n/use Stave of Fur and Claw",
			["DEMONHUNTER"] = "\n/cancelaura Golden Hearthstone Card: Lord Jaraxxus\n/use Golden Hearthstone Card: Lord Jaraxxus",
			["EVOKER"] = "",
		}
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

		local slZones = {
			["Cosmic"] = true,
			["Bastion"] = true,
			["Maldraxxus"] = true,
			["Ardenweald"] = true,
			["Revendreth"] = true,
			["The Shadowlands"] = true,
			["Oribos"] = true,
			["The Maw"] = true,
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

		local EQS = {
			[1] = "Noon!",
			[2] = "DoubleGate",
			[3] = "Menkify!",
			[4] = "Supermenk",
			[5] = "",
		}
		-- speciella item sets
		
		local tpPants, noPants = "Tipipants",EQS[playerspec]
		if C_EquipmentSet.GetEquipmentSetID(tpPants) ~= nil then
			tpPants = C_EquipmentSet.GetEquipmentSetID(tpPants)
			noPants = C_EquipmentSet.GetEquipmentSetID(noPants)
			tpPants = "C_EquipmentSet.UseEquipmentSet("..tpPants..")" 
			noPants = "C_EquipmentSet.UseEquipmentSet("..noPants..")"
		end
	 
		-- set spec title
		local SST = {
		-- Shaman titles
			[1] = "Gorgeous",
			[2] = "Storm's End",
			[3] = "Gorgeous",
		}
		if UnitName("player") == "Raxana" and class == "SHAMAN" and race == "Orc" then
			SST = {
				[1] = "Mistwalker", 
				[2] = "Lady of War",
				[3] = "of the Deeps",
			}
		elseif class == "MAGE" then
			SST = {
				[1] = "Headmistress", 
				[2] = "Flame Keeper",
				[3] = "Merrymaker",
			}
		elseif class == "WARLOCK" then
			SST = {
				[1] = "of The Black Harvest", 
				[2] = "Matron",
				[3] = "Netherlord",
			}
			if (UnitName("player") == "Darkglace" or UnitName("player") == "Voidlisa") and playerspec == 2 then
				SST = {
					[2] = "Lady of War",
				}
			end
		elseif class == "MONK" then
			SST = {
				[1] = "Brewmaster", 
				[2] = "the Tranquil Master",
				[3] = "Shado",
			}
		elseif class == "PALADIN" then
			SST = {
				[1] = "The Lightbringer", 
				[2] = "Highlord",
				[3] = "Gorgeous",
			}
			if UnitName("player") == "Blackvampkid" and playerspec == 3 then
				SST = { 
				[3] = "Lady of War",
			}
			end
		elseif class == "HUNTER" then
			SST = {
				[1] = "Zookeeper", 
				[2] = "Tower Ranger",
				[3] = "Predator",
			}
		elseif class == "ROGUE" then
			SST = {
				[1] = "The Kingslayer", 
				[2] = "Captain",
				[3] = "Shadowblade",
			}
		elseif class == "PRIEST" then
			SST = {
				[1] = "The Argent Champion", 
				[2] = "Gorgeous",
				[3] = "The Insane",
			}					
		elseif class == "DEATHKNIGHT" then
			SST = {
				[1] = "Baron", 
				[2] = "Abominable",
				[3] = "Deathlord",
			} 					
		elseif class == "WARRIOR" then
			if race == "Scourge" then
				SST = {
					[1] = "Lady of War", 
					[2] = "Lady of War",
					[3] = "The Proven Defender",
				}
			else
				SST = {
					[1] = "The Chosen", 
					[2] = "Battlelord",
					[3] = "The Proven Defender",
				}
			end
		elseif class == "DRUID" then
			SST = {
				[1] = "Starcaller", 
				[2] = "The Crazy Cat Lady",
				[3] = "Guardian of Cenarius",
				[4] = "The Dreamer",
			}					
		elseif class == "DEMONHUNTER" then
			SST = {
				[1] = "Demonslayer", 
				[2] = "Vengeance Incarnate",
			}
		elseif class == "EVOKER" then
			SST = {
				[1] = "Talon Queen", 
				[2] = "Wakener",
			}					
        end

        if IsEquippedItem("Mirror of the Blademaster") then
        	SST[playerspec] = "Timelord"
        end

		local invisPot = "Stealthman 54"

		local hasBell = "Cooking School Bell"

		if EQS[playerspec] then

			EditMacro("WSpecs!",nil,nil,"/equipset "..EQS[playerspec].."\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 elseif(IsModifierKeyDown())then x=4 end if(x~=GetSpecialization())then SetSpecialization(x) end\n/stopcasting")
		end
		
		local oOtas = "\n/use Orb of Deception"
		if race ~= "BloodElf" and eLevel >= 25 then
			oOtas = "\n/use Orb of the Sin'dorei"
		end

		if eLevel < 20 then
			oOtas = oOtas.."\n/use Toy Armor Set\n/use Toy Weapon Set"
		else
			oOtas = oOtas
		end
		-- Class exception pvp macros.
		local warPvPExc = ""

		local locPvPExcQQ = "[@mouseover,exists,nodead][]Command Demon"
		local locPvPExcSThree = ""
		local locPvPExcGenF = "[@focus,harm,nodead]Command Demon;"
		local ptdSG = GetItemCount("Protocol Transference Device")
		local chameleon = IsSpellKnown(61648)
		if chameleon == true then
			chameleon = "Aspect of the Chameleon"
		elseif chameleon == false then 
			chameleon = "Hunter's Call"
		end 
     	-- ptdSG, mechanical device
		if ptdSG >=1 then
			ptdSG = "[mod:alt]Protocol Transference Device;"
		elseif ptdSG <= 1 then 
			ptdSG = ""
		end

		-- Target BG Healers and Set BG Healers // Helpful measures in non-pvp areas
		local numaltcc = {
			["SHAMAN"] = "Hex",
			["MAGE"] = "Polymorph",
			["WARLOCK"] = "Command Demon",
			["MONK"] = "Paralysis",
			["PALADIN"] = "Blessing of Sacrifice",
			["HUNTER"] = "Intimidation",
			["ROGUE"] = "Blind",
			["PRIEST"] = "Mind Bomb",
			["DEATHKNIGHT"] = "Asphyxiate",
			["WARRIOR"] = "Storm Bolt",
			["DRUID"] = "Cyclone", 
			["DEMONHUNTER"] = "Imprison",
			["EVOKER"] = "",
		}
		local numctrlcc = {
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
			["EVOKER"] = "",
		}
		if class == "ROGUE" and playerspec == 2 then
			numctrlcc[class] = "Kidney Shot"
		end
		local numnomodcc = {
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
			["EVOKER"] = "",
		}

		if class == "DRUID" then
			if (playerspec == 2 or playerspec == 3) then
				numnomodcc[class] = "Skull Bash"
			elseif playerspec == 4 then
				numnomodcc[class] = "Cyclone"
			end
		end 

		-- Global Addon Messages
		if event == "BAG_UPDATE_DELAYED" and not throttledMessage then 
			throttledMessage = true
	        C_Timer.After(2, function()
	            -- denna kod körs efter 2 sekunder
	            throttledMessage = false
	        end)
		DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: BAG_UPDATE_DELAYED\nRecalibrating related macros :)",0.5,1.0,0.0)
		elseif event == "PET_SPECIALIZATION_CHANGED" and not throttledMessage then 
			throttledMessage = true
	        C_Timer.After(2, function()
	            -- denna kod körs efter 2 sekunder
	            throttledMessage = false
	        end)
			DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: PET_SPECIALIZATION_CHANGED\nRecalibrating related macros :)",0.5,1.0,0.0)
		elseif event == "ZONE_CHANGED_NEW_AREA" and not throttledMessage then 
			throttledMessage = true
	        C_Timer.After(2, function()
	            -- denna kod körs efter 2 sekunder
	            throttledMessage = false
	        end)
			DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: ZONE_CHANGED_NEW_AREA\nRecalibrating related macros :)",0.5,1.0,0.0)
		elseif event == "GROUP_ROSTER_UPDATE" and not throttledMessage then 
			eventHandler()
			throttledMessage = true
	        C_Timer.After(2, function()
	            -- denna kod körs efter 2 sekunder
	            throttledMessage = false
	        end)
			DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: GROUP_ROSTER_UPDATE\nRecalibrating related macros :)",0.5,1.0,0.0)
		end

		-- Här börjar Events
		-- Login,zone,bag_update based event, Swapper, Alt+J parser, Call Companion, set class/spec toys.
		-- Zone och bag baserade events
		if (event == "ZONE_CHANGED_NEW_AREA" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "BAG_UPDATE_DELAYED" or event == "PET_SPECIALIZATION_CHANGED" or event == "PLAYER_LOGIN" or event == "TRAIT_CONFIG_UPDATED") and not throttled then 
			throttled = true
	        C_Timer.After(2, function()
	            -- denna kod körs efter 2 sekunder
	            throttled = false
	        end)

	        local pets = ""
			local classText = ""
			if class == "SHAMAN" then
				classText = "#show "..b("Earth Elemental","","")
				if playerspec == 1 then
					pets = "\"Snowfang\",\"Pebble\",\"Zephyrian Prince\",\"Lil' Ragnaros\",\""..covPets.."\"" 
				elseif playerspec == 2 then
					pets = "\"Frostwolf Ghostpup\",\"Bound Stream\",\"Pebble\",\"Primal Stormling\",\""..covPets.."\""
				else
					classText = "#show "..b("Mana Tide Totem","","")
					pets = "\"Snowfang\",\"Bound Stream\",\"Pebble\",\"Drafty\",\""..covPets.."\""
				end
				if race == "Troll" then
					pets = "\"Sen'jin Fetish\",\"Lashtail Hatchling\",\"Searing Scorchling\",\"Mojo\",\""..covPets.."\""
				end
			elseif class == "MAGE" then
				classText = "/use Pilfered Sweeper" 
				pets = "\"Lil' Tarecgosa\",\"Trashy\",\"Wondrous Wisdomball\",\""..covPets.."\""
				if playerspec == 2 then
					pets = "\"Phoenix Hatchling\",\"Animated Tome\",\"Nethaera's Light\",\""..covPets.."\""
				elseif playerspec == 3 then
					pets = "\"Magical Crawdad\",\"Animated Tome\",\"Water Waveling\",\"Tiny Snowman\",\""..covPets.."\""
				end
			elseif class == "WARLOCK" then
				pets = "\"Eye of the Legion\",\"Cross Gazer\",\"Sister of Temptation\",\"Nibbles\",\""..covPets.."\""
				classText = ""
				if playerspec == 2 then
					pets = "\"Rebellious Imp\",\"Eye of the Legion\",\"Sister of Temptation\",\"Nibbles\",\"Baa'l\",\""..covPets.."\""
				elseif playerspec == 3 then
					pets = "\"Rebellious Imp\",\"Lesser Voidcaller\",\"Netherspace Abyssal\",\"Eye of the Legion\",\"Nibbles\",\""..covPets.."\""
				end
			elseif class == "MONK" then
				classText = "#show "..b("Faeline Stomp","","")
				local banfu = "\"Ban-Fu, Cub of Ban-Lu\""
				if playerspec == 1 then 
					pets = "\"Zao, Calfling of Niuzao\","..banfu..",".."\""..covPets.."\""
				elseif playerspec == 2 then 
					pets = {"Chi-Chi, Hatchling of Chi-Ji","Yu'la, Broodling of Yu'lon"}
					pets = "\""..pets[random(#pets)].."\","..banfu..",".."\""..covPets.."\""
				else
					pets = "\"Xu-Fu, Cub of Xuen\","..banfu..",".."\""..covPets.."\""
				end
			elseif class == "PALADIN" then
				classText = "#show "..b("Seraphim","","")
				pets = "\"K'ute\",\"Uuna\",\"Bound Lightspawn\",\""..factionMurloc.."\",\""..covPets.."\""
			elseif class == "HUNTER" then
				pets = "\"Rocket Chicken\",\"Nuts\",\"Tito\",\"Stormwing\",\"Son of Skum\",\""..covPets.."\""
				classText = "#show Hunter's Mark"
				if playerspec == 2 then
					pets = "\"Alarm-o-Bot\",\"Tito\",\"Stormwing\",\"Crow\",\""..covPets.."\""
				elseif playerspec == 3 then
					pets = "\"Alarm-o-Dog\",\"Baby Elderhorn\",\"Nuts\",\"Tito\",\"Stormwing\",\"Crow\",\""..covPets.."\""
				end
			elseif class == "ROGUE" then
				classText = "#show Vanish"
				pets = "\"Toxic Wasteling\",\"Spawn of Merektha\",\"Sneaky Marmot\",\"Creepy Crate\",\""..covPets.."\""
				if playerspec == 2 then
					pets = "\"Pocket Cannon\",\"Captain Nibs\",\"Sneaky Marmot\",\"Cap'n Crackers\",\""..covPets.."\""
				elseif playerspec == 3 then
					pets = "\"Bronze Whelpling\",\"Gilnean Raven\",\"Sneaky Marmot\",\"Creepy Crate\",\""..covPets.."\""
				end
			elseif class == "PRIEST" then
				classText = "#show "..b("Mass Dispel","","")
				pets = "\"Argi\",\"K'ute\",\"Dread Hatchling\",\"Shadow\",\"Uuna\",\""..covPets.."\""
				if playerspec == 2 then
					pets = "\"Bound Lightspawn\",\"K'ute\",\"Sunborne Val'kyr\",\"Uuna\",\""..covPets.."\""
				elseif playerspec == 3 then
					pets = "\"K'ute\",\"Hungering Claw\",\"Dread Hatchling\",\"Faceless Minion\",\""..covPets.."\""
				end
			elseif class == "DEATHKNIGHT" then
				classText = "#show "..b("Raise Dead")
				pets = "\"Bloodbrood Whelpling\",\"Blightbreath\",\"Boneshard\",\"Naxxy\",\""..covPets.."\""
				if playerspec == 2 then
					pets = "\"Frostbrood Whelpling\",\"Mr. Bigglesworth\",\"Boneshard\",\""..covPets.."\""	
				elseif playerspec == 3 then
					pets = "\"Vilebrood Whelpling\",\"Grotesque\",\"Unborn Val'kyr\",\"Mr. Bigglesworth\",\""..covPets.."\""
				end
			elseif class == "WARRIOR" then
				pets = "\"Darkmoon Rabbit\",\"Sunborne Val'kyr\",\""..factionMurloc.."\",\""..covPets.."\""
				classText = "/use "..factionPride..""
				-- druid
			elseif class == "DRUID" then
				if (race == "Tauren" and GetItemCount("Ancient Tauren Talisman") == 1) then
					hasBell = "Ancient Tauren Talisman"
				end
				classText = "#show Rebirth\n/use Wisp in a Bottle"
				pets = "\"Stardust\",\"Singing Sunflower\",\"Ragepeep\",\""..covPets.."\""
				if playerspec == 2 then
					pets = "\"Cinder Kitten\",\"Singing Sunflower\",\""..covPets.."\""
				elseif (UnitName("player") == "Fannylands" and playerspec == 3) then
					pets = "\"Nightmare Whelpling\",\"Nightmare Lasher\",\"Nightmare Treant\",\""..covPets.."\""
				elseif playerspec == 3 then
					pets = "\"Lil' Ursoc\",\"Singing Sunflower\",\""..covPets.."\""
				elseif playerspec == 4 then	
					pets = "\"Blossoming Ancient\",\"Broot\",\"Singing Sunflower\",\""..covPets.."\""
				end
			elseif class == "DEMONHUNTER" then
				pets = "\"Murkidan\",\"Emmigosa\",\"Abyssius\",\"Micronax\",\"Wyrmy Tunkins\",\"Fragment of Desire\",\""..covPets.."\""
				classText = ""
			elseif class == "EVOKER" then
				pets = ""
				hasBell = ""
				classText = ""
				SST[playerspec] = ""
			end
			
			-- Winter Veil Holiday Override
			if C_Calendar and C_DateAndTime then
				C_Calendar.SetMonth(0)
				local gHI = C_Calendar.GetHolidayInfo(0, C_DateAndTime.GetCurrentCalendarTime().monthDay, 1) and C_Calendar.GetHolidayInfo(0, C_DateAndTime.GetCurrentCalendarTime().monthDay, 1).name or ""
				-- print("gHI#1 = "..gHI)
				if gHI == "Feast of Winter Veil" then
					pets = "\"Perky Pug\""
					classText = classText.."\n/use Wild Holly"
					--[[print("gHI = "..gHI)--]]
				end
			end

			if GetItemCount(hasBell) < 1 then
				hasBell = "B. F. F. Necklace"
			end

			-- print("classText =", classText)
			-- print("SST[playerspec] =", SST[playerspec])
			-- print("hasBell =", hasBell)
			-- print("pets =", pets)
			EditMacro("WSxSwapper",nil,nil,classText.."\n/settitle "..SST[playerspec].."\n/use "..hasBell.."\n/run local a={"..pets.."}b=math.random(1,#a)_,c=C_PetJournal.FindPetIDByName(a[b])do C_PetJournal.SummonPetByGUID(c)end")

	        -- print("ZONE_CHANGED_NEW_AREA or BAG_UPDATE_DELAYED or PET_SPECIALIZATION_CHANGED")

	         -- Role definition scope for dps potions
			local primary = "int"
			if (class == "DEMONHUNTER") or (class == "DRUID" and (playerspec == 2 or playerspec == 3)) or (class == "HUNTER") or (class == "MONK" and playerspec ~= 2) or (class == "ROGUE") or (class == "SHAMAN" and playerspec == 2) then
				primary = "agi"
			elseif (class == "DEATHKNIGHT") or (class == "WARRIOR") or (class == "PALADIN" and playerspec ~= 1) then
				primary = "str"
			end
			-- Throughput Potion synthesizer 
			EditMacro("Wx3ShowPot", nil, "INV_MISC_QUESTIONMARK", nil, 1, 1)
			if instanceType == "pvp" and GetItemCount("Saltwater Potion", false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Saltwater Potion\n/use Hell-Bent Bracers", 1, 1)
			elseif IsInJailersTower() == true and GetItemCount("Fleeting Frenzy Potion", false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Fleeting Frenzy Potion\n/use Hell-Bent Bracers", 1, 1)
			elseif IsInJailersTower() == true and GetItemCount("Mirror of the Conjured Twin", false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Mirror of the Conjured Twin\n/use Hell-Bent Bracers", 1, 1)	
			elseif primary == "int" and GetItemCount(171273, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Potion of Spectral Intellect\n/use Hell-Bent Bracers", 1, 1)
			elseif primary == "int" and GetItemCount(169299, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Potion of Unbridled Fury\n/use Hell-Bent Bracers", 1, 1)
			elseif primary == "int" and GetItemCount(168498, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Superior Battle Potion of Intellect\n/use Hell-Bent Bracers", 1, 1)
			elseif primary == "agi" and GetItemCount(168489, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Superior Battle Potion of Agility\n/use Hell-Bent Bracers", 1, 1)
			elseif primary == "str" and GetItemCount(168500, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Superior Battle Potion of Strength\n/use Hell-Bent Bracers", 1, 1)
			elseif primary == "int" and GetItemCount(163222, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Battle Potion of Intellect\n/use Hell-Bent Bracers", 1, 1)
			elseif primary == "agi" and GetItemCount(163223, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Battle Potion of Agility\n/use Hell-Bent Bracers", 1, 1)
			elseif primary == "str" and GetItemCount(163224, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Battle Potion of Strength\n/use Hell-Bent Bracers", 1, 1)
			elseif GetItemCount(171349, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Potion of Phantom Fire\n/use Hell-Bent Bracers", 1, 1)	
			elseif GetItemCount(169299, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Potion of Unbridled Fury\n/use Hell-Bent Bracers", 1, 1)
			elseif GetItemCount(142117, false, true) >= 1 then
				EditMacro("Wx3ShowPot", nil, nil, "#show\n/use Potion of Prolonged Power\n/use Hell-Bent Bracers", 1, 1)
			else
				EditMacro("Wx3ShowPot", nil, 132380, "#show", 1, 1)
			end	
			
			-- Map
			if C_Map and C_Map.GetBestMapForUnit("player") then
				local map = C_Map.GetMapInfo(C_Map.GetBestMapForUnit("player"))
				local parent = map.parentMapID and C_Map.GetMapInfo(map.parentMapID) or map
				local ink = "\n/use Moroes' Famous Polish"
				local hasCannon, alt4, alt5, alt6, CZ, AR, conDB, conEF, conAF, conVS, conSET, conST, conSst, conMW, conMS, conTE, conBE, conCE, conRE = "", "", "", "\n/use Goren \"Log\" Roller", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""
				alt4 = ink
				-- Gör ett nytt macro för ExtraActionButton1 som har en Vindicator Matrix ability bundet när du är på Argus, bind detta till CGenB

				-- Zone Ability
				local zA = "/use [@mouseover,exists,nodead][@cursor]Garrison Ability"
				if instanceName == "Draenor" then
					-- Draenor: Garrison Ability
				elseif instanceName == "Broken Isles" then
					zA = "/use [@mouseover,harm,nodead][@cursor]Combat Ally"
				elseif instanceName == "Argus" then
					-- Argus: Vindicaar Matrix Crystal
					zA = "/use [@mouseover,exists,nodead][@cursor]Vindicaar Matrix Crystal"
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
				end
				EditMacro("WSxCSGen+B",nil,nil,zA)
				
				EditMacro("WSxCGen+B",nil,nil,"#show\n/click ExtraActionButton1")
				if GetItemCount("Darkmoon Cannon") == 1 then 
					hasCannon = "\n/use Darkmoon Cannon"
				end

				-- Augment Runes
				if eLevel <= 50 and GetItemCount("Lightforged Augment Rune") == 1 then
					AR = "\n/use [nostealth]Lightforged Augment Rune"
				elseif eLevel <= 60 and GetItemCount("Eternal Augment Rune") == 1 then
					AR = "\n/use [nostealth]Eternal Augment Rune"
				end
			
				local pp = parent and parent.name

				local LAR = "Loot-A-Rang"
				local hasShark, hasScrapper = "Photo B.O.M.B.","Citizens Brigade Whistle"
    			
			    if IsInJailersTower() == true then
					local torghastAnimaCell = {
					"Ravenous Anima Cell",
					"Plundered Anima Cell",
					"Requisitioned Anima Cell",					}
					local torghastAnimaCellInBags = ""
					for i, torghastAnimaCell in pairs(torghastAnimaCell) do
					    if GetItemCount(torghastAnimaCell) >= 1 then
					        torghastAnimaCellInBags = torghastAnimaCell
					    end
					end
					alt4 = ink
					alt5 = hasCannon
					alt6 = ""
					CZ = ""
			    elseif ((z == "The Maw" and pp == "The Shadowlands") or (z == "The Rift" and pp == "The Shadowlands")) then
					alt4 = ink.."\n/use Silver Shardhide Whistle"
					if (class == "PRIEST" or class == "MAGE" or class == "WARLOCK") then
						alt5 = "/use 9"
					elseif (class == "WARRIOR" or class == "DEATHKNIGHT" or class == "PALADIN" or class == "DRUID" or class == "MONK" or class == "ROGUE" or class == "DEMONHUNTER") then
						alt5 = "/use 10"
					else
						alt5 = "/use 8"
					end
					alt5 = hasCannon.."\n"..alt5
					CZ = "[nostealth]Borr-Geth's Fiery Brimstone"
				elseif slZones[z] then
					if (class == "PRIEST" or class == "MAGE" or class == "WARLOCK") then
							alt5 = "/use 9"
					elseif (class == "WARRIOR" or class == "DEATHKNIGHT" or class == "PALADIN" or class == "DRUID" or class == "MONK" or class == "ROGUE" or class == "DEMONHUNTER") then
						alt5 = "/use 10"
					else
						alt5 = "/use 8"
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
					alt4 = ink.."\n/use Silver Shardhide Whistle"
					alt5 = hasCannon.."\n"..alt5
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
					alt4 = ink..""..conDB..""..conEF..""..conAF
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
					alt4 = ink.."\n/use Baarut the Brisk"
					alt6 = "\n/use The \"Devilsaur\" Lunchbox"
					CZ = "Sightless Eye"
				-- Broken Isles is continent 8
				elseif pp == "Broken Isles" then
					alt4 = ink
					alt5 = "\n/use Emerald Winds"..hasCannon
					alt6 = "\n/use The \"Devilsaur\" Lunchbox"
					CZ = "Sightless Eye"
					if z == "Highmountain" then
						alt4 = "\n/use Majestic Elderhorn Hoof"..ink
					end
				-- Draenor is continent 7
				elseif (pp == "Draenor") or (pp == "Frostfire Ridge") or (pp == "Shadowmoon Valley") or (pp == "Ashran") then
					alt4 = ink.."\n/use Spirit of Shinri\n/use Skull of the Mad Chief"
					alt5 = "\n/use Breath of Talador\n/use Black Whirlwind"..hasCannon
					alt6 = "\n/use Ever-Blooming Frond"
					CZ = "Aviana's Feather\n/use Treessassin's Guise"
					LAR = "Findle's Loot-A-Rang"
				-- Pandaria
				elseif (pp == "Pandaria") or (pp == "Vale of Eternal Blossoms") then
					alt4 = ink.."\n/use Cursed Swabby Helmet\n/use Ash-Covered Horn\n/use Battle Horn"
					alt5 = "\n/use Bottled Tornado"..hasCannon
					alt6 = "\n/use Eternal Warrior's Sigil"
					CZ = "[combat]Salyin Battle Banner" 
				-- Northrend
				elseif pp == "Northrend" then
					alt4 = "\n/use Grizzlesnout's Fang"..ink
				end

				EditMacro("WLoot pls",nil,nil,"/click StaticPopup1Button1\n/use Battle Standard of Coordination\n/target mouseover\n/targetlasttarget [noharm,nocombat]\n/use "..LAR.."\n/use [exists,nodead,nochanneling]Rainbow Generator\n/use Gin-Ji Knife Set")

				-- array med klass abilities för varje klass, aC == Alt+456 Class ability
				-- Helpful Dispel Array ctrl+alt+num456
				local aC = {
					["SHAMAN"] = "Cleanse Spirit",
					["MAGE"] = "Remove Curse",
					["WARLOCK"] = "Singe Magic",
					["MONK"] = "Detox",
					["PALADIN"] = "Cleanse",
					["HUNTER"] = "Roar of Sacrifice",
					["ROGUE"] = "Tricks of the Trade",
					["PRIEST"] = "Purify Disease",
					["DEATHKNIGHT"] = "Chains of Ice",
					["WARRIOR"] = "Intervene",
					["DRUID"] = "Remove Corruption", 
					["DEMONHUNTER"] = "Silver-Plated Turkey Shooter",
					["EVOKER"] = "",
				}
				-- array med klass abilities för varje klass, PoA == Party or Arena
				local PoA = "@party"
				if class == "DEATHKNIGHT" then
					PoA = "@arena"
				end
				
				--[[DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: New area detected: "..parent.name..".\nRecalibrating zone based macros :)",0.5,1.0,0.0)--]]			

				EditMacro("WMPAlt+4",nil,nil,"/target [nomod]Boss1\n/target [nomod]Arena1\n/use [mod:ctrl"..PoA.. "1]"..aC[class]..""..alt4.."\n/run DepositReagentBank();")
				EditMacro("WMPAlt+5",nil,nil,"/target [nomod]Boss2\n/target [nomod]Arena2\n/use [mod:ctrl"..PoA.. "2]"..aC[class]..""..alt5)
				if class == "DEATHKNIGHT" then
					PoA = "@arena3"
				else
					PoA = "@party"
				end        
				EditMacro("WMPAlt+6",nil,nil,"/target [nomod]Boss3\n/target [nomod]Arena3\n/use [mod:ctrl"..PoA.."]"..aC[class]..""..alt6)
				local covSpecial = ""
				-- Kyrian, 
				if cov[slBP] == "Kyrian" then
					covSpecial = "\n/use Bondable Val'kyr Diadem\n/use Acrobatic Steward"
				-- Venthyr, "Door of Shadows"
				elseif cov[slBP] == "Venthyr" then
					covSpecial = "\n/use Tome of Small Sins"
				-- Night Fae, "Soulshape"
				elseif cov[slBP] == "Night Fae" then
					covSpecial = "\n/use Sparkle Wings\n/use Gormling in a Bag"
				-- Necrolord, "Fleshcraft" 
				elseif cov[slBP] == "Necrolord" then
					covSpecial = "\n/use Regenerating Slime Vial"
				end
				-- (Shaman är default/fallback)
				local ccz = "\n/use [nospec:3]Lightning Shield;Water Shield"
				if class == "MAGE" then
					ccz = "\n/use [combat,help,nodead][nocombat]Arcane Intellect;Invisibility"
				elseif class == "WARLOCK" then
					ccz = "\n/use Lingering Wyrmtongue Essence\n/use [nocombat]Heartsbane Grimoire"
				elseif class == "MONK" then
					ccz = "\n/use Mystical Orb of Meditation"
				elseif class == "PALADIN" then
					ccz = "\n/use Mystical Orb of Meditation\n/use Mark of Purity"
				elseif class == "HUNTER" then
					ccz = "\n/use "..chameleon.."\n/use [nocombat]!Camouflage" 
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
					ccz = "\n/use Battle Shout\n/use Shard of Archstone\n/use Brynja's Beacon"
				elseif class == "DRUID" then
					ccz = "\n/use Fandral's Seed Pouch\n/use Ravenbear Disguise\n/use Mark of the Wild\n/use !Prowl"
				elseif class == "DEMONHUNTER" then
					ccz = "\n/use Lingering Wyrmtongue Essence\n/cancelaura Wyrmtongue Disguise"
				elseif class == "EVOKER" then
					ccz = "\n/use Blessing of the Bronze\n/use Lingering Wyrmtongue Essence\n/cancelaura Wyrmtongue Disguise"
				end
				
				if ccz and CZ and AR then
					-- print(CZ..ccz..AR..covSpecial)
					EditMacro("WSxCGen+Z",nil,nil,"/use Seafarer's Slidewhistle\n/use [nostealth]Repurposed Fel Focuser\n/use "..CZ..ccz..AR..covSpecial)
					--DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Recalibrating zone based variables :)\nalt4 = "..alt4.."\nalt5 = "..alt5.."\nalt6 = "..alt6.."\nCZ = "..CZ.."\nccz = "..ccz.."\naC = "..aC.."\nPoA = "..PoA.."\nAR = "..AR.."\nconTE = "..conTE.."\nconRE = "..conRE.."\nconBE = "..conBE.."\nconCE = "..conCE,0.5,1.0,0.0)
				end		
				--[[print("pp = "..pp)
		    	print("z = "..z)
		    	print("CZ = "..CZ)--]]
				-- om du är i en battleground, kollar inte om det är rated dock.
				if instanceType == "pvp" then
					invisPot = "Potion of Trivial Invisibility" 
					EditMacro("wWBGHealer1",nil,nil,"/stopmacro [noexists]\n/run if not InCombatLockdown()then local A=UnitName(\"target\") EditMacro(\"wWBGHealerisSet1\",nil,nil,\"/target \"..A, nil)print(\"Healer1 set to : \"..A)else print(\"Cannot change assist now!\")end")
					EditMacro("wWBGHealer2",nil,nil,"/stopmacro [noexists]\n/run if not InCombatLockdown()then local A=UnitName(\"target\") EditMacro(\"wWBGHealerisSet2\",nil,nil,\"/target \"..A, nil)print(\"Healer2 set to : \"..A)else print(\"Cannot change assist now!\")end")        
					EditMacro("wWBGHealer3",nil,nil,"/stopmacro [noexists]\n/run if not InCombatLockdown()then local A=UnitName(\"target\") EditMacro(\"wWBGHealerisSet3\",nil,nil,\"/target \"..A, nil)print(\"Healer3 set to : \"..A)else print(\"Cannot change assist now!\")end")
					EditMacro("wWBGHealerisSet1",nil,nil,"")
					EditMacro("wWBGHealerisSet2",nil,nil,"")        
					EditMacro("wWBGHealerisSet3",nil,nil,"")					
				-- om du är i ett dungeon eller raid
				elseif instanceType == "party" or instanceType == "raid" then
					invisPot = "Draenic Invisibility Potion"	
				end
	
				-- om du är i timewalking radde
				if (difficultyID == 24 or difficultyID == 33) then
					EditMacro("WSpecs!",nil,nil,"/equipset Timewalking\n/run x=1 if(IsShiftKeyDown())then x=2 elseif(IsControlKeyDown())then x=3 elseif(IsModifierKeyDown())then x=4 end if(x~=GetSpecialization())then SetSpecialization(x) end\n/stopcasting")
				end
	
				EditMacro("wWBGHealer1",nil,nil,"/cleartarget")
				EditMacro("wWBGHealer2",nil,nil,"/cleartarget")        
				EditMacro("wWBGHealer3",nil,nil,"/cleartarget")	
				EditMacro("wWBGHealerisSet1",nil,nil,"/use [mod:alt,"..PoA.."1,exists]"..numaltcc[class]..";[mod:ctrl,"..PoA.."1,exists]"..numctrlcc[class]..";["..PoA.."1,exists]"..numnomodcc[class])
				EditMacro("wWBGHealerisSet2",nil,nil,"/use [mod:alt,"..PoA.."2,exists]"..numaltcc[class]..";[mod:ctrl,"..PoA.."2,exists]"..numctrlcc[class]..";["..PoA.."2,exists]"..numnomodcc[class])        
				EditMacro("wWBGHealerisSet3",nil,nil,"/use [mod:alt,"..PoA.."3,exists]"..numaltcc[class]..";[mod:ctrl,"..PoA.."3,exists]"..numctrlcc[class]..";["..PoA.."3,exists]"..numnomodcc[class])

				-- Healing Tonic and Scrap Grenade Addon, Ctrl+alt+Capslock
				-- Healthstone Addon "Capslock", Hearthstones, hsToy, Magefood/Water (and eventually Bandages)injector 
				
				local hsNecks = {
					"Man'ari Training Amulet",
					"Eternal Woven Ivy Necklace",
					"Eternal Will of the Martyr",
					"Eternal Talisman of Evasion",
					"Eternal Horizon Choker",
					"Eternal Emberfury Talisman",
					"Eternal Amulet of the Redeemed",
				}
		
				local eqhsNeck = ""
				for i, hsNecks in pairs(hsNecks) do
					if IsEquippedItem(hsNecks) == true then
						eqhsNeck = hsNecks
					end	
				end
				local hasTonics = {
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
					"item:137222",
				}
				local hasTonicInBags = ""
						hasTonicInBags = eqhsNeck
				for i, hasTonics in pairs(hasTonics) do
					if GetItemCount(hasTonics) >= 1 then
				    	hasTonicInBags = hasTonics
					end
				end
						
				if hasTonicInBags == "" then
					hasTonicInBags = hasScrapper
				elseif z == "Brawl'gar Arena" then
					hasTonicInBags = "Brawler's Coastal Healing Potion"
				elseif instanceType == "pvp" and GetItemCount("\"Third Wind\" Potion") >= 1 then 
					hasTonicInBags = "\"Third Wind\" Potion"
				end
				-- overrides potion
				-- Grenades addon "Ctrl+Shift+E"
			
		    	EditMacro("WGrenade",nil,nil,"#show [mod:alt]"..hasScrapper..";"..hasShark.."\n/use Hot Buttered Popcorn\n/use [mod:alt]"..hasScrapper..";"..hasShark)
				
				local sttFBpoS = ""
				if slBP == 1 and GetItemCount("item:177278") > 0 then  
					sttFBpoS = "item:177278"
				else
					sttFBpoS = "Foul Belly"
				end
				EditMacro("WTonic",nil,nil,"#show [mod:shift]"..sttFBpoS..";"..hasTonicInBags.."\n/use Foul Belly\n/use "..hasTonicInBags)

				 -- First Aid Bandages Parser
		        local hasBandages = {
			        "Tidespray Linen Bandage",
			        "Deep Sea Bandage",
			        "Shrouded Cloth Bandage",
			        "Heavy Shrouded Cloth Bandage",
		 	   	}
		 	   	local hasBandagesInBags = ""
		 	   	for i, hasBandages in pairs(hasBandages) do 
			 	   	if GetItemCount(hasBandages) >= 1 then
			 	   		hasBandagesInBags = hasBandages
			 	   	end
			 	end

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
				    "item:170068",
				    "item:169763",
				    "Seafoam Coconut Water",
				    "Rockskip Mineral Water",
				    "Purified Skyspring Water",
				    "Ethereal Pomegranate",
				    "Shadespring Water",
				    "Stygian Stew",
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

				if hasWaterInBags and GetItemCount(hasWaterInBags) > 0 then
					getWaters = GetItemCount(hasWaterInBags)
					if hasWaterInBags == "item:169763" then
						DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Updating bags :) Your Mardivas's Magnificent Desalinating Pouch is usable :)",0.5,1.0,0.0)
					elseif hasWaterInBags == "item:170068" then
						DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Updating bags :) Your Mardivas's Magnificent Desalinating Pouch is empty :(",0.5,1.0,0.0)
					else
						DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Updating bags :) and found "..getWaters.." "..hasWaterInBags.." to drink! :)",0.5,1.0,0.0)
					end
				end


				if (class == "MAGE" and playerspec == 3) or (class == "DEATHKNIGHT" and playerspec == 2) then
					HS[class] = "Greatfather Winter's Hearthstone"
				elseif (class == "MAGE" and playerspec == 1) then
					HS[class] = "Tome of Town Portal"
				elseif (class == "WARLOCK" and UnitName("player") == "Voidlisa") then
					HS[class] = "Venthyr Sinstone"
				elseif (class == "MONK" and playerspec ~= 1) or (class == "PALADIN" and playerspec ~=3) then
					HS[class] = "Kyrian Hearthstone"
				elseif (class == "HUNTER" and playerspec == 2) then 
					HS[class] = "Holographic Digitalization Hearthstone"
				elseif class == "PRIEST" then
					if playerspec == 2 then
						HS[class] = "Peddlefeet's Lovely Hearthstone"
					elseif playerspec == 1 then
						HS[class] = "Eternal Traveler's Hearthstone"
					end
				elseif class == "DRUID" then
					if playerspec == 1 then
						HS[class] = "Lunar Elder's Hearthstone"
					elseif playerspec == 4 then
						HS[class] = "Night Fae Hearthstone"
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

				if HS[class] and hsToy[class] and hasWaterInBags then
					HS[class] = "[mod:ctrl]"..HS[class]..";"

					if class == "MAGE" then 
						local sgen2hasWaterInBags = "Conjure Refreshment"
						if GetItemCount(hasWaterInBags) > 0 then
							sgen2hasWaterInBags = hasWaterInBags
						end
						EditMacro("WSxSGen+2",nil,nil,"/use "..sgen2hasWaterInBags.."\n/use Gnomish X-Ray Specs\n/stopcasting [spec:2]\n/use [nocombat]Conjure Refreshment")
						EditMacro("WSxSGen+1",nil,nil,"/run local c=C_Container for i=0,4 do for x=1,c.GetContainerNumSlots(i)do y=c.GetContainerItemLink(i,x)if y and GetItemInfo(y)==\""..sgen2hasWaterInBags.."\"then c.PickupContainerItem(i,x)DropItemOnUnit(\"target\")return end end end\n/click TradeFrameTradeButton")
					end
					if GetItemCount(hasWaterInBags) > 0 then 
						hasWaterInBags = "[mod:alt]"..hasWaterInBags..";"
					end
					if GetItemCount(hasBandagesInBags) > 0 then
						hasBandagesInBags = "[mod]"..hasBandagesInBags..";"
					end
					if GetItemCount("Healthstone", false, true) >= 1 then
						EditMacro("WShow",nil,nil,"/use "..hasWaterInBags..HS[class]..hasBandagesInBags.."Healthstone\n/stopmacro [mod]"..hsToy[class].."\n/run PlaySound(15160)\n/glare", 1, 1)
					else
						EditMacro("WShow",nil,nil,"/use "..hasWaterInBags..HS[class]..hasBandagesInBags.."\n/stopmacro [mod]"..hsToy[class].."\n/use Healthstone\n/run PlaySound(15160)\n/cry", 1, 1)
					end
				end

				-- Garrisons Knappen, Mobile Gbank, Nimble Brew if has.
				local nBrew = "Nimble Brew"
				if GetItemCount("Nimble Brew") < 1 then 
					nBrew = "Magic Pet Mirror"
				end
				EditMacro("Wx2Garrisons",nil,nil,"#show\n/use [nocombat,noexists,nomod]Mobile Banking(Guild Perk);[mod:shift]Narcissa's Mirror;"..nBrew)

				local hasDrums = {
					"Drums of Rage",
					"Drums of Fury",
					"Drums of the Mountain",
					"Drums of the Maelstrom",
					"Drums of Deathly Ferocity",
				}
				local hasDrumsInBags = "Hot Buttered Popcorn"
				for i, hasDrums in pairs(hasDrums) do
				    if GetItemCount(hasDrums) >= 1 then
				        hasDrumsInBags = hasDrums
				    end
				end

				local name = AuraUtil.FindAuraByName("Lone Wolf", "player") 
				local bladlast = "Bloodlust"
				if class == "SHAMAN" then
					if faction == "Alliance" then 
				    	bladlast = "Heroism" 
					end
				elseif class == "MAGE" then 
					bladlast = "Time Warp"
				elseif class == "HUNTER" then
					-- hunter med bl drums
					if (name == nil and petspec ~= 1 and hasDrumsInBags) then
						bladlast = "[nopet]Call Pet 5;[pet]"..hasDrumsInBags
					-- hunter med bl pet
					elseif (name == nil and petspec == 1) then
						bladlast = "[nopet]Call Pet 5;[pet]Command Pet" 
					-- lone wolf hunter med bl drums
					elseif name == "Lone Wolf" then
						bladlast = "[nopet]"..hasDrumsInBags..";[pet]Command Pet" 
					end
				elseif class == "EVOKER" then 
					bladlast = "Fury of the Aspects"
				else
					bladlast = hasDrumsInBags
				end

				-- #show Bloodlust, Time Warp, Netherwinds, Drums and Favorite mount - Ctrl+Shift+V
				if class == "PRIEST" then
					EditMacro("WSxFavMount",nil,nil,"#show " ..bladlast.. "\n/run C_MountJournal.SummonByID(0)\n/dismount [mounted]\n/cancelaura Flaming Hoop\n/use Celebration Firework")
				else
					EditMacro("WSxFavMount",nil,nil,"#show " ..bladlast.. "\n/run C_MountJournal.SummonByID(0)\n/dismount [mounted]\n/cancelform Bear Form\n/cancelform Cat Form\n/cancelaura Zen Flight\n/cancelaura Flaming Hoop\n/cancelaura Prowl\n/use Celebration Firework\n/cancelaura Stealth")
				end
				--  T75 Talents, "Ctrl+7" bind Bloodlusts etc and SGen+G Biggest Dick in the game, Poppa BL, Ctrl+7 and ptdSG injector
				if class == "SHAMAN" then
					EditMacro("WSxBladlast",nil,nil,"#show [mod] " ..bladlast.. ";[talent:5/1]Wind Shear;"..b("Ancestral Guidance","",";")..b("Feral Lunge","[@mouseover,harm,nodead][harm,nodead]",";").."[talent:5/3]Wind Rush Totem;" ..bladlast.. ";\n/use " ..bladlast.."\n/use [nocombat]Thunderstorm")
					EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG..""..b("Purge","[@mouseover,harm,nodead][harm,nodead]",";")..b("Greater Purge","[@mouseover,harm,nodead][harm,nodead]",";").."Flaming Hoop\n/targetenemy [noexists]\n/cleartarget [dead]")
				-- Is class Mage
				elseif class == "MAGE" then
					EditMacro("WSxBladlast",nil,nil,"#show\n/use " ..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG..""..b("Spellsteal","","").."\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]\n/use Poison Extraction Totem")
				-- Is class Warlock
				elseif class == "WARLOCK" then
					EditMacro("WSxBladlast",nil,nil,"#show [mod]"..bladlast..";[talent:5/1]Shadowfury;[talent:5/2]Mortal Coil;[talent:5/3]Howl of Terror\n/use " ..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"/use "..ptdSG.."\n/use "..b("Mortal Coil","[]",";")..b("Howl of Terror","[]",";").."\n/use Flaming Hoop")
				-- Is class Monk
				elseif class == "MONK" then
					EditMacro("WSxBladlast",nil,nil,"#show [mod] " ..bladlast.. ";"..b("Diffuse Magic","[]",";")..b("Dampen Harm","[]",";").."\n/use "..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG..b("Diffuse Magic","[]",";")..b("Dampen Harm","[]",";").."Pandaren Scarecrow\n/use [noexists,nocombat]Flaming Hoop")
				-- Is class Paladin
				elseif class == "PALADIN" then
				    EditMacro("WSxBladlast",nil,nil,"#show [mod] " ..bladlast.. ";[talent:5/2]Holy Avenger;[talent:5/3]Seraphim;Concentration Aura\n/use " ..bladlast)
				    EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG.."Hammer of Justice\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]")
				-- Is class Hunter
				elseif class == "HUNTER" then
					EditMacro("WSxBladlast",nil,nil,"#show [spec:2,nomod][talent:5/3,nomod]Binding Shot;"..bladlast.."\n/use " ..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"#show "..b("Tranquilizing Shot","[]","").."\n/use "..b("Tranquilizing Shot","[@mouseover,harm,nodead][]","").."\n/use [nocombat,noexists,nomounted]Nat's Fishing Chair\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				-- Is class Rogue
				elseif class == "ROGUE" then
					EditMacro("WSxBladlast",nil,nil,"#show\n/use " ..bladlast)
					if ptdSG and class == "ROGUE" then
						ptdSG = "[mod:alt]Protocol Transference Device;"
					end
					EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt,nocombat,noexists]Darkmoon Gazer;"..ptdSG.."[@mouseover,harm,nodead][harm,nodead]Shiv;Pick Lock")
					EditMacro("WSxSGen+G",nil,nil,"#show\n/targetenemy [noexists]\n/use [stance:0,nocombat]Stealth;[mod:alt,@focus,exists,nodead][]Kidney Shot\n/use [nocombat,noexists,stance:0]Flaming Hoop")
				-- is class Prist
				elseif class == "PRIEST" then
					EditMacro("WSxBladlast",nil,nil,"#show [mod] " ..bladlast.. ";[spec:1,talent:5/3]Shadow Covenant;[spec:2,talent:5/2]Binding Heal;[spec:3,talent:5/3]Shadow Crash;Smite\n/use " ..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG..b("Dispel Magic","[@mouseover,harm,nodead][harm,nodead]",";").."Personal Spotlight\n/use [noexists,nocombat] Flaming Hoop\n/targetenemy [noexists]")
				-- Is class Death Knight
				elseif class == "DEATHKNIGHT" then
					EditMacro("WSxBladlast",nil,nil,"#show [mod] " ..bladlast.. ";[nospec:1,talent:5/2][spec:1,talent:5/3]Wraith Walk;[nospec:1,talent:5/3]Death Pact\n/use " ..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG..b("Asphyxiate","[]",";")..b("Blinding Sleet","[]",";")..b("Raise Dead","[nopet]",";").."[pet]!Gnaw\n/use [noexists,nocombat] Flaming Hoop\n/petattack [harm,nodead]")
				-- Is class Warrior
				elseif class == "WARRIOR" then
					EditMacro("WSxBladlast",nil,nil,"#show [mod]"..bladlast.. "\n/use "..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG..b("Storm Bolt","[]",";").."Victory Rush\n/use [noexists,nocombat]Flaming Hoop")
				-- Is class Druid
				elseif class == "DRUID" then
					EditMacro("WSxBladlast",nil,nil,"#show [mod]" ..bladlast.."\n/use ".. bladlast) 
					EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..ptdSG..b("Maim","[form:2]",";")..b("Soothe","[]","").."\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]") 
				-- Is class Demon Hunter
				elseif class == "DEMONHUNTER" then
					EditMacro("WSxBladlast",nil,nil,"#show\n/use " ..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"/use "..ptdSG..b("Fel Eruption","[]",";")..b("Chaos Nova","[]",";").."Consume Magic\n/use [noexists,nocombat] Flaming Hoop")
				elseif class == "EVOKER" then
					EditMacro("WSxBladlast",nil,nil,"#show\n/use " ..bladlast)
					EditMacro("WSxSGen+G",nil,nil,"/use "..ptdSG..b("Unravel","[]",";").."Expunge\n/use [noexists,nocombat]Flaming Hoop")
				end -- class
			end -- map
		end -- event
		-- Byta talent eller zone events
		if (event == "ZONE_CHANGED_NEW_AREA" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PLAYER_LOGIN" or event == "TRAIT_CONFIG_UPDATED") then
      	
			if glider >= 1 then
				glider = "Goblin Glider Kit"
			else 
				glider = "15"
			end
			if brazier ~= 1 then 
				brazier = ""
			else 
				brazier = "\n/use [mod:ctrl]Brazier of Awakening"
			end
			--DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Talent change detected! :)",0.5,1.0,0.0)
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

				if UnitIsPVP("player") == true then
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
							locPvPExcQQ = "[@mouseover,harm,nodead][]Call Felhunter"
							locPvPExcGenF = "[@focus,harm,nodead]Call Felhunter;"
						end
						if PvPTalentNames[i] == "Call Fel Lord" then
							locPvPExcSeven = "[mod:shift,@player][@cursor]Call Fel Lord"
						end
						if PvPTalentNames[i] == "Fel Obelisk" then
							locPvPExcSThree = "[@player]Fel Obelisk"
						end
					elseif class == "WARRIOR" and PvPTalentNames[i] == "Death Wish" then
						warPvPExc = "[]Death Wish;"
					end
					
				end

			end
			
			-- Offensive Counter abilities Array 
			-- shift+alt+wmp456
			local wmpaltcc = {
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
				["EVOKER"] = "",
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
				["PRIEST"] = "Mind Bomb",
				["DEATHKNIGHT"] = "Asphyxiate",
				["WARRIOR"] = "Storm Bolt",
				["DRUID"] = "Cyclone", 
				["DEMONHUNTER"] = "Imprison",
				["EVOKER"] = "",
			}
			if class == "ROGUE" and playerspec == 2 then
				wmpctrlcc[class] = "Kidney Shot"
			end
			local wmpnomodcc = {
				["SHAMAN"] = "Wind Shear",
				["MAGE"] = "Counterspell",
				["WARLOCK"] = locPvPExcQQ,
				["MONK"] = "Spear Hand Strike",
				["PALADIN"] = "Rebuke",
				["HUNTER"] = "Counter Shot",
				["ROGUE"] = "Kick",
				["PRIEST"] = "Silence",
				["DEATHKNIGHT"] = "Mind Freeze",
				["WARRIOR"] = "Pummel",
				["DRUID"] = "Solar Beam", 
				["DEMONHUNTER"] = "Disrupt",
				["EVOKER"] = "",
			}
			if class == "DRUID" then
				if (playerspec == 2 or playerspec == 3) then
					wmpnomodcc[class] = "Skull Bash"
				else
					wmpnomodcc[class] = "Cyclone"
				end
			end 

			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1]"..wmpaltcc[class]..";[mod:ctrl,@arena1]"..wmpctrlcc[class]..";[@arena1,exists][@boss1,exists]"..wmpnomodcc[class]..";" ..one)
			EditMacro("WMPCC+5",nil,nil,"/use [mod:alt,@arena2]"..wmpaltcc[class]..";[mod:ctrl,@arena2]"..wmpctrlcc[class]..";[@arena2,exists][@boss2,exists]"..wmpnomodcc[class]..";" ..two)        
			EditMacro("WMPCC+6",nil,nil,"/use [mod:alt,@arena3]"..wmpaltcc[class]..";[mod:ctrl,@arena3]"..wmpctrlcc[class]..";[@arena3,exists][@boss3,exists]"..wmpnomodcc[class]..";" ..tre)

			-- Target Calling Macro    
			EditMacro("WACommandKill",nil,nil,"/stopmacro [noexists]\n/run if UnitRace(\"target\") then SendChatMessage(\"Kill my target NOW! ->> %t the \"..(UnitRace(\"target\")..\" \"..UnitClass(\"target\"))..\" \", IsInGroup(2) and \"instance_chat\" or IsInRaid() and \"raid\" or IsInGroup() and \"party\" or \"say\")end")
			EditMacro("WACommandRare",nil,nil,"/run a=UnitName('target');b=C_Map;c='player';d=b.GetBestMapForUnit(c);e=b.GetPlayerMapPosition(d,c);b.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(d,e.x,e.y));SendChatMessage(a..' at '..b.GetUserWaypointHyperlink(),'CHANNEL',c,1);b.ClearUserWaypoint()")
			
			if racials[race] then
				if race == "VoidElf" then
					EditMacro("Wx6RacistAlt+V",nil,nil,"#show " ..racials[race].."\n/use Prismatic Bauble\n/use Sparklepony XL\n/castsequence reset=9 "..racials[race]..",Languages")
				else
					EditMacro("Wx6RacistAlt+V",nil,nil,"#show " ..racials[race].."\n/use Prismatic Bauble\n/use Sparklepony XL\n/use "..racials[race])
				end

			    -- Class Artifact Button, "§" Completed, note: Kanske kan hooka Heart Essence till fallback från Cov och Signature Ability? Sedan behöver vi hooka Ritual of Doom till Warlock Order Hall också.
				-- Covenant and Signature Ability parser
				-- Kyrian, "Summon Steward", phial of serenity

				local sigA,sigB,covA,poS,hoaEq,hasHE  = "","","Covenant Ability","","[@mouseover,exists,nodead][@cursor]13",""
				if cov[slBP] == "Kyrian" then
					poS = "\n/use [mod]item:177278\n/use Steward's First Feather"
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
					elseif class == "EVOKER" then
						covA = "Boon of the Covnants"
					end
				-- Necrolord, "Fleshcraft" 
				elseif cov[slBP] == "Necrolord" then
					poS = "\n/use [nomod]Apprentice Slimemancer's Boots"
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
						covA = "Adaptive Swarm"
					elseif class == "DEMONHUNTER" then
						covA = "Fodder to the Flame"
					elseif class == "EVOKER" then
						covA = "Boon of the Covnants"
					end
				-- Night Fae, "Soulshape"
				elseif cov[slBP] == "Night Fae" then
					poS = "\n/use [mod]Spring Florist's Pouch"
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
					elseif class == "EVOKER" then
						covA = "Boon of the Covnants"
					end
				-- Venthyr, "Door of Shadows"
				elseif cov[slBP] == "Venthyr" then
					poS = "\n/use [mod]Bondable Sinstone"
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
					elseif class == "EVOKER" then
						covA = "Boon of the Covnants"
					end
				end
				
				-- hard exceptions
				
				sigB = "[@mouseover,exists,nodead,mod][@cursor,mod]"..sigA
				covA = "[@mouseover,exists,nodead][@cursor]"..covA..poS
				hoaEq = "[@mouseover,exists,nodead][@cursor]Heart Essence"
				local slBPGen
				if ((slBP== 2 and class == "WARRIOR") and IsEquippedItem("Heart of Azeroth") and not slZones[z]) then
					slBPGen = sigB..";"..hoaEq
				elseif (slBP== 2 and class == "WARRIOR") then 
					hoaEq = "13"
					slBPGen = sigB..";"..hoaEq
				elseif (slBP ~= 0 and not slZones[z]) then
					sigA = "The Golden Banana"
					covA = "Murglasses"
					if class == "SHAMAN" then
						covA = b("Primordial Wave","","")
					elseif class == "MAGE" then
							covA = b("Mirror Image","","") 
							sigA = "Seed of Renewed Souls"
						if b("Radiant Spark") == "Radiant Spark" then
							covA = b("Radiant Spark","","")
						elseif b("Glacial Spike") == "Glacial Spike" then
							covA = b("Glacial Spike","","")
						end
						if b("Shifting Power") == "Shifting Power" then
							sigA = b("Shifting Power","","")
						elseif b("Meteor") == "Meteor" then
							sigA = b("Meteor","","")
						end
					elseif class == "WARLOCK" then
						if b("Soul Rot") == "Soul Rot" then
							covA = b("Soul Rot","","")
						elseif b("Guillotine") == "Guillotine" then
							covA = b("Guillotine")
						elseif b("Dimensional Rift") == "Dimensional Rift" then
							covA = b("Dimensional Rift")
						end
						if b("Inquisitor's Gaze") == "Inquisitor's Gaze" then
							sigA = b("Inquisitor's Gaze")
						elseif b("Summon Soulkeeper") == "Summon Soulkeeper" then
							sigA = b("Summon Soulkeeper")
						end
					elseif class == "MONK" then 
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
						sigA = "Seed of Renewed Souls"
					elseif class == "ROGUE" then
					elseif class == "PRIEST" then
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
						if b("Spear of Bastion") == "Spear of Bastion" then
							sigA = b("Spear of Bastion")
						end
					elseif class == "DRUID" then
						sigA = "Seed of Renewed Souls"
						if b("Convoke the Spirits") == "Convoke the Spirits" then
							covA = b("Convoke the Spirits")
						elseif b("Adaptive Swarm") == "Adaptive Swarm" then
							covA = b("Adaptive Swarm")
						end
						if b("Adaptive Swarm") == "Adaptive Swarm" then
							sigA = b("Adaptive Swarm")
						end
					elseif class == "DEMONHUNTER" then
					elseif class == "EVOKER" then
					end
					sigB = "[@mouseover,exists,nodead,mod][@cursor,mod]"..sigA
					covA = "[@mouseover,exists,nodead][@cursor]"..covA..poS
					slBPGen = sigB..";"..covA
				elseif slBP ~= 0 then 
					slBPGen = sigB..";"..covA
				elseif (IsEquippedItem("Heart of Azeroth") and slBP == 0) then
					slBPGen = hoaEq
				else
					slBPGen = "13"
				end
				
				if class == "MAGE" then 
					hasHE = "\n/use Mirror Image" 
				end

				--alt+6 mods
				if (IsEquippedItem("Heart of Azeroth") and not slZones[z]) then
					hoaEq = "/stopspelltarget\n/stopspelltarget\n/use [mod,@player][@mouseover,exists,nodead][@cursor]Heart Essence"
					if class == "MAGE" then
						hasHE = "\n/castsequence Mirror Image, Heart Essence"
					else
						hasHE = "\n/use Heart Essence" 
					end
				elseif class == "WARLOCK" then
					hoaEq = "/use [nocombat,noexists]Wand of Simulated Life;"..b("Mortal Coil","[]",";")..b("Howl of Terror","[]",";")..b("Curse of Exhaustion","[]","")
				elseif class == "MONK" then 
					hoaEq = "/use [nocombat,noexists]Wand of Simulated Life;"..b("Fortifying Brew","","")
				elseif class == "PALADIN" then 
					hoaEq = "/use [nocombat,noexists]Wand of Simulated Life;"..b("Divine Favor","","")
				elseif class == "HUNTER" then 
					hoaEq = "/use [nocombat,noexists]Wand of Simulated Life;Misdirection"
				elseif class == "PRIEST" then 
					hoaEq = "/use [nocombat,noexists]Wand of Simulated Life;"..b("Evangelism","","")
				elseif class == "DEATHKNIGHT" then 
					hoaEq = "/use [nocombat,noexists]Wand of Simulated Life;"..b("Wraith Walk","","")
				elseif class == "WARRIOR" then 
					hoaEq = "/use [nocombat,noexists]Wand of Simulated Life;"..b("Piercing Howl","","")
				elseif class == "DRUID" then 
					hoaEq = "/use [nocombat,noexists]Wand of Simulated Life;"..b("Ursol's Vortex","[]",";")..b("Mass Entanglement","[]",";").."Barkskin"
				else
					hoaEq = "/use Wand of Simulated Life"
				end
				
				EditMacro("WArtifactCDs",nil,nil,"/stopspelltarget\n/stopspelltarget\n/use [help,dead,nomod]Unstable Temporal Time Shifter;"..slBPGen)
				EditMacro("WSxCAGen+§",nil,nil,"/use [@player,mod:shift]"..sigA..";[@player][@mouseover,exists,nodead][@cursor]"..covA)
				-- print("sigA = "..sigA)
				-- print(slZones[z])

				
				EditMacro("WSxAGen+4",nil,nil,"#showtooltip\n/use [@mouseover,exists,nodead][@cursor][]13")

				--[[				EditMacro("WSxAGen+4",nil,nil,"/run local Z,_,d=\"Mirror of the Blademaster\",GetItemCooldown(124224) if IsEquippedItem(Z) and d==0 then SendChatMessage(\"Daddy, i'm going to use \" .. Z .. \" pls no moverino", "SAY\") end")
				--]]

				-- EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use 14\n/use [nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;Eternal Black Diamond Ring")
				
				local pennantClass = "\n/use Honorable Pennant"

				if class == "ROGUE" and playerspec ~= 2 then
					pennantClass = "\n/use Honorable Pennant\n/cancelaura A Mighty Pirate"
				elseif class == "ROGUE" then 
					pennantClass = "\n/use Jolly Roger\n/cancelaura Honorable Pennant"
				end

				EditMacro("Wx1Trinkit",nil,nil,"#show\n"..hoaEq.."\n/stopmacro [combat,channeling]\n/use Attraction Sign\n/use Rallying War Banner"..pennantClass)
				
				if (class == "WARLOCK" or class == "DEMONHUNTER") then
					EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use 14\n/use [nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Fractured Necrolyte Skull;[help,dead,nocombat]Cremating Torch;Eternal Black Diamond Ring")
				else
					EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use 14\n/use [nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;Eternal Black Diamond Ring")
				end

				local nPepe = ""
	    		local name = AuraUtil.FindAuraByName("Pepe", "player") 
				if nPepe then
					if (name ~= "Pepe" and (class == "WARLOCK" or class == "DEMONHUNTER")) then 
						name = "\n/use [nocombat,noexists]A Tiny Set of Warglaives"
					elseif (name ~= "Pepe" and (class ~= "WARLOCK" or class ~= "DEMONHUNTER")) then
						name = "\n/use [nocombat,noexists]Trans-Dimensional Bird Whistle"
					else
						name = ""
					end
					nPepe = name
					--[[print("nPepe = "..nPepe)--]]
				end
			 
				-- Main Class configuration
				-- Shaman, Raxxy
				if class == "SHAMAN" then
					EditMacro("WSxGen1",nil,nil,"#show\n/use "..b("Static Discharge","[@mouseover,harm,nodead][harm,nodead]",";")..b("Feral Lunge","[@mouseover,harm,nodead][harm,nodead]",";")..b("Unleash Life","[@mouseover,help,nodead][help,nodead]",";")..b("Frost Shock","[@mouseover,harm,nodead][harm,nodead]",";").."Xan'tish's Flute\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+1",nil,nil,"#show [nocombat,noexists]Haunted War Drum;Frost Shock\n/use [mod:alt,@party3,help,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Healing Surge\n/use [nocombat]Haunted War Drum")
					EditMacro("WSxGen2",nil,nil,"#show\n/use [nocombat,noexists]Raging Elemental Stone;"..b("Lava Lash","",";").."[@mouseover,harm,nodead][]Lightning Bolt\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/use [mod,@party4,help,nodead][@mouseover,help,nodead][]Healing Surge\n/cancelaura X-Ray Specs\n/use Gnomish X-Ray Specs")
					EditMacro("WSxGen3",nil,nil,"#show\n/startattack\n/targetenemy [noexists]\n/use [nocombat,noexists]Tadpole Cloudseeder;"..b("Stormstrike","[]",";")..b("Lava Burst","[@mouseover,harm,nodead][]","").."\n/cleartarget [dead]")
					EditMacro("WSxSGen+3",nil,nil,"#show Flame Shock\n/cleartarget [dead]\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead,nomod:alt][nomod:alt]Flame Shock\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Flame Shock\n/targetlasttarget")
					EditMacro("WSxGen4",nil,nil,"/use "..b("Icefury","[]",";")..b("Lava Burst","[nospec:3,@mouseover,harm,nodead][nospec:3]",";")..b("Chain Heal","[@mouseover,help,nodead][]","").."\n/targetenemy [noexists]\n/cleartarget [dead]\n/use Smolderheart")
					EditMacro("WSxSGen+4",nil,nil,"#show\n/targetenemy [noexists]\n/use "..b("Riptide","[@party2,help,nodead,mod]",";")..b("Chain Heal","[mod,@party2,help,nodead]",";")..b("Healing Surge","[mod,@party2,help,nodead]",";").."[nocombat,noexists]Sen'jin Spirit Drum\n/use "..b("Fire Elemental","[pet:Storm Elemental]Tempest;[pet:Fire Elemental,@mouseover,harm,nodead][pet:Fire Elemental]Meteor",";")..b("Sundering","[]",";")..b("Stormkeeper","[]",";")..b("Ice Strike","","")..b("Icefury","","")..b("Chain Heal","[@mouseover,help,nodead]","").."\n/cleartarget [dead]")
					EditMacro("WSxCGen+4",nil,nil,"#show\n/use [@party3,help,nodead,mod:alt]Riptide;"..b("Ascendance","",";")..b("Wellspring","",";")..b("Totemic Projection","[@cursor]",";")..b("Downpour","[@cursor]",";")..b("Stormkeeper","",";").."\n/targetenemy [noexists]\n/use Trawler Totem")
					EditMacro("WSxGen5",nil,nil,"#show\n/targetenemy [noexists,nomod]\n/target [@Greater Earth Ele,mod]\n/use [help,mod,nodead]Healing Surge;"..b("Spirit Link Totem","[mod,@cursor,spec:3]",";")..b("Earth Elemental","[mod]",";")..b("Earth Shock","",";")..b("Healing Wave","[@mouseover,help,nodead][]",";").."[@mouseover,harm,nodead][harm,nodead]Lightning Bolt\n/use Words of Akunda\n/targetlasttarget [mod]")
					EditMacro("WSxSGen+5",nil,nil,"#show\n/cast "..b("Riptide","[@party2,help,nodead,mod]",";")..b("Liquid Magma Totem","[mod,@player][@cursor]",";")..b("Fire Elemental","[pet:Storm Elemental]Tempest;[pet:Fire Elemental,@mouseover,harm,nodead][pet:Fire Elemental]Meteor;",";")..b("Chain Heal","[mod,@party2,help,nodead]",";")..b("Doom Winds","","")..b("Earthen Wall Totem","[@cursor]","")..b("Ancestral Protection Totem","[@cursor]","")..b("Wellspring","","")..b("Downpour","[@cursor]","").."\n/use [nocombat,noexists]Lava Fountain\n/targetenemy [noexists]")
					EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod,@party4,help,nodead]Riptide;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14\n/use Eternal Black Diamond Ring")
					EditMacro("WSxGen6",nil,nil,"/use "..b("Feral Spirit","[mod]",";")..b("Fire Elemental","[mod]",";")..b("Earth Elemental","[mod]",";")..b("Crash Lightning","",";")..b("Healing Rain","[@cursor]","")..b("Chain Lightning","[@mouseover,harm,nodead][]","").."\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+6",nil,nil,"/use "..b("Healing Tide Totem","[spec:3]",";")..b("Totemic Projection","[]",";")..b("Chain Heal","[@mouseover,help,nodead][]","")..b("Windfury Totem","[]","").."\n/use [nocombat,noexists]Goren \"Log\" Roller\n/use Orb of Deception\n/leavevehicle")
					EditMacro("WSxGen7",nil,nil,"/use "..b("Healing Rain","[mod:shift,@player]",";")..b("Earthquake","[mod:shift,@player][@cursor]",";")..b("Windfury Totem","[mod:shift]",";")..b("Chain Lightning","[@mouseover,harm,nodead][harm,nodead]",";").."Bom'bay's Color-Seein' Sauce\n/startattack\n/use [noexists,nocombat]Moonfang's Paw")
					EditMacro("WSxGen8",nil,nil,"#show\n/use "..b("Fire Nova","[]",";")..b("Ice Strike","","")..b("Wellspring","","")..b("Frost Shock","[@mouseover,harm,nodead][]",""))
					EditMacro("WSxGen9",nil,nil,"#show "..b("Ice Strike","[]",";")..b("Fire Nova","",";")..b("Spirit Link Totem","[]",";")..b("Tremor Totem","[]",";")..b("Downpour","[]","")..b("Water Walking","","").."\n/use "..b("Ice Strike","[]",";")..b("Fire Nova","",";")..b("Earthliving Weapon","[]",";")..b("Tremor Totem","[]",";")..b("Downpour","[@cursor]","")..b("Water Walking","",""))
					EditMacro("WSxCSGen+2",nil,nil,"/use [spec:3,@focus,help,nodead][spec:3,@party1,help,nodead]Purify Spirit;[@focus,help,nodead][@party1,help,nodead]Cleanse Spirit;[nocombat,noharm]Spirit Wand;")
					EditMacro("WSxCSGen+3",nil,nil,"/use [spec:3,@focus,help,nodead][spec:3,@party2,help,nodead]Purify Spirit;[nospec:2,@focus,harm,nodead]Flame Shock;[@party2,help,nodead]Cleanse Spirit;[nocombat,noharm]Cranky Crab;\n/cleartarget [dead]\n/stopspelltarget")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Earth Shield")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,help,nodead][@party2,help,nodead][@targettarget,help,nodead]Earth Shield\n/use [spec:3]Waterspeaker's Totem")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]"..glider..";[mod]6;[nocombat]Ancestral Spirit;"..pwned.."\n/use [mod:ctrl]Ancestral Vision"..brazier)
					EditMacro("WSxGenQ",nil,nil,"/stopcasting [nomod:alt]\n/use "..b("Hex","[mod:alt,@focus,harm,nodead]",";")..b("Tremor Totem","[mod:shift]",";").."[help,nodead]Foot Ball;[nocombat,noexists]The Golden Banana;"..b("Wind Shear","[@mouseover,harm,nodead][]","").."\n/use [nocombat,spec:3]Bubble Wand\n/cancelaura Bubble Wand")
					EditMacro("WSkillbomb",nil,nil,"/use "..b("Fire Elemental","","")..b("Feral Spirit","","")..b("Earth Elemental","\n/use ","").."\n/use Rukhmar's Sacred Memory"..b("Ascendance","\n/use ","")..""..dpsRacials[race].."\n/use [@player]13\n/use 13\n/use Flippable Table\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")	
					EditMacro("WSxGenE",nil,nil,"#show [nocombat,noexists]Party Totem;Capacitor Totem\n/use "..b("Mana Spring Totem","[mod:alt]",";")..b("Capacitor Totem","[@cursor]","").."\n/use Haunting Memento\n/use [nocombat,noexists]Party Totem")
					EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..b("Capacitor Totem","[mod:alt,@player]",";")..b("Nature's Swiftness","","")..oOtas)
					EditMacro("WSxSGen+E",nil,nil,"#show\n/use [mod:alt,@player]Earthbind Totem;"..b("Healing Stream Totem","","").."\n/use Arena Master's War Horn\n/use Totem of Spirits\n/use [nocombat]Void-Touched Souvenir Totem")
					EditMacro("WSxGenR",nil,nil,"#show Earthbind Totem\n/use "..b("Totemic Projection","[@cursor,mod:ctrl]",";").."[mod:shift,@cursor]Earthbind Totem;"..b("Frost Shock","[@mouseover,harm,nodead][harm,nodead]",";").."\n/targetenemy [noharm]\n/cleartarget [dead]")
					EditMacro("WSxGenT",nil,nil,"/use "..b("Wind Rush Totem","[@cursor]",";")..b("Earthgrab Totem","[@cursor]",";")..b("Thunderstorm","[@mouseover,exists,nodead][]","")..b("Frost Shock","[@mouseover,harm,nodead][harm,nodead]","")..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
				    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..b("Downpour","[@cursor]",""))
					EditMacro("WSxSGen+T",nil,nil,"#show\n/use "..b("Lightning Lasso","[@mouseover,harm,nodead][]",";")..b("Thunderstorm","[@mouseover,exists,nodead][]","")..b("Earthquake","[@cursor]",""))
					EditMacro("WSxGenU",nil,nil,"#show\n/use Reincarnation")
					EditMacro("WSxGenF",nil,nil,"#show\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@cursor]Far Sight;"..b("Wind Shear","[@focus,harm,nodead]",";").."Mrgrglhjorn\n/use Survey")
					EditMacro("WSxSGen+F",nil,nil,"#show\n/use [nocombat,noexists,mod:alt]Gastropod Shell;[nocombat,noexists]Totem of Harmony;"..b("Primordial Wave","[@mouseover,exists,nodead][]","")..b("Ever-Rising Tide","","").."\n/cancelform [mod:alt]")
					EditMacro("WSxCGen+F",nil,nil,"#show\n/use "..b("Ancestral Guidance","","").."\n/use "..fftpar.."\n/cancelaura Thistleleaf Disguise")
					EditMacro("WSxCAGen+F",nil,nil,"#show "..b("Spirit Walk","[]",";")..b("Spiritwalker's Grace","[]","")..b("Gust of Wind","[]","").."\n/run if not InCombatLockdown() then if GetSpellCooldown(198103)==0 then "..tpPants.." else "..noPants.." end end\n/stopcasting\n/use Gateway Control Shard")
					EditMacro("WSxGenG",nil,nil,"/use [mod:alt]Darkmoon Gazer;"..b("Purge","[@mouseover,harm,nodead]","")..b("Greater Purge","[@mouseover,harm,nodead]",";").."[spec:3,@mouseover,help,nodead][spec:3]Purify Spirit;"..b("Cleanse Spirit","[@mouseover,help,nodead][]").."\n/targetenemy [noexists]\n/use Poison Extraction Totem")
				    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..b("Wellspring","",""))
					EditMacro("WSxCSGen+G",nil,nil,"/use "..b("Purge","[@focus,harm,nodead]",";")..b("Greater Purge","[@focus,harm,nodead]",";")..b("Purify Spirit","[@focus,help,nodead]",";")..b("Cleanse Spirit","[@focus,help,nodead]",";")..b("Poison Cleansing Totem","[]",";")..b("Tremor Totem","[]",";")..b("Capacitor Totem","","").."\n/cancelaura Whole-Body Shrinka'\n/cancelaura Growing Pains")
					EditMacro("WSxSGen+H",nil,nil,"#show\n/use "..b("Stoneskin Totem","[@cursor]",";")..b("Tranquil Air Totem","[@cursor]",";")..b("Hex","[]","").."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
					EditMacro("WSxAGen+J",nil,nil,"#show [spec:3,talent:1/3]Unleash Life;[spec:2,talent:1/3]Elemental Blast;[spec:1,talent:1/3]Static Discharge;Flame Shock\n/use "..invisPot)
					EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Flametongue Weapon;[mod:shift,@player,spec:3]Spirit Link Totem;"..b("Astral Shift","[nomod]","").."\n/use Whole-Body Shrinka'\n/use [mod:alt]Gateway Control Shard")
					EditMacro("WSxGenX",nil,nil,"/use "..b("Windfury Weapon","[mod:alt]",";")..b("Earthliving Weapon","[mod:alt]",";").."[mod:ctrl]Astral Recall;"..b("Spirit Walk","[mod:shift]",";")..b("Spiritwalker's Grace","[mod:shift]",";")..b("Earth Shield","[@mouseover,help,nodead][]",";")..b("Lightning Shield","","").."\n/use Void Totem\n/use Deceptia's Smoldering Boots")
					EditMacro("WSxGenC",nil,nil,"/use "..b("Hex","[@mouseover,exists,nodead,mod:ctrl][mod:ctrl]",";")..b("Mana Tide Totem","[mod:shift]",";")..b("Riptide","[@mouseover,help,nodead][]","")..b("Thunderstorm","[@mouseover,exists,nodead][]",";")..b("Feral Spirit","","").."\n/use Thistleleaf Branch")
					EditMacro("WSxAGen+C",nil,nil,"#show\n/use [nocombat,noexists]Vol'Jin's Serpent Totem\n/use "..b("Totemic Recall","").."\n/click TotemFrameTotem1 RightButton\n/cry")
					EditMacro("WSxGenV",nil,nil,"/use "..b("Gust of Wind","[]",";")..b("Feral Lunge","","")..b("Spiritwalker's Grace","","")..b("Spirit Walk","",";")..b("Ghost Wolf","[noform]","").."\n/use Panflute of Pandaria\n/use Croak Crock\n/cancelaura Rhan'ka's Escape Plan\n/use Desert Flute\n/use Sparklepony XL")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@mouseover,help,nodead][nomod:alt]Water Walking\n/use [swimming,nomod:alt]Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")   
					EditMacro("WSxT100",nil,nil,"#show [spec:2,talent:7/2]Earthen Spike;[spec:3,talent:7/2]Wellspring;[spec:1,talent:7/2]Stormkeeper")
					if playerspec == 3 then
						EditMacro("WSxGen6",nil,nil,"#show\n/targetenemy [noexists,nomod]\n/target [@Greater Earth Ele,mod]\n/use [help,mod,nodead]Healing Surge;[mod]Earth Elemental;"..b("Healing Rain","[@cursor]","").."\n/use Words of Akunda\n/targetlasttarget [mod]")
					end

				-- Mage, maggi, nooniverse
				elseif class == "MAGE" then
					local broom = "Worn Doll"
					if GetItemCount("Anti-Doom Broom") ~= 0 then
						broom = "Anti-Doom Broom"
					end
					EditMacro("WSxGen1",nil,nil,"/targetenemy [noharm,nodead]\n/use [nocombat,noexists]Dazzling Rod\n/use "..b("Ray of Frost","[]",";")..b("Glacial Spike","[]",";")..b("Phoenix Flames","[@mouseover,harm,nodead][]",";")..b("Presence of Mind","[]",";")..b("Ice Lance","[]",""))
					EditMacro("WSxGen2",nil,nil,"/use "..b("Arcane Blast","[harm,nodead]",";")..b("Scorch","[@mouseover,harm,nodead][harm,nodead]",";")..b("Frostbolt","[harm,nodead]",";").."Akazamzarak's Spare Hat\n/targetenemy [noharm]\n/cleartarget [dead]\n/use Kalec's Image Crystal\n/use Archmage Vargoth's Spare Staff")
					EditMacro("WSxGen3",nil,nil,"/use "..b("Frozen Orb","[@cursor]","")..b("Pyroblast","[@mouseover,harm,nodead][harm,nodead]","")..b("Arcane Surge","[]",";")..b("Supernova","","").."\n/use Dalaran Initiates' Pin\n/targetenemy [noexists]")
					EditMacro("WSxSGen+3",nil,nil,"#show\n/targetenemy [noexists]\n/use [nocombat,noexists]Archmage Vargoth's Spare Staff;"..b("Nether Tempest","[]",";")..b("Living Bomb","[nomod:alt]","")..b("Arcane Blast","","")..b("Pyroblast","[nomod:alt]","")..b("Ebonbolt","","").."\n/use [nocombat,nomod:alt]Brazier of Dancing Flames\n/stopmacro [nomod:alt]\n/targetlasttarget"..b("Pyroblast","\n/use [mod:alt]","").."\n/targetlasttarget")
					EditMacro("WSxGen4",nil,nil,"/use "..b("Fireball","[@mouseover,harm,nodead][harm,nodead]",";")..b("Flurry","[harm,nodead]",";")..b("Arcane Missiles","[harm,nodead]",";").."Memory Cube\n/targetenemy [noexists]\n/cleartarget [dead]\n/stopspelltarget")
					EditMacro("WSxSGen+4",nil,nil,"#show\n/targetenemy [noexists]\n/use "..b("Touch of the Magi","[]",";")..b("Comet Storm","[nomod:alt]",";")..b("Ebonbolt","","")..b("Meteor","[@cursor,nomod:alt]",";")..b("Fireball","[nomod:alt]","")..b("Frostbolt","[nomod:alt]","").."\n/use Smolderheart\n/stopmacro [nomod:alt]"..b("Fireball","\n/targetlasttarget\n/use [mod:alt]","\n/targetlasttarget"))
					EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..b("Rune of Power","","")..b("Focus Magic","[@mouseover,help,nodead][]","").."\n/use [nocombat,noexists]Faded Wizard Hat")
					EditMacro("WSxGen5",nil,nil,"/targetenemy [noexists]\n/use "..b("Alter Time", "[mod]!",";")..b("Arcane Barrage","[@mouseover,harm,nodead][harm,nodead]",";")..b("Ice Lance","[@mouseover,harm,nodead][harm,nodead]",";")..b("Fire Blast","[@mouseover,harm,nodead][harm,nodead]",";")..""..broom)
					EditMacro("WSxSGen+5",nil,nil,"/targetenemy [noexists]\n/cleartarget [dead]\n/clearfocus [dead]\n/use [mod:alt,pet,@player][pet,@cursor]Freeze"..b("Evocation",";",";")..b("Fire Blast","[@mouseover,harm,nodead][]",";")..b("Frost Nova","",""))
					EditMacro("WSxGen6",nil,nil,"#show\n/use "..b("Icy Veins","[mod:ctrl]","")..b("Arcane Surge","[mod:ctrl]","")..b("Combustion","[mod:ctrl]","").."\n/use "..b("Mirror Image","[mod:ctrl]","")..b("Blizzard",";[@cursor]","")..b("Flamestrike","[@cursor]","")..b("Arcane Explosion",";","").."\n/stopspelltarget [spec:2]")
					EditMacro("WSxSGen+6",nil,nil,"#show\n/use [nocombat,noexists]Mystical Frosh Hat\n/use "..b("Arcane Orb","[]",";")..b("Flamestrike","[@player]","")..b("Blizzard","[@player]",""))
					EditMacro("WSxGen7",nil,nil,"#show "..b("Arcane Explosion","","").."\n/use "..b("Meteor","[mod:shift,@player][@cursor,nospec:2]",";")..b("Ice Nova","[]",";")..b("Blast Wave","","")..b("Arcane Explosion","","")..b("Touch of the Magi","",";"))
					EditMacro("WSxGen8",nil,nil,"#show "..b("Ice Nova","[]",";")..b("Arcane Explosion","","").."\n/use "..b("Ice Nova","[nospec:2]",";")..b("Arcane Explosion","",""))
					EditMacro("WSxGen9",nil,nil,"#show "..b("Dragon's Breath","[]",";")..b("Cold Snap","[]",";")..b("Arcane Familiar","","").."\n/use "..b("Supernova","[]",";")..b("Arcane Explosion","",""))
					EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead]Remove Curse")
					EditMacro("WSxCSGen+3",nil,nil,"#show\n/use "..b("Pyroblast","[@focus,harm,nodead]",";").."[@party2,help,nodead]Remove Curse;[exists,nodead]Magical Saucer\n/targetenemy [noharm]\n/cleartarget [dead][nocombat,noharm]\n/stopspelltarget")
					EditMacro("WSxCSGen+4",nil,nil,"/use [spec:2,@focus,harm,nodead]Fireball;[@focus,help,nodead][@party1,help,nodead]Slow Fall;Pink Gumball\n/targetenemy [noharm]\n/cleartarget [dead][nocombat,noharm]\n/stopspelltarget\n/use [nocombat,noexists]Ogre Pinata")
					EditMacro("WSxCSGen+5",nil,nil,"#show Ice Block\n/use [@party2,help,nodead]Slow Fall\n/use [nocombat,noexists]Shado-Pan Geyser Gun\n/cancelaura [combat]Shado-Pan Geyser Gun\n/stopmacro [combat]\n/click ExtraActionButton1")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]"..glider..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..brazier)
					EditMacro("WSxGenQ",nil,nil,"#show\n/stopcasting [nomod]\n/use [mod:alt,@focus,harm,nodead]Polymorph;[mod:shift]Winning Hand;[@mouseover,harm,nodead][]Counterspell\n/use [mod:shift]Ice Block;")
					EditMacro("WSkillbomb",nil,nil,"#show\n/use "..b("Combustion","[]",";")..b("Icy Veins","[]",";")..b("Mirror Image","","").."\n/use "..b("Arcane Surge","","")..""..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13\n/use Hearthstone Board\n/use Big Red Raygun"..hasHE)
					EditMacro("WSxGenE",nil,nil,"#show\n/use "..b("Mass Polymorph","[mod:alt]",";")..b("Blast Wave","[mod:alt]",";")..b("Cone of Cold","[mod:shift]",";")..b("Frost Nova","","").."\n/use Manastorm's Duplicator")
					EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..b("Ice Floes","[]",";")..b("Ice Nova","","").."\n/use [spec:2]Blazing Wings"..oOtas)
					EditMacro("WSxSGen+E",nil,nil,"#show\n/use [mod:alt,@player,pet]Freeze;"..b("Cone of Cold","[]",""))
					EditMacro("WSxGenR",nil,nil,"#show "..b("Dragon's Breath","[mod:shift]",";")..b("Cone of Cold","","").."\n/use "..b("Dragon's Breath","[mod:shift]",";")..b("Cone of Cold","[mod:shift]",";")..b("Slow","[]",";")..b("Frostbolt","",""))
					EditMacro("WSxGenT",nil,nil,"/use "..b("Fire Blast","[@mouseover,harm,nodead][]","").."\n/targetenemy [noexists]\n/cleartarget [dead]\n/petattack [@mouseover,harm,nodead][]"..nPepe)
					EditMacro("WSxSGen+T",nil,nil,"#show "..b("Ring of Frost","","").."\n/use "..b("Blast Wave","","").."\n/use [help,nocombat]Swapblaster")
				    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..b("Ring of Frost","[mod:alt,@player][@cursor]",""))
					local hasManaGem = ""
					if GetItemCount("36799") >= 1 then
						hasManaGem = "item:36799"		
					elseif b("Displacement") == "Displacement" then 
						hasManaGem = "Displacement"
					elseif b("Arcane Familiar") == "Arcane Familiar" then 
						hasManaGem = "Arcane Familiar"
					end
					EditMacro("WSxGenU",nil,nil,"#showtooltip\n/use "..hasManaGem)
					EditMacro("WSxGenF",nil,nil,"#show\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/stopcasting [nomod]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Counterspell;Mrgrglhjorn\n/use Survey")
					EditMacro("WSxSGen+F",nil,nil,"#show Familiar Stone\n/cancelaura [mod:alt] Shado-Pan Geyser Gun\n/use [mod:alt,nocombat,noexists]Gastropod Shell;[nomod:alt]Arcane Familiar Stone\n/use [nomod:alt]Fiery Familiar Stone\n/use [nomod:alt]Icy Familiar Stone\n/use [nomod:alt]Familiar Stone")
					EditMacro("WSxCGen+F",nil,nil,"#show "..b("Invisibility","[combat]","")..";"..b("Ice Block","","")..b("Alter Time","\n/use ",""))
					EditMacro("WSxCAGen+F",nil,nil,"#show "..b("Blast Wave","[]",";")..b("Mirror Image","","").."\n/stopmacro [indoors]\n/use 16\n/run if not (InCombatLockdown() or IsEquippedItem(\"Dragonwrath, Tarecgosa's Rest\") and IsMounted) then EquipItemByName(71086) else Dismount() end\n/equipset [nomounted]"..EQS[playerspec])
					EditMacro("WSxGenG",nil,nil,"#show\n/targetenemy [noharm]\n/use [mod:alt]Darkmoon Gazer"..b("Spellsteal",";[@mouseover,harm,nodead]",";")..b("Remove Curse","[@mouseover,help,nodead][]","").."\n/use [noexists,nocombat]Set of Matches")
				    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..b("Arcane Familiar","[]",""))
					EditMacro("WSxCSGen+G",nil,nil,"#show "..b("Cold Snap","[]",";")..b("Greater Invisibility","[]",";").."\n/use "..b("Spellsteal","[@focus,harm,nodead]","").."\n/use Poison Extraction Totem")
					EditMacro("WSxSGen+H",nil,nil,"#show\n/targetenemy [noharm]\n/use Nat's Fishing Chair\n/use Home Made Party Mask\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
					EditMacro("WSxAGen+J",nil,nil,"#show "..b("Arcane Familiar","","")..b("Ice Nova","","")..b("Scorch","","")..b("Frost Nova","","").."\n/use "..invisPot)
					EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;"..b("Invisibility","[nocombat]",";")..b("Ice Block","!",""))
					EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt]Conjure Refreshment;[mod:ctrl]Teleport: Hall of the Guardian;"..b("Displacement","[mod:shift]",";")..b("Alter Time","[mod:shift]",";")..b("Prismatic Barrier","",";")..b("Blazing Barrier","",";")..b("Ice Barrier","","").."\n/use [nomod,spec:1]Arcano-Shower;[nomod,spec:2]Blazing Wings")
					EditMacro("WSxGenC",nil,nil,"#show\n/use [@mouseover,harm,nodead,mod:ctrl][mod:ctrl]Polymorph;"..b("Conjure Mana Gem","[mod:shift]",";")..b("Cold Snap","[mod:shift]",";")..b("Greater Invisibility","[]",";")..b("Mirror Image","","").."\n/cancelaura X-Ray Specs\n/use [mod:shift]Mana Gem")
					EditMacro("WSxAGen+C",nil,nil,"#show\n/use Worn Doll\n/run PetDismiss();\n/cry")
					EditMacro("WSxGenV",nil,nil,"#show\n/use Blink\n/dismount [mounted]\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Illusion\n/use Prismatic Bauble")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@mouseover,help,nodead][noswimming]Slow Fall;Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")
					EditMacro("WSxT100",nil,nil,"#shosw [spec:3,talent:7/3]Glacial Spike;[spec:3,talent:7/2]Ray of Frost;[spec:2,talent:7/3]Meteor;Arcane Intellect")
		
				-- Warlock, vårlök
				elseif class == "WARLOCK" then
					EditMacro("WSxGen1",nil,nil,"/use "..b("Soulstone","[@mouseover,help][help,nodead]",";")..b("Soul Fire","[]",";")..b("Havoc","[@mouseover,harm,nodead][]",";")..b("Soul Strike","[]",";")..b("Summon Vilefiend","[]",";")..b("Soul Swap","[@mouseover,harm,nodead][]",";")..b("Drain Life","[]",";")..b("Corruption","[@mouseover,harm,nodead][]",";").."\n/use Copy of Daglop's Contract\n/targetenemy [noexists]\n/use Imp in a Ball")
					EditMacro("WSxSGen+1",nil,nil,"/run local c=C_Container for i=0,4 do for x=1,c.GetContainerNumSlots(i) do y=c.GetContainerItemLink(i,x) if y and GetItemInfo(y)==\"Healthstone\" then c.PickupContainerItem(i,x) DropItemOnUnit(\"target\") return end end end\n/click TradeFrameTradeButton")
					EditMacro("WSxGen2",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use [harm,dead,nocombat]Soul Inhaler;"..b("Incinerate","[]",";")..b("Unstable Affliction","[@mouseover,harm,nodead][]",";")..b("Shadow Bolt","[]",";").."\n/use Accursed Tome of the Sargerei\n/startattack\n/clearfocus [dead]\n/use Haunting Memento")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/use [nomod:alt,harm,nodead]Drain Life;[nomod:alt]Create Healthstone\n/use [nocombat,noexists]Gnomish X-Ray Specs\n/cleartarget [dead]\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Unstable Affliction\n/targetlasttarget")
					EditMacro("WSxGen3",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use [nocombat,noexists]Pocket Fel Spreader;[harm,dead]Narassin's Soul Gem;"..b("Drain Soul","[@mouseover,harm,nodead][]",";")..b("Shadowburn","[@mouseover,harm,nodead][]",";")..b("Call Dreadstalkers","[@mouseover,harm,nodead][]",";")..b("Immolate","[@mouseover,harm,nodead]","")..b("Shadow Bolt","[@mouseover,harm,nodead][]",";").."\n/targetenemy [noexists]")
					EditMacro("WSxSGen+3",nil,nil,"/targetenemy [noexists]\n/use "..b("Doom","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",";")..b("Power Siphon","[]",";")..b("Immolate","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",";")..b("Corruption","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",";")..""..locPvPExcSThree.."\n/use Verdant Throwing Sphere\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use "..b("Doom","[]",";")..b("Immolate","[]",";")..b("Corruption","[]","").."\n/targetlasttarget")
					EditMacro("WSxGen4",nil,nil,"/use [nocombat,noexists]Crystalline Eye of Undravius;[spec:2]Hand of Gul'dan;"..b("Chaos Bolt","[]",";")..b("Haunt","[@mouseover,harm,nodead][]",";")..b("Unstable Affliction","[@mouseover,harm,nodead][]","").."\n/targetenemy [noexists]\n/cleartarget [dead]\n/cancelaura Crystalline Eye of Undravius")
					EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noexists]\n/use "..b("Havoc","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",";")..b("Agony","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",";")..b("Grimoire of Sacrifice","[nomod:alt]",";")..b("Inquisitor's Gaze","[]",";")..b("Corruption","[@mouseover,harm,nodead,nomod:alt][nomod:alt]","").."\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use "..b("Agony","[]",";")..b("Havoc","[]",";")..b("Corruption","[]","").."\n/targetlasttarget")
					EditMacro("WSxCGen+4",nil,nil,"/use "..b("Nether Portal","[]",";")..b("Soul Fire","[]",";")..b("Demonic Gateway","[@cursor]","").."\n/targetenemy [noexists]\n/cleartarget [dead]\n/use Gateway Control Shard")
					EditMacro("WSxGen5",nil,nil,"/use [pet:Voidwalker/Voidlord,mod:ctrl]Suffering;[mod:ctrl]Fel Domination\n/use [nopet:Voidwalker/Voidlord,mod:ctrl]Summon Voidwalker;"..b("Demonbolt","[@mouseover,harm,nodead,nomod:ctrl][nomod:ctrl]",";")..b("Conflagrate","[@mouseover,harm,nodead,nomod:ctrl][nomod:ctrl]",";")..b("Summon Soulkeeper","[@cursor,nomod:ctrl]","").."\n/use Fire-Eater's Vial\n/targetenemy [noexists]")
					EditMacro("WSxSGen+5",nil,nil,"#show\n/targetenemy [noexists]\n/use "..b("Summon Infernal","[mod:alt,@cursor]",";")..b("Bilescourge Bombers","[@player]",";")..b("Grimoire: Felguard","[]",";")..b("Demonic Strength","[pet:Felguard/Wrathguard]",";").."[nopet:Felguard/Wrathguard,spec:2]Summon Felguard;"..b("Channel Demonfire","[nomod:alt]",";")..b("Siphon Life","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",";")..b("Corruption","[nomod:alt]","").."\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use "..b("Siphon Life","[]",";")..b("Corruption","[]","").."\n/targetlasttarget")
					EditMacro("WSxGen6",nil,nil,"/use "..b("Summon Darkglare","[mod]",";")..b("Summon Demonic Tyrant","[mod]",";")..b("Summon Infernal","[mod,@player]",";")..b("Bilescourge Bombers","[@cursor]",";")..b("Demonic Strength","[@mouseover,harm,nodead][]",";")..b("Seed of Corruption","[@mouseover,harm,nodead][]",";")..b("Implosion","[@mouseover,harm,nodead][]",";")..b("Rain of Fire","[@cursor]","").."\n/startattack")
					EditMacro("WSxSGen+6",nil,nil,"/use "..b("Rain of Fire","[@player]",";").."[spec:2,nopet:Felguard/Wrathguard]Summon Felguard;[pet:Felguard/Wrathguard]!Felstorm;"..b("Phantom Singularity","[]",";")..b("Vile Taint","[@player]",";").."Command Demon\n/stopmacro [@pet,nodead]\n/run PetDismiss()")
					EditMacro("WSxGen7",nil,nil,"/use "..b("Cataclysm","[mod:shift,@player][@cursor]",";")..b("Malefic Rapture","[]",";")..b("Guillotine","[@player,mod:shift][@cursor]","").."\n/targetenemy [noexists]\n/use Legion Pocket Portal")
					EditMacro("WSxGen8",nil,nil,"#showtooltip\n/use "..b("Power Siphon","[]",";")..b("Implosion","[]",";")..b("Soul Tap","[]",";").."Subjugate Demon")
					EditMacro("WSxGen9",nil,nil,"#show [nocombat]Create Soulwell"..b("Power Siphon",";[]",";").."\n/use "..b("Implosion","[]",""))
					EditMacro("WSxCSGen+2",nil,nil,"/use [spec:1,@focus,harm,nodead]Unstable Affliction;[nocombat,noexists]Legion Invasion Simulator\n/targetenemy [noharm]\n/cleartarget [dead]")
					EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noexists]The Perfect Blossom;[spec:1,@focus,harm,nodead]Corruption;[spec:3,@focus,harm,nodead]Immolate;[spec:2,@focus,harm,nodead]Doom;Fel Petal;\n/targetenemy [noharm]\n/cleartarget [dead]")
					EditMacro("WSxCSGen+4",nil,nil,"/use [spec:1,@focus,harm,nodead]Agony;[spec:3,@focus,harm,nodead]Havoc\n/targetenemy [noharm]\n/cleartarget [dead]\n/use [nocombat]Micro-Artillery Controller")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,harm,nodead]Siphon Life\n/cleartarget [dead]\n/use Battle Standard of Coordination\n/stopmacro [combat]\n/use [noexists]Spire of Spite")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]"..glider..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..brazier)
					EditMacro("WSxGenQ",nil,nil,"#show\n/stopcasting [nomod,nopet]\n/use [@focus,mod:alt,harm,nodead]Fear;[mod:shift]Demonic Circle;"..locPvPExcQQ.."\n/use [nocombat,noexists]Vixx's Chest of Tricks\n/cancelaura Wyrmtongue Collector Disguise")
					EditMacro("WSkillbomb",nil,nil,"#show\n/use "..b("Summon Demonic Tyrant","[]",";")..b("Nether Portal","[]",";")..b("Summon Infernal","[@cursor]",";")..b("Summon Darkglare","[]",";").."\n/use Jewel of Hellfire\n/use [@player]13\n/use 13"..dpsRacials[race].."\n/use Shadescale\n/use Adopted Puppy Crate\n/use Big Red Raygun")
					EditMacro("WSxGenE",nil,nil,"/use "..b("Soulburn","[mod:alt]",";")..b("Shadowfury","[@cursor]",""))
					EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..b("Shadowfury","[mod:alt,@player]",";")..b("Fel Domination","","")..""..oOtas)
					EditMacro("WSxSGen+E",nil,nil,"#show Spell Lock\n/use [mod:alt,@focus,harm,nodead,pet:Felhunter/Observer][@mouseover,harm,nodead,pet:Felhunter/Observer][pet:Felhunter/Observer]Spell Lock;Fel Domination\n/use [nopet:Felhunter/Observer]Summon Felhunter")
					EditMacro("WSxGenR",nil,nil,"/use [mod:ctrl,nopet]Summon Sayaad;"..b("Shadowflame","[mod:shift]",";")..b("Mortal Coil","[@mouseover,harm,nodead,mod:shift][mod:shift]",";")..b("Howl of Terror","[mod:shift]",";")..b("Curse of Exhaustion","[@mouseover,harm,nodead][]","").."\n/targetenemy [noexists]\n/stopmacro [nomod:ctrl]\n/target [@pet,nodead,pet]\n/kiss\n/targetlasttarget")
					EditMacro("WSxGenT",nil,nil,"/use [pet:Incubus/Succubus/Shivarra]Whiplash;[@mouseover,harm,nodead,pet:Felguard/Wrathguard][pet:Felguard/Wrathguard]!Pursuit;Soul Shards\n/petattack [@mouseover,harm,nodead][]\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+T",nil,nil,"#show "..b("Shadowflame","[]",";").."Curse of Weakness\n/use [@mouseover,harm,nodead][harm,nodead]Curse of Weakness;[help,nocombat]Swapblaster"..nPepe.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..b("Amplify Curse","[]",";").."[@mouseover,help][]Soulstone")
					EditMacro("WSxGenU",nil,nil,"#show [help]Soulstone;[nopet]Summon Imp;"..b("Amplify Curse","[]",";").."Soulstone\n/use [nopet]Summon Imp")
					EditMacro("WSxGenF",nil,nil,"#show Demonic Circle\n/focus [@mouseover,exists]mouseover\n/stopmacro [@mouseover,exists]\n/stopcasting [nomod,nopet]\n/use [mod,exists,nodead]All-Seer's Eye;[mod]Eye of Kilrogg;"..locPvPExcGenF.."\n/use [noexists,nocombat,nomod]Tickle Totem")
					EditMacro("WSxSGen+F",nil,nil,"/use [mod:alt,nocombat,noexists]Gastropod Shell;[pet:Felguard/Wrathguard,nomod:alt]Threatening Presence;[pet:Imp]Flee;[pet:Voidwalker]Suffering;Command Demon\n/petautocasttoggle [mod:alt]Legion Strike;[pet:Voidwalker]Suffering;Threatening Presence")
					EditMacro("WSxCGen+F",nil,nil,"#show Ritual of Doom\n/use [nocombat,noexists,pet:Incubus/Succubus/Shivarra]Lesser Invisibility;[group]Ritual of Doom;Bewitching Tea Set\n/use "..fftpar.."\n/cancelaura Wyrmtongue Disguise\n/cancelaura Burning Rush\n/cancelaura Heartsbane Curse")
					EditMacro("WSxCAGen+F",nil,nil,"#show "..b("Soulburn","[]",";")..
						--\n/run if not InCombatLockdown() then if GetSpellCooldown(111771)==0 then "..tpPants.." else "..noPants.." end end
						"\n/stopcasting\n/use "..b("Soulburn","[]",";").."\n/use "..b("Demonic Gateway","[@cursor]","").."\n/use Gateway Control Shard")
					EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]S.F.E. Interceptor;[@mouseover,harm,nodead,pet:Felhunter/Observer][pet:Felhunter/Observer,harm,nodead]Devour Magic;[@mouseover,exists,nodead][]Command Demon\n/stopspelltarget")
					--[@mouseover,harm,nodead,pet:Felhunter/Observer][pet:Felhunter/Observer,harm,nodead]Devour Magic;[pet:Voidwalker/Voidlord]Consuming Shadows;[pet:Imp]Flee;[@mouseover,exists,nodead][]Command Demon
				    EditMacro("WSxCGen+G",nil,nil,"#show "..b("Dark Pact","","").."\n/use [help,nodead,pet:Imp/Fel Imp][@player,pet:Imp/Fel Imp]Singe Magic;Fel Domination\n/use [nopet:Imp/Fel Imp]Summon Imp")
					EditMacro("WSxCSGen+G",nil,nil,"#show [mod]Create Soulwell;"..b("Grimoire of Sacrifice","[]",";")..b("Dark Pact","[]",";").."Summon Felhunter\n/use "..b("Grimoire of Sacrifice","[pet]",";").."[nopet][combat]Summon Felhunter;Create Soulwell\n/use [nopet]Summon Felhunter")
					EditMacro("WSxSGen+H",nil,nil,"#show Demonic Circle: Teleport\n/use [nocombat]Legion Communication Orb\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
					EditMacro("WSxAGen+J",nil,nil,"#show\n/use "..invisPot)
					EditMacro("WSxGenZ",nil,nil,"/use "..b("Demonic Gateway","[mod:alt,@cursor]",";")..b("Dark Pact","[mod:shift]",";").."Unending Resolve")
					EditMacro("WSxGenX",nil,nil,"/use [mod:alt,group]Create Soulwell;[mod:alt]Create Healthstone;[mod:shift]Demonic Circle: Teleport;[mod,harm,nodead]Subjugate Demon;[mod,group]Ritual of Summoning;[mod]Unstable Portal Emitter;"..b("Burning Rush","!",";")..b("Dark Pact","[]",";").."Demonic Circle: Teleport")					
					EditMacro("WSxGenC",nil,nil,"/use "..b("Soul Tap","[mod:shift]",";").."[mod,@mouseover,harm,nodead][mod]Fear;[nopet]Summon Voidwalker;Ring of Broken Promises\n/use Poison Extraction Totem\n/use Health Funnel\n/cancelaura Ring of Broken Promises\n/use Totem of Spirits\n/cancelaura X-Ray Specs\n/use Smolderheart")
					EditMacro("WSxAGen+C",nil,nil,"#show\n/use Spire of Spite\n/run PetDismiss();\n/cry")
					EditMacro("WSxGenV",nil,nil,"#show "..b("Banish","[mod]",";")..b("Curse of Tongues","","").."\n/use "..b("Curse of Tongues","[@mouseover,harm,nodead][]","").."\n/use [nomod]Panflute of Pandaria\n/use Haw'li's Hot & Spicy Chili\n/cancelaura Rhan'ka's Escape Plan\n/use Void Totem\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@focus,harm,nodead,mod:alt][@mouseover,harm,nodead][harm,nodead]Banish;[@mouseover,help,nodead][]Unending Breath\n/use [mod:alt]Stylish Black Parasol")
					EditMacro("WSxT100",nil,nil,"#show ")
					EditMacro("WSxCAGen+B",nil,nil,"")
					EditMacro("WSxCAGen+N",nil,nil,"")
					
				-- Monk, menk, Happyvale
				elseif class == "MONK" then
					EditMacro("WSxGen1",nil,nil,"#show\n/use [nocombat,noexists]Mrgrglhjorn\n/use [@mouseover,exists,nodead][]Expel Harm\n/targetenemy [noexists]")
					EditMacro("WSxSGen+1",nil,nil,"/use "..b("Soothing Mist","[mod:ctrl,@party2,nodead,nochanneling:Soothing Mist][@focus,help,nodead,nochanneling:Soothing Mist][@party1,nodead,nochanneling:Soothing Mist]",";").."[mod:ctrl,@party2,nodead][@focus,help,nodead][@party1,nodead]Vivify;Honorary Brewmaster Keg")
					EditMacro("WSxGen2",nil,nil,"#show\n/use [channeling,@mouseover,help,nodead][channeling:Soothing Mist]Vivify;[nocombat,noexists]Brewfest Keg Pony;Tiger Palm\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/use "..b("Soothing Mist","[mod:alt,@party3,nodead,nochanneling:Soothing Mist][nochanneling:Soothing Mist,@mouseover,help,nodead][nochanneling:Soothing Mist]",";").."[@party3,nodead,mod:alt][@mouseover,help,nodead][]Vivify\n/use [nochanneling]Gnomish X-Ray Specs")
					EditMacro("WSxGen3",nil,nil,"/use [@mouseover,harm,nodead][]Touch of Death\n/use [nocombat,noexists]Mystery Keg\n/use [nocombat,noexists]Jin Warmkeg's Brew\n/targetenemy [noexists]\n/cleartarget [dead]")  
					EditMacro("WSxSGen+3",nil,nil,"/use "..b("Rushing Jade Wind","[]",";")..b("Soothing Mist","[mod:alt,@party4,nodead,nochanneling:Soothing Mist][nochanneling:Soothing Mist,@mouseover,help,nodead][nochanneling:Soothing Mist]",";").."[@party4,nodead,mod:alt]Vivify"..b("Enveloping Mist",";[@mouseover,help,nodead][]","")..";Crackling Jade Lightning")
					EditMacro("WSxGen4",nil,nil,"#show\n/use [nocombat,noexists]Brewfest Pony Keg;"..b("Rising Sun Kick","[]","").."\n/use Piccolo of the Flaming Fire\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
					EditMacro("WSxSGen+4",nil,nil,"#show\n/use [@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Renewing Mist;"..b("Chi Wave","[]",";")..b("Chi Burst","[]",";").."Tiger Palm\n/stopspelltarget\n/targetenemy [noexists]")
					EditMacro("WSxCGen+4",nil,nil,"/use [mod,@party3,help,nodead]Renewing Mist;"..b("Bonedust Brew","[@cursor]",";")..b("Faeline Stomp","[]",";").."\n/targetenemy [nocombat,noexists]")
					EditMacro("WSxGen5",nil,nil,"/use "..b("Zen Meditation","[mod:ctrl]",";")..b("Thunder Focus Tea","[mod:ctrl]",";").."Blackout Kick\n/use [noexists,nocombat]Brewfest Banner\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+5",nil,nil,"/use "..b("Renewing Mist","[@party2,help,nodead,mod:alt]",";")..b("Strike of the Windlord","[]",";")..b("Energizing Elixir","[]",";")..b("Zen Pulse","[]",";")..b("Keg Smash","[]","")..b("Thunder Focus Tea","[]","").."\n/use Displacer Meditation Stone\n/targetenemy [noexists]")
					EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod,@party4,help,nodead]Renewing Mist;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14\n/use Eternal Black Diamond Ring")
					EditMacro("WSxGen6",nil,nil,"#show\n/use "..b("Storm, Earth, and Fire","[mod]",";")..b("Serenity","[mod]",";")..b("Invoke Xuen, the White Tiger","[mod]",";")..b("Invoke Yu'lon, the Jade Serpent","[mod]",";")..b("Invoke Chi-Ji, the Red Crane","[mod]",";")..b("Invoke Niuzao, the Black Ox","[mod]",";")..b("Breath of Fire","[]",";").."!Spinning Crane Kick\n/use Words of Akunda")
					EditMacro("WSxSGen+6",nil,nil,"/use [noexists,nocombat,nospec:2]\"Purple Phantom\" Contender's Costume;"..b("Fists of Fury","[@mouseover,harm,nodead][]","")..b("Essence Font","[]","")..b("Black Ox Brew","[]","").."\n/targetenemy [noexists]\n/stopmacro [combat]\n/click ExtraActionButton1",1,1)
					EditMacro("WSxGen7",nil,nil,"/use "..b("Exploding Keg","[mod:shift,@player][@cursor]",";")..b("Faeline Stomp","[mod:shift]",";")..b("Bonedust Brew","[mod:shift,@player]",";")..b("Whirling Dragon Punch","[]",";")..b("Storm, Earth, and Fire","[]",";")..b("Serenity","[]",";")..b("Refreshing Jade Wind","[]",";")..b("Summon Jade Serpent Statue","[@cursor]",";").."!Spinning Crane Kick")
					EditMacro("WSxGen8",nil,nil,"#show\n/use "..b("Thunder Focus Tea","[]",";")..b("Summon Jade Serpent Statue","[@cursor]","")..b("Rushing Jade Wind","[]",";")..b("Invoke Xuen, the White Tiger","[]",";")..b("Storm, Earth, and Fire","[]",";")..b("Serenity","[]",";").."!Spinning Crane Kick")
					EditMacro("WSxGen9",nil,nil,"#show\n/use "..b("Invoke Xuen, the White Tiger","[]",";")..b("Storm, Earth, and Fire","[]",";")..b("Serenity","[]",";")..b("Invoke Yu'lon, the Jade Serpent","[]",";")..b("Invoke Chi-Ji, the Red Crane","[]",";")..b("Invoke Niuzao, the Black Ox","[]",";"))
					EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead]Detox")
					EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,help,nodead][@party2,help,nodead]Detox\n/run if not InCombatLockdown() then local j,p,_=C_PetJournal _,p=j.FindPetIDByName(\"Alterac Brew-Pup\") if p and j.GetSummonedPetGUID()~=p then j.SummonPetByGUID(p) end end")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@focus,help,nodead,nochanneling:Soothing Mist][@party1,help,nodead,nochanneling:Soothing Mist]Soothing Mist;[@focus,help,nodead][@party1,help,nodead]Enveloping Mist\n/use [nocombat,noexists]Totem of Harmony")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,help,nodead,nochanneling:Soothing Mist][@party2,nodead,nochanneling:Soothing Mist]Soothing Mist;[@focus,help,nodead][@party2,nodead]Enveloping Mist\n/use [nocombat,noexists]Pandaren Brewpack\n/cancelaura Pandaren Brewpack")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]"..glider..";[mod]6;[nocombat]Resuscitate;"..pwned.."\n/use [mod:ctrl]Reawaken"..brazier)
					EditMacro("WSxGenQ",nil,nil,"#show\n/use "..b("Paralysis","[mod:alt,@focus,harm,nodead]",";")..b("Transcendence","[mod:shift]",";")..b("Spear Hand Strike","[@mouseover,harm,nodead][harm,nodead]",";")..b("Paralysis","[@mouseover,harm,nodead][harm,nodead]",";").."The Golden Banana")
					-- EditMacro("WSxGenQ",nil,nil,"#show\n/use "..b("Spear Hand Strike","[@mouseover,harm,nodead,nomod][nomod,harm,nodead]",";")..b("Transcendence","[mod:shift]",";")..b("Paralysis","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";").."The Golden Banana")
					EditMacro("WSkillbomb",nil,nil,"#show "..b("Storm, Earth, and Fire","[]","")..b("Serenity","[]","")..b("Invoke Xuen, the White Tiger","\n/use []","")..b("Revival","[]","").."\n/use "..b("Storm, Earth, and Fire","[]","")..b("Serenity","[]","")..b("Invoke Xuen, the White Tiger","\n/use []","")..b("Invoke Yu'lon, the Jade Serpent","[]","")..b("Invoke Chi-Ji, the Red Crane","[]","")..b("Invoke Niuzao, the Black Ox","[]","")..b("Fortifying Brew","[]","")..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13\n/use Celestial Defender's Medallion\n/use Big Red Raygun")
					EditMacro("WSxGenE",nil,nil,"#show "..b("Clash","[]",";")..b("Flying Serpent Kick","[]",";")..b("Song of Chi-Ji","[]",";")..b("Soothing Mist","[]","").."\n/use Prismatic Bauble\n/use [mod:alt]Leg Sweep;"..b("Clash","[@mouseover,harm,nodead][harm,nodead]",";")..b("Flying Serpent Kick","[]",";")..b("Soothing Mist","[@mouseover,help,nodead][]",";").."\n/targetenemy [noexists]")
					EditMacro("WSxCGen+E",nil,nil,"#show Roll"..oOtas)
					EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..b("Ring of Peace","[mod:alt,@player]",";")..b("Song of Chi-Ji","[]",";")..b("Summon Black Ox Statue","\n/target Black Ox\n/use [@cursor,nomod:alt]","\n/use [help,nodead]Provoke\n/targetlasttarget"))
					EditMacro("WSxGenR",nil,nil,"#show "..b("Ring of Peace","[]","").."\n/use "..b("Ring of Peace","[mod:shift,@cursor]",";")..b("Tiger's Lust","[mod:ctrl,@player][@mouseover,help,nodead][help,nodead]",";")..b("Disable","[]",";").."[@mouseover,harm,nodead][]Crackling Jade Lightning")
					EditMacro("WSxGenT",nil,nil,"#show "..b("Summon White Tiger Statue","[]",";")..b("Summon Jade Serpent Statue","[]",";")..b("Summon Black Ox Statue","[]",";").."Provoke\n/use [@mouseover,harm,nodead][]Crackling Jade Lightning"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+T",nil,nil,"#show\n/targetenemy [noexists]\n/cleartarget [dead]\n/use "..b("Summon White Tiger Statue","[mod:alt,@cursor]",";")..b("Summon Jade Serpent Statue","[mod:alt,@cursor]",";").."Provoke"..b("Summon Black Ox Statue","\n/target Black Ox\n/use [mod:alt,@player]","\n/use [help,nodead,mod:alt]Provoke\n/targetlasttarget"))
				    EditMacro("WSxCGen+T",nil,nil,"#show\n/targetenemy [noexists]\n/cleartarget [dead]\n/use "..b("Summon Jade Serpent Statue","[mod:alt,@player][@cursor]",";")..b("Summon White Tiger Statue","[mod:alt,@player][@cursor]",";").."Provoke"..b("Summon Black Ox Statue","\n/target Black Ox\n/use [mod:alt,@player][@cursor]","\n/use [help,nodead]Provoke\n/targetlasttarget"))
					EditMacro("WSxGenU",nil,nil,"#show\n/use "..b("Tiger's Lust","[]",";").."Roll")
					EditMacro("WSxGenF",nil,nil,"#show Transcendence: Transfer\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;"..b("Spear Hand Strike","[@focus,harm,nodead]","")..b("Paralysis","[@focus,harm,nodead]",";").."\n/targetenemy [noexists]")
					EditMacro("WSxSGen+F",nil,nil,"/use ".."[nocombat,noexists]Gastropod Shell;"..b("Dampen Harm","[]",";")..b("Diffuse Magic","[]",";")..b("Faeline Stomp","[]","").."\n/use [nocombat]Mulled Alterac Brandy\n/cancelaura [mod]Purple Phantom")
					EditMacro("WSxCGen+F",nil,nil,"#show "..b("Touch of Karma","[]",";")..b("Mana Tea","[]",";")..b("Zen Meditation","[]","").."\n/use "..b("Touch of Karma","[]",";")..b("Revival","[]",";")..b("Zen Meditation","[]",""))
					EditMacro("WSxCAGen+F",nil,nil,"#show "..b("Leg Sweep","[combat][exists,nodead]",";").."Silversage Incense\n/targetfriendplayer\n/use [help,nodead]Tiger's Lust;Silversage Incense\n/targetlasttarget")
					EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]Nimble Brew;"..b("Detox","[@mouseover,help,nodead][]",""))
				    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..b("Bonedust Brew","[@player]",""))
					EditMacro("WSxCSGen+G",nil,nil,"#show Transcendence\n/use [@focus,help,nodead]Detox")
					EditMacro("WSxSGen+H",nil,nil,"#show [nocombat,noexists]Darkmoon Gazer"..b("Paralysis",";","").."\n/use [nomounted]Darkmoon Gazer\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
					EditMacro("WSxAGen+J",nil,nil,"#show\n/use "..invisPot)
					EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;[mod:shift]Fortifying Brew;"..b("Healing Elixir","[]",";")..b("Diffuse Magic","[]",";")..b("Dampen Harm","[]",";").."Fortifying Brew\n/use Lao Chin's Last Mug")
					EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt]Tumblerun Brew;[mod:ctrl]Zen Pilgrimage;[mod:shift]Transcendence: Transfer;"..b("Celestial Brew","[]",";")..b("Touch of Karma","[]",";")..b("Life Cocoon","[@mouseover,help,nodead][nodead]",""))
					EditMacro("WSxGenC",nil,nil,"#show\n/use "..b("Mana Tea","[mod:shift]",";")..b("Paralysis","[mod,@mouseover,harm,nodead][mod]",";")..b("Purifying Brew","[]",";")..b("Renewing Mist","[@mouseover,help,nodead][]",";")..b("Paralysis","[@mouseover,harm,nodead][]","").."\n/cancelaura X-Ray Specs")
					EditMacro("WSxAGen+C",nil,nil,"#show\n/click TotemFrameTotem1 RightButton\n/run PetDismiss()\n/use [noexists,nocombat]Turnip Punching Bag")
					EditMacro("WSxGenV",nil,nil,"#show\n/use Roll\n/use Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Ruthers' Harness\n/use Prismatic Bauble")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem;!Zen Flight\n/use [mod:alt]Weathered Purple Parasol\n/use Mystical Orb of Meditation")
					EditMacro("WSxT100",nil,nil,"#show [spec:3,talent:7/2]Whirling Dragon Punch;[spec:3,talent:7/3]Serenity;")
					
				-- Paladin, bvk, palajong
				elseif class == "PALADIN" then
					EditMacro("WSxGen1",nil,nil,"/use "..b("Intercession","[@mouseover,help,dead][help,dead]",";")..b("Holy Shock","[@mouseover,exists,nodead][exists,nodead]",";").."[nocombat,noexists]!Devotion Aura;"..b("Judgment","[@mouseover,harm,nodead][]","")..b("Eye of Tyr","[]",";")..b("Judgment","[@mouseover,harm,nodead][]","").."\n/use Pretty Draenor Pearl\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+1",nil,nil,"#show Blessing of Protection\n/use [mod:alt,@party3,help,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Flash of Light\n/use Vindicator's Armor Polish Kit")
					EditMacro("WSxGen2",nil,nil,"#show\n/use "..b("Crusader Strike","","").."\n/startattack\n/targetenemy [noexists]\n/cleartarget [dead]\n/cancelaura X-Ray Specs")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/use [@party4,help,nodead,mod:alt][@mouseover,help,nodead][]Flash of Light\n/use Gnomish X-Ray Specs")
					EditMacro("WSxGen3",nil,nil,"/use "..b("Light of the Martyr","[@mouseover,help,nodead][help,nodead]",";")..b("Hammer of Wrath","[@mouseover,harm,nodead][harm,nodead]",";").."Contemplation\n/targetenemy [noexists]\n/stopspelltarget")
					EditMacro("WSxSGen+3",nil,nil,"/use "..b("Rule of Law","[]",";")..b("Execution Sentence","[]",";")..b("Consecration","[]","").."\n/targetenemy [noexists]\n/use Soul Evacuation Crystal")
					EditMacro("WSxGen4",nil,nil,"/use [spec:2,help,nodead,nocombat]Dalaran Disc;[help,nodead,nocombat]Holy Lightsphere;"..b("Avenger's Shield","[@mouseover,harm,nodead][]",";")..b("Blade of Justice","[]",";")..b("Judgment","[]","").."\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
					EditMacro("WSxSGen+4",nil,nil,"#show "..b("Holy Prism","[]",";")..b("Light's Hammer","[]",";")..b("Shield of the Righteous","[]",";").."\n/use "..b("Holy Shock","[@focus,help,nodead,mod:alt][@party1,nodead,mod:alt]",";")..b("Holy Prism","[@mouseover,exists,nodead][exists,nodead]",";")..b("Light's Hammer","[@cursor]",";")..b("Moment of Glory","[]",";")..b("Shield of the Righteous","[]","")..b("Wake of Ashes","[]",";")..b("Judgment","[]","").."\n/targetenemy [noexists]")
					EditMacro("WSxCGen+4",nil,nil,"#show "..b("Beacon of Faith","[]",";").."[spec:1]Beacon of Light;"..b("Final Reckoning","[]",";").."Devotion Aura".."\n/use "..b("Holy Shock","[@party3,help,nodead,mod:alt]",";")..b("Beacon of Faith","[@mouseover,help,nodead][]",";")..b("Final Reckoning","[@cursor]",";")..b("Seraphim","[]",";").."[@mouseover,help,nodead,spec:1][spec:1]Beacon of Light;Devotion Aura\n/startattack [combat]")
					EditMacro("WSxGen5",nil,nil,"/use "..b("Ardent Defender","[mod:ctrl]",";")..b("Aura Mastery","[mod:ctrl]",";")..b("Templar's Verdict","[]",";").."[spec:2,nocombat,noexists]Barrier Generator;[spec:2]Shield of the Righteous;"..b("Holy Light","[@mouseover,help,nodead][]","").."\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+5",nil,nil,"#show\n/use "..b("Exorcism","[]",";")..b("Holy Shock","[@party2,help,nodead,mod:alt][@player]",";")..b("Holy Light","[]",";")..b("Bastion of Light","[]",";")..b("Judgment","[]","").."\n/use [nocombat,noexists]Light in the Darkness")
					EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod,@party4,help,nodead]Holy Shock;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14\n/use Eternal Black Diamond Ring")
					EditMacro("WSxGen6",nil,nil,"#show\n/use "..b("Avenging Wrath","[mod:ctrl]",";")..b("Divine Storm","[]",";")..b("Light of Dawn","[]",";")..b("Consecration","[]",";").."\n/use [mod:ctrl] 19\n/targetenemy [noexists]")
					EditMacro("WSxSGen+6",nil,nil,"#show "..b("Holy Avenger","[]",";")..b("Seraphim","[]",";")..b("Consecration","[]","").."\n/use "..b("Holy Prism","[@player]",";")..b("Light's Hammer","[@player]",";")..b("Holy Avenger","[]",";")..b("Seraphim","[]",";")..b("Consecration","[]",""))
					EditMacro("WSxGen7",nil,nil,"#show\n/use "..b("Final Reckoning","[mod,@player]",";")..b("Holy Avenger","[mod]",";")..b("Seraphim","[mod,talent:5/3]",";")..b("Judgment","[spec:2]",";")..b("Consecration","[]","").."\n/targetenemy [noexists]")
					EditMacro("WSxGen8",nil,nil,"#show "..b("Lay on Hands","[]","").."\n/use "..b("Seraphim","[mod:shift]","").."Shield of the Righteous")
					EditMacro("WSxGen9",nil,nil,"#show "..b("Tyr's Deliverance","[]","").."\n/use "..b("Seraphim","[]",""))
					EditMacro("WSxCSGen+2",nil,nil,"/use [spec:1,@focus,help,nodead][spec:1,@party1,help,nodead]Cleanse;"..b("Cleanse Toxins","[@focus,help,nodead][@party1,help,nodead]",""))
					EditMacro("WSxCSGen+3",nil,nil,"/use [spec:1,@focus,help,nodead][spec:1,@party2,help,nodead]Cleanse;"..b("Cleanse Toxins","[@focus,help,nodead][@party2,help,nodead]","").."\n/use [nocombat,noharm]Forgotten Feather")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Word of Glory")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,help,nodead][@party2,help,nodead]Word of Glory")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]"..glider..";[mod]6;[nocombat]Redemption;"..pwned.."\n/use [mod:ctrl]Absolution"..brazier)
					EditMacro("WSxGenQ",nil,nil,"/use [mod:shift]Divine Shield;"..b("Hammer of Justice","[mod:alt,@focus,harm,nodead][]",";")..b("Rebuke","[@mouseover,harm,nodead][]",""))
					EditMacro("WSkillbomb",nil,nil,"#show\n/use "..b("Avenging Wrath","[]","").."\n/use [@player]13\n/use 13\n/use Sha'tari Defender's Medallion"..dpsRacials[race].."\n/use Gnawed Thumb Ring\n/use Echoes of Rezan")
					EditMacro("WSxGenE",nil,nil,"#show\n/use "..b("Divine Favor","[mod:alt]",";").."[@mouseover,help,nodead][]Word of Glory")
					EditMacro("WSxCGen+E",nil,nil,"#show\n/use [@mouseover,help,nodead][]Lay on Hands\n/use [help,nodead]Apexis Focusing Shard\n/stopspelltarget"..oOtas)
					EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..b("Repentance","[mod:alt,@focus,harm,nodead][]",";")..b("Blinding Light","[]",";").."Hammer of Justice")
					EditMacro("WSxGenR",nil,nil,"#show "..b("Hand of Hindrance","[]",";")..b("Turn Evil","[]","")..b("Divine Favor","[]","").."\n/use "..b("Divine Steed","[mod:ctrl]",";")..b("Blessing of Freedom","[@mouseover,help,nodead][help,nodead]",";")..b("Avenger's Shield","[@mouseover,harm,nodead][harm,nodead]","")..b("Hand of Hindrance","[@mouseover,harm,nodead][harm,nodead]","").."\n/use [mod:ctrl]Prismatic Bauble")
					EditMacro("WSxGenT",nil,nil,"#show "..b("Blessing of Summer","[]","").."\n/use Titanium Seal of Dalaran\n/use "..b("Blessing of Summer","[]","")..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat]Wayfarer's Bonfire")
					EditMacro("WSxSGen+T",nil,nil,"#show\n/use Hand of Reckoning")
				    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..b("Bestow Faith","[mod:alt,@party2,nodead]",";").."[@party4,help,nodead]Word of Glory")
					EditMacro("WSxGenU",nil,nil,"#show\n/use "..b("Repentance","[]",";")..b("Blinding Light","[]",";").."Hammer of Justice")
					EditMacro("WSxGenF",nil,nil,"#show "..b("Blessing of Freedom","","").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use "..b("Repentance","[mod:alt,@focus,harm,nodead]",";").."[mod:alt]Farwater Conch;"..b("Rebuke","[@focus,harm,nodead]",";").."[exists,nodead]Apexis Focusing Shard")
					EditMacro("WSxSGen+F",nil,nil,"#show "..b("Tyr's Deliverance","[]",";")..b("Turn Evil","","").."\n/use [spec:2,@focus,harm,nodead]Avenger's Shield;[nocombat,noexists]Gastropod Shell"..b("Tyr's Deliverance","[]",""))
					EditMacro("WSxCGen+F",nil,nil,"#show [nocombat,noexists]Sense Undead"..b("Blessing of Sacrifice",";[]","").."\n/use "..b("Divine Favor","[]",""))
					EditMacro("WSxCAGen+F",nil,nil,"#show "..b("Aura Mastery","[combat][exists]",";")..b("Turn Evil","[combat]",";").."Contemplation\n/use Contemplation")
					EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]Darkmoon Gazer;[spec:1,@mouseover,help,nodead][spec:1]Cleanse;"..b("Cleanse Toxins","[@mouseover,help,nodead][]",""))
				    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..b("Bestow Faith","[mod:alt,@party1,nodead]",";").."[@party3,help,nodead]Word of Glory;")
					EditMacro("WSxCSGen+G",nil,nil,"#show Divine Shield\n/use [@focus,help,nodead]Cleanse\n/cancelaura Divine Shield\n/cancelaura Blessing of Protection")
					EditMacro("WSxSGen+H",nil,nil,"#show Intercession\n/use [nomounted]Darkmoon Gazer\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
					EditMacro("WSxAGen+J",nil,nil,"#show\n/use "..invisPot)
					EditMacro("WSxGenZ",nil,nil,"/use [mod:alt]!Devotion Aura;"..b("Blessing of Protection","[@mouseover,help,nodead,mod:shift][mod:shift]",";")..b("Blessing of Sacrifice","[@mouseover,help,nodead][help,nodead]",";")..b("Divine Protection","[]",";")..b("Guardian of Ancient Kings","[]","")..";Divine Shield\n/use [mod:alt]Gateway Control Shard")
					EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt]!Retribution Aura;"..b("Blessing of Freedom","[mod:shift]",";")..b("Barrier of Faith","[@mouseover,help,nodead][]",";")..b("Ardent Defender","[spec:2]",";")..b("Shield of Vengeance","[]",";")..b("Lay on Hands","[@mouseover,help,nodead][]",""))
					EditMacro("WSxGenC",nil,nil,"/use "..b("Repentance","[mod]",";")..b("Blessing of Spellwarding","[@mouseover,help,nodead][]",";")..b("Justicar's Vengeance","[]",";")..b("Eye for an Eye","[]",";")..b("Bestow Faith","[@mouseover,help,nodead][]",";")..b("Light's Hammer","[@cursor]",";").."[@mouseover,help,nodead][]Word of Glory")
					EditMacro("WSxAGen+C",nil,nil,"#show [mod]Sylvanas' Music Box;[spec:1,talent:4/3]Rule of Law;[spec:3,talent:5/3]Eye for an Eye;Lay on Hands\n/use "..b("Light's Hammer","[mod:shift,@player]",";").."!Concentration Aura\n/use Sylvanas' Music Box")
					EditMacro("WSxGenV",nil,nil,"#show "..b("Divine Steed","","").."\n/use "..b("Divine Steed","[nospec:1]",";")..b("Beacon of Light","[@mouseover,help,nodead][]","").."\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use [nospec:1]Prismatic Bauble")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";"..b("Turn Evil","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";").."[swimming]Barnacle-Encrusted Gem\n/use [nomod:alt]Seafarer's Slidewhistle\n/use [mod:alt]Weathered Purple Parasol")
					EditMacro("WSxT100",nil,nil,"#show [spec:3,talent:7/3]Final Reckoning;[spec:1,talent:7/2]Beacon of Faith;[spec:1,talent:7/3]Beacon of Virtue;Avenging Wrath")
					if UnitName("player") == "Blackvampkid" then
						EditMacro("WSxCAGen+F",nil,nil,"#show [spec:1,combat][spec:1,exists]Aura Mastery;[combat]Turn Evil;Sun-Lute of the Phoenix King\n/stopmacro [combat,exists]\n/use 16\n/equipset "..EQS[playerspec].."\n/run local _,d,_=GetItemCooldown(44924) if d==0 then EquipItemByName(44924) end")
					end
									
				-- Hunter, hanter 
				elseif class == "HUNTER" then
					local MSK,_ = IsUsableSpell("Mother's Skinning Knife") 
					if MSK == true and eLevel <= 40 then
						MSK = "/targetlasttarget [noexists,nocombat,nodead]\n/use [harm,dead]Mother's Skinning Knife"
					else
						MSK = ""
					end
					EditMacro("WSxGen1",nil,nil,"/use "..b("Misdirection","[@mouseover,help,nodead][help,nodead]",";").."[nocombat,noexists]Mrgrglhjorn;"..b("Rapid Fire","[@mouseover,harm,nodead][harm,nodead]",";")..b("Harpoon","[@mouseover,harm,nodead][harm,nodead]",";")..b("Barbed Shot","[@mouseover,harm,nodead][harm,nodead]",";").."Steady Shot\n/targetenemy [noexists]\n/use [nocombat][noexists]Words of Akunda\n/equipset [noequipped:Two-Hand,spec:3]Menkify!")
					EditMacro("WSxSGen+1",nil,nil,"#show Aspect of the Cheetah\n/use [mod:ctrl,@party2,help,nodead][mod:shift,@pet][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Spirit Mend\n/use [noexists,nocombat]Whitewater Carp\n/targetexact Talua")
					EditMacro("WSxGen2",nil,nil,"/use [@mouseover,harm,nodead][harm,nodead]Steady Shot;[harm,dead]Fetch;Corbyn's Beacon\n/targetlasttarget [noharm,nodead,nocombat]\n/targetenemy [noharm]\n/equipset [noequipped:Bows/Crossbows/Guns]DoubleGate")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/use [spec:1,pet,nopet:Spirit Beast][spec:3,pet]Dismiss Pet;[nopet]Call Pet 2;[@mouseover,help,nodead,pet:Spirit Beast][pet:Spirit Beast,help,nodead][pet:Spirit Beast,@player]Spirit Mend;[spec:3]Arcane Shot;Dismiss Pet\n/use Totem of Spirits")
					EditMacro("WSxGen3",nil,nil,MSK.."\n/use "..b("Kill Shot","[@mouseover,harm,nodead][harm,nodead]",";").."Imaginary Gun\n/use Zanj'ir Weapon Rack\n/targetenemy [noharm]\n/cleartarget [dead]\n/stopspelltarget\n/equipset [noequipped:Two-Hand,spec:3]Menkify!\n/use [spec:2]Dark Ranger's Spare Cowl")
					EditMacro("WSxSGen+3",nil,nil,"/startattack\n/use "..b("A Murder of Crows","[]",";")..b("Bloodshed","[]",";")..b("Serpent Sting","[]",";")..b("Barrage","[]",";")..b("Explosive Shot","[]",";")..b("Wildfire Bomb","[@mouseover,harm,nodead,nomod:alt][nomod:alt]Wildfire Bomb\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [mod:alt]","\n/targetlasttarget")..b("Wailing Arrow","[]",""))
					EditMacro("WSxGen4",nil,nil,"#show\n/use [help,nodead]Dalaran Disc;"..b("Aimed Shot","[harm,nodead]",";")..b("Kill Command","[@mouseover,harm,nodead][harm,nodead]",";").."Puntable Marmot\n/target Puntable Marmot\n/targetenemy [noexists]\n/startattack [harm,combat]\n/cleartarget [dead]")
					EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noharm]\n/cleartarget [dead]\n/use "..b("Flanking Strike","[nomod:alt]",";")..b("Stampede","[nomod:alt]",";")..b("Death Chakram","[nomod:alt]",";")..b("Double Tap","[nomod:alt]",";")..b("Wailing Arrow","[]",";")..b("Chimaera Shot","[]",";")..b("Serpent Sting","[nomod:alt]",";")..b("Misdirection","[nomod:alt]",";")..b("Kill Command","[nomod:alt]Kill Command\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [mod:alt]","\n/targetlasttarget"))
					EditMacro("WSxCGen+4",nil,nil,"/use "..b("Call of the Wild","[]",";")..b("Volley","[@cursor]",";")..b("Fury of the Eagle","[]",";")..b("Spearhead","[]",";")..b("Chakrams","[]",";")..b("Stampede","[]",";")..b("Barrage","[]",";").."Eyes of the Beast")
					EditMacro("WSxGen5",nil,nil,"/use [mod]Exhilaration;[help,nodead]Silver-Plated Turkey Shooter;[nocombat,noexists]Fireworks;"..b("Raptor Strike","[equipped:Two-Hand]",";").."Arcane Shot\n/use [mod]Skoller's Bag of Squirrel Treats\n/cleartarget [dead]\n/targetenemy [noexists]")
					EditMacro("WSxSGen+5",nil,nil,"#show\n/use [nocombat,noexists,mod:alt]Pandaren Scarecrow;"..b("Binding Shot","[mod:alt,@player]",";")..b("Dire Beast","[]",";")..b("Steel Trap","[@cursor]",";")..b("A Murder of Crows","[]",";")..b("Bloodshed","[]",";")..b("Wailing Arrow","[]",";").."Hunter's Mark")
					EditMacro("WSxGen6",nil,nil,"/use "..b("Bestial Wrath","[mod]",";")..b("Trueshot","[mod]",";")..b("Coordinated Assault","[mod]",";").."[nocombat,noexists]Twiddle Twirler: Sentinel's Glaive;"..b("Carve","[]",";")..b("Butchery","[]",";")..b("Multi-Shot","[@mouseover,harm,nodead][]","").."\n/startattack\n/equipset [noequipped:Two-Hand,spec:3]Menkify!")
					EditMacro("WSxSGen+6",nil,nil,"#show "..b("Survival of the Fittest","[]",";")..b("Steel Trap","[@player]",";")..b("Stampede","[]",";")..b("Death Chakram","[]",";")..b("A Murder of Crows","[]",";")..b("Bloodshed","[]",";")..b("Rapid Fire","[]",";")..b("Aspect of the Wild","[]",";")..b("Carve","[]","")..b("Butchery","[]","").."\n/use [nocombat,noexists]Laser Pointer\n/use "..b("Steel Trap","[@player]",";")..b("Stampede","[]",";")..b("Death Chakram","[]",";")..b("A Murder of Crows","[]",";")..b("Bloodshed","[]",";")..b("Rapid Fire","[]",";")..b("Aspect of the Wild","[]",";")..b("Carve","[]","")..b("Butchery","[]",""))
					EditMacro("WSxGen7",nil,nil,"/use "..b("Volley","[mod:shift,@player]",";")..b("Aspect of the Wild","[]",";")..b("Aspect of the Eagle","[]",";")..b("Stampede","[]",";")..b("Death Chakram","[]",";")..b("Barrage","[]",";")..b("Explosive Shot","[]",";")..b("Rapid Fire","[]",";")..b("Aspect of the Wild","[]",""))
					EditMacro("WSxGen8",nil,nil,"#show\n/use "..b("Sentinel Owl","[mod:shift,@player][@cursor]",";")..b("Aspect of the Eagle","[]","")..b("Wailing Arrow","[]",""))
					EditMacro("WSxGen9",nil,nil,"#show\n/use "..b("Stampede","[]",";")..b("Death Chakram","[]",";")..b("Aspect of the Wild","[]",";")..b("Kill Command","[]",""))
					EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead]Misdirection")
					EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,help,nodead][@party2,help,nodead]Misdirection;[nocombat,noharm]Cranky Crab")
					EditMacro("WSxCSGen+4",nil,nil,"#show Play Dead\n/target [pet,pet:Crab]pet\n/run SetTracking(9,true);\n/use [nomounted]Gnomish X-Ray Specs\n/use [nopet]Call Pet 3;[pet:Crab,help,pet]Crab Shank;[nocombat,noexists]Gastropod Shell\n/targetlasttarget [help,nodead,pet,pet:Crab]")
					EditMacro("WSxCSGen+5",nil,nil,"/run SetTracking(4,true);SetTracking(7,true);SetTracking(5,true);SetTracking(10,true);SetTracking(11,true);SetTracking(6,true);SetTracking(8,true);SetTracking(3,true)\n/use Overtuned Corgi Goggles")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]"..glider..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..brazier)
					EditMacro("WSxGenQ",nil,nil,"/use [mod:shift]!Aspect of the Turtle;[nocombat,noexists]The Golden Banana;"..b("Muzzle","[@mouseover,harm,nodead][]","")..b("Counter Shot","[@mouseover,harm,nodead][]","").."\n/use Angler's Fishing Spear")
					EditMacro("WSkillbomb",nil,nil,"#show\n/use "..b("Bestial Wrath","[]",";")..b("Trueshot","[]",";")..b("Coordinated Assault","[]","").."\n/use Will of Northrend"..dpsRacials[race].."\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Pendant of the Scarab Storm\n/use Big Red Raygun\n/use Echoes of Rezan")
					EditMacro("WSxGenE",nil,nil,"/targetenemy [noharm]\n/stopspelltarget\n/use [mod:alt,@cursor]Flare;"..b("Bursting Shot","[]",";").."[@cursor]Flare\n/use [nocombat,noexists]Party Totem\n/cleartarget [dead]")
					EditMacro("WSxCGen+E",nil,nil,"#show\n/use [mod:alt,@player]Freezing Trap"..b("Misdirection",";[@mouseover,help,nodead][help,nodead][@focus,help,nodead][pet,@pet]","")..oOtas)
					EditMacro("WSxSGen+E",nil,nil,"/use "..b("Tar Trap","[mod:alt,@player]",";")..b("Binding Shot","[@cursor]","")..b("Scatter Shot","[@mouseover,harm,nodead][]","").."\n/use [nocombat,noexists]Goblin Fishing Bomb\n/use Bloodmane Charm") 
					EditMacro("WSxGenR",nil,nil,"/use "..b("Tar Trap","[mod:shift,@cursor]",";").."[mod:ctrl,@player][@mouseover,help,nodead,nomod][help,nodead,nomod]Master's Call;[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Wing Clip\n/targetenemy [noharm]")
					EditMacro("WSxGenT",nil,nil,"#show Command Pet\n/use [mod:alt]Hunter's Mark;"..b("Kill Command","[@mouseover,harm,nodead][harm,nodead]",";").."Hunter's Call"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]\n/petattack [@mouseover,harm,nodead][harm,nodead]")
					EditMacro("WSxSGen+T",nil,nil,"/use "..b("Intimidation","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]","")..b("High Explosive Trap","[mod:alt,@player][@cursor]",""))
				    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..b("Sentinel Owl","[mod:alt,@player][@cursor]",";").."\n/use Everlasting Darkmoon Firework\n/use Power Converter\n/use Pandaren Firework Launcher\n/use Azerite Firework Launcher\n/use "..factionFireworks)
					EditMacro("WSxGenU",nil,nil,"#show\n/use "..b("Binding Shot","[]","")..b("Scatter Shot","[]",""))
					EditMacro("WSxGenF",nil,nil,"#show Tar Trap\n/focus [@mouseover,exists]mouseover\n/stopmacro [@mouseover,exists]\n/use [@cursor,mod]!Eagle Eye;[spec:3,@focus,harm,nodead]Muzzle;[@focus,harm,nodead]Counter Shot;[@mouseover,harm,nodead][]Hunter's Mark\n/targetenemy [noharm][dead]")
					EditMacro("WSxSGen+F",nil,nil,"#show Mend Pet\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead,nomod][harm,nodead,nomod]Hunter's Mark;Robo-Gnomebulator\n/use \n/stopmacro [mod:ctrl]\n/petautocasttoggle Growl\n/petautocasttoggle [mod:alt]Spirit Walk")
					EditMacro("WSxCGen+F",nil,nil,"#show Flare\n/run SetTracking(3,false);SetTracking(4,false);SetTracking(5,false);SetTracking(6,false);SetTracking(7,false);SetTracking(8,false);SetTracking(9,false);SetTracking(10,false);SetTracking(11,false);\n/cancelaura X-Ray Specs")
					EditMacro("WSxCAGen+F",nil,nil,"#show Exhilaration\n/run if not InCombatLockdown() then if GetSpellCooldown(5384)==0 then "..tpPants.." else "..noPants.." end end")
				    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..b("Survival of the Fittest","[]",""))
					EditMacro("WSxCSGen+G",nil,nil,"#show "..b("Camouflage","[]",";")..b("Scare Beast","[]","").."\n/cancelaura Whole-Body Shrinka'\n/cancelaura Growing Pains\n/cancelaura Aspect of the Turtle")
					EditMacro("WSxAGen+J",nil,nil,"#show [spec:3]Command Pet;[spec:1,talent:1/3]Dire Beast;[spec:1]Aspect of the Wild;[spec:2]Bursting Shot\n/use "..invisPot)
					EditMacro("WSxGenZ",nil,nil,"#show [mod]Play Dead;Feign Death\n/use [mod:alt]Hunter's Call;[mod]Play Dead;Personal Hologram\n/use [nomod]Feign Death\n/cancelaura Will of the Taunka\n/cancelaura Will of the Vrykul\n/cancelaura Will of the Iron Dwarves\n/use [mod:alt]Gateway Control Shard")
					EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt,exists]Beast Lore;[mod:ctrl,exists,nodead]Tame Beast;[mod]Aspect of the Cheetah;!Aspect of the Turtle\n/use Super Simian Sphere\n/use Angry Beehive\n/use Xan'tish's Flute")
					EditMacro("WSxGenC",nil,nil,"#show Freezing Trap\n/use [mod:ctrl,@cursor]Freezing Trap;[mod,@player]Flare;Revive Pet\n/stopmacro [mod]\n/cancelaura X-Ray Specs\n/cancelaura Safari Hat\n/use [spec:1]Safari Hat\n/use Poison Extraction Totem\n/use Totem of Spirits\n/use Desert Flute")
					EditMacro("WSxAGen+C",nil,nil,"#show [mod]Hunter's Mark;Play Dead\n/use Dismiss Pet\n/click TotemFrameTotem1 RightButton\n/use Crashin' Thrashin' Robot")
					EditMacro("WSxGenV",nil,nil,"#show\n/use Disengage\n/stopcasting\n/use Crashin' Thrashin' Robot\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Ruthers' Harness\n/use Bom'bay's Color-Seein' Sauce\n/use Prismatic Bauble")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@mouseover,harm,nodead][harm,nodead]Scare Beast;[nopet]Call Pet 1;[swimming]Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol\n/use [pet:Water Strider]Surface Trot")
					-- EditMacro("WSxT100",nil,nil,"#show [spec:1,talent:7/3]Bloodshed;[spec:2,talent:7/3]Volley;[spec:3,talent:7/3]Chakrams;Eagle Eye")
					EditMacro("WSxCAGen+B",nil,nil,"")
					EditMacro("WSxCAGen+N",nil,nil,"")	

				-- Rogue, rogge, rouge, raxicil
				elseif class == "ROGUE" then
					EditMacro("WSxGen1",nil,nil,"/use [nocombat,nostealth]Xan'tish's Flute\n/use "..b("Tricks of the Trade","[@mouseover,help,nodead][help,nodead]",";").."[stance:0,nocombat]Stealth;[spec:3]Symbols of Death"..b("Pistol Shot","[]",";")..b("Garrote","[@mouseover,harm,nodead][]","").."\n/targetenemy [noexists]\n/startattack [combat]")
					EditMacro("WSxSGen+1",nil,nil,"#show\n/use "..b("Shadowstep","[mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][]","")..b("Tricks of the Trade","[]","").."\n/targetexact Lucian Trias")
					EditMacro("WSxGen2",nil,nil,"/targetenemy [noexists]\n/use [stance:0,nocombat]Stealth;[stealth,nostance:3,nodead]Pick Pocket;[spec:3]Ambush;Sinister Strike\n/cleartarget [exists,dead]\n/stopspelltarget")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/cast Crimson Vial\n/use [nostealth] Totem of Spirits\n/use [nostealth]Hourglass of Eternity\n/use [nocombat,nostealth,spec:2]Don Carlos' Famous Hat;[nocombat,nostealth]Dark Ranger's Spare Cowl")
					EditMacro("WSxGen3",nil,nil,"/use [stance:0,nocombat]Stealth;"..b("Shadow Dance","[stance:0,combat]",";").."[nostance:0]Ambush;[spec:2]Between The Eyes;"..b("Shiv","[]",";").."Sinister Strike\n/targetenemy [noexists]")
					EditMacro("WSxSGen+3",nil,nil,"#show\n/use [@mouseover,harm,nodead,nospec:2][nospec:2]Rupture;"..b("Cold Blood","[]",";").."[spec:2]Between the Eyes\n/targetenemy [noexists]\n/use [spec:2,nocombat]Ghostly Iron Buccaneer's Hat;[nospec:2]Ravenbear Disguise")
					EditMacro("WSxGen4",nil,nil,"/use [nocombat,noexists,spec:2]Dead Ringer\n/use [nostance:0]Ambush;[spec:3]Backstab;"..b("Sepsis","[]",";")..b("Serrated Bone Spike","[]",";")..b("Ghostly Strike","[]",";").."[spec:1]Sinister Strike;Pistol Shot\n/use [stance:0,nocombat]Stealth\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+4",nil,nil,"/use [nocombat,noexists,nostealth]Barrel of Eyepatches\n/use "..b("Marked for Death","[]",";")..b("Cold Blood","[]",";")..b("Shiv","[]",";").."Feint\n/use [nostealth,nospec:2]Hozen Beach Ball;[nostealth]Titanium Seal of Dalaran\n/targetenemy [noexists]\n/startattack [combat]\n/cleartarget [dead]")
					EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..b("Killing Spree","[]",";")..b("Keep It Rolling","[]",";")..b("Adrenaline Rush","[]",";")..b("Kingsbane","[]",";")..b("Indiscriminate Carnage","[]",";")..b("Sepsis","[]",";")..b("Cold Blood","[]",";")..b("Shuriken Tornado","[]",";")..b("Shadow Blades","[]","")..b("Deathmark","[]","").."\n/targetenemy [noexists,nocombat]\n/use [nocombat,noexists]Gastropod Shell")
					EditMacro("WSxGen5",nil,nil,"#show\n/use [mod:ctrl]Smoke Bomb;Eviscerate\n/targetenemy [noexists]\n/stopmacro [nomod:ctrl]\n/use [spec:2]Mr. Smite's Brass Compass;Shadescale\n/roar")
					EditMacro("WSxSGen+5",nil,nil,"/use [nocombat,noexists,nostealth]Barrel of Bandanas\n/use Slice and Dice\n/use [nocombat,noexists,nostealth] Worn Troll Dice")
					EditMacro("WSxGen6",nil,nil,"#show\n/use "..b("Deathmark","[mod:ctrl]",";")..b("Adrenaline Rush","[mod:ctrl]",";")..b("Shadow Blades","[mod:ctrl]",";")..b("Fan of Knives","[]",";")..b("Blade Flurry","[]",";")..b("Shuriken Storm","[]",""))
					EditMacro("WSxSGen+6",nil,nil,"/use [stance:0,nocombat]Stealth;"..b("Crimson Tempest","[]",";")..b("Roll the Bones","[]",";")..b("Dreadblades","[]",";")..b("Secret Technique","[]",";")..b("Shuriken Tornado","[]",";")..b("Black Powder","[]",";")..b("Blade Flurry","[]",""))
					EditMacro("WSxGen7",nil,nil,"#show\n/use [nocombat,help]Corbyn's Beacon;"..b("Black Powder","[]",";")..b("Blade Rush","[]","")..b("Exsanguinate","[]",";")..b("Rupture","[@mouseover,harm,nodead][]","").."\n/use [stance:0]Stealth;Autographed Hearthstone Card")
					EditMacro("WSxGen8",nil,nil,"#show\n/use "..b("Shuriken Tornado","[]",";")..b("Cold Blood","[]",";")..b("Flagellation","[]",";")..b("Amplifying Poison","[]",";").."Sprint")
					EditMacro("WSxGen9",nil,nil,"#show\n/use "..b("Shadow Dance","[]","")..b("Thistle Tea","[]","")..b("Echoing Reprimand","[]",""))
					EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead][@party1,help,nodead]Tricks of the Trade;")
					EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,help,nodead][@party2,help,nodead]Tricks of the Trade")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@focus,help,nodead][@party3,help,nodead]Tricks of the Trade;[nocombat,noexists]Crashin' Thrashin' Cannon Controller")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,help,nodead][@party4,help,nodead]Tricks of the Trade")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]"..glider..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..brazier)
					EditMacro("WSxGenQ",nil,nil,"#show\n/use "..b("Blind","[mod:alt,@focus,harm,nodead]",";")..b("Cloak of Shadows","[mod:shift]",";").."[@mouseover,harm,nodead][harm,nodead]Kick;The Golden Banana\n/use [spec:2,nocombat,noexists]Rime of the Time-Lost Mariner;[nospec:2,nocombat,noexists]Sira's Extra Cloak")
					EditMacro("WSkillbomb",nil,nil,"/use "..b("Deathmark","[]",";")..b("Adrenaline Rush","[]",";")..b("Shadow Blades","[]",";").."\n/stopmacro [stealth]\n/use Will of Northrend"..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13"..hasHE.."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
					EditMacro("WSxGenE",nil,nil,"/use "..b("Cheap Shot","[mod:alt,@focus,harm,nodead,nostance:0][nostance:0]",";")..b("Shadow Dance","[stance:0,combat]",";")..b("Vanish","[stance:0,combat]",";").."[stance:0,nocombat]Stealth\n/use [nostealth,spec:2,nocombat]Iron Buccaneer's Hat")
					EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..b("Tricks of the Trade","[@focus,help,nodead][@mouseover,help,nodead][help,nodead][@party1,help,nodead]","").."\n/use Seafarer's Slidewhistle"..oOtas)
					EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..b("Garrote","[mod:alt,@focus,harm,nodead,nostance:0][nostance:0]",";")..b("Cheap Shot","[mod:alt,@focus,harm,nodead,nostance:0][nostance:0]",";")..b("Shadow Dance","[stance:0,combat]",";")..b("Vanish","[stance:0,combat]",";").."[stance:0,nocombat]Stealth\n/use [nostealth]Hourglass of Eternity")
					EditMacro("WSxGenR",nil,nil,"#show\n/use "..b("Shadowstep","[@mouseover,help,nodead,nomod:alt][help,nodead,nomod:alt]",";")..b("Poisoned Knife","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";")..b("Pistol Shot","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";")..b("Shuriken Toss","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";").."Horse Head Costume\n/targetenemy [noexists]")
					EditMacro("WSxGenT",nil,nil,"#show\n/stopspelltarget\n/use [nocombat,nostance:1/2/3]Stealth;[@mouseover,exists,nodead,stealth,nocombat][stealth,nocombat,@cursor]Distract"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+T",nil,nil,"#show\n/use "..b("Gouge","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]","").."\n/targetenemy [noexists]")
				    EditMacro("WSxCGen+T",nil,nil,"#show\n/use [@player]Distract")
					EditMacro("WSxGenU",nil,nil,"#show\n/use Sprint")
					EditMacro("WSxGenF",nil,nil,"#show\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Kick;[exists,nodead,spec:1]Detoxified Blight Grenade;Detection")
					EditMacro("WSxSGen+F",nil,nil,"/use "..b("Shadowstep","[@focus,harm,nodead]","\n/use [@focus,harm,nodead]Kick"))
					EditMacro("WSxCGen+F",nil,nil,"#show "..b("Cloak of Shadows","[]","").."\n/use "..b("Garrote","[nostance:0]",";")..b("Cheap Shot","[nostance:0]",";")..b("Vanish","[stance:0,combat]",";").."[stance:0,nocombat]Stealth")
					EditMacro("WSxCAGen+F",nil,nil,"#show [stealth]Shroud of Concealment;[nocombat,noexists]Twelve-String Guitar;Cloak of Shadows\n/targetfriend [nohelp,nodead]\n/use [help,nodead]Shadowstep;[nocombat,noexists]Twelve-String Guitar\n/targetlasttarget")
				    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..b("Cheap Shot","[mod:alt,@focus,harm,nodead,nostance:0][nostance:0]",";")..b("Vanish","[stance:0,combat]",";").."[stance:0,nocombat]Stealth")
					EditMacro("WSxCSGen+G",nil,nil,"#show Blind\n/use Totem of Spirits\n/use [@focus,harm,nodead]Gouge")	
					EditMacro("WSxSGen+H",nil,nil,"#show\n/use [nomounted,nocombat,noexists]Burgy Blackheart's Handsome Hat;Shiv\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
					EditMacro("WSxAGen+J",nil,nil,"#show [spec:2,talent:1/1]Ghostly Strike;[spec:1,talent:1/3]Ambush;[spec:3,talent:1/3]Backstab;Wound Poison\n/use "..invisPot)
					EditMacro("WSxGenZ",nil,nil,"/use "..b("Wound Poison","[mod:alt]",";")..b("Deadly Poison","[mod,spec:1]",";")..b("Instant Poison","[mod]",";").."[stance:0,nocombat]Stealth;"..b("Evasion","[combat]",";").."[stance:1]Shroud of Concealment\n/use [mod:alt]Gateway Control Shard\n/use [spec:2,mod]Slightly-Chewed Insult Book;[mod]Shadowy Disguise")
					EditMacro("WSxGenX",nil,nil,"/use [mod:alt]Crippling Poison;[mod:ctrl]Scroll of Teleport: Ravenholdt;[mod:shift]Sprint;"..b("Feint","[]","").."\n/use [nostealth,mod:shift]Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
					EditMacro("WSxGenC",nil,nil,"#show\n/targetenemy [noexists]\n/use "..b("Blind","[mod:ctrl,@mouseover,harm,nodead][mod:ctrl]",";").."[stance:0,nocombat]Stealth;[@focus,harm,nodead,stance:1/2/3,mod][@mouseover,harm,nodead,stance:1/2/3][stance:1/2/3]Sap;Blind\n/cancelaura Don Carlos' Famous Hat")
					EditMacro("WSxAGen+C",nil,nil,"#show\n/use "..b("Numbing Poison","[]","")..b("Atrophic Poison","[]","").."\n/run PetDismiss();")
					EditMacro("WSxGenV",nil,nil,"/use "..b("Grappling Hook","[@cursor]",";")..b("Shadowstep","[@mouseover,exists,nodead][]","").."\n/targetenemy [noexists]\n/use [nostealth]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use [nostealth]Prismatic Bauble")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem;Survivor's Bag of Coins\n/use [mod:alt]Weathered Purple Parasol")	
					EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen8\",nil,nil,\"\\#show Sprint\\n/use [@\"..B..\"]Tricks of the Trade\\n/stopspelltarget\", nil)print(\"Trix set to : \"..B)else print(\"Combat!\")end")
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen9\",nil,nil,\"\\#show Sprint\\n/use [@\"..N..\"]Tricks of the Trade\\n/stopspelltarget\", nil)print(\"Trix#2 set to : \"..N)else print(\"Combat!\")end")
								
				-- Priest, Prist
				elseif class == "PRIEST" then
					EditMacro("WSxGen1",nil,nil,"/use [help,nodead,nocombat]The Heartbreaker;"..b("Power Infusion","[@mouseover,help,nodead][help,nodead]",";")..b("Schism","[]",";")..b("Power Word: Solace","[]",";")..b("Holy Fire","[@mouseover,harm,nodead][]",";")..b("Mind Spike","[]",";")..b("Void Torrent","[]",";")..b("Damnation","[@mouseover,harm,nodead][]",";").."[@mouseover,harm,nodead][]Shadow Word: Pain\n/startattack")
					EditMacro("WSxSGen+1",nil,nil,"#show Power Infusion\n/use [mod:alt,@party3,nodead][mod:ctrl,@party2,exists][@focus,help][@party1,exists][@targettarget,exists]Flash Heal;Kaldorei Light Globe")
					EditMacro("WSxGen2",nil,nil,"#show\n/cancelaura Fling Rings\n/use [nospec:3,help,nodead]Holy Lightsphere;[help,nodead]Corbyn's Beacon\n/use [@mouseover,harm,nodead][]Smite\n/use [nocombat]Darkmoon Ring-Flinger\n/use Haunting Memento\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/use [mod:alt,@party4,nodead][@mouseover,help,nodead][]Flash Heal\n/use Gnomish X-Ray Specs\n/cancelaura Don Carlos' Famous Hat\n/cancelaura X-Ray Specs")
					EditMacro("WSxGen3",nil,nil,"/targetenemy [noexists]\n/cleartarget [dead]\n/use "..b("Shadow Word: Death","[@mouseover,harm,nodead][harm,nodead]","").."\n/use Scarlet Confessional Book\n/petattack\n/use Ivory Feather\n/use [nocombat,noexists,spec:3]Twitching Eyeball")
					EditMacro("WSxSGen+3",nil,nil,"/targetenemy [noexists]\n/stopspelltarget\n/cleartarget [dead]\n/use "..b("Shadow Word: Pain","[@mouseover,harm,nodead,nomod:alt][nomod:alt]","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Shadow Word: Pain\n/targetlasttarget").."\n/use Totem of Spirits")
					EditMacro("WSxGen4",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,noexists,nochanneling]Pretty Draenor Pearl\n/use "..b("Holy Word: Serenity","[@mouseover,help,nodead][]",";")..b("Penance","[@mouseover,help,nodead][]",";")..b("Mind Blast","[]",""))
					EditMacro("WSxSGen+4",nil,nil,"/stopspelltarget\n/targetenemy [noexists]\n/use "..b("Penance","[@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]",";")..b("Prayer of Mending","[mod:alt,@focus,help,nodead][mod:alt,@party1,help,nodead]",";").."[nocombat,noexists]Leather Love Seat;"..b("Divine Star","[nospec:3]",";")..b("Halo","[nospec:3]",";")..b("Prayer of Healing","[@mouseover,help,nodead][]",";")..b("Shadowform","[noform]",";")..b("Vampiric Touch","[@mouseover,harm,nodead,nomod:alt][nomod:alt]","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Vampiric Touch\n/targetlasttarget"))
					EditMacro("WSxCGen+4",nil,nil,"#show\n/cast "..b("Power Word: Shield","[mod,@party3,help,nodead]",";")..b("Light's Wrath","[@mouseover,help,nodead][]",";")..b("Evangelism","[]",";")..b("Rapture","[]",";")..b("Lightwell","[@cursor]",";")..b("Divine Word","[]",";")..b("Apotheosis","[]",";")..b("Holy Word: Salvation","[]",";")..b("Dark Void","[]",";")..b("Void Torrent","[]",";")..b("Damnation","[@mouseover,harm,nodead][]",";")..b("Power Infusion","[]","").."\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxGen5",nil,nil,"/use "..b("Power Word: Barrier","[mod:ctrl,@cursor]",";")..b("Symbol of Hope","[mod:ctrl]",";")..b("Desperate Prayer","[mod:ctrl]",";")..b("Void Eruption","[@mouseover,harm,nodead][]",";")..b("Heal","[@mouseover,help,nodead][]",";")..b("Mind Blast","[@mouseover,harm,nodead][]","").."\n/use [help,nodead]Apexis Focusing Shard\n/targetenemy [noexists]\n/use [nocombat]Thaumaturgist's Orb\n/use [spec:3]Shadowy Disguise")
					EditMacro("WSxSGen+5",nil,nil,"/use "..b("Devouring Plague","[@mouseover,harm,nodead,nomod:alt][harm,nodead,nomod:alt]","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Devouring Plague\n/targetlasttarget")..b("Penance","[@party2,help,nodead,mod:alt][@player]",";")..b("Prayer of Mending","[@party2,help,nodead,mod:alt]",";")..b("Circle of Healing","[@mouseover,help,nodead][]","").."\n/use [nochanneling]Soul Evacuation Crystal\n/targetenemy [noharm]\n/cleartarget [dead]")
					EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod,@party4,help,nodead]Power Word: Shield;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14\n/use Eternal Black Diamond Ring")
					EditMacro("WSxGen6",nil,nil,"#show\n/use "..b("Divine Hymn","[mod:ctrl]",";")..b("Shadowfiend","[mod:ctrl]",";")..b("Mind Sear","[@mouseover,exists,nodead][]","")..b("Holy Nova","[]",";").."\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+6",nil,nil,"/use "..b("Prayer of Healing","[@mouseover,help,nodead][]",";")..b("Power Word: Radiance","[@mouseover,help,nodead][]",";")..b("Divine Star","[]",";")..b("Halo","[]",";")..b("Mind Sear","[@mouseover,harm,nodead][]","").."\n/use Cursed Feather of Ikzan\n/use [nocombat]Dead Ringer\n/targetenemy [noexists]")
					EditMacro("WSxGen7",nil,nil,"/use "..b("Shadow Covenant","[mod:shift]",";")..b("Holy Word: Sanctify","[@player,mod:shift][@cursor]",";")..b("Shadow Crash","[@player,mod:shift][@cursor]",";")..b("Power Word: Solace","[]",";")..b("Schism","[]",";")..b("Mind Sear","[@mouseover,exists,nodead][]",";").."\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [spec:3]Shadescale")
					EditMacro("WSxGen8",nil,nil,"#show\n/use "..b("Evangelism","[mod:shift]",";")..b("Lightwell","[@player,mod:shift]",";")..b("Mindgames","[@mouseover,harm,nodead][]",";")..b("Void Torrent","[]",";")..b("Damnation","[@mouseover,harm,nodead][]",";"))
					EditMacro("WSxGen9",nil,nil,"#show\n/use "..b("Power Infusion","[mod:shift,@focus,help,nodead][mod:shift,@mouseover,help,nodead][mod:shift]",";")..b("Shadow Covenant","[@mouseover,help,nodead][]",";")..b("Evangelism","[]",";")..b("Rapture","[]",";")..b("Apotheosis","[]",";")..b("Holy Word: Salvation","[]",";")..b("Void Torrent","[]",";")..b("Damnation","[@mouseover,harm,nodead][]",""))
					EditMacro("WSxCSGen+2",nil,nil,"/use [@focus,help,nodead,nospec:3][@party1,help,nodead,nospec:3]Purify;[@focus,help,nodead][@party1,help,nodead]Purify Disease\n/use [@party1,mod]Apexis Focusing Shard\n/use Brynja's Beacon")
					EditMacro("WSxCSGen+3",nil,nil,"/use [nospec:2,@focus,harm,nodead]Shadow Word: Pain;[@party2,help,nodead,nospec:3]Purify;[@party2,help,nodead]Purify Disease\n/use [nocombat,noharm]Forgotten Feather\n/stopspelltarget\n/use [@party2,mod]Apexis Focusing Shard")
					EditMacro("WSxCSGen+4",nil,nil,"/use [spec:3,@focus,harm,nodead]Vampiric Touch;[@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Power Word: Shield;[nocombat]Romantic Picnic Basket\n/use [@party1]Apexis Focusing Shard")
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,spec:3,harm,nodead]Devouring Plague;[@focus,help,nodead][@party2,help,nodead]Power Word: Shield\n/use Battle Standard of Coordination\n/use [@party2]Apexis Focusing Shard")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]"..glider..";[mod]6;[nocombat]Resurrection;"..pwned.."\n/use [mod:ctrl]Mass Resurrection"..brazier)
					EditMacro("WSxGenQ",nil,nil,"#show\n/use "..b("Mind Control","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead,nospec:3][nospec:3]",";")..b("Dominate Mind","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead,nospec:3][nospec:3]",";")..b("Silence","[@mouseover,harm,nodead][]",""))
					EditMacro("WSkillbomb",nil,nil,"/use "..b("Shadowfiend","[]","")..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
					EditMacro("WSxGenE",nil,nil,"#show "..b("Psychic Scream","[]","").."\n/use "..b("Mass Dispel","[mod:alt,@cursor]",";").."[noexists,nocombat]Party Totem\n/use "..b("Holy Nova","[]",";")..b("Psychic Scream","[]",""))
					EditMacro("WSxCGen+E",nil,nil,"#show\n/use Desperate Prayer"..oOtas)
					EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..b("Mass Dispel","[mod:alt,@player]",";")..b("Psychic Scream","[@mouseover,harm,nodead][]","").."\n/use Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
					EditMacro("WSxGenR",nil,nil,"/use "..b("Void Tendrils","[mod:shift]",";")..b("Angelic Feather","[mod:ctrl,@player][@cursor]",";")..b("Power Word: Shield","[mod:ctrl,@player][@mouseover,help,nodead][]","").."\n/stopspelltarget")
					EditMacro("WSxGenT",nil,nil,"#show "..b("Holy Word: Chastise","[]",";")..b("Psychic Horror","[]",";")..b("Evangelism","[]",";").."\n/stopspelltarget\n/use "..b("Mind Soothe","[@mouseover,exists,nodead,nocombat][@cursor,nocombat]",";")..b("Void Shift","[@mouseover,help,nodead][]","")..b("Power Word: Life","[@mouseover,help,nodead][]","")..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists][dead]")
					EditMacro("WSxSGen+T",nil,nil,"#show "..b("Void Tendrils","[]",";")..b("Leap of Faith","[]","").."\n/use "..b("Psychic Horror","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";")..b("Holy Word: Chastise","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";")..b("Leap of Faith","[mod:alt,@focus,help,nodead][@mouseover,help,nodead][exists,nodead]",";"))
				    EditMacro("WSxCGen+T",nil,nil,"")
					EditMacro("WSxGenU",nil,nil,"#show Desperate Prayer\n/use "..b("Empyreal Blaze","[]",""))
					EditMacro("WSxGenF",nil,nil,"#show "..b("Void Shift","[]",";")..b("Power Word: Life","[]","").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod,exists,nodead]Mind Vision;[mod]Farwater Conch;"..b("Silence","[@focus,harm,nodead]",";").."[help,nodead]True Love Prism;Doomsayer's Robes")
					EditMacro("WSxSGen+F",nil,nil,"#show "..b("Empyreal Blaze","[]",";")..b("Shackle Undead","[]","").."\n/use "..b("Shackle Undead","[@focus,harm,nodead]",";").."[help,nocombat,mod:alt]B. F. F. Necklace;[nocombat,noexists,mod:alt]Gastropod Shell;Mind Vision\n/use [nocombat,noexists]Tickle Totem\n/cancelaura [mod:alt]Shadowform")
					EditMacro("WSxCGen+F",nil,nil,"#show "..b("Symbol of Hope","[]",";")..b("Rapture","[]",";")..b("Psychic Scream","[]","").."\n/use [nocombat,noexists]Piccolo of the Flaming Fire;[spec:3]Vampiric Embrace;Rapture\n/cancelaura Twice-Cursed Arakkoa Feather\n/cancelaura Spirit Shell")
					EditMacro("WSxCAGen+F",nil,nil,"#show "..b("Vampiric Embrace","","").."\n/targetfriendplayer\n/use [help,nodead]Power Infusion;Starlight Beacon\n/targetlasttarget")
					EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]Darkmoon Gazer;"..b("Dispel Magic","[@mouseover,harm,nodead]",";").."[nospec:3,@mouseover,help,nodead][nospec:3]Purify"..b("Purify Disease","[@mouseover,help,nodead][]","").."\n/use Tickle Totem")
				    EditMacro("WSxCGen+G",nil,nil,"#show\n/"..b("Void Shift","[@mouseover,help,nodead][]",";")..b("Power Word: Life","[@mouseover,help,nodead][]","").."\n/use Panflute of Pandaria\n/use Puzzle Box of Yogg-Saron\n/use Spectral Visage\n/use Xan'tish's Flute")
					EditMacro("WSxCSGen+G",nil,nil,"#show Fade\n/use [@focus,harm,nodead]Dispel Magic;[nospec:3,@focus,help,nodead][nospec:3]Purify;[@focus,help,nodead][]Purify Disease\n/cancelaura Dispersion\n/cancelaura Spirit of Redemption")
					EditMacro("WSxSGen+H",nil,nil,"#show Leap of Faith\n/use [nocombat,noexists]Don Carlos' Famous Hat"..b("Power Word: Life",";[@mouseover,help,nodead][]","").."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")	    
					EditMacro("WSxAGen+J",nil,nil,"#show [spec:1,talent:1/3]Schism;Power Word: Fortitude\n/use "..invisPot)
					EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;"..b("Power Word: Barrier","[mod,@player]",";")..b("Pain Suppression","[@mouseover,help,nodead][]",";")..b("Guardian Spirit","[@mouseover,help,nodead][]",";")..b("Dispersion","!",""))
					EditMacro("WSxGenX",nil,nil,"/use [mod:alt]Mind Soothe;[mod:shift]Fade;"..b("Mind Control","[mod:ctrl,harm,nodead]",";")..b("Dominate Mind","[mod:ctrl,harm,nodead]",";").."[mod:ctrl]Unstable Portal Emitter;"..b("Power Word: Shield","[@mouseover,help,nodead][]","").."\n/use [nocombat]Bubble Wand\n/use Void Totem\n/cancelaura Bubble Wand")
					EditMacro("WSxGenC",nil,nil,"/use "..b("Shackle Undead","[@mouseover,harm,nodead,mod:ctrl][mod:ctrl]",";")..b("Rapture","[mod:shift]",";")..b("Symbol of Hope","[mod:shift]",";")..b("Prayer of Mending","[@mouseover,help,nodead][]",";")..b("Renew","[@mouseover,help,nodead][]",";")..b("Shadowfiend","[]",""))
					EditMacro("WSxAGen+C",nil,nil,"#show [nospec:3,talent:4/3]Shining Force;[spec:3,talent:4/3]Psychic Horror;Psychic Scream\n/use [nocombat,noexists]Sturdy Love Fool\n/run PetDismiss();\n/cry")
					EditMacro("WSxGenV",nil,nil,"#show "..b("Renew","[combat]",";").."Mind Soothe\n/use "..b("Renew","[@mouseover,help,nodead][]","").."\n/cancelaura Rhan'ka's Escape Plan")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming,noexists,nocombat]Barnacle-Encrusted Gem;Levitate\n/use [nomod:alt]Seafarer's Slidewhistle\n/use [mod:alt]Weathered Purple Parasol")
					-- EditMacro("WSxT100",nil,nil,"#show [spec:3,talent:7/3]Surrender to Madness;[spec:2,talent:7/2]Apotheosis;[spec:2,talent:7/3]Holy Word: Salvation;[spec:1,talent:7/2]Rapture;[spec:1,talent:7/3]Evangelism;Smite")
					EditMacro("WSxCAGen+B",nil,nil,"")
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxCGen+T\",nil,nil,\"\\#show Power Infusion\\n/use [@\"..N..\"]Power Infusion\\n/stopspelltarget\", nil)print(\"PI set to : \"..N)else print(\"Nöpe!\")end")
					
				-- Death Knight, DK, diky
				elseif class == "DEATHKNIGHT" then
					EditMacro("WSxGen1",nil,nil,"#show\n/cast "..b("Raise Ally","[@mouseover,help,dead][help,dead]",";")..b("Frostwyrm's Fury","[]",";")..b("Apocalypse","[]",";")..b("Consumption","[]",";")..b("Blooddrinker","[@mouseover,harm,nodead][]",";")..b("Tombstone","[]",";")..b("Breath of Sindragosa","[]!",";").."Death Strike\n/targetenemy [noexists]")
					EditMacro("WSxSGen+1",nil,nil,"#show Raise Ally\n/use [@mouseover,exists][]Raise Ally\n/use Stolen Breath")
					EditMacro("WSxGen2",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use [harm,dead,nocombat]Corpse Exploder;"..b("Heart Strike","[]",";")..b("Howling Blast","[@mouseover,harm,nodead][]",";")..b("Scourge Strike","[@mouseover,harm,nodead][]","").."\n/startattack")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/use Death Strike\n/use Gnomish X-Ray Specs\n/cancelaura X-Ray Specs")
					EditMacro("WSxGen3",nil,nil,"#show\n/use [nocombat,noexists]Sack of Spectral Spiders;"..b("Soul Reaper","[]",";")..b("Empower Rune Weapon","[]",";")..b("Abomination Limb","[]",";")..b("Scourge Strike","[]",";")..b("Breath of Sindragosa","[]!",";")..b("Obliterate","[]",";")..b("Marrowrend","[]","").."\n/startattack")
					EditMacro("WSxSGen+3",nil,nil,"/use "..b("Glacial Advance","[]",";")..b("Outbreak","[@mouseover,harm,nodead][]",";")..b("Death's Caress","[@mouseover,harm,nodead][]",";")..b("Howling Blast","[]","").."\n/startattack\n/stopspelltarget")
					EditMacro("WSxGen4",nil,nil,"#show\n/use [spec:2,noexists]Vrykul Drinking Horn;"..b("Festering Strike","[]","")..b("Obliterate","[]","")..b("Marrowrend","[]","").."\n/startattack\n/cancelaura Vrykul Drinking Horn")
					EditMacro("WSxSGen+4",nil,nil,"#show Death and Decay\n/use ".."[@focus,mod:alt]Death Coil;[@cursor]Death and Decay\n/use [spec:1]Krastinov's Bag of Horrors\n/targetenemy [noexists]")
					EditMacro("WSxCGen+4",nil,nil,"#show\n/cast "..b("Bonestorm","[]",";")..b("Unholy Assault","[]",";")..b("Summon Gargoyle","[]",";")..b("Apocalypse","[]",";")..b("Empower Rune Weapon","[]","").."\n/use [spec:1,nocombat]For da Blood God!;[nospec:1,nocombat]Will of Northrend\n/startattack")
					EditMacro("WSxGen5",nil,nil,"/use "..b("Anti-Magic Zone","[mod:ctrl,@cursor]",";")..b("Frost Strike","[]",";").."[@mouseover,exists,nodead][]Death Coil\n/startattack\n/cleartarget [dead]\n/use [nospec:2]Aqir Egg Cluster")
					EditMacro("WSxSGen+5",nil,nil,"#show\n/use [@player,mod:alt]Death Coil;"..b("Mark of Blood","[]",";")..b("Tombstone","[]",";")..b("Unholy Blight","[]",";").."[@mouseover,exists,nodead][exists,nodead]Death Coil\n/use Angry Beehive\n/startattack\n/use [mod:alt]Lichborne")
					EditMacro("WSxGen6",nil,nil,"#show\n/use "..b("Dancing Rune Weapon","[mod:ctrl]",";")..b("Pillar of Frost","[mod:ctrl]",";")..b("Army of the Dead","[mod:ctrl,@player]",";")..b("Heart Strike","[]",";")..b("Epidemic","[]",";")..b("Remorseless Winter","[]",";").."\n/use [mod:ctrl]Angry Beehive")
					EditMacro("WSxSGen+6",nil,nil,"#show "..b("Vile Contagion","[]",";")..b("Sacrificial Pact","[]","").."\n/use [@player]Death and Decay\n/use [noexists,nocombat,spec:1] Vial of Red Goo\n/stopspelltarget\n/cancelaura Secret of the Ooze")
					EditMacro("WSxGen7",nil,nil,"#show\n/use "..b("Vile Contagion","[mod:shift]",";")..b("Blood Boil","[nomod]",";")..b("Frostscythe","[nomod]",";")..b("Sacrificial Pact","[mod:shift][]",";").."\n/use "..b("Raise Dead","[mod:shift,nopet]","").."\n/use [nocombat]Champion's Salute")
					EditMacro("WSxGen8",nil,nil,"#show\n/use "..b("Raise Dead","[nopet,mod:shift]",";")..b("Chill Streak","[@mouseover,harm,nodead][]",";").."Corpse Exploder\n/use"..b("Sacrificial Pact","[mod:shift]",""))
					EditMacro("WSxGen9",nil,nil,"#show\n/use "..b("Army of the Dead","[]",";")..b("Anti-Magic Zone","[mod:alt,@player][]",""))
					EditMacro("WSxCSGen+2",nil,nil,"")
					EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noharm]Spirit Wand;[@focus,exists,harm,nodead,spec:3]Outbreak;[@focus,exists,harm,nodead,spec:2]Howling Blast\n/stopspelltarget")
					EditMacro("WSxCSGen+4",nil,nil,"/use \n/use [@pet,pet,nodead]Death Coil\n/use [nocombat]Lilian's Warning Sign")
					EditMacro("WSxCSGen+5",nil,nil,"/clearfocus [dead]\n/use Permanent Frost Essence\n/use Stolen Breath")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]"..glider..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..brazier)
					EditMacro("WSxGenQ",nil,nil,"/use "..b("Asphyxiate","[mod:alt,@focus,harm,nodead]",";").."[mod:shift]Lichborne;"..b("Mind Freeze","[@mouseover,harm,nodead][]",""))
					EditMacro("WSkillbomb",nil,nil,"#show\n/cast "..b("Dancing Rune Weapon","[]",";")..b("Pillar of Frost","[]",";")..b("Raise Dead","[nopet]",";")..b("Dark Transformation","[]","")..dpsRacials[race].."\n/use [@player]13\n/use 13\n/use Raise Dead\n/use Pendant of the Scarab Storm\n/use Adopted Puppy Crate\n/use Big Red Raygun")
					EditMacro("WSxGenE",nil,nil,"#show\n/use "..b("Blinding Sleet","[mod:alt]",";").."[@focus,mod:alt,harm,nodead,pet]Gnaw;[@mouseover,harm,nodead][]Death Grip\n/startattack\n/petattack [mod:alt,@focus,exists,nodead]")
					EditMacro("WSxCGen+E",nil,nil,"#show "..b("Consumption","[]",";")..b("Horn of Winter","[]",";")..b("Unholy Blight","[]",";")..b("Blood Tap","[]","")..oOtas.."\n/use "..b("Horn of Winter","[]",";")..b("Blood Tap","[]",""))
					EditMacro("WSxSGen+E",nil,nil,"#show "..b("Asphyxiate","[]",";")..b("Blinding Sleet","[]",";")..b("Blood Tap","[]",";")..b("Raise Ally","[]","").."\n/use "..b("Blinding Sleet","[]",";")..b("Asphyxiate","[nospec:1]",";")..b("Gorefiend's Grasp","[mod:alt,@player]",";")..b("Rune Tap","[]",""))
					EditMacro("WSxGenR",nil,nil,"#show\n/use "..b("Wraith Walk","[mod:ctrl]!",";")..b("Gorefiend's Grasp","[@mouseover,exists,nodead,mod:shift][mod:shift]",";")..b("Chains of Ice","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]","").."\n/targetenemy [noexists]")
					EditMacro("WSxGenT",nil,nil,"#show Dark Command\n/use "..b("Blood Tap","[]",";")..b("Sacrificial Pact","[spec:2]","")..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]\n/petattack [@mouseover,exists,nodead][]")
					EditMacro("WSxSGen+T",nil,nil,"#show Lichborne\n/use "..b("Gorefiend's Grasp","[mod:alt,@player]",";").."Dark Command\n/use Blight Boar Microphone")
				    EditMacro("WSxCGen+T",nil,nil,"#show\n/use ")
					EditMacro("WSxGenU",nil,nil,"#show\n/use "..b("Rune Tap","[]",";")..b("Blinding Sleet","[]",""))
					EditMacro("WSxGenF",nil,nil,"#show "..b("Death Pact","[]",";")..b("Raise Dead","[]","").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@focus,harm,nodead]Death Grip;[mod:alt]Legion Communication Orb;[@focus,harm,nodead]Mind Freeze\n/petattack [mod:alt,@focus,harm,nodead]")
					EditMacro("WSxSGen+F",nil,nil,"#show\n/petautocasttoggle [mod:alt]Claw\n/use "..b("Blood Tap","[]",";")..b("Raise Dead","[nopet,spec:3]",";")..b("Dark Transformation","[pet,@focus,harm,nodead][pet,harm,nodead]","").."\n/use [pet,@focus,harm,nodead][pet,harm,nodead]!Leap;Gastropod Shell")
					EditMacro("WSxCGen+F",nil,nil,"#show\n/use "..b("Horn of Winter","[]",";")..b("Vampiric Blood","[]",";").."[pet]Huddle")
					EditMacro("WSxCAGen+F",nil,nil,"#show "..b("Path of Frost","[mod:shift]",";")..b("Gorefiend's Grasp","[spec:1]",";").."[spec:3,pet]!Gnaw;Stolen Breath\n/use 16\n/equipset "..EQS[playerspec].."\n/run local _,d,_=GetItemCooldown(151255) if d==0 then EquipItemByName(151255) end")
					EditMacro("WSxGenG",nil,nil,"#show "..b("Anti-Magic Zone","[]",";")..b("Rune Tap","[]",";").."\n/use [mod:alt]S.F.E. Interceptor;[spec:3,nopet]Raise Dead;[@mouseover,harm,nodead,spec:3][spec:3,pet]Leap;"..b("Rune Tap","[]",";").."Death Grip")
				    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..b("Death Pact","[]",""))
					EditMacro("WSxCSGen+G",nil,nil,"#show "..b("Control Undead","","").."\n/cancelaura Lichborne")
					EditMacro("WSxSGen+H",nil,nil,"#show\n/use [nocombat,noexists]Death Gate;[spec:3,nopet]Raise Dead;[@mouseover,harm,nodead,spec:3][spec:3,pet]Gnaw;[nomounted]Death Gate\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
					EditMacro("WSxAGen+J",nil,nil,"#show\n/use "..invisPot)
					EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;"..b("Anti-Magic Zone","[@player,mod:shift]",";")..b("Icebound Fortitude","[]",""))
					EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt]Runeforging;"..b("Control Undead","[mod:ctrl,harm,nodead]",";").."[mod:ctrl]Death Gate;"..b("Anti-Magic Shell","[]",""))
					EditMacro("WSxGenC",nil,nil,"/use "..b("Raise Dead","[mod]","").."\n/use "..b("Sacrificial Pact","[nospec:1,mod]",";").."[spec:3,pet]Leap;"..b("Death Pact","[mod]",";")..b("Blinding Sleet","[]",";")..b("Horn of Winter","[]",";")..b("Asphyxiate","[]",";")..b("Death Grip","[]",""))
					EditMacro("WSxAGen+C",nil,nil,"#show\n/use Sylvanas' Music Box\n/run PetDismiss();\n/cry")
					EditMacro("WSxGenV",nil,nil,"#show\n/use !Death's Advance\n/use Ancient Elethium Coin\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[nomod:alt]Path of Frost\n/use [swimming]Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")

				-- Warrior, warror
				elseif class == "WARRIOR" then	
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
					            local item = bag and C_Container.GetContainerItemInfo(bag, slot)
					            if item and item.itemID then
					                OffHands[EquipmentSets[i]] = GetItemInfo(item.itemID)
				               	elseif player then
						            local itemID = GetInventoryItemID("player", slot)
						            OffHands[EquipmentSets[i]] = GetItemInfo(itemID)
				                end
					        end
					    end
					end
					local swap =  (OffHands["Menkify!"] and ("\n/equipslot [noequipped:Shields,mod,nospec:1] 17 " .. OffHands["Menkify!"]) or "")
					if playerspec == 1 then
						swap = "\n/equipset [noequipped:shields,mod]Menkify!"
					end
					EditMacro("WSxGen1",nil,nil,"#show\n/use [nocombat,help]Corbyn's Beacon;"..b("Colossus Smash","[]",";")..b("Rampage","[]",";").."Shield Block\n/targetenemy [noexists]\n/startattack\n/use Chalice of Secrets" .. (OffHands["DoubleGate"] and ("\n/equipslot [equipped:Shields,spec:2] 17 " .. OffHands["DoubleGate"]) or ""))
					EditMacro("WSxSGen+1",nil,nil,"/use "..b("Ignore Pain","[]",";")..b("Bitter Immunity","[]",";").."\n/use Chalice of Secrets\n/targetexact Aerylia")
					EditMacro("WSxGen2",nil,nil,"/use [nocombat,noexists]Vrykul Drinking Horn;"..b("Mortal Strike","[]",";")..b("Bloodthirst","[]",";")..b("Devastate","[]","").."\n/targetenemy [noexists]\n/cleartarget [noharm]\n/startattack\n/cancelaura Vrykul Drinking Horn\n/equipset [equipped:Shields,spec:1]Noon!")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/use Victory Rush\n/use [noexists,nocombat,nochanneling]Gnomish X-Ray Specs\n/targetenemy [noharm]\n/startattack")
					EditMacro("WSxGen3",nil,nil,"#show\n/use Execute\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]\n/use Banner of the Burning Blade")
					EditMacro("WSxSGen+3",nil,nil,"/use "..b("Rend","[]",";")..b("Thunderous Roar","[]",";")..b("Bladestorm","[]",";")..b("Thunder Clap","[]",";").."Whirlwind\n/startattack")
					EditMacro("WSxGen4",nil,nil,"#show\n/use "..b("Overpower","[]",";").."[spec:3][equipped:Shields,spec:2]Shield Slam;"..b("Raging Blow","[]","").."\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
					EditMacro("WSxSGen+4",nil,nil,"#show\n/use "..b("Ravager","[@cursor]",";")..b("Skullsplitter","[]",";")..b("Siegebreaker","[]","").."\n/use Muradin's Favor\n/startattack")
					EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..b("Odyn's Fury","[]",";")..b("Bladestorm","[]",";")..b("Shield Charge","[]",";")..b("Avatar","[]",";")..b("Recklessness","[]","").."\n/startattack\n/cleartarget [dead]\n/use [nocombat,noexists]Tosselwrench's Mega-Accurate Simulation Viewfinder")
					EditMacro("WSxGen5",nil,nil,"/use "..b("Rallying Cry","[mod]",";")..b("Onslaught","[]",";")..b("Revenge","[]",";").."[equipped:Shields,nospec:3]Shield Slam;Slam\n/startattack\n/cleartarget [dead]\n/stopmacro [nomod]\n/use [mod]Gamon's Braid\n/roar")
					EditMacro("WSxSGen+5",nil,nil,"#show\n/use "..b("Shockwave","[]",";")..b("Thunderous Roar","[]",";")..b("Bladestorm","[]",";").."[spec:2]Slam;Whirlwind\n/startattack")
					EditMacro("WSxGen6",nil,nil,"#show\n/use "..b("Bladestorm","[mod:ctrl]",";")..b("Recklessness","[mod:ctrl]",";")..b("Avatar","[mod:ctrl]",";")..b("Thunder Clap","[spec:3]",";").."Whirlwind\n/startattack\n/use Words of Akunda")
					EditMacro("WSxSGen+6",nil,nil,"#show Shield Block\n/use "..b("Ravager","[@player]",";")..b("Rampage","[]",";").."[spec:3]Shield Block"..b("Sweeping Strikes","[]","").."\n/targetenemy [noexists,nospec:2]\n/targetenemy [spec:2]\n/startattack")
					EditMacro("WSxGen7",nil,nil,"/use [mod]Shield Block;"..b("Thunder Clap","[nospec:3]",";")..b("Bladestorm","[]",";")..b("Sweeping Strikes","[]",";").."[spec:3]Whirlwind\n/startattack"..swap)
					EditMacro("WSxGen8",nil,nil,"#show\n/use "..b("Spear of Bastion","[@player,mod][@cursor]",";")..b("Cleave","[]",";").."Slam")
					EditMacro("WSxGen9",nil,nil,"#show\n/use "..b("Recklessness","[]",";")..b("Sweeping Strikes","[]",";")..b("Cleave","[]",";")..b("Challenging Shout","[]",""))
					EditMacro("WSxCSGen+2",nil,nil,"")
					EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Rend;Vrykul Toy Boat\n/use [nocombat]Vrykul Toy Boat Kit")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@party1,help,nodead][@targettarget,help,nodead]Intervene")
					EditMacro("WSxCSGen+5",nil,nil,"//use [@party2,help,nodead][@targettarget,help,nodead]Intervene")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]"..glider..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..brazier)
					EditMacro("WSxGenQ",nil,nil,"#show Pummel\n/use "..b("Storm Bolt","[mod:alt,@focus,harm,nodead]",";")..b("Berserker Rage","[mod:shift]",";").."[@mouseover,harm,nodead,nomod]Charge\n/use [@mouseover,harm,nodead,nomod][nomod]Pummel\n/use Mote of Light\n/use World Shrinker")
					EditMacro("WSkillbomb",nil,nil,"#show "..b("Avatar","\n/use []","")..b("Recklessness","\n/use ","").."\n/use Flippable Table"..dpsRacials[race]..hasHE.."\n/use Will of Northrend\n/use [@player]13\n/use 13"..b("Thunderous Roar","\n/use []","")..b("Bladestorm","\n/use []","")..b("Ravager","\n/use [@player]","").."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
					EditMacro("WSxGenE",nil,nil,"#show\n/use [@mouseover,harm,nodead][]Charge\n/use [noexists,nocombat]Arena Master's War Horn\n/startattack\n/cleartarget [dead][help]\n/targetenemy [noharm]\n/use Prismatic Bauble")
					EditMacro("WSxCGen+E",nil,nil,"#show Battle Shout\n/use "..b("Last Stand","[]","").."\n/use Outrider's Bridle Chain"..oOtas)
					EditMacro("WSxSGen+E",nil,nil,"#show "..b("Intimidating Shout","\n/startattack\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead][]","\n/targetlasttarget")..b("Demoralizing Shout","[]",""))
					EditMacro("WSxGenR",nil,nil,"#show "..b("Spell Reflection","[spec:3]",";").."Hamstring\n/use "..b("Piercing Howl","[mod:shift]",";")..b("Intervene","[@mouseover,help,nodead,nomod][help,nodead,nomod]","").."\n/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Hamstring\n/startattack")
					EditMacro("WSxGenT",nil,nil,"#show\n/use [@mouseover,harm,nodead][]Heroic Throw"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]\n/use Blight Boar Microphone")
					EditMacro("WSxSGen+T",nil,nil,"#show Taunt\n/use [nocombat,noexists]Blight Boar Microphone;Taunt\n/targetenemy [noexists]")
				    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..b("Challenging Shout","[]",""))
					EditMacro("WSxGenU",nil,nil,"#show\n/use "..b("Intervene","[]",""))
					EditMacro("WSxGenF",nil,nil,"#show "..b("Berserker Rage","[]","").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Pummel;Survey;")
					EditMacro("WSxSGen+F",nil,nil,"#show "..b("Spell Block","[]","").."\n/use [@focus,harm,nodead]Charge\n/use [@focus,harm,nodead]Pummel\n/use [nocombat,noexists,mod:alt]Gastropod Shell;Faintly Glowing Flagon of Mead")
					EditMacro("WSxCGen+F",nil,nil,"#show\n/use "..b("Demoralizing Shout","[]",";").."Battle Shout")
					EditMacro("WSxCAGen+F",nil,nil,"#show "..b("Rallying Cry","[]","").."\n/use [nocombat]Throbbing Blood Orb\n/stopmacro [combat,exists]\n/run local _,d=GetItemCooldown(39769) if d==0 then EquipItemByName(39769) else C_EquipmentSet.UseEquipmentSet(C_EquipmentSet.GetEquipmentSetID(\""..EQS[playerspec].."\")) end\n/use 16")
					EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]S.F.E. Interceptor;"..b("Shattering Throw","[@mouseover,harm,nodead][]",";")..b("Wrecking Throw","[@mouseover,harm,nodead][]","").."\n/targetenemy [noharm]")
				    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..b("Spell Block","[]",";"))
					EditMacro("WSxCSGen+G",nil,nil,"#show\n/use "..b("Bitter Immunity","[]",";"))
					EditMacro("WSxSGen+H",nil,nil,"#show Battle Shout\n/use [nomounted]Darkmoon Gazer\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
					EditMacro("WSxAGen+J",nil,nil,"#show\n/use "..invisPot)
					EditMacro("WSxGenZ",nil,nil,"#show\n/use "..b("Defensive Stance","[mod]!",";")..b("Die by the Sword","[]",";")..b("Enraged Regeneration","[]",";")..b("Shield Wall","[]","").."\n/use Stormforged Vrykul Horn\n/use [mod:alt]Gateway Control Shard")
					EditMacro("WSxGenX",nil,nil,"#show\n/use "..b("Battle Stance","[mod]!",";")..b("Berserker Stance","[mod:alt]!",";")..b("Last Stand","[nomod]",";")..b("Spell Reflection","[nomod]","").."\n/targetfriend [mod:shift,nohelp]\n/use [mod:shift,help,nodead]Intervene\n/targetlasttarget [mod:shift]")
					EditMacro("WSxGenC",nil,nil,"#show "..b("Intimidating Shout","[]",";")..b("Spell Reflection","[]","").."\n/use "..b("Intimidating Shout","[mod:ctrl]",";")..b("Spell Reflection","[]","").."\n/use Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
					EditMacro("WSxAGen+C",nil,nil,"#show\n/use Sylvanas' Music Box\n/run PetDismiss();\n/cry")
					EditMacro("WSxGenV",nil,nil,"/use "..b("Heroic Leap","[@cursor]","").."\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[nomod:alt]Heroic Leap\n/use [swimming]Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")
				
				-- Druid, dodo
				elseif class == "DRUID" then

					local dOH = "Teleport: Moonglade"
					if IsSpellKnown(193753) == true then
						dOH = "Dreamwalk"
					end

					-- Block for Healer-Innervate secure pre-parser
					local healer = "help,nodead" 
					for i = 1, 5 do 
						if UnitGroupRolesAssigned("party"..i) == "HEALER" then 
							healer = "@".."party"..i 
							-- print(healer)
						end 
					end
					
					EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,dead][help,dead]Rebirth;"..b("Innervate","[@mouseover,help,nodead][help,nodead]",";").."[@mouseover,harm,nodead][harm,nodead]Moonfire;Druid and Priest Statue Set\n/use [nocombat,noform:1/4]!Prowl\n/targetenemy [noexists]")
					EditMacro("WSxSGen+1",nil,nil,"#show "..b("Tranquility","[]",";").."Mark of the Wild\n/use [mod:alt,@party3,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Regrowth;Kalytha's Haunted Locket")
					EditMacro("WSxGen2",nil,nil,"/use [form:2]Shred;[form:1]Mangle;"..b("Sunfire","[@mouseover,harm,nodead][harm,nodead]",";").."Moonfeather Statue\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+2",nil,nil,"#show\n/cancelaura X-Ray Specs\n/use [mod:alt,@party4,nodead][@mouseover,help,nodead][]Regrowth\n/use Gnomish X-Ray Specs")
					EditMacro("WSxGen3",nil,nil,"#show\n/use "..b("Rip","[form:2]",";")..b("Pulverize","[form:1]",";")..b("Lunar Beam","[form:1]",";")..b("Frenzied Regeneration","[form:1]",";")..b("Starsurge","[]","").."\n/targetenemy [noexists]\n/use Desert Flute")
					EditMacro("WSxSGen+3",nil,nil,"#show "..b("Invigorate","","")..b("Rake","\n/use [noform:2]Cat Form;[form:2]","\n/use !Prowl")..b("Lifebloom","\n/use [@mouseover,help,nodead][]","")..b("Frenzied Regeneration","\n/use [noform:1]Bear Form;[form:1]",""))
					EditMacro("WSxGen4",nil,nil,"/use [form:2]Shred;[form:1]Mangle;"..b("Starfire","[@mouseover,harm,nodead][]","").."\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,nostealth,noform:1]!Prowl")
					EditMacro("WSxSGen+4",nil,nil,"/use "..b("Rejuvenation","[@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]",";")..b("Lifebloom","[@mouseover,help,nodead][]",";")..b("Moonkin Form","[noform:4]",";")..b("Stellar Flare","[@mouseover,harm,nodead][]",";")..b("New Moon","[]",";")..b("Fury of Elune","[]",";")..b("Bristling Fur","[noform:1]Bear Form;[form:1]",";").."Charm Woodland Creature\n/targetenemy [noexists]")
					EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..b("Rejuvenation","[@party3,help,nodead,mod:alt]",";")..b("Fury of Elune","[]",";")..b("New Moon","[]",";")..b("Warrior of Elune","[]",";")..b("Force of Nature","[@cursor]",";")..b("Feral Frenzy","[noform:2]Cat Form;[form:2]",";")..b("Rage of the Sleeper","[noform:1]Bear Form;[form:1]",";")..b("Flourish","[]",";")..b("Adaptive Swarm","[@mouseover,exists,nodead][]",";")..b("Incapacitating Roar","[]",""))	
					EditMacro("WSxGen5",nil,nil,"#show\n/use "..b("Incarnation: Tree of Life","[mod:ctrl]!",";").."[mod:ctrl,nocombat,resting]Treant Form;"..b("Renewal","[mod:ctrl]",";").."[form:2]Ferocious Bite;"..b("Maul","[form:1]",";").."[form:1]Mangle;"..b("Nourish","[@mouseover,help,nodead]",";").."[harm,nodead]Wrath;Hunter's Call\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+5",nil,nil,"#show "..b("Frenzied Regeneration","","").."\n/use "..b("Rejuvenation","[@party2,help,nodead,mod:alt]",";").."[nocombat,help,nodead]Corbyn's Beacon;"..b("Frenzied Regeneration","[noform:1]Bear Form;[form:1]",";")..b("Tiger's Fury","[noform:2]Cat Form;[form:2]",";")..b("Nourish","[@mouseover,help,nodead][]",";")..b("Astral Communion","[]",";")..b("Cenarion Ward","[@mouseover,help,nodead][]","").."\n/use [spec:2/3]Bloodmane Charm")
					EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod,@party4,help,nodead]Rejuvenation;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14\n/use Eternal Black Diamond Ring")
					EditMacro("WSxGen6",nil,nil,"/use "..b("Celestial Alignment","[mod]",";")..b("Incarnation: Chosen of Elune","[mod]!",";")..b("Incarnation: Avatar of Ashamane","[mod]!",";")..b("Incarnation: Guardian of Ursoc","[mod]!",";")..b("Berserk","[mod]",";")..b("Tranquility","[mod]",";")..b("Thrash","[form:1/2]",";[spec:2,noform:1/2]Cat Form;")..b("Starfall","[]",";")..b("Nourish","[@mouseover,help,nodead][]",";")..b("Sunfire","[@mouseover,help,nodead][]",""))
					EditMacro("WSxSGen+6",nil,nil,"#show\n/use "..b("Primal Wrath","[form:2]",";")..b("Wild Growth","[@mouseover,help,nodead][]","").."\n/use Kaldorei Wind Chimes")
					EditMacro("WSxGen7",nil,nil,"/use "..b("Efflorescence","[mod,@player][@cursor,noform:1/2]",";")..b("Wild Mushroom","[mod,@player,noform:1/2][noform:1/2]",";")..b("Starfall","[noform:1/2]",";")..b("Swipe","[noform:1/2]Cat Form;[form:1/2]",""))
					EditMacro("WSxGen8",nil,nil,"#show\n/use "..b("Adaptive Swarm","[@mouseover,exists,nodead][]",";")..b("Force of Nature","[@cursor]",";")..b("Invigorate","[@mouseover,help,nodead,mod][mod]",";")..b("Overgrowth","[@mouseover,help,nodead][]",";")..b("Ironfur","[]",""))
					EditMacro("WSxGen9",nil,nil,"#show\n/use "..b("Astral Communion","[]",";")..b("Tiger's Fury","[]",";")..b("Cenarion Ward","[]",";")..b("Bristling Fur","[]",";"))
					EditMacro("WSxCSGen+2",nil,nil,"/use [spec:4,@focus,help,nodead][spec:4,@party1,help,nodead]Nature's Cure;[@focus,help,nodead][@party1,help,nodead]Remove Corruption\n/use [nocombat]Spirit of Bashiok")
					EditMacro("WSxCSGen+3",nil,nil,"/use [@party2,help,nodead,spec:4,nomod]Nature's Cure;[@party2,help,nodead,nomod]Remove Corruption\n/use [@party1,help]Innervate\n/use [@party2,help]Innervate\n/use [@party3,help]Innervate\n/use [@party4,help]Innervate")
					EditMacro("WSxCSGen+4",nil,nil,"/use [@focus,spec:4,help,nodead][@party1,help,nodead,spec:4]Lifebloom;[noform:2]!Cat Form\n/stopmacro [noform:2]\n/run SetTracking(3,true);") 
					EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,spec:4,help,nodead][@party2,help,nodead,spec:4]Lifebloom;[noform:2]!Cat Form\n/use Battle Standard of Coordination\n/run SetTracking(4,true);")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/cancelaura Flap\n/use [mod:ctrl]"..glider..";[mod]6;[nocombat]Revive;"..pwned.."\n/use [mod:ctrl]Revitalize"..brazier)
					EditMacro("WSxGenQ",nil,nil,"/use "..b("Cyclone","[mod:alt,@focus,harm,nodead]",";")..b("Skull Bash","[@mouseover,harm,nodead,form:1/2,nomod:alt][form:1/2,nomod:alt]",";[noform:1/2,nomod:alt]Cat Form")..b("Solar Beam","[@mouseover,harm,nodead][]",""))
					EditMacro("WSkillbomb",nil,nil,"#show "..b("Celestial Alignment","\n/use ","")..b("Incarnation: Chosen of Elune","\n/use !","")..b("Incarnation: Avatar of Ashamane","\n/use !","")..b("Incarnation: Guardian of Ursoc","\n/use !","")..b("Berserk","\n/use ","")..b("Incarnation: Tree of Life","\n/use !","")..b("Overgrowth","\n/use ","")..b("Force of Nature","\n/use [@player]","")..dpsRacials[race].."\n/use [spec:1/4]Rukhmar's Sacred Memory;Will of Northrend\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
					EditMacro("WSxGenE",nil,nil,"#show "..b("Incapacitating Roar","[]",";")..b("Mighty Bash","[]",";")..b("Ursol's Vortex","[]",";")..b("Mass Entanglement","[]","").."\n/use "..b("Nature's Swiftness","[mod:alt]",";")..b("Wild Charge","[help,nodead,noform][form:1/2]","").."\n/use [noform:1]!Prowl;[combat,noform:1/2]Bear Form(Shapeshift)\n/targetenemy [noexists]\n/cancelform [help,nodead]\n/use [nostealth]Prismatic Bauble")
					EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..b("Solar Beam","[mod:alt,@focus,harm,nodead]",";")..b("Renewal","[]",";")..b("Nature's Swiftness","[]",";").."\n/use [nocombat]Mylune's Call"..oOtas)
					EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..b("Ursol's Vortex","[mod:alt,@player]",";")..b("Solar Beam","[mod:alt,@focus,harm,nodead]",";")..b("Incapacitating Roar","[]",";")..b("Mighty Bash","[]",";")..b("Solar Beam","[@mouseover,harm,nodead][]",";").."\n/use [nomod]!Prowl")
					EditMacro("WSxGenR",nil,nil,b("Wild Charge","/cancelform [form,@mouseover,help,nodead,nomod]\n/use [@mouseover,help,nodead,nomod]",";")..b("Typhoon","[nomod]","")..b("Stampeding Roar","\n/use [mod:ctrl]","")..b("Ursol's Vortex","\n/use [@cursor,mod:shift][nomod,@cursor]","")..b("Mass Entanglement","\n/use [mod:shift][nomod]","")..b("Stampeding Roar","\n/use [nomod]","")..";Entangling Roots")
					EditMacro("WSxGenT",nil,nil,"#show Entangling Roots\n/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Entangling Roots"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+T",nil,nil,"#show Growl\n/use [noform:1]Bear form(Shapeshift);Growl\n/use [spec:3]Highmountain War Harness\n/cancelaura [noform:1]Highmountain War Harness")
				    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..b("Invigorate","[@mouseover,help,nodead][]",""))
					EditMacro("WSxGenU",nil,nil,"#show\n/use !Prowl")
					EditMacro("WSxGenF",nil,nil,"#show Barkskin\n/focus [@mouseover,exists]mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;"..b("Skull Bash","[@focus,harm,nodead,form:1/2]",";[noform:1/2]Bear Form;")..b("Solar Beam","[@focus,harm,nodead]",";"))
					EditMacro("WSxSGen+F",nil,nil,"#show "..b("Stampeding Roar","","").."\n/cancelform [mod:alt]\n/use [mod:alt,nocombat]Gastropod Shell;"..b("Wild Charge","[nomod:alt,form:3/6]",";").."[nomod:alt,noform:3/6]Travel Form(Shapeshift)\n/stopspelltarget\n/use Prismatic Bauble")
					EditMacro("WSxCGen+F",nil,nil,"#show\n/use [nocombat,noexists]Mushroom Chair\n/use "..b("Nature's Vigil","[]",";")..b("Heart of the Wild","[]",""))
					EditMacro("WSxCAGen+F",nil,nil,"#show "..b("Innervate","[]",";")..b("Renewal","[]",";").."\n/use [nocombat,noexists]Tear of the Green Aspect\n/targetfriend [nohelp,nodead]\n/cancelform [help,nodead]\n/use [help,nodead]Wild Charge\n/targetlasttarget\n/use Prismatic Bauble")
					EditMacro("WSxGenG",nil,nil,"/use [nocombat,noexists,mod]Darkmoon Gazer;"..b("Stampeding Roar","[mod]",";")..b("Soothe","[@mouseover,harm,nodead]",";")..b("Nature's Cure","[@mouseover,help,nodead][]",";")..b("Remove Corruption","[@mouseover,help,nodead][]","").."\n/use Poison Extraction Totem")
				    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..b("Overgrowth","[@mouseover,help,nodead][]",""))
					EditMacro("WSxCSGen+G",nil,nil,"#show Dash\n/use [spec:4,@focus,help,nodead]Nature's Cure;[@focus,help,nodead]Remove Corruption")
					EditMacro("WSxSGen+H",nil,nil,"/use "..b("Solar Beam","[@mouseover,harm,nodead][]",";")..b("Nature's Swiftness","[]",";").."\n/use Wisp Amulet\n/stopmacro [combat]\n/run if not (IsControlKeyDown()) then if IsMounted() or GetShapeshiftFormID() ~= nil then DoEmote(\"mountspecial\") end end")
					EditMacro("WSxAGen+J",nil,nil,"#show\n/use "..invisPot)
					EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Nature's Beacon;"..b("Ironbark","[@mouseover,help,nodead,nomod][nomod]",";")..b("Survival Instincts","[nomod]",";").."[mod][]Barkskin\n/use [mod:alt]Gateway Control Shard")
					EditMacro("WSxGenX",nil,nil,"/use [mod:alt]Mount Form;[noform:2,mod:shift]!Cat Form;[mod:shift]Dash;"..b("Hibernate","[mod:ctrl,harm,nodead]",";").."[mod:ctrl]"..dOH..";"..b("Ironfur","[form:1]",";")..b("Swiftmend","[@mouseover,help,nodead][]","").."\n/stopmacro [stealth]\n/use Path of Elothir\n/use Prismatic Bauble")
				 	EditMacro("WSxGenC",nil,nil,"/use "..b("Innervate","[mod:shift,"..healer.."][mod:shift,@player]",";")..b("Cyclone","[@mouseover,harm,nodead,mod][mod]",";")..b("Frenzied Regeneration","[form:1]",";")..b("Tiger's Fury","[form:2]",";")..b("Astral Communion","[form:4]",";")..b("Rejuvenation","[@mouseover,help,nodead][noform:1]",";").."\n/use Totem of Spirits\n/cancelform [mod:shift,form:1/2]")
					EditMacro("WSxAGen+C",nil,nil,"#show\n/run PetDismiss();\n/cry")
					EditMacro("WSxGenV",nil,nil,"#show "..b("Wild Charge","[]","").."\n/use "..b("Moonkin Form","[noform:4]",";")..b("Wild Charge","[@mouseover,exists,nodead][]",";")..b("Renewal","[]","").."\n/use Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
			 		EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";"..b("Moonkin Form","[noform:4]",";!Flap;")..b("Wild Charge","[noform]Mount Form;[form]",";").."\n/cancelform [form:1/2]\n/cancelaura Prowl\n/use [mod:alt]Weathered Purple Parasol\n/use [nomod:alt,nostealth,form]Seafarer's Slidewhistle")				

				-- Demon Hunter, DH, Fannyvision, Dihy
				elseif class == "DEMONHUNTER" then
					EditMacro("WSxGen1",nil,nil,"#show\n/use [@cursor]Fel Rush\n/targetenemy [noexists]\n/startattack\n/use Prismatic Bauble")
					EditMacro("WSxSGen+1",nil,nil,"#show Skull of Corruption\n/use [nocombat]Skull of Corruption")
					EditMacro("WSxGen2",nil,nil,"#show\n/use [nocombat,noexists]Verdant Throwing Sphere\n/targetlasttarget [noexists,nocombat]\n/use [harm,dead,nocombat,nomod]Soul Inhaler;[spec:1]Demon's Bite;[spec:2]Shear\n/cleartarget [dead]\n/targetenemy [noexists]\n/startattack")
					EditMacro("WSxSGen+2",nil,nil,"#show "..b("Fel Eruption","[]",";")..b("Fel Devastation","[]",";").."Gnomish X-Ray Specs\n/use Gnomish X-Ray Specs\n/use "..b("Fel Eruption","[]",";")..b("Fel Devastation","[]",";").."\n/startattack\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxGen3",nil,nil,"#show\n/use "..b("Felblade","[]",";").."[spec:2]Demon Spikes;[@mouseover,harm,nodead][]Throw Glaive\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]\n/use Imp in a Ball")
					EditMacro("WSxSGen+3",nil,nil,"#show\n/use "..b("Essence Break","[]",";").."[@mouseover,harm,nodead,nomod:alt][nomod:alt]Throw Glaive;[nocombat]Legion Pocket Portal\n/targetenemy [noexists]\n/startattack\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Throw Glaive\n/targetlasttarget")
					EditMacro("WSxGen4",nil,nil,"#show\n/use "..b("Spirit Bomb","[]",";")..b("Eye Beam","[]","").."\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
					EditMacro("WSxSGen+4",nil,nil,"#show\n/use "..b("Elysian Decree","[@player,mod:alt][@cursor]",";")..b("Glaive Tempest","[]",";")..b("Fel Barrage","[]",";")..b("Shear","[]",";").."\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
					EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..b("The Hunt","[@mouseover,harm,nodead][]",";")..b("Bulk Extraction","[]",";")..b("Soul Barrier","[]",";")..b("Fel Barrage","[]",";")..b("Glaive Tempest","[]",";")..b("Darkness","[]",";")..b("Fiery Brand","[]","").."\n/targetenemy [noexists]\n/startattack")
					EditMacro("WSxGen5",nil,nil,"#show\n/use "..b("Darkness","[mod:ctrl]",";").."Chaos Strike;"..b("Soul Cleave","[]","").."\n/use [mod:ctrl]Shadescale\n/startattack\n/targetenemy [noexists]")
					EditMacro("WSxSGen+5",nil,nil,"#show\n/use [spec:2,@player]Infernal Strike;"..b("Glaive Tempest","[]",";")..b("Fel Barrage","[]",";")..b("Chaos Nova","[]","").."\n/targetenemy [noexists]\n/startattack")
					EditMacro("WSxGen6",nil,nil,"#show\n/use [mod:ctrl,@cursor]Metamorphosis;[spec:2]Immolation Aura;Blade Dance\n/targetenemy [noexists]")
					EditMacro("WSxSGen+6",nil,nil,"#show\n/use [spec:2]Demon Spikes;Immolation Aura\n/stopspelltarget")
					EditMacro("WSxGen7",nil,nil,"#show\n/use "..b("Sigil of Flame","[@player,mod:shift][@cursor]","").."\n/targetenemy [noexists]")
					EditMacro("WSxGen8",nil,nil,"#show\n/use "..b("Soul Carver","[]",";").."Immolation Aura")
					EditMacro("WSxGen9",nil,nil,"#show\n/use Throw Glaive")
					EditMacro("WSxCSGen+2",nil,nil,"")
					EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noexists]The Perfect Blossom;[@focus,harm,nodead]Throw Glaive;Fel Petal;")
					EditMacro("WSxCSGen+4",nil,nil,"")
					EditMacro("WSxCSGen+5",nil,nil,"/clearfocus")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/cancelaura Glide\n/use [mod:ctrl]"..glider..";[mod]6;[nocombat]Ultimate Gnomish Army Knife;"..pwned..""..brazier)
					EditMacro("WSxGenQ",nil,nil,"/use "..b("Imprison","[mod:alt,@focus,harm,nodead]",";").."[@mouseover,harm,nodead][]Disrupt")
					EditMacro("WSkillbomb",nil,nil,"/use [@player]Metamorphosis\n/use [@player]13\n/use 13"..dpsRacials[race].."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
					EditMacro("WSxGenE",nil,nil,"#show\n/use [mod:alt]!Spectral Sight;"..b("Chaos Nova","[]",""))
					EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..b("Sigil of Misery","[mod:alt,@player]","")..oOtas)
					EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..b("Sigil of Silence","[mod:alt,@player][@cursor]",";")..b("Sigil of Misery","[mod:alt,@player][@cursor]",""))
					EditMacro("WSxGenR",nil,nil,"#show\n/use "..b("Netherwalk","[mod:ctrl]",";")..b("Sigil of Chains","[mod:ctrl,@player][mod:shift,@cursor]",";").."[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Throw Glaive\n/startattack")
					EditMacro("WSxGenT",nil,nil,"#show\n/use [@mouseover,harm,nodead][]Throw Glaive"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+T",nil,nil,"#show Torment\n/use Torment\n/targetenemy [noexists]\n/cleartarget [dead]")
				    EditMacro("WSxCGen+T",nil,nil,"#show\n/use ")
					EditMacro("WSxGenU",nil,nil,"#show\n/use "..b("Darkness","",""))
					EditMacro("WSxGenF",nil,nil,"#show "..b("Sigil of Misery","","").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,exists,nodead]All-Seer's Eye;[mod:alt]Legion Communication Orb;[@focus,harm,nodead]Disrupt;[nocombat,noexists]Micro-Artillery Controller")
					EditMacro("WSxSGen+F",nil,nil,"#show "..b("Sigil of Silence","","")..b("Netherwalk","[]",";").."\n/cancelaura [mod:alt]Spectral Sight\n/use [nocombat,noexists]Gastropod Shell")
					EditMacro("WSxCGen+F",nil,nil,"#show Glide\n/cancelaura Wyrmtongue Disguise")
					EditMacro("WSxCAGen+F",nil,nil,"#show "..b("Sigil of Chains","[]",";").."Fel Rush\n/run if not InCombatLockdown() then if GetSpellCharges(195072)>=1 then "..tpPants.." else "..noPants.." end end")
					EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]S.F.E. Interceptor;"..b("Consume Magic","[@mouseover,harm,nodead][]",""))
				    EditMacro("WSxCGen+G",nil,nil,"#show\n/use ")
					EditMacro("WSxCSGen+G",nil,nil,"#show\n/use [@focus,harm,nodead]Consume Magic\n/use Wisp Amulet\n/cancelaura Netherwalk")
					EditMacro("WSxSGen+H",nil,nil,"#show Spectral Sight\n/use Wisp Amulet\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
					EditMacro("WSxAGen+J",nil,nil,"#show\n/use "..invisPot)
					EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;"..b("Fiery Brand","[]",";").."Blur")
					EditMacro("WSxGenX",nil,nil,"#show\n/use "..b("Netherwalk","[mod:shift][]!",";")..b("Soul Barrier","[]",";")..b("Bulk Extraction","[]",";").."\n/use Shadescale")
					EditMacro("WSxGenC",nil,nil,"#show\n/use "..b("Sigil of Misery","[@cursor,mod:ctrl]",";")..b("Imprison","[@mouseover,harm,nodead][]","").."\n/cancelaura X-Ray Specs")
					EditMacro("WSxAGen+C",nil,nil,"#show\n/run PetDismiss();\n/cry")
					EditMacro("WSxGenV",nil,nil,"#show\n/use "..b("Infernal Strike","[spec:2,@cursor]",";")..b("Vengeful Retreat","[]","").."\n/use [nomod]Panflute of Pandaria\n/use Haw'li's Hot & Spicy Chili\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem\n/use Prismatic Bauble\n/use !Glide\n/use [mod:alt]Weathered Purple Parasol\n/dismount [mounted]")

					-- Evoker, Dracthyr, Debra, Dragon
					elseif class == "EVOKER" then
					EditMacro("WSxGen1",nil,nil,"#show\n/use Hover\n/targetenemy [noexists]\n/startattack\n/use Prismatic Bauble")
					EditMacro("WSxSGen+1",nil,nil,"#show Blessing of the Bronze\n/use [mod:alt,@party3,help,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Living Flame")
					EditMacro("WSxGen2",nil,nil,"#show\n/targetlasttarget [noexists,nocombat]\n/use [help,nodead]Rainbow Generator;[@mouseover,harm,nodead][]Azure Strike\n/cleartarget [dead]\n/targetenemy [noexists]")
					EditMacro("WSxSGen+2",nil,nil,"#show Living Flame\n/use Gnomish X-Ray Specs\n/use [@mouseover,help,nodead][help,nodead][@player]Living Flame\n/startattack\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxGen3",nil,nil,"#show\n/use Disintegrate\n/cleartarget [dead]\n/targetenemy [noexists]")
					EditMacro("WSxSGen+3",nil,nil,"#show\n/use Hover\n/targetenemy [noexists]")
					EditMacro("WSxGen4",nil,nil,"#show\n/use Living Flame\n/cleartarget [dead]\n/targetenemy [noexists]")
					EditMacro("WSxSGen+4",nil,nil,"#show\n/use \n/cleartarget [dead]\n/targetenemy [noexists]")
					EditMacro("WSxCGen+4",nil,nil,"#show\n/use \n/targetenemy [noexists]\n/startattack")
					EditMacro("WSxGen5",nil,nil,"#show\n/use \n/startattack\n/targetenemy [noexists]")
					EditMacro("WSxSGen+5",nil,nil,"#show\n/use \n/targetenemy [noexists]\n/startattack")
					EditMacro("WSxGen6",nil,nil,"#show\n/use \n/targetenemy [noexists]")
					EditMacro("WSxSGen+6",nil,nil,"#show\n/use \n/stopspelltarget")
					EditMacro("WSxGen7",nil,nil,"#show\n/use \n/targetenemy [noexists]")
					EditMacro("WSxGen8",nil,nil,"#show\n/use ")
					EditMacro("WSxGen9",nil,nil,"#show\n/use ")
					EditMacro("WSxCSGen+2",nil,nil,"")
					EditMacro("WSxCSGen+3",nil,nil,"/use ")
					EditMacro("WSxCSGen+4",nil,nil,"")
					EditMacro("WSxCSGen+5",nil,nil,"/clearfocus")
					EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]"..glider..";[mod]6;[nocombat]Return;"..pwned.."\n/use [mod:ctrl]Mass Return"..brazier)
					EditMacro("WSxGenQ",nil,nil,"/use "..b("Sleep Walk","[mod:alt,@focus,harm,nodead]",";")..b("Quell","[@mouseover,harm,nodead][]",""))
					EditMacro("WSkillbomb",nil,nil,b("Dragonrage","/use ","").."\n/use [@player]13\n/use 13"..dpsRacials[race].."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
					EditMacro("WSxGenE",nil,nil,"#show\n/use Tail Swipe")
					EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..oOtas)
					EditMacro("WSxSGen+E",nil,nil,"#show\n/use Wing Buffet")
					EditMacro("WSxGenR",nil,nil,"#show\n/use Wing Buffet\n/startattack")
					EditMacro("WSxGenT",nil,nil,"#show\n/use "..b("Shattering Star","[@mouseover,harm,nodead][]",";")..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
					EditMacro("WSxSGen+T",nil,nil,"#show\n/use "..b("Shattering Star","[@mouseover,harm,nodead][]",";").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				    EditMacro("WSxCGen+T",nil,nil,"#show\n/use ")
					EditMacro("WSxGenU",nil,nil,"#show\n/use "..b("Darkness","",""))
					EditMacro("WSxGenF",nil,nil,"#show\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,exists,nodead]All-Seer's Eye;[mod:alt]Legion Communication Orb;[@focus,harm,nodead]Disrupt;[nocombat,noexists]Micro-Artillery Controller")
					EditMacro("WSxSGen+F",nil,nil,"#show\n/use [nocombat,noexists]Gastropod Shell")
					EditMacro("WSxCGen+F",nil,nil,"#show Glide\n/cancelaura Wyrmtongue Disguise")
					EditMacro("WSxCAGen+F",nil,nil,"#show\n/run if not InCombatLockdown() then if GetSpellCharges(195072)>=1 then "..tpPants.." else "..noPants.." end end")
					EditMacro("WSxGenG",nil,nil,"/use [mod:alt]Darkmoon Gazer;"..b("Unravel","[@mouseover,harm,nodead]","").."[spec:2,@mouseover,help,nodead][spec:2]Naturalize;"..b("Expunge","[@mouseover,help,nodead][]").."\n/targetenemy [noexists]\n/use Poison Extraction Totem")
				    EditMacro("WSxCGen+G",nil,nil,"#show\n/use ")
					EditMacro("WSxCSGen+G",nil,nil,"#show\n/use [@focus,help,nodead,spec:2]Naturalize;"..b("Expunge","[@focus,help,nodead]","").."\n/use Wisp Amulet\n/cancelaura Netherwalk")
					EditMacro("WSxSGen+H",nil,nil,"#show\n/use Wisp Amulet\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
					EditMacro("WSxAGen+J",nil,nil,"#show\n/use "..invisPot)
					EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;"..b("Obsidian Scales","",""))
					EditMacro("WSxGenX",nil,nil,"#show\n/use \n/use Shadescale")
					EditMacro("WSxGenC",nil,nil,"#show\n/use "..b("Sleep Walk","[@mouseover,harm,nodead][]","").."\n/cancelaura X-Ray Specs")
					EditMacro("WSxAGen+C",nil,nil,"#show\n/run PetDismiss();\n/cry")
					EditMacro("WSxGenV",nil,nil,"#show\n/use Hover\n/use [nomod]Panflute of Pandaria\n/use Haw'li's Hot & Spicy Chili\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
					EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem\n/use Prismatic Bauble\n/use !Glide\n/use [mod:alt]Weathered Purple Parasol\n/dismount [mounted]")
				end -- avslutar class
			end	-- avslutar racials[race]			
		end -- events

		-- Mount Parser based on events
		if (event == "ZONE_CHANGED_NEW_AREA" or event == "BAG_UPDATE_DELAYED" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PET_SPECIALIZATION_CHANGED" or event == "PLAYER_LOGIN" or event == "TRAIT_CONFIG_UPDATED") then
			local palaMounts = {
				["Draenei"] = "Summon Exarch's Elekk,Summon Great Exarch's Elekk,",
				["LightforgedDraenei"] = "Summon Lightforged Ruinstrider,",
				["DarkIronDwarf"] = "Summon Darkforge Ram,",
				["Dwarf"] = "Summon Dawnforge Ram,",
				["Tauren"] = "Summon Sunwalker Kodo,Summon Great Sunwalker Kodo,",
				["BloodElf"] = "Summon Thalassian Warhorse,Summon Thalassian Charger,",
				["Human"] = "Summon Warhorse,Summon Charger,",
				["ZandalariTroll"] = "Crusader's Direhorn,",
			}	
			local groundMount = {
				["SHAMAN"] = "",
				["MAGE"] = "Wild Dreamrunner,Sarge's Tale",
				["WARLOCK"] = "Felblaze Infernal,Wild Dreamrunner,Lucid Nightmare,Illidari Felstalker,Hellfire Infernal",
				["MONK"] = "Wild Dreamrunner,Swift Zulian Tiger,Lil' Donkey",
				["PALADIN"] = "Blessed Felcrusher,Prestigious Bronze Courser,Argent Charger,Pureheart Courser",
				["HUNTER"] = "Spawn of Horridon,Bruce,Llothien Prowler,Ironhoof Destroyer,Alabaster Hyena",
				["ROGUE"] = "Blue Shado-Pan Riding Tiger,Broken Highland Mustang",
				["DEATHKNIGHT"] = "Midnight,Bloodgorged Crawg,Pureheart Courser",
				["PRIEST"] = "Trained Meadowstomper, Glorious Felcrusher, Ivory Hawkstrider, Wild Dreamrunner, Pureheart Courser",
				["WARRIOR"] = "Vicious War Turtle,Infernal Direwolf,Bloodfang Widow,Ironhoof Destroyer",
				["DRUID"] = "Wild Dreamrunner,Kaldorei Nightsaber,Pureheart Courser,Raven Lord",
				["DEMONHUNTER"] = "Felsaber,Wild Dreamrunner,Lucid Nightmare,Grove Defiler,Illidari Felstalker,Llothien Prowler",
				["EVOKER"] = "",
			}
			if faction == "Alliance" then 
				groundMount = { 
					["SHAMAN"] = "",
					["MAGE"] = "Wild Dreamrunner, Sarge's Tale",
					["WARLOCK"] = "Lucid Nightmare,Illidari Felstalker,Hellfire Infernal",
					["MONK"] = "Wild Dreamrunner,Swift Zulian Tiger,Lil' Donkey",
					["PALADIN"] = "Blessed Felcrusher,Prestigious Bronze Courser,Argent Charger,Pureheart Courser",
					["HUNTER"] = "Spawn of Horridon,Bruce,Llothien Prowler,Ironhoof Destroyer,Alabaster Hyena",
					["ROGUE"] = "Blue Shado-Pan Riding Tiger,Highland Mustang",
					["WARRIOR"] = "Vicious War Turtle,Infernal Direwolf,Bloodfang Widow,Ironhoof Destroyer",
					["DRUID"] = "Wild Dreamrunner,Kaldorei Nightsaber,Pureheart Courser,Raven Lord",
					["DEMONHUNTER"] = "Felsaber,Wild Dreamrunner,Lucid Nightmare,Grove Defiler,Illidari Felstalker,Llothien Prowler",
					["EVOKER"] = "",
				}
			end

			local flyingMount = {
				["SHAMAN"] = ",Spectral Pterrorwing,Grand Wyvern,Kua'fon",
				["MAGE"] = ",Leywoven Flying Carpet,Ashes of Al'ar,Arcanist's Manasaber,Violet Spellwing,Soaring Spelltome,Glacial Tidestorm",
				["WARLOCK"] = ",Grove Defiler,Headless Horseman's Mount,Felsteel Annihilator,Antoran Gloomhound,Shackled Ur'zul",
				["MONK"] = "Astral Cloud Serpent",
				["PALADIN"] = ",Highlord's Golden Charger,Lightforged Warframe,Invincible",
				["HUNTER"] = ",Mimiron's Head,Clutch of Ji-Kun,Armored Skyscreamer,Dread Raven,Darkmoon Dirigible,Spirit of Eche'ro,Spectral Pterrorwing",
				["ROGUE"] = ",Ironbound Wraithcharger,Shadowblade's Murderous Omen,Geosynchronous World Spinner",
				["PRIEST"] = ",Dread Raven,Lightforged Warframe",
				["DEATHKNIGHT"] = ",Invincible,Sky Golem",
				["WARRIOR"] = ",Invincible,Smoldering Ember Wyrm,Valarjar Stormwing,Obsidian Worldbreaker",
				["DRUID"] = ",Sky Golem,Ashenvale Chimaera,Leyfeather Hippogryph",
				["DEMONHUNTER"] = ",Arcanist's Manasaber,Felfire Hawk,Corrupted Dreadwing,Azure Drake,Cloudwing Hippogryph,Leyfeather Hippogryph,Felsteel Annihilator",
				["EVOKER"] = "",
			}
			if faction == "Alliance" then 
				flyingMount = { 
					["SHAMAN"] = ",Spirit of Eche'ro,Grand Gryphon,Honeyback Harvester",
					["MAGE"] = ",Leywoven Flying Carpet,Ashes of Al'ar,Arcanist's Manasaber,Violet Spellwing,Soaring Spelltome,Glacial Tidestorm,Honeyback Harvester",
					["WARLOCK"] = ",Honeyback Harvester,Headless Horseman's Mount,Grove Defiler,Felsteel Annihilator,Shackled Ur'zul",
					["MONK"] = "Astral Cloud Serpent",
					["PALADIN"] = ",Highlord's Golden Charger,Lightforged Warframe,Invincible,Honeyback Harvester",
					["HUNTER"] = ",Mimiron's Head,Clutch of Ji-Kun,Armored Skyscreamer,Dread Raven,Darkmoon Dirigible,Spirit of Eche'ro,Honeyback Harvester",
					["ROGUE"] = ",Ironbound Wraithcharger,Shadowblade's Murderous Omen,Geosynchronous World Spinner",
					["PRIEST"] = ",Dread Raven,Lightforged Warframe,Honeyback Harvester",
					["DEATHKNIGHT"] = ",Invincible,Sky Golem,Honeyback Harvester,",
					["WARRIOR"] = ",Invincible,Smoldering Ember Wyrm,Valarjar Stormwing,Obsidian Worldbreaker,Honeyback Harvester",
					["DRUID"] = ",Sky Golem,Ashenvale Chimaera,Leyfeather Hippogryph,Honeyback Harvester",
					["DEMONHUNTER"] = ",Arcanist's Manasaber,Felfire Hawk,Corrupted Dreadwing,Azure Drake,Cloudwing Hippogryph,Leyfeather Hippogryph,Felsteel Annihilator,Honeyback Harvester",
					["EVOKER"] = "",
				}	
			end

			-- classMount[class]	 
			local classMount = {
				["SHAMAN"] = "Farseer's Raging Tempest",
				["MAGE"] = "Archmage's Prismatic Disc",
				["WARLOCK"] = "Netherlord's Accursed Wrathsteed",
				["MONK"] = "Hogrus, Swine of Good Fortune",
				["PALADIN"] = "Highlord's Valorous Charger",
				["HUNTER"] = "Huntmaster's Loyal Wolfhawk",
				["ROGUE"] = "Shadowblade's Baneful Omen", 
				["PRIEST"] = "High Priest's Lightsworn Seeker",
				["DEATHKNIGHT"] = "Deathlord's Vilebrood Vanquisher",
				["WARRIOR"] = "Battlelord's Bloodthirsty War Wyrm",
				["DRUID"] = "Grove Warden",
				["DEMONHUNTER"] = "Slayer's Felbroken Shrieker",
				["EVOKER"] = "",
			}

			local racistMount = {
				["BloodElf"] = "",
				["Draenei"] = "",
				["DarkIronDwarf"] = "Dark Iron Core Hound,",
				["Dwarf"] = "Stormpike Battle Ram,",
				["Gnome"] = "",
				["Goblin"] = "",
				["HighmountainTauren"] = "",
				["Human"] = "",
				["KulTiran"] = "Kul Tiran Charger,",
				["LightforgedDraenei"] = "Lightforged Felcrusher,",
				["MagharOrc"] = "Mag'har Direwolf,",
				["Mechagnome"] = "Mechagon Mechanostrider,Mechacycle Model W,",
				["Nightborne"] = "",
				["NightElf"] = "",
				["Orc"] = "Frostwolf Snarler,",
				["Pandaren"] = "",
				["Scourge"] = "Undercity Plaguebat,",
				["Tauren"] = "",
				["Troll"] = "Fossilized Raptor,Bloodfang Widow,Swift Zulian Tiger,",
				["VoidElf"] = "Starcursed Voidstrider,",
				["Vulpera"] = "Alabaster Hyena,Springfur Alpaca,Elusive Quickhoof,Caravan Hyena,",
				["Worgen"] = "Running Wild,",
				["ZandalariTroll"] = "",
				["Dracthyr"] = "Lil' Donkey",
			}

			-- Random Covenant Mount Generator
			-- Covenant Ground mounts
			local covGroundMounts = {
	        	[0] = {""},
	        	[1] = {"Eternal Phalynx of Courage","Eternal Phalynx of Purity","Phalynx of Courage","Phalynx of Humility","Ascended Skymane","Sundancer"},
	        	[2] = {"Battle Gargon Vrednic","Crypt Gargon","Gravestone Battle Gargon","Hopecrusher Gargon","Inquisition Gargon","Sinfall Gargon","Court Sinrunner"},
	        	[3] = {"Enchanted Dreamlight Runestag","Enchanted Shadeleaf Runestag","Spinemaw Gladechewer","Wildseed Cradle","Swift Gloomhoof","Shimmermist Runner","Arboreal Gulper"},
	        	[4] = {"Armored Plaguerot Tauralus","Armored War-Bred Tauralus","Lurid Bloodtusk", "Jigglesworth Sr."},
        	}
			-- Covenant Flying mounts
			local covFlyingMounts = {
	        	[0] = {""},
	        	[1] = {"Gilded Prowler","Silverwind Larion"},
	        	[2] = {"Horrid Dredwing","Rampart Screecher", "Wastewarped Deathwalker", "Restoration Deathwalker"},
	        	[3] = {"Amber Ardenmoth","Duskflutter Ardenmoth"},
	        	[4] = {"Predatory Plagueroc","Colossal Slaughterclaw","Marrowfang"},
	        }

			-- pvp mount faction converter
			local pvpSkelly = "Vicious Skeletal Warhorse," 
			local pvpRaptor = "Vicious War Raptor," 
			local pvpKodo = "Vicious War Kodo,"
			local prestWolf = "Prestigious War Wolf,"
			if faction == "Alliance" then 
				pvpSkelly = "Vicious Kaldorei Warsaber,"
				pvpRaptor = "Vicious War Ram,"
				pvpKodo = "Vicious War Mechanostrider,"
				prestWolf = "Prestigious War Steed,"
			end

			local factionBike = "Warlord's Deathwheel,"
			if faction == "Alliance" then
				factionBike = "Champion's Treadblade,"
			end

			local factionHog = "Mechano-Hog"
			if faction == "Alliance" then
				factionHog = "Mekgineer's Chopper"
			end
			-- Mount class spec parser
			if class == "SHAMAN" then
				if playerspec == 3 then
					groundMount[class] = "Snapback Scuttler"
				end
			elseif class == "WARLOCK" then
				if playerspec == 2 then 
					classMount[class] = "Netherlord's Accursed Wrathsteed,Netherlord's Chaotic Wrathsteed"
				elseif playerspec == 3 then
					classMount[class] = "Netherlord's Brimstone Wrathsteed,Netherlord's Chaotic Wrathsteed"
				end
			elseif class == "MONK" then
				if (playerspec == 1 and faction == "Alliance") then
					flyingMount[class] = "Honeyback Harvester"
				elseif playerspec == 1 then 
					flyingMount[class] = "Lucky Yun"
				elseif playerspec == 2 then
					flyingMount[class] = "Yu'lei, Daughter of Jade" 
					classMount[class] = "Shu-Zen, the Divine Sentinel"
				elseif playerspec == 3 then
					flyingMount[class] = "Wen Lo, the River's Edge"
					classMount[class] = "Ban-Lu, Grandmaster's Companion"
				end
				classMount[class] = "/use [mounted]"..classMount[class]
				flyingMount[class] = "/use "..flyingMount[class]
				
			elseif class == "PALADIN" then
				if playerspec == 2 then 
					classMount[class] = "Highlord's Vigilant Charger" 
					groundMount[class] = "Avenging Felcrusher"   
				elseif playerspec == 3 then
					classMount[class] = "Highlord's Vengeful Charger"
				end
			elseif class == "HUNTER" then				
				if playerspec == 2 then 
					classMount[class] = "Huntmaster's Dire Wolfhawk" 
					groundMount[class] = "Spawn of Horridon,Spirit of Eche'ro,Brawler's Burly Basilisk,Llothien Prowler,Ironhoof Destroyer"
					flyingMount[class] = ",Mimiron's Head,Armored Skyscreamer,Dread Raven,Darkmoon Dirigible"
				elseif playerspec == 3 then
					classMount[class] = "Huntmaster's Fierce Wolfhawk" 
					groundMount[class] = "Highmountain Thunderhoof,Brawler's Burly Basilisk,Great Northern Elderhorn,Highmountain Elderhorn,Alabaster Hyena"
					flyingMount[class] = ",Clutch of Ji-Kun,Dread Raven,Spirit of Eche'ro"
				end
			elseif class == "ROGUE" then
				if playerspec == 2 then 
					classMount[class] = "Shadowblade's Crimson Omen"
					groundMount[class] = "Siltwing Albatross,Ratstallion"
					flyingMount[class] = ",Shadowblade's Murderous Omen,Infinite Timereaver,Siltwing Albatross,The Dreadwake"
				elseif playerspec == 3 then
					classMount[class] = "Shadowblade's Lethal Omen"	
					groundMount[class] = "Infinite Timereaver"
					flyingMount[class] = ",Ironbound Wraithcharger,Shadowblade's Murderous Omen"
				end			
			elseif class == "PRIEST" then		
				if playerspec == 3 then
					flyingMount[class] = ",Dread Raven,Riddler's Mind-Worm,The Hivemind,Uncorrupted Voidwing"	
					groundMount[class] = "Lucid Nightmare,Ivory Hawkstrider,Ultramarine Qiraji Battle Tank,The Hivemind,Voidtalon of the Dark Star"
				elseif playerspec == 2 then
					groundMount[class] = "Bone-White Primal Raptor,Ivory Hawkstrider,Wild Dreamrunner,Pureheart Courser"
				end
			elseif class == "DEATHKNIGHT" then
				if playerspec == 2 then
					groundMount[class] = "Frostshard Infernal,Pureheart Courser,Glacial Tidestorm"
				elseif playerspec == 3 then
					groundMount[class] = "Winged Steed of the Ebon Blade,Pureheart Courser"
				end
			elseif class == "WARRIOR" then	
				if playerspec == 2 then
					groundMount[class] = "Arcadian War Turtle,Bloodfang Widow,Ironhoof Destroyer"
				elseif playerspec == 3 then
					groundMount[class] = "Prestigious Bronze Courser,Bloodfang Widow,Ironhoof Destroyer"
				end
			elseif class == "DRUID" then
				if playerspec == 2 then 
					classMount[class] = "Swift Zulian Tiger"
				elseif playerspec == 3 then
					classMount[class] = "Darkmoon Dancing Bear"
				elseif playerspec == 4 then
					classMount[class] = "Emerald Drake"
				end
			elseif class == "DEMONHUNTER" then
				if playerspec == 1 then 
					-- classMount[class] = "Swift Zulian Tiger"
				elseif playerspec == 2 then
					-- classMount[class] = "Darkmoon Dancing Bear"
				end
			elseif class == "EVOKER" then
				if playerspec == 1 then 
					-- classMount[class] = "Swift Zulian Tiger"
				elseif playerspec == 2 then
					-- classMount[class] = "Darkmoon Dancing Bear"
				end

				if (UnitName("player") == "Fannylands" and playerspec == 3) then
					classMount[class] = "Grove Defiler"
					flyingMount[class] = ",Grove Defiler"
					pvpRaptor = ""
					groundMount[class] = "Grove Defiler"
				end
			end

        	covGroundMounts = covGroundMounts[slBP]
        	covGroundMounts = covGroundMounts[random(#covGroundMounts)]
        	if slBP == 2 then
        		covGroundMounts = covGroundMounts..",Sinrunner Blanchy,Wastewarped Deathwalker"
        	end        	
        	covFlyingMounts = covFlyingMounts[slBP]
        	covFlyingMounts = covFlyingMounts[random(#covFlyingMounts)]

			if class ~= "MONK" then
				groundMount[class] = groundMount[class]..","..covGroundMounts
				flyingMount[class] = flyingMount[class]..","..covFlyingMounts
			end
			
			local mountSlash = "/userandom"

			-- Vazj'ir
			if (z == "Vashj'ir" or z == "Kelp'thar Forest" or z == "Shimmering Expanse" or z == "Abyssal Depths") then
				if class == "DRUID" then
					flyingMount[class] = "!Travel Form"
				else
					flyingMount[class] = "Vashj'ir Seahorse"
				end
				mountSlash = "/use "
				classMount[class] = ""
				groundMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
			elseif (IsInJailersTower() == true and event == "BAG_UPDATE_DELAYED") then
			-- Torghast preloader
				local powerInBags = ""
				local torghastMountPower = {
		    		"Maw Seeker Harness",
					"Deadsoul Hound Harness",
					"Mawrat Harness",
					"Spectral Bridle",
				}
				for i, torghastMountPower in pairs(torghastMountPower) do
				    if GetItemCount(torghastMountPower) >= 1 then
				        powerInBags = torghastMountPower
				    end
				end
				mountSlash = "/use "
				classMount[class] = ""
				flyingMount[class] = ""
				groundMount[class] = powerInBags
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
				-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Torghast = "..z.."",0.5,1.0,0.0)
			elseif z == "Torghast, Tower of the Damned" then
				mountSlash = ""
				classMount[class] = ""
				flyingMount[class] = ""
				groundMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Inside the Tower = "..z.."",0.5,1.0,0.0)
			elseif GetItemCount("Magic Broom") >= 1 then
				classMount[class] = "Magic Broom"
				flyingMount[class] = "Magic Broom"
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Magic Broom = "..z.."",0.5,1.0,0.0)
			elseif z == "The Maw" then
				mountSlash = "/use "
				classMount[class] = ""
				flyingMount[class] = ""
				groundMount[class] = "Colossal Ebonclaw Mawrat"
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: The Maw = "..z.."",0.5,1.0,0.0)
			-- Nazjatar
			elseif (z == "Nazjatar" or z == "Damprock Cavern") then
				local randomSeapony = {"Inkscale Deepseeker","Fabious","Subdued Seahorse","Crimson Tidestallion"}
				randomSeapony = ","..randomSeapony[random(#randomSeapony)]
				flyingMount[class] = randomSeapony
				groundMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Random Seapony = "..z.."",0.5,1.0,0.0)
			elseif instanceName == "The Deaths of Chromie" then
				-- We can use flying mounts
				groundMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
				--print("The Deaths of Chromie")
			elseif (instanceType ~= "none" and not garrisonId[mapID]) or groundAreas[z] or groundAreas[instanceName] then
				-- We can't fly inside instances, except Draenor Garrisons and The Deaths of Chromie
				-- Flying is also disabled in certain outdoor areas/zones
				classMount[class] = ""
				flyingMount[class] = ""
				-- groundMount[class] = ""
				-- pvpSkelly = "" 
				-- pvpRaptor = "" 
				-- pvpKodo = ""
				-- prestWolf = ""
				-- factionBike = ""
				-- racistMount[race] = ""
				-- palaMounts[race] = ""
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: No flying zones = "..z.."",0.5,1.0,0.0)
			--print("Cannot fly in certain areas")
			elseif (IsSpellKnown(34090) or IsSpellKnown(34091) or IsSpellKnown(90265)) then 
				-- Expert, Artisan or Master Riding
				groundMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Expert, Artisan or Master Riding = "..z.."",0.5,1.0,0.0)
			--print("Artisan or Master Riding")
			elseif IsSpellKnown(33388) or IsSpellKnown(33391) then 
				-- Apprentice or Journeyman Riding
				-- We can use ground mounts
				flyingMount[class] = ""
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Apprentice or Journeyman Riding = "..z.."",0.5,1.0,0.0)
			--print("Journeyman or Apprentice")
			elseif level < 10 then
				groundMount[class] = "Summon Chauffeur"
				classMount[class] = ""
				flyingMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Summon Chauffeur "..z.."",0.5,1.0,0.0)
			elseif level <= 20 then
				groundMount[class] = "Snapback Scuttler"
				classMount[class] = ""
				flyingMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
				-- Mount Type Zone Parser
				-- Check if the character has riding skill
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Snapback Scuttler "..z.."",0.5,1.0,0.0)
			else 
				classMount[class] = ""
				flyingMount[class] = ""
				pvpSkelly = "" 
				pvpRaptor = "" 
				pvpKodo = ""
				prestWolf = ""
				factionBike = ""
				racistMount[race] = ""
				palaMounts[race] = ""
				mountSlash = ""
			-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: MountZoneParser: Cannot mount = "..z.."",0.5,1.0,0.0)
			--print("We dont any Riding skill")
			end

			--[[Mount synthesis: 
			flying mounts: classMount[class], flyingMount[class], 
			ground mounts: "..pvpKodo..""..pvpRaptor..""..prestWolf..""..factionBike..",racistMount[race],groundMount[class] --]] 
			if (class == "MAGE" or class == "PRIEST" or class == "DEMONHUNTER" or class == "DEATHKNIGHT") then
				EditMacro("WSxSGen+V",nil,nil,mountSlash.." "..classMount[class]..""..flyingMount[class]..""..racistMount[race]..""..groundMount[class]) 
			elseif class == "SHAMAN" then
				EditMacro("WSxSGen+V",nil,nil,"/use [noform]Ghost Wolf\n/use [@player,nochanneling]Water Walking\n"..mountSlash.." "..classMount[class]..""..flyingMount[class]..""..pvpKodo..""..pvpRaptor..""..prestWolf..""..factionBike..""..racistMount[race]..""..groundMount[class].."\n/use Death's Door Charm")
			elseif class == "WARLOCK" then
				EditMacro("WSxSGen+V",nil,nil,mountSlash.." "..classMount[class]..""..flyingMount[class]..""..pvpSkelly..""..factionBike..""..racistMount[race]..""..groundMount[class].."\n/use Tithe Collector's Vessel")
			elseif class == "MONK" then
				if groundMount[class]  ~= "" then
					groundMount[class] = "/userandom "..groundMount[class]
				end
				EditMacro("WSxSGen+V",nil,nil,classMount[class].."\n"..flyingMount[class]..""..racistMount[race]..""..groundMount[class])
			elseif class == "PALADIN" then
				mountSlash = "/userandom [nomounted]"
				EditMacro("WSxSGen+V",nil,nil,"/use [combat]!Devotion Aura;[nomounted]!Crusader Aura\n"..mountSlash..""..classMount[class]..""..flyingMount[class]..""..palaMounts[race]..""..racistMount[race]..""..groundMount[class])
			elseif class == "HUNTER" then
				EditMacro("WSxSGen+V",nil,nil,mountSlash.." "..classMount[class]..""..flyingMount[class]..""..pvpKodo..""..pvpRaptor..""..racistMount[race]..""..groundMount[class])
			elseif class == "ROGUE" then
				EditMacro("WSxSGen+V",nil,nil,mountSlash.." "..classMount[class]..""..flyingMount[class]..""..racistMount[race]..""..groundMount[class].."\n/targetfriend [nospec:2,nohelp,combat]")
			elseif class == "WARRIOR" then
				EditMacro("WSxSGen+V",nil,nil,mountSlash.." "..classMount[class]..""..flyingMount[class]..""..factionBike..""..prestWolf..""..racistMount[race]..""..groundMount[class].."\n/use Death's Door Charm")
			elseif class == "DRUID" then
				EditMacro("WSxSGen+V",nil,nil,"/cancelform [form:1/2/3]\n"..mountSlash.." "..classMount[class]..""..flyingMount[class]..""..pvpRaptor..""..racistMount[race]..""..groundMount[class])
			end
--[[			print("mountSlash = "..noMount)--]]
		end -- class
	
		-- Hunter Misc pet parser
		if class == "HUNTER" and (event == "PET_STABLE_CLOSED" or event == "PLAYER_LOGIN") then
			local petAbilityMacro, petExoticMacro = "/use "..ptdSG.."[nopet]Call Pet 4;", "/use [mod:alt]Eyes of the Beast;[nopet]Call Pet 5;"
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
				["Toad"] = "Swarm of Flies",
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
				["Worm"] = "Burrow Attack",
			}
			-- Hunter Pets
			for i = 1, 5 do
				local _, _, _, family = GetStablePetInfo(i)

				if family and petAbilities[family] then
					petAbilityMacro = petAbilityMacro .. "[pet:" .. family .. "]" .. petAbilities[family] .. ";"
				end

				if family and petExoticAbilities[family] then
					if family == "Spirit Beast" then
						petExoticMacro = petExoticMacro .. "[pet:Spirit Beast,nocombat]Spirit Walk;[pet:Spirit Beast]Spirit Shock;"
					else
						petExoticMacro = petExoticMacro .. "[pet:" .. family .. "]" .. petExoticAbilities[family] .. ";"
					end
				end
			end
			petAbilityMacro = petAbilityMacro .. "\n/use Hunter's Call\n/use [nocombat,noexists,resting]Flaming Hoop" 
			-- Call Pet 4, Shift+G
			petExoticMacro = petExoticMacro .. "\n/use Whole-Body Shrinka'" 
			-- Ctrl+Shift+G --> "GG", "G"
			EditMacro("WSxSGen+H", nil, nil, petAbilityMacro, 1, 1)
			EditMacro("WSxGenG", nil, nil, petExoticMacro, 1, 1)
			DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Updating Active Pets! :D",0.5,1.0,0.0)
				--[[print(family)
				print(petAbilityMacro)
				print(petExoticAbilities)
				print(petAbilities[family])--]]			
		end -- eventHandler
	end -- Combat Lock
end -- Function
frame:SetScript("OnEvent", eventHandler)


-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen8\",nil,nil,\"\\#show Tremor Totem\\n/use [mod:shift,@\"..B..\"]Healing Surge;[@\"..B..\"]Earth Shield\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
					-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen9\",nil,nil,\"\\#show Reincarnation\\n/use [mod:shift,@\"..N..\"]Healing Surge;[@\"..N..\"]Earth Shield\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
						-- EditMacro("WSxGen1",nil,nil,"/use [spec:1,talent:1/3,harm,nodead]Static Discharge;[@mouseover,harm,nodead,talent:6/3][harm,talent:6/3]Frost Shock;[@mouseover,harm,nodead][harm,nodead]Flame Shock;Xan'tish's Flute\n/targetenemy [noexists]\n/cleartarget [dead]")
						-- EditMacro("WSxSGen+4",nil,nil,"/use [noexists,nocombat]Sen'jin Spirit Drum;\n/startattack")
						-- EditMacro("WSxGen5",nil,nil,"/targetenemy [noexists,nomod]\n/target [@Greater Earth Ele,mod,notalent:6/2]\n/use [@pet,exists,nodead,mod,talent:6/2][help,mod,nodead]Healing Surge;[mod]Earth Elemental;[harm,nodead]Earth Shock\n/use Words of Akunda\n/targetlasttarget [mod,notalent:6/2]")
						-- EditMacro("WSxSGen+5",nil,nil,"/use [pet:Storm Elemental]Tempest;[pet:Fire Elemental,@mouseover,harm,nodead][pet:Fire Elemental]Meteor;"..b("Liquid Magma Totem", "[mod,@player][@cursor]",";").."\n/use [nocombat]Lava Fountain\n/targetenemy [noexists]")
						-- EditMacro("WSxSGen+T",nil,nil,"#show [talent:6/1]Earth Shock;[talent:6/2]Fire Elemental;[talent:6/3]Icefury")
						-- EditMacro("WSxGen4",nil,nil,"/use [talent:2/2]Echoing Shock;"..b("Lava Burst","[@mouseover,harm,nodead][]",";").."Earth Shock\n/targetenemy [noexists]\n/cleartarget [dead]\n/use Smolderheart")
						-- EditMacro("WSxGen1",nil,nil,"#show\n/use [noexists]Xan'tish's Flute\n/use [@mouseover,harm,nodead][harm,nodead]Flame Shock\n/targetenemy [noexists]\n/cleartarget [dead]")
						-- EditMacro("WSxSGen+4",nil,nil,"#show\n/use "..b("Riptide","[@party1,help,nodead,mod:alt]",";").."[nocombat,noexists]Sen'jin Spirit Drum;[talent:6/2,@cursor]Downpour;Healing Stream Totem")
						-- EditMacro("WSxGen5",nil,nil,"#show\n/use [mod,@cursor]Spirit Link Totem;\n/targetenemy [noexists]\n/use Words of Akunda")
						-- EditMacro("WSxSGen+5",nil,nil,"#show\n/use [talent:4/2,@cursor]Earthen Wall Totem;[talent:4/3,@cursor]Ancestral Protection Totem\n/use Lava Fountain")
						-- EditMacro("WSxSGen+T",nil,nil,"#show [talent:6/1]Mana Tide Totem;[talent:6/2]Downpour;[talent:6/2]Cloudburst Totem\n/use Spirit Link Totem")
						-- EditMacro("WSxGen4",nil,nil,"/use \n/targetfriendplayer [noexists]\n/cleartarget [dead]")

						-- if playerspec == 1 then
						-- EditMacro("WSxSGen+1",nil,nil,"#show\n/use [mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Vivify;Honorary Brewmaster Keg")
						-- EditMacro("WSxSGen+2",nil,nil,"/use [@party3,help,nodead,mod:alt][@mouseover,help,nodead][]Vivify\n/use [nochanneling]Gnomish X-Ray Specs")
						-- EditMacro("WSxSGen+3",nil,nil,"#show\n/use [mod,@party4,nodead,notalent:6/3]Vivify;Tiger Palm")
					-- elseif playerspec == 2 then
						-- EditMacro("WSxGenR",nil,nil,"/use "..b("Ring of Peace","[mod:shift,@cursor]",";")..b("Tiger's Lust","[mod:ctrl,@player][@mouseover,help,nodead][help,nodead]",";")..b("Disable","[]",";").."[@mouseover,harm,nodead][]Crackling Jade Lightning")
					-- else	
						-- EditMacro("WSxGenR",nil,nil,"/use [mod:shift,talent:4/3,@cursor]Ring of Peace;[mod,@player,talent:2/3][@mouseover,help,talent:2/3][help,talent:2/3]Tiger's Lust;Disable")
						-- EditMacro("WSxSGen+1",nil,nil,"#show\n/use [mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Vivify;Honorary Brewmaster Keg")
						-- EditMacro("WSxSGen+2",nil,nil,"/use [@party3,help,nodead,mod:alt][@mouseover,help,nodead][]Vivify\n/use [nochanneling]Gnomish X-Ray Specs")
						-- EditMacro("WSxSGen+3",nil,nil,"/use [mod,@party4,nodead]Vivify;[talent:6/2]Rushing Jade Wind;Tiger Palm")

						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen8\",nil,nil,\"\\#show Provoke\\n/use [mod:shift,@\"..B..\"]Vivify;[@\"..B..\"]Renewing Mist\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")	
					-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen9\",nil,nil,\"\\#show Provoke\\n/use [mod:shift,@\"..N..\"]Vivify;[@\"..N..\"]Renewing Mist\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")

					-- if playerspec == 1 then
						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen8\",nil,nil,\"\\#show Lay on Hands\\n/use [mod:shift,@\"..B..\"]Flash of Light;[@\"..B..\"]Holy Shock\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen9\",nil,nil,\"\\#show Lay on Hands\\n/use [mod:shift,@\"..N..\"]Flash of Light;[@\"..N..\"]Holy Shock\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
						
					-- elseif playerspec == 2 then
						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen8\",nil,nil,\"\\#show Lay on Hands\\n/use [mod:shift,@\"..B..\"]Lay on Hands;[@\"..B..\"]Light of the Protector\", nil)print(\"Vigil set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen9\",nil,nil,\"\\#show Lay on Hands\\n/use [mod:shift,@\"..N..\"]Lay on Hands;[@\"..N..\"]Light of the Protector\", nil)print(\"Vigil#2 set to : \"..N)else print(\"Combat!\")end")
						-- EditMacro("WSxSGen+4",nil,nil,"/use [talent:2/3];Judgment\n/targetenemy [noexists]")
						
					-- else
						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen8\",nil,nil,\"\\#show Lay on Hands\\n/use [mod:shift,@\"..B..\"]Lay on Hands;[@\"..B..\"]Flash of Light\", nil)print(\"Vigil set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen9\",nil,nil,\"\\#show Lay on Hands\\n/use [mod:shift,@\"..N..\"]Lay on Hands;[@\"..N..\"]Flash of Light\", nil)print(\"Vigil#2 set to : \"..N)else print(\"Combat!\")end")
						-- EditMacro("WSxSGen+4",nil,nil,"/use Wake of Ashes\n/targetenemy [noexists]")
					-- end	

					-- EditMacro("WSxT100",nil,nil,"#show [spec:1,talent:7/3]Crimson Tempest;[spec:2,talent:7/2]Blade Rush;[spec:2,talent:7/3]Killing Spree;[spec:3,talent:7/2]Secret Technique;[spec:3,talent:7/3]Shuriken Tornado;[nospec:2]Eviscerate;Run Through")
					-- if playerspec == 1 then
					-- elseif playerspec == 2 then
					-- 	-- EditMacro("WSxGenR",nil,nil,"#show\n/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]Pistol Shot;Horse Head Costume\n/targetenemy [noexists]")
					-- 	EditMacro("WSxGenT",nil,nil,"#show\n/use [nocombat,nostance:1/2/3]Stealth;[stealth,@cursor,nocombat]Distract;[mod,@focus,nodead][]Gouge\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
					-- else
					-- 	-- EditMacro("WSxGenR",nil,nil,"#show\n/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead,d]Shuriken Toss;[@mouseover,help,nodead][help,nodead]Shadowstep;Horse Head Costume")
					-- 	EditMacro("WSxGenT",nil,nil,"#show\n/use [nocombat,nostance:1/2/3]Stealth;[stealth,@cursor,nocombat]Distract;[@mouseover,harm,nodead][]Shuriken Toss"..nPepe.."\n/use [help,nocombat]Swapblaster\n/targetenemy [noexists]\n/cleartarget [dead]")
					-- end		

						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen8\",nil,nil,\"/use [mod:shift,@\"..B..\"]Shadow Mend;[@\"..B..\"]Power Word: Shield\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen9\",nil,nil,\"/use [mod:shift,@\"..N..\"]Shadow Mend;[@\"..N..\"]Power Word: Shield\", nil)print(\"Tank#2 set to: \" ..N)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+B",nil,nil,"")
						-- EditMacro("WSxCAGen+N",nil,nil,"")
						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen8\",nil,nil,\"/use [mod:shift,@\"..B..\"]Flash Heal;[spec:2,@\"..B..\"]Prayer of Mending;[@\"..B..\"]Power Word: Shield\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen9\",nil,nil,\"/use [mod:shift,@\"..N..\"]Flash Heal;[spec:2,@\"..N..\"]Prayer of Mending;[@\"..N..\"]Power Word: Shield\", nil)print(\"Tank#2 set to: \" ..N)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+B",nil,nil,"")
						-- EditMacro("WSxCAGen+N",nil,nil,"")


						-- EditMacro("WSxCGen+4",nil,nil,"#show\n/use [mod,@party3,help,nodead]Power Word: Shield;
							-- [talent:7/2]Apotheosis;[talent:7/3]Holy Word: Salvation;Power Infusion\n/targetenemy [noexists]\n/cleartarget [dead]")
						-- EditMacro("WSxCGen+4",nil,nil,"#show\n/use [mod,@party3,help,nodead]Power Word: Shield;[@mouseover,harm,nodead,talent:7/3][talent:7/3]Surrender to Madness\n/targetenemy [noexists]\n/cleartarget [dead]")
						
						-- EditMacro("WSxSGen+4",nil,nil,"#show Symbol of Hope\n/use [talent:6/2]Divine Star;[talent:6/3]Halo;\n/use [nocombat,noexists]Leather Love Seat\n/stopspelltarget")
						-- EditMacro("WSxSGen+4",nil,nil,"/stopspelltarget\n/targetenemy [noharm]\n/cleartarget [dead]\n/use [noform]Shadowform;\n/use [@mouseover,harm,nodead][nomod]Vampiric Touch\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Vampiric Touch\n/targetlasttarget")

							-- if playerspec == 1 then
						-- EditMacro("WSxGen7",nil,nil,"/use [mod]Shield Block;[equipped:Shields,nospec:3]Shield Slam;[spec:2,talent:6/2]Dragon Roar;[spec:2,talent:6/3]Bladestorm;[spec:1]Sweeping Strikes;Whirlwind\n/startattack\n/equipset [noequipped:shields]Menkify!") 

							-- EditMacro("WSxT100",nil,nil,"#show [spec:1]Bladestorm;[spec:2,talent:7/3]Siegebreaker;Execute")
					-- EditMacro("WSxCAGen+F",nil,nil,"#show Rallying Cry\n/use [nocombat]Throbbing Blood Orb\n/stopmacro [combat,exists]\n/equipset "..EQS[playerspec].."\n/run local _,d,_=GetItemCooldown(39769) if d==0 then EquipItemByName(39769) end\n/use 16")
					-- EditMacro("WSxCAGen+F",nil,nil,"#show Rallying Cry\n/use [nocombat]Throbbing Blood Orb\n/stopmacro [combat,exists]\n/run local _,d=GetItemCooldown(39769) if d~=0 then C_EquipmentSet.UseEquipmentSet(C_EquipmentSet.GetEquipmentSetID("..EQS[playerspec]..")) else EquipItemByName(39769) end\n/use 16")
					-- EditMacro("WSxCAGen+B",nil,nil,"")
					-- EditMacro("WSxCAGen+N",nil,nil,"")


					-- EditMacro("WSkillbomb",nil,nil,"#show\n/use Berserk"..dpsRacials[race].."\n/use Will of Northrend\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
						-- EditMacro("WSkillbomb",nil,nil,"#show\n/use Berserk"..dpsRacials[race].."\n/use Will of Northrend\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
						-- EditMacro("WSkillbomb",nil,nil,"#show\n/use [talent:5/3]!Incarnation: Tree of Life"..dpsRacials[race].."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")

							-- EditMacro("WSxGen3",nil,nil,"#show\n/use [form:2]Rip;[talent:3/1,noform][talent:3/1,form:4]Starsurge;[talent:3/2,form:1];[@mouseover,help,nodead][]Regrowth\n/targetenemy [noexists]\n/use Desert Flute")
						-- EditMacro("WSxGen3",nil,nil,"/use [talent:7/3,form:1]Pulverize;[talent:7/2]Lunar Beam;[form:2,talent:3/2]Rake;[talent:3/1,noform]Moonkin Form;[talent:3/1,form:4]Starsurge;[form:1]Frenzied Regeneration;[@mouseover,help,nodead][]Regrowth\n/targetenemy [noexists]\n/use Desert Flute")
						-- EditMacro("WSxGen3",nil,nil,"#show\n/use [talent:3/1,noform:4]Moonkin Form;[talent:3/1,form:4]Starsurge;[form:2,talent:3/2]Rip;[@mouseover,help,nodead,talent:6/3][talent:6/3]Overgrowth;[@mouseover,help,nodead][]Regrowth\n/targetenemy [noexists]\n/use Desert Flute")

						-- EditMacro("WSxSGen+3",nil,nil,"/use [noform:2]!Cat Form;[form:2]Thrash\n/use [nocombat]!Prowl;")

						-- EditMacro("WSxSGen+3",nil,nil,"/use [talent:3/2,noform:2]!Cat Form;[talent:3/2,form:2]Rip;[noform:1]Bear Form(Shapeshift);Thrash\n/use [nocombat,talent:3/2]!Prowl;")

						-- EditMacro("WSxSGen+3",nil,nil,"/use 



						-- EditMacro("WSxGen4",nil,nil,"/use [talent:3/2,noform:1/2]Bear Form;[form:1]Thrash;[form:2]Rake;[talent:3/1,noform:4]Moonkin Form;[talent:3/1,form:4]Starfire\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,nostealth,noform:1]!Prowl")
						-- EditMacro("WSxGen4",nil,nil,"/use [noform]Bear Form(Shapeshift);[form:1/2]Thrash;[talent:3/1,noform:4]Moonkin Form;[talent:3/1,form:4]Starfire\n/targetenemy [noexists]\n/cleartarget [dead]")
						-- EditMacro("WSxGen4",nil,nil,"/use [form:2]Shred;[form:1]Mangle;[@mouseover,talent:3/1,form:4,harm,nodead][talent:3/1,form:4]Starfire;[@mouseover,help,nodead][]Regrowth\n/targetenemy [noexists]\n/cleartarget [dead]")



						-- EditMacro("WSxSGen+4",nil,nil,"/use [@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Rejuvenation;[noform:2]Cat Form;Tiger's Fury\n/use [nocombat,nostealth]Bloodmane Charm\n/use !Prowl\n/targetenemy [noexists]")
						-- EditMacro("WSxSGen+4",nil,nil,"/use [@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Rejuvenation;[noform:1]Bear Form(Shapeshift);[talent:1/3]Bristling Fur;Ironfur\n/use [nocombat,nostealth]Bloodmane Charm\n/targetenemy [noexists]")
						-- EditMacro("WSxSGen+4",nil,nil,"/use [@focus,help,nodead,mod][@party1,help,nodead,mod]Rejuvenation;[noform:2]!Cat Form;[talent:3/2,form:2]Rake;[form:2]Shred\n/use [nocombat]!Prowl\n/targetenemy [noexists]")


						-- EditMacro("WSxGen5",nil,nil,"#show\n/use [mod:ctrl]Treant Form;[talent:3/1,form:4]Wrath;[form:1]Maul;[noform]!Cat Form;[form:1]Thrash;[form:2]Ferocious Bite\n/targetenemy [noexists]\n/cleartarget [dead]")
						-- EditMacro("WSxGen5",nil,nil,"#show\n/use [mod:ctrl]Treant Form;[noform]Bear Form(Shapeshift);[form:1]Maul;[form:2]Ferocious Bite;[talent:3/1,form]Wrath\n/targetenemy [noexists]\n/cleartarget [dead]")
						-- EditMacro("WSxGen5",nil,nil,"#show\n/use [mod,talent:5/3];[mod]Treant Form;[form:2]Ferocious Bite;[form:1]Ironfur;[@mouseover,help,nodead,talent:1/2][talent:1/2,noharm]Nourish;Wrath\n/targetenemy [noexists]\n/cleartarget [dead]")

						-- EditMacro("WSxSGen+5",nil,nil,"/use [@party2,help,nodead,mod]Rejuvenation;[nocombat,help,nodead]Corbyn's Beacon;[talent:7/3]Feral Frenzy;Stampeding Roar")

						-- EditMacro("WSxSGen+5",nil,nil,"/use [@party2,help,nodead,mod]Rejuvenation;[nocombat,help,nodead]Corbyn's Beacon;[talent:4/1]Mighty Bash;[talent:4/2]Mass Entanglement;[talent:4/3]Heart of the Wild;Ursine Adept")
						-- EditMacro("WSxSGen+5",nil,nil,"/use [@party2,help,nodead,mod]Rejuvenation;[nocombat,help,nodead]Corbyn's Beacon;[@mouseover,help,nodead,talent:1/2][talent:1/2]Nourish;[@mouseover,help,nodead,talent:1/3][talent:1/3]Cenarion Ward")


	-- EditMacro("WSxGen6",nil,nil,"/use [noform:1/2]Cat form;[talent:6/2,form:1]Thrash;[form:1/2]Swipe\n/use ")
						-- EditMacro("WSxGen6",nil,nil,"/use [mod,talent:5/3]Berserk;[noform:1/2]Bear form(Shapeshift);[form:1/2]Swipe\n/use Hunter's Call")
						-- EditMacro("WSxGen6",nil,nil,"/use ;[talent:3/3,noform:1]Bear Form(Shapeshift);[talent:3/2,noform:2]!Cat Form;[form:1,talent:3/3]Thrash;[form:2,talent:3/2]Swipe;")



						-- EditMacro("WSxGenX",nil,nil,"/use [mod:alt]Mount Form;[noform:2,mod:shift]!Cat Form;[mod:shift]Dash;[mod,harm,nodead]Hibernate;[mod]"..dOH..";[form:1]Ironfur;[@mouseover,help,talent:3/3][talent:3/3]Swiftmend\n/stopmacro [stealth]\n/use Path of Elothir\n/use Prismatic Bauble")
						-- EditMacro("WSxGenX",nil,nil,"/use [mod:alt]Mount Form;[noform:2,mod:shift]!Cat Form;[mod:shift]Dash;[mod,harm,nodead]Hibernate;[mod]"..dOH..";[form:1]Ironfur;[@mouseover,help,nodead][]Swiftmend\n/stopmacro [stealth]\n/use Path of Elothir\n/use Prismatic Bauble")	
						-- EditMacro("WSxGenX",nil,nil,"/use [mod:alt]Mount Form;[noform:2,mod:shift]!Cat Form;[mod:shift]Dash;[mod,harm,nodead]Hibernate;[mod]"..dOH..";[form:1]Ironfur;[@mouseover,help,talent:3/3][talent:3/3]Swiftmend\n/stopmacro [stealth]\n/use Path of Elothir\n/use Prismatic Bauble")


						-- EditMacro("WSxGenC",nil,nil,"/use "..b("Innervate","[mod:shift,"..healer.."]",";").."[@mouseover,harm,nodead,mod][mod]Entangling Roots;[noform:1]Bear Form;[talent:3/2,form:1]Frenzied Regeneration;[@mouseover,help,nodead,talent:3/3][noform:1,talent:3/3]Rejuvenation\n/use Totem of Spirits\n/cancelform [mod:shift,form:1,talent:3/3]")


						-- EditMacro("WSxGenC",nil,nil,"/use [@mouseover,harm,nodead,mod][mod]Entangling Roots;[form:1]Frenzied Regeneration;[@mouseover,help,nodead,talent:3/3][noform:1,talent:3/3]Rejuvenation;[noform]Bear Form(Shapeshift);\n/use Totem of Spirits")
						-- EditMacro("WSxGenC",nil,nil,"/use [mod:shift,noform:1/2]Innervate;[@mouseover,harm,nodead,mod][mod]Entangling Roots;[form:1,talent:3/3]Frenzied Regeneration;[@mouseover,help,nodead][]Rejuvenation\n/use Totem of Spirits\n/cancelform [mod:shift,form:1,talent:3/3]")
-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen8\",nil,nil,\"/use [mod:shift,@\"..B..\"]Regrowth;[@\"..B..\"]Regrowth\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen9\",nil,nil,\"/use [mod:shift,@\"..N..\"]Regrowth;[@\"..N..\"]Regrowth\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen8\",nil,nil,\"/use [mod,@\"..B..\"]Innervate;[@\"..B..\"]Regrowth\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen9\",nil,nil,\"/use [mod,@\"..N..\"]Innervate;[@\"..N..\"]Regrowth\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen8\",nil,nil,\"/use [mod:shift,@\"..B..\"]Regrowth;[@\"..B..\"]Regrowth\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen9\",nil,nil,\"/use [mod:shift,@\"..N..\"]Regrowth;[@\"..N..\"]Regrowth\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")
						-- ta bort cenarion ward @party12
						-- EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxGen8\",nil,nil,\"/use [mod:shift,@\"..B..\"]Regrowth;[@\"..B..\"]Lifebloom\\n/stopspelltarget\", nil)print(\"Tank set to : \"..B)else print(\"Combat!\")end")
						-- EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxGen9\",nil,nil,\"/use [mod:shift,@\"..N..\"]Regrowth;[@\"..N..\"]Lifebloom\\n/stopspelltarget\", nil)print(\"Tank#2 set to : \"..N)else print(\"Combat!\")end")

						-- EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[noform:4]Moonkin Form;!Flap\n/cancelform [form:1/2]\n/cancelaura Prowl\n/use [mod:alt]Weathered Purple Parasol\n/use [nomod,nostealth,form]Seafarer's Slidewhistle")

					

						-- EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[talent:3/1,noform:4]Moonkin Form;[talent:3/1]!Flap;[noform]Mount Form;[talent:2/3,form]Wild Charge\n/cancelform [form:1/2]\n/use [mod:alt]Weathered Purple Parasol\n/use [nomod,nostealth,form]Seafarer's Slidewhistle")				
						-- EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[talent:3/1,noform:4]Moonkin Form;[talent:3/1]!Flap;[noform]Mount Form;[talent:2/3,form]Wild Charge\n/cancelform [form:1/2]\n/use [mod:alt]Weathered Purple Parasol\n/use [nomod,nostealth,form]Seafarer's Slidewhistle")

						-- 						EditMacro("WSxGen8",nil,nil,"#show Dash\n/use [@focus,mod,help,nodead][@party1,help,nodead,mod]Swiftmend;[@focus,help,nodead][@party1,help,nodead]Swiftmend")
						-- EditMacro("WSxGen8",nil,nil,"#show Dash\n/use [@focus,mod,help,nodead][@party1,help,nodead,mod]Swiftmend;[@focus,help,nodead][@party1,help,nodead]Swiftmend")		
						-- EditMacro("WSxGen8",nil,nil,"#show Dash\n/use [@focus,help,nodead][@party1,help,nodead]Swiftmend")
						-- EditMacro("WSxGen9",nil,nil,"#show Hibernate\n/use [@focus,mod,help,nodead][@party2,help,nodead,mod]Swiftmend;[@focus,help,nodead][@party2,help,nodead]Swiftmend")
						-- EditMacro("WSxGen9",nil,nil,"#show Hibernate\n/use [@focus,mod,help,nodead][@party2,help,nodead,mod]Swiftmend;[@focus,help,nodead][@party2,help,nodead]Swiftmend")
						-- EditMacro("WSxGen9",nil,nil,"#show Innervate\n/use [@focus,mod,help,nodead][@party2,help,nodead,mod]Cenarion Ward;[@focus,help,nodead][@party2,help,nodead]Swiftmend")

						-- 						EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,dead][help,dead]Rebirth;[form:2,notalent:1/3]Rake;[@mouseover,harm,nodead][harm,nodead]Moonfire;Druid and Priest Statue Set\n/use [nocombat,noform:1/4]!Prowl\n/targetenemy [noexists]")
						-- EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,dead][help,dead]Rebirth;[@mouseover,harm,nodead][harm,nodead]Moonfire;Druid and Priest Statue Set\n/use [nocombat,noform:1/4]!Prowl\n/targetenemy [noexists]")
						-- EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,dead][help,dead]Rebirth;[@mouseover,help,nodead][help,nodead]Innervate;[@mouseover,harm,nodead][harm,nodead]Moonfire;Druid and Priest Statue Set\n/use [nocombat,noform:1/4]!Prowl\n/targetenemy [noexists]")
-- EditMacro("WSxGen2",nil,nil,"/use [nocombat,noexists]Moonfeather Statue;[talent:3/1,noform:4]Moonkin Form;[@mouseover,harm,nodead,talent:3/1,form:4][talent:3/1,form:4,harm,nodead]Sunfire;[noform:2]!Cat Form\n/targetenemy [noexists]") 
-- 						EditMacro("WSxGen2",nil,nil,"/use [nocombat,noexists]Moonfeather Statue;[form:1]Mangle;[talent:3/1,noform:4]Moonkin Form;[talent:3/2,noform:2]!Cat Form;[form:2]Shred;[@mouseover,harm,nodead,talent:3/1,form:4][talent:3/1,form:4]Sunfire\n/targetenemy [noexists]\n/cleartarget [dead]")
-- 						EditMacro("WSxGen2",nil,nil,"/use [@mouseover,harm,nodead][harm,nodead][harm,nodead]Sunfire;Moonfeather Statue\n/targetenemy [noexists]\n/cleartarget [dead]") 
-- EditMacro("WSxGenR",nil,nil,"/cancelform [talent:2/3,form,@mouseover,help,nodead]\n/use [mod:ctrl]Stampeding Roar;[talent:3/3,@cursor,mod]Ursol's Vortex;[talent:3/2,mod]Incapacitating Roar;[mod]Typhoon;[talent:2/3,noform,@mouseover,help,nodead]Wild Charge;Maim")
-- 						EditMacro("WSxGenR",nil,nil,"/cancelform [talent:2/3,form,@mouseover,help,nodead]\n/use [mod:ctrl]Stampeding Roar;[talent:3/3,@cursor,mod]Ursol's Vortex;[talent:3/1,mod]Typhoon;[talent:2/3,noform,@mouseover,help,nodead]Wild Charge;Incapacitating Roar")
-- 						EditMacro("WSxGenR",nil,nil,"/cancelform [talent:2/3,form,@mouseover,help,nodead]\n/use [mod:ctrl]Stampeding Roar;[talent:3/3,mod]Incapacitating Roar;[talent:3/1,mod]Typhoon;[talent:2/3,noform,@mouseover,help,nodead]Wild Charge;[@cursor]Ursol's Vortex")