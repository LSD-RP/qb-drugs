Config = Config or {}
Config.MinimumDrugSalePolice = 0

Config.Products = {
    [1] = {
        name = "weed_white-widow",
        price = 15,
        amount = 150,
        info = {},
        type = "item",
        slot = 1,
        minrep = 0,
    },
    [2] = {
        name = "weed_skunk",
        price = 15,
        amount = 150,
        info = {},
        type = "item",
        slot = 2,
        minrep = 20,
    },
    [3] = {
        name = "weed_purple-haze",
        price = 15,
        amount = 150,
        info = {},
        type = "item",
        slot = 3,
        minrep = 40,
    },
    [4] = {
        name = "weed_og-kush",
        price = 15,
        amount = 150,
        info = {},
        type = "item",
        slot = 4,
        minrep = 60,
    },
    [5] = {
        name = "weed_amnesia",
        price = 15,
        amount = 150,
        info = {},
        type = "item",
        slot = 5,
        minrep = 80,
    },
    [6] = {
        name = "weed_white-widow_seed",
        price = 150,
        amount = 20,
        info = {},
        type = "item",
        slot = 6,
        minrep = 50,
    },
    [7] = {
        name = "oxy",
        price = 30,
        amount = 150,
        info = {},
        type = "item",
        slot = 7,
        minrep = 75,
    },
    [8] = {
        name = "weed_skunk_seed",
        price = 175,
        amount = 20,
        info = {},
        type = "item",
        slot = 8,
        minrep = 100,
    },
    [9] = {
        name = "xtcbaggy",
        price = 40,
        amount = 150,
        info = {},
        type = "item",
        slot = 9,
        minrep = 110,
    },
    [10] = {
        name = "weed_purple-haze_seed",
        price = 200,
        amount = 20,
        info = {},
        type = "item",
        slot = 10,
        minrep = 120,
    },
    [11] = {
        name = "weed_og-kush_seed",
        price = 225,
        amount = 20,
        info = {},
        type = "item",
        slot = 11,
        minrep = 150,
    },
    [12] = {
        name = "weed_amnesia_seed",
        price = 250,
        amount = 20,
        info = {},
        type = "item",
        slot = 12,
        minrep = 170,
    },


}

Config.Dealers = {}

Config.CornerSellingDrugsList = {
    "weed_white-widow",
    "weed_skunk",
    "weed_purple-haze",
    "weed_og-kush",
    "weed_amnesia",
    "weed_ak47",
    "crack_baggy",
    "cokebaggy",
    "meth"
}

Config.DrugsPrice = {
    ["weed_white-widow"] = {
        min = 25,
        max = 50,
    },
    ["weed_og-kush"] = {
        min = 30,
        max = 65,
    },
    ["weed_skunk"] = {
        min = 30,
        max = 65,
    },
    ["weed_amnesia"] = {
        min = 30,
        max = 65,
    },
    ["weed_purple-haze"] = {
        min = 25,
        max = 65,
    },
    ["weed_ak47"] = {
        min = 40,
        max = 80,
    },
    ["crack_baggy"] = {
        min = 22,
        max = 55,
    },
    ["cokebaggy"] = {
        min = 45,
        max = 110,
    },
    ["meth"] = {
        min = 25,
        max = 100,
    },
}

