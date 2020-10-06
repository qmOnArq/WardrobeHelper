local o = mOnWardrobe
if o.additionalData == nil then o.additionalData = {} end
local a = o.additionalData

-- Difficulties: LFR, N, H, M, 10, 25, 10H, 25H
-- LinkDifficulties: LFR, N - default, H, M

---------------------------------------------------------------
--  WoD - Raids
---------------------------------------------------------------

a[457] = {} -- Blackrock Foundry
a[457]["N"] = {items = {Trash = {119332, 119342, 119333, 119340, 119334, 119339, 119331, 119341}}}
a[457]["H"] = {items = {Trash = {119332, 119342, 119333, 119340, 119334, 119339, 119331, 119341}}, linkDifficulty = "H"}
a[457]["M"] = {items = {Trash = {119332, 119342, 119333, 119340, 119334, 119339, 119331, 119341}}, linkDifficulty = "M"}

a[669] = {} -- Hellfire Citadel
a[669]["N"] = {items = {Trash = {124182, 124150, 124277, 124252, 124311, 124288, 124350, 124323}}}
a[669]["H"] = {items = {Trash = {124182, 124150, 124277, 124252, 124311, 124288, 124350, 124323}}, linkDifficulty = "H"}
a[669]["M"] = {items = {Trash = {124182, 124150, 124277, 124252, 124311, 124288, 124350, 124323}}, linkDifficulty = "M"}

a[477] = {} -- Highmaul
a[477]["N"] = {items = {Trash = {119343, 119347, 119346, 119344, 119345, 119336, 119335, 119338, 119337}}}
a[477]["H"] = {items = {Trash = {119343, 119347, 119346, 119344, 119345, 119336, 119335, 119338, 119337}}, linkDifficulty = "H"}
a[477]["M"] = {items = {Trash = {119343, 119347, 119346, 119344, 119345, 119336, 119335, 119338, 119337}}, linkDifficulty = "M"}

---------------------------------------------------------------
--  MoP - Raids
---------------------------------------------------------------

a[330] = {} -- Heart of Fear
a[330]["LFR"] = {items = {Trash = {86850, 86844, 86841, 86845, 86843, 86847, 86842, 86846, 86849, 86848}}}
a[330]["10"]  = {items = {Trash = {86192, 86186, 86183, 86187, 86185, 86189, 86184, 86188, 86191, 86190}}}
a[330]["25"] = a[330]["10"]

a[362] = {} -- Throne of Thunder
a[362]["10"] = {items = {
  Trash = { 95207, 95208, 95224, 95223, 95210, 95209, 95221, 95219, 95211, 95212,
            95220, 95222, 95215, 95214, 95213, 95218, 95217, 95216},
  ['Shared Loot'] = { 95061, 95067, 95066, 95065, 95062, 95060, 95064, 95068, 95063,
                      95069, 95498, 95507, 95502, 95501, 95505, 95499, 95500, 95503,
                      95506, 97126, 95504, 95516}}}
a[362]["25"] = a[362]["10"]
a[362]["10H"] = {items = {
  ['Shared Loot'] = { 96607, 96609, 96608, 96612, 96613, 96614, 96615, 96618, 96617,
                      96616, 96621, 96606, 96620, 96604, 96619, 96602, 96611, 96603,
                      96610, 97127, 96605, 96622}}}
a[362]["25H"] = a[362]["10H"]
a[362]["LFR"] = {items = {
  ['Shared Loot'] = { 95863, 95865, 95864, 95868, 95869, 95870, 95871, 95874, 95873,
                      95872, 95877, 95862, 95876, 95860, 95875, 95858, 95867, 95859,
                      95866, 97129, 95861, 95878, 95961, 95962, 95965, 95963, 95971,
                      95970, 95966, 95959, 95972, 95973, 95960, 95967, 95976, 95975,
                      95974, 95979, 95978, 95968 }}}

a[369] = {} -- Siege of Orgrimmar
a[369]["N"] = {items = {
  Trash = {113224, 113231, 113226, 113230, 113223, 113225, 113218,
           113220, 113221, 113222, 113227, 113228, 113219, 113229,
           105745, 105747, 105743, 105748, 105744, 105741, 105746,
           105742}}}
