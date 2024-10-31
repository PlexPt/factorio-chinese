local open = settings.startup["chinese-fast-bot"].value

local function botplus(bot)
    if not bot then
        return
    end
    --speed = 0.06,
    local speed = 10

    if bot.speed then
        bot.speed = bot.speed * speed
    end
    ---------------------------------------------
    if bot.max_payload_size then
        bot.max_payload_size = bot.max_payload_size * 2
    end
    ---------------------------------------------
    if bot.max_health then
        bot.max_health = bot.max_health * 2
    end
    ---------------------------------------------
    if bot.speed_multiplier_when_out_of_energy then
        bot.speed_multiplier_when_out_of_energy = bot.speed_multiplier_when_out_of_energy * 10
    end
    ---------------------------------------------
    ---    energy_per_move = "5kJ",
    --    energy_per_tick = "0.05kJ",
    if bot.energy_per_move then
        bot.energy_per_move = "0.1kJ"
    end
    ---------------------------------------------
    if bot.energy_per_tick then
        bot.energy_per_tick = "0.001kJ"
    end
    ---------------------------------------------

end

if open then


    for _, bot in pairs(data.raw["logistic-robot"]) do
        botplus(bot)
    end

    for _, bot in pairs(data.raw["construction-robot"]) do
        botplus(bot)
    end

end
