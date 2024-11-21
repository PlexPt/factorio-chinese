
if  not mods['bobinserters'] then
    return
end


if not settings.startup["chinese-enable-bob"].value then
    return
end

--------------------------------------------------------------------------------------------------------
local bob1 = data.raw.technology["near-inserters"]
if bob1 then
    bob1.prerequisites = {}
    bob1.unit = { count = 1, ingredients = {}, time = 1 }
end

local bob2 = data.raw.technology["more-inserters-1"]
if bob2 then
    bob2.prerequisites = {}
    bob2.unit = { count = 1, ingredients = {}, time = 1 }
end

local bob3 = data.raw.technology["more-inserters-2"]
if bob3 then
    bob3.prerequisites = {}
    bob3.unit = { count = 1, ingredients = {}, time = 1 }
end
local bob4 = data.raw.technology["long-inserters-1"]
if bob4 then
    bob4.prerequisites = {}
    bob4.unit = { count = 1, ingredients = {}, time = 1 }
end

local bob5 = data.raw.technology["long-inserters-2"]
if bob5 then
    bob5.prerequisites = {}
    bob5.unit = { count = 1, ingredients = {}, time = 1 }
end

--------------------------