a[369]["H"] = {items = {
  Trash = {113224, 113231, 113226, 113230, 113223, 113225, 113218,
           113220, 113221, 113222, 113227, 113228, 113219, 113229,
           105745, 105747, 105743, 105748, 105744, 105741, 105746,
           105742}}, linkDifficulty = "H"}
a[369]["M"] = {items = {
  Trash = {113224, 113231, 113226, 113230, 113223, 113225, 113218,
           113220, 113221, 113222, 113227, 113228, 113219, 113229,
           105745, 105747, 105743, 105748, 105744, 105741, 105746,
           105742}}, linkDifficulty = "M"}
a[369]["LFR"] = {items = {
  ['Shared Loot'] = {113224, 113231, 113226, 113230, 113223, 113225, 113218,
                     113220, 113221, 113222, 113227, 113228, 113219, 113229}}, linkDifficulty = "LFR"}

---------------------------------------------------------------
--  Cataclysm - Raids
---------------------------------------------------------------

a[73] = {} -- Blackwing Descent
a[73]["10"] = {items = {Trash = {59466, 59468, 59467, 59465, 59464, 59462, 59463, 63537, 63538, 68601, 59460}}}
a[73]["25"] = a[73]["10"]

a[72] = {} -- The Bastion of Twilight
a[72]["10"] = {items = {Trash = {60211, 60202, 60201, 59901, 59521, 59525, 60210}}}
a[72]["25"] = a[72]["10"]

a[187] = {} -- Dragon Soul
a[187]["10"] = {items = {Trash = {78879, 78884, 78882, 78886, 78885, 78887, 78888, 78889, 78878, 77192, 77938}}}
a[187]["25"] = a[187]["10"]

a[78] = {} -- Firelands
a[78]["10"] = {items = {['Shared Loot'] = {71779, 71787, 71785, 71780, 71776, 71782, 71775},
  Trash = {71640, 71365, 71359, 71362, 71361, 71360, 71366}}}
a[78]["25"] = a[78]["10"]
a[78]["10H"] = {items = {['Shared Loot'] = {71778, 71786, 71784, 71781, 71777, 71783, 71774},
  Vendor = {71641, 71561, 71560, 71562, 71557, 71559, 71558, 71579, 71575}}}
a[78]["25H"] = a[78]["10H"]

---------------------------------------------------------------
--  Cataclysm - Dungeons
---------------------------------------------------------------

a[66] = {} -- Blackrock Caverns
a[66]["N"] = {items = {Trash = {55790, 55789}}}

a[184] = {} -- End Time
a[184]["H"] = {items = {Trash = {76154, 76156}}}

a[71] = {} -- Grim Batol
a[71]["N"] = {items = {Trash = {56219, 56218}}}

a[70] = {} -- Halls of Origination
a[70]["N"] = {items = {Trash = {56109}}}

a[186] = {} -- Hour of Twilight
a[186]["N"] = {items = {Trash = {76160, 76161}}}

a[69] = {} -- Lost City of the Tol'vir
a[69]["N"] = {items = {Trash = {55882}}}

a[67] = {} -- The Stonecore
a[67]["N"] = {items = {Trash = {55824, 55822, 55823}}}

a[68] = {} -- The Vortex Pinnacle
a[68]["N"] = {items = {Trash = {55855}}}

a[65] = {} -- Throne of the Tides
a[65]["N"] = {items = {Trash = {55260}}}

a[185] = {} -- Well of Eternity
a[185]["N"] = {items = {Trash = {76158, 76157, 76159}}}

a[77] = {} -- Zul'Aman
a[77]["N"] = {items = {Trash = {69797, 69801},
  ["Time Chest"] = {69584, 69585, 69589, 69586, 69590, 69593, 69587, 69588, 69591, 69592}}}

a[76] = {} -- Zul'Gurub
a[76]["N"] = {items = {Trash = {69800, 69796, 69798, 69803}}}

---------------------------------------------------------------
--  WotLK - Raids
---------------------------------------------------------------

a[758] = {} -- Icecrown Citadel
a[758]["25"] = {items = {Trash = {50449, 50450, 50451, 50444}}}

