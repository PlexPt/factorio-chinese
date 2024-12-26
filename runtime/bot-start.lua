storage.chinese_bot_count = storage.chinese_bot_count or 1

local function isopen()
    local open = settings.global["chinese-bot-start"] and settings.global["chinese-bot-start"].value
    return open
end

-- 日志函数
local function log_message(message)
    if chinese_debug then
        log("[chinese-bot-start] " .. message)
    end
end

-- 验证物品是否存在
local function validate_item(itemName)
    if prototypes.item[itemName] then
        return true
    end
    log_message("警告: 物品 " .. itemName .. " 不存在")
    return false
end

-- 模组管理器

storage.chinese_bot_current_items = storage.chinese_bot_current_items or {}
storage.chinese_bot_current_armor_modules = storage.chinese_bot_current_items or {}


-- 处理 Space Age 模组
local function process_space_age()
    storage.chinese_bot_current_items["Battery"] = "battery-mk3-equipment"
    storage.chinese_bot_current_items["Armor"] = "mech-armor"
    storage.chinese_bot_current_items["Reactor"] = "fusion-reactor-equipment"
    log_message("已加载 Space Age 模组配置")
end

-- 处理 Bob's Equipment 模组
local function process_bob_equipment()
    storage.chinese_bot_current_items["Reactor"] = "fusion-reactor-equipment-4"
    storage.chinese_bot_current_items["Shield"] = "energy-shield-mk6-equipment"
    storage.chinese_bot_current_items["Roboport"] = "personal-roboport-mk4-equipment"
    storage.chinese_bot_current_items["Battery"] = "battery-mk6-equipment"
    storage.chinese_bot_current_items["LaserDefense"] = "personal-laser-defense-equipment-6"
    storage.chinese_bot_current_items["Exoskeleton"] = "exoskeleton-equipment-3"
    storage.chinese_bot_current_items["Nightvision"] = "night-vision-equipment-3"
end

-- 处理 Krastorio2 模组
local function process_krastorio2()
    storage.chinese_bot_current_items["Armor"] = "power-armor-mk4"

    -- 根据chinese-tiny设置调整模块数量
    if settings.startup["chinese-tiny-enable"] and settings.startup["chinese-tiny-enable"].value then
        storage.chinese_bot_current_armor_modules = {
            { Name = storage.chinese_bot_current_items["Reactor"], Count = 8 },
            { Name = storage.chinese_bot_current_items["Roboport"], Count = 8 },
            { Name = storage.chinese_bot_current_items["Shield"], Count = 8 },
            { Name = storage.chinese_bot_current_items["Battery"], Count = 4 },
            { Name = storage.chinese_bot_current_items["Nightvision"], Count = 1 },
            { Name = storage.chinese_bot_current_items["Exoskeleton"], Count = 8 },
        }
    else
        storage.chinese_bot_current_armor_modules = {
            { Name = storage.chinese_bot_current_items["Reactor"], Count = 4 },
            { Name = storage.chinese_bot_current_items["Roboport"], Count = 4 },
            { Name = storage.chinese_bot_current_items["Shield"], Count = 4 },
            { Name = storage.chinese_bot_current_items["Battery"], Count = 2 },
            { Name = storage.chinese_bot_current_items["Nightvision"], Count = 1 },
            { Name = storage.chinese_bot_current_items["Exoskeleton"], Count = 4 },
        }
    end
end

