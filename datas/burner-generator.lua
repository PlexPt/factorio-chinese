if data.raw.item["burner-generator"] then
    data.raw.item["burner-generator"].hidden = nil
end

if data.raw["burner-generator"]["burner-generator"] then
    data.raw["burner-generator"]["burner-generator"].hidden = nil
end

data:extend({
    {
        type = "recipe",
        name = "chinese-burner-generator",
        localised_name = { "item-name.burner-generator" },
        enabled = true,
        energy_required = 0.5,
        subgroup = "energy",
        order = "a-b",
        ingredients = {
            { type = "item", name = "copper-plate", amount = 10 },
            { type = "item", name = "iron-plate", amount = 10 },
        },
        results = {
            { type = "item", name = "burner-generator", amount = 1 }
        }
    }
})