a[754] = {} -- Naxxramas
a[754]["10"] = {items = {Trash = {39467, 39427, 39468, 39473}}}
a[754]["25"] = {items = {Trash = {40410, 40409, 40414, 40408, 40407, 40406}}}

a[759] = {} -- Ulduar
a[759]["10"] = {items = {Trash = {46341, 46347, 46344, 46346, 46345, 46340, 46339, 46351, 46350, 46342}}}
a[759]["25"] = {items = {Trash = {45541, 45549, 45547, 45548, 45543, 45544, 45542, 45605}}}

---------------------------------------------------------------
--  WotLK - Dungeons
---------------------------------------------------------------

a[271] = {} -- Ahn'kahet: The Old Kingdom
a[271]["N"] = {items = {Trash = {35616, 35615}}}
a[271]["H"] = {items = {Trash = {37625}}}

a[272] = {} -- Azjol-Nerub
a[272]["H"] = {items = {Trash = {37243, 37625}}}

a[273] = {} -- Drak'Tharon Keep
a[273]["N"] = {items = {Trash = {35641, 35640, 35639}}}
a[273]["H"] = {items = {Trash = {37799, 37800, 37801}}}

a[274] = {} -- Gundrak
a[274]["N"] = {items = {Trash = {35594, 35593}}}
a[274]["H"] = {items = {Trash = {37647, 37648}}}

a[275] = {} -- Halls of Lightning
a[275]["N"] = {items = {Trash = {36997, 37000, 36999}}}
a[275]["H"] = {items = {Trash = {37858, 37857, 37856}}}

a[276] = {} -- Halls of Reflection
a[276]["N"] = {items = {Trash = {49832, 49828, 49830, 49831, 49829, 49827}}}
a[276]["H"] = {items = {Trash = {50292, 50293, 50295, 50294, 50290, 50291}}}

a[277] = {} -- Halls of Stone
a[277]["N"] = {items = {Trash = {35682, 35681}}}
a[277]["H"] = {items = {Trash = {37673, 37672, 37671}}}

a[278] = {} -- Pit of Saron
a[278]["N"] = {items = {Trash = {49854, 49855, 49853, 49852}}}
a[278]["H"] = {items = {Trash = {50318, 50315, 50319}}}

a[279] = {} -- The Culling of Stratholme
a[279]["N"] = {items = {Trash = {37117, 37116, 37115}}}

a[280] = {} -- The Forge of Souls
a[280]["N"] = {items = {Trash = {49854, 49855, 49853, 49852}}}
a[280]["H"] = {items = {Trash = {50318, 50315, 50319}}}

a[282] = {} -- The Oculus
a[282]["N"] = {items = {Trash = {36978, 36977, 36976}}}
a[282]["H"] = {items = {Trash = {37366, 37365, 37364}}}

a[283] = {} -- The Violet Hold
a[283]["N"] = {items = {Trash = {35654, 35653, 35652}}}
a[283]["H"] = {items = {Trash = {35654, 37890, 37891, 35653, 37889, 35652}}}

a[285] = {} -- Utgarde Keep
a[285]["N"] = {items = {Trash = {35580, 35579}}}
a[285]["H"] = {items = {Trash = {37197, 37196}}}

a[286] = {} -- Utgarde Pinnacle
a[286]["N"] = {items = {Trash = {37070, 37069, 37068}}}
a[286]["H"] = {items = {Trash = {37587, 37590}}}

---------------------------------------------------------------
--  TBC - Raids
---------------------------------------------------------------

a[751] = {} -- Black Temple
a[751]["N"] = {items = {Trash = {32590, 34012, 32609, 32593, 32592, 32608, 32606, 34009, 32943, 34011}}}

a[750] = {} -- The Battle for Mount Hyjal
a[750]["N"] = {items = {Trash = {32590, 34010, 32609, 32592, 34009, 32946, 32945}}}

a[745] = {} -- Karazhan
a[745]["N"] = {items = {Trash = {30642, 30668, 30673, 30644, 30674, 30643, 30641}}}

a[748] = {} -- Serpentshrine Cavern
a[748]["N"] = {items = {Trash = {30027, 30021}}}

