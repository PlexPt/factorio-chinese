local gui_type = defines.gui_type.entity
local prototypes = {
    ['container'] = defines.inventory.chest,
    ['logistic-container'] = defines.inventory.chest,
    ['infinity-container'] = defines.inventory.chest,
    ['linked-container'] = defines.inventory.chest,
    ['temporary-container'] = defines.inventory.chest,
    ['cargo-wagon'] = defines.inventory.cargo_wagon,
}

MyEvent.on_event(defines.events.on_gui_opened, function()
    local open = settings.global["chinese-chest-auto-sort"] and settings.global["chinese-chest-auto-sort"].value
    if open then
        for _, player in pairs(game.connected_players) do
            if player.opened_gui_type == gui_type then
                local inventory = prototypes[player.opened.type]
                if inventory then
                    player.opened.get_inventory(inventory).sort_and_merge()
                end
            end
        end
    end
end)