-- 处理 Bob's Warfare 模组
local function process_bob_warfare()
    storage.chinese_bot_current_items["Armor"] = "bob-power-armor-mk5"

    -- 根据chinese-tiny设置调整模块数量
    if settings.startup["chinese-tiny-enable"] and settings.startup["chinese-tiny-enable"].value then
        storage.chinese_bot_current_armor_modules = {
            { Name = storage.chinese_bot_current_items["Reactor"], Count = 16 },
            { Name = storage.chinese_bot_current_items["Roboport"], Count = 8 },
            { Name = storage.chinese_bot_current_items["Shield"], Count = 8 },
            { Name = storage.chinese_bot_current_items["Battery"], Count = 4 },
            { Name = storage.chinese_bot_current_items["Nightvision"], Count = 1 },
            { Name = storage.chinese_bot_current_items["Battery"], Count = 8 },
            { Name = storage.chinese_bot_current_items["Exoskeleton"], Count = 10 },
            { Name = storage.chinese_bot_current_items["LaserDefense"], Count = 32 },
        }
    else
        storage.chinese_bot_current_armor_modules = {
            { Name = storage.chinese_bot_current_items["Reactor"], Count = 8 },
            { Name = storage.chinese_bot_current_items["Roboport"], Count = 4 },
            { Name = storage.chinese_bot_current_items["Shield"], Count = 4 },
            { Name = storage.chinese_bot_current_items["Battery"], Count = 2 },
            { Name = storage.chinese_bot_current_items["Nightvision"], Count = 1 },
            { Name = storage.chinese_bot_current_items["Battery"], Count = 4 },
            { Name = storage.chinese_bot_current_items["Exoskeleton"], Count = 5 },
            { Name = storage.chinese_bot_current_items["LaserDefense"], Count = 16 },
        }
    end
end


-- 处理模组兼容性
local function process_mods()
    local modProcessors = {
        ["space-age"] = process_space_age,
        ["bobequipment"] = process_bob_equipment,
        ["boblogistics"] = function()
            storage.chinese_bot_current_items["Robot"] = "bob-construction-robot-5"
        end,
        ["Krastorio2"] = process_krastorio2,
        ["bobwarfare"] = process_bob_warfare
    }
    for modName, processor in pairs(modProcessors) do
        if script.active_mods[modName] then
            processor()
        end
    end
end

-- 初始化模组配置
local function init_mod_manager()

    -- 配置文件
    local ConfigData = {
        -- 基础装备原型定义
        ItemPrototypes = {
            Armor = "power-armor-mk2", -- 动力装甲
            Robot = "construction-robot", -- 建设机器人
            Reactor = "fission-reactor-equipment", -- 裂变反应堆(4x4)
            Exoskeleton = "exoskeleton-equipment", -- 外骨骼(2x4)
            Shield = "energy-shield-mk2-equipment", -- 能量护盾(2x2)
            Roboport = "personal-roboport-mk2-equipment", -- 机器人指令平台(2x2)
            Battery = "battery-mk2-equipment", -- 电池(1x2)
            LaserDefense = "personal-laser-defense-equipment", -- 激光防御(2x2)
            Nightvision = "night-vision-equipment", -- 夜视设备(2x2)
        },

        -- 默认装甲模块配置 (原版 10x10 网格)
        DefaultArmorModules = {
            { Name = "fission-reactor-equipment", Count = 4 },
            { Name = "personal-roboport-mk2-equipment", Count = 4 },
            { Name = "battery-mk2-equipment", Count = 2 },
            { Name = "energy-shield-mk2-equipment", Count = 4 },
        },

        -- 扩展装甲模块配置 (用于chinese-tiny mod)
        ExtendedArmorModules = {
            { Name = "fission-reactor-equipment", Count = 8 },
            { Name = "personal-roboport-mk2-equipment", Count = 8 },
            { Name = "battery-mk2-equipment", Count = 8 },
            { Name = "energy-shield-mk2-equipment", Count = 8 },
            { Name = "exoskeleton-equipment", Count = 8 },
            { Name = "personal-laser-defense-equipment", Count = 8 },
            { Name = "night-vision-equipment", Count = 1 },
            { Name = "belt-immunity-equipment", Count = 1 },
        }
    }

    storage.chinese_bot_current_items = ConfigData.ItemPrototypes
    -- 根据chinese-tiny设置选择装甲模块配置
    if settings.startup["chinese-tiny-enable"] and settings.startup["chinese-tiny-enable"].value then
        storage.chinese_bot_current_armor_modules = ConfigData.ExtendedArmorModules
        log_message("启用扩展装甲模块配置")
    else
        storage.chinese_bot_current_armor_modules = ConfigData.DefaultArmorModules
    end
    process_mods()
end

-- 装备管理器

