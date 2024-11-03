local function fix_resources(surface, area)
    resources = surface.find_entities_filtered {
        area = area,
        type = 'resource',
    }
    for _, resource in pairs(resources) do
        if resource.prototype.infinite_resource then
            -- set all new resources to exactly their normal amount
            resource.initial_amount = resource.prototype.normal_resource_amount
            resource.amount = resource.prototype.normal_resource_amount
        end
    end
end

if settings.startup["chinese-infinite-resources"].value then
    script.on_configuration_changed(function()
        for _, surface in pairs(game.surfaces) do
            fix_resources(surface)
        end
    end)

    MyEvent.on_event(defines.events.on_chunk_generated, function(event)
        fix_resources(event.surface, event.area)
    end)

    MyEvent.on_event(defines.events.on_surface_created, function(event)
        fix_resources(game.surfaces[event.surface_index])
    end)
end


