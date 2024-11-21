local open = settings.global["chinese-skip-crashsite"] and settings.global["chinese-skip-crashsite"].value
if open then


    MyEvent.on_init(function()


        local freeplay = remote.interfaces["freeplay"]
        if freeplay then
            if freeplay["set_skip_intro"] then
                remote.call("freeplay", "set_skip_intro", true)
            end

            if freeplay["set_disable_crashsite"] then
                remote.call("freeplay", "set_disable_crashsite", true)
            end
        end
    end)


end
