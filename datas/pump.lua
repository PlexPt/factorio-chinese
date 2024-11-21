local enable = settings.startup["chinese-pump"].value

if enable then


    local lavas = {
        ["lava"] = true,
        ["lava-hot"] = true,
        ["volcanic-cracks"] = true,
        ["volcanic-cracks-hot"] = true,
        ["volcanic-cracks-warm"] = true,
        ["volcanic-smooth-stone"] = true,
        ["volcanic-smooth-stone-warm"] = true,
    }

    for k, tile in pairs(data.raw["tile"]) do
        if tile and not tile["fluid"] then
            -- 检查当前 tile 是否在 lavas 哈希表中，或者是否以 "volcanic-" 开头
            if lavas[tile.name] or string.find(tile.name, "^volcanic-") then
                tile["fluid"] = "lava"
            else
                tile["fluid"] = "water"
            end
        end
    end




    local pump = data.raw['offshore-pump']['offshore-pump']
    if not pump then
        return
    end
    pump.tile_buildability_rules = nil;




    --pump.adjacent_tile_collision_test = { 'ground-tile', 'water-tile', 'object-layer' }
    --pump.adjacent_tile_collision_mask = nil;
    --pump.placeable_position_visualization = nil;
    --pump.flags = { 'placeable-neutral', 'player-creation' }
    --pump.adjacent_tile_collision_box = { { -0.5, -0.25 }, { 0.5, 0.25 } }

    --pump.collision_mask = { layers = {} }

end
