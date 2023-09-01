data:extend({
    {
        type = "bool-setting",
        name = "squeakthrough-enable",
        order = "aa",
        setting_type = "startup",
        default_value = false,
    }
})

data:extend({
    {
        type = "bool-setting",
        name = "chinese-tree-enable",
        order = "bb",
        setting_type = "startup",
        default_value = true,
    }
})

data:extend({
    {
        type = "bool-setting",
        name = "chinese-tiny-enable",
        setting_type = "startup",
        default_value = false
    },

})

data:extend({
    {
        type = "bool-setting",
        name = "chinese-inventorysize-enable",
        setting_type = "startup",
        order = "cc",
        default_value = false
    },
    {
        type = "int-setting",
        name = "chinese-inventorysize",
        setting_type = "startup",
        order = "cd",
        default_value = 300,
        minimum_value = 50,
        maximum_value = 2000,
    }
})
data:extend({
    {
        type = "bool-setting",
        name = "chinese-infinite-resources",
        setting_type = "startup",
        order = "ee",
        default_value = false
    }
})
data:extend({
    {
        type = "bool-setting",
        name = "chinese-pump",
        setting_type = "startup",
        order = "ef",
        default_value = false
    }
})

data:extend({
    {
        type = "bool-setting",
        name = "chinese-stack",
        setting_type = "startup",
        order = "f1",
        default_value = false
    },
    {
        type = "int-setting",
        name = "chinese-stack-factor",
        setting_type = "startup",
        default_value = 10,
        minimum_value = 1,
        maximum_value = 1000,
        order = "f2"
    },
    {
        type = "int-setting",
        name = "chinese-running-speed",
        setting_type = "startup",
        default_value = 1,
        minimum_value = 1,
        maximum_value = 100,
        order = "f3"
    }
})

data:extend({
    {
        type = "bool-setting",
        name = "chinese-reach-enable",
        setting_type = "runtime-global",
        order = "dd",
        default_value = false
    },
    {
        type = "int-setting",
        name = "chinese-reach-distance",
        setting_type = "runtime-global",
        order = "de",
        default_value = 160,
        maximum_value = 100000,
        minimum_value = 0,
    }
})