a[752] = {} -- Sunwell Plateau
a[752]["N"] = {items = {Trash = {34351, 34407, 34350, 34409, 34183, 34346, 34348, 34347}}}

a[749] = {} -- The Eye
a[749]["N"] = {items = {Trash = {30024, 30020, 30029, 30026, 30030}}}

a[-101] = {} -- Outland
a[-101]["N"] = {items = {['Doom Lord Kazzak'] = {30735, 30734, 30737, 30739, 30740, 30741, 30733, 30732},
  ['Doomwalker'] = {30729, 30725, 30727, 30730, 30728, 30731, 30723, 30722, 30724}}}

---------------------------------------------------------------
--  Vanilla - Raids
---------------------------------------------------------------

a[742] = {} -- Blackwing Lair
a[742]["N"] = {items = {Trash = {19436, 19437, 19438, 19439, 19362, 19354, 19358, 19435}}}

a[741] = {} -- Molten Core
a[741]["N"] = {items = {Trash = {16802, 16817, 16806, 16827, 16828, 16851, 16838, 16864, 16858,
                                           16799, 16819, 16804, 16825, 16830, 16850, 16840, 16861, 16857}}}

a[744] = {} -- Temple of Ahn'Qiraj
a[744]["N"] = {items = {Trash = {21838, 21888, 21889, 21856, 21837}}}

---------------------------------------------------------------
--  Vanilla - Dungeons
---------------------------------------------------------------

a[227] = {} -- Blackfathom Deeps
a[227]["N"] = {items = {Trash = {1486, 3416, 3413, 2567, 3417, 1454, 1481, 3414, 3415, 2271}}}

a[228] = {} -- Blackrock Depths
a[228]["N"] = {items = {Trash = {12552, 12551, 12542, 12546, 12550, 12547, 12549, 12555, 12531, 12535, 12527, 12528, 12532}}}

a[63] = {} -- Deadmines
a[63]["N"] = {items = {Trash = {1930, 1951, 1926}}}

a[230] = {} -- Dire Maul
a[230]["N"] = {items = {Trash = {18295, 18344, 18298, 18296, 18338},
  ["Tribute Chest"] = {18538, 18495, 18532, 18475, 18528, 18478, 18477,
                       18476, 18479, 18530, 18480, 18533, 18529, 18481,
                       18531, 18534, 18499, 18482}}}

a[231] = {} -- Gnomeregan
a[231]["N"] = {items = {Trash = {9508, 9491, 9509, 9510, 9490, 9485, 9486, 9488, 9487}}}

a[233] = {} -- Razorfen Downs
a[233]["N"] = {items = {Trash = {10574, 10581, 10578, 10583, 10582, 10584, 10573, 10570, 10571, 10567, 10572}}}

a[234] = {} -- Razorfen Kraul
a[234]["N"] = {items = {Trash = {2264, 1978, 1488, 4438, 776, 1727, 1975, 1976, 2549}}}

a[64] = {} -- Shadowfang Keep
a[64]["N"] = {items = {Trash = {1974, 3194, 1483, 2807, 1318, 1484}}}

a[236] = {} -- Stratholme
a[236]["N"] = {items = {Trash = {18743, 17061, 18745, 18744, 18736, 18742, 18741}}}

a[237] = {} -- The Temple of Atal'hakkar
a[237]["N"] = {items = {Trash = {10630, 10629, 10632, 10631, 10633, 10623, 10625, 10628, 10626, 10627, 10624}}}

a[239] = {} -- Uldaman
a[239]["N"] = {items = {Trash = {9397, 9431, 9429, 9420, 9430, 9406, 9428,
                                       9396, 9432, 9393, 9384, 9392, 9424, 9465,
                                       9383, 9425, 9386, 9427, 9423, 9391, 9381,
                                       9426, 9422},
  ["The Lost Dwarves"] = {9401, 9400, 9394, 9398, 9404, 9403}}}

a[240] = {} -- Wailing Caverns
a[240]["N"] = {items = {Trash = {10413}}}

a[241] = {} -- Zul'Farrak
a[241]["N"] = {items = {Trash = {9512, 9484, 5616, 9511, 9481, 9480, 9482, 9483, 2040}}}

