-- original by Wanakachi
-- suitable for Windows operating systems

-- picture-in-picture (PiP) mode for mpv
-- usage: "Alt+p" to toggle PiP mode on/off.

require("mp.options")
local pip_enabled = false
local original_options = {}

-- save original window properties
local function save_original_options()
    original_options.fullscreen   = mp.get_property_bool("fullscreen")
    original_options.border        = mp.get_property_bool("border")
    original_options.ontop         = mp.get_property_bool("ontop")
    original_options.window_scale  = mp.get_property_number("window-scale")
end

-- restore original window properties
local function restore_original_options()
    if original_options.fullscreen    ~= nil then mp.set_property_bool("fullscreen",    original_options.fullscreen)    end
    if original_options.border        ~= nil then mp.set_property_bool("border",        original_options.border)        end
    if original_options.ontop         ~= nil then mp.set_property_bool("ontop",         original_options.ontop)         end
    if original_options.window_scale  ~= nil then mp.set_property_number("window-scale", original_options.window_scale) end
end

-- enter PiP mode
local function enable_pip()
    if pip_enabled then return end

    save_original_options()

    mp.set_property_bool("fullscreen",   false)   -- exit fullscreen if necessary
    mp.set_property_bool("border",       false)   -- remove decorations
    mp.set_property_bool("ontop",        true)    -- keep above other windows
    mp.set_property_number("window-scale", 0.3)   -- scale down (30 %)

    pip_enabled = true
    mp.osd_message("PiP enabled")
end

-- leave PiP mode
local function disable_pip()
    if not pip_enabled then return end

    restore_original_options()
    pip_enabled = false
    mp.osd_message("PiP disabled")
end

-- toggle PiP on/off
local function toggle_pip()
    if pip_enabled then
        disable_pip()
    else
        enable_pip()
    end
end

-- re-apply PiP settings when a new file loads
mp.register_event("file-loaded", function()
    if pip_enabled then
        mp.add_timeout(0.1, enable_pip)   -- re-apply PiP
    end
end)

-- fix possible unwanted borderless state (e.g. saving PiP state by "watchlater")
mp.add_timeout(0.1, function()
    if not pip_enabled and mp.get_property_bool("border") == false then
        mp.set_property_bool("border", true)
        mp.set_property_bool("ontop",  false)
    end
end)

-- monitor fullscreen state changes and exit PiP first
mp.observe_property("fullscreen", "bool", function(name, value)
    if value and pip_enabled then
        disable_pip()
        mp.set_property_bool("fullscreen", true)
    end
end)

-- monitor window-maximized state changes (on some systems maximize and fullscreen are separate)
mp.observe_property("window-maximized", "bool", function(name, value)
    if value and pip_enabled then
        disable_pip()
        mp.set_property_bool("window-maximized", true)
    end
end)

-- binding
mp.add_key_binding("Alt+p", "toggle-pip", toggle_pip)