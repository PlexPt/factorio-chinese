-- MIT
-- All Armors can Fly
-- by notnotmelon


local enable = settings.startup["chinese-enable-armors-fly"].value
if not enable then
    return
end

if not mods["space-age"] then
    return
end

for _, armor in pairs(data.raw.armor or {}) do
    armor.provides_flight = true
end
