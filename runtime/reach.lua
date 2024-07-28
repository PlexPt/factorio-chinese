

function far_reach_apply_settings()

    if not settings.global["chinese-reach-enable"] then
        return
    end

    local distance = settings.global["chinese-reach-distance"].value
    for _, player in pairs(game.players) do
        if player and player.character then
            player.character_build_distance_bonus = distance
            player.character_reach_distance_bonus = distance
            player.character_resource_reach_distance_bonus = distance
            player.character_item_drop_distance_bonus = distance
        end
    end
end

function hook_space_exploration()
    if script.active_mods["space-exploration"] and remote.interfaces["space-exploration"] and remote.interfaces["space-exploration"]["get_on_player_respawned_event"] then
        script.on_event(remote.call("space-exploration", "get_on_player_respawned_event"), function(data)
            far_reach_apply_settings()
        end)
    end
end

script.on_init(
        function(data)
            far_reach_apply_settings()
            hook_space_exploration()
        end
)

script.on_load(
        function(data)
            hook_space_exploration()
        end
)

script.on_configuration_changed(
        function(data)
            far_reach_apply_settings()
        end
)

script.on_event({ defines.events.on_runtime_mod_setting_changed,
                  defines.events.on_player_joined_game,
                  defines.events.on_player_changed_force,
                  defines.events.on_player_respawned,
                  defines.events.on_player_created,
                  defines.events.on_cutscene_cancelled,
                  defines.events.on_cutscene_waypoint_reached },
        function(event)
            far_reach_apply_settings()
        end
)

-- fix for https://mods.factorio.com/mod/jetpack resetting far reach settings.
if script.active_mods["jetpack"] then
    remote.add_interface("chinese-reach", {
        on_character_swapped = function(event)
            --https://mods.factorio.com/mod/jetpack looks for remote interface called "on_character_swapped" specifically
            --{new_unit_number = uint, old_unit_number = uint, new_character = luaEntity, old_character = luaEntity}
            far_reach_apply_settings()
        end
    })
end