-- 插入初始物品
local function insert_starting_items(player)
    -- 插入建设机器人
    if validate_item(storage.chinese_bot_current_items["Robot"]) then
        player.insert { name = storage.chinese_bot_current_items["Robot"], count = storage.chinese_bot_count }
    end
end

-- 清理现有装备
local function clear_existing_armor(player, armorInventory)
    if not armorInventory.is_empty() then
        local currentArmor = armorInventory[1].name
        armorInventory.clear()
        -- 从玩家主背包中移除旧护甲
        local playerInventory = player.get_inventory(defines.inventory.character_main)
        if playerInventory then
            playerInventory.remove(currentArmor)
        end
    end
end

-- 插入新护甲
local function insert_new_armor(armorInventory)
    if not validate_item(storage.chinese_bot_current_items["Armor"]) then
        return false
    end
    if armorInventory.is_empty() then
        local insertCount = armorInventory.insert {
            name = storage.chinese_bot_current_items["Armor"],
            count = 1
        }
        return insertCount > 0
    end
    return false
end

-- 插入护甲模块
local function insert_armor_modules(grid)
    if not grid then
        log_message("错误: 护甲网格无效")
        return
    end

    for _, module in pairs(storage.chinese_bot_current_armor_modules) do
        if validate_item(module.Name) then
            for i = 1, module.Count do
                grid.put({ name = module.Name })
            end
        end
    end
end


-- 检查并装备护甲
local function equip_armor(player, needclear)
    local botLevel = settings.global["chinese-bot-start"].value
    if botLevel == "关闭" then
        return
    end

    if not (player and player.valid and player.connected and player.character) then
        log_message("错误: 无效的玩家")
        return
    end
    --  game.player.get_inventory(defines.inventory.character_armor)[1].grid.put({ name = "personal-laser-defense-equipment" })
    local armorInventory = player.get_inventory(defines.inventory.character_armor)
    if not armorInventory then
        log_message("警告: 玩家 " .. player.name .. " 没有装备栏")
        return
    end

    -- 插入初始物品
    insert_starting_items(player)

    if needclear then
        -- 清理现有装备
        clear_existing_armor(player, armorInventory)
    end

    -- 装备新护甲
    local success = insert_new_armor(armorInventory)
    if success then
        local armor_grid = armorInventory[1].grid
        if armor_grid then
            insert_armor_modules(armor_grid)
        else
            log_message("错误: 无法获取护甲网格")
        end
    end
end

local function check_bot_level()
    local botLevel = settings.global["chinese-bot-start"].value

    local botCounts = {
        ["关闭"] = 1,
        ["简易"] = 50,
        ["豪华"] = 200,
        ["尊享"] = 400
    }

    storage.chinese_bot_count = botCounts[botLevel] or 1
end

check_bot_level()

-- 初始化脚本
script.on_init(function(event)
    if isopen() then
        check_bot_level()
        -- 初始化模组管理器
        init_mod_manager()
    end
end)

-- 注册玩家创建事件
script.on_event(defines.events.on_player_created, function(event)
    if isopen() then
        check_bot_level()

        init_mod_manager()

        local player = game.get_player(event.player_index)

        equip_armor(player, true)
    end
end)

-- 注册过场动画结束事件
script.on_event(defines.events.on_cutscene_cancelled, function(event)
    if isopen() then
        local player = game.get_player(event.player_index)
        equip_armor(player, true)
    end
end)

script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
    if event and event.setting and event.setting == "chinese-bot-start"
            and settings.global["chinese-bot-start"].value then
        local botLevel = settings.global["chinese-bot-start"].value
        if botLevel == "关闭" then
            return
        end

        check_bot_level()

        -- 初始化模组管理器
        init_mod_manager()
        for _, player in pairs(game.players) do
            equip_armor(player, false)
        end
    end
end)


--"葛优躺" - 极致休闲模式
--"佛系" - 随缘，不强求
--"卷王" - 最高性能模式
--"打工人" - 标准经济实用款
--"土豪" - 比豪华更豪横
--"修仙" - 终极节能模式
--"摆烂" - 比关闭还要关闭
--"梦游" - 半开不开状态
--"火力全开" - 超豪华加强版
--"王炸" - 终极奢华模式

