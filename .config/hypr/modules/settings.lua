-----------------------
---- LOOK AND FEEL ----
-----------------------
local theme = require("theme")

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = theme.active_border,
            inactive_border = theme.inactive_border
        },
        
        layout = "dwindle",
    },

    decoration = {
        rounding = 10,
        blur = {
            enabled = true,
            size = 10,
            passes = 3,
            new_optimizations = true,
        },
        shadow = {
            enabled = false,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
    },

    animations = {
        enabled = true,
    },
    
    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        disable_hyprland_logo = true,
        allow_session_lock_restore = true,
    },

    input = {
        kb_layout = "br,us",
        kb_variant = "abnt2,intl",
        kb_options = "grp:alt_space_toggle",
        numlock_by_default = true,
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
            disable_while_typing = true,
        },
    },
})
