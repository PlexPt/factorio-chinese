local my_running_speed_factor = settings.startup["chinese-running-speed"].value

if my_running_speed_factor and my_running_speed_factor > 1 then

    -- running speed
    if my_running_speed_factor ~= 1 and data.raw.character.character.running_speed == 0.15 then
        data.raw.character.character.running_speed = 0.15 * my_running_speed_factor
    end
end
