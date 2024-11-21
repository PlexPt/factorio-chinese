storage.chinese_botCount = 1

-- 配置文件
local Config = {
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

-- 工具函数
local Utils = {
    -- 日志函数
    log = function(message)
        if chinese_debug then
            log("[Armor] " .. message)
        end
    end,

    -- 验证物品是否存在
    validateItem = function(itemName)
        if prototypes.item[itemName] then
            return true
        end
        Utils.log("警告: 物品 " .. itemName .. " 不存在")
        return false
    end

}

-- 模组管理器
local ModManager = {
    -- 当前物品配置
    currentItems = Config.ItemPrototypes,
    -- 当前装甲模块配置
    currentArmorModules = Config.DefaultArmorModules,

    -- 初始化配置
    init = function(self)
        self.currentItems = Config.ItemPrototypes
        -- 根据chinese-tiny设置选择装甲模块配置
        if settings.startup["chinese-tiny-enable"] and settings.startup["chinese-tiny-enable"].value then
            self.currentArmorModules = Config.ExtendedArmorModules
            Utils.log("启用扩展装甲模块配置")
        else
            self.currentArmorModules = Config.DefaultArmorModules
        end
        self:processMods()
    end,

    -- 处理模组兼容性
    processMods = function(self)
        local modProcessors = {
            ["space-age"] = self.processSpaceAge,
            ["bobequipment"] = self.processBobEquipment,
            ["boblogistics"] = function()
                self.currentItems["Robot"] = "bob-construction-robot-5"
            end,
            ["Krastorio2"] = self.processKrastorio2,
            ["bobwarfare"] = self.processBobWarfare
        }
        for modName, processor in pairs(modProcessors) do
            if script.active_mods[modName] then
                processor(self)
            end
        end
    end,

    -- 处理 Space Age 模组
    processSpaceAge = function(self)
        self.currentItems["Battery"] = "battery-mk3-equipment"
        self.currentItems["Armor"] = "mech-armor"
        self.currentItems["Reactor"] = "fusion-reactor-equipment"
        Utils.log("已加载 Space Age 模组配置")
    end,

    -- 处理 Bob's Equipment 模组
    processBobEquipment = function(self)
        self.currentItems["Reactor"] = "fusion-reactor-equipment-4"
        self.currentItems["Shield"] = "energy-shield-mk6-equipment"
        self.currentItems["Roboport"] = "personal-roboport-mk4-equipment"
        self.currentItems["Battery"] = "battery-mk6-equipment"
        self.currentItems["LaserDefense"] = "personal-laser-defense-equipment-6"
        self.currentItems["Exoskeleton"] = "exoskeleton-equipment-3"
        self.currentItems["Nightvision"] = "night-vision-equipment-3"
    end,

    -- 处理 Krastorio2 模组
    processKrastorio2 = function(self)
        self.currentItems["Armor"] = "power-armor-mk4"

        -- 根据chinese-tiny设置调整模块数量
        if settings.startup["chinese-tiny-enable"] and settings.startup["chinese-tiny-enable"].value then
            self.currentArmorModules = {
                { Name = self.currentItems["Reactor"], Count = 8 },
                { Name = self.currentItems["Roboport"], Count = 8 },
                { Name = self.currentItems["Shield"], Count = 8 },
                { Name = self.currentItems["Battery"], Count = 4 },
                { Name = self.currentItems["Nightvision"], Count = 1 },
                { Name = self.currentItems["Exoskeleton"], Count = 8 },
            }
        else
            self.currentArmorModules = {
                { Name = self.currentItems["Reactor"], Count = 4 },
                { Name = self.currentItems["Roboport"], Count = 4 },
                { Name = self.currentItems["Shield"], Count = 4 },
                { Name = self.currentItems["Battery"], Count = 2 },
                { Name = self.currentItems["Nightvision"], Count = 1 },
                { Name = self.currentItems["Exoskeleton"], Count = 4 },
            }
        end
    end,

    -- 处理 Bob's Warfare 模组
    processBobWarfare = function(self)
        self.currentItems["Armor"] = "bob-power-armor-mk5"

        -- 根据chinese-tiny设置调整模块数量
        if settings.startup["chinese-tiny-enable"] and settings.startup["chinese-tiny-enable"].value then
            self.currentArmorModules = {
                { Name = self.currentItems["Reactor"], Count = 16 },
                { Name = self.currentItems["Roboport"], Count = 8 },
                { Name = self.currentItems["Shield"], Count = 8 },
                { Name = self.currentItems["Battery"], Count = 4 },
                { Name = self.currentItems["Nightvision"], Count = 1 },
                { Name = self.currentItems["Battery"], Count = 8 },
                { Name = self.currentItems["Exoskeleton"], Count = 10 },
                { Name = self.currentItems["LaserDefense"], Count = 32 },
            }
        else
            self.currentArmorModules = {
                { Name = self.currentItems["Reactor"], Count = 8 },
                { Name = self.currentItems["Roboport"], Count = 4 },
                { Name = self.currentItems["Shield"], Count = 4 },
                { Name = self.currentItems["Battery"], Count = 2 },
                { Name = self.currentItems["Nightvision"], Count = 1 },
                { Name = self.currentItems["Battery"], Count = 4 },
                { Name = self.currentItems["Exoskeleton"], Count = 5 },
                { Name = self.currentItems["LaserDefense"], Count = 16 },
            }
        end
    end
}

-- 装备管理器
local ArmorManager = {
    -- 检查并装备护甲
    equipArmor = function(self, player, needclear)
        local botLevel = settings.global["chinese-bot-start"].value
        if botLevel == "关闭" then
            return
        end

        if not (player and player.valid and player.connected and player.character) then
            Utils.log("错误: 无效的玩家")
            return
        end
        --  game.player.get_inventory(defines.inventory.character_armor)[1].grid.put({ name = "personal-laser-defense-equipment" })
        local armorInventory = player.get_inventory(defines.inventory.character_armor)
        if not armorInventory then
            Utils.log("警告: 玩家 " .. player.name .. " 没有装备栏")
            return
        end

        -- 插入初始物品
        self:insertStartingItems(player)

        if needclear then
            -- 清理现有装备
            self:clearExistingArmor(player, armorInventory)
        end

        -- 装备新护甲
        local success = self:insertNewArmor(armorInventory)
        if success then
            self:insertArmorModules(armorInventory[1].grid)
        end
    end,

    -- 插入初始物品
    insertStartingItems = function(self, player)
        -- 插入建设机器人
        if Utils.validateItem(ModManager.currentItems["Robot"]) then
            player.insert { name = ModManager.currentItems["Robot"], count = storage.chinese_botCount }
        end

    end,

    -- 清理现有装备
    clearExistingArmor = function(self, player, armorInventory)
        if not armorInventory.is_empty() then
            local currentArmor = armorInventory[1].name
            armorInventory.clear()
            -- 从玩家主背包中移除旧护甲
            local playerInventory = player.get_inventory(defines.inventory.character_main)
            if playerInventory then
                playerInventory.remove(currentArmor)
            end
        end
    end,

    -- 插入新护甲
    insertNewArmor = function(self, armorInventory)
        if not Utils.validateItem(ModManager.currentItems["Armor"]) then
            return false
        end
        if armorInventory.is_empty() then
            local insertCount = armorInventory.insert {
                name = ModManager.currentItems["Armor"],
                count = 1
            }
            return insertCount > 0
        end
        return false
    end,

    -- 插入护甲模块
    insertArmorModules = function(self, grid)
        if not grid then
            Utils.log("错误: 护甲网格无效")
            return
        end

        for _, module in pairs(ModManager.currentArmorModules) do
            if Utils.validateItem(module.Name) then
                for i = 1, module.Count do
                    grid.put({ name = module.Name })
                end
            end
        end
    end
}

local function check_bot_level()
    local botLevel = settings.global["chinese-bot-start"].value

    local botCounts = {
        ["关闭"] = 1,
        ["简易"] = 50,
        ["豪华"] = 200,
        ["尊享"] = 400
    }

    storage.chinese_botCount = botCounts[botLevel] or 1
end

if settings.global["chinese-bot-start"] and settings.global["chinese-bot-start"].value then
    local botLevel = settings.global["chinese-bot-start"].value

    check_bot_level()

    -- 初始化脚本
    MyEvent.on_init(function(event)
        -- 初始化模组管理器
        ModManager:init()

    end)

    -- 注册玩家创建事件
    MyEvent.on_event(defines.events.on_player_created, function(event)
        local player = game.get_player(event.player_index)

        ArmorManager:equipArmor(player, true)

    end)

    -- 注册过场动画结束事件
    MyEvent.on_event(defines.events.on_cutscene_cancelled, function(event)
        local player = game.get_player(event.player_index)
        ArmorManager:equipArmor(player, true)
    end)
end

MyEvent.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
    if event and event.setting and event.setting == "chinese-bot-start"
            and settings.global["chinese-bot-start"].value then
        local botLevel = settings.global["chinese-bot-start"].value
        if botLevel == "关闭" then
            return
        end

        check_bot_level()

        -- 初始化模组管理器
        ModManager:init()
        for _, player in pairs(game.players) do
            ArmorManager:equipArmor(player, false)
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

