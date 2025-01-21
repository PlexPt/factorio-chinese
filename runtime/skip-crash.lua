
MyEvent.on_init(function()
    local open = settings.global["chinese-skip-crashsite"] and settings.global["chinese-skip-crashsite"].value

    if open then

        local freeplay = remote.interfaces["freeplay"] or {}
        if freeplay["set_skip_intro"] then
            remote.call("freeplay", "set_skip_intro", true)
        end

        if freeplay["set_disable_crashsite"] then
            remote.call("freeplay", "set_disable_crashsite", true)
        end
    end
end)


