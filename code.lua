SLASH_ZIGIALLBUTTONS1 = "/zigi"
local ZigiAllButtons = CreateFrame("FRAME", "ZigiAllButtons")

ZigiAllButtons:RegisterEvent("BAG_UPDATE_DELAYED")
ZigiAllButtons:RegisterEvent("ZONE_CHANGED_NEW_AREA")
ZigiAllButtons:RegisterUnitEvent("UNIT_PET","player")
ZigiAllButtons:RegisterEvent("GROUP_ROSTER_UPDATE")
ZigiAllButtons:RegisterEvent("PLAYER_ENTERING_WORLD")
ZigiAllButtons:RegisterEvent("PLAYER_LEVEL_UP")
ZigiAllButtons:RegisterEvent("LEARNED_SPELL_IN_TAB")
ZigiAllButtons:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
ZigiAllButtons:RegisterEvent("TRAIT_CONFIG_UPDATED")
ZigiAllButtons:RegisterEvent("COVENANT_CHOSEN")


local loaded = false
local locked = false

function SlashCmdList.ZIGIALLBUTTONS(msg, ...)
	if msg == "zonevars" then
		ZigiPrintZoneVars()
	else
		DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: Known commands are:\n(ZigiAllButtons): zigi zonevars\n(ZigiLevelNewChar): zigiplz eq\n(ZigiLevelNewChar): zigiplz save\n(ZigiLevelNewChar): zigiplz load\n(ZigiLevelNewChar): zigiplz dragonzigi\n(ZigiLevelNewChar): zigiplz new",0.5,1.0,0.0)
	end
end
--[[/use [nomounted]Eternal Black Diamond Ring
/run if IsControlKeyDown() then C_PartyInfo.LeaveParty() elseif IsShiftKeyDown() then LFGTeleport(IsInLFGDungeon()) end
--]]

local _,class = UnitClass("player")

