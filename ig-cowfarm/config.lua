cfg = {
    esxLegacy = true,

    blip = {
        ['blipcow'] = vector3(2458.1333, 4756.3159, 34.3039),
        ['blipcowname'] = "Karviu Ferma",
        ['sellmilk'] = vector3(1960.9851, 3754.2280, 32.2506),
        ['sellmilkname'] = "Pieno Pardavimas",
    },

    job = {
        ['job'] = "farmer"
    },

    marker = {
        ['sellmilk'] = vector3(1960.9205, 3754.1567, 32.2515)
    },

    translation = {
        ['sellmilk'] = "Parduoti Piena [E]",
        ['nomilk'] = "Jus Neturite Pieno",
        ['tryagain'] = "Bandyk Iš Naujo",
        ['getmilk'] = "Melžti Karve",
        ['limit'] = "Jus Neturite Vietos Inventoryje"
    },

    money = {
        ['permilk'] = "2"
    },

    karves = {
        {
            pos = {x = 2436.3179, y = 4760.4878, z = 33.3129, h = 192.7831}, --  2436.3179, 4760.4878, 34.3129, 192.7831
            model = 'a_c_cow',
            spawned = false,
        },
        {
            pos = {x = 2448.3845, y = 4774.1953, z = 33.4080, h = 86.3661}, -- 2448.3845, 4774.1953, 34.4080, 86.3661
            model = 'a_c_cow',
            spawned = false,
        },
        {
            pos = {x = 2430.7354, y = 4773.1631, z = 33.3923, h = 352.1471}, -- 2430.7354, 4773.1631, 34.3923, 352.1471
            model = 'a_c_cow',
            spawned = false,
        },
        {
            pos = {x = 2416.1936, y = 4777.7495, z = 33.4446, h = 75.2435}, -- 2416.1936, 4777.7495, 34.4446, 75.2435
            model = 'a_c_cow',
            spawned = false,
        },
        {
            pos = {x = 2400.8740, y = 4781.2285, z = 33.7055, h = 39.7833}, -- 2400.8740, 4781.2285, 34.7055, 39.7833
            model = 'a_c_cow',
            spawned = false,
        },
        {
            pos = {x = 2424.1934, y = 4790.5054, z = 33.8396, h = 284.1580}, -- 2424.1934, 4790.5054, 34.8396, 284.1580
            model = 'a_c_cow',
            spawned = false,
        },
        {
            pos = {x = 2441.3938, y = 4792.7886, z = 33.6690, h = 266.7509}, -- 2441.3938, 4792.7886, 34.6690, 266.7509
            model = 'a_c_cow',
            spawned = false,
        },
}

}
Notify = function(msg)
    --exports.bulletin:SendInfo(msg)
    ESX.ShowNotification(msg)
end