local fastmining = settings.startup["chinese-fast-mining"].value
if not fastmining then
    return
end


function is_value_in_list (value, list)
    for i, v in pairs(list) do
        if v == value then
            return true
        end
    end
    return false
end

local resource_category = 'basic-solid'
-- local speed_factor = 60 -- 30/s
local speed_factor = 30 -- 15/s

local area_factor = 3

local md_names = {}

for md_name, mining_drill in pairs(data.raw["mining-drill"]) do
    if mining_drill.resource_categories and is_value_in_list(resource_category, mining_drill.resource_categories) then
        mining_drill.mining_speed = speed_factor * mining_drill.mining_speed
        local energy_usage = mining_drill.energy_usage
        local value = tonumber(string.match(energy_usage, "%d+"))
        local unit = string.match(energy_usage, "%a+")
        mining_drill.energy_usage = (speed_factor * value) .. unit

        mining_drill.resource_searching_radius = (area_factor * math.ceil(mining_drill.resource_searching_radius * 2) / 2 - 0.01)

        table.insert(md_names, md_name)
    end
end

