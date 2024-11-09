
-- 装载机配置定义
local LOADER_CONFIGS = {
    {
        name = "loader",
        tech = "logistics"
    },
    {
        name = "fast-loader",
        tech = "logistics-2"
    },
    {
        name = "express-loader",
        tech = "logistics-3"
    }
}

-- 工具函数：检查并设置配方属性
local function configure_recipe(recipe_name)
    local recipe = data.raw.recipe[recipe_name]
    if recipe then
        recipe.enabled = false
        recipe.hidden = false
        return true
    end
    return false
end

-- 工具函数：添加配方到科技树
local function add_recipe_to_tech(tech_name, recipe_name)
    local tech = data.raw.technology[tech_name]
    if tech then
        table.insert(tech.effects, {
            type = "unlock-recipe",
            recipe = recipe_name
        })
        return true
    end
    return false
end

-- 主函数：配置装载机
local function configure_loaders()
    -- 处理每个装载机配置
    for _, config in ipairs(LOADER_CONFIGS) do
        local recipe_configured = configure_recipe(config.name)
        local tech_configured = add_recipe_to_tech(config.tech, config.name)

        -- 可选：记录配置状态
        if log then  -- 如果日志函数可用
            if not recipe_configured then
                log(string.format("[Loader Config] Warning: Recipe '%s' not found", config.name))
            end
            if not tech_configured then
                log(string.format("[Loader Config] Warning: Technology '%s' not found", config.tech))
            end
        end
    end
end

-- 执行配置
configure_loaders()
