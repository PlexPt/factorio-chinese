script.on_event(defines.events.on_player_joined_game, function(event)

    local player = game.players[event.player_index]
    if player then

        local msg = "欢迎使用[color=#B57FB3]开源中文汉化语言包[/color]，翻译有任何问题可加群反馈: 830846580 \n有其他想汉化的mod也可联系"

        if msg then
            player.print(msg)
        end
    end

end)
