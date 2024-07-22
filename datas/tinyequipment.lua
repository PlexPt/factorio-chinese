if settings.startup["chinese-tiny-enable"].value then

    local shape_list = { "night-vision-equipment", "energy-shield-equipment", "energy-shield-equipment", "battery-equipment",
                         "solar-panel-equipment", "generator-equipment", "active-defense-equipment", "movement-bonus-equipment",
                         "roboport-equipment", "belt-immunity-equipment", }
    for _, shape in pairs(shape_list) do
        for _, equipment in pairs(data.raw[shape]) do
            if equipment.shape then
                equipment.shape.type = "full"
                if equipment.shape.width then
                    equipment.shape.width = 1
                end
                if equipment.shape.height then
                    equipment.shape.height = 1
                end
            end
        end
    end

end
