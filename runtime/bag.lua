local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end


-- 缓存堆叠大小的表，用于优化性能
local stack_size_cache = {}
local function stack_size(item)
    -- 如果缓存中没有该物品的堆叠大小，则查询并缓存结果
    stack_size_cache[item] = stack_size_cache[item] or game.item_prototypes[item].stack_size
    return stack_size_cache[item]
end

-- 计算物品栏中的物品堆叠数

-- 计算库存中所有物品所需的总堆叠数
local function inventory_stacks(inventory)
    local contents = inventory.get_contents() -- 获取库存的物品内容
    local stacks = 0
    -- 遍历库存中的每种物品
    for item, count in pairs(contents) do
        -- 计算该物品的堆叠数量并累加
        stacks = stacks + math.ceil(count / stack_size(item))
    end
    return stacks -- 返回总堆叠数
end

local creative_inventory = false -- 标记是否在“创意模式”下

-- 更改玩家的物品栏槽位
local function changeInventorySlots(player)
    local main_inv = player.get_main_inventory() -- 获取玩家的主物品栏
    if not (main_inv and main_inv.valid) then
        return
    end
    local empty_stack = main_inv.count_empty_stacks()

    local contents = main_inv.get_contents() -- 获取主物品栏的内容
    if creative_inventory then
        -- 如果在创意模式下，调整物品栏内容
        -- TODO: 不要移除非空的规划器
        for item, count in pairs(contents) do
            -- 检查物品是否不属于特定类型的规划器
            if not has_value({ 'blueprint', 'blueprint-book', 'upgrade-planner', 'deconstruction-planner' }, game.item_prototypes[item].type) then
                local diff = count - stack_size(item) * ((game.item_prototypes[item].place_result == nil and stack_size(item) == 1) and 2 or 1)
                -- 根据 diff 的值来调整该物品的数量
                if diff > 0 then
                    main_inv.remove({ name = item, count = diff }) -- 移除多余的物品
                elseif diff < 0 then
                    main_inv.insert({ name = item, count = -diff }) -- 插入缺少的物品
                end
            end
        end
        -- 确保玩家光标中的物品数量符合堆叠大小
        if player.cursor_stack.valid_for_read then
            player.cursor_stack.count = stack_size(player.cursor_stack.name)
        end
    end
    local changed = false

    if empty_stack then

        if empty_stack < 10 then
            player.character_inventory_slots_bonus = player.character_inventory_slots_bonus + 20
            changed = true
        elseif empty_stack > 40 then
            local newBonus = player.character_inventory_slots_bonus - 20
            if newBonus > 0 then
                player.character_inventory_slots_bonus = newBonus
                changeInventorySlots(player)
                changed = true
            end
        end
    end

    ---- 计算主物品栏中的总堆叠数
    --local stacks = inventory_stacks(main_inv)
    ---- 根据配置中的空槽位设置，计算新物品栏的总槽位
    --local newTotal = stacks + 20
    ---- 去除额外加成后的物品栏槽位数量
    --local withoutBonus = #main_inv - player.character_inventory_slots_bonus
    ---- 计算新的加成槽位数
    --local newBonus = newTotal - withoutBonus
    --
    ---- 检查新的加成槽位数是否不同，以决定是否需要更新
    --local oldBonus = player.character_inventory_slots_bonus
    --player.character_inventory_slots_bonus = math.max(0, newBonus)
    --local change = (oldBonus ~= player.character_inventory_slots_bonus)

    -- 如果加成槽位数发生变化，输出更新信息（调试用）
    -- if change ~= 0 then game.print(game.table_to_json({stacks, newBonus, #main_inv})) end

    -- 如果物品栏槽位数已更改且 minime 模块可用，则更新 minime 的虚拟槽位数
    if change and remote.interfaces.minime and remote.interfaces.minime.main_inventory_resized then
        remote.call("minime", "main_inventory_resized", player.index)
    end
end

-- 检查是否启用 "chinese-reach-enable" 设置


MyEvent.on_event(defines.events.on_player_main_inventory_changed, function(event)
    local open = settings.global["chinese-smart-bag"] and settings.global["chinese-smart-bag"].value

    if open then

        local player = game.players[event.player_index]
        if player and player.valid and player.connected and player.character then

            changeInventorySlots(player)
        end
    end
end)


-- 每 600 个 tick 检查全局表中的玩家是否可以更改物品栏
script.on_nth_tick(600, function(event)
    local open = settings.global["chinese-smart-bag"] and settings.global["chinese-smart-bag"].value

    if open then
        for _, player in pairs(game.players) do
            -- 检查玩家是否满足条件，如果满足则更改物品栏
            if player and player.valid and player.connected and player.character then
                changeInventorySlots(player)
            end
        end
    end
end)



--/sc game.player.print(game.player.character_inventory_slots_bonus)
--/sc game.player.print(game.player.connected)
--    /sc game.player.print(game.player.get_main_inventory().count_empty_stacks())