Config.DeliveryLocations = {
    [1] = {
        ["label"] = "Stripclub",
        ["coords"] = vector3(106.24, -1280.32, 29.24),
    },
    [2] = {
        ["label"] = "Vinewood Video",
	    ["coords"] = vector3(223.98, 121.53, 102.76),
    },
    [3] = {
        ["label"] = "Taxi",
	    ["coords"] = vector3(882.67, -160.26, 77.11),
    },
    [4] = {
        ["label"] = "Resort",
	    ["coords"] = vector3(-1245.63, 376.21, 75.34),
    },
    [5] = {
        ["label"] = "Bahama Mamas",
	    ["coords"] = vector3(-1383.1, -639.99, 28.67),
    },
    [6] = {
        ["label"] = "Paper",
        ["coords"] = vector3(0.1554, -1824.4092, 29.5414),
    },
    [7] = {
        ["label"] = "Pipe Dreams",
        ["coords"] = vector3(-1194.3107, -1189.0890, 7.6921),
    },
    [8] = {
        ["label"] = "Super Fly",
        ["coords"] = vector3(-1168.8407, -1572.7521, 4.6636),
    },
    [9] = {
        ["label"] = "Pier",
        ["coords"] = vector3(-1584.3921, -957.6338, 13.0174),
    },
    [10] = {
        ["label"] = "Richman Hill Hotel",
        ["coords"] = vector3(-1273.7734, 315.9627, 65.5118),
    },
    [11] = {
        ["label"] = "North Vinewood",
        ["coords"] = vector3(-496.6964, 84.5463, 55.8691),
    },
    [12] = {
        ["label"] = "Century Manor Retirement",
        ["coords"] = vector3(-77.4621, 364.6606, 112.4416),
    },
    [13] = {
        ["label"] = "Dolla Pills",
        ["coords"] = vector3(591.1708, 2744.7822, 42.0430),
    },
    [14] = {
        ["label"] = "Tyce",
        ["coords"] = vector3(-461.3307, 1101.4449, 327.6819),
    },
    [15] = {
        ["label"] = "Ruby",
        ["coords"] = vector3(1407.7456, 3618.9358, 34.8944),
    },
    [16] = {
        ["label"] = "NoTell Motel",
        ["coords"] = vector3(1613.0818, 3570.4294, 35.4332),
    },
    [17] = {
        ["label"] = "Trevor",
        ["coords"] = vector3(1964.2129, 3819.2314, 32.3969),
    },
    [18] = {
        ["label"] = "Grapeseed Airport",
        ["coords"] = vector3(2146.1030, 4782.0796, 41.0013),
    },
    [19] = {
        ["label"] = "Pops Pills",
        ["coords"] = vector3(157.0652, 6657.3862, 31.5592),
    },
    [20] = {
        ["label"] = "Pops Diner",
        ["coords"] = vector3(1587.1808, 6466.3242, 25.3172),
    },
    [21] = {
        ["label"] = "Clukin Bell Factory",
        ["coords"] = vector3(-6.3650, 6275.3413, 31.6365),
    },
    [22] = {
        ["label"] = "Jess",
        ["coords"] = vector3(-302.3519, 6286.2559, 31.4922),
    },
    [23] = {
        ["label"] = "Ammunation",
        ["coords"] = vector3(-342.3311, 6097.8496, 31.3130),
    },
    [24] = {
        ["label"] = "Bayview Lodge",
        ["coords"] = vector3(-689.3765, 5789.0029, 17.3309),
    },
    [25] = {
        ["label"] = "Hookies",
        ["coords"] = vector3(-2203.0112, 4244.5513, 48.3464),
    },
    [26] = {
        ["label"] = "Zancudo",
        ["coords"] = vector3(-2521.1604, 2310.4153, 33.2158),
    },
    [27] = {
        ["label"] = "Chumash",
        ["coords"] = vector3(-3252.1716, 1077.2245, 11.0333),
    },
    [28] = {
        ["label"] = "HangTen",
        ["coords"] = vector3(-2949.9238, 420.9854, 15.2811),
    },
    [29] = {
        ["label"] = "Marina",
        ["coords"] = vector3(-2033.7053, -275.7060, 23.3855),
    },
    [30] = {
        ["label"] = "Homeless",
        ["coords"] = vector3(10.4186, -1216.9514, 29.3348),
    },
    [31] = {
        ["label"] = "Flywheels",
        ["coords"] = vector3(-1174.7032, -1570.6056, 4.3563) ,
    },
    [32] = {
        ["label"] = "Nico",
        ["coords"] = vector3(-935.2894, 567.9108, 100.1620) ,
    },
    [33] = {
        ["label"] = "Boris",
        ["coords"] = vector3(295.0637, -1007.2582, 29.3353) ,
    },
    [34] = {
        ["label"] = "Jay",
        ["coords"] = vector3(1322.5233, -1736.7019, 54.3822) ,
    },
    [35] = {
        ["label"] = "Linden",
        ["coords"] = vector3(1417.2424, 6343.9126, 24.0036) ,
    },
    [36] = {
        ["label"] = "Sunday",
        ["coords"] = vector3(-956.3878, 578.7708, 101.1750) ,
    },

}

Config.CornerSellingZones = {
    [1] = {
	["coords"] = vector3(-1415.53, -1041.51, 4.62),
        ["time"] = {
            ["min"] = 12,
            ["max"] = 18,
        },
    },
}

Config.DeliveryItems = {
    [1] = {
        ["item"] = "weed_brick",
        ["minrep"] = 0,
    },
}