MyEvent = require("EventDispatcher")
chinese_debug = true


MyEvent.on_event(defines.events.on_player_joined_game, function(event)

    local player = game.players[event.player_index]
    if player then

        local msg = "[font=heading-1][color=#E99696]在设置中也有一些方便的小功能可以使用，大部分不影响平衡。[/color][/font]"

        if msg then
            player.print('[font=heading-1]' ..
                    '[color=#E99696]欢[/color]' ..
                    '[color=#E9A296]迎[/color]' ..
                    '[color=#E9AF96]使[/color]' ..
                    '[color=#E9BB96]用[/color]' ..
                    '[color=#E9C896]开[/color]' ..
                    '[color=#E9D496]源[/color]' ..
                    '[color=#E9E096]中[/color]' ..
                    '[color=#E5E996]文[/color]' ..
                    '[color=#D8E996]汉[/color]' ..
                    '[color=#CCE996]化[/color]' ..
                    '[color=#BFE996]语[/color]' ..
                    '[color=#B3E996]言[/color]' ..
                    '[color=#A6E996]包[/color]' ..
                    '[color=#9AE996]！[/color]\n' ..
                    '[color=#96E99E]本[/color]' ..
                    '[color=#96E9AB]语[/color]' ..
                    '[color=#96E9B7]言[/color]' ..
                    '[color=#96E9C3]包[/color]' ..
                    '[color=#96E9D0]提[/color]' ..
                    '[color=#96E9DC]供[/color]' ..
                    '[color=#96E9E9]了[/color]' ..
                    '[color=#96DCE9]1[/color]' ..
                    '[color=#96D0E9]0[/color]' ..
                    '[color=#96C3E9]0[/color]' ..
                    '[color=#96B7E9]0[/color]' ..
                    '[color=#96ABE9]多[/color]' ..
                    '[color=#969EE9]个[/color]' ..
                    '[color=#9A96E9]模[/color]' ..
                    '[color=#A696E9]组[/color]' ..
                    '[color=#B396E9]的[/color]' ..
                    '[color=#BF96E9]汉[/color]' ..
                    '[color=#CC96E9]化[/color]' ..
                    '[color=#D896E9]，[/color]' ..
                    '[color=#E596E9]大[/color]' ..
                    '[color=#E996E0]部[/color]' ..
                    '[color=#E996D4]分[/color]' ..
                    '[color=#E996C8]热[/color]' ..
                    '[color=#E996BB]门[/color]' ..
                    '[color=#E996AF]模[/color]' ..
                    '[color=#E996A2]组[/color]' ..
                    '[color=#E99696]都[/color]' ..
                    '[color=#E9A296]已[/color]' ..
                    '[color=#E9AF96]汉[/color]' ..
                    '[color=#E9BB96]化[/color]' ..
                    '[color=#E9C896]。[/color]' ..
                    '[color=#E9D496]如[/color]' ..
                    '[color=#E9E096]果[/color]' ..
                    '[color=#E5E996]您[/color]' ..
                    '[color=#D8E996]在[/color]' ..
                    '[color=#CCE996]使[/color]' ..
                    '[color=#BFE996]用[/color]' ..
                    '[color=#B3E996]中[/color]' ..
                    '[color=#A6E996]有[/color]' ..
                    '[color=#9AE996]任[/color]' ..
                    '[color=#96E99E]何[/color]' ..
                    '[color=#96E9AB]问[/color]' ..
                    '[color=#96E9B7]题[/color]' ..
                    '[color=#96E9C3]，[/color]' ..
                    '[color=#96E9D0]欢[/color]' ..
                    '[color=#96E9DC]迎[/color]' ..
                    '[color=#96E9E9]加[/color]' ..
                    '[color=#96DCE9]入[/color]' ..
                    '[color=#96D0E9]我[/color]' ..
                    '[color=#96C3E9]们[/color]' ..
                    '[color=#96B7E9]的[/color]' ..
                    '[color=#96ABE9]汉[/color]' ..
                    '[color=#969EE9]化[/color]' ..
                    '[color=#9A96E9]群[/color]' ..
                    '[color=#A696E9]8[/color]' ..
                    '[color=#B396E9]3[/color]' ..
                    '[color=#BF96E9]0[/color]' ..
                    '[color=#CC96E9]8[/color]' ..
                    '[color=#D896E9]4[/color]' ..
                    '[color=#E596E9]6[/color]' ..
                    '[color=#E996E0]5[/color]' ..
                    '[color=#E996D4]8[/color]' ..
                    '[color=#E996C8]0[/color]' ..
                    '[color=#E996BB]与[/color]' ..
                    '[color=#E996AF]我[/color]' ..
                    '[color=#E996A2]们[/color]' ..
                    '[color=#E99696]交[/color]' ..
                    '[color=#E9A296]流[/color]' ..
                    '[color=#E9AF96]、[/color]' ..
                    '[color=#E9BB96]提[/color]' ..
                    '[color=#E9C896]交[/color]' ..
                    '[color=#E9D496]翻[/color]' ..
                    '[color=#E9E096]译[/color]' ..
                    '[color=#E5E996]、[/color]' ..
                    '[color=#D8E996]报[/color]' ..
                    '[color=#CCE996]告[/color]' ..
                    '[color=#BFE996]翻[/color]' ..
                    '[color=#B3E996]译[/color]' ..
                    '[color=#A6E996]问[/color]' ..
                    '[color=#9AE996]题[/color]' ..
                    '[color=#96E99E]等[/color]' ..
                    '[/font]'
            )
            player.print(msg)

        end
    end

end)

--require("runtime.gui")

require("runtime.skip-crash")

require("runtime.reach")

require("runtime.bag")

require("runtime.chest-auto-sort")

require("runtime.infinite-resources")

require("runtime.bot-start")

if script.active_mods["gvv"] then
    require("__gvv__.gvv")()
end
