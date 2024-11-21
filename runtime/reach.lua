-- 用于存储每个玩家的原始距离加成值
storage.original_distances = storage.original_distances or {}
function far_reach_apply_settings()
    storage.original_distances = storage.original_distances or {}

    -- 检查是否启用 "chinese-reach-enable" 设置
    local distance = settings.global["chinese-reach-distance"].value
    if settings.global["chinese-reach-enable"].value then
        for _, player in pairs(game.players) do
            if player and player.character then
                -- 如果当前加成值已经等于目标值，则不重复设置


                -- 如果尚未记录原始值，则存储当前的距离加成
                if not storage.original_distances[player.index] then
                    storage.original_distances[player.index] = {
                        build = player.character_build_distance_bonus,
                        reach = player.character_reach_distance_bonus,
                        resource = player.character_resource_reach_distance_bonus,
                        drop = player.character_item_drop_distance_bonus
                    }
                    -- 应用新的距离加成
                    player.character_build_distance_bonus = player.character_build_distance_bonus + distance
                    player.character_reach_distance_bonus = player.character_reach_distance_bonus + distance
                    player.character_resource_reach_distance_bonus = player.character_resource_reach_distance_bonus + distance
                    player.character_item_drop_distance_bonus = player.character_item_drop_distance_bonus + distance

                end

            end
        end
    else
        -- 恢复原始距离加成值
        for _, player in pairs(game.players) do
            if player and player.character and storage.original_distances[player.index] then
                local newbuild = player.character_build_distance_bonus - distance
                if newbuild > 1 then
                    player.character_build_distance_bonus = newbuild
                end
                local newreach = player.character_reach_distance_bonus - distance
                if newreach > 1 then
                    player.character_reach_distance_bonus = player.character_reach_distance_bonus - distance
                end
                local resource_reach = player.character_resource_reach_distance_bonus - distance
                if resource_reach > 1 then
                    player.character_resource_reach_distance_bonus = resource_reach
                end

                local item_drop_distance = player.character_item_drop_distance_bonus - distance
                if resource_reach > 1 then
                    player.character_item_drop_distance_bonus = item_drop_distance
                end

                storage.original_distances[player.index] = nil
            end
        end
    end
end
require("runtime.list")

function hook_space_exploration()
    -- 检查是否启用 space-exploration 模组以及相关接口
    if script.active_mods["space-exploration"] and remote.interfaces["space-exploration"] and remote.interfaces["space-exploration"]["get_on_player_respawned_event"] then
        script.on_event(remote.call("space-exploration", "get_on_player_respawned_event"), function(data)
            far_reach_apply_settings()
        end)
    end
end

MyEvent.on_init(function(data)
    -- 初始加载时应用设置，并挂接 space-exploration 事件
    far_reach_apply_settings()
    hook_space_exploration()
end
)

MyEvent.on_load(
        function(data)
            -- 在加载游戏时挂接 space-exploration 事件
            hook_space_exploration()
        end
)

MyEvent.on_configuration_changed(
        function(data)
            -- 配置更改时应用设置
            far_reach_apply_settings()
        end
)

MyEvent.on_event({ defines.events.on_runtime_mod_setting_changed,
                   defines.events.on_player_joined_game,
                   defines.events.on_player_changed_force,
                   defines.events.on_player_respawned,
                   defines.events.on_player_created,
                   defines.events.on_cutscene_cancelled,
                   defines.events.on_cutscene_waypoint_reached },
        function(event)
            -- 针对不同事件触发加成设置
            far_reach_apply_settings()
        end
)

-- 解决 jetpack 模组重置 far reach 设置的问题
if script.active_mods["jetpack"] then
    remote.add_interface("chinese-reach", {
        on_character_swapped = function(event)
            --https://mods.factorio.com/mod/jetpack looks for remote interface called "on_character_swapped" specifically
            --{new_unit_number = uint, old_unit_number = uint, new_character = luaEntity, old_character = luaEntity}
            far_reach_apply_settings()
        end
    })
end
