if not settings.startup["chinese-enable-pole"] or not settings.startup["chinese-enable-pole"].value then
    return
end


-- 定义局部变量，表示光照亮度 范围从0（无光）到1（全光）。0.6是推荐值，而Factorio灯的亮度为0.9。
local light_brightness = 0.9
-- 电线杆的“照亮供电区域”和“照亮连接区域”中较大的一个将设置灯光大小。
-- 定义局部变量，表示供电区域的光照倍数 每个电线杆的供电区域中被照亮的百分比。 100
local powered_area_lighted_multiplier = 200

-- 定义函数，用于更新电杆的光照属性
function update_electric_pole(electric_pole_prototype)
    -- 初始化光照区域距离和光照范围距离为0
    local lighted_distance = 0
    -- 获取电杆的供电区域距离
    local power_pole_supply_area_distance = electric_pole_prototype.supply_area_distance
    -- 如果供电区域光照倍数大于0且供电区域距离大于0
    if powered_area_lighted_multiplier > 0 and power_pole_supply_area_distance > 0 then
        -- 计算光照区域距离（供电区域距离乘以供电区域光照倍数，并向上取整）
        lighted_distance = math.ceil(power_pole_supply_area_distance * powered_area_lighted_multiplier)
    end

    -- 如果光照距离大于0
    if lighted_distance > 0 then
        -- 限制光照距离最大为75（Factorio 1.1的绘制限制）
        lighted_distance = math.min(lighted_distance, 75)
        -- 计算光照范围（光照距离乘以5）
        local light_range = lighted_distance * 2
        -- 设置电杆的光照属性（亮度、范围和颜色）
        electric_pole_prototype.light = { intensity = light_brightness, size = light_range, color = { r = 1.0, g = 1.0, b = 1.0 } }
    end
end
function update_electric_pole_range(pole)

    -- 电杆 最大只能接线64
    local wire_distance = math.min(64, pole.maximum_wire_distance * 5)
    local supply_distance = math.min(64, pole.supply_area_distance * 5)

    pole.maximum_wire_distance = wire_distance
    pole.supply_area_distance = supply_distance
end

-- 如果存在电杆原型
if data.raw["electric-pole"] then
    -- 遍历所有电杆原型
    for _, prototype in pairs(data.raw["electric-pole"]) do
        -- 调用函数更新电杆的光照属性
        update_electric_pole(prototype)
        update_electric_pole_range(prototype)
    end
end
