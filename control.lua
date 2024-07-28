script.on_event(defines.events.on_player_joined_game, function(event)

    local player = game.players[event.player_index]
    if player then

        local msg = "欢迎使用[color=#FF00FF]开源中文汉化语言包[/color]！\n我们为Factorio提供了1000+个mod的汉化，覆盖了所有下载量大于1000的mod。\n我们的汉化是由专业的团队校对的，保证质量。\n使用[color=#FF00FF]开源中文汉化语言包[/color]，您可以轻松地享受Factorio的游戏体验，不用担心语言障碍。\n如果您在使用过程中有任何问题，欢迎加入我们的汉化群[color=#FF00FF]830846580[/color]与我们交流。祝您游戏愉快！"

        if msg then
            player.print(msg)
        end
    end

end)

--require("runtime.gui")

require("runtime.infinite-resources")

