local _,class = UnitClass("player")
local classSkillList = {
	["SHAMAN"] = {
		-- Hero Talent: Farseer
		[443454] = "Ancestral Swiftness",
		-- Hero Talent: Totemic, resto: Surging Totem replaces Healing Rain, so no need to remap really.
		[444995] = "Surging Totem",
		--
		[457481] = "Tidecaller's Guard",
		[462757] = "Thunderstrike Ward",
		[318038] = "Flametongue Weapon",
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
		[428332] = "Primordial Wave(Shadowlands)",
		[375982] = "Primordial Wave",
		[51505] = "Lava Burst",
		[114050] = "Ascendance",
		[382021] = "Earthliving Weapon",
		[198838] = "Earthen Wall Totem",
		[191634] = "Stormkeeper",
		[192063] = "Gust of Wind",
		[61882] = "Earthquake",
		[462620] = "Earthquake",
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
		[108270] = "Stone Bulwark Totem",
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
		[462854] = "Skyfury",
	},
	["MAGE"] = {
		-- Hero Talent: Frostfire
		-- [431044] = "Frostfire Bolt",
		--
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
		-- Hero Talent: Hellcaller
		[442726] = "Malevolence",
		--
		[688] = "Summon Imp",
		[268358] = "Demonic Circle",
		[417537] = "Oblivion",
		[386689] = "Demonic Healthstone",
		[6201] = "Create Healthstone",
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
		-- Hero Talent: Conduit of the Celestials
		[443028] = "Celestial Conduit",
		-- 
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
		[460485] = "Chi Burst",
		[123986] = "Chi Burst",
		[132578] = "Invoke Niuzao, the Black Ox",
		[116847] = "Rushing Jade Wind",
		[392983] = "Strike of the Windlord",
		[450391] = "Chi Wave",
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
		-- Hero Talent: Lightsmith
		[432459] = "Holy Armaments",
		--
		[433568] = "Rite of Sanctification(Weapon Imbue)",
		[433583] = "Rite of Adjuration(Weapon Imbue)",
		[465] = "Devotion Aura",
		[317920] = "Concentration Aura",
		[32223] = "Crusader Aura",
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
		[198034] = "Divine Hammer",
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
	-- Hero Talent: Dark Ranger, BM/MM
		[430703] = "Black Arrow",
		--
		[53480] = "Roar of Sacrifice",
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
		[462031] = "Implosive Trap",
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
		-- [200806] = "Exsanguinate",
		[271877] = "Blade Rush",
		[385408] = "Sepsis",
		[277925] = "Shuriken Tornado",
	},
	["PRIEST"] = {
		-- Hero Talent: Oracle
		[428924] = "Premonition",
		--
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
		[15286] = "Vampiric Embrace",
		[73325] = "Leap of Faith",
		[205385] = "Shadow Crash",
		[457042] = "Shadow Crash",
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
		-- Hero Talent: Deathbringer
		[439843] = "Reaper's Mark",
		--
		[61999] = "Raise Ally",
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
		-- Hero Talent: Colossus
		[436358] = "Demolish",
		--
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
		[449193] = "Fluid Form", 
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
		[400254] = "Raze",
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
		[390163] = "Sigil of Spite",
		[258925] = "Fel Barrage",
		[263648] = "Soul Barrier",
		[320341] = "Bulk Extraction",
	},
	["EVOKER"] = { 
	-- Hero Talent: Flameshaper
		[443328] = "Engulf",
		[355913] = "Emerald Blossom",
		[364342] = "Blessing of the Bronze",
		[390386] = "Fury of the Aspects",
		[360823] = "Naturalize",
		[364343] = "Echo",
		[374968] = "Time Spiral",
		[406732] = "Spatial Paradox",
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

-- bind to function, has two override subroutines for arrays and nested array types
function Get_Spell(spellName, macroCond, semiCol)
	-- Skriv om så att jag inte behöver sätta overrides innan anropen, lägg till stöd för parameter-overriding för arrays och strängar, vill kunna skicka in arrayer med spells.
	if not InCombatLockdown() then
		-- if string
		if type(spellName) == "string" then 
			for k,v in pairs(classSkillList[class]) do
				if v == spellName then
					if IsPlayerSpell(k) or IsSpellKnown(k) then
						-- spellName = (select(1,GetSpellInfo(k)))
						spellName = C_Spell.GetSpellInfo(k).name
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
								-- spellName = (select(1,GetSpellInfo(k)))
								spellName = C_Spell.GetSpellInfo(k).name
								-- print(spellName)
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
							-- spellName = (select(1,GetSpellInfo(k)))
							spellName = C_Spell.GetSpellInfo(k).name
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

function Get_Pet_Spell(spellName, macroCond, semiCol)
	if not InCombatLockdown() then 
		for k,v in pairs(commandPetAbilities[class]) do
			if v == spellName then
				if IsSpellKnownOrOverridesKnown(k) then
					-- spellName = (select(1,GetSpellInfo(k)))
					spellName = C_Spell.GetSpellInfo(k).name
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
