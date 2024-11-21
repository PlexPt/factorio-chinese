-- Define global variables to store the GUI elements
storage.mod_info_button = nil
storage.mod_info_frame = nil

-- Function to create the mod info button
local function create_mod_info_button(player)
    if player.gui.left.mod_info_button then
        return
    end
    storage.mod_info_button = player.gui.left.add { type = "button", name = "mod_info_button", caption = "Mod Info" }
end

-- Function to create the mod info panel
local function create_mod_info_panel(player)
    if player.gui.center.mod_info_frame then
        return
    end
    storage.mod_info_frame = player.gui.center.add { type = "frame", name = "mod_info_frame", direction = "vertical", caption = "Mod Information" }

    local info_panel = storage.mod_info_frame.add { type = "scroll-pane", vertical_scroll_policy = "auto", horizontal_scroll_policy = "never" }
    info_panel.style.maximal_height = 300

    info_panel.add { type = "label", caption = "Welcome to [Your Mod Name]!" }

    info_panel.add { type = "label", caption = "Basic Suggestions:" }
    info_panel.add { type = "label", caption = "- Do X to achieve Y" }
    info_panel.add { type = "label", caption = "- Press Z for more options" }

    info_panel.add { type = "label", caption = "Usage Guide:" }
    info_panel.add { type = "label", caption = "1. Step 1" }
    info_panel.add { type = "label", caption = "2. Step 2" }

    info_panel.add { type = "label", caption = "Developer Information:" }
    info_panel.add { type = "label", caption = "- Developed by [Your Name]" }
    info_panel.add { type = "label", caption = "- Version: 1.0.0" }
end

-- Function to remove the mod info panel
local function remove_mod_info_panel(player)
    if player.gui.center.mod_info_frame then
        player.gui.center.mod_info_frame.destroy()
    end
end

-- When player is created, add the button to their UI
MyEvent.on_event(defines.events.on_player_created, function(event)
    local player = game.players[event.player_index]
    create_mod_info_button(player)
end)

local function on_gui_click(event)
    local player = game.players[event.player_index]
    local element = event.element

    if element.name == "mod_info_button" then
        if player.gui.center.mod_info_frame then
            remove_mod_info_panel(player)
        else
            create_mod_info_panel(player)
        end
    end

    if element.name == "mod_info_close_button" then
        remove_mod_info_panel(player)
    end
end

-- Handle GUI clicks
MyEvent.on_event(defines.events.on_gui_click, on_gui_click)
MyEvent.on_event(defines.events.on_player_joined_game, on_gui_click)
