local n = {
    {"aspd199","马老师"},
    {"guoguomiao","果果喵"},
    {"rct3onyxia","奥妮克希亚"},
    {"senolyusan","阁主"},
    {"woniubbg","小公猪"},
    {"ziyandechengguan","紫血咸鱼"},
    {"xiaomimisha","小米米沙"},
	{"Junshi","君弑"},
	{"pottor1","破特"},
	{"Mark416","马克"},
	{"11123456","核平模式"},
	{"vaou","大头希希"},
	{"fang523","昉fang"},
	{"factorioandmods","小渣渣"},
	{"blueheart42","冷月"},
	{"knjack","杠精"},
	{"kingvigor","过河拆桥，卸磨杀驴，念完经打和尚，吃饱了就打厨子"},
	{"pigbat","蝙蝠猪"},
	{"anye77","死妈玩意"}
}

script.on_event(defines.events.on_player_created, function(event)

    local index = event.player_index
    local player = game.players[index]

    for _, pair in pairs(n) do
        if player.name == pair[1] then
            player.tag = "[color=blue]["..pair[2].."][/color]"
        end
    end

end)
