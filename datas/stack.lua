local stack_enable = settings.startup['chinese-stack'].value
local my_stack_factor = settings.startup['chinese-stack-factor'].value

local function table_contains(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

function new_size(oldvalue, offset, factor)
    if oldvalue == nil then
        oldvalue = 1
    end
    local v = offset + oldvalue * factor
    if v > oldvalue then
        return (v)
    else
        return oldvalue
    end
end

if stack_enable then
    -- item stacks
    for _, dat in pairs(data.raw) do
        for _, item in pairs(dat) do
            if item.stack_size and type(item.stack_size) == "number" and item.stack_size > 1 then

                if not (item.flags and table_contains(item.flags, "not-stackable")) then
                    item.stack_size = new_size(item.stack_size, 0, my_stack_factor)
                    --if my_default_req_amount ~= nil then
                    --    item.default_request_amount = my_default_req_amount
                    --end
                end
            end
        end
    end
end

-- ammo stacks
--for _, ammo in pairs(data.raw.ammo) do
--    -- ammo.stack_size = new_size( ammo.stack_size, my_stack_offset, my_stack_factor )	-- ammo are already modified in the previsous loop
--    ammo.magazine_size = new_size(ammo.magazine_size, my_mag_offset, my_mag_factor)
--    if my_default_req_amount then
--        ammo.default_request_amount = my_default_req_amount
--    end
--end
--
---- module stacks
--for _, modu in pairs(data.raw["module"]) do
--    modu.stack_size = new_size(modu.stack_size, my_stack_offset, my_stack_factor)
--end
--
---- capsule stacks
--for _, caps in pairs(data.raw["capsule"]) do
--    caps.stack_size = new_size(caps.stack_size, my_stack_offset, my_stack_factor)
--end