local classSkillList = {
	["SHAMAN"] = {
		[188196] = "Lightning Bolt",
		[77130] = "Purify Spirit",
		[2645] = "Ghost Wolf", 
		[6196] = "Far Sight",
		[2825] = "Bloodlust",
		[32182] = "Heroism",
		[73899] = "Primal Strike",
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
		[118] = "Polymorph",
		[80353] = "Time Warp",
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
		[126892] = "Zen Pilgrimage",
		[8647] = "Mystic Touch",
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
		[4987] = "Cleanse",
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
		[56814] = "Detection",
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
		[527] = "Purify",
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
		[1680] = "Whirlwind",
		[1464] = "Slam",
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
		[191427] = "Metamorphosis",
		[188499] = "Blade Dance",
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
		[355913] = "Emerald Blossom",
		[364342] = "Blessing of the Bronze",
		[390386] = "Fury of the Aspects",
		[360823] = "Naturalize",
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
		[357210] = "Deep Breath",
		[371806] = "Recall",
	},
}
local commandPetAbilities = {
	["HUNTER"] = {
		[272682] = "Master's Call",
		[272679] = "Fortitude of the Bear",
	}
}
-- Battle of Dazar'alor, Mercenary BG Racial parser
local vars = {
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
	--,
	[41] = "@party",
	[42] = "",
	[43] = "",
	[44] = "/use [@mouseover,exists,nodead][@cursor]Garrison Ability",
	[45] = "\n/use Moroes' Famous Polish",
	[46] = "\n/use [nospec:3]Lightning Shield;Water Shield",
	-- [47] = "",
	[48] = "",
	[49] = "Tipipants",
	[50] = "",
	[51] = "\n/use Orb of Deception",
	[52] = "",
	[53] = "",
	[54] = "\n/use Honorable Pennant",
	[55] = {"Iridal, the Earth's Master", "Dreambinder, Loom of the Great Cycle", "Djaruun, Pillar of the Elder Flame","Cruel Dreamcarver","Kharnalex, The First Light"},
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = {},
	[61] = {},
	[62] = {},
	[63] = {},
	[64] = "\n/use [help,nocombat]Swapblaster"
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
local garrisonId = { 
	[1152] = true, 
	[1330] = true,
	[1153] = true,
	[1158] = true,
	[1331] = true,
	[1159] = true, 
}
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

-- Sätta overrides för 5 = Mawsworn och 6 = Enlightened, så får vi fler customisations options på klassnivå.
local covenantsEnum = {
	1,
	2,
	3,
	4,
	5,
	6,
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
local covTable = {
	[""] = {},
	["Kyrian"] = {
		["SHAMAN"] = "Vesper Totem",
		["MAGE"] = "Radiant Spark",
		["WARLOCK"] = "Scouring Tithe",
		["MONK"] = "Weapons of Order",
		["PALADIN"] = "Divine Toll",
		["HUNTER"] = "Resonating Arrow",
		["ROGUE"] = "Echoing Reprimand",
		["PRIEST"] = "Boon of the Ascended",
		["DEATHKNIGHT"] = "Shackle the Unworthy",
		["WARRIOR"] = "Spear of Bastion",
		["DRUID"] = "Kindred Spirits",
		["DEMONHUNTER"] = "Elysian Decree",
	},
	["Necrolord"] = {
		["SHAMAN"] = "Primordial Wave",
		["MAGE"] = "Deathborne",
		["WARLOCK"] = "Decimating Bolt",
		["MONK"] = "Bonedust Brew",
		["PALADIN"] = "Vanquisher's Hammer",
		["HUNTER"] = "Death Chakram",
		["ROGUE"] = "Serrated Bone Spike",
		["PRIEST"] = "Unholy Nova",
		["DEATHKNIGHT"] = "Abomination Limb",
		["WARRIOR"] = "Conqueror's Banner",
		["DRUID"] = "Adaptive Swarm(Necrolord)",
		["DEMONHUNTER"] = "Fodder to the Flame",
	},
	["Night Fae"] = {
		["SHAMAN"] = "Fae Transfusion",
		["MAGE"] = "Shifting Power",
		["WARLOCK"] = "Soul Rot",
		["MONK"] = "Faeline Stomp",
		["PALADIN"] = "Blessing of Summer",
		["HUNTER"] = "Wild Spirits",
		["ROGUE"] = "Sepsis",
		["PRIEST"] = "Fae Guardians",
		["DEATHKNIGHT"] = "Death's Due",
		["WARRIOR"] = "Ancient Aftershock",
		["DRUID"] = "Convoke the Spirits",
		["DEMONHUNTER"] = "The Hunt",
	},
	["Venthyr"] = {
		["SHAMAN"] = "Chain Harvest",
		["MAGE"] = "Mirrors of Torment",
		["WARLOCK"] = "Impending Catastrophe",
		["MONK"] = "Fallen Order",
		["PALADIN"] = "Ashen Hallow",
		["HUNTER"] = "Flayed Shot",
		["ROGUE"] = "Flagellation",
		["PRIEST"] = "Mindgames",
		["DEATHKNIGHT"] = "Swarming Mist",
		["WARRIOR"] = "Condemn",
		["DRUID"] = "Ravenous Frenzy",
		["DEMONHUNTER"] = "Sinful Brand",
	},
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
-- equipment sets
local EQS = {
	[1] = "Noon!",
	[2] = "DoubleGate",
	[3] = "Menkify!",
	[4] = "Supermenk",
	[5] = "",
}
-- Target BG Healers and Set BG Healers // Helpful measures in non-bg areas
local numaltbuff101112 = {
	["SHAMAN"] = "Hex",
	["MAGE"] = "Polymorph",
	["WARLOCK"] = "Command Demon",
	["MONK"] = "Paralysis",
	["PALADIN"] = "Repentance",
	["HUNTER"] = "Intimidation",
	["ROGUE"] = "Blind",
	["PRIEST"] = "Fade",
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
-- Target BG Healers and Set BG Healers // Helpful measures in non-bg areas
local numaltbuff789 = {
	["SHAMAN"] = "Hex",
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
-- Target BG Healers and Set BG Healers // Helpful measures in non-bg areas
local modnumaltbuff789 = {
	["SHAMAN"] = "Lightning Shield",
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

local arenaDots = {
	["SHAMAN"] = "Flame Shock",
	["MAGE"] = "Mage Bomb",
	["WARLOCK"] = "Singe Magic",
	["MONK"] = "Detox",
	["PALADIN"] = "Cleanse",
	["HUNTER"] = "Roar of Sacrifice",
	["ROGUE"] = "Tricks of the Trade",
	["PRIEST"] = "Shadow Word: Pain",
	["DEATHKNIGHT"] = "Outbreak",
	["WARRIOR"] = "Rend",
	["DRUID"] = "Moonfire", 
	["DEMONHUNTER"] = "Throw Glaive",
	["EVOKER"] = "Pyre",
}
local altArenaDots = {
	["SHAMAN"] = "Flame Shock",
	["MAGE"] = "Mage Bomb",
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
	["MAGE"] = "Mage Bomb",
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
	["DRUID"] = "Soothe", 
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
	["PRIEST"] = "Mind Control",
	["DEATHKNIGHT"] = "Asphyxiate",
	["WARRIOR"] = "Storm Bolt",
	["DRUID"] = "Cyclone", 
	["DEMONHUNTER"] = "Imprison",
	["EVOKER"] = "Sleep Walk",
}
local wmpnomodkick = {
	["SHAMAN"] = "Wind Shear",
	["MAGE"] = "Counterspell",
	["WARLOCK"] = "Command Demon",
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

-- bind to function, has two override subroutines for arrays and nested array types
local function b(spellName, macroCond, semiCol)
	-- Skriv om så att jag inte behöver sätta overrides innan anropen, lägg till stöd för parameter-overriding för arrays och strängar, vill kunna skicka in arrayer med spells.
	if not InCombatLockdown() then
		-- if string
		if type(spellName) == "string" then 
			for k,v in pairs(classSkillList[class]) do
				if v == spellName then
					if IsPlayerSpell(k) or IsSpellKnown(k) then
						spellName = (select(1,GetSpellInfo(k)))
						if (macroCond == "" or macroCond == nil) and (semiCol == "" or semiCol == nil) then
							return spellName
						else
							return (macroCond or "")..(spellName or "")..(semiCol or "")
						end
					end
				end
			end
		elseif type(spellName) == "table" then
		-- Method overrides
			local tmpSpellObject = {}
			local nestedTableFound = false
			for i,v in pairs(spellName) do
				if type(v) == "table" then
					nestedTableFound = true
				end
			end
			-- if nested table
			if nestedTableFound == true then
			-- call signature should look like (b({{spellName,macroCond,semiCol},{...},}) or "")
				local tmpSpellObjectArray = {{}}
				for i,tbl in ipairs(spellName) do
					table.insert(tmpSpellObjectArray,i,tbl)
					for i,str in ipairs(tbl) do
						table.insert(tmpSpellObject,i,str)
					end
					spellName = tmpSpellObject[1]
					macroCond = tmpSpellObject[2]
					semiCol = tmpSpellObject[3]
					for k,v in pairs(classSkillList[class]) do
						if v == spellName then
							if IsPlayerSpell(k) or IsSpellKnown(k) then
								spellName = (select(1,GetSpellInfo(k)))
								return macroCond..spellName..semiCol
							end
						end
					end
				end
			else
				-- call signature should look like (b({spellName,macroCond,semiCol}) or "")
				-- observed to be never used by user, obsolete?
				for i,str in pairs(spellName) do
					table.insert(tmpSpellObject,i,str)
				end
				spellName = tmpSpellObject[1]
				macroCond = tmpSpellObject[2]
				semiCol = tmpSpellObject[3]
				for k,v in pairs(classSkillList[class]) do
					if v == spellName then
						if IsPlayerSpell(k) or IsSpellKnown(k) then
							spellName = (select(1,GetSpellInfo(k)))
							print("Object[spellName]", spellName)
							print("Object[macroCond]", macroCond)
							print("Object[semiCol]", semiCol)
							return macroCond..spellName..semiCol
						end
					end
				end
			end
		end
	end
end
local function groupRosterBuilder(role)
	if role == "tank" then
		role = "help,nodead" 
		for i = 1, 5 do 
			if UnitGroupRolesAssigned("party"..i) == "TANK" then 
				role = "@".."party"..i 
				-- print("Role Tank found at: ",role)
				return role or ""
			else
				-- print("Tank not found!")
				return role or ""
			end 
		end
	elseif role == "healer" then
		role = "help,nodead"
		for i = 1, 5 do  
			if UnitGroupRolesAssigned("party"..i) == "HEALER" then 
				role = "@".."party"..i 
				-- print("Role Healer found at: ",role)
				return role or ""
			else
				-- print("Healer not found!")
				return role or ""
			end  
		end
	end
end

local function pandaremixSpecial(spellType)
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
			if spellType == "throughputAbilities" then
				spellType = "Artist's Easel"
			end
			return spellType or ""
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
			if spellType == "movementAbilties" then
				spellType = "Darkmoon Seesaw"
			end
			return spellType or ""
		end
		if spellType == "resItem" then
			if GetItemCount("Timeless Scroll of Resurrection") >= 1 then
				spellType = "Timeless Scroll of Resurrection"
			else 
				spellType = ""
			end 
			return spellType or "" 
		end
		if spellType == "meteorChip" then
			if GetItemCount("Meteor Chip") >= 1 then 
				spellType = "\n/use Meteor Chip"
			else
				spellType = ""
			end
			return spellType or ""
		end
		if spellType == "bottleBees" then
			if GetItemCount("Bottle of Bees") >= 1 then
				spellType = "Bottle of Bees"
			else 
				spellType = ""
			end
			return spellType or ""
		end
		if spellType == "pandaTaxi" then
			local pandaTaxiUsables = {"Tuft of Yak Fur"}
			for i, pandaTaxiUsables in pairs(pandaTaxiUsables) do
				if GetItemCount(pandaTaxiUsables) >= 1 then
					spellType = "\n/use "..pandaTaxiUsables
				end
			end
			-- if empty
			if spellType == "pandaTaxi" then
				spellType = ""
			end
			return spellType or ""
		end
	else
		return fallback or ""	
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
	if item == "crKnife" then
		if GetItemCount("Ultimate Gnomish Army Knife") >= 1 then 
			item = "[nocombat]Ultimate Gnomish Army Knife;"
			return item or ""
		else
			item = ""
		end
		return item or "" 
	end
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
			item = "[nocombat,noexists]Anti-Doom Broom;"
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
			for k, v in pairs(hasPot) do
			    if GetItemCount(hasPot[k]) >= 1 and primary == hasPot[v] then
			        hasPotInBags = "item:"..hasPot[k]
			    end
			end
			hasPot = {
				171349,
				169299,
				191383,
				191389,
				191388,
				191387,
				191382,
				191381,
				142117,
				217904,
			}
			for i, hasPot in pairs(hasPot) do
			    if GetItemCount(hasPot) >= 1 then
			        hasPotInBags = "item:"..hasPot
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
	        "Timerunner's Vial",
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
		if GetItemCount(36799) >= 1 then
			hasManaGem = "item:36799"		
		elseif b("Displacement") == "Displacement" then 
			hasManaGem = "Displacement"
			--Arcane
		elseif GetItemCount(87257) >= 1 then
			hasManaGem = "item:87257"
			--Fiery
		elseif GetItemCount(87258) >= 1 then
			hasManaGem = "item:87258"
			--Icy
		elseif GetItemCount(87259) >= 1 then
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
		if class == "SHAMAN" and macroCond == "Alliance" and b("Heroism") then 
	    	hasDrumsInBags = "Heroism"
		elseif class == "SHAMAN" and b("Bloodlust") then 
			hasDrumsInBags = "Bloodlust"
		elseif class == "MAGE" and b("Time Warp") then 
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
		elseif class == "EVOKER" and b("Fury of the Aspects") then 
			hasDrumsInBags = "Fury of the Aspects\n/use Prismatic Bauble\n/targetfriendplayer\n/use [help,nodead]Rainbow Generator\n/targetlasttarget [exists]"
		end
		return hasDrumsInBags or ""
	end
end

function zigiTrade(tradable)
	local c=C_Container 
	for i=0,4 do 
		for x=1,c.GetContainerNumSlots(i)do 
			y=c.GetContainerItemLink(i,x)
			if y and GetItemInfo(y)== tradable then 
				c.PickupContainerItem(i,x)DropItemOnUnit("target")
				return TradeFrameTradeButton:Click() 
			end 
		end 
	end
end

local function eventHandler(event)

	-- Jag vill splitta upp eventhandlerns events till olika funktioner som anropas av eventHandlern eventuellt, det blir för rörigt.
	local faction = UnitFactionGroup("player")
	local _,race = UnitRace("player")
	local sex = UnitSex("player")
	local playerSpec = GetSpecialization(false,false)
	local playerName = UnitName("player")
	local petSpec = GetSpecialization(false,true)
	local level = UnitLevel("player")
	local eLevel = UnitEffectiveLevel("player")
	local z, m, mA, mP = GetZoneText(), "", "", ""
	local instanceName, instanceType, difficultyID, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance, mapID, instanceGroupSize = GetInstanceInfo()
	-- print("test")
	hasCannon = vars[1]
	alt4 = vars[2]
	alt5 = vars[3]
	alt6 = vars[4]
	alt9 = vars[5]
	CZ = vars[6]
	AR = vars[7]
	conDB = vars[8]
	conEF = vars[9]
	conAF = vars[10]
	conVS = vars[11]
	conSET = vars[12]
	conST = vars[13]
	conSst = vars[14]
	conMW = vars[15]
	conMS = vars[16]
	conTE = vars[17]
	conBE = vars[18]
	conCE = vars[19]
	conRE = vars[20]
	LAR = vars[21] 
	hasShark = vars[22]
	hasScrapper = vars[23] 
	sigA = vars[24]
	sigB = vars[25]
	covA = vars[26]
	covB = vars[27]
	poS = vars[28]
	hoaEq = vars[29]
	hasHE = vars[30]
	slBPGen = vars[31]
	pwned = vars[32] 
	fftpar = vars[33] 
	factionPride = vars[34] 
	factionFireworks = vars[35] 
	passengerMount = vars[36] 
	warPvPExc = vars[37]
	locPvPQ = vars[38] 
	locPvPSThree = vars[39]
	locPvPF = vars[40] 
	--
	PoA = vars[41]
	covSpecial = vars[42]
	classText = vars[43]
	zA = vars[44]
	ink = vars[45]
	ccz = vars[46]
	-- chameleon = vars[47]
	usable = vars[48]
	tpPants = vars[49]
	noPants = vars[50]
	oOtas = vars[51]
	bfaIsland = vars[52]
	slBP = vars[53]
	pennantClass = vars[54]
	usableWeapons = vars[55]
	usableWeaponEquipped = vars[56]
	override = vars[57]
	overrideModAlt = vars[58]
	overrideModCtrl = vars[59]
	mercenaryRacials = vars[60]
	racials = vars[61]
	dpsRacials = vars[62]
	extraRacials = vars[63]
	swapblaster = vars[64]

	if InCombatLockdown() then
		ZigiAllButtons:RegisterEvent("PLAYER_REGEN_ENABLED")
	else

		-- -- Configure Battlefield Map
		if not BattlefieldMapFrame then
			BattlefieldMap_LoadUI(); 
		else
			BattlefieldMapFrame:SetScale(1.4)
			BattlefieldMapFrame:SetAlpha(.9)
			BattlefieldMapFrame:SetPoint("TOPLEFT")
			BattlefieldMapFrame.BorderFrame.CloseButton:Hide()
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

		slBP = C_Covenants.GetActiveCovenantID(covenantsEnum)
		-- CovToys
		if slBP and covToys[slBP] then
			covToys = covToys[slBP]
			covToys = covToys[random(#covToys)]
			covToys = "\n/use "..covToys
		end


		-- if Instanced Content 
		if instanceType ~= "none" then
			SetBinding("A","STRAFELEFT")
			SetBinding("D","STRAFERIGHT")
		else
		-- else: InstanceType: "none"
			SetBinding("A","TURNLEFT")
			SetBinding("D","TURNRIGHT")
		end

		-- DEFAULT_CHAT_FRAME:AddMessage("ZigiAllButtons: ZONEw_CHANGED_NEW_AREA\nRecalibrating related macros :)",0.5,1.0,0.0)
		if (event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PLAYER_ENTERING_WORLD") then
			if race == "Orc" then
				pennantClass = "\n/use Clan Banner"
			elseif class == "ROGUE" and playerSpec ~= 2 then
				pennantClass = "\n/use Honorable Pennant\n/cancelaura A Mighty Pirate"
			elseif class == "ROGUE" or (playerName == "Stabbin" and class == "HUNTER" and race == "Goblin") then 
				pennantClass = "\n/use Jolly Roger\n/cancelaura Honorable Pennant\n/use Swarthy Warning Sign"
			end
		end

		mercenaryRacials = {
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

		-- mercenaryRacials Setter
		for k,v in pairs(mercenaryRacials) do
			if IsSpellKnown(k) == true then
				race = v
			end
		end

		racials = {	
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
		
		dpsRacials = {
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
		extraRacials = {	
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
		if faction == "Alliance" then
			pwned = "Alliance Flag of Victory" 
			fftpar = "Touch of the Naaru"
			factionPride = "Gnomeregan Pride"
			factionFireworks = "Everlasting Alliance Firework"
			passengerMount = "Stormwind Skychaser" 
		end

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

		if not extraRacials[race] and class == "SHAMAN" then
			extraRacials = b({{"Wind Rush Totem","[@player]",""},{"Earthgrab Totem","[@player]",""},}) or "Zandalari Effigy Amulet"
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
		if race == "VoidElf" then
			EditMacro("Wx6RacistAlt+V",nil,nil,"#show " ..racials.."\n/use Prismatic Bauble\n/use Sparklepony XL\n/castsequence reset=9 "..racials..",Languages")
		else
			EditMacro("Wx6RacistAlt+V",nil,nil,"#show " ..racials.."\n/use Prismatic Bauble\n/use Sparklepony XL\n/use "..racials)
		end
		-- dpsRacials Implementation
		if class == "SHAMAN" then
			EditMacro("WSkillbomb",nil,nil,"/use "..(b({{"Fire Elemental","",""},{"Storm Elemental","",""},{"Feral Spirit","",""},{"Earth Elemental","\n/use ","\n/use Tiny Box of Tiny Rocks"},}) or "").."\n/use Rukhmar's Sacred Memory"..(b("Ascendance","\n/use ","") or "")..dpsRacials.."\n/use [@player]13\n/use 13\n/use Flippable Table\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")	
		elseif class == "MAGE" then
			EditMacro("WSkillbomb",nil,nil,"#show"..(b({{"Combustion","\n/use ",""},{"Icy Veins","\n/use ",""},{"Arcane Surge","\n/use ",""},}) or "")..(b("Mirror Image","\n/use ","") or "")..dpsRacials.."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13\n/use Hearthstone Board\n/use Gleaming Arcanocrystal\n/use Big Red Raygun"..hasHE)
		elseif class == "WARLOCK" then
			EditMacro("WSkillbomb",nil,nil,"#show\n/use "..(b({{"Summon Demonic Tyrant","",""},{"Nether Portal","",""},{"Summon Infernal","[@player]",""},{"Summon Darkglare","",""},}) or "").."\n/use Jewel of Hellfire\n/use [@player]13\n/use 13"..dpsRacials.."\n/use Shadescale\n/use Adopted Puppy Crate\n/use Big Red Raygun")
		elseif class == "MONK" then
			EditMacro("WSkillbomb",nil,nil,"#show"..(b({{"Storm, Earth, and Fire","\n/use ",""},{"Serenity","\n/use ",""},}) or "")..(b({{"Invoke Xuen, the White Tiger","\n/use ",""},{"Invoke Yu'lon, the Jade Serpent","\n/use ",""},{"Invoke Chi-Ji, the Red Crane","\n/use ",""},{"Invoke Niuzao, the Black Ox","\n/use ",""},}) or "")..dpsRacials.."\n/use Rukhmar's Sacred Memory\n/use Adopted Puppy Crate\n/use [@player]13\n/use 13\n/use Big Red Raygun\n/use Piccolo of the Flaming Fire\n/use [@player]Summon White Tiger Statue")
		elseif class == "PALADIN" then
			EditMacro("WSkillbomb",nil,nil,"#show\n/use "..(b("Avenging Wrath","","") or "").."\n/use [@player]13\n/use 13\n/use Sha'tari Defender's Medallion"..dpsRacials.."\n/use Gnawed Thumb Ring\n/use Echoes of Rezan")
		elseif class == "HUNTER" then
			EditMacro("WSkillbomb",nil,nil,"#show\n/use "..(b({{"Bestial Wrath","",""},{"Trueshot","",""},{"Coordinated Assault","",""},{"Spearhead","",""}}) or "Hunter's Call").."\n/use Will of Northrend"..dpsRacials.."\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Pendant of the Scarab Storm\n/use Big Red Raygun\n/use Echoes of Rezan")
		elseif class == "ROGUE" then
			EditMacro("WSkillbomb",nil,nil,"/use "..(b({{"Deathmark","",""},{"Adrenaline Rush","",""},{"Shadow Blades","",""},}) or "").."\n/stopmacro [stealth]\n/use Will of Northrend"..dpsRacials.."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13"..hasHE.."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
		elseif class == "PRIEST" then
			EditMacro("WSkillbomb",nil,nil,"/use "..(b("Shadowfiend","","") or "")..dpsRacials.."\n/use Rukhmar's Sacred Memory\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
		elseif class == "DEATHKNIGHT" then
			EditMacro("WSkillbomb",nil,nil,"#show\n/cast "..(b({{"Dancing Rune Weapon","",""},{"Pillar of Frost","",""},{"Dark Transformation","[nopet]Raise Dead;",""},}) or "")..dpsRacials.."\n/use [@player]13\n/use 13\n/use Raise Dead\n/use Pendant of the Scarab Storm\n/use Adopted Puppy Crate\n/use Big Red Raygun")
		elseif class == "WARRIOR" then
			EditMacro("WSkillbomb",nil,nil,"#show "..(b("Avatar","\n/use ","") or "")..(b("Recklessness","\n/use ","") or "")..(b("Battle Stance","\n/use [nostance:2]","") or "")..((b("Berserker Stance","\n/use [nostance:2]","") or "")).."\n/use Flippable Table"..dpsRacials..hasHE.."\n/use Will of Northrend\n/use [@player]13\n/use 13"..(b("Thunderous Roar","\n/use ","") or "")..(b("Bladestorm","\n/use ","") or "")..(b("Ravager","\n/use [@player]","") or "").."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
		elseif class == "DRUID" then
			EditMacro("WSkillbomb",nil,nil,"#show "..(b({{"Celestial Alignment","\n/use [@cursor]",""},{"Incarnation: Chosen of Elune","\n/use !",""},{"Incarnation: Avatar of Ashamane","\n/use !",""},{"Incarnation: Guardian of Ursoc","\n/use !",""},{"Berserk","\n/use ",""},{"Incarnation: Tree of Life","\n/use !",""},{"Tranquility","\n/use ",""},}) or "")..(b("Nature's Vigil","\n/use ","") or "")..(b("Force of Nature","\n/use [@player]","") or "")..dpsRacials.."\n/use [spec:1/4]Rukhmar's Sacred Memory;Will of Northrend\n/use [@player]13\n/use 13\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
		elseif class == "DEMONHUNTER" then
			EditMacro("WSkillbomb",nil,nil,"#showtooltip "..(b("Metamorphosis") or "").."\n/use Shadowy Disguise\n/use Shadow Slicing Shortsword\n/use [@player]Metamorphosis\n/use [@player]13\n/use 13"..dpsRacials.."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
		elseif class == "EVOKER" then
			EditMacro("WSkillbomb",nil,nil,(b({{"Dragonrage","/use ",""},{"Emerald Communion","/use !",""},{"Time Skip","/use !",""},}) or "").."\n/use [@player]13\n/use 13"..dpsRacials.."\n/use Adopted Puppy Crate\n/use Big Red Raygun\n/use Echoes of Rezan")
		end

		if (event == "PLAYER_LEVEL_UP" or event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD") then 
			if (slBP == 0 and ((level > 50 or eLevel > 50) and (level < 60 or eLevel < 60)) and slZones[z]) or (slBP == 0 and slZones[z]) then
				slBP = 5
			elseif slBP == 0 and ((level > 50 or eLevel > 50) and (level < 60 or eLevel < 60)) and not slZones[z] then
				slBP = 6
			end
		end


		-- print("slBP is: ",slBP)
		if race ~= "BloodElf" and (level and eLevel) >= 25 then
			oOtas = "\n/use Orb of the Sin'dorei"
		end
		if (level and eLevel) < 20 then
			oOtas = oOtas.."\n/use Toy Aarmor Set\n/use Toy Weapon Set"
		else
			oOtas = oOtas
		end

 		if (event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD") then 
			-- speciella item sets
			noPants = EQS[playerSpec]
			tpPants = "Tipipants"
			-- print("noPants = ", EQS[playerSpec])
			if C_EquipmentSet.GetEquipmentSetID(tpPants) ~= nil and playerSpec ~= 5 then
				tpPants = C_EquipmentSet.GetEquipmentSetID(tpPants) or ""
				noPants = C_EquipmentSet.GetEquipmentSetID(noPants) or ""
				tpPants = "C_EquipmentSet.UseEquipmentSet("..tpPants..")" 
				noPants = "C_EquipmentSet.UseEquipmentSet("..noPants..")"
			end 
		end
		-- if (event == "PLAYER_ENTERING_WORLD" or event == "LEARNED_SPELL_IN_TAB" or event == "ACTIVE_TALENT_GROUP_CHANGED") and C_PvP.IsWarModeActive() == true or (instanceType == "pvp" or instanceType == "arena") then
			-- print("test")
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
		-- end

		if (event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD") then 		

			-- lite b-funktion overrides och setters
			if class == "SHAMAN" then
				numaltbuff101112[class] = b("Earth Shield") or ""
				numaltbuff789[class] = b("Earth Shield") or ""
				modnumaltbuff789[class] = b("Earth Shield") or ""
			elseif class == "MAGE" then
				altArenaDots[class] = b({{"Nether Tempest","",""},{"Living Bomb","",""},{"Frost Bomb","",""},}) or ""
				ctrlArenaDots[class] = b({{"Nether Tempest","",""},{"Living Bomb","",""},{"Frost Bomb","",""},}) or ""
				arenaDots[class] = b({{"Nether Tempest","",""},{"Living Bomb","",""},{"Frost Bomb","",""},}) or ""
			elseif class == "WARLOCK" then
				wmpnomodkick[class] = locPvPQ
				arenaDots[class] = b({{"Demonbolt","",""},{"Immolation","",""},{"Corruption","",""},}) or ""
			-- elseif class == "ROGUE" and playerSpec == 2 then
			-- 	modnumctrlbuff789[class] = "Kidney Shot"
			-- 	numctrlbuff101112[class] = "Kidney Shot"
			-- 	numctrlbuff789[class] = "Kidney Shot"
			-- 	wmpctrlcc[class] = "Kidney Shot"
			elseif class == "PRIEST" then 
				arenaDots[class] = b("Vampiric Touch","[]",";") or "".."Shadow Word: Pain"
				wmpctrlcc[class] = b({{"Thoughtsteal","",""},{"Mind Control","",""},}) or ""
				if b("Pain Suppression") or b("Guardian Spirit") then
					numaltbuff101112[class] = (b("Pain Suppression") or "")..(b("Guardian Spirit") or "")
				end
				if playerSpec ~= 3 then
					wmpnomodkick[class] = "Mindgames"
				end
			elseif class == "DRUID" then
					wmpnomodkick[class] = (b({{"Skull Bash","",""},{"Solar Beam","",""},{"Cyclone","",""},}) or "")
					wmpctrlcc[class] = (b({{"Cyclone","",""},{"Entangling Roots","",""},}) or "")
				if (playerSpec == 2 or playerSpec == 3) then
				elseif playerSpec == 4 then
					--mod:shift base
					numaltbuff789[class] = (b("Grove Guardians","","") or "")
					numnomodbuff789[class] = (b("Grove Guardians","","") or "")
					numctrlbuff789[class] = (b("Grove Guardians","","") or "")

					modnumaltbuff789[class] = (b("Grove Guardians","","") or "")
					modnumnomodbuff789[class] = (b("Grove Guardians","","") or "")
					modnumctrlbuff789[class] = (b("Grove Guardians","","") or "")

					-- 10,11,12 buttons,
					numnomodbuff101112[class] = (b("Grove Guardians","","") or "")
					numaltbuff101112[class] = (b("Grove Guardians","","") or "")
					numctrlbuff101112[class] = (b("Grove Guardians","","") or "")
				end
			end 
		end
		-- Här börjar Events
		-- Login,zone,bag_update based event, Swapper, Alt+J parser, Call Companion, set class/spec toys.
		-- Zone och bag baserade events

		-- Showtooltip on Alt+J
		if (event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "BAG_UPDATE_DELAYED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LEVEL_UP" or event == "LEARNED_SPELL_IN_TAB") then 
			if class == "MAGE" then
				classText = "#show "..(b("Conjure Mana Gem","item:36799;",";") or "")..(b("Arcane Familiar") or "").."\n/use Pilfered Sweeper"
			end
		end
		if (event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LEVEL_UP" or event == "LEARNED_SPELL_IN_TAB") then 

			-- Skulle kunna migrera det här blocket till ZigiSwapper och göra ett funktionsanrop cross addons för b-funktionerna som lagras i classText
			if class == "SHAMAN" then
				classText = b({{"Mana Tide Totem","",""},{"Earth Elemental","",""},}) or ""
			elseif class == "WARLOCK" then
				classText = ""
			elseif class == "MONK" then
				classText = "#show "..(b({{"Black Ox Brew","",""},{"Thunder Focus Tea","",""},{"Invoke Xuen, the White Tiger","",""},}) or "")			
				if b("Invoke Xuen, the White Tiger") then
					classText = classText.."\n/use Fury of Xuen" 
				elseif b("Invoke Niuzao, the Black Ox") then 
					classText = classText.."\n/use Fortitude of Niuzao"
				elseif b("Invoke Chi-Ji, the Red Crane") then
					classText = classText.."\n/use Kindness of Chi-Ji"
				elseif b("Invoke Yu'lon, the Jade Serpent") then
					classText = classText.."\n/use Essence of Yu'lon"
				end
			elseif class == "PALADIN" then
				classText = "#show "..(b("Lay on Hands") or "").."\n/use "..(b("Contemplation","[]",";") or "Holy Lightsphere")
			elseif class == "HUNTER" then
				classText = "#show Command Pet"
				if playerSpec == 2 then 
					classText = classText.."\n/use Dark Ranger's Spare Cowl"
				else
					classText = classText.."\n/use Zanj'ir Weapon Rack"
				end
			elseif class == "ROGUE" then
				classText = "#show "..b({{"Shadow Dance","",""},{"Tricks of the Trade","",""},}) or ""
			elseif class == "PRIEST" then
				classText = "#show "..(b("Mass Dispel") or "")
			elseif class == "DEATHKNIGHT" then
				classText = "#show "..(b("Raise Dead") or "").."\n/use [nocombat]Permanent Frost Essence\n/use [nocombat]Champion's Salute"
				if faction == "Alliance" then
					classText = "#show "..(b("Raise Dead") or "").."\n/use [nocombat]Stolen Breath\n/use [nocombat]Champion's Salute"
				end
			elseif class == "WARRIOR" then
				classText = "#show Shield Block\n/use "..factionPride.."\n/use Raise Banner"
			elseif class == "DRUID" then
				classText = "#show Rebirth\n/use Wisp in a Bottle"
			elseif class == "DEMONHUNTER" then
				classText = "#show "..(b("Vengeful Retreat") or "")
			elseif class == "EVOKER" then
				classText = "#show "..(b("Time Spiral") or "")
			end
			-- print("classtext is = ",classText)
			EditMacro("WSxSwapperBody",nil, nil, classText)
			ZigiSetSwapper()	
		end
			        
		if event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD" then
			bfaIsland = ((select(3, GetInstanceInfo())))	
			-- Gör ett nytt macro för ExtraActionButton1 som har en Vindicator Matrix ability bundet när du är på Argus, bind detta till CGenB
			-- Zone Ability
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
		end

        if (event == "ZONE_CHANGED_NEW_AREA" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "BAG_UPDATE_DELAYED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LEVEL_UP" or event == "LEARNED_SPELL_IN_TAB") then 
			-- Showtooltip on Alt+J
			-- Map, get current map name for player with parent names 
			if C_Map and C_Map.GetBestMapForUnit("player") then
				local map = C_Map.GetMapInfo(C_Map.GetBestMapForUnit("player"))
				local parent = map.parentMapID and C_Map.GetMapInfo(map.parentMapID) or map
				local pp = parent and parent.name
			
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
					alt6 = alt6.."\n/use The \"Devilsaur\" Lunchbox"
					CZ = "Sightless Eye"
				-- Broken Isles is continent 8
				elseif pp == "Broken Isles" then
					alt5 = "\n/use Emerald Winds"..hasCannon
					alt6 = alt6.."\n/use The \"Devilsaur\" Lunchbox"
					CZ = "Sightless Eye"
					if z == "Highmountain" then
						alt4 = alt4.."\n/use Majestic Elderhorn Hoof"
					end
				-- Draenor is continent 7
				elseif (pp == "Draenor") or (pp == "Frostfire Ridge") or (pp == "Shadowmoon Valley") or (pp == "Ashran") then
					alt4 = alt4.."\n/use Spirit of Shinri\n/use Skull of the Mad Chief"
					alt5 = "\n/use Breath of Talador\n/use Black Whirlwind"..hasCannon
					alt6 = alt6.."\n/use Ever-Blooming Frond"
					CZ = "Aviana's Feather\n/use Treessassin's Guise"
					LAR = "Findle's Loot-A-Rang"
				elseif z == "Timeless Isle" then
					alt4 = alt4.."\n/use Cursed Swabby Helmet\n/use Battle Horn\n/use Ash-Covered Horn"
					alt5 = "\n/use Bottled Tornado"..pandaremixSpecial("meteorChip")..hasCannon
					alt6 = alt6.."\n/use Eternal Warrior's Sigil"
					CZ = "[combat]Salyin Battle Banner" 
				-- Pandaria
				elseif (pp == "Pandaria") or (pp == "Vale of Eternal Blossoms") then
					-- if pandaTaxiUsables == nil then pandaTaxiUsables = "" end
					alt4 = alt4.."\n/use Cursed Swabby Helmet\n/use Battle Horn"..pandaremixSpecial("pandaTaxi")
					alt5 = "\n/use Bottled Tornado"..pandaremixSpecial("meteorChip")..hasCannon
					alt6 = alt6.."\n/use Eternal Warrior's Sigil"
					CZ = "[combat]Salyin Battle Banner" 
					if pandaremixSpecial("bottleBees") == "Bottle of Bees" then
						hasShark = "Bottle of Bees"
					end
				-- Northrend
				elseif pp == "Northrend" then
					alt4 = alt4.."\n/use Grizzlesnout's Fang"
				end

				EditMacro("WLoot pls",nil,nil,"/click StaticPopup1Button1\n/use Battle Standard of Coordination\n/target mouseover\n/targetlasttarget [noharm,nocombat]\n/use "..LAR.."\n/use [exists,nodead,nochanneling]Rainbow Generator\n/use Gin-Ji Knife Set")
				EditMacro("WGrenade",nil,nil,"#show [mod:alt]"..hasScrapper..";"..hasShark.."\n/use Hot Buttered Popcorn\n/use [mod:alt]"..hasScrapper..";"..hasShark)
				
				-- (Shaman är default/fallback)
				
				if class == "MAGE" then
					ccz = "\n/use [combat,help,nodead][nocombat]Arcane Intellect;Invisibility"
				elseif class == "WARLOCK" then
					ccz = "\n/use Lingering Wyrmtongue Essence\n/use [nocombat,noexists]Heartsbane Grimoire"
				elseif class == "MONK" then
					ccz = "\n/use Mystical Orb of Meditation"
				elseif class == "PALADIN" then
					ccz = "\n/use Mystical Orb of Meditation\n/use Mark of Purity\n/use !Devotion Aura"
				elseif class == "HUNTER" then
					ccz = "\n/use "..(b("Aspect of the Chameleon","","") or "Hunter's Call").."\n/use [nocombat]!Camouflage;Feign Death" 
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
			end
      		      		    
			EditMacro("WMPAlt+4",nil,nil,"/target [@boss1,exists,nodead,nomod:ctrl]\n/target [@arena1,exists,nodead,nomod:ctrl]\n/use [mod:ctrl,"..PoA.. "1,nodead]"..aC[class]..alt4)
			EditMacro("WMPAlt+5",nil,nil,"/target [@boss2,exists,nodead,nomod:ctrl]\n/target [@arena2,exists,nodead,nomod:ctrl]\n/use [mod:ctrl,"..PoA.. "2,nodead]"..aC[class]..alt5)
			EditMacro("WMPAlt+6",nil,nil,"/target [@boss3,exists,nodead,nomod:ctrl]\n/target [@arena3,exists,nodead,nomod:ctrl]\n/use [mod:ctrl,"..PoA.."3,nodead]"..aC[class]..alt6)
			EditMacro("WMPAlt+9",nil,nil,"/focus [@arena3,exists,nodead]\n/target [@boss6,exists]Boss6"..alt9)
			
			EditMacro("wWBGHealer1",nil,nil,"/use [mod:alt,@arena1,harm,nodead][mod:alt,@boss1,harm,nodead]"..altArenaDots[class]..";[mod:ctrl,@arena1,harm,nodead][mod:ctrl,@boss1,harm,nodead]"..ctrlArenaDots[class]..";[@arena1,harm,nodead][@boss1,harm,nodead]"..arenaDots[class])
			EditMacro("wWBGHealer2",nil,nil,"/use [mod:alt,@arena2,harm,nodead][mod:alt,@boss2,harm,nodead]"..altArenaDots[class]..";[mod:ctrl,@arena2,harm,nodead][mod:ctrl,@boss2,harm,nodead]"..ctrlArenaDots[class]..";[@arena2,harm,nodead][@boss2,harm,nodead]"..arenaDots[class])        
			EditMacro("wWBGHealer3",nil,nil,"/use [mod:alt,@arena3,harm,nodead][mod:alt,@boss3,harm,nodead]"..altArenaDots[class]..";[mod:ctrl,@arena3,harm,nodead][mod:ctrl,@boss3,harm,nodead]"..ctrlArenaDots[class]..";[@arena3,harm,nodead][@boss3,harm,nodead]"..arenaDots[class])
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
			EditMacro("WMPCC+4",nil,nil,"/use [mod:alt,@arena1,harm,nodead]"..(wmpaltpurge[class] or "")..";[mod:ctrl,@arena1,harm,nodead]"..(wmpctrlcc[class] or "")..";[@arena1,harm,nodead][@boss1,harm,nodead]"..(wmpnomodkick[class] or "")..";")
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
			if cov[slBP] == "Kyrian" then
				poS = "\n/use [mod]item:177278"
				sigA = "Summon Steward"
			-- Necrolord, "Fleshcraft" 
			elseif cov[slBP] == "Necrolord" then
				poS = ""
				sigA = "Fleshcraft"
			-- Night Fae, "Soulshape"
			elseif cov[slBP] == "Night Fae" then
				poS = ""
				sigA = "Soulshape"
			-- Venthyr, "Door of Shadows"
			elseif cov[slBP] == "Venthyr" then
				poS = ""
				sigA = "Door of Shadows"
			end

			if cov[slBP] ~= "" then
				covA = covTable[cov[slBP]][class] 
			end
			-- print("covA", covA)
			-- hard exceptions
			if class == "EVOKER" then 
				covA = "Boon of the Covenants"
			end
		 
		    -- Class Artifact Button, "§" Completed, note: Kanske kan hooka Heart Essence till fallback från Cov och Signature Ability? Sedan behöver vi hooka Ritual of Doom till Warlock Order Hall också.
			-- Covenant and Signature Ability parser
			-- Kyrian, "Summon Steward", phial of serenity
			for i,v in pairs(usableWeapons) do
				if IsEquippedItem(v) == true then
					usableWeaponEquipped = v
				end
			end
					
			sigB = "[@mouseover,exists,nodead,mod][@cursor,mod]"..sigA
			covB = "[@mouseover,exists,nodead][@cursor]"..covA..poS
			hoaEq = "[@mouseover,exists,nodead][@cursor]Heart Essence"
			if PlayerGetTimerunningSeasonID() == 1 then
				covA = pandaremixSpecial("throughputAbilities") or ""
				sigA = pandaremixSpecial("movementAbilties") or ""
				sigB = "[@mouseover,exists,nodead,mod][@cursor,mod]"..sigA
				covB = "[@mouseover,exists,nodead][@cursor]"..covA
				slBPGen = sigB..";"..covB
				if GetItemCount("Timeless Scroll of Cleansing") >= 1 then
					EditMacro("PvPAT 1" , nil, 4549192, "/stopspelltarget\n/stopspelltarget\n/use [@mouseover,exists,nodead,nomod][@cursor,nomod]Timeless Scroll of Cleansing")
				end
				if GetItemCount("Timeless Scroll of Summoning") >= 1 then
					EditMacro("PvPAT 2" , nil, 4549182, "/stopspelltarget\n/stopspelltarget\n/use [@mouseover,exists,nodead,nomod][@cursor,nomod]Timeless Scroll of Summoning")
				end
				if GetItemCount("Drake Treat") >= 1 then
					EditMacro("PvPAT 3" , nil, 132165, "/stopspelltarget\n/stopspelltarget\n/use [@mouseover,exists,nodead,nomod][@cursor,nomod]Drake Treat")
				end
				pwned = pandaremixSpecial("resItem")
			elseif ((slBP == 2 and class == "WARRIOR") and IsEquippedItem("Heart of Azeroth") and not slZones[z]) then
				slBPGen = sigB..";"..hoaEq
			-- elseif (slBP == 2 and class == "WARRIOR") then 
			-- 	hoaEq = "13"
			-- 	slBPGen = sigB..";"..hoaEq
			elseif (IsEquippedItem("Heart of Azeroth") and (not slZones[z])) then
				sigA = "The Golden Banana"
				if class == "EVOKER" then
					sigA = usableWeaponEquipped
				end
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
					sigA = b("Nature's Swiftness") or ""
					if b("Primordial Wave") then
						covA = "Primordial Wave"
						sigA = "Primordial Wave"
					elseif b("Doom Winds") then
						covA = "Doom Winds"
					end
				elseif class == "MAGE" then
					covA = (b({{"Radiant Spark","",""},{"Meteor","",""},{"Glacial Spike","",""},{"Mirror Image","",""},}) or covA) 
					sigA = (b({{"Shifting Power","",""},{"Mirror Image","",""},{"Cold Snap","",""},{"Meteor","",""},}) or sigA)
				elseif class == "WARLOCK" then
					covA = (b({{"Summon Soulkeeper","",""},{"Soul Rot","",""},{"Guillotine","",""},{"Dimensional Rift","",""},}) or covA)
					if b("Inquisitor's Gaze") and playerSpec == 2 then
						covA = "Felstorm"
					else
						covA = (b("Inquisitor's Gaze","","") or covA)
					end
					sigA = (b({{"Soul Rot"},{"Dimensional Rift","",""},{"Guillotine","",""},{"Summon Soulkeeper","",""},{"Inquisitor's Gaze","",""},}) or sigA)
				elseif class == "MONK" then
					covA = (b({{"Sheilun's Gift","",""},{"Bonedust Brew","",""},{"Jadefire Stomp","",""},{"Strike of the Windlord","",""},}) or covA)
					sigA = (b({{"Weapons of Order","",""},{"Jadefire Stomp","",""},{"Bonedust Brew","",""},{"Whirling Dragon Punch","",""},{"Sheilun's Gift","",""},}) or sigA)
				elseif class == "PALADIN" then
					covA = (b({{"Blessing of Summer","",""},{"Divine Toll","",""},}) or covA)
					sigA = (b({{"Divine Toll","",""},{"Blessing of Summer","",""},}) or sigA)
				elseif class == "HUNTER" then
					covA = (b({{"Death Chakram","",""},{"Stampede","",""},}) or covA)
				elseif class == "ROGUE" then
					covA = (b({{"Flagellation","",""},{"Sepsis","",""},{"Serrated Bone Spike","",""},{"Ghostly Strike","",""},{"Echoing Reprimand","",""},{"Goremaw's Bite"},}) or covA)
					sigA = (b({{"Echoing Reprimand","",""},{"Serrated Bone Spike","",""},{"Ghostly Strike","",""},{"Sepsis","",""},{"Flagellation","",""},{"Goremaw's Bite","",""},}) or sigA)
				elseif class == "PRIEST" then
					covA = (b({{"Mindgames","",""},{"Power Word: Life","",""},}) or covA)
					sigA = (b({{"Empyreal Blaze","",""},{"Void Torrent","",""},{"Rapture","",""},}) or sigA)
				elseif class == "DEATHKNIGHT" then
					covA = (b({{"Blood Tap","",""},{"Abomination Limb","",""},{"Empower Rune Weapon","",""},}) or covA)
					sigA = (b({{"Rune Tap","",""},{"Horn of Winter","",""},{"Abomination Limb","",""},{"Empower Rune Weapon","",""},}) or sigA)
				elseif class == "WARRIOR" then
					covA = (b({{"Champion's Spear","",""},{"Odyn's Fury","",""},}) or covA)
					sigA = (b("Odyn's Fury","","") or sigA)
				elseif class == "DRUID" then
					covA = (b({{"Adaptive Swarm","",""},{"Rage of the Sleeper","",""},{"Convoke the Spirits","",""},}) or covA)
					sigA = (b({{"Astral Communion","",""},{"Convoke the Spirits","",""},{"Adaptive Swarm","",""},}) or sigA)
				elseif class == "DEMONHUNTER" then
					covA = (b({{"Fel Barrage","",""},{"Glaive Tempest","",""},{"Elysian Decree","",""},{"Soul Carver","",""},}) or covA)
					sigA = (b({{"Soul Carver","",""},{"Immolation Aura","",""},}) or sigA)
				elseif class == "EVOKER" then
					if b("Deep Breath") then
						covA = "Deep Breath"
						sigA = usableWeaponEquipped
					end
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
				hoaEq = (b({{"Gust of Wind","",""},{"Spirit Link Totem","",""},{"Far Sight","",""},}) or "Farwater Conch")
			elseif class == "MAGE" then
				hoaEq = (b({{"Mass Polymorph","",""},{"Polymorph","",""},}) or "Mage's Chewed Wand")
			elseif class == "WARLOCK" then
				hoaEq = b("Demonic Gateway") or ""
			elseif class == "MONK" then 
				hoaEq = (b({{"Song of Chi-Ji"},{"Ring of Peace","",""},}) or "")
			elseif class == "PALADIN" then 
				hoaEq = b("Divine Steed") or ""
			elseif class == "HUNTER" then 
				hoaEq = b("Misdirection") or ""
			elseif class == "ROGUE" then 
				hoaEq = "Shroud of Concealment"
			elseif class == "PRIEST" then 
				hoaEq = (b({{"Evangelism","",""},{"Mind Soothe","",""},}) or "")
			elseif class == "DEATHKNIGHT" then 
				hoaEq = (b({{"Wraith Walk","",""},{"Anti-Magic Zone","",""},}) or "")
			elseif class == "WARRIOR" then 
				hoaEq = b("Piercing Howl") or ""
			elseif class == "DRUID" then 
				hoaEq = (b({{"Ursol's Vortex","",""},{"Mass Entanglement","",""},{"Barkskin","";""}}) or "Primal Stave of Claw and Fur")
			elseif class == "DEMONHUNTER" then 
				hoaEq = "Shattered Souls"
			elseif class == "EVOKER" then 
				hoaEq = b({{"Oppressing Roar","",""},{"Obsidian Scales","",""},}) or ""
			end
	
			EditMacro("WArtifactCDs",nil,nil,"#show\n/stopspelltarget\n/stopspelltarget\n/cast "..itemBuilder("resItem")..slBPGen)
			EditMacro("WSxCAGen+§",nil,nil,"/cast [@player,mod:shift]"..sigA..";[@player][@mouseover,exists,nodead][@cursor]"..covA)
			if IsEquippedItem("Nymue's Unraveling Spindle") and IsEquippedItem("Kharnalex, The First Light") then 
				EditMacro("WSxAGen+4",nil,nil,"#showtooltip\n/castsequence reset=10 13,16")
			else
				EditMacro("WSxAGen+4",nil,nil,"#showtooltip 13\n/use [@mouseover,exists,nodead][@cursor][]13\n/use [@mouseover,exists,nodead][@cursor][]16")
			end			
			EditMacro("Wx1Trinkit",nil,nil,"#show "..hoaEq.."\n/use [nocombat,noexists]Wand of Simulated Life\n/use Attraction Sign\n/use Rallying War Banner"..pennantClass.."")

			if class == "SHAMAN" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@mouseover,help,nodead][nomod:alt]Water Walking\n/use [swimming,nomod:alt]Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")   
			elseif class == "MAGE" then 
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@mouseover,help,nodead][noswimming]Slow Fall;Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")
			elseif class == "WARLOCK" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@focus,harm,nodead,mod:alt][@mouseover,harm,nodead][harm,nodead]Banish;[@mouseover,help,nodead][]Unending Breath\n/use [mod:alt]Stylish Black Parasol")
			elseif class == "MONK" then 
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem;!Zen Flight\n/use [mod:alt]Delicate Jade Parasol\n/use Mystical Orb of Meditation")
			elseif class == "PALADIN" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";"..(b("Turn Evil","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";") or "").."[swimming]Barnacle-Encrusted Gem\n/use [nomod:alt]Seafarer's Slidewhistle\n/use [mod:alt]Weathered Purple Parasol")
			elseif class == "HUNTER" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[@mouseover,harm,nodead][harm,nodead]Scare Beast;[nopet]Call Pet 1;[swimming]Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")
			elseif class == "ROGUE" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem;Survivor's Bag of Coins\n/use [mod:alt]Weathered Purple Parasol")	
			elseif class == "PRIEST" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming,noexists,nocombat]Barnacle-Encrusted Gem;Levitate\n/use [nomod:alt]Seafarer's Slidewhistle\n/use [mod:alt]Weathered Purple Parasol")
			elseif class == "DEATHKNIGHT" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[nomod:alt]Path of Frost\n/use [swimming]Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")
			elseif class == "WARRIOR" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[nomod:alt]Heroic Leap\n/use [swimming]Barnacle-Encrusted Gem\n/use [mod:alt]Weathered Purple Parasol")
			elseif class == "DRUID" then
	 			EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";"..(b("Moonkin Form","[noform:4]",";!Flap;") or "")..(b("Wild Charge","[noform]Mount Form;[form]",";") or "").."\n/cancelform [form:1/2]\n/cancelaura Prowl\n/use [mod:alt]Weathered Purple Parasol")				
			elseif class == "DEMONHUNTER" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem\n/use Prismatic Bauble\n/use !Glide\n/use [mod:alt]Weathered Purple Parasol\n/dismount [mounted]")
			elseif class == "EVOKER" then
				EditMacro("WSxCGen+V",nil,nil,"#show "..sigA.."\n/use [mod:alt,nocombat]"..passengerMount..";[swimming]Barnacle-Encrusted Gem\n/use Prismatic Bauble\n/use !Glide\n/use [mod:alt]Weathered Purple Parasol\n/dismount [mounted]")
			end
		end

		-- consumablebuilder(bladlast
		if (event == "TRAIT_CONFIG_UPDATED" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "BAG_UPDATE_DELAYED" or event == "UNIT_PET" or event == "PLAYER_ENTERING_WORLD" or event == "LEARNED_SPELL_IN_TAB") then
			
			EditMacro("WSxBladlast",nil,nil,"#show\n/use "..consumableBuilder("bladlast",faction))
			-- #show Bloodlust, Time Warp, Netherwinds, Drums and Favorite mount - Ctrl+Shift+V
			if class == "PRIEST" then				
				EditMacro("WSxFavMount",nil,nil,"#show " ..consumableBuilder("bladlast",faction).. "\n/run C_MountJournal.SummonByID(0)\n/dismount [mounted]\n/cancelaura Flaming Hoop\n/use Celebration Firework")
			elseif class == "DRUID" then
				EditMacro("WSxFavMount",nil,nil,"#show " ..consumableBuilder("bladlast",faction).. "\n/run C_MountJournal.SummonByID(0)\n/dismount [mounted]\n/cancelaura Bear Form\n/cancelaura Cat Form\n/cancelaura Flaming Hoop\n/cancelaura Prowl\n/use Celebration Firework\n/cancelaura Stealth")
			elseif class == "MONK" then
				EditMacro("WSxFavMount",nil,nil,"#show " ..consumableBuilder("bladlast",faction).. "\n/run C_MountJournal.SummonByID(0)\n/dismount [mounted]\n/cancelaura Zen Flight\n/cancelaura Flaming Hoop\n/use Celebration Firework")
			else
				EditMacro("WSxFavMount",nil,nil,"#show " ..consumableBuilder("bladlast",faction).. "\n/run C_MountJournal.SummonByID(0)\n/dismount [mounted]\n/cancelaura Flaming Hoop\n/use Celebration Firework\n/cancelaura Stealth\n/cancelform")
			end
			if class == "HUNTER" then
				EditMacro("WSxGenR",nil,nil,"/stopspelltarget\n/use "..(b("Tar Trap","[mod:shift,@mouseover,exists,nodead][mod:shift,@cursor]",";") or "")..bPet("Master's Call","[mod:ctrl,@player][@mouseover,help,nodead,nomod][help,nodead,nomod]",";")..bPet("Fortitude of the Bear","[mod:ctrl]",";").."[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Wing Clip\n/targetenemy [noharm]")
			end
		end

		-- itembuilder, consumablebuilder
		if (event == "BAG_UPDATE_DELAYED" or event == "ZONE_CHANGED_NEW_AREA" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD" or event == "LEARNED_SPELL_IN_TAB") then							
			EditMacro("Wx3ShowPot", nil, "INV_MISC_QUESTIONMARK", nil, 1, 1)
			-- is World Shrinker usable?
			usable = C_ToyBox.IsToyUsable(109183)
			if usable == false then 
				usable = "Vrykul Drinking Horn"
				EditMacro("Wx3ShowPot",nil, nil,"#showtooltip "..consumableBuilder("potion")..consumableBuilder("potion","\n/use ","\n/use Hell-Bent Bracers\n/use "..usable.."\n/doom"))
			else 
				usable = "World Shrinker" 
				EditMacro("Wx3ShowPot",nil, nil,"#showtooltip "..consumableBuilder("potion")..consumableBuilder("potion","\n/use "..usable.."\n/use ","\n/use Hell-Bent Bracers\n/doom"))
			end
			if GetItemCount(consumableBuilder("potion")) < 1 then
				EditMacro("Wx3ShowPot", nil, 132380, "#show\n/oops", 1, 1)
			end
			EditMacro("WTonic",nil,nil,"#show [mod:shift]"..itemBuilder("fartToy",slBP)..";"..consumableBuilder("tonic").."\n/use "..itemBuilder("fartToy",slBP).."\n/use "..consumableBuilder("tonic").."\n/use Eternal Black Diamond Ring")
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
				EditMacro("WShow",nil,nil,"/use "..consumableBuilder("water","[mod:alt,nocombat]",";")..consumableBuilder("manapot","[mod:alt]",";")..((hsBuilder("HS","[mod:ctrl]",";",class, slBP, z, eLevel, playerSpec, race, playerName) or "") or "").."Healthstone\n/stopmacro [mod]"..((hsBuilder("hsToy","","",class, slBP, z, eLevel, playerSpec, race, playerName) or "") or "").."\n/run PlaySound(15160)\n/glare")
			else
				EditMacro("WShow",nil,nil,"/use "..consumableBuilder("water","[mod:alt,nocombat]",";")..consumableBuilder("manapot","[mod:alt]",";")..((hsBuilder("HS","[mod:ctrl]",";",class, slBP, z, eLevel, playerSpec, race, playerName) or "") or "").."\n/stopmacro [mod]"..((hsBuilder("hsToy","","",class, slBP, z, eLevel, playerSpec, race, playerName) or "") or "").."\n/use Healthstone\n/run PlaySound(15160)\n/cry", 1, 1)
			end  
			if class == "SHAMAN" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Ancestral Spirit;"..pwned.."\n/use [mod:ctrl]Ancestral Vision"..itemBuilder("brazier"))
			elseif class == "MAGE" then
				EditMacro("WSxGen5",nil,nil,"/stopspelltarget [@mouseover,harm,nodead][harm,nodead][exists,nodead]\n/targetenemy [noexists]\n/use "..(b("Alter Time", "[mod]!",";") or "")..(b({{"Arcane Barrage","[@mouseover,harm,nodead][harm,nodead]",";"},{"Ice Lance","[@mouseover,harm,nodead][harm,nodead]",";"},{"Fire Blast","[@mouseover,harm,nodead][harm,nodead]",";"},}) or "")..itemBuilder("broom")..(b({{"Arcane Barrage","",";"},{"Ice Lance","",";"},{"Fire Blast","",";"},}) or ""))
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;"..itemBuilder("crKnife")..pwned..""..itemBuilder("brazier"))
				EditMacro("WSxSGen+1",nil,nil,"#showtooltip Alter Time\n/run zigiTrade(\""..consumableBuilder("water").."\")")
				EditMacro("WSxSGen+2",nil,nil,"#show "..(b("Presence of Mind","[combat][harm,nodead]",";") or "")..consumableBuilder("water").."\n/use [nocombat,noexists]"..consumableBuilder("water").."\n/use Gnomish X-Ray Specs\n/stopcasting [spec:2]\n/use "..(b("Presence of Mind","[combat][harm,nodead]",";") or "").."[nocombat]Conjure Refreshment")
				EditMacro("WSxGenU",nil,nil,"#showtooltip\n/use "..consumableBuilder("managem"))
				EditMacro("WSxSGen+F",nil,nil,"#show Familiar Stone\n/cancelaura [mod:alt]Shado-Pan Geyser Gun\n/use [help,nocombat,mod:alt]B. F. F. Necklace;[nocombat,noexists,mod:alt]Gastropod Shell;[nomod:alt]"..consumableBuilder("managem").."\n/use [nomod:alt]Familiar Stone")
			elseif class == "WARLOCK" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;"..itemBuilder("crKnife")..pwned..""..itemBuilder("brazier"))
			elseif class == "MONK" then 
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Resuscitate;"..pwned.."\n/use [mod:ctrl]Reawaken"..itemBuilder("brazier"))
			elseif class == "PALADIN" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Redemption;"..pwned.."\n/use [mod:ctrl]Absolution"..itemBuilder("brazier"))
				EditMacro("WSxCAGen+F",nil,nil,(b("Blessing of Summer","/targetfriendplayer\n/use [help,nodead]",";Strength of Conviction\n/targetlasttarget") or "").."\n/stopmacro [combat,exists]"..itemBuilder("instrument",noPants))
			elseif class == "HUNTER" then
				EditMacro("WSxGen3",nil,nil,"/targetlasttarget [noexists,nocombat,nodead]\n/use "..(b("Kill Shot","[@mouseover,harm,nodead][harm,nodead]",";") or "")..((itemBuilder("flyingSkinner") or "") or "").."Imaginary Gun\n/targetenemy [noharm]\n/cleartarget [dead]"..((itemBuilder("inject",class,playerSpec) or "") or "").."\n/targetlasttarget [dead]")
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;"..itemBuilder("crKnife")..pwned..""..itemBuilder("brazier"))
			elseif class == "ROGUE" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;"..itemBuilder("crKnife")..pwned..""..itemBuilder("brazier"))
			elseif class == "PRIEST" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;[nocombat]Resurrection;"..pwned.."\n/use [mod:ctrl]Mass Resurrection"..itemBuilder("brazier"))
			elseif class == "DEATHKNIGHT" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;"..itemBuilder("crKnife")..pwned..""..itemBuilder("brazier"))
				EditMacro("WSxCAGen+F",nil,nil,"#show Lichborne"..itemBuilder("instrument",noPants))
			elseif class == "WARRIOR" then
				if playerSpec ~= 3 and b("Thunder Clap") == "Thunder Clap" then override = "Thunder Clap"
				elseif b("Bladestorm") then override = "Bladestorm"
				elseif b("Sweeping Strikes") then override = "Sweeping Strikes"
				elseif playerSpec == 3 then override = "Whirlwind"
				else override = "Slam"
				end
				EditMacro("WSxGen7",nil,nil,"/use [mod]Shield Block;"..override.."\n/use "..(b("Defensive Stance","[mod,nostance:1]!","") or "").."\n/startattack"..(itemBuilder("inject",class,playerSpec) or "") or "")
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant"..itemBuilder("glider")..";[mod]6;"..itemBuilder("crKnife")..pwned..""..itemBuilder("brazier"))
				EditMacro("WSxCAGen+F",nil,nil,"#show "..(b("Rallying Cry","[]","") or "").."\n/use [nocombat]Throbbing Blood Orb\n/stopmacro [combat,exists]"..itemBuilder("instrument",noPants))
				EditMacro("WSxGenZ",nil,nil,"/use "..(b("Defensive Stance","[mod:alt][mod:shift]!",";") or "").."[mod:shift]Shield Block;"..(b({{"Die by the Sword","",""},{"Enraged Regeneration","",""},{"Shield Wall","",""},}) or "")..(itemBuilder("inject",class,playerSpec) or "").."\n/use Stormforged Vrykul Horn\n/use [mod:alt]Gateway Control Shard")
			elseif class == "DRUID" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant\n/cancelaura Flap"..itemBuilder("glider")..";[mod]6;[nocombat]Revive;"..pwned.."\n/use [mod:ctrl]Revitalize"..itemBuilder("brazier"))
			elseif class == "DEMONHUNTER" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant\n/cancelaura Glide"..itemBuilder("glider")..";[mod]6;"..itemBuilder("crKnife")..pwned..""..itemBuilder("brazier"))
			elseif class == "EVOKER" then
				EditMacro("WRessMix",nil,nil,"/cancelaura Slow Fall\n/cancelaura Levitate\n/cancelaura Goblin Glider\n/use [mod:ctrl]Bronze Racer's Pennant\n/cancelaura Glide"..itemBuilder("glider")..";[mod]6;[nocombat]Return;"..pwned.."\n/use [mod:ctrl]Mass Return"..itemBuilder("brazier"))
			end
		end

		--grouprosterbuilder, group roster update or spec talent change or on load
		if (event == "GROUP_ROSTER_UPDATE" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD" or event == "LEARNED_SPELL_IN_TAB") then
			override = ""
			overrideModCtrl = ""
			overrideModAlt = ""
			if class == "SHAMAN" then
				EditMacro("WSxGenX",nil,nil,"/use "..(b({{"Windfury Weapon","[mod:alt]",";"},{"Earthliving Weapon","[mod:alt]",";"},}) or "").."[mod:ctrl]Astral Recall;"..(b({{"Spirit Walk","[mod:shift]",";"},{"Spiritwalker's Grace","[mod:shift]",";"},}) or "")..(b({{"Earth Shield","[@mouseover,help,nodead]["..groupRosterBuilder("tank").."][]",""},{"Lightning Shield","",""},}) or "").."\n/use Void Totem\n/use Deceptia's Smoldering Boots")
			-- elseif class == "MAGE" then 
			-- elseif class == "WARLOCK" then
			elseif class == "MONK" then 
				EditMacro("WSxGenH",nil,nil,"#show "..(b("Paralysis") or "Leg Sweep").."\n/use "..(b("Life Cocoon","[mod:shift,"..groupRosterBuilder("tank").."]",";") or "")..(b("Healing Elixir","","") or "").."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
			elseif class == "PALADIN" then
				EditMacro("WSxGenX",nil,nil,"#show\n/use "..(b({{"Retribution Aura","[mod:alt]!",";"},{"Concentration Aura","[mod:alt]!",";"},}) or "")..(b("Blessing of Freedom","[mod:shift]",";") or "")..(b({{"Barrier of Faith","[@mouseover,help,nodead]["..groupRosterBuilder("tank").."][]"},{"Divine Favor","",""},{"Hand of Divinity","",""},{"Ardent Defender","",""},{"Shield of Vengeance","",""},{"Lay on Hands","[@mouseover,help,nodead][]",""},}) or ""))
				if playerSpec == 2 and b("Blessing of Sacrifice") then 
					override = "["..groupRosterBuilder("healer").."][]Blessing of Sacrifice"
				elseif b("Blessing of Sacrifice") then 
					override = "["..groupRosterBuilder("tank").."][]Blessing of Sacrifice"
				end
				EditMacro("WSxGenC",nil,nil,"/use "..(b("Repentance","[mod:ctrl,@mouseover,harm,nodead][mod:ctrl]",";") or "")..(b({{"Blessing of Summer","[mod:shift,known:Blessing of Spring][mod:shift,known:Blessing of Winter][mod:shift,known:Blessing of Winter,@player][mod:shift,known:Blessing of Spring,"..groupRosterBuilder("tank").."]",";"},{"Blessing of Spellwarding","[mod:shift,"..groupRosterBuilder("healer").."]",";"},{"Blessing of Protection","[mod:shift,"..groupRosterBuilder("healer").."]",";"},}) or "Holy Lightsphere")..override)
			-- elseif class == "HUNTER" then
			-- elseif class == "ROGUE" then
			elseif class == "PRIEST" then
				EditMacro("WSxGenF",nil,nil,"#show "..(b({{"Void Shift","",""},{"Power Word: Life","",""},}) or "").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod,exists,nodead]Mind Vision;[mod]Farwater Conch;"..(b({{"Pain Suppression","["..groupRosterBuilder("tank").."]",";"},{"Guardian Spirit","["..groupRosterBuilder("tank").."]",";"},{"Silence","[@focus,harm,nodead]",";"},}) or "").."[help,nodead]True Love Prism;Doomsayer's Robes")
			-- elseif class == "DEATHKNIGHT" then
			elseif class == "WARRIOR" then
				EditMacro("WSxGenC",nil,nil,"#show\n/use "..(b("Intimidating Shout","[mod:ctrl]",";") or "")..(b("Intervene","[mod:shift,"..groupRosterBuilder("healer").."]",";") or "")..(b("Spell Reflection") or "").."\n/use Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
			elseif class == "DRUID" then
				EditMacro("WSxGenH",nil,nil,"#show "..(b({{"Nature's Swiftness","",""},{"Ironbark","",""},}) or "").."\n/use "..(b({{"Ironbark","["..groupRosterBuilder("tank").."]",""},{"Nature's Swiftness","",""},}) or "").."\n/use Wisp Amulet\n/stopmacro [combat][mod:ctrl]\n/run if IsMounted() or GetShapeshiftFormID() ~= nil then DoEmote(\"mountspecial\") end")
		 		EditMacro("WSxGenC",nil,nil,"/use "..(b("Innervate","[mod:shift,"..groupRosterBuilder("healer").."][mod:shift,@player]",";") or "")..(b({{"Cylclone","[@mouseover,harm,nodead,mod][mod]",";"},{"Entangling Roots","[@mouseover,harm,nodead,mod][mod]",";"},}) or "")..(b({{"Rejuvenation","[@mouseover,help,nodead][]",""},{"Frenzied Regeneration","[noform:1]Bear Form;[form:1]",""},{"Astral Communion","[noform:4]Moonkin Form;[form:4]",""},}) or "").."\n/use Totem of Spirits\n/cancelform [mod:shift,form:2]")
			-- elseif class == "DEMONHUNTER" then
			elseif class == "EVOKER" then
				EditMacro("WSxSGen+3",nil,nil,"#show\n/use "..(b({{"Blistering Scales","[@mouseover,help,nodead]["..groupRosterBuilder("tank").."][]",""},{"Stasis","",""},{"Pyre","[@mouseover,harm,nodead][]",""},}) or "Hover").."\n/targetenemy [noexists]")
				EditMacro("WSxGenC",nil,nil,"#show\n/use "..(b("Sleep Walk","[@mouseover,harm,nodead,mod:ctrl][mod:ctrl]",";") or "")..(b("Source of Magic","[mod:shift][mod:shift,"..groupRosterBuilder("healer").."]",";") or "")..(b("Reversion","[@mouseover,help,nodead][]","") or "[@mouseover,help,nodead][]Emerald Blossom").."\n/cancelaura X-Ray Specs")
			end
		end
	
		
		
		if (event == "LEARNED_SPELL_IN_TAB" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_ENTERING_WORLD") then
			if (class == "WARLOCK" or class == "DEMONHUNTER") then
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use 14\n/use [nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Fractured Necrolyte Skull;[help,dead,nocombat]Cremating Torch")
			else
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use 14\n/use [nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol")
			end
				if GetItemCount("Swapblaster") ~= 1 then
					swapblaster = ""
				end
			
			-- Main Class configuration
			-- Shaman, Raxxy
			if class == "SHAMAN" then
				EditMacro("WSxGen1",nil,nil,"#show\n/use "..(b({{"Ice Strike","[@mouseover,harm,nodead][harm,nodead]",""},{"Unleash Life","[@mouseover,help,nodead][help,nodead]",""},{"Primal Strike","[@mouseover,harm,nodead][harm,nodead]",""},}) or "")..";Xan'tish's Flute\n/targetenemy [noexists]\n/cleartarget [dead]")
				if b("Healing Stream Totem") and playerSpec ~= 2 then
					override = "Healing Stream Totem"
				elseif b("Frost Shock") then
					override = "Frost Shock"
				end
				EditMacro("WSxSGen+1",nil,nil,"#show "..(override or "Primal Strike").."\n/use [mod:alt,@party3,help,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Healing Surge\n/use Haunted War Drum")
				EditMacro("WSxGen2",nil,nil,"#show\n/use [nocombat,noexists]Raging Elemental Stone;"..(b({{"Lava Lash","",""},{"Lightning Bolt","[@mouseover,harm,nodead][]",""},}) or "").."\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use [mod:alt,@party4,help,nodead][@mouseover,help,nodead][]Healing Surge\n/cancelaura X-Ray Specs\n/use Gnomish X-Ray Specs")
				EditMacro("WSxGen3",nil,nil,"#show\n/stopspelltarget\n/startattack\n/targetenemy [noexists]\n/use [nocombat,noexists]Tadpole Cloudseeder;"..(b({{"Stormstrike","[@mouseover,harm,nodead][]",""},{"Lava Burst","[@mouseover,harm,nodead][]",""},}) or "Primal Strike").."\n/cleartarget [dead]\n/use Words of Akunda")
				EditMacro("WSxSGen+3",nil,nil,"#show Flame Shock\n/cleartarget [dead]\n/targetenemy [noexists]\n/use [@mouseover,harm,nodead,nomod:alt][nomod:alt]Flame Shock\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Flame Shock\n/targetlasttarget")
				if b("Wellspring") then override = "Wellspring" 
				elseif b("Icefury") then override = "Icefury" 
				elseif playerSpec ~= 3 and b("Lava Burst") then override = "[@mouseover,harm,nodead][]Lava Burst" 
				elseif b("Chain Heal") then override = "[@mouseover,help,nodead][]Chain Heal"
				elseif b("Sundering") then override = "Sundering"
				elseif b("Primal Strike") then override = "[@mouseover,harm,nodead][]Primal Strike" 
				end
				EditMacro("WSxGen4",nil,nil,"#show\n/use "..override.."\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,noexists,nospec:3]Smolderheart\n/startattack")
				EditMacro("WSxSGen+4",nil,nil,"#show\n/targetenemy [noexists]\n/use "..(b({{"Riptide","[@party1,help,nodead,mod:alt]",";"},{"Chain Heal","[@party1,help,nodead,mod:alt]",";"},}) or "[@party1,help,nodead,mod:alt]Healing Surge;")..(b({{"Sundering","",""},{"Downpour","",""},{"Healing Tide Totem","",""},{"Stormkeeper","",""},{"Storm Elemental","[pet:Storm Elemental]Tempest",";"},{"Fire Elemental","[pet:Fire Elemental,@mouseover,harm,nodead][pet:Fire Elemental]Meteor",";"},{"Primordial Wave","@mouseover,harm,nodead][]",""},}) or "").."\n/use [nocombat,noexists]Sen'jin Spirit Drum\n/cleartarget [dead]")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use [@party3,help,nodead,mod:alt]Riptide;"..(b({{"Ascendance","",""},{"Stormkeeper","",""},{"Wellspring","",""},{"Totemic Projection","[@cursor]",""},{"Downpour","[@cursor]",""},}) or "").."\n/targetenemy [noexists]\n/use Trawler Totem")
				EditMacro("WSxGen5",nil,nil,"/targetenemy [noexists,nomod]\n/target [@Greater Earth,mod]\n/use "..(b({{"Spirit Link Totem","[mod,@cursor]",""},{"Earth Elemental","[mod,@pet,help,nodead][mod,help,nodead]Healing Surge;[mod]","\n/use [mod]Tiny Box of Tiny Rocks\n/targetlasttarget [mod,exists]"},}) or "")..(b({{"Earth Shock","\n/use ",""},{"Healing Wave","\n/use [@mouseover,help,nodead][]",""},}) or "\n/use Lightning Bolt"))
				EditMacro("WSxSGen+5",nil,nil,"#show ".."\n/cast [nocombat,noexists]Lava Fountain\n/stopspelltarget\n/cast "..(b({{"Riptide","[@party2,help,nodead,mod:alt]",";"},{"Chain Heal","[@party2,help,nodead,mod:alt]",";"},}) or "[@party2,help,nodead,mod:alt]Healing Surge;")..(b({{"Storm Elemental","[pet:Storm Elemental]Tempest;",""},{"Fire Elemental","[pet:Fire Elemental,@mouseover,harm,nodead][pet:Fire Elemental]Meteor;",""},{"Doom Winds","",""},{"Stormkeeper","",""},{"Frost Shock","",""},{"Healing Stream Totem","",""},}) or ""))
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod:ctrl,@party4,help,nodead]Riptide;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14")
				if b("Healing Rain") then override = "[@cursor]Healing Rain" 
				elseif b("Crash Lightning") then override = "Crash Lightning" 
				elseif playerSpec ~= 3 then override = "[@mouseover,harm,nodead][]Chain Lightning" 
				else override = "[@mouseover,help,nodead]Chain Heal;[@mouseover,harm,nodead][harm,nodead]Chain Lightning;Chain Heal"
				end
				EditMacro("WSxGen6",nil,nil,"/stopspelltarget\n/targetenemy [noexists,nomod]\n/use "..(b({{"Feral Spirit","\n/use [mod:ctrl]",";"},{"Fire Elemental","\n/use [mod:ctrl]",";"},{"Storm Elemental","\n/use [mod:ctrl]",";"},{"Earth Elemental","\n/target [@Greater Earth Ele,mod:ctrl]\n/use [help,mod:ctrl,nodead]Healing Surge;[mod:ctrl]","\n/use [mod:ctrl]Tiny Box of Tiny Rocks\n/targetlasttarget [mod:ctrl]\n/use "},}) or "")..override)
				EditMacro("WSxSGen+6",nil,nil,"#show "..(b({{"Earthen Wall Totem","",""},{"Ancestral Protection Totem","",""},{"Feral Lunge","",""},}) or "").."\n/use "..(b("Chain Heal","[@mouseover,help,nodead]",";") or "")..(b("Chain Lightning","[@mouseover,harm,nodead][harm,nodead]",";") or "")..(b("Chain Heal","","") or "").."\n/use Orb of Deception\n/targetenemy [noexists]")
				EditMacro("WSxGen7",nil,nil,"/use "..(b({{"Healing Rain","[mod:shift,@player]",";"},{"Earthquake","[mod:shift,@player][@cursor]",";"},{"Windfury Totem","[mod:shift]",";"},}) or "")..(b({{"Chain Lightning","[@mouseover,harm,nodead][]",""},{"Riptide","",""},}) or "X-treme Water Blaster Display").."\n/startattack")
				EditMacro("WSxGen8",nil,nil,"#show\n/stopspelltarget\n/use "..(b({{"Liquid Magma Totem","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",";"},{"Downpour","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",";"},{"Healing Rain","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",";"},}) or "")..(b({{"Fire Nova","",""},{"Primordial Wave","[@focus,harm,nodead][]",""},}) or "Frost Shock"))
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..(b({{"Primordial Wave","",""},{"Healing Stream Totem","",""},{"Windfury Totem","",""},{"Ice Strike","",""},{"Fire Nova","",""},{"Earthliving Weapon","",""},{"Spirit Link Totem","",""},{"Tremor Totem","",""},{"Downpour","[@cursor]",""},}) or "Water Walking"))
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,spec:3,@party3,help,nodead][spec:3,@party1,help,nodead][spec:3,@targettarget,help,nodead]Purify Spirit;[mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Cleanse Spirit;[nocombat,noharm]Spirit Wand")
				EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Flame Shock;[mod:alt,spec:3,@party4,help,nodead][spec:3,@party2,help,nodead]Purify Spirit;[mod:alt,@party4,help,nodead][@party2,help,nodead]Cleanse Spirit;[nocombat,noharm]Cranky Crab;\n/cleartarget [dead]\n/stopspelltarget")
				EditMacro("WSxCSGen+4",nil,nil,"/use [mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Chain Heal")
				EditMacro("WSxCSGen+5",nil,nil,"/use [mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead][@targettarget,help,nodead]Chain Heal\n/use [spec:3]Waterspeaker's Totem")
				EditMacro("WSxGenQ",nil,nil,"/stopcasting [nomod:alt]\n/use "..(b("Hex","[mod:alt,@focus,harm,nodead]",";") or "")..(b("Tremor Totem","[mod:shift]",";") or "").."[help,nodead]Foot Ball;[nocombat,noexists]The Golden Banana;"..(b("Wind Shear","[@mouseover,harm,nodead][]","") or "").."\n/use [nocombat,spec:3]Bubble Wand\n/cancelaura Bubble Wand")
				EditMacro("WSxGenE",nil,nil,"#show [nocombat,noexists]Party Totem;"..(b("Capacitor Totem","",";") or "").."Party Totem\n/use "..(b("Capacitor Totem","[@cursor]","") or "").."\n/use Haunting Memento\n/use [nocombat,noexists]Party Totem")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(b("Capacitor Totem","[mod:alt,@player]",";") or "")..(b("Nature's Swiftness","","") or "")..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use [mod:alt,@player]Earthbind Totem;"..(b("Healing Stream Totem","","") or "").."\n/use Arena Master's War Horn\n/use Totem of Spirits\n/use [nocombat]Void-Touched Souvenir Totem")
				EditMacro("WSxGenR",nil,nil,"#show Earthbind Totem\n/stopspelltarget\n/use "..(b("Totemic Projection","[mod:ctrl,@cursor]",";") or "").."[@mouseover,exists,nodead,mod:shift][@cursor,mod:shift]Earthbind Totem;"..(b("Frost Shock","[@mouseover,harm,nodead][]",";") or "").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGenT",nil,nil,"/stopspelltarget\n/use "..(b({{"Thunderstorm","[@mouseover,exists,nodead][]",""},{"Frost Shock","[@mouseover,harm,nodead][]",""},{"Earthgrab Totem","[@mouseover,exists,nodead][@cursor]",""},}) or "[noexists,nodead]Water Walking")..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+T",nil,nil,"#show\n/stopspelltarget\n/use "..(b({{"Lightning Lasso","[@mouseover,harm,nodead][]",""},{"Totemic Projection","[mod:alt,@player][@mouseover,exists,nodead][@cursor]",""},{"Thunderstorm","[@mouseover,exists,nodead][]",""},{"Earthquake","[@cursor]",""},{"Purge","[@mouseover,harm,nodead][]",""},{"Greater Purge","[@mouseover,harm,nodead][]",""},{"Frost Shock","[@mouseover,harm,nodead][]",""},{"Wind Rush Totem","[mod:alt,@player][@mouseover,exists,nodead][@cursor]",""},}) or ""))
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/stopspelltarget\n/use "..(b({{"Wind Rush Totem","[@mouseover,exists,nodead][@cursor]",""},{"Earthgrab Totem","[@mouseover,exists,nodead][@cursor]",""},}) or ""))
				EditMacro("WSxGenU",nil,nil,"#show\n/use Reincarnation")
				EditMacro("WSxGenF",nil,nil,"#show "..(b({{"Healing Stream Totem","",""},{"Totemic Projection","",""},}) or "").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,@cursor]Far Sight;"..(b("Wind Shear","[@focus,harm,nodead]",";") or "").."Mrgrglhjorn")
				EditMacro("WSxSGen+F",nil,nil,"#show\n/use [help,nocombat,mod:alt]B.B.F. Fist;[nocombat,noexists,mod:alt]Gastropod Shell;[nocombat,noexists]Totem of Harmony\n/use "..(b({{"Stoneskin Totem","[@cursor]",""},{"Tranquil Air Totem","[@cursor]",""},{"Gust of Wind","",""},{"Spirit Walk","",""},}) or "Totem of Harmony").."\n/cancelform [mod:alt]")
				EditMacro("WSxCGen+F",nil,nil,"#show "..(b({{"Ancestral Guidance","",""},{"Totemic Projection","",""},}) or "")..(b("Ancestral Guidance","\n/use ","") or "").."\n/use "..fftpar.."\n/cancelaura Thistleleaf Disguise\n/use Bom'bay's Color-Seein' Sauce")
				EditMacro("WSxCAGen+F",nil,nil,"#show "..(b("Tremor Totem","","") or "Water Walking").."\n/run if not InCombatLockdown() then if GetSpellCooldown(198103)==0 then "..tpPants.." else "..noPants.." end end\n/use Gateway Control Shard")
				EditMacro("WSxGenG",nil,nil,"/use [mod:alt]Darkmoon Gazer;"..(b({{"Purge","[@mouseover,harm,nodead]",";"},{"Greater Purge","[@mouseover,harm,nodead]",";"},}) or "")..(b({{"Purify Spirit","[@mouseover,help,nodead][]",""},{"Cleanse Spirit","[@mouseover,help,nodead][]",""},{"Frost Shock","[@mouseover,harm,nodead][]",""},}) or "Darkmoon Gazer").."\n/targetenemy [noexists]\n/use Poison Extraction Totem")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(b({{"Purge","[@mouseover,harm,nodead][harm,nodead]",""},{"Greater Purge","[@mouseover,harm,nodead][harm,nodead]",""},{"Healing Stream Totem","",""},}) or "").."\n/use Flaming Hoop\n/targetenemy [noexists]\n/cleartarget [dead]")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(b({{"Earthen Wall Totem","[@cursor]",""},{"Ancestral Protection Totem","[@cursor]",""},{"Stoneskin Totem","[@cursor]",""},{"Tranquil Air Totem","[@cursor]",""},}) or ""))
				EditMacro("WSxCSGen+G",nil,nil,"/use "..(b({{"Purge","[@focus,harm,nodead]",";"},{"Greater Purge","[@focus,harm,nodead]",";"},}) or "")..(b({{"Purify Spirit","[@focus,help,nodead]",";"},{"Cleanse Spirit","[@focus,help,nodead]",";"},}) or "")..(b({{"Poison Cleansing Totem","",""},{"Tremor Totem","",""},{"Capacitor Totem","",""},}) or "Reincarnation").."\n/cancelaura Whole-Body Shrinka'\n/cancelaura Growing Pains\n/cancelaura Words of Akunda")
				EditMacro("WSxGenH",nil,nil,"#show\n/use "..(b({{"Totemic Recall","",""},{"Stoneskin Totem","[@cursor]",""},{"Tranquil Air Totem","[@cursor]",""},{"Hex","",""},}) or "Astral Recall").."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Flametongue Weapon;"..(b({{"Spirit Link Totem","[mod:shift,@player]",";"},{"Earthen Wall Totem","[mod:shift,@player]",";"},{"Ancestral Protection Totem","[mod:shift,@player]",";"},{"Stoneskin Totem","[mod:shift,@player]",";"},{"Tranquil Air Totem","[mod:shift,@player]",";"},}) or "")..(b("Astral Shift","[nomod]","") or "").."\n/use Whole-Body Shrinka'\n/use [mod:alt]Gateway Control Shard\n/use Moonfang's Paw")
				EditMacro("WSxGenC",nil,nil,"/use [help,nodead,nocombat]Chasing Storm".."\n/use "..(b("Hex","[@mouseover,exists,nodead,mod:ctrl][mod:ctrl]",";") or "")..(b({{"Mana Tide Totem","[mod]",";"},{"Totemic Recall","[mod]",";"},}) or "")..(b({{"Riptide","[@mouseover,help,nodead][]",""},{"Hex","",""},{"Thunderstorm","[@mouseover,exists,nodead][]",""},}) or "").."\n/use Thistleleaf Branch")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use [nocombat,noexists]Vol'Jin's Serpent Totem\n/use "..(b("Totemic Recall","") or "").."\n/click TotemFrameTotem1 RightButton\n/cry\n/cancelaura Chasing Storm\n/use [nocombat,noexists]Goren \"Log\" Roller\n/leavevehicle")
				EditMacro("WSxGenV",nil,nil,"#show "..(b("Spiritwalker's Grace") or "").."\n/use "..(b({{"Feral Lunge","[@mouseover,harm,nodead][]",""},{"Gust of Wind","",""},{"Spiritwalker's Grace","",""},{"Spirit Walk","",""},{"Ghost Wolf","[noform]",""},}) or "").."\n/use Panflute of Pandaria\n/use Croak Crock\n/cancelaura Rhan'ka's Escape Plan\n/use Desert Flute\n/use Sparklepony XL")

			-- Mage, maggi, nooniverse
			elseif class == "MAGE" then
				EditMacro("WSxGen1",nil,nil,"/targetenemy [noharm,nodead]\n/use [nocombat,noexists]Dazzling Rod\n/use "..(b({{"Ray of Frost","",""},{"Radiant Spark","[@mouseover,harm,nodead][]",""},{"Ice Lance","[@mouseover,harm,nodead][]",""},{"Phoenix Flames","[@mouseover,harm,nodead][]",""},{"Frostbolt","",""},}) or ""))
				EditMacro("WSxGen2",nil,nil,"/use "..(b({{"Arcane Blast","[harm,nodead]",";"},{"Scorch","[@mouseover,harm,nodead][harm,nodead]",";"},{"Frostbolt","[harm,nodead]",";"},}) or "").."Akazamzarak's Spare Hat\n/targetenemy [noharm]\n/cleartarget [dead]\n/use [nocombat,noexists]Kalec's Image Crystal\n/use [nocombat,noexists]Archmage Vargoth's Spare Staff")
				EditMacro("WSxGen3",nil,nil,"/use "..(b({{"Pyroblast","[@mouseover,harm,nodead][harm,nodead]",""},{"Arcane Surge","",""},{"Glacial Spike","",""},}) or "").."\n/use [spec:2]Smolderheart\n/use Dalaran Initiates' Pin\n/targetenemy [noexists]")
				EditMacro("WSxSGen+3",nil,nil,"/targetenemy [noexists]\n/use [nocombat,noexists]Archmage Vargoth's Spare Staff;"..(b({{"Nether Tempest","[nomod:alt]",""},{"Arcane Blast","[nomod:alt]",""},{"Living Bomb","[nomod:alt]","\n/use [nocombat]Brazier of Dancing Flames"},{"Icy Veins","[pet:Water Elemental,@mouseover,harm,nodead][pet:Water Elemental]Water Jet;[nomod:alt]Frostbolt;",""},{"Pyroblast","[nomod:alt]","\n/use [nocombat]Brazier of Dancing Flames\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [mod:alt]Pyroblast\n/targetlasttarget"},}) or ""))
				EditMacro("WSxGen4",nil,nil,"/use "..(b({{"Fireball","[@mouseover,harm,nodead][harm,nodead]",";"},{"Flurry","[harm,nodead]",";"},{"Arcane Missiles","[harm,nodead]",";"},}) or "").."Memory Cube\n/targetenemy [noexists]\n/cleartarget [dead]\n/stopspelltarget")
				EditMacro("WSxSGen+4",nil,nil,"#showtooltip "..(b("Touch of the Magi") or "").."\n/stopspelltarget\n/use "..(b({{"Touch of the Magi","[nomod:alt]Arcane Barrage\n/use [nomod:alt]",""},{"Comet Storm","[nomod:alt]",""},{"Ebonbolt","[nomod:alt]",""},{"Meteor","[@mouseover,exists,nodead,nomod:alt,spec:2][@cursor,nomod:alt,spec:2]",""},{"Dragon's Breath","[nomod:alt]",""},{"Frostbolt","[nomod:alt]",""},{"Fireball","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [mod:alt]","\n/targetlasttarget"},}) or ""))
				EditMacro("WSxCGen+4",nil,nil,"#show "..(b({{"Shifting Power","",""},{"Arcane Familiar","[nocombat,noexists]",""},{"Meteor","[@mouseover,exists,nodead][@cursor]",""},}) or "").."\n/use [nocombat,noexists]Faded Wizard Hat"..(b("Ice Floes","\n/use Ice Floes","") or "").."\n/use "..(b({{"Shifting Power","",""},{"Arcane Familiar","[nocombat,noexists]",""},{"Meteor","[@mouseover,exists,nodead][@cursor]",""},}) or ""))
				EditMacro("WSxSGen+5",nil,nil,"/stopspelltarget\n/targetenemy [noexists]\n/cleartarget [dead]\n/use "..(b({{"Icy Veins","[mod:alt,pet:Water Elemental,@player][@mouseover,exists,nodead,pet:Water Elemental][pet:Water Elemental,@cursor]Freeze;[@mouseover,harm,nodead][]Fire Blast;","",""},{"Evocation","",""},{"Pyroblast","[@mouseover,harm,nodead][]Fire Blast;",""},}) or ""))
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..(b({{"Icy Veins","[mod:ctrl]",""},{"Arcane Surge","[mod:ctrl]",""},{"Combustion","[mod:ctrl]",""},}) or "").."\n/use "..(b("Mirror Image","[mod:ctrl]",";") or "")..(b({{"Frozen Orb","[@cursor]",""},{"Arcane Orb","",""},{"Supernova","[@mouseover,exists,nodead][]",""},{"Dragon's Breath","",""},{"Arcane Explosion","",""},}) or ""))
				EditMacro("WSxSGen+6",nil,nil,"#show\n/use [nocombat,noexists]Mystical Frosh Hat\n/use "..(b({{"Meteor","[@player,spec:2]",""},{"Dragon's Breath","[@mouseover,exists,nodead][]",""},}) or ""))
				EditMacro("WSxGen7",nil,nil,"#show\n/stopspelltarget\n/use "..(b({{"Blizzard","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Flamestrike","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Supernova","[@mouseover,exists,nodead][]",""},{"Arcane Orb","",""},{"Ice Nova","",""},{"Arcane Explosion","",""},{"Touch of the Magi","",""},}) or ""))
				EditMacro("WSxGen8",nil,nil,"#show\n/stopspelltarget\n/use "..(b("Arcane Explosion","","") or ""))
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..(b({{"Shifting Power","",""},{"Dragon's Breath","",""},{"Meteor","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Arcane Familiar","[nocombat,noexists]",""},{"Arcane Explosion","[spec:2]",""},}) or ""))
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Remove Curse")
				EditMacro("WSxCSGen+3",nil,nil,"#show\n/use "..(b("Pyroblast","[@focus,harm,nodead]",";") or "").."[mod:alt,@party4,help,nodead][@party2,help,nodead]Remove Curse;[exists,nodead]Magical Saucer\n/targetenemy [noharm]\n/cleartarget [dead][nocombat,noharm]\n/stopspelltarget")
				EditMacro("WSxCSGen+4",nil,nil,"/use [spec:2,@focus,harm,nodead]Fireball;[mod:alt,@party3,help,nodead][@party1,help,nodead]Slow Fall;Pink Gumball\n/targetenemy [noharm]\n/cleartarget [dead][nocombat,noharm]\n/stopspelltarget\n/use [nocombat,noexists]Ogre Pinata")
				EditMacro("WSxCSGen+5",nil,nil,"#show Ice Block\n/use [mod:alt,@party4,help,nodead][@party2,help,nodead]Slow Fall\n/use [nocombat,noexists]Shado-Pan Geyser Gun\n/cancelaura [combat]Shado-Pan Geyser Gun\n/stopmacro [combat]\n/click ExtraActionButton1")
				EditMacro("WSxGenQ",nil,nil,"#show\n/stopcasting [nomod]\n/use [mod:alt,@focus,harm,nodead]Polymorph;[mod:shift]Winning Hand;[@mouseover,harm,nodead][harm,nodead]Counterspell;Nightborne Guard's Vigilance\n/use [mod:shift]Ice Block;")
				EditMacro("WSxGenE",nil,nil,"#show\n/use "..(b({{"Mass Polymorph","[mod:alt]Mass Polymorph",";"},{"Blast Wave","[mod:alt]",";"},}) or "")..(b("Frost Nova") or "").."\n/use Manastorm's Duplicator")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(b({{"Ice Floes","",""},{"Ice Nova","",""},}) or "").."\n/use [spec:2]Blazing Wings"..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use [mod:alt,@player,pet]Freeze;"..(b("Ice Nova") or ""))
				EditMacro("WSxGenR",nil,nil,"#show "..(b("Cone of Cold") or "").."\n/use "..(b("Cone of Cold","[mod:shift]",";") or "")..(b({{"Slow","",""},{"Frostbolt","",""},}) or "").."\n/targetenemy [noexists]")
				EditMacro("WSxGenT",nil,nil,"/use "..(b("Fire Blast","[@mouseover,harm,nodead][harm,nodead]",";") or "")..swapblaster.."\n/targetenemy [noexists]\n/use Titanium Seal of Dalaran\n/cleartarget [dead]\n/petattack [@mouseover,harm,nodead][]")
				EditMacro("WSxSGen+T",nil,nil,"#show\n/use "..(b("Blast Wave","","") or "Frostbolt"))
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/stopspelltarget\n/use "..(b("Ring of Frost","[mod:alt,@player][@mouseover,exists,nodead][@cursor]","") or ""))
				EditMacro("WSxGenF",nil,nil,"#show "..(b("Invisibility","[combat]","") or "")..";"..(b("Ice Block") or "").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/stopcasting [nomod]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Counterspell;Mrgrglhjorn")
				EditMacro("WSxCGen+F",nil,nil,"#show\n/use "..(b({{"Mass Invisibility","",""},{"Mass Barrier","",""},}) or ""))
				EditMacro("WSxCAGen+F",nil,nil,"#show "..(b({{"Ring of Frost","",""},{"Mirror Image","",""},}) or "").."\n/use !Blink\n/use Alter Time\n/cancelaura Alter Time")
				EditMacro("WSxGenG",nil,nil,"#show\n/targetenemy [noharm]\n/use [mod:alt]Darkmoon Gazer"..(b("Spellsteal",";[@mouseover,harm,nodead]",";") or "")..(b("Remove Curse","[@mouseover,help,nodead][help,nodead]",";") or "").."\n/use Set of Matches")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(b("Spellsteal","[@mouseover,harm,nodead][]","") or "").."\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]\n/use Poison Extraction Totem")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(b("Arcane Familiar") or ""))
				EditMacro("WSxCSGen+G",nil,nil,"#show "..(b({{"Cold Snap","",""},{"Greater Invisibility","",""},}) or "").."\n/use "..(b("Spellsteal","[@focus,harm,nodead]","") or "").."\n/use Poison Extraction Totem")
				EditMacro("WSxGenH",nil,nil,"#show "..(b("Ice Nova") or "").."\n/targetenemy [noharm]\n/use Nat's Fishing Chair\n/use Home Made Party Mask\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") else C_MountJournal.SummonByID(1727) end end")
				EditMacro("WSxGenZ",nil,nil,"#show\n/use "..(b("Arcane Familiar","[mod:alt]",";") or "")..(b("Invisibility","[nocombat]",";") or "")..(b("Ice Block","!","") or "").."\n/use [mod:alt]Gateway Control Shard")
				EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt]Conjure Refreshment;[mod:ctrl]Teleport: Hall of the Guardian;"..(b({{"Displacement","[mod:shift]",";"},{"Alter Time","[mod:shift]",";"},}) or "")..(b({{"Prismatic Barrier","",""},{"Blazing Barrier","",""},{"Ice Barrier","",""},}) or "").."\n/use [nomod,spec:1]Arcano-Shower;[nomod,spec:2]Blazing Wings")
				EditMacro("WSxGenC",nil,nil,"/use "..(b({{"Cold Snap","[mod:shift]",";"},{"Conjure Mana Gem","[mod:shift]",";"},}) or "")..(b("Mirror Image","[nomod]",";") or "").."[@mouseover,harm,nodead,mod][mod][]Polymorph\n/use "..(b("Conjure Mana Gem","[mod:shift]","") or "").."\n/cancelaura X-Ray Specs\n/ping [mod:ctrl,@mouseover,harm,nodead][mod:ctrl,harm,nodead]onmyway")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use Worn Doll\n/run PetDismiss()\n/cry")
				EditMacro("WSxGenV",nil,nil,"#show\n/cast Blink\n/dismount [mounted]\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Illusion\n/use Prismatic Bauble\n/use Choofa's Call")
			-- Warlock, vårlök
			elseif class == "WARLOCK" then
				EditMacro("WSxGen1",nil,nil,"/use "..(b("Soulstone","[@mouseover,help,dead][help,dead]",";") or "")..(b({{"Soul Fire","",""},{"Havoc","[@mouseover,harm,nodead][]",""},{"Soul Strike","[nopet]Summon Felguard;[@mouseover,harm,nodead][harm,nodead]",""},{"Summon Vilefiend","",""},{"Soul Swap","[@mouseover,harm,nodead][harm,nodead]",""},{"Drain Life","",""},{"Corruption","[@mouseover,harm,nodead][]",""},}) or "").."\n/use Copy of Daglop's Contract\n/targetenemy [noexists]\n/use Imp in a Ball\n/cancelaura Ring of Broken Promises")
				EditMacro("WSxSGen+1",nil,nil,"#showtooltip Fel Domination\n/run zigiTrade(\"Healthstone\")")
				EditMacro("WSxGen2",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use [harm,dead,nocombat]Soul Inhaler;"..(b({{"Incinerate","",""},{"Agony","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",""},{"Shadow Bolt","",""},}) or "").."\n/use Accursed Tome of the Sargerei\n/startattack\n/clearfocus [dead]\n/use Haunting Memento\n/use Verdant Throwing Sphere\n/use Totem of Spirits")
				EditMacro("WSxSGen+2",nil,nil,"/use [nomod:alt,harm,nodead]Drain Life;[nomod:alt]Healthstone\n/use [noexists,nomod:alt]Create Healthstone\n/use [nocombat,noexists]Gnomish X-Ray Specs\n/cleartarget [dead]"..(b("Unstable Affliction","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use ","\n/targetlasttarget") or ""))
				EditMacro("WSxGen3",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use [nocombat,noexists]Pocket Fel Spreader;[harm,dead]Narassin's Soul Gem;"..(b({{"Shadowburn","[@mouseover,harm,nodead][]",""},{"Call Dreadstalkers","[@mouseover,harm,nodead][]",""},{"Malefic Rapture","",""},{"Immolate","[@mouseover,harm,nodead][]",""},{"Shadow Bolt","[@mouseover,harm,nodead][]",""},}) or "").."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+3",nil,nil,"/targetenemy [noexists]\n/use "..(b({{"Doom","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",""},{"Immolate","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",""},{"Corruption","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",""},}) or "").."\n/use Totem of Spirits\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use "..(b({{"Doom","",""},{"Immolate","",""},{"Corruption","",""},}) or "").."\n/targetlasttarget")
				EditMacro("WSxGen4",nil,nil,"/use [nocombat,noexists]Crystalline Eye of Undravius;"..(b({{"Hand of Gul'dan","",""},{"Chaos Bolt","",""},{"Haunt","[@mouseover,harm,nodead][]",""},{"Unstable Affliction","[@mouseover,harm,nodead][]",""},}) or "").."\n/targetenemy [noexists]\n/cleartarget [dead]\n/cancelaura Crystalline Eye of Undravius\n/use Poison Extraction Totem")
				EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noexists]\n/use "..(b({{"Havoc","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",""},{"Unstable Affliction","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",""},{"Power Siphon","",""},{"Corruption","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",""},}) or "").."\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use "..(b({{"Agony","",""},{"Havoc","",""},{"Corruption","",""},}) or "").."\n/targetlasttarget")
				EditMacro("WSxCGen+4",nil,nil,"/use "..(b({{"Nether Portal","",""},{"Soul Fire","",""},{"Demonic Gateway","[@cursor]",""},}) or "").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGen5",nil,nil,"/use [pet:Voidwalker,mod:ctrl]Suffering;[mod:ctrl]Fel Domination;[nocombat,noexists]Fire-Eater's Vial\n/use [nopet:Voidwalker,mod:ctrl]Summon Voidwalker;"..(b({{"Demonbolt","[@mouseover,harm,nodead][]",""},{"Conflagrate","[@mouseover,harm,nodead][]",""},}) or "Shadow Bolt").."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+5",nil,nil,"/targetenemy [noexists]\n/use "..(b({{"Summon Infernal","[mod:alt,@cursor]",""},{"Grimoire: Felguard","[nomod:alt]",""},{"Bilescourge Bombers", "[@player,nomod:alt]",""},{"Demonic Strength","[pet:Felguard/Wrathguard,nomod:alt]",""},{"Channel Demonfire","[nomod:alt]",""},{"Siphon Life","[@mouseover,harm,nodead,nomod:alt][nomod:alt]",""},}) or "").."\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use "..(b({{"Demonbolt","",""},{"Siphon Life","",""},}) or "").."\n/targetlasttarget")
				EditMacro("WSxGen6",nil,nil,"/use "..(b({{"Summon Darkglare","[mod]",";"},{"Summon Demonic Tyrant","[mod]",";"},{"Summon Infernal","[mod,@cursor]",";"},}) or "")..(b({{"Seed of Corruption","[@mouseover,harm,nodead][]",""},{"Implosion","[@mouseover,harm,nodead][]",""},{"Soul Strike","[@mouseover,harm,nodead][]",""},{"Rain of Fire","[@cursor]",""},}) or "").."\n/startattack")
				EditMacro("WSxSGen+6",nil,nil,"/use "..(b({{"Rain of Fire","[@player]",";"},{"Malefic Rapture","",";"},}) or "").."[spec:2,nopet:Felguard/Wrathguard]Summon Felguard;[pet:Felguard/Wrathguard]!Felstorm;Command Demon\n/stopmacro [@pet,nodead]\n/run PetDismiss()")
				if b("Cataclysm") then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Cataclysm"
				elseif b("Bilescourge Bombers") and b("Guillotine") then override = "[@player,mod:shift][@mouseover,exists,nodead][@cursor]Bilescourge Bombers"
				elseif b("Guillotine") then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Guillotine"
				elseif b("Demonic Strength") then override = "[@mouseover,harm,nodead][]Demonic Strength"
				elseif b("Phantom Singularity") then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Phantom Singularity"
				elseif b("Vile Taint") then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Vile Taint"
				elseif playerSpec == 2 then
					override = "Felstorm"
				else
					override = "Command Demon"
				end
				EditMacro("WSxGen7",nil,nil,"#showtooltip\n/stopspelltarget\n/use "..override.."\n/targetenemy [noexists]")
				if b("Soul Rot") then override = "[@mouseover,harm,nodead][]Soul Rot"
				elseif b("Guillotine") and b("Demonic Strength") then 
						override = "[@mouseover,harm,nodead][]Demonic Strength"
				elseif b("Bilescourge Bombers") and b("Guillotine") then
						override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Guillotine"
				else 
					override = b({{"Guillotine","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Bilescourge Bombers","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Summon Soulkeeper","[mod:shift,@player][@mouseover,exists,nodead][@cursor]","",},{"Implosion","[@mouseover,harm,nodead][]Implosion",""},}) or "Subjugate Demon"
				end
				EditMacro("WSxGen8",nil,nil,"#showtooltip\n/stopspelltarget\n/use "..override)
				if b("Summon Soulkeeper") then override = "[mod:shift,@player][@mouseover,exists,nodead][@cursor]Summon Soulkeeper"
				elseif b("Inquisitor's Gaze") and playerSpec == 2 then 
					override = "Felstorm"
				else
					override = b({{"Inquisitor's Gaze","",""},{"Implosion","",""},}) or "Create Soulwell"
				end
				EditMacro("WSxGen9",nil,nil,"#showtooltip\n/stopspelltarget\n/use "..override)
				EditMacro("WSxCSGen+2",nil,nil,"/use [spec:1,@focus,harm,nodead]Unstable Affliction;[@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Singe Magic;[nocombat,noexists]Legion Invasion Simulator\n/targetenemy [noharm]\n/cleartarget [dead]")
				EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noexists]The Perfect Blossom;[spec:1,@focus,harm,nodead]Corruption;[spec:2,@focus,harm,nodead]Doom;[spec:3,@focus,harm,nodead]Immolate;[@party2,help,nodead]Singe Magic;Fel Petal;\n/targetenemy [noharm]\n/cleartarget [dead]")
				EditMacro("WSxCSGen+4",nil,nil,"/use [spec:1,@focus,harm,nodead]Agony;[spec:3,@focus,harm,nodead]Havoc\n/targetenemy [noharm]\n/cleartarget [dead]\n/use [nocombat]Micro-Artillery Controller")
				EditMacro("WSxCSGen+5",nil,nil,"/use "..(b({{"Siphon Life","[@focus,harm,nodead]",""},{"Demonbolt","[@focus,harm,nodead]",""},}) or "").."\n/cleartarget [dead]\n/use Battle Standard of Coordination\n/stopmacro [combat]\n/use S.F.E. Interceptor")
				EditMacro("WSxGenQ",nil,nil,"#show\n/stopcasting [nomod,nopet]\n/use [@focus,mod:alt,harm,nodead]Fear;[mod:shift]Demonic Circle;"..locPvPQ.."\n/use [nocombat,noexists]Vixx's Chest of Tricks\n/cancelaura Wyrmtongue Collector Disguise")
				EditMacro("WSxGenE",nil,nil,"/stopspelltarget\n/use "..(b("Shadowfury","[@mouseover,exists,nodead,nocombat,nomod][@cursor,nomod]",";") or "")..(b({{"Soulburn","",""},{"Amplify Curse","",""},}) or ""))
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(b("Shadowfury","[mod:alt,@player]",";") or "")..(b("Fel Domination") or "")..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show [nopet:Felhunter]Summon Felhunter;Spell Lock\n/use [mod:alt,@focus,harm,nodead,pet:Felhunter/Observer][@mouseover,harm,nodead,pet:Felhunter/Observer][pet:Felhunter/Observer]Spell Lock;Fel Domination\n/use [nopet:Felhunter/Observer]Summon Felhunter")
				EditMacro("WSxGenR",nil,nil,"/use [mod:ctrl]Summon Sayaad;[mod:ctrl,pet]Lesser Invisibility;"..(b("Shadowflame","[mod:shift]",";") or "")..(b("Curse of Exhaustion","[@mouseover,harm,nodead,nomod:ctrl][nomod:ctrl]","") or "").."\n/targetenemy [noexists,nomod]\n/stopmacro [nomod:ctrl][nopet]\n/target pet\n/kiss\n/targetlasttarget [exists]")
				EditMacro("WSxGenT",nil,nil,"/use [pet:Incubus/Succubus/Shivarra]Whiplash;[@mouseover,harm,nodead,pet:Felguard/Wrathguard][pet:Felguard/Wrathguard]!Pursuit;Command Demon\n/petattack [@mouseover,harm,nodead][]\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+T",nil,nil,"#show "..(b("Shadowflame","","") or "Curse of Weakness").."\n/use [@mouseover,harm,nodead][harm,nodead]Curse of Weakness"..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use [@mouseover,help][]Soulstone")
				EditMacro("WSxGenU",nil,nil,"#show [help]Soulstone;[nopet]Summon Imp;"..(b("Amplify Curse","[]",";") or "").."Soulstone\n/use "..(b("Amplify Curse","[]",";") or "").."[nopet]Summon Imp")
				EditMacro("WSxGenF",nil,nil,"#show Demonic Circle\n/focus [@mouseover,exists]mouseover\n/stopmacro [@mouseover,exists]\n/stopcasting [nomod,nopet]\n/use [mod,exists,nodead]All-Seer's Eye;[mod]Legion Communication Orb;"..locPvPF.."[noexists,nocombat]Tickle Totem")
				EditMacro("WSxSGen+F",nil,nil,"/use [mod:alt,nocombat,noexists]Gastropod Shell;[pet:Felguard/Wrathguard]Threatening Presence;[pet:Imp]Flee;[pet:Voidwalker]Suffering\n/use B. F. F. Necklace\n/petautocasttoggle [mod:alt]Legion Strike;[pet:Voidwalker]Suffering;Threatening Presence")
				EditMacro("WSxCGen+F",nil,nil,"#show "..(b("Amplify Curse","[combat]",";") or "").."Ritual of Doom\n/use [group,nocombat]Ritual of Doom"..(b("Amplify Curse",";","") or "").."\n/use Bewitching Tea Set\n/use "..fftpar.."\n/cancelaura Wyrmtongue Disguise\n/cancelaura Burning Rush\n/cancelaura Heartsbane Curse")
				EditMacro("WSxCAGen+F",nil,nil,"#show "..(b("Soulburn","","") or "")..
					--\n/run if not InCombatLockdown() then if GetSpellCooldown(111771)==0 then "..tpPants.." else "..noPants.." end end
					"\n/stopcasting\n/use "..(b("Soulburn","","") or "").."\n/use "..(b("Demonic Gateway","[@cursor]","") or "").."\n/use Gateway Control Shard")
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]Eye of Kilrogg;[@mouseover,harm,nodead,pet:Felhunter][pet:Felhunter,harm,nodead]Devour Magic;[@mouseover,exists,nodead][]Command Demon\n/stopspelltarget")
				EditMacro("WSxSGen+G",nil,nil,"/use "..(b({{"Mortal Coil","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]",""},{"Howl of Terror","",""},}) or "").."\n/use Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use [help,nodead,pet:Imp/Fel Imp][@player,pet:Imp/Fel Imp]Singe Magic;Fel Domination\n/use [nopet:Imp/Fel Imp]Summon Imp\n/use Legion Pocket Portal")
				EditMacro("WSxCSGen+G",nil,nil,"#show [mod]Create Soulwell;"..(b({{"Grimoire of Sacrifice","",";"},{"Dark Pact","",";"},}) or "").."Summon Felhunter\n/use "..(b("Grimoire of Sacrifice","[pet]",";") or "").."[nopet][combat]Summon Felhunter;Create Soulwell\n/use [nopet]Summon Felhunter")
				EditMacro("WSxGenH",nil,nil,"#show Demonic Circle: Teleport\n/run if not InCombatLockdown() then if IsMounted()then DoEmote(\"mountspecial\")end end"..(b("Soulburn","\n/use ","\n/castsequence [mod,nomounted]reset=5 Demonic Circle,Demonic Circle: Teleport\n/use [nomod,nomounted]Demonic Circle: Teleport") or ""))
				EditMacro("WSxGenZ",nil,nil,"/cast "..(b("Demonic Gateway","[mod:alt,@cursor]",";") or "")..(b("Dark Pact","[mod:shift]",";") or "").."Unending Resolve")
				EditMacro("WSxGenX",nil,nil,"/cast [mod:alt,group]Create Soulwell;[mod:alt]Create Healthstone;[mod:shift]Demonic Circle: Teleport;[mod,harm,nodead]Subjugate Demon;[mod,group]Ritual of Summoning;[mod]Unstable Portal Emitter;"..(b({{"Burning Rush","!",";"},{"Dark Pact","",";"},}) or "").."Demonic Circle: Teleport")
				EditMacro("WSxGenC",nil,nil,"/use [mod,@mouseover,harm,nodead][mod]Fear;[nopet]Summon Voidwalker;Ring of Broken Promises\n/use Smolderheart\n/use Health Funnel\n/cancelaura X-Ray Specs\n/ping [mod:ctrl,@mouseover,harm,nodead][mod:ctrl,harm,nodead]onmyway")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use Spire of Spite\n/run PetDismiss();\n/cry")
				EditMacro("WSxGenV",nil,nil,"#show\n/use "..(b("Curse of Tongues","[@mouseover,harm,nodead][harm,nodead]",";The Heartbreaker") or "").."\n/use [nomod]Panflute of Pandaria\n/use Haw'li's Hot & Spicy Chili\n/cancelaura Rhan'ka's Escape Plan\n/use Void Totem\n/targetenemy [noexists]\n/cleartarget [dead]")
				-- EditMacro("WSxCAGen+B",nil,nil,"")
				-- EditMacro("WSxCAGen+N",nil,nil,"")
			-- Monk, menk, Happyvale
			elseif class == "MONK" then
				if b("Soothing Mist") and playerSpec == 2 then override = "[@mouseover,help,nodead,nochanneling:Soothing Mist][nochanneling:Soothing Mist]Soothing Mist;[@mouseover,help,nodead][]Vivify"
				else override = "Expel Harm"
				end
				EditMacro("WSxGen1",nil,nil,"#show\n/use [nocombat,noexists]Mrgrglhjorn\n/use "..override.."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+1",nil,nil,"/use "..(b("Soothing Mist","[mod:ctrl,@party2,help,nodead,nochanneling:Soothing Mist][@party1,help,nodead,nochanneling:Soothing Mist]",";") or "").."[mod:ctrl,@party2,help,nodead][@party1,help,nodead]Vivify;Honorary Brewmaster Keg")
				EditMacro("WSxGen2",nil,nil,"#show\n/use [channeling,@mouseover,help,nodead][channeling:Soothing Mist]Vivify;[nocombat,noexists]Brewfest Keg Pony;Tiger Palm\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use "..(b("Soothing Mist","[mod:alt,@party3,nodead,nochanneling:Soothing Mist]",";") or "").."[@party3,nodead,mod:alt][@mouseover,help,nodead][]Vivify\n/use [nochanneling]Gnomish X-Ray Specs")
				EditMacro("WSxGen3",nil,nil,"/use "..(b("Enveloping Mist","[channeling,@mouseover,help,nodead][channeling:Soothing Mist]",";") or "").."[@mouseover,harm,nodead][]Touch of Death\n/use [nocombat,noexists]Mystery Keg\n/use [nocombat,noexists]Jin Warmkeg's Brew\n/targetenemy [noexists]\n/cleartarget [dead]")  
				EditMacro("WSxSGen+3",nil,nil,"/use "..(b("Soothing Mist","[mod:alt,@party4,nodead,nochanneling:Soothing Mist]",";") or "").."[@party4,nodead,mod:alt]Vivify;"..(b({{"Rushing Jade Wind","",""},{"Enveloping Mist","[@mouseover,help,nodead][]",""},}) or "Crackling Jade Lightning"))
				EditMacro("WSxGen4",nil,nil,"#show\n/use [nocombat,noexists]Brewfest Pony Keg;"..(b("Rising Sun Kick","","") or "").."\n/use Piccolo of the Flaming Fire\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxSGen+4",nil,nil,"#show\n/use [@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Renewing Mist;"..(b({{"Chi Wave","",""},{"Chi Burst","",""},{"Rushing Jade Wind","",""},}) or "Tiger Palm").."\n/stopspelltarget\n/targetenemy [noexists]")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use [mod:alt,@party3,help,nodead]Renewing Mist;Expel Harm\n/targetenemy [nocombat,noexists]")
				EditMacro("WSxGen5",nil,nil,"#show "..(b({{"Zen Meditation","[mod:ctrl]",";"},{"Thunder Focus Tea","[mod:ctrl]",";"},}) or "").."Blackout Kick\n/use [noexists,nocombat]Brewfest Banner\n/use "..(b({{"Zen Meditation","[mod:ctrl]",";"},{"Thunder Focus Tea","[mod:ctrl]",";"},}) or "").."Blackout Kick\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+5",nil,nil,"/use "..(b("Renewing Mist","[@party2,help,nodead,mod:alt]",";") or "")..(b({{"Strike of the Windlord","",""},{"Energizing Elixir","",""},{"Zen Pulse","[@mouseover,help,nodead][]",""},{"Keg Smash","",""},{"Thunder Focus Tea","",""},{"Jadefire Stomp","",""},}) or "").."\n/use Displacer Meditation Stone\n/targetenemy [noexists]")
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod:ctrl,@party4,help,nodead]Renewing Mist;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14")
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..(b({{"Storm, Earth, and Fire","[mod]",";"},{"Serenity","[mod]",";"},{"Invoke Xuen, the White Tiger","[mod]",";"},{"Invoke Yu'lon, the Jade Serpent","[mod]",";"},{"Invoke Chi-Ji, the Red Crane","[mod]",";"},{"Invoke Niuzao, the Black Ox","[mod]",";"},}) or "").."!Spinning Crane Kick\n/use Words of Akunda")
				EditMacro("WSxSGen+6",nil,nil,"/use [noexists,nocombat,spec:3]\"Purple Phantom\" Contender's Costume;"..(b({{"Fists of Fury","[@mouseover,harm,nodead][]",""},{"Essence Font","",""},{"Breath of Fire","",""},{"Black Ox Brew","",""},{"Rushing Jade Wind","",""},}) or "Kindness of Chi-Ji").."\n/targetenemy [noexists]\n/stopmacro [combat]\n/click ExtraActionButton1",1,1)
				EditMacro("WSxGen7",nil,nil,"#show\n/use "..(b({{"Exploding Keg","[mod:shift,@player][@cursor]",""},{"Whirling Dragon Punch","",""},{"Bonedust Brew","[mod:shift,@player][@cursor]",""},{"Jadefire Stomp","",""},{"Summon White Tiger Statue","[mod:shift,@player][@cursor]",""},{"Storm, Earth, and Fire","",""},{"Serenity","",""},{"Summon Jade Serpent Statue","[@cursor]",""},{"Rushing Jade Wind","",""},}) or "!Spinning Crane Kick"))
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..(b({{"Summon White Tiger Statue","[mod:shift,@player][@cursor]",""},{"Weapons of Order","",""},{"Refreshing Jade Wind","",""},{"Summon Jade Serpent Statue","[mod:shift,@player][@cursor]",""},{"Jadefire Stomp","",""},{"Bonedust Brew","",""},{"Thunder Focus Tea","",""},{"Rushing Jade Wind","",""},{"Invoke Xuen, the White Tiger","",""},{"Storm, Earth, and Fire","",""},{"Serenity","",""},}) or "!Spinning Crane Kick"))
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..(b({{"Bonedust Brew","[mod:shift,@player][@cursor]",""},{"Invoke Xuen, the White Tiger","",""},{"Storm, Earth, and Fire","",""},{"Serenity","",""},{"Sheilun's Gift","",""},{"Revival","",""},{"Restoral","",""},{"Weapons of Order","",""},{"Invoke Niuzao, the Black Ox","",""},}) or "Haw'li's Hot & Spicy Chili"))
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Detox")
				EditMacro("WSxCSGen+3",nil,nil,"/use [mod:alt,@party4,help,nodead][@party2,help,nodead]Detox;Mulled Alterac Brandy\n/run if not InCombatLockdown() then local j,p,_=C_PetJournal _,p=j.FindPetIDByName(\"Alterac Brew-Pup\") if p and j.GetSummonedPetGUID()~=p then j.SummonPetByGUID(p) end end")
				EditMacro("WSxCSGen+4",nil,nil,"/use "..(b("Enveloping Mist","[mod:alt,@party3,help,nodead,nochanneling:Soothing Mist][@party1,help,nodead,nochanneling:Soothing Mist]Soothing Mist;[mod:alt,@party3,help,nodead][@party1,help,nodead]","") or "").."\n/use [nocombat,noexists]Totem of Harmony")
				EditMacro("WSxCSGen+5",nil,nil,"/use "..(b("Enveloping Mist","[mod:alt,@party4,help,nodead,nochanneling:Soothing Mist][@party2,nodead,nochanneling:Soothing Mist]Soothing Mist;[mod:alt,@party4,help,nodead][@party2,help,nodead]","") or "").."\n/use [nocombat,noexists]Pandaren Brewpack\n/cancelaura Pandaren Brewpack")
				EditMacro("WSxGenQ",nil,nil,"#show\n/use "..(b("Transcendence","[mod:shift]",";") or "")..(b("Spear Hand Strike","[@mouseover,harm,nodead,nomod][harm,nodead,nomod]",";") or "")..(b("Paralysis","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]","") or "").."\n/use [mod:shift]Celestial Defender's Medallion;The Golden Banana")
				EditMacro("WSxGenE",nil,nil,"#show "..(b({{"Clash","[@mouseover,harm,nodead][]",""},{"Flying Serpent Kick","",""},{"Soothing Mist","[@mouseover,help,nodead][]",""},{"Song of Chi-Ji","",""},{"Ring of Peace","",""},}) or "").."\n/use Prismatic Bauble\n/use [mod:alt]Leg Sweep;"..(b({{"Flying Serpent Kick","",""},{"Soothing Mist","[@mouseover,help,nodead][]",""},{"Song of Chi-Ji","",""},{"Ring of Peace","",""},{"Clash","[@mouseover,harm,nodead][]",""},}) or "").."\n/targetenemy [noexists]")
				EditMacro("WSxCGen+E",nil,nil,"#show Roll\n/use Expel Harm"..oOtas..covToys.."\n/use A Collection Of Me")
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..(b("Ring of Peace","[mod:alt,@player]",";") or "")..(b({{"Song of Chi-Ji","",""},{"Clash","[@mouseover,harm,nodead][]",""},{"Summon Black Ox Statue","\n/target Black Ox\n/use [@cursor,nomod:alt]","\n/use [help,nodead]Provoke\n/targetlasttarget"},}) or "").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGenR",nil,nil,"#show\n/use "..(b({{"Ring of Peace","[mod:shift,@cursor]",";"},{"Song of Chi-Ji","[mod:shift]",";"},}) or "")..(b("Tiger's Lust","[mod:ctrl,@player][@mouseover,help,nodead][help,nodead]",";") or "")..(b("Disable","[]",";") or "").."[@mouseover,harm,nodead][]Crackling Jade Lightning")
				EditMacro("WSxGenT",nil,nil,"#show "..(b({{"Revival","",""},{"Restoral","",""},{"Black Ox Brew","",""},{"Summon Jade Serpent Statue","",""},{"Summon Black Ox Statue","",""},{"Mystic Touch","",""},}) or "Crackling Jade Lightning").."\n/use [@mouseover,harm,nodead][harm,nodead]Crackling Jade Lightning"..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+T",nil,nil,"#show\n/targetenemy [noexists]\n/cleartarget [dead]\n/use Provoke")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..(b("Summon Black Ox Statue","\n/target Black Ox\n/use [mod:alt,@player][@cursor]","\n/use [help,nodead]Provoke\n/targetlasttarget") or "")..(b("Summon Jade Serpent Statue","[mod:alt,@player][@cursor]",";") or "")..(b("Summon White Tiger Statue","[mod:alt,@player][@cursor]",";") or "").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..(b("Tiger's Lust","","") or "Roll"))
				override = "Crackling Jade Lightning"
				if b("Transcendence") then override = "Transcendence: Transfer" end
				EditMacro("WSxGenF",nil,nil,"#show "..override.."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;"..(b({{"Spear Hand Strike","[@focus,harm,nodead]",""},{"Paralysis","[@focus,harm,nodead]",""},}) or "").."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+F",nil,nil,"/use [help,nocombat,mod:alt]B. B. F. Fist;[nocombat,noexists,mod:alt]Gastropod Shell;"..(b({{"Dampen Harm","",""},{"Diffuse Magic","",""},{"Jadefire Stomp","",""},}) or "Leg Sweep").."\n/use [nocombat]Mulled Alterac Brandy\n/cancelaura [mod]Purple Phantom")
				EditMacro("WSxCGen+F",nil,nil,"#show "..(b({{"Touch of Karma","",""},{"Mana Tea","",""},{"Zen Meditation","",""},{"Zen Pilgrimage","",""},}) or "Fortitude of Niuzao").."\n/use "..(b({{"Touch of Karma","",""},{"Revival","",""},{"Restoral","",""},{"Zen Meditation","",""},}) or "").."\n/cancelaura Celestial Defender")
				EditMacro("WSxCAGen+F",nil,nil,"#show "..(b("Leg Sweep","[combat][exists,nodead]",";") or "").."Silversage Incense\n/targetfriendplayer\n/use [help,nodead]Tiger's Lust;Silversage Incense\n/targetlasttarget")
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt,nomounted,nocombat,noexists]Darkmoon Gazer;[mod:alt]Nimble Brew;"..(b("Detox","[@mouseover,help,nodead][]","") or "Totem of Harmony"))
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(b({{"Diffuse Magic","",""},{"Dampen Harm","",""},}) or "").."\n/use Pandaren Scarecrow\n/use [noexists,nocombat]Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(b("Summon White Tiger Statue","[mod:alt,@player][@cursor]",";") or "")..(b("Summon Black Ox Statue","\n/target Black Ox\n/use [mod:alt,@player][@cursor]","\n/use [help,nodead]Provoke\n/targetlasttarget") or "")..(b("Summon Jade Serpent Statue","[mod:alt,@player][@cursor]",";") or "").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxCSGen+G",nil,nil,"#show "..(b("Transcendence","","") or "Tiger Palm").."\n/use [@focus,help,nodead]Detox\n/cancelaura Blessing of Protection\n/cancelaura Words of Akunda")
				EditMacro("WSxGenZ",nil,nil,"#show "..(b("Fortifying Brew") or "").."\n/use [mod:alt]Gateway Control Shard;"..(b({{"Healing Elixir","[nomod]",";"},{"Dampen Harm","[nomod]",";"},}) or "")..(b({{"Fortifying Brew","[mod:shift][nomod]",";"},{"Diffuse Magic","[mod:shift][nomod]",""},}) or "").."\n/use Lao Chin's Last Mug")
				EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt]Tumblerun Brew;[mod:ctrl]Zen Pilgrimage;[mod:shift]Transcendence: Transfer;"..(b({{"Celestial Brew","",""},{"Touch of Karma","[@mouseover,harm,nodead][nodead]",""},{"Life Cocoon","[@mouseover,help,nodead][nodead]",""},}) or "Cherry Blossom Trail"))
				EditMacro("WSxGenC",nil,nil,"#show\n/use "..(b({{"Mana Tea","[mod:shift]",";"},{"Black Ox Brew","[mod:shift]",";"},}) or "")..(b({{"Purifying Brew","[nomod]",";"},{"Renewing Mist","[@mouseover,help,nodead,nomod][nomod]",";"},{"Soothing Mist","[@mouseover,help,nodead,nomod][nomod]",";"},}) or "[nomod]Essence of Yu'lon")..(b("Paralysis","[mod,@mouseover,harm,nodead][mod][@mouseover,harm,nodead][]",";") or "").."\n/cancelaura X-Ray Specs")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/click TotemFrameTotem1 RightButton\n/run PetDismiss()\n/use [noexists,nocombat]Turnip Punching Bag")
				EditMacro("WSxGenV",nil,nil,"#show\n/cast Roll\n/use Cherry Blossom Trail\n/use Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Ruthers' Harness\n/use Prismatic Bauble")
			-- Paladin, bvk, palajong
			elseif class == "PALADIN" then
				EditMacro("WSxGen1",nil,nil,"/use "..(b("Intercession","[@mouseover,help,dead][help,dead]",";") or "")..(b("Holy Shock","[@mouseover,exists,nodead][exists,nodead]",";") or "").."!Devotion Aura\n/use Pretty Draenor Pearl\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+1",nil,nil,"#show "..(b("Blessing of Protection") or "").."\n/use [mod:alt,@party3,help,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Flash of Light\n/use Vindicator's Armor Polish Kit")
				EditMacro("WSxGen2",nil,nil,"#show\n/use "..(b("Blessing of Summer","[@mouseover,help,nodead][help,nodead]",";") or "")..(b("Crusader Strike","[known:404542,@mouseover,harm,nodead][known:404542]Judgment;","") or "").."\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]\n/cancelaura X-Ray Specs")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use [@party4,help,nodead,mod:alt][@mouseover,help,nodead][]Flash of Light\n/use Gnomish X-Ray Specs")
				EditMacro("WSxGen3",nil,nil,"/use "..(b("Light of the Martyr","[@mouseover,help,nodead][help,nodead]",";") or "")..(b("Hammer of Wrath","[@mouseover,harm,nodead][harm,nodead]",";") or "")..(b("Contemplation") or "Holy Lightsphere").."\n/targetenemy [noexists]\n/stopspelltarget")
				EditMacro("WSxSGen+3",nil,nil,"/use "..(b({{"Daybreak","",""},{"Execution Sentence","",""},{"Consecration","",""},}) or "").."\n/targetenemy [noexists]\n/use Soul Evacuation Crystal")
				EditMacro("WSxGen4",nil,nil,"/use [spec:2,help,nodead,nocombat]Dalaran Disc;[help,nodead,nocombat]Holy Lightsphere;"..(b({{"Avenger's Shield","[@mouseover,harm,nodead][]",""},{"Blade of Justice","",""},{"Judgment","",""},}) or "").."\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
				EditMacro("WSxSGen+4",nil,nil,"#show\n/stopspelltarget\n/use "..(b("Holy Shock","[@focus,help,nodead,mod:alt][@party1,nodead,mod:alt]",";") or "")..(b({{"Moment of Glory","",""},{"Final Reckoning","[@mouseover,exists,nodead][@cursor]",""},{"Tyr's Deliverance","[@mouseover,help,nodead][]",""},}) or "Judgment").."\n/targetenemy [noexists]")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..(b("Holy Shock","[@party3,help,nodead,mod:alt]",";") or "")..(b({{"Beacon of Faith","[@mouseover,help,nodead][]",""},{"Beacon of Light","[@mouseover,help,nodead][]",""},}) or "!Devotion Aura").."\n/startattack [combat]")
				EditMacro("WSxGen5",nil,nil,"/use "..(b({{"Ardent Defender","[mod:ctrl]",";"},{"Aura Mastery","[mod:ctrl]",";"},}) or "")..(b({{"Templar's Verdict","",""},{"Holy Light","[@mouseover,help,nodead][]",""},}) or "[spec:2,nocombat,noexists]Barrier Generator;[spec:2]Shield of the Righteous").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+5",nil,nil,"#show "..(b({{"Divine Favor","",""},{"Hand of Divinity","",""},}) or "").."\n/use "..(b({{"Holy Shock","[@party2,help,nodead,mod:alt][@player]",""},{"Bastion of Light","",""},{"Consecration","",""},{"Judgment","",""},}) or "").."\n/use [nocombat,noexists]Light in the Darkness")
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod:ctrl,@party4,help,nodead]Holy Shock;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14")
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..(b("Avenging Wrath","[mod:ctrl]",";") or "")..(b("Divine Storm","","") or "Shield of the Righteous").."\n/use [mod:ctrl] 19\n/targetenemy [noexists]")
				EditMacro("WSxSGen+6",nil,nil,"#show\n/use "..(b({{"Final Reckoning","[@player]",""},{"Eye of Tyr","",""},{"Light of Dawn","",""},{"Consecration","",""},}) or ""))
				EditMacro("WSxGen7",nil,nil,"#show\n/stopspelltarget\n/use "..(b("Divine Toll","[mod,@player]",";") or "")..(b({{"Wake of Ashes","",""},{"Consecration","",""},}) or "").."\n/targetenemy [noexists]")
				EditMacro("WSxGen8",nil,nil,"#show "..(b({{"Holy Prism","",""},{"Light's Hammer","",""},}) or "Shield of the Righteous").."\n/stopspelltarget\n/use "..(b({{"Holy Prism","[mod,@player][@mouseover,exists,nodead][exists,nodead]",""},{"Light's Hammer","[mod,@player][@mouseover,exists,nodead][@cursor]",""},}) or "Shield of the Righteous"))
				if covA == "Divine Toll" then
					override = b({{"Blessing of Summer","",""},{"Consecration","",""},}) or ""
					EditMacro("WSxGen9",nil,nil,"#show\n/use "..override)
				else
					override = b({{"Divine Toll","[@mouseover,exists,nodead][]",""},{"Consecration","",""},}) or ""
					EditMacro("WSxGen9",nil,nil,"#show\n/use "..override)
				end
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,spec:1,@party3,help,nodead][spec:1,@party1,help,nodead][spec:1,@targettarget,help,nodead]Cleanse;"..(b("Cleanse Toxins","[mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]","") or ""))
				EditMacro("WSxCSGen+3",nil,nil,"/use [mod:alt,spec:1,@party4,help,nodead][spec:1,@party2,help,nodead]Cleanse;"..(b("Cleanse Toxins","[mod:alt,@party4,help,nodead][@party2,help,nodead]","") or "").."\n/use [nocombat,noharm]Forgotten Feather")
				EditMacro("WSxCSGen+4",nil,nil,"/use [mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Word of Glory")
				EditMacro("WSxCSGen+5",nil,nil,"/use [mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]Word of Glory")
				EditMacro("WSxGenQ",nil,nil,"/use "..(b("Repentance","[mod:alt,@focus,harm,nodead]",";") or "").."[mod:shift]Divine Shield;"..(b({{"Rebuke","[@mouseover,harm,nodead][]",";"},{"Hammer of Justice","[@mouseover,harm,nodead][]",";"},}) or ""))
				EditMacro("WSxGenE",nil,nil,"#show\n/use "..(b({{"Divine Favor","[mod:alt]",";"},{"Hand of Divinity","[mod:alt]",";"},}) or "").."[@mouseover,help,nodead][]Word of Glory")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use [@mouseover,help,nodead][]Lay on Hands\n/use [help,nodead]Apexis Focusing Shard\n/stopspelltarget"..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..(b({{"Repentance","",""},{"Blinding Light","",""},}) or "Hammer of Justice"))
				EditMacro("WSxGenR",nil,nil,(b("Aura Mastery","#show ","\n") or "").."/use "..(b("Divine Steed","[mod:ctrl]",";") or "")..(b("Blessing of Freedom","[@mouseover,help,nodead][help,nodead]",";") or "")..(b("Avenger's Shield","[@mouseover,harm,nodead][]","") or "Judgment").."\n/use [mod:ctrl]Prismatic Bauble")
				EditMacro("WSxGenT",nil,nil,"/use "..(b("Turn Evil","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";") or "")..swapblaster.."\n/use Titanium Seal of Dalaran\n/use \n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat]Wayfarer's Bonfire")
				EditMacro("WSxSGen+T",nil,nil,"#show\n/use Hand of Reckoning")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..(b("Bestow Faith","[mod:alt,@party2,nodead]",";") or "").."[@party4,help,nodead]Word of Glory")
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..(b({{"Repentance","",""},{"Blinding Light","",""},}) or "Hammer of Justice"))
				EditMacro("WSxGenF",nil,nil,"#show "..(b("Blessing of Freedom") or "").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;"..(b("Rebuke","[@focus,harm,nodead]",";") or "").."[exists,nodead]Apexis Focusing Shard")
				EditMacro("WSxSGen+F",nil,nil,"#show\n/use "..(b({{"Divine Favor","[nomod:alt]",";"},{"Hand of Divinity","[nomod:alt]",";"},{"Avenger's Shield","[nomod:alt,@focus,harm,nodead]",";"},}) or "").."[help,nocombat]B. F. F. Necklace;[nocombat,noexists]Gastropod Shell"..(b("Contemplation",";","") or ";Holy Lightsphere)"))
				EditMacro("WSxCGen+F",nil,nil,"#show\n/use Sense Undead")
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]Darkmoon Gazer"..(b({{"Cleanse Toxins",";[@mouseover,help,nodead][]",""},{"Cleanse",";[@mouseover,help,nodead][]",""},}) or ""))
			    EditMacro("WSxSGen+G",nil,nil,"#show\n/use [mod:alt,@focus,harm,nodead][]Hammer of Justice\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]")
				EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(b("Bestow Faith","[mod:alt,@party1,nodead]",";") or "").."[@party3,help,nodead]Word of Glory;")
				EditMacro("WSxCSGen+G",nil,nil,"#show Divine Shield\n/use [@focus,help,nodead]Cleanse\n/cancelaura Divine Shield\n/cancelaura Blessing of Protection")
				EditMacro("WSxGenH",nil,nil,"#show Intercession\n/use [nomounted]Darkmoon Gazer\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenZ",nil,nil,"/use [mod:alt]!Devotion Aura;"..(b("Blessing of Protection","[@mouseover,help,nodead,mod:shift][mod:shift]",";") or "")..(b("Blessing of Sacrifice","[@mouseover,help,nodead][help,nodead]",";") or "")..(b({{"Divine Protection","",""},{"Guardian of Ancient Kings","",""},}) or "Divine Shield").."\n/use [mod:alt]Gateway Control Shard")
				EditMacro("WSxAGen+C",nil,nil,"#show [mod]Sylvanas' Music Box;Lay on Hands\n/use !Concentration Aura\n/use Sylvanas' Music Box")
				EditMacro("WSxGenV",nil,nil,"#show\n/use "..(b({{"Beacon of Light","[@mouseover,help,nodead][]",""},{"Divine Steed","",""},}) or "").."\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use [nospec:1]Prismatic Bauble")
				EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local B=UnitName(\"target\") EditMacro(\"WSxCGen+G\",nil,nil,\"/use [@\"..B..\",known:Blessing of Summer]Blessing of Summer\\n/stopspelltarget\", nil)print(\"BoS set to : \"..B)else print(\"Nope!\")end")
				EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxCGen+T\",nil,nil,\"/use [@\"..N..\",known:Blessing of Autumn]Blessing of Summer\\n/stopspelltarget\", nil)print(\"BoA set to : \"..N)else print(\"Nööp!\")end")	
			-- Hunter, hanter 
			elseif class == "HUNTER" then
				EditMacro("WSxGen1",nil,nil,"/use [known:127933,nocombat,noexists]Fireworks;[help,nodead]Corbyn's Beacon;[spec:1]Arcane Shot;Steady Shot\n/targetenemy [noexists]\n/equipset [noequipped:Bows/Crossbows/Guns]DoubleGate\n/use [nocombat,noexists]Mrgrglhjorn")
				EditMacro("WSxSGen+1",nil,nil,"#show Aspect of the Cheetah\n/use [mod:ctrl,@party2,help,nodead][mod:shift,@pet][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Spirit Mend\n/use [noexists,nocombat]Whitewater Carp\n/targetexact Talua")
				EditMacro("WSxGen2",nil,nil,"/use "..(b("Misdirection","[@mouseover,help,nodead][help,nodead]",";") or "")..(b({{"Barbed Shot","[@mouseover,harm,nodead][harm,nodead]",";"},{"Rapid Fire","[@mouseover,harm,nodead][harm,nodead]",";"},{"Serpent Sting","[@mouseover,harm,nodead][harm,nodead]",";"},{"Harpoon","[@mouseover,harm,nodead][harm,nodead]",";"},{"Barrage","[@mouseover,harm,nodead,known:265895][harm,nodead,known:265895]",";"},{"Explosive Shot","[@mouseover,harm,nodead][harm,nodead]",";"},}) or "").."[harm,dead]Fetch;Corbyn's Beacon\n/targetlasttarget [noharm,nodead,nocombat]\n/targetenemy [noharm]")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use [spec:1,pet,nopet:Spirit Beast][spec:3,pet]Dismiss Pet;[nopet]Call Pet 2;[@mouseover,help,nodead,pet:Spirit Beast][pet:Spirit Beast,help,nodead][pet:Spirit Beast,@player]Spirit Mend;[spec:3]Arcane Shot;Dismiss Pet\n/use Totem of Spirits")
				EditMacro("WSxSGen+3",nil,nil,"/startattack\n/use "..(b({{"Wildfire Bomb","[@mouseover,harm,nodead,nomod:alt][nomod:alt]","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [mod:alt]Wildfire Bomb\n/targetlasttarget"},{"A Murder of Crows","",""},{"Bloodshed","",""},{"Serpent Sting","",""},{"Stampede","",""},{"Death Chakram","",""},{"Dire Beast","",""},{"Wailing Arrow","",""},}) or "Hunter's Call"))
				EditMacro("WSxGen4",nil,nil,"#show\n/use [harm,dead]Gin-Ji Knife Set;[help,nodead]Dalaran Disc;"..(b({{"Aimed Shot","[harm,nodead]",";"},{"Kill Command","[@mouseover,harm,nodead][harm,nodead]",";"},}) or "").."Puntable Marmot\n/target Puntable Marmot\n/targetenemy [noexists]\n/startattack [harm,combat]\n/cleartarget [dead]\n/use Squeaky Bat")
				if (playerName == "Stabbin" and class == "HUNTER" and race == "Goblin") then
					EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noharm]\n/cleartarget [dead]\n/use "..(b({{"Flanking Strike","[nomod:alt]",""},{"Steel Trap","[@cursor,nomod:alt]",""},{"Dire Beast","",""},{"Wailing Arrow","",""},{"Chimaera Shot","",""},{"Serpent Sting","[nomod:alt]",""},{"Misdirection","[nomod:alt]",""},{"Kill Command","[nomod:alt]","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [mod:alt]Kill Command\n/targetlasttarget"},}) or ""))
				else
					EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noharm]\n/cleartarget [dead]\n/use [nocombat,noexists]Owl Post;"..(b({{"Flanking Strike","[nomod:alt]",""},{"Steel Trap","[@cursor,nomod:alt]",""},{"Dire Beast","",""},{"Wailing Arrow","",""},{"Chimaera Shot","",""},{"Serpent Sting","[nomod:alt]",""},{"Misdirection","[nomod:alt]",""},{"Kill Command","[nomod:alt]","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use [mod:alt]Kill Command\n/targetlasttarget"},}) or ""))
				end
				EditMacro("WSxCGen+4",nil,nil,"/stopspelltarget\n/cast "..(b({{"Call of the Wild","",""},{"Salvo","",""},{"Fury of the Eagle","",""},{"Spearhead","",""},{"Death Chakram","",""},{"Stampede","",""},{"Barrage","",""},{"Eyes of the Beast","",""},}) or "Hunter's Call"))
				EditMacro("WSxGen5",nil,nil,"/use [mod]Exhilaration\n/use [mod]Fortitude of the Bear;[help,nodead]Silver-Plated Turkey Shooter;"..(b("Raptor Strike","[equipped:Two-Hand]",";") or "").."[spec:1]Steady Shot;Arcane Shot\n/use [mod]Skoller's Bag of Squirrel Treats\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use [nocombat,noexists]Pandaren Scarecrow;Hunter's Mark\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGen6",nil,nil,"/stopspelltarget\n/use "..(b({{"Bestial Wrath","[mod]",";"},{"Trueshot","[mod]",";"},{"Coordinated Assault","[mod]",";"},}) or "").."[nocombat,noexists]Twiddle Twirler: Sentinel's Glaive;"..(b({{"Carve","",""},{"Butchery","",""},{"Multi-Shot","[@mouseover,harm,nodead][]",""},{"Steel Trap","[@mouseover,exists,nodead][@cursor]",""},}) or "").."\n/startattack\n/equipset [noequipped:Two-Hand,spec:3]Menkify!")
				EditMacro("WSxSGen+6",nil,nil,"#show\n/use [nocombat,noexists]Laser Pointer\n/use "..(b({{"Steel Trap","[@player]",""},{"Aspect of the Wild","",""},{"Aspect of the Eagle","",""},{"Stampede","",""},{"Death Chakram","",""},{"A Murder of Crows","",""},{"Bloodshed","",""},{"Rapid Fire","",""},{"Carve","","Carve"},{"Butchery","",""},}) or "Laser Pointer"))
				EditMacro("WSxGen7",nil,nil,"#showtooltip "..(b("Volley","[mod:shift,@player]",";") or "")..(b({{"Aspect of the Wild","",""},{"Aspect of the Eagle","",""},{"Barrage","",""},{"Explosive Shot","",""},{"Stampede","",""},{"Death Chakram","",""},{"Rapid Fire","",""},}) or "").."\n/use Champion's Salute\n/use Words of Akunda\n/cancelaura Chasing Storm\n/use Chasing Storm\n/use "..(b("Volley","[mod:shift,@player]",";") or "")..(b({{"Aspect of the Wild","",""},{"Aspect of the Eagle","",""},{"Barrage","",""},{"Explosive Shot","",""},{"Stampede","",""},{"Death Chakram","",""},{"Rapid Fire","",""},}) or ""))
				EditMacro("WSxGen8",nil,nil,"#show "..(b({{"Aspect of the Eagle","",""},{"Volley","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Wailing Arrow","",""},{"Stampede","",""},{"Death Chakram","",""},}) or "Hunter's Call").."\n/stopspelltarget\n/use "..(b("Salvo","","\n/use ") or "")..(b({{"Aspect of the Eagle","",""},{"Volley","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Wailing Arrow","",""},{"Stampede","",""},{"Death Chakram","",""},}) or "Hunter's Call"))
				EditMacro("WSxGen9",nil,nil,"#show\n/use [mod:shift]Command Pet"..(b({{"Sentinel Owl",";",""},{"Aspect of the Wild",";",""},{"Kill Command",";",""},}) or ";Hunter's Call"))
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Misdirection")
				EditMacro("WSxCSGen+3",nil,nil,"/use [mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]Misdirection;[nocombat,noharm]Cranky Crab")
				EditMacro("WSxCSGen+4",nil,nil,"/use [nospec:3,nomounted]Safari Hat;[nomounted]Gnomish X-Ray Specs\n/run ZigiHunterTrack(not IsAltKeyDown())")
				EditMacro("WSxCSGen+5",nil,nil,"/run local c,arr = C_Minimap,{12,11,10,9,8,6,5,4,7,1} for _,v in pairs(arr) do local name, _, active = c.GetTrackingInfo(v) if (name and active ~= true) then active = true c.SetTracking(v,true) return active end end\n/use Overtuned Corgi Goggles")
				EditMacro("WSxGenQ",nil,nil,"/use [mod:alt,@player]Freezing Trap;[mod:shift]!Aspect of the Turtle;"..(b({{"Muzzle","[@mouseover,harm,nodead][harm,nodead]",";"},{"Counter Shot","[@mouseover,harm,nodead][harm,nodead]",";"},{"Harpoon","[@mouseover,harm,nodead][harm,nodead]",";"}}) or "").."The Golden Banana\n/use Angler's Fishing Spear")
				EditMacro("WSxGenE",nil,nil,"/targetenemy [noharm]\n/stopspelltarget\n/use [mod:alt,@mouseover,exists,nodead][mod:alt,@cursor]Flare;"..(b({{"Bursting Shot","",";"},{"Harpoon","[@mouseover,harm,nodead][harm,nodead]",";"},{"Intimidation","[@mouseover,harm,nodead][harm,nodead]",";"},{"Binding Shot","[@mouseover,exists,nodead][@cursor]",";"},{"Kill Command","[@mouseover,exists,nodead][@cursor]",";"},}) or "").."[nocombat]Party Totem\n/cleartarget [dead]\n/equipset [noequipped:Two-Hand,spec:3,nomod]Menkify!")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(b({{"Binding Shot","[mod:alt,@player]",";"},{"Scatter Shot","[mod:alt,@focus,harm,nodead]",";"},}) or "")..(b("Misdirection","[@mouseover,help,nodead][help,nodead][@focus,help,nodead][pet,@pet]","") or "")..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"/stopspelltarget\n/use "..(b("Tar Trap","[mod:alt,@player]",";") or "")..(b({{"Binding Shot","[@mouseover,exists,nodead][@cursor]",""},{"Scatter Shot","",""},}) or "[@player]Flare").."\n/use [nocombat,noexists]Goblin Fishing Bomb\n/use Bloodmane Charm")
				EditMacro("WSxGenT",nil,nil,"#show Feign Death\n/use [@mouseover,harm,nodead][harm,nodead]Hunter's Mark;Hunter's Call"..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]\n/petattack [@mouseover,harm,nodead][harm,nodead]")
				EditMacro("WSxSGen+T",nil,nil,"/stopspelltarget\n/use "..(b({{"Intimidation","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]",""},{"High Explosive Trap","[mod:alt,@player][@mouseover,exists,nodead][@cursor]",""},{"Sentinel","[mod:alt,@player][@mouseover,exists,nodead][@cursor]",""},{"Fetch","",""},}) or "Hunter's Call"))
			    EditMacro("WSxCGen+T",nil,nil,"/stopspelltarget\n/use "..(b("Sentinel Owl","[mod:alt,@player][@mouseover,exists,nodead][@cursor]",";") or "").."\n/use Everlasting Darkmoon Firework\n/use Pandaren Firework Launcher\n/use Azerite Firework Launcher\n/use "..factionFireworks)
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..(b({{"Binding Shot","",""},{"Scatter Shot","",""},}) or "Silver-Plated Turkey Shooter"))
				EditMacro("WSxGenF",nil,nil,"#show "..(b("Tar Trap") or "").."\n/focus [@mouseover,exists]mouseover\n/stopmacro [@mouseover,exists]\n/use [@cursor,mod,known:Eagle Eye]!Eagle Eye;"..(b({{"Muzzle","[@focus,harm,nodead]",";"},{"Counter Shot","[@focus,harm,nodead]",";"},}) or "").."[@mouseover,harm,nodead][]Hunter's Mark\n/targetenemy [noharm][dead]")
				EditMacro("WSxSGen+F",nil,nil,"#show Freezing Trap\n/targetenemy [noexists]Robo-Gnomebulator\n/use [nocombat,noexists]Gastropod Shell\n/use \n/stopmacro [mod:ctrl]\n/petautocasttoggle Growl\n/petautocasttoggle [mod:alt]Spirit Walk")
				EditMacro("WSxCGen+F",nil,nil,"#show Flare\n/run for i = 4,12 do C_Minimap.SetTracking(i,false) end C_Minimap.SetTracking(1,false);\n/cancelaura [nospec:3]Safari Hat;X-Ray Specs\n/cancelaura Will of the Taunka\n/cancelaura Will of the Vrykul\n/cancelaura Will of the Iron Dwarves")
				EditMacro("WSxCAGen+F",nil,nil,"#show Exhilaration\n/run if not InCombatLockdown() then if GetSpellCooldown(5384)==0 then "..tpPants.." else "..noPants.." end end")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(b({{"Tranquilizing Shot","[@mouseover,harm,nodead][]",""},{"Eyes of the Beast","",""},}) or "Hunter's Call").."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use Feign Death")
				EditMacro("WSxCSGen+G",nil,nil,"#show "..(b({{"Camouflage","",""},{"Scare Beast","",""},}) or "").."\n/cancelaura Whole-Body Shrinka'\n/cancelaura Growing Pains\n/cancelaura Aspect of the Turtle\n/use Choofa's Call\n/cancelaura Chasing Storm\n/cancelaura Enthralling\n/cancelaura Words of Akunda")
				EditMacro("WSxGenZ",nil,nil,"#show [mod,pet,@pet,nodead]Play Dead;[mod]Revive Pet;"..(b("Survival of the Fittest","[nomod]","") or "[nomod]Feign Death").."\n/use [mod:alt]Gateway Control Shard;[mod,pet,@pet,nodead]Play Dead;[mod]Revive Pet;Personal Hologram\n/use "..(b("Survival of the Fittest","[nomod]","") or "[nomod]Feign Death"))
				EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt,exists]Beast Lore;[mod:ctrl,exists,nodead]Tame Beast;[mod]Aspect of the Cheetah;!Aspect of the Turtle\n/use Super Simian Sphere\n/use Angry Beehive\n/use Xan'tish's Flute")
				EditMacro("WSxGenC",nil,nil,"/target [@pet,pet:Crab]\n/stopspelltarget\n/use [mod,@mouseover,exists,nodead][mod,@cursor]Freezing Trap;[nopet]Call Pet 3;[pet:Crab,help,pet,nocombat]Crab Shank;[pet,nodead]Mend Pet\n/use Totem of Spirits\n/targetlasttarget [help,nodead,pet,pet:Crab]")
				EditMacro("WSxAGen+C",nil,nil,"#show [mod]Hunter's Mark;Play Dead\n/use [mod:ctrl,@player]Freezing Trap;Dismiss Pet\n/stopmacro [mod:ctrl]\n/click TotemFrameTotem1 RightButton\n/use Crashin' Thrashin' Robot")
				EditMacro("WSxGenV",nil,nil,"#show\n/cast Disengage\n/stopcasting\n/use Crashin' Thrashin' Robot\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Ruthers' Harness\n/use Bom'bay's Color-Seein' Sauce\n/use Prismatic Bauble\n/use Desert Flute")
				EditMacro("WSxCAGen+B",nil,nil,"")
				EditMacro("WSxCAGen+N",nil,nil,"")	
			-- Rogue, rogge, rouge, raxicil
			elseif class == "ROGUE" then
				EditMacro("WSxGen1",nil,nil,"/use [nocombat,nostealth]Xan'tish's Flute\n/use "..(b("Tricks of the Trade","[@mouseover,help,nodead][help,nodead]",";") or "").."[stance:0,nocombat]Stealth;"..(b({{"Echoing Reprimand","",""},{"Pistol Shot","",""},{"Thistle Tea","",""},}) or "").."\n/targetenemy [noexists]\n/startattack [combat]")
				EditMacro("WSxSGen+1",nil,nil,"#show Vanish\n/use "..(b("Shadowstep","[mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][]",";") or "")..(b("Tricks of the Trade","[]","") or "").."\n/targetexact Lucian Trias")
				EditMacro("WSxGen2",nil,nil,"/targetenemy [noexists]\n/use [stealth,nostance:3,nodead]Pick Pocket;Sinister Strike\n/use !Stealth\n/cleartarget [exists,dead]\n/stopspelltarget")
				EditMacro("WSxSGen+2",nil,nil,"#show "..(b("Shuriken Tornado") or "").."\n/cast Crimson Vial\n/use [nostealth] Totem of Spirits\n/use [nostealth]Hourglass of Eternity\n/use [nocombat,nostealth,spec:2]Don Carlos' Famous Hat;[nocombat,nostealth]Dark Ranger's Spare Cowl")
				EditMacro("WSxGen3",nil,nil,"/use [stance:0,nocombat]Stealth;"..(b("Shadow Dance","[spec:3,harm,nodead]Symbols of Death\n/use [stance:0,combat]",";") or "").."[@mouseover,harm,nodead][]Ambush\n/targetenemy [noexists]")
				EditMacro("WSxSGen+3",nil,nil,"#show\n/use [@mouseover,harm,nodead,nospec:2][nospec:2]Rupture;[spec:2]Between the Eyes\n/targetenemy [noexists]\n/use [spec:2,nocombat]Ghostly Iron Buccaneer's Hat;[nospec:2]Ravenbear Disguise")
				EditMacro("WSxGen4",nil,nil,"/use [nocombat,noexists,spec:2,nostealth]Dead Ringer\n/use [spec:1]Shiv;"..(b("Ghostly Strike","[]",";") or "").."[@mouseover,harm,nodead][]Ambush\n/use !Stealth\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+4",nil,nil,"/use [nocombat,noexists,nostealth]Barrel of Eyepatches\n/use "..(b({{"Garrote","[@mouseover,harm,nodead][]",""},{"Cold Blood","",""},{"Between the Eyes","",""},{"Pistol Shot","",""},}) or "Feint").."\n/use [nostealth,nospec:2]Hozen Beach Ball;[nostealth]Titanium Seal of Dalaran\n/targetenemy [noexists]\n/startattack [combat]\n/cleartarget [dead]")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..(b({{"Killing Spree","",""},{"Dreadblades","",""},{"Keep It Rolling","",""},{"Goremaw's Bite","",""},{"Shuriken Tornado","",""},{"Kingsbane","",""},{"Cold Blood","",""},{"Thistle Tea","",""},{"Deathmark","","Deathmark"},{"Adrenaline Rush","",""},{"Shadow Blades","",""},}) or "").."\n/targetenemy [noexists,nocombat]\n/use [nocombat,noexists]Gastropod Shell")
				EditMacro("WSxGen5",nil,nil,"#show\n/use [combat,mod:ctrl]Vanish;Eviscerate\n/use !Stealth\n/targetenemy [noexists]\n/stopmacro [nomod:ctrl]\n/use [spec:2]Mr. Smite's Brass Compass;Shadescale\n/roar")
				EditMacro("WSxSGen+5",nil,nil,"/use [nocombat,noexists,nostealth]Barrel of Bandanas\n/use Slice and Dice\n/use [nocombat,noexists,nostealth] Worn Troll Dice")					
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..(b({{"Deathmark","[mod:ctrl]",";"},{"Adrenaline Rush","[mod:ctrl]",";"},{"Shadow Blades","[mod:ctrl]",";"},}) or "")..(b({{"Fan of Knives","",""},{"Blade Flurry","",""},{"Shuriken Storm","",""},}) or ""))
				EditMacro("WSxSGen+6",nil,nil,"/use "..(b({{"Crimson Tempest","",""},{"Secret Technique","",""},{"Shuriken Tornado","",""},{"Black Powder","",""},{"Roll the Bones","",""},{"Blade Flurry","",""},}) or "").."\n/stopmacro\n/use Vanish")			
				EditMacro("WSxGen7",nil,nil,"#show\n/use [nocombat,help]Corbyn's Beacon;"..(b({{"Shuriken Tornado","[mod:shift]",";"},{"Keep It Rolling","[mod:shift]",";"},}) or "")..(b({{"Black Powder","",""},{"Blade Rush","",""},{"Ghostly Strike","",""},{"Pistol Shot","",""},{"Thistle Tea","",""},{"Cold Blood","",""},}) or "").."\n/use Autographed Hearthstone Card\n/use !Stealth")
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..(b({{"Exsanguinate","",""},{"Sepsis","",""},{"Ghostly Strike","",""},{"Shuriken Tornado","",""},{"Cold Blood","",""},{"Thistle Tea","",""},}) or "Sprint"))
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..(b({{"Flagellation","",""},{"Serrated Bone Spike","",""},{"Keep It Rolling","",""},{"Sepsis","",""},{"Ghostly Strike","",""},{"Shadow Dance","",""},{"Numbing Poison","",""},{"Echoing Reprimand","",""},}) or "Evasion"))
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Tricks of the Trade")
				EditMacro("WSxCSGen+3",nil,nil,"/use [mod:alt,@party4,help,nodead][@party2,help,nodead]Tricks of the Trade")
				EditMacro("WSxCSGen+4",nil,nil,"/use [mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead]Tricks of the Trade;[nocombat,noexists]Crashin' Thrashin' Cannon Controller")
				EditMacro("WSxCSGen+5",nil,nil,"/use [mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]Tricks of the Trade")
				EditMacro("WSxGenQ",nil,nil,"#show\n/use "..(b("Blind","[mod:alt,@focus,harm,nodead]",";") or "")..(b("Cloak of Shadows","[mod:shift]",";") or "").."[@mouseover,harm,nodead][harm,nodead]Kick;The Golden Banana\n/use [spec:2]Rime of the Time-Lost Mariner;Sira's Extra Cloak\n/use [mod:shift]Poison Extraction Totem")
				EditMacro("WSxGenE",nil,nil,"/use "..(b("Cheap Shot","[mod:alt,@focus,harm,nodead,nostance:0][nostance:0]",";") or "")..(b("Shadow Dance","[stance:0,combat]",";") or "")..(b("Vanish","[stance:0,combat]",";") or "").."\n/use !Stealth\n/use [nostealth,spec:2,nocombat]Iron Buccaneer's Hat")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(b("Tricks of the Trade","[@focus,help,nodead][@mouseover,help,nodead][help,nodead][@party1,help,nodead]","") or "").."\n/use Seafarer's Slidewhistle"..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..(b({{"Garrote","[mod:alt,@focus,harm,nodead,nostance:0][nostance:0]",";"},{"Cheap Shot","[mod:alt,@focus,harm,nodead,nostance:0][nostance:0]",";"},}) or "")..(b("Shadow Dance","[stance:0,combat]",";") or "")..(b("Vanish","[stance:0,combat]","") or "").."\n/use !Stealth\n/use [nostealth]Hourglass of Eternity")
				EditMacro("WSxGenR",nil,nil,"/stopspelltarget\n/use [@mouseover,exists,nodead,mod:ctrl][@cursor,mod:ctrl]Distract;"..(b({{"Poisoned Knife","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";"},{"Pistol Shot","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";"},{"Shuriken Toss","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";"},}) or "")..(b("Shadowstep","[@mouseover,help,nodead][help,nodead]",";") or "").."Horse Head Costume\n/targetenemy [noexists]")
				EditMacro("WSxGenT",nil,nil,"/use "..(b("Gouge","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";") or "")..swapblaster.."\n/stopattack\n/targetenemy [noexists]\n/cleartarget [dead]\n/stopspelltarget\n/use !Stealth")
				EditMacro("WSxSGen+T",nil,nil,"#show "..(b({{"Tricks of the Trade","",""},{"Shadowstep","",""},}) or "").."\n/stopspelltarget\n/use Titanium Seal of Dalaran\n/use [@mouseover,exists,nodead][@cursor]Grappling Hook\n/targetenemy [noexists]")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/stopspelltarget\n/use "..(b("Grappling Hook","[@mouseover,exists,nodead][@cursor]",";") or "").."[mod:alt,@player][@mouseover,exists,nodead][@cursor]Distract")
				EditMacro("WSxGenU",nil,nil,"#show\n/use Sprint")
				if playerSpec == 1 then
					override = "Detoxified Blight Grenade"
				elseif playerSpec == 2 then
					override = "Crashin' Thrashin' Cannon Controller"
				else
					override = "Shadow Slicing Shortsword"
				end
				EditMacro("WSxGenF",nil,nil,"#show\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Kick;"..(b("Detection","[noexists,nodead]",";") or "")..override)
				EditMacro("WSxSGen+F",nil,nil,"#show "..(b({{"Grappling Hook","",""},{"Gouge","",""},}) or "Kick").."\n/use "..(b("Shadowstep","[@focus,harm,nodead]","\n/use [@focus,harm,nodead]Kick\n/use [@cursor]Grappling Hook") or ""))
				EditMacro("WSxCGen+F",nil,nil,"#show "..(b("Cloak of Shadows","","") or "").."\n/use "..(b({{"Garrote","[nostance:0]",";"},{"Cheap Shot","[nostance:0]",";"},}) or "")..(b("Vanish","[stance:0,combat]",";") or "").."\n/use !Stealth")
				EditMacro("WSxCAGen+F",nil,nil,"#show [nocombat,noexists,resting]Twelve-String Guitar;Distract\n/targetfriend [nohelp,nodead]\n/use [help,nodead]Shadowstep;[nocombat,noexists]Twelve-String Guitar\n/targetlasttarget")
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt,nocombat,noexists]Darkmoon Gazer;[@mouseover,harm,nodead][harm,nodead]Shiv;Pick Lock")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/targetenemy [noexists]\n/use [stance:0,nocombat]Stealth;[mod:alt,@focus,exists,nodead][]Kidney Shot\n/use [nocombat,noexists,stance:0]Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(b("Cheap Shot","[mod:alt,@focus,harm,nodead,nostance:0][nostance:0]",";") or "")..(b("Vanish","[stance:0,combat]",";") or "").."\n/use !Stealth")
				EditMacro("WSxCSGen+G",nil,nil,"#show Blind\n/use Totem of Spirits\n/use [@focus,harm,nodead]Gouge")	
				EditMacro("WSxGenH",nil,nil,"#show\n/use Crimson Vial\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenZ",nil,nil,"/use "..(b("Wound Poison","[mod:alt]",";") or "")..(b({{"Deadly Poison","[mod]",";"},{"Instant Poison","[mod]",";"},}) or "")..(b("Evasion","[combat]",";") or "").."[stance:1]Shroud of Concealment\n/use !Stealth\n/use [mod:alt]Gateway Control Shard\n/use [spec:2,mod]Slightly-Chewed Insult Book;[mod]Shadowy Disguise")
				EditMacro("WSxGenX",nil,nil,"/use [mod:alt]Crippling Poison;[mod:ctrl]Scroll of Teleport: Ravenholdt;[mod:shift]Sprint;"..(b("Feint","","") or "").."\n/use [nostealth,mod:shift]Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
				EditMacro("WSxGenC",nil,nil,"#show\n/targetenemy [noexists]\n/use "..(b("Blind","[mod:ctrl,@mouseover,harm,nodead][mod:ctrl]",";") or "")..(b("Amplifying Poison","[mod:shift]",";") or "").."[@mouseover,harm,nodead,nostance:0][nostance:0]Sap;Blind\n/use !Stealth\n/cancelaura Don Carlos' Famous Hat")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use "..(b({{"Numbing Poison","",""},{"Atrophic Poison","",""},}) or "").."\n/run PetDismiss();")
				EditMacro("WSxGenV",nil,nil,"/use "..(b({{"Shadowstep","[@mouseover,exists,nodead][]",""},{"Grappling Hook","[@cursor]",""},}) or "").."\n/targetenemy [noexists]\n/use [nostealth]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use [nostealth]Prismatic Bauble")
			-- Priest, Prist
			elseif class == "PRIEST" then
				EditMacro("WSxGen1",nil,nil,"/use [help,nodead,nocombat]The Heartbreaker;"..(b("Power Infusion","[@mouseover,help,nodead][help,nodead]",";") or "")..(b({{"Void Torrent","[@mouseover,harm,nodead][harm,nodead]",""},{"Schism","[@mouseover,harm,nodead][harm,nodead]",""},{"Mind Blast","[@mouseover,harm,nodead][harm,nodead]",""},{"Shadow Word: Pain","[@mouseover,harm,nodead][harm,nodead]",""}}) or "").."\n/startattack\n/use Xan'tish's Flute")
				EditMacro("WSxSGen+1",nil,nil,"#show "..(b("Power Infusion") or "Shadow Word: Pain").."\n/use [mod:alt,@party3,nodead][mod:ctrl,@party2,exists][@focus,help][@party1,exists][@targettarget,exists]Flash Heal;Kaldorei Light Globe")
				EditMacro("WSxGen2",nil,nil,"/targetenemy [noexists]\n/cleartarget [dead]\n/cancelaura Fling Rings\n/use [nospec:3,help,nodead,nocombat]Holy Lightsphere;[help,nodead,nocombat]Corbyn's Beacon\n/use "..(b("Power Word: Life","[@mouseover,help,nodead][help,nodead]",";") or "").."[@mouseover,harm,nodead][]Smite\n/use [nocombat]Darkmoon Ring-Flinger\n/use Haunting Memento")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use [mod:alt,@party4,nodead][@mouseover,help,nodead][]Flash Heal\n/use [nocombat,noexists,resting]Gnomish X-Ray Specs\n/cancelaura Don Carlos' Famous Hat\n/cancelaura X-Ray Specs")
				EditMacro("WSxGen3",nil,nil,"/targetenemy [noexists]\n/cleartarget [dead]\n/use "..(b("Shadow Word: Death","[@mouseover,harm,nodead][harm,nodead]",";") or "")..(b("Power Word: Life","[@mouseover,help,nodead,combat][help,nodead,combat]","") or "").."\n/use Scarlet Confessional Book\n/use [nocombat,noexists,spec:3]Twitching Eyeball")
				EditMacro("WSxSGen+3",nil,nil,"/targetenemy [noexists]\n/stopspelltarget\n/cleartarget [dead]\n/use "..(b("Shadow Word: Pain","[@mouseover,harm,nodead,nomod:alt][nomod:alt]","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Shadow Word: Pain\n/targetlasttarget") or "").."\n/use Totem of Spirits")
				EditMacro("WSxGen4",nil,nil,"#showtooltip\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,noexists,nochanneling]Pretty Draenor Pearl\n/use "..(b({{"Penance","[@mouseover,exists,nodead][]",""},{"Holy Word: Serenity","[@mouseover,help,nodead][]",""},{"Mind Blast","[@mouseover,harm,nodead][]",""},}) or ""))	
				EditMacro("WSxSGen+4",nil,nil,"/stopspelltarget\n/targetenemy [noexists]\n/use "..(b({{"Penance","[@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]",";"},{"Prayer of Mending","[@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]",";"},}) or "")..(b("Shadowform","[noform]",";") or "")..(b({{"Vampiric Touch","[@mouseover,harm,nodead,nomod:alt][nomod:alt]","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Vampiric Touch\n/targetlasttarget"},{"Divine Star","",""},{"Halo","",""},{"Mindgames","",""},{"Prayer of Healing","[@mouseover,help,nodead][]",""},}) or ""))
				EditMacro("WSxCGen+4",nil,nil,"#show\n/cast "..(b("Penance","[mod:alt,@party3,help,nodead]",";") or "")..(b({{"Ultimate Penitence","[@mouseover,help,nodead][]",""},{"Rapture","",""},{"Lightwell","[@cursor]",""},{"Divine Word","",""},{"Apotheosis","",""},{"Holy Word: Salvation","",""},{"Dark Void","",""},{"Power Infusion","",""},{"Void Torrent","",""},{"Mindgames","",""},{"Empyreal Blaze","",""},}) or "").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGen5",nil,nil,"/targetenemy [noexists]\n/use "..(b({{"Power Word: Barrier","[mod:ctrl,@cursor]",";"},{"Symbol of Hope","[mod:ctrl]",";"},{"Desperate Prayer","[mod:ctrl]",";"}}) or "")..(b({{"Void Eruption","[@mouseover,harm,nodead][]",""},{"Dark Ascension","",""},{"Heal","[@mouseover,help,nodead][]",""},{"Mind Blast","[@mouseover,harm,nodead][]",""},}) or "").."\n/use [help,nodead]Apexis Focusing Shard\n/use [nocombat]Thaumaturgist's Orb\n/use [spec:3]Shadescale")
				EditMacro("WSxSGen+5",nil,nil,(b({{"Devouring Plague","/targetenemy [noharm]\n/cleartarget [dead]\n/use [@mouseover,harm,nodead,nomod:alt][harm,nodead,nomod:alt]","\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Devouring Plague\n/targetlasttarget"},{"Penance","/targetenemy [noharm]\n/cleartarget [dead]\n/use [@party2,help,nodead,mod:alt][@player]",""},{"Prayer of Mending","/targetenemy [noharm]\n/cleartarget [dead]\n/use [@party2,help,nodead,mod:alt][@player]",""},{"Circle of Healing","/targetenemy [noharm]\n/cleartarget [dead]\n/use [@mouseover,help,nodead][]",""},}) or ""))
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use "..(b("Penance","[mod:ctrl,@party4,help,nodead]",";") or "").."[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14")
				EditMacro("WSxGen6",nil,nil,"#show\n/stopspelltarget\n/targetenemy [noexists]\n/cleartarget [dead]\n/use "..(b({{"Divine Hymn","[mod:ctrl]",";"},{"Shadowfiend","[mod:ctrl]",";"},}) or "")..(b({{"Holy Nova","",""},{"Divine Star","",""},{"Halo","",""},}) or "Shadow Word: Pain"))
				EditMacro("WSxSGen+6",nil,nil,"/use "..(b({{"Prayer of Healing","[@mouseover,help,nodead][]",""},{"Power Word: Radiance","[@mouseover,help,nodead][]",""},{"Divine Star","",""},{"Halo","",""},{"Mindgames","",""},}) or "").."\n/use Cursed Feather of Ikzan\n/use [nocombat]Dead Ringer\n/targetenemy [noexists]")
				EditMacro("WSxGen7",nil,nil,"#show\n/stopspelltarget\n/use "..(b({{"Holy Word: Sanctify","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Shadow Crash","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Divine Star","",""},{"Halo","",""},{"Empyreal Blaze","",""},{"Power Word: Life","[@mouseover,help,nodead][]",""},{"Schism","",""},}) or "").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..(b({{"Evangelism","[mod:shift]",";"},{"Lightwell","[@player,mod:shift]",";"},{"Power Infusion","[mod:shift,@focus,help,nodead][mod:shift,@mouseover,help,nodead][mod:shift]",";"},}) or "")..(b({{"Void Torrent","",""},{"Rapture","",""},{"Mindgames","[@mouseover,harm,nodead][]",""},{"Shadowfiend","",""},{"Power Infusion","",""},}) or ""))
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..(b({{"Power Infusion","[mod:shift,@focus,help,nodead][mod:shift,@mouseover,help,nodead][mod:shift]",";"},}) or "")..(b({{"Mindgames","[@mouseover,harm,nodead][]",""},{"Vampiric Embrace","",""},{"Evangelism","",""},{"Power Word: Barrier","",""},{"Rapture","",""},{"Shadow Covenant","[@mouseover,help,nodead][]",""},{"Empyreal Blaze","",""},{"Apotheosis","",""},{"Holy Word: Salvation","",""},{"Void Torrent","",""},{"Power Infusion","",""},}) or ""))
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead,nospec:3][@party1,help,nodead,nospec:3][@targettarget,help,nodead,nospec:3]Purify;[mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Purify Disease\n/use Brynja's Beacon")
				EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Shadow Word: Pain;[mod:alt,@party4,help,nodead,nospec:3][@party2,help,nodead,nospec:3]Purify;[mod:alt,@party4,help,nodead][@party2,help,nodead]Purify Disease\n/use [nocombat,noharm]Forgotten Feather")
				EditMacro("WSxCSGen+4",nil,nil,"/use [spec:3,@focus,harm,nodead]Vampiric Touch;[mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Power Word: Shield;[nocombat]Romantic Picnic Basket\n/use [@party1]Apexis Focusing Shard")
				EditMacro("WSxCSGen+5",nil,nil,"/use [@focus,spec:3,harm,nodead]Devouring Plague;[mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]Power Word: Shield\n/use Battle Standard of Coordination\n/use [@party2]Apexis Focusing Shard")
				EditMacro("WSxGenQ",nil,nil,"#show\n/use "..(b({{"Mind Control","[mod:alt,@focus,harm,nodead]",";"},{"Dominate Mind","[mod:alt,@focus,harm,nodead]",";"},}) or "")..(b("Void Shift","[@mouseover,help,nodead][help,nodead]",";") or "")..(b({{"Silence","[@mouseover,harm,nodead][]",""},{"Mind Control","[@mouseover,harm,nodead][]",""},{"Dominate Mind","[@mouseover,harm,nodead][]",""},}) or "").."\n/use Forgotten Feather")
				EditMacro("WSxGenE",nil,nil,"#show "..(b({{"Psychic Scream","",""},{"Holy Nova","",""},}) or "").."\n/stopspelltarget\n/use "..(b("Mass Dispel","[mod:alt,@mouseover,exists,nodead][mod:alt,@cursor]",";") or "").."[nomod,nocombat,noexists]Party Totem"..(b({{"Psychic Scream","\n/use [nomod]",""},{"Holy Nova","\n/use [nomod]",""},}) or ""))
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use Desperate Prayer\n/use [@player]Power Word: Life\n/use A Collection Of Me"..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..(b("Mass Dispel","[mod:alt,@player]",";") or "")..(b("Psychic Scream","[@mouseover,harm,nodead][]","") or "").."\n/use Thistleleaf Branch\n/cancelaura Thistleleaf Disguise")
				EditMacro("WSxGenR",nil,nil,"/use "..(b("Void Tendrils","[mod:shift]",";") or "")..(b({{"Angelic Feather","[mod:ctrl,@player][@cursor]",""},{"Power Word: Shield","[mod:ctrl,@player][@mouseover,help,nodead][]",""},}) or "").."\n/stopspelltarget")
				EditMacro("WSxGenT",nil,nil,"#show "..(b({{"Holy Word: Chastise","",""},{"Psychic Horror","",""},{"Power Word: Barrier","",""},{"Evangelism","",""},}) or "")..swapblaster.."\n/stopspelltarget"..(b("Mind Soothe","\n/use [mod:alt,@player][@mouseover,exists,nodead][@cursor]","") or ""))				
				EditMacro("WSxSGen+T",nil,nil,"#show "..(b({{"Void Tendrils","",""},{"Leap of Faith","",""},}) or "").."\n/use "..(b({{"Psychic Horror","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";"},{"Holy Word: Chastise","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]",";"},}) or "[@mouseover,harm,nodead][harm,nodead]Shadow Word: Pain;")..(b("Leap of Faith","[mod:alt,@focus,help,nodead][@mouseover,help,nodead][help,nodead]",";") or "").."\n/use Shadowy Disguise")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..(b("Renew","[@party4,help,nodead,mod:alt][@focus,help,nodead][@party2,help,nodead]",";") or "Fade"))
				EditMacro("WSxGenU",nil,nil,"#show Desperate Prayer\n/use "..(b("Empyreal Blaze","","") or "Fade"))
				EditMacro("WSxSGen+F",nil,nil,"#show "..(b({{"Empyreal Blaze","",""},{"Shackle Undead","",""},}) or "").."\n/use "..(b("Shackle Undead","[@focus,harm,nodead]",";") or "").."[help,nocombat,mod:alt]B. F. F. Necklace;[nocombat,noexists,mod:alt]Gastropod Shell;Mind Vision\n/use [nocombat,noexists]Tickle Totem\n/cancelaura [mod:alt]Shadowform")
				EditMacro("WSxCGen+F",nil,nil,"#show "..(b({{"Symbol of Hope","",""},{"Rapture","",""},{"Psychic Scream","",""},}) or "").."\n/use [nocombat,noexists]Piccolo of the Flaming Fire;"..(b({{"Vampiric Embrace","",""},{"Rapture","",""},}) or "").."\n/cancelaura Twice-Cursed Arakkoa Feather\n/cancelaura Spirit Shell\n/use Xan'tish's Flute\n/use Leather Love Seat")
				EditMacro("WSxCAGen+F",nil,nil,"#show "..(b("Vampiric Embrace","","") or "Levitate").."\n/targetfriendplayer\n/use [help,nodead]Power Infusion;Starlight Beacon\n/targetlasttarget")
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]Darkmoon Gazer;"..(b("Dispel Magic","[@mouseover,harm,nodead]",";") or "")..(b({{"Purify","[@mouseover,help,nodead][]",";"},{"Purify Disease","[@mouseover,help,nodead][]",";"},}) or "Power Word: Fortitude"))
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(b("Dispel Magic","[@mouseover,harm,nodead][harm,nodead]",";") or "").."Personal Spotlight\n/use [noexists,nocombat] Flaming Hoop\n/targetenemy [noexists]")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(b("Renew","[@party3,help,nodead,mod:alt][@focus,help,nodead][@party1,help,nodead]","") or "").."\n/use Panflute of Pandaria\n/use Puzzle Box of Yogg-Saron\n/use Spectral Visage")
				EditMacro("WSxCSGen+G",nil,nil,"#show Fade\n/use [@focus,harm,nodead]Dispel Magic;[nospec:3,@focus,help,nodead][nospec:3]Purify;[@focus,help,nodead][]Purify Disease\n/cancelaura Dispersion\n/cancelaura Spirit of Redemption\n/use Tickle Totem")
				EditMacro("WSxGenH",nil,nil,"#show "..(b({{"Evangelism","",""},{"Leap of Faith","",""},}) or "").."\n/use [nocombat,noexists]Don Carlos' Famous Hat"..(b({{"Evangelism",";",""},{"Power Word: Life",";[@mouseover,help,nodead][]",""},}) or "").."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;"..(b("Power Word: Barrier","[mod,@player]",";") or "")..(b({{"Pain Suppression","[@mouseover,help,nodead][]",""},{"Guardian Spirit","[@mouseover,help,nodead][]",""},{"Dispersion","!",""},}) or "").."\n/use [nochanneling:Penance]Soul Evacuation Crystal")
				EditMacro("WSxGenX",nil,nil,"/use [mod:shift]Fade;"..(b({{"Mind Control","[mod:ctrl,harm,nodead]",";"},{"Dominate Mind","[mod:ctrl,harm,nodead]",";"},}) or "").."[mod:ctrl]Unstable Portal Emitter"..(b("Power Word: Shield",";[@mouseover,help,nodead][]","") or "").."\n/use [nocombat]Bubble Wand\n/use Void Totem\n/cancelaura Bubble Wand")
				EditMacro("WSxGenC",nil,nil,"/use "..(b("Shackle Undead","[@mouseover,harm,nodead,mod:ctrl][mod:ctrl]",";") or "")..(b({{"Rapture","[mod:shift]",";"},{"Symbol of Hope","[mod:shift]",";"},}) or "")..(b({{"Prayer of Mending","[@mouseover,help,nodead][]",""},{"Renew","[@mouseover,help,nodead][]",""},{"Shadowfiend","",""},{"Mindbender","",""},}) or ""))
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use [nocombat,noexists]Sturdy Love Fool\n/run PetDismiss();\n/cry")		
				EditMacro("WSxGenV",nil,nil,"#show\n/stopspelltarget\n/use "..(b({{"Renew","[@mouseover,help,nodead][]",""},{"Void Shift","[@mouseover,help,nodead][]",""},}) or "[@mouseover,exists,nodead][@cursor,nodead]Mind Soothe").."\n/cancelaura Rhan'ka's Escape Plan")
				EditMacro("WSxCAGen+B",nil,nil,"")
				EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxCGen+T\",nil,nil,\"\\#show Power Infusion\\n/use [@\"..N..\"]Power Infusion\\n/stopspelltarget\", nil)print(\"PI set to : \"..N)else print(\"Nöpe!\")end")
			-- Death Knight, DK, diky
			-- Start off here
			elseif class == "DEATHKNIGHT" then
				EditMacro("WSxGen1",nil,nil,"#show\n/cast [@mouseover,help,dead][help,dead]Raise Ally;"..(b({{"Frostwyrm's Fury","",""},{"Apocalypse","",""},{"Consumption","",""},{"Blooddrinker","[@mouseover,harm,nodead][]",""},{"Tombstone","",""},{"Breath of Sindragosa","!",""}}) or "Death Strike").."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+1",nil,nil,"#show Raise Ally\n/use [@mouseover,exists][]Raise Ally\n/use Stolen Breath")
				EditMacro("WSxGen2",nil,nil,"/targetlasttarget [noexists,nocombat]\n/use "..(b("Corpse Exploder","[harm,dead,nocombat]",";") or "")..(b({{"Heart Strike","",""},{"Howling Blast","[@mouseover,harm,nodead][]",""},{"Scourge Strike","[@mouseover,harm,nodead][]",""},}) or "").."\n/use [nocombat]Stolen Breath\n/startattack")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use Death Strike\n/use Gnomish X-Ray Specs\n/cancelaura X-Ray Specs")
				EditMacro("WSxGen3",nil,nil,"#show\n/use [nocombat,noexists]Sack of Spectral Spiders;"..(b({{"Soul Reaper","",""},{"Empower Rune Weapon","",""},{"Abomination Limb","",""},{"Scourge Strike","",""},{"Breath of Sindragosa","",""},{"Obliterate","",""},{"Rune Strike","",""},{"Marrowrend","",""},}) or "").."\n/startattack")
				EditMacro("WSxSGen+3",nil,nil,"/use "..(b({{"Death's Caress","[@mouseover,harm,nodead][]",""},{"Glacial Advance","[@mouseover,harm,nodead][]",""},{"Howling Blast","[@mouseover,harm,nodead][]",""},{"Outbreak","[@mouseover,harm,nodead][]",""},}) or "").."\n/startattack\n/stopspelltarget")
				EditMacro("WSxGen4",nil,nil,"#show\n/use [spec:2,noexists]Vrykul Drinking Horn;"..(b({{"Marrowrend","",""},{"Obliterate","",""},{"Rune Strike","",""},{"Festering Strike","",""},}) or "").."\n/startattack\n/cancelaura Vrykul Drinking Horn")
				EditMacro("WSxSGen+4",nil,nil,"#show Death and Decay\n/stopspelltarget\n/use [spec:1,nocombat,noexists]Krastinov's Bag of Horrors\n/use [@focus,mod:alt]Death Coil;[@mouseover,exists,nodead][@cursor]Death and Decay\n/targetenemy [noexists]")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/cast "..(b({{"Bonestorm","",""},{"Unholy Assault","",""},{"Summon Gargoyle","",""},{"Apocalypse","",""},{"Breath of Sindragosa","!",""},{"Empower Rune Weapon","",""},}) or "").."\n/use [spec:1,nocombat]For da Blood God!;[nospec:1,nocombat]Will of Northrend\n/startattack")
				EditMacro("WSxGen5",nil,nil,"/use "..(b("Anti-Magic Zone","[mod:ctrl,@cursor]",";") or "")..(b("Frost Strike") or "[@mouseover,exists,nodead][]Death Coil").."\n/startattack\n/cleartarget [dead]\n/use [nospec:2]Aqir Egg Cluster")
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use "..(b({{"Mark of Blood","",""},{"Tombstone","",""},{"Unholy Blight","",""},}) or "[@mouseover,exists,nodead][exists,nodead]Death Coil").."\n/use Angry Beehive\n/startattack")
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..(b({{"Dancing Rune Weapon","[mod:ctrl]",";"},{"Pillar of Frost","[mod:ctrl]",";"},{"Army of the Dead","[mod:ctrl]",";"},}) or "")..(b({{"Heart Strike","",""},{"Epidemic","",""},{"Remorseless Winter","",""},}) or "[@player]Death and Decay").."\n/use [mod:ctrl]Angry Beehive")
				EditMacro("WSxSGen+6",nil,nil,"#show "..(b({{"Vile Contagion","",""},{"Sacrificial Pact","",""},{"Army of the Dead","",""},}) or "").."\n/use [@player]Death and Decay\n/use [noexists,nocombat,spec:1]Vial of Red Goo\n/stopspelltarget\n/cancelaura Secret of the Ooze")
				EditMacro("WSxGen7",nil,nil,"#show\n/use "..(b("Vile Contagion","[mod:shift]",";") or "")..(b({{"Blood Boil","",""},{"Frostscythe","",""},{"Horn of Winter","",""},{"Summon Gargoyle","",""},{"Pillar of Frost","",""},}) or ""))
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..(b("Sacrificial Pact","[mod:shift]",";") or "")..(b({{"Chill Streak","[@mouseover,harm,nodead][]",""},{"Dark Transformation","[nopet]Raise Dead;[pet]",""},{"Sacrificial Pact","",""},{"Empower Rune Weapon","",""},{"Death's Caress","",""},}) or ""))
				if covA == "Abomination Limb" then
					override = (b({{"Empower Rune Weapon","",""},{"Sacrificial Pact","",""},{"Army of the Dead","",""},{"Breath of Sindragosa","!",""},{"Bone Storm","",""},{"Anti-Magic Zone","",""},}) or "")
				else
					override = (b({{"Abomination Limb","",""},{"Empower Rune Weapon","",""},{"Sacrificial Pact","",""},{"Army of the Dead","",""},{"Breath of Sindragosa","!",""},{"Bone Storm","",""},{"Anti-Magic Zone","",""},}) or "")
				end
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..override)
				EditMacro("WSxCSGen+2",nil,nil,"")
				EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noharm]Spirit Wand;[@focus,exists,harm,nodead,spec:3]Outbreak;[@focus,exists,harm,nodead,spec:2]Howling Blast\n/stopspelltarget")
				EditMacro("WSxCSGen+4",nil,nil,"/use [nocombat]Lilian's Warning Sign")
				EditMacro("WSxCSGen+5",nil,nil,"/clearfocus [dead]\n/use Stolen Breath")
				EditMacro("WSxGenQ",nil,nil,"/use "..(b("Asphyxiate","[mod:alt,@focus,harm,nodead]",";") or "").."[mod:shift]Lichborne;"..(b("Mind Freeze","[@mouseover,harm,nodead][]","") or ""))
				EditMacro("WSxGenE",nil,nil,"#show\n/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Death Grip\n/startattack\n/cleartarget [dead]\n/targetenemy [noharm]")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(b({{"Horn of Winter","",""},{"Blood Tap","",""},}) or "")..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show "..(b({{"Blinding Sleet","",""},{"Rune Tap","",""},{"Blood Tap","",""},}) or "").."\n/use "..(b("Gorefiend's Grasp","[mod:alt,@player]",";") or "")..(b({{"Blinding Sleet","",""},{"Rune Tap","",""},{"Blood Tap","",""},}) or ""))
				EditMacro("WSxGenR",nil,nil,"#show\n/use "..(b("Gorefiend's Grasp","[@player,mod:ctrl][@mouseover,exists,nodead,mod:shift][mod:shift]",";") or "")..(b("Wraith Walk","[mod:ctrl]!",";") or "")..(b("Chains of Ice","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]","") or "").."\n/targetenemy [noexists]")
				if playerSpec == 3 then override = "[nopet]Raise Dead;[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][pet]Leap"
				else 
					override = (b({{"Blood Tap","",""},{"Horn of Winter","",""},{"Gorefiend's Grasp","",""},}) or "Death Grip")
				end
				EditMacro("WSxGenT",nil,nil,"/use "..override..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]\n/petattack [@mouseover,exists,nodead][]")
				EditMacro("WSxSGen+T",nil,nil,"#show\n/use Dark Command\n/use Blight Boar Microphone")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..(b("Raise Dead","[nopet]",";") or "").."\n/use "..(b("Sacrificial Pact","[]","") or ""))
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..(b({{"Horn of Winter","",""},{"Wraith Walk","",""},{"Rune Tap","",""},{"Blinding Sleet","",""},{"Corpse Exploder","",""},}) or "Corpse Exploder"))
				EditMacro("WSxGenF",nil,nil,"#show Corpse Exploder\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Legion Communication Orb;[@focus,harm,nodead]Mind Freeze")
				EditMacro("WSxSGen+F",nil,nil,"#show "..(b("Death Pact") or "").."\n/petautocasttoggle [mod:alt]Claw\n/use "..(b({{"Dark Transformation","[nopet]Raise Dead;[pet,@focus,harm,nodead][pet,harm,nodead]",";Gastropod Shell\n/use [pet,@focus,harm,nodead][pet,harm,nodead]!Leap\n/petattack [@focus,harm,nodead]"},{"Blood Tap","[nocombat,noexists]Gastropod Shell;",""},}) or ""))
				EditMacro("WSxCGen+F",nil,nil,"#show\n/use "..(b({{"Horn of Winter","",""},{"Vampiric Blood","",""},{"Rune Tap","",""},{"Blinding Sleet","",""},}) or "[pet]Huddle"))
				if playerSpec == 3 and b("Raise Dead") then 
					override = "[nopet]Raise Dead;[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][pet]Gnaw\n/petattack [harm,nodead]"
				else 
					override = (b("Rune Tap","","") or "Death Grip")
				end
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt,nocombat,noexists]S.F.E. Interceptor;"..override)
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(b({{"Asphyxiate","[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]",""},{"Blinding Sleet","",""},}) or "[@mouseover,harm,nodead][]Death Grip").."\n/use [noexists,nocombat] Flaming Hoop")				
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(b("Death Pact","[]","") or ""))
				EditMacro("WSxCSGen+G",nil,nil,"#show "..(b({{"Control Undead","",""},{"Anti-Magic Zone","",""},}) or "").."\n/cancelaura Lichborne\n/cancelaura Blessing of Protection")
				EditMacro("WSxGenH",nil,nil,"#show\n/use [nocombat,noexists]Death Gate;[spec:3,nopet]Raise Dead;[@mouseover,harm,nodead,spec:3][spec:3,pet]Gnaw;[nomounted]Death Gate\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;"..(b("Anti-Magic Zone","[@player,mod:shift]",";") or "")..(b("Icebound Fortitude","","") or ""))
				EditMacro("WSxGenX",nil,nil,"#show\n/use [mod:alt]Runeforging;"..(b("Control Undead","[mod:ctrl,harm,nodead]",";") or "").."[mod:ctrl]Death Gate;"..(b("Wraith Walk","[mod:shift]",";") or "")..(b("Anti-Magic Shell","","") or ""))
				EditMacro("WSxGenC",nil,nil,"#show "..(b({{"Horn of Winter","",""},{"Death Pact","",""},{"Blinding Sleet","",""},{"Asphyxiate","",""},{"Death Grip","",""},}) or "").."\n/use "..(b("Control Undead","[mod:ctrl]",";") or "")..(b("Lichborne","[mod:shift]","\n/use [@player,mod:shift][@pet,pet,nodead]Death Coil;[nopet][pet,dead]Raise Dead") or "")..(b({{"Horn of Winter","",""},{"Death Pact","",""},{"Blinding Sleet","",""},{"Asphyxiate","",""},{"Death Grip","",""},}) or ""))
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use Sylvanas' Music Box\n/run PetDismiss();\n/cry")
				EditMacro("WSxGenV",nil,nil,"#show\n/use !Death's Advance\n/use Ancient Elethium Coin\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
			-- Warrior, warror
			elseif class == "WARRIOR" then
				overrideModAlt = ""
				if b("Berserker Stance") then overrideModAlt = "\n/use [nostance:2]!Berserker Stance"
				end
				if b("Colossus Smash") then override = "Colossus Smash"
				elseif b("Rampage") then override = "[noequipped:Shields]Rampage\n/equipset [equipped:Shields,spec:2]DoubleGate"..overrideModAlt
				elseif playerSpec == 2 then override = "[noequipped:Shields]Slam\n/equipset [equipped:Shields,spec:2]DoubleGate"..overrideModAlt
				else override = "Shield Block"
				end
				EditMacro("WSxGen1",nil,nil,"#show\n/use [nocombat,help]Corbyn's Beacon;"..override.."\n/targetenemy [noexists]\n/startattack\n/use Chalice of Secrets")
				EditMacro("WSxSGen+1",nil,nil,"/use "..(b({{"Ignore Pain","",""},{"Bitter Immunity","",""},}) or "").."\n/use Chalice of Secrets\n/targetexact Aerylia")
			   	overrideModAlt = ""
			   	if b("Battle Stance") then overrideModAlt = "\n/use [nostance:2]!Battle Stance" 
			   	end
			   	override = b({{"Mortal Strike","[noequipped:Shields]","\n/equipset [equipped:Shields,spec:1]Noon!"..overrideModAlt..""},{"Bloodthirst","",""},{"Devastate","[known:Devastator,@mouseover,harm,nodead][known:Devastator]Heroic Throw;",""},}) or ""
				EditMacro("WSxGen2",nil,nil,"/use [nocombat,noexists]Vrykul Drinking Horn;"..override.."\n/targetenemy [noexists]\n/cleartarget [noharm]\n/startattack\n/cancelaura Vrykul Drinking Horn")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/use Victory Rush\n/use [noexists,nocombat,nochanneling]Gnomish X-Ray Specs\n/targetenemy [noharm]\n/startattack")
				EditMacro("WSxGen3",nil,nil,"#show\n/use Execute\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]\n/use Banner of the Burning Blade")			
				EditMacro("WSxSGen+3",nil,nil,"/use "..(b({{"Rend","",""},{"Thunderous Roar","",""},{"Bladestorm","",""},{"Thunder Clap","",""},}) or "Whirlwind").."\n/startattack")
				EditMacro("WSxGen4",nil,nil,"#show\n/use [spec:3][equipped:Shields,spec:2]Shield Slam;"..(b({{"Overpower","",""},{"Raging Blow","",""},}) or "Slam").."\n/targetenemy [noexists]\n/startattack\n/cleartarget [dead]")
				EditMacro("WSxSGen+4",nil,nil,"#show\n/stopspelltarget\n/use "..(b({{"Ravager","[@mouseover,exists,nodead][@cursor]",""},{"Skullsplitter","",""},{"Siegebreaker","",""},{"Sweeping Strikes","",""},}) or "").."\n/use Muradin's Favor\n/startattack")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..(b({{"Odyn's Fury","",""},{"Bladestorm","",""},{"Shield Charge","",""},{"Thunderous Roar","",""},{"Avatar","",""},{"Recklessness","",""},}) or "").."\n/startattack\n/cleartarget [dead]\n/use [nocombat,noexists]Tosselwrench's Mega-Accurate Simulation Viewfinder;Frenzyheart Brew")
				EditMacro("WSxGen5",nil,nil,"/use "..(b("Rallying Cry","[mod:ctrl]",";") or "").."[equipped:Shields,nospec:3]Shield Slam;"..(b({{"Onslaught","",""},{"Revenge","",""},}) or "Slam").."\n/startattack\n/cleartarget [dead]\n/stopmacro [nomod]\n/use [mod]Gamon's Braid\n/roar")
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use "..(b({{"Shockwave","",""},{"Thunderous Roar","",""},{"Avatar","",""},{"Bladestorm","",""},}) or "[spec:2]Slam;Whirlwind").."\n/startattack")		
				if playerSpec == 3 then
					override = "Thunder Clap"
				else
					override = b("Whirlwind","","") or ""
				end		
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..(b({{"Bladestorm","[mod:ctrl]",";"},{"Recklessness","[mod:ctrl]",";"},{"Avatar","[mod:ctrl]",";"},}) or "")..override.."\n/startattack\n/use Words of Akunda")
				EditMacro("WSxSGen+6",nil,nil,"/use "..(b({{"Ravager","[@player]",""},{"Rampage","",""},{"Slam","",""},{"Sweeping Strikes","",""},}) or "[spec:3]Shield Block").."\n/targetenemy [noexists]\n/startattack")
				EditMacro("WSxGen8",nil,nil,"#show \n/use "..(b({{"Recklessness","",""},{"Cleave","",""},{"Sweeping Strikes","",""},{"Challenging Shout","",""},{"Whirlwind","",""},}) or ""))
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..(b({{"Champion's Spear","[@player,mod][@cursor]",""},{"Cleave","",""},{"Sweeping Strikes","",""},}) or "Slam"))
				EditMacro("WSxCSGen+2",nil,nil,"")
				EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Rend;Vrykul Toy Boat\n/use [nocombat]Vrykul Toy Boat Kit")
				EditMacro("WSxCSGen+4",nil,nil,"/use [mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Intervene")
				EditMacro("WSxCSGen+5",nil,nil,"//use [mod:alt,@party4,help,nodead][@party2,help,nodead][@targettarget,help,nodead]Intervene")
				EditMacro("WSxGenQ",nil,nil,"#show Pummel\n/use "..(b("Storm Bolt","[mod:alt,@focus,harm,nodead]",";") or "")..(b("Berserker Rage","[mod:shift]",";") or "").."[@mouseover,harm,nodead,nomod]Charge\n/use [@mouseover,harm,nodead,nomod][nomod]Pummel\n/use Mote of Light\n/use World Shrinker")
				EditMacro("WSxGenE",nil,nil,"#show\n/use [@mouseover,harm,nodead][]Charge\n/use [noexists,nocombat]Arena Master's War Horn\n/startattack\n/cleartarget [dead][help]\n/targetenemy [noharm]\n/use Prismatic Bauble")
				EditMacro("WSxCGen+E",nil,nil,"#show Battle Shout\n/use "..(b("Last Stand","","") or "").."\n/use Outrider's Bridle Chain"..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..(b({{"Intimidating Shout","[@mouseover,harm,nodead][]",""},{"Demoralizing Shout","[@mouseover,harm,nodead][]",""},}) or "").."\n/startattack\n/targetenemy [noexists]\n/targetlasttarget")
				EditMacro("WSxGenR",nil,nil,"#show "..(b("Spell Reflection","[spec:3]",";") or "").."Hamstring\n/use "..(b("Piercing Howl","[mod:shift]",";") or "")..(b("Intervene","[@mouseover,help,nodead,nomod][help,nodead,nomod]","") or "").."\n/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Hamstring\n/startattack")
				EditMacro("WSxGenT",nil,nil,"#show\n/use [@mouseover,harm,nodead][]Heroic Throw"..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]\n/use Blight Boar Microphone")
				EditMacro("WSxSGen+T",nil,nil,"#show Taunt\n/use [nocombat,noexists]Blight Boar Microphone;Taunt\n/targetenemy [noexists]")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..(b("Challenging Shout","","") or ""))
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..(b({{"Intervene","",""},{"Intimidating Shout","",""},{"Rallying Cry","",""},}) or ""))
				EditMacro("WSxGenF",nil,nil,"#show "..(b({{"Berserker Rage","",""},{"Intimidating Shout","",""},}) or "Farwater Conch").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;[@focus,harm,nodead]Pummel")
				EditMacro("WSxSGen+F",nil,nil,"#show "..(b("Spell Block","","") or "").."\n/use [@focus,harm,nodead]Charge\n/use [@focus,harm,nodead]Pummel\n/use [help,nocombat,mod:alt]B.B.F. Fist;[nocombat,noexists,mod:alt]Gastropod Shell;Faintly Glowing Flagon of Mead")
				EditMacro("WSxCGen+F",nil,nil,"#show\n/use "..(b("Demoralizing Shout") or "Battle Shout"))
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]S.F.E. Interceptor;"..(b({{"Shattering Throw","[@mouseover,harm,nodead][harm,nodead]",";"},{"Wrecking Throw","[@mouseover,harm,nodead][harm,nodead]",";"},{"Storm Bolt","[@mouseover,harm,nodead][harm,nodead]",";"},}) or "").."B.B.F. Fist\n/targetenemy [combat,noharm]")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(b("Storm Bolt") or "Victory Rush").."\n/use [noexists,nocombat]Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(b("Spell Block") or ""))
				EditMacro("WSxCSGen+G",nil,nil,"#show\n/use [nocombat,noexists]Hraxian's Unbreakable Will;"..(b("Bitter Immunity","","") or "Fyrakk's Frenzy").."\n/cancelaura Blessing of Protection\n/cancelaura Words of Akunda")
				EditMacro("WSxGenH",nil,nil,"#show Battle Shout\n/use [nomounted]Darkmoon Gazer;"..(b("Bitter Immunity") or "").."\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenX",nil,nil,"#show\n/use "..(b("Defensive Stance","[mod:alt,nostance:1]!",";") or "")..(b({{"Battle Stance","[mod:alt]!",";"},{"Berserker Stance","[mod:alt]!",";"},}) or "")..(b({{"Last Stand","[nomod]",""},{"Intimidating Shout","[nomod]",""},{"Rallying Cry","[nomod]",""},}) or "").."\n/targetfriend [mod:shift,nohelp]\n/use [mod:shift,help,nodead]Intervene\n/targetlasttarget [mod:shift]")	
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use Sylvanas' Music Box\n/run PetDismiss();\n/cry")
				EditMacro("WSxGenV",nil,nil,"/use "..(b("Heroic Leap","[@cursor]","") or "").."\n/use [nomod]Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
			-- Druid, dodo
			elseif class == "DRUID" then
				EditMacro("WSxGen1",nil,nil,"/use [@mouseover,help,dead][help,dead]Rebirth;"..(b("Innervate","[@mouseover,help,nodead][help,nodead]",";") or "").."[@mouseover,harm,nodead][harm,nodead]Moonfire;Druid and Priest Statue Set\n/use [nocombat,noform:1/4]!Prowl\n/targetenemy [noexists]")
				EditMacro("WSxSGen+1",nil,nil,"#show "..(b({{"Sunfire","",""},{"Tranquility","",""},}) or "Mark of the Wild").."\n/use [mod:alt,@party3,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Regrowth;Kalytha's Haunted Locket")
				EditMacro("WSxGen2",nil,nil,"/use [form:2]Shred;[form:1]Mangle;"..(b("Sunfire","[@mouseover,harm,nodead][harm,nodead]",";") or "")..(b("Invigorate","[@mouseover,help,nodead][help,nodead]",";") or "").."Moonfeather Statue\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+2",nil,nil,"#show\n/cancelaura X-Ray Specs\n/use [mod:alt,@party4,nodead][@mouseover,help,nodead][]Regrowth\n/use Gnomish X-Ray Specs")
				EditMacro("WSxGen3",nil,nil,"#show\n/use "..(b("Rake","[form:2]",";") or "")..(b("Ironfur","[form:1]",";") or "")..(b("Starsurge","","") or "").."\n/targetenemy [noexists]\n/use Desert Flute")
				EditMacro("WSxSGen+3",nil,nil,"#show "..(b("Rake","[]",";") or "").."Moonfire"..(b("Rake","\n/use [noform:2]Cat Form;[form:2]","\n/use !Prowl") or "")..(b("Lifebloom","\n/use [@mouseover,help,nodead][]","") or "")..(b("Thrash","\n/use [form:1/2]","\n/use [noform:1]Bear Form;[form:1]","") or ""))
				EditMacro("WSxGen4",nil,nil,"/use "..(b("Rip","[form:2]",";") or "")..(b("Pulverize","[form:1]",";") or "").."[form:2]Shred;[form:1]Mangle;"..(b("Starfire","[@mouseover,harm,nodead][]","") or "").."\n/targetenemy [noexists]\n/cleartarget [dead]\n/use [nocombat,nostealth,noform:1/4]!Prowl")
				overrideModAlt = ""
				if playerSpec == 4 and b("Rejuvenation") then overrideModAlt = "[@focus,help,nodead,mod:alt][@party1,help,nodead,mod:alt]Rejuvenation;"
				elseif b("Rejuvenation") then overrideModAlt = "[@party1,help,nodead,mod:alt]Rejuvenation;"
				end
				if playerSpec == 1 and b("Moonkin Form") then overrideModCtrl = "[noform:4]!Moonkin Form;"
				elseif playerSpec == 2 then overrideModCtrl = "[noform:2]!Cat Form;"
				elseif playerSpec == 3 then overrideModCtrl = "[noform:1]!Bear Form;"
				else overrideModCtrl = ""
				end
				EditMacro("WSxSGen+4",nil,nil,"/targetenemy [noexists]\n/use "..overrideModAlt..overrideModCtrl..(b({{"Stellar Flare","[nomod:alt,harm,nodead]","\n/use [nomod:alt]Bushel of Mysterious Fruit\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Stellar Flare\n/targetlasttarget"},{"New Moon","[harm,nodead]","\n/use Bushel of Mysterious Fruit"},{"Fury of Elune","[harm,nodead]","\n/use Bushel of Mysterious Fruit"},{"Tiger's Fury","[form:2]","\n/use Bushel of Mysterious Fruit"},{"Bristling Fur","[form:1]","\n/use Bushel of Mysterious Fruit"},{"Lifebloom","[@mouseover,help,nodead][]","\n/use Bushel of Mysterious Fruit"},}) or "\n/use Bushel of Mysterious Fruit"))
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..(b("Rejuvenation","[@party3,help,nodead,mod:alt]",";") or "")..(b({{"Heart of the Wild","",""},{"Grove Guardians","[@mouseover,help,nodead][]",""},{"Nourish","[@mouseover,help,nodead][]",""},{"Nature's Vigil","",""},{"Convoke the Spirits","[@mouseover,exists,nodead][]",""},{"Stampeding Roar","",""},}) or ""))	
				EditMacro("WSxGen5",nil,nil,"#show\n/use "..(b("Renewal","[mod:ctrl]",";") or "").."[form:1,harm,nodead]Mangle;[form:2,harm,nodead]Ferocious Bite;"..(b({{"Nourish","[@mouseover,help,nodead][help,nodead]",";"},{"Grove Guardians","[@mouseover,help,nodead][help,nodead]",";"},{"Maul","[noform:1]Bear Form;[form:1,harm,nodead]",";"},}) or "").."Wrath\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use "..(b("Rejuvenation","[@focus,help,nodead,mod:alt][@party2,help,nodead,mod:alt]",";") or "").."[nocombat,help,nodead]Corbyn's Beacon;"..(b({{"Lunar Beam","",""},{"Flourish","",""},{"Feral Frenzy","[noform:2]Cat Form;[form:2]",""},{"Tiger's Fury","[noform:2]Cat Form;[form:2]",""},{"Nourish","[@mouseover,help,nodead][]",""},{"Grove Guardians","[@mouseover,help,nodead][]",""},{"Warrior of Elune","",""},{"Force of Nature","[@cursor]",""},{"Wild Mushroom","",""},{"Cenarion Ward","[@mouseover,help,nodead][]",""},}) or "").."\n/use [spec:2/3]Bloodmane Charm;Compendium of the New Moon")
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod:ctrl,@party4,help,nodead]Rejuvenation;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14")
				EditMacro("WSxGen6",nil,nil,"#show\n/use "..(b({{"Celestial Alignment","[mod,@cursor]",";"},{"Incarnation: Chosen of Elune","[mod]!",";"},{"Incarnation: Avatar of Ashamane","[mod]!",";"},{"Incarnation: Guardian of Ursoc","[mod]!",";"},{"Berserk","[mod]",";"},{"Tranquility","[mod]",";"},{"Incarnation: Tree of Life","[mod]!",";"},}) or "")..(b("Thrash","[form:1/2]",";[spec:2,noform:1/2]Cat Form;[spec:3,noform:1/2]Bear Form;") or "")..(b("Starfall","[]",";") or "")..(b("Sunfire","[@mouseover,harm,nodead][harm,nodead]","") or "")..(b("Nature's Swiftness","[]","") or "")..(b("Tranquility","\n/stopmacro\n/use ","") or ""))
				EditMacro("WSxSGen+6",nil,nil,"#show\n/use "..(b("Primal Wrath","[form:2]",";") or "")..(b("Wild Growth","[@mouseover,help,nodead][]","") or "").."\n/use Kaldorei Wind Chimes\n/use [nocombat,noexists]Friendsurge Defenders")
				
				EditMacro("WSxGen7",nil,nil,"/stopspelltarget\n/use "..(b({{"Efflorescence","[mod,@player][@mouseover,exists,nodead,noform:1/2][@cursor,noform:1/2]",";"},{"Wild Mushroom","[mod,@player,noform:1/2][noform:1/2]",";"},}) or "")..(b({{"Fury of Elune","[@mouseover,harm,nodead,noform:1/2][noform:1/2]",";"},{"Starfall","[noform:1/2]",";"},}) or "")..(b("Swipe","[noform:1/2]Cat Form;[form:1/2]","") or ""))
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..(b("Invigorate","[@mouseover,help,nodead,mod][mod]",";") or "")..(b({{"Fury of Elune","",""},{"New Moon","",""},{"Incarnation: Tree of Life","!",""},{"Convoke the Spirits","",""},{"Adaptive Swarm","[@mouseover,exists,nodead][]",""},{"Cenarion Ward","",""},{"Overgrowth","[@mouseover,help,nodead][]",""},{"Nature's Vigil","",""},{"Ironfur","",""},{"Starfall","",""},}) or ""))
				if b("Starfall") and (covA ~= "Ravenous Frenzy" or covA ~= "Kindred Spirits" or covA ~= "Adaptive Swarm") then override = "Starfall"
				else
					override = (b({{"Rage of the Sleeper","[noform:1]Bear Form;[form:1]",""},{"Adaptive Swarm","[@mouseover,exists,nodead][]",""},{"Incarnation: Tree of Life","!",""},{"Convoke the Spirits","",""},{"Astral Communion","",""},{"Tiger's Fury","",""},{"Bristling Fur","",""},{"Cyclone","",""},}) or "")
				end
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..override)
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,spec:4,@party3,help,nodead][spec:4,@party1,help,nodead][spec:4,@targettarget,help,nodead]Nature's Cure;[mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Remove Corruption\n/use [nocombat]Spirit of Bashiok")
				EditMacro("WSxCSGen+3",nil,nil,"/use [mod:alt,spec:4,@party4,help,nodead][spec:4,@party2,help,nodead]Nature's Cure;[mod:alt,@party4,help,nodead][@party2,help,nodead]Remove Corruption")
				EditMacro("WSxCSGen+4",nil,nil,"/use "..(b("Stellar Flare","[spec:1,@focus,harm,nodead]",";") or "").."[mod:alt,@party3,help,nodead,spec:4][@focus,spec:4,help,nodead][@party1,help,nodead,spec:4]Lifebloom;[mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead]Rejuvenation") 
				EditMacro("WSxCSGen+5",nil,nil,"/use [mod:alt,@party4,help,nodead,spec:4][@focus,spec:4,help,nodead][@party2,help,nodead,spec:4][@targettarget,help,nodead,spec:4]Lifebloom;[mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead][@targettarget,help,nodead]Rejuvenation")
				EditMacro("WSxGenQ",nil,nil,"/use "..(b("Cyclone","[mod:alt,@focus,harm,nodead]",";") or "")..(b({{"Skull Bash","[@mouseover,harm,nodead,form:1/2][form:1/2]",";[noform:1/2]Cat Form"},{"Solar Beam","[@mouseover,harm,nodead][]",""},{"Ursol's Vortex","[@cursor]",""},}) or ""))
				EditMacro("WSxGenE",nil,nil,"#show "..(b({{"Incapacitating Roar","",""},{"Mighty Bash","",""},{"Ursol's Vortex","",""},{"Mass Entanglement","",""},{"Cyclone","",""},}) or "").."\n/use "..(b("Frenzied Regeneration","[noform:1,mod:alt]Bear Form;[form:1,mod:alt]",";") or "")..(b("Wild Charge","[help,nodead,noform][form:1/2]","") or "").."\n/use [noform:1]!Prowl\n/use [combat,noform:1/2]Bear Form(Shapeshift)\n/targetenemy [noexists]\n/cancelform [help,nodead]\n/use [nostealth]Prismatic Bauble")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(b("Solar Beam","[mod:alt,@focus,harm,nodead]",";") or "")..(b({{"Nature's Swiftness","",""},{"Renewal","",""},{"Frenzied Regeneration","[noform:1]Bear Form;[form:1]",""},}) or "").."\n/use [nocombat]Mylune's Call"..oOtas..covToys)	
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..(b({{"Ursol's Vortex","[mod:alt,@player]",";"},{"Solar Beam","[mod:alt,@focus,harm,nodead]",";"},}) or "")..(b({{"Incapacitating Roar","",""},{"Mighty Bash","",""},{"Solar Beam","[@mouseover,harm,nodead][]",""},}) or "").."\n/use [nomod]!Prowl")
				EditMacro("WSxGenR",nil,nil,(b("Wild Charge","/cancelform [form,@mouseover,help,nodead,nomod]\n/use [@mouseover,help,nodead,nomod]","\n") or "").."/use "..(b("Stampeding Roar","[mod:ctrl]",";") or "")..(b("Typhoon","[nomod:shift]",";") or "")..(b({{"Ursol's Vortex","[@cursor,mod:shift][nomod,@cursor]",""},{"Mass Entanglement","[mod:shift][nomod]",""},}) or "[@mouseover,harm,nodead][]Entangling Roots"))
				EditMacro("WSxGenT",nil,nil,"#show "..(b("Frenzied Regeneration") or "Entangling Roots").."\n/use [mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][harm,nodead]Entangling Roots"..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+T",nil,nil,"#show [nocombat,noform:1]Prowl;Growl\n/use [noform:1]Bear form(Shapeshift);Growl\n/use [spec:3]Highmountain War Harness\n/cancelaura [noform:1]Highmountain War Harness\n/use Hunter's Call")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..(b({{"Cenarion Ward","[@party4,help,nodead,mod:alt][@mouseover,help,nodead][help,nodead][@party2,help,nodead][]",""},{"Invigorate","[@party4,help,nodead,mod:alt][@mouseover,help,nodead][help,nodead][@party2,help,nodead][]",""},}) or ""))
				EditMacro("WSxGenU",nil,nil,"#show "..(b("Renewal","[]",";") or "").."[resting]Treant Form;Prowl\n/use Treant Form")
				EditMacro("WSxGenF",nil,nil,"#show Barkskin\n/focus [@mouseover,exists]mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt]Farwater Conch;"..(b({{"Skull Bash","[@focus,harm,nodead,form:1/2]",";[@focus,harm,nodead,noform:1/2]Bear Form;"},{"Solar Beam","[@focus,harm,nodead]",";"},}) or "").."Charm Woodland Creature")
				EditMacro("WSxSGen+F",nil,nil,"#show [exists,nocombat]Charm Woodland Creature"..(b("Stampeding Roar",";","") or "").."\n/cancelform [mod:alt]\n/use [mod:alt,nocombat]Gastropod Shell;"..(b("Wild Charge","[nomod:alt,form:3/6]",";") or "").."[nomod:alt,noform:3/6]Travel Form(Shapeshift)\n/stopspelltarget\n/use Prismatic Bauble")
				EditMacro("WSxCGen+F",nil,nil,"#show [nocombat,noexists]Mushroom Chair"..(b({{"Cenarion Ward",";",""},{"Nature's Vigil",";",""},{"Heart of the Wild",";",""},}) or "").."\n/use [nocombat,noexists]Mushroom Chair"..(b({{"Nature's Vigil",";",""},{"Heart of the Wild",";",""},}) or ""))
				EditMacro("WSxCAGen+F",nil,nil,"#show "..(b({{"Innervate","",""},{"Renewal","",""},}) or "Mark of the Wild").."\n/use [nocombat,noexists]Tear of the Green Aspect\n/targetfriend [nohelp,nodead]\n/cancelform [help,nodead]\n/use [help,nodead]Wild Charge\n/targetlasttarget\n/use Prismatic Bauble")
				EditMacro("WSxGenG",nil,nil,"/use [nocombat,noexists,mod]Darkmoon Gazer;"..(b("Stampeding Roar","[mod]",";") or "")..(b({{"Nature's Cure","[@mouseover,help,nodead][]",""},{"Remove Corruption","[@mouseover,help,nodead][]",""},{"Soothe","[@mouseover,harm,nodead][]",""},}) or "Mark of the Wild").."\n/use Poison Extraction Totem")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(b("Maim","[form:2]",";") or "")..(b("Soothe","[]","") or "").."\n/use [noexists,nocombat]Flaming Hoop\n/targetenemy [noexists]") 
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(b({{"Overgrowth","[@party3,help,nodead,mod:alt][@mouseover,help,nodead][help,nodead][@party1,help,nodead][]",""},{"Invigorate","[@party3,help,nodead,mod:alt][@mouseover,help,nodead][help,nodead][@party1,help,nodead][]",""},{"Cenarion Ward","[@party3,help,nodead,mod:alt][@mouseover,help,nodead][help,nodead][@party1,help,nodead][]",""},}) or ""))
				EditMacro("WSxCSGen+G",nil,nil,"#show Dash\n/use [spec:4,@focus,help,nodead]Nature's Cure;[@focus,help,nodead]Remove Corruption\n/use Choofa's Call\n/cancelaura Blessing of Protection\n/cancelaura Enthralling")
				EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt,nocombat]Nature's Beacon;[mod]Barkskin;"..(b({{"Ironbark","[@mouseover,help,nodead][]",""},{"Survival Instincts","",""},{"Frenzied Regeneration","[noform:1]Bear Form;[form:1]",""},}) or "Barkskin").."\n/use [mod:alt]Gateway Control Shard")
				EditMacro("WSxGenX",nil,nil,"/use [mod:alt]Mount Form;[noform:2,mod:shift]!Cat Form;[mod:shift]Dash;"..(b("Hibernate","[mod:ctrl,harm,nodead]",";") or "")..(b({{"Dreamwalk","[mod:ctrl]",";"},{"Teleport: Moonglade","[mod:ctrl]",";"},}) or "")..(b("Ironfur","[form:1]",";") or "")..(b("Swiftmend","[@mouseover,help,nodead][]","") or "").."\n/stopmacro [stealth]\n/use Path of Elothir\n/use Prismatic Bauble")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/use "..(b("Frenzied Regeneration","[noform:1]Bear Form;[form:1]","") or "").."\n/run PetDismiss();")
				EditMacro("WSxGenV",nil,nil,"#show "..(b("Wild Charge","","") or "").."\n/use "..(b("Moonkin Form","[noform:4]",";") or "")..(b("Wild Charge","[@mouseover,exists,nodead][]","") or "").."\n/use Panflute of Pandaria\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
			-- Demon Hunter, DH, Fannyvision, Dihy 
			elseif class == "DEMONHUNTER" then
				EditMacro("WSxGen1",nil,nil,"#show\n/use [@cursor]Fel Rush\n/targetenemy [noexists]\n/startattack\n/use Prismatic Bauble")
				EditMacro("WSxSGen+1",nil,nil,"#show\n/use Skull of Corruption")
				EditMacro("WSxGen2",nil,nil,"#show\n/use [nocombat,noexists]Verdant Throwing Sphere\n/targetlasttarget [noexists,nocombat]\n/use [harm,dead,nocombat,nomod]Soul Inhaler;[spec:1]Demon's Bite;[spec:2]Shear\n/cleartarget [dead]\n/targetenemy [noexists]\n/startattack")
				EditMacro("WSxSGen+2",nil,nil,"#show "..(b({{"Fel Eruption","",""},{"Fel Devastation","",""},}) or "Gnomish X-Ray Specs").."\n/use Gnomish X-Ray Specs\n/use "..(b({{"Fel Eruption","",""},{"Fel Devastation","",""},}) or "Gnomish X-Ray Specs").."\n/startattack\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGen3",nil,nil,"#show\n/use "..(b({{"Felblade","",""},{"Demon Spikes","",""},}) or "[@mouseover,harm,nodead][]Throw Glaive").."\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]\n/use Imp in a Ball")
				EditMacro("WSxSGen+3",nil,nil,"#show\n/use [@mouseover,harm,nodead,nomod:alt][nomod:alt]Throw Glaive;[nocombat]Legion Pocket Portal\n/targetenemy [noexists]\n/startattack\n/stopmacro [nomod:alt]\n/targetlasttarget\n/use Throw Glaive\n/targetlasttarget")
				EditMacro("WSxGen4",nil,nil,"#show\n/use "..(b({{"Demon Spikes","",""},{"Eye Beam","",""},}) or "").."\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxSGen+4",nil,nil,"#show\n/stopspelltarget\n/use "..(b({{"Sigil of Flame","[@mouseover,exists,nodead][@cursor]",""},{"Glaive Tempest","",""},{"Fel Barrage","",""},{"Shear","",""},}) or "").."\n/startattack\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/use "..(b({{"The Hunt","[@mouseover,harm,nodead][]",""},{"Bulk Extraction","",""},{"Soul Barrier","",""},{"Fel Barrage","",""},{"Glaive Tempest","",""},{"Darkness","",""},{"Fiery Brand","[@mouseover,harm,nodead][]",""},{"Fel Blade","",""},}) or "Shadowy Disguise").."\n/targetenemy [noexists]\n/startattack")
				EditMacro("WSxGen5",nil,nil,"#show\n/use "..(b("Darkness","[mod:ctrl]",";") or "").."Chaos Strike\n/use [mod:ctrl]Shadescale\n/startattack\n/targetenemy [noexists]")
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use [spec:2,@player]Infernal Strike;"..(b({{"Essence Break","",""},{"Glaive Tempest","",""},{"Chaos Nova","",""},}) or "").."\n/targetenemy [noexists]\n/startattack")
				EditMacro("WSxGen6",nil,nil,"#show\n/stopspelltarget\n/use [mod:ctrl,@mouseover,exists,nodead][mod:ctrl,@cursor]Metamorphosis;"..(b({{"Soul Carver","",""},{"Blade Dance","",""},{"Immolation Aura","",""},}) or "").."\n/targetenemy [noexists]\n/use [mod:ctrl]Shadowy Disguise\n/use [mod:ctrl]Shadow Slicing Shortsword")
				EditMacro("WSxSGen+6",nil,nil,"#show\n/use "..(b({{"Sigil of Flame","[@player]",""},{"Demon Spikes","",""},{"Immolation Aura","",""},}) or "").."\n/stopspelltarget")
				EditMacro("WSxGen7",nil,nil,"#show\n/stopspelltarget\n/use "..(b("Elysian Decree","[@player,mod:shift]",";") or "")..(b({{"Spirit Bomb","",""},{"Soul Carver","",""},{"Immolation Aura","",""},}) or "").."\n/targetenemy [noexists]")
				EditMacro("WSxGen8",nil,nil,"#show\n/stopspelltarget\n/use "..(b({{"Elysian Decree","[@player,mod:shift][@mouseover,exists,nodead][@cursor]",""},{"Glaive Tempest","",""},{"Fel Barrage","",""},{"Immolation Aura","",""},}) or ""))
				EditMacro("WSxGen9",nil,nil,"#show\n/stopspelltarget\n/use "..(b({{"Fel Barrage","",""},{"Chaos Nova","",""},}) or "Immolation Aura"))
				EditMacro("WSxCSGen+2",nil,nil,"")
				EditMacro("WSxCSGen+3",nil,nil,"/use [nocombat,noexists]The Perfect Blossom;[@focus,harm,nodead]Throw Glaive;Fel Petal;")
				EditMacro("WSxCSGen+4",nil,nil,"")
				EditMacro("WSxCSGen+5",nil,nil,"/clearfocus")
				EditMacro("WSxGenQ",nil,nil,"/use "..(b("Imprison","[mod:alt,@focus,harm,nodead]",";") or "").."[@mouseover,harm,nodead][]Disrupt")
				EditMacro("WSxGenE",nil,nil,"#show\n/stopspelltarget\n/use "..(b("Sigil of Misery","[@mouseover,exists,nodead,nomod:alt][@cursor,nomod:alt]",";") or "")..(b("Chaos Nova","[mod:alt][]","") or ""))
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(b("Sigil of Misery","[mod:alt,@player]","") or "")..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use "..(b({{"Sigil of Silence","[mod:alt,@player][@cursor]",""},{"Sigil of Misery","[mod:alt,@player][@cursor]",""},}) or ""))
				EditMacro("WSxGenR",nil,nil,"#show\n/use "..(b("Netherwalk","[mod:ctrl]!",";") or "")..(b("Sigil of Chains","[mod:ctrl,@player][mod:shift,@cursor]",";") or "").."[mod:alt,@focus,harm,nodead][@mouseover,harm,nodead][]Throw Glaive\n/startattack")
				EditMacro("WSxGenT",nil,nil,"#show\n/use !Spectral Sight"..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+T",nil,nil,"#show Torment\n/use "..(b("Sigil of Chains","[mod:alt,@player]",";") or "").."Torment\n/targetenemy [noexists]\n/cleartarget [dead]")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use ")
				EditMacro("WSxGenU",nil,nil,"#show\n/use "..(b({{"Darkness","",""},{"Chaos Nova","",""},}) or ""))
				EditMacro("WSxGenF",nil,nil,"#show "..(b("Sigil of Misery") or "").."\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,exists,nodead]All-Seer's Eye;[mod:alt]Legion Communication Orb;[@focus,harm,nodead]Disrupt;[nocombat,noexists]Micro-Artillery Controller")
				EditMacro("WSxSGen+F",nil,nil,"#show "..(b({{"Sigil of Silence","",""},{"Chaos Nova","",""},{"Netherwalk","!",""},}) or "").."\n/use [help,nocombat,mod:alt]B. F. F. Necklace;[nocombat,noexists,mod:alt]Gastropod Shell\n/cancelaura Spectral Sight")
				EditMacro("WSxCGen+F",nil,nil,"#show Glide\n/cancelaura Wyrmtongue Disguise")
				EditMacro("WSxCAGen+F",nil,nil,"#show "..(b("Sigil of Chains","","") or "Fel Rush").."\n/run if not InCombatLockdown() then if GetSpellCharges(195072)>=1 then "..tpPants.." else "..noPants.." end end")
				EditMacro("WSxGenG",nil,nil,"#show\n/use [mod:alt]S.F.E. Interceptor;"..(b("Consume Magic","[@mouseover,harm,nodead][]","") or "").."\n/use Mirror of Humility")
				EditMacro("WSxSGen+G",nil,nil,"/use "..(b({{"Fel Eruption","",""},{"Chaos Nova","",""},{"Consume Magic","",""},}) or "").."\n/use [noexists,nocombat] Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use ")
				EditMacro("WSxCSGen+G",nil,nil,"#show\n/use "..(b("Consume Magic","[@focus,harm,nodead]",";") or "")..(b("Chaos Nova") or "").."\n/use Wisp Amulet\n/cancelaura Netherwalk\n/cancelaura Spectral Sight\n/cancelaura Blessing of Protection")
				EditMacro("WSxGenH",nil,nil,"#show Spectral Sight\n/use Wisp Amulet\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenZ",nil,nil,"#show\n/use [mod:alt]Gateway Control Shard;"..(b({{"Fiery Brand","[@mouseover,harm,nodead][]",""},{"Blur","",""},{"Darkness","",""},}) or ""))
				EditMacro("WSxGenX",nil,nil,"#show\n/use "..(b({{"Netherwalk","[mod:shift][]!",""},{"Soul Barrier","",""},{"Bulk Extraction","",""},}) or "").."\n/use Shadescale")
				EditMacro("WSxGenC",nil,nil,"#show\n/use "..(b("Imprison","[@mouseover,harm,nodead][]","") or "").."\n/cancelaura X-Ray Specs")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/run PetDismiss();\n/cry")
				EditMacro("WSxGenV",nil,nil,"#show\n/use "..(b("Vengeful Retreat","","") or "").."\n/use Panflute of Pandaria\n/use Haw'li's Hot & Spicy Chili\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble")
			-- Evoker, Dracthyr, Debra, Dragon, augussy, lizzy
			elseif class == "EVOKER" then
				EditMacro("WSxGen1",nil,nil,"#show\n/use "..(b({{"Timelessness","[@mouseover,help,nodead][]",""},{"Echo","[@mouseover,help,nodead][]",""},{"Pyre","[@mouseover,harm,nodead][]",""},}) or "Hover").."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+1",nil,nil,"#show "..(b("Blessing of the Bronze") or "Living Flame").."\n/use [mod:alt,@party3,help,nodead][mod:ctrl,@party2,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Living Flame")
				EditMacro("WSxGen2",nil,nil,"#show Azure Strike\n/use Gnomish X-Ray Specs\n/use [@mouseover,harm,nodead][]Azure Strike\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxSGen+2",nil,nil,"/use [mod:alt,@party4,help,nodead][@mouseover,help,nodead][help,nodead][@player]Living Flame\n/targetlasttarget [noexists,nocombat]\n/use [help,nodead]Rainbow Generator\n/use Prismatic Bauble\n/cleartarget [dead]")
				EditMacro("WSxGen3",nil,nil,"#show\n/use "..(b({{"Upheaval","[@mouseover,harm,nodead][]",""},{"Eternity Surge","[@mouseover,harm,nodead][]",""},{"Spiritbloom","[@mouseover,help,nodead][]",""},}) or "Fire Breath(Red)").."\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxGen4",nil,nil,"#show\n/use [@mouseover,harm,nodead][]Disintegrate\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxSGen+4",nil,nil,"#show\n/stopspelltarget\n/use "..(b({{"Prescience","[@party1,help,nodead,mod:alt]",";"},{"Reversion","[@party1,help,nodead,mod:alt]",";"},}) or "")..(b({{"Ebon Might","",""},{"Shattering Star","",""},{"Firestorm","[@mouseover,exists,nodead][@cursor]",""},{"Pyre","",""},{"Temporal Anomaly","",""},}) or "").."\n/cleartarget [dead]\n/targetenemy [noexists]")
				EditMacro("WSxCGen+4",nil,nil,"#show\n/stopspelltarget\n/use [@party3,help,nodead,mod:alt]Reversion;[@mouseover,exists,nodead][@cursor]Deep Breath\n/targetenemy [noexists]\n/startattack")
				EditMacro("WSxGen5",nil,nil,"#show "..(b({{"Zephyr","[mod:ctrl]",";"},{"Cauterizing Flame","[mod:ctrl]",";"},{"Time Spiral","[mod:ctrl]",";"},}) or "").."Living Flame\n/use "..(b({{"Zephyr","[mod:ctrl]",";"},{"Cauterizing Flame","[mod:ctrl]",";"},{"Time Spiral","[mod:ctrl]",";"},}) or "").."[@mouseover,harm,nodead][harm,nodead]Living Flame\n/targetenemy [noexists]\n/use [mod:ctrl] Golden Dragon Goblet")
				EditMacro("WSxSGen+5",nil,nil,"#show\n/use "..(b({{"Prescience","[@party2,help,nodead,mod:alt]",";"},{"Reversion","[@party2,help,nodead,mod:alt]",";"},}) or "")..(b("Tip the Scales","","") or "").."\n/targetenemy [noexists]\n/startattack")
				EditMacro("WSxAGen+5",nil,nil,"#show 14\n/targetenemy [noexists]\n/target [nocombat,noexists]Squirrel\n/use [mod:ctrl,@party4,help,nodead]Reversion;[nocombat,noexists]Critter Hand Cannon;[harm,nocombat]Hozen Idol;[help,dead,nocombat]Cremating Torch;14")
				EditMacro("WSxGen6",nil,nil,"#show\n/cast "..(b({{"Time Skip","[mod:ctrl]",";"},{"Dragonrage","[mod:ctrl]",";"},{"Emerald Communion","[mod:ctrl]!",";"},}) or "").."Fire Breath(Red)".."\n/targetenemy [noexists]")
				EditMacro("WSxSGen+6",nil,nil,"#show\n/cast "..(b({{"Dream Breath","",""},{"Rewind","",""},{"Firestorm","[@player]",""},{"Emerald Blossom","[@mouseover,help,nodead][help,nodead][@player]",""},}) or ""))
				EditMacro("WSxGen7",nil,nil,"#show\n/stopspelltarget\n/cast "..(b({{"Firestorm","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Dream Flight(Green)","[mod:shift,@player][@mouseover,exists,nodead][@cursor]",""},{"Pyre","[@mouseover,harm,nodead][]",""},{"Emerald Blossom","[mod:shift,@player][@mouseover,help,nodead][help,nodead][@cursor]",""},{"Echo","[@mouseover,help,nodead][]",""},}) or "[@mouseover,harm,nodead][]Azure Strike").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGen8",nil,nil,"#show\n/use "..(b("Prescience","","") or "[@mouseover,harm,nodead][]Azure Strike").."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxGen9",nil,nil,"#show\n/use "..(b({{"Spatial Paradox","",""},{"Pyre","",""},{"Obsidian Scales","",""},}) or ""))
				EditMacro("WSxCSGen+2",nil,nil,"/use [mod:alt,@party3,help,nodead,spec:2][@party1,help,nodead,spec:2][@targettarget,help,nodead,spec:2]Naturalize;[mod:alt,@party3,help,nodead][@party1,help,nodead][@targettarget,help,nodead]Expunge")
				EditMacro("WSxCSGen+3",nil,nil,"/use [@focus,harm,nodead]Living Flame;[mod:alt,@party4,help,nodead,spec:2][@party2,help,nodead,spec:2]Naturalize;[mod:alt,@party4,help,nodead][@party2,help,nodead]Expunge\n/use [nocombat,noharm]Forgotten Feather")
				EditMacro("WSxCSGen+4",nil,nil,"/use "..(b("Blistering Scales","[mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]","") or "")..(b("Echo","[mod:alt,@party3,help,nodead][@focus,help,nodead][@party1,help,nodead][@targettarget,help,nodead]","") or "").."\n/use [@party1]Apexis Focusing Shard")
				EditMacro("WSxCSGen+5",nil,nil,"/use "..(b("Blistering Scales","[mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]","\n/use ") or "")..(b("Echo","[mod:alt,@party4,help,nodead][@focus,help,nodead][@party2,help,nodead]","\n/use ") or "").."Battle Standard of Coordination\n/use [@party2]Apexis Focusing Shard")
				EditMacro("WSxGenQ",nil,nil,"/use "..(b("Sleep Walk","[mod:alt,@focus,harm,nodead]",";") or "")..(b("Quell","[@mouseover,harm,nodead][]","") or ""))
				EditMacro("WSxGenE",nil,nil,"#show\n/use Tail Swipe")
				EditMacro("WSxCGen+E",nil,nil,"#show\n/use "..(b("Oppressing Roar","","") or "Hover")..oOtas..covToys)
				EditMacro("WSxSGen+E",nil,nil,"#show\n/use [@mouseover,help,nodead][help,nodead][@player]Emerald Blossom")
				EditMacro("WSxGenR",nil,nil,"#show\n/stopspelltarget\n/use "..(b("Time Spiral","[mod:ctrl]",";") or "[mod:ctrl]Hover;")..(b("Landslide","[@mouseover,exists,nodead,nomod][@cursor,nomod]",";") or "[nomod]Wing Buffet;").."[mod:shift]Wing Buffet\n/startattack")
				EditMacro("WSxGenT",nil,nil,"#show\n/use "..(b("Verdant Embrace","[@mouseover,help,nodead][]","") or "")..swapblaster.."\n/targetenemy [noexists]\n/cleartarget [dead]")
				EditMacro("WSxSGen+T",nil,nil,"#show"..(b("Rescue","\n/stopspelltarget\n/targetfriendplayer [nohelp,nodead]\n/use [@cursor]","") or "").."\n/cleartarget [dead]\n/use Seafarer's Slidewhistle")
			    EditMacro("WSxCGen+T",nil,nil,"#show\n/use "..(b("Verdant Embrace","[mod:alt,@party4,nodead][@party2,nodead]","") or ""))
				EditMacro("WSxGenU",nil,nil,"#show "..(b({{"Sleep Walk","",""},{"Mass Return","",""},}) or "Return"))
				EditMacro("WSxGenF",nil,nil,"#show Wing Buffet\n/focus [@mouseover,exists] mouseover\n/stopmacro [@mouseover,exists]\n/use [mod:alt,exists,nodead]All-Seer's Eye;[mod:alt]Farwater Conch;"..(b("Quell","[@focus,harm,nodead]","") or ""))
				EditMacro("WSxSGen+F",nil,nil,"#show [nocombat,noexists]Soar;Wing Buffet\n/use [help,nocombat,mod:alt]B. F. F. Necklace;[nocombat,noexists,mod:alt]Gastropod Shell\n/use Soar\n/use Hover")
				EditMacro("WSxCGen+F",nil,nil,"#show\n/use "..(b({{"Spatial Paradox","[@mouseover,help,nodead][]",""},{"Rewind","",""},{"Zephyr","",""},{"Tip the Scales","",""},}) or "Fire Festival Batons"))
				EditMacro("WSxCAGen+F",nil,nil,"#show Emerald Blossom\n/use [nocombat,noexists]Tear of the Green Aspect"..(b("Verdant Embrace","\n/targetfriend [nohelp,nodead]\n/use [help,nodead]","\n/targetlasttarget") or "").."\n/use Prismatic Bauble")
				EditMacro("WSxGenG",nil,nil,"/use [mod:alt]Darkmoon Gazer;"..(b("Unravel","[@mouseover,harm,nodead]",";") or "")..(b("Naturalize","[spec:2,@mouseover,help,nodead][spec:2]",";") or "")..(b("Expunge","[@mouseover,help,nodead][]","") or "").."\n/targetenemy [noexists]\n/use Poison Extraction Totem")
				EditMacro("WSxSGen+G",nil,nil,"#show\n/use "..(b("Unravel","[@mouseover,harm,nodead][harm,nodead]",";") or "").."Expunge\n/use [noexists,nocombat]Flaming Hoop")
			    EditMacro("WSxCGen+G",nil,nil,"#show\n/use "..(b("Verdant Embrace","[mod:alt,@party3,nodead][@party1,nodead]","") or ""))
				EditMacro("WSxCSGen+G",nil,nil,"#show\n/use [@focus,help,nodead,spec:2]Naturalize;"..(b("Expunge","[@focus,help,nodead]",";") or "").."\n/use Choofa's Call")
				EditMacro("WSxGenH",nil,nil,"#show\n/use "..(b("Cauterizing Flame","[@mouseover,help,nodead][]",";") or "").."Wisp Amulet\n/run if not (InCombatLockdown()) then if IsMounted() then DoEmote(\"mountspecial\") end end")
				EditMacro("WSxGenZ",nil,nil,"#show\n/use "..(b("Black Attunement","[mod:alt,nostance:1]!",";") or "")..(b("Bronze Attunement","[mod:alt,stance:1]!",";") or "")..(b("Time Dilation","[@mouseover,help,nodead,nomod][nomod]",";") or "")..(b("Obsidian Scales","[mod:shift][]","") or "").."\n/use [mod:alt]Gateway Control Shard")
				EditMacro("WSxGenX",nil,nil,"#show\n/use "..(b("Bestow Weyrnstone","[@mouseover,help,nodead,mod:alt][mod:alt]",";") or "")..(b("Recall","[mod:shift]",";") or "")..(b("Renewing Blaze","","") or "Emerald Blossom").."\n/use Shadescale")
				EditMacro("WSxAGen+C",nil,nil,"#show\n/run PetDismiss();\n/cry")
				EditMacro("WSxGenV",nil,nil,"#show\n/use Hover\n/use [nomod]Panflute of Pandaria\n/use Haw'li's Hot & Spicy Chili\n/cancelaura Rhan'ka's Escape Plan\n/use Prismatic Bauble\n/use Whelps on Strings")
				if playerSpec == 3 then
					EditMacro("WSxCAGen+B",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxCGen+G\",nil,nil,\"\\#show Prescience\\n/use [@\"..N..\"]Prescience\\n/stopspelltarget\", nil)print(\"PSci 1 : \"..N)else print(\"Combat?\")end")
					EditMacro("WSxCAGen+N",nil,nil,"/run if not InCombatLockdown()then local N=UnitName(\"target\") EditMacro(\"WSxCGen+T\",nil,nil,\"\\#show Prescience\\n/use [@\"..N..\"]Prescience\\n/stopspelltarget\", nil)print(\"PSci 2 : \"..N)else print(\"Combat?\")end")
				end 
			end -- avslutar class
		end	-- avslutar racials[race]			
	end -- events	
end

ZigiAllButtons:SetScript("OnEvent", function(self, event)
	-- Delay the first load
	if not loaded and not InCombatLockdown() then
		loaded = true
		C_Timer.After(1, function()
			eventHandler(event)
			-- print("loaded-event:",event)
			loaded = false
		end) 
	end

	if loaded then
		if event == "PLAYER_REGEN_ENABLED" then
			ZigiAllButtons:UnregisterEvent("PLAYER_REGEN_ENABLED")
		end 

		if not locked then
			locked = true
			C_Timer.After(1, function()
				eventHandler(event)
				-- print("locked-event:",event)
				locked = false	
			end)
		end
	end
end)