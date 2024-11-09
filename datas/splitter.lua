-- Constants
local GRAPHICS_PATH = "__chinese__/graphics/icon/"
local BASE_ITEM_TYPE = "item"
local BASE_ENTITY_TYPE = "lane-splitter"
local BASE_NAME = "lane-splitter"

-- Configuration for different tiers of splitters
local TIER_CONFIGS = {
    {
        prefix = "",
        tech = "logistics",
        previous_prefix = "", -- 黄色分道器由传送带制作,此值不生效
        order = "a"
    },
    {
        prefix = "fast-",
        tech = "logistics-2",
        previous_prefix = "",
        order = "b"
    },
    {
        prefix = "express-",
        tech = "logistics-3",
        previous_prefix = "fast-",
        order = "c"
    },
    -- 可选的涡轮传送带支持
    {
        prefix = "turbo-",
        tech = "turbo-transport-belt",
        previous_prefix = "express-",
        order = "d",
    }
}

-- 工具函数
local function deep_copy(obj)
    return table.deepcopy(obj)
end

local function update_icon(prototype, prefix)
    prototype.icons = {
        {
            icon = GRAPHICS_PATH .. prefix .. BASE_NAME .. ".png"
        }
    }
end

local function update_animation_scales(animation_4_way, scale_factor)
    for _, direction in ipairs({ "north", "east", "south", "west" }) do
        local anim = animation_4_way[direction]
        if anim then
            anim.scale = (anim.scale or 1) / scale_factor
            if anim.shift then
                anim.shift = {
                    anim.shift[1] / scale_factor,
                    anim.shift[2] / scale_factor
                }
            end
        end
    end
end

-- 检查函数
local function prototype_exists(type_name, name)
    return data.raw[type_name] and data.raw[type_name][name] ~= nil
end

local function log_warning(message)
    if log then
        -- 确保log函数存在
        log("[Lane] Warning: " .. message)
    end
end

-- 主要功能函数
local function create_lane_splitter_item(prefix, base_splitter_name)
    local item_name = prefix .. BASE_NAME

    -- 检查物品是否已存在
    if prototype_exists(BASE_ITEM_TYPE, item_name) then
        log_warning("Item " .. item_name .. " already exists, skipping creation.")
        return data.raw[BASE_ITEM_TYPE][item_name]
    end

    local item = deep_copy(data.raw[BASE_ITEM_TYPE][BASE_NAME])

    -- 基本属性设置
    item.name = item_name
    item.order = string.format("d[lane-splitter]-%s[%slane-splitter]",
            prefix == "" and "a" or prefix:sub(1, 1),
            prefix)
    item.subgroup = "belt"
    item.place_result = item_name


    -- 权重和堆叠大小计算
    local base_splitter = data.raw[BASE_ITEM_TYPE][base_splitter_name]
    if base_splitter then
        item.weight = base_splitter.weight and (base_splitter.weight / 2) or nil
        item.stack_size = base_splitter.stack_size * 2
    end

    -- 更新图标
    update_icon(item, prefix)

    return item
end

local function create_lane_splitter_entity(prefix, item_name, base_splitter)
    local entity_name = prefix .. BASE_NAME

    -- 检查实体是否已存在
    if prototype_exists(BASE_ENTITY_TYPE, entity_name) then
        log_warning("Entity " .. entity_name .. " already exists, skipping creation.")
        return data.raw[BASE_ENTITY_TYPE][entity_name]
    end

    local entity = deep_copy(data.raw[BASE_ENTITY_TYPE][BASE_NAME])

    -- 基本属性设置
    entity.name = entity_name
    entity.minable.result = item_name
    entity.speed = base_splitter.speed
    entity.max_health = base_splitter.max_health
    entity.belt_animation_set = base_splitter.belt_animation_set

    -- 更新贴图
    entity.structure = deep_copy(base_splitter.structure)
    entity.structure_patch = deep_copy(base_splitter.structure_patch)

    update_animation_scales(entity.structure, 2)
    update_animation_scales(entity.structure_patch, 2)

    -- 更新图标
    update_icon(entity, prefix)

    return entity
end

local function create_recipe(config)
    local recipe_name = config.prefix .. BASE_NAME

    -- 检查配方是否已存在
    if prototype_exists("recipe", recipe_name) then
        log_warning("Recipe " .. recipe_name .. " already exists, skipping creation.")
        return
    end

    local base_splitter_recipe = data.raw.recipe[config.prefix .. "splitter"]
    if not base_splitter_recipe then
        log_warning("Base splitter recipe " .. config.prefix .. "splitter not found, skipping recipe creation.")
        return
    end

    local recipe = deep_copy(base_splitter_recipe)

    recipe.name = recipe_name

    -- 更新配方原料
    for _, ingredient in ipairs(recipe.ingredients) do
        if ingredient.name == config.previous_prefix .. "splitter" then
            ingredient.name = config.previous_prefix .. BASE_NAME
            ingredient.amount = 2
        end
    end

    -- 更新产出
    recipe.results[1].name = recipe_name
    recipe.results[1].amount = 2

    -- 检查科技是否存在
    if not data.raw.technology[config.tech] then
        log_warning("Technology " .. config.tech .. " not found, skipping recipe unlock.")
        return
    end

    -- 添加到科技树
    data:extend { recipe }
    table.insert(data.raw.technology[config.tech].effects, {
        type = "unlock-recipe",
        recipe = recipe.name
    })
end

-- 初始化基础(黄色)分道器
local function init_base_lane_splitter()
    -- 检查基础元件是否存在
    if not prototype_exists(BASE_ITEM_TYPE, BASE_NAME) or
            not prototype_exists(BASE_ENTITY_TYPE, BASE_NAME) then
        log_warning("Base lane splitter prototypes not found. Mod initialization failed.")
        return false
    end
    local base_item = data.raw[BASE_ITEM_TYPE][BASE_NAME]
    local base_entity = data.raw[BASE_ENTITY_TYPE][BASE_NAME]

    base_item.hidden = nil
    base_item.subgroup = "belt"
    base_item.order = string.format("d[lane-splitter]-%s[%slane-splitter]", "a", "")
    base_entity.hidden = nil

    update_icon(base_item, "")
    update_icon(base_entity, "")

    -- 创建配方
    create_recipe(TIER_CONFIGS[1])
    return true
end

-- 主程序
local function main()
    -- 初始化基础分道器
    if not init_base_lane_splitter() then
        return
    end

    -- 记录上一个处理的实体用于升级链
    local last_entity = data.raw[BASE_ENTITY_TYPE][BASE_NAME]

    -- 处理每个等级的分道器
    for _, config in ipairs(TIER_CONFIGS) do
        -- 检查是否满足条件(用于模组兼容)
        if not config.condition or config.condition() then
            -- 跳过基础(黄色)分道器,因为已经在init_base_lane_splitter中处理
            if config.prefix ~= "" then
                local base_splitter_name = config.prefix .. "splitter"

                -- 检查基础分离器是否存在
                if not prototype_exists("splitter", base_splitter_name) then
                    log_warning("Base splitter " .. base_splitter_name .. " not found, skipping tier.")
                    goto continue
                end

                local base_splitter = data.raw.splitter[base_splitter_name]

                -- 创建物品和实体
                local item = create_lane_splitter_item(config.prefix, base_splitter_name)
                local entity = create_lane_splitter_entity(config.prefix, item.name, base_splitter)

                -- 如果物品或实体是新创建的（不是已存在的），则注册到游戏
                if not prototype_exists(BASE_ITEM_TYPE, item.name) then
                    data:extend { item }
                end
                if not prototype_exists(BASE_ENTITY_TYPE, entity.name) then
                    data:extend { entity }
                end

                -- 设置升级链
                if last_entity then
                    last_entity.next_upgrade = entity.name
                end
                entity.next_upgrade = nil
                last_entity = entity

                -- 创建配方
                create_recipe(config)
            end


            :: continue ::
        end
    end
end

-- 运行主程序
main()
