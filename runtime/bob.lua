if not settings.startup["chinese-enable-bob"] or not settings.startup["chinese-enable-bob"].value then
    return
end

function bob_research(event)
    for i, force in pairs(game.forces) do
        for j, tech in pairs({ "long-inserters-1", "long-inserters-2", "near-inserters", "more-inserters-1", "more-inserters-2" }) do
            if force.technologies[tech] and not force.technologies[tech].researched then
                force.technologies[tech].researched = true
                force.technologies[tech].enabled = false
                force.technologies[tech].visible_when_disabled = false
            end
        end
    end
end


MyEvent.on_init(bob_research)
MyEvent.on_configuration_changed(bob_research)
MyEvent.on_event(defines.events.on_force_created, bob_research)
MyEvent.on_event(defines.events.on_force_reset, bob_research)
MyEvent.on_event(defines.events.on_research_reversed, bob_research)
