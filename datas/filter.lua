-- MIT
-- Filter Chests
-- by Xorimuth



if not settings.startup["chinese-enable-filter-chest"].value then
    return
end

local blue_tint = { 0.4, 0.7, 1 }

local container_prototypes = {}
local container_blacklists = {
    ["se-rocket-landing-pad"] = true,
    ["se-delivery-cannon-chest"] = true,
}

for index, prototype in pairs(data.raw["container"]) do
    if not container_blacklists[prototype.name] then
        container_prototypes[index] = prototype
    end
end
--fc-filter-logistic-chests"
for index, prototype in pairs(data.raw["logistic-container"]) do
    if not container_blacklists[prototype.name] then
        container_prototypes[index] = prototype
    end
end

for index, prototype in pairs(data.raw["infinity-container"]) do
    if not container_blacklists[prototype.name] then
        container_prototypes[index] = prototype
    end
end
--filter-linked-chests
for index, prototype in pairs(data.raw["linked-container"]) do
    if not container_blacklists[prototype.name] then
        container_prototypes[index] = prototype
    end
end

--chest_mode == "modify"
for _, container in pairs(container_prototypes) do
    if not container.inventory_type or container.inventory_type ~= "with_filters_and_bar" then
        container.inventory_type = "with_filters_and_bar"
    end
end
