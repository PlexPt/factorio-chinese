
if not settings.startup["chinese-free-loader"].value then
    return
end

-- 定义装载机配方
local loaders = {
    "aai-loader",
    "aai-fast-loader",
    "aai-express-loader",
    "aai-turbo-loader",
}



-- 遍历每个未润滑的装载机配方并进行修改
for k, recipe_name in pairs(loaders) do
    -- 检查配方是否存在
    if data.raw.recipe[recipe_name] then
        local recipe = data.raw.recipe[recipe_name]

        -- 直接修改未润滑配方的原料
        recipe.ingredients = {
            { type = "item", name = "iron-plate", amount = 5 },
        }

        -- 调整所需时间为1
        recipe.energy_required = 1
    end
end

for name, entity in pairs(data.raw["loader-1x1"]) do
    if entity then
        entity.energy_source = nil
        entity.energy_per_item = nil
    end


    -- 检查配方是否存在
    if data.raw.recipe[name] then
        local recipe = data.raw.recipe[name]

        -- 直接修改未润滑配方的原料
        recipe.ingredients = {
            { type = "item", name = "iron-plate", amount = 5 },
        }

        -- 调整所需时间为1
        recipe.energy_required = 1
    end

end

for name, entity in pairs(data.raw["loader"]) do
    if entity then
        entity.energy_source = nil
        entity.energy_per_item = nil
    end


    -- 检查配方是否存在
    if data.raw.recipe[name] then
        local recipe = data.raw.recipe[name]

        -- 直接修改未润滑配方的原料
        recipe.ingredients = {
            { type = "item", name = "iron-plate", amount = 5 },
        }

        -- 调整所需时间为1
        recipe.energy_required = 1
    end

end
