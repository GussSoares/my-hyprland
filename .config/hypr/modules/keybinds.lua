-- =============================================================================
-- CONFIGURAÇÃO DE KEYBINDS (PADRÃO OFICIAL WIKI LUA)
-- =============================================================================

local mainMod = "SUPER"
local terminal = "kitty"

-- -----------------------------------------------------------------------------
-- Binds Principais & Aplicativos
-- -----------------------------------------------------------------------------
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal)) -- 36 = Enter
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("nwgbar"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("hyprlock -q"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty --class files-floating -e spf"))
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("~/bin/wofi-power-menu.sh"))

-- Antigo bindr: Dispara no release da tecla usando a flag { release = true }
hl.bind("SUPER + SUPER_L", hl.dsp.exec_cmd("pkill wofi || wofi --normal-window --show drun --allow-images"), { release = true })

hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("nwg-drawer -mb 10 -mr 10 -ml 10 -mt 10"))
-- hl.bind(mainMod .. " + P", hl.dsp.pseudo()) -- dwindle

-- -----------------------------------------------------------------------------
-- Teclas de Função (F1 a F12)
-- -----------------------------------------------------------------------------
local f_keys_apps = {
    F1 = "firedragon",    F2 = "thunderbird",   F3 = "thunar",
    F4 = "geany",         F5 = "github-desktop", F6 = "gparted",
    F7 = "inkscape",      F8 = "blender",       F9 = "meld",
    F10 = "joplin-desktop", F11 = "snapper-tools", F12 = "galculator"
}
for key, app in pairs(f_keys_apps) do
    hl.bind(mainMod .. " + " .. key, hl.dsp.exec_cmd(app))
end

-- -----------------------------------------------------------------------------
-- Movimentação de Foco (Vim Keys e Setas)
-- -----------------------------------------------------------------------------
local directions = {
    left = "l", H = "l",
    right = "r", L = "r",
    up    = "u", K = "u",
    down  = "d", J = "d"
}
for key, dir in pairs(directions) do
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = dir }))
end

-- -----------------------------------------------------------------------------
-- Gerenciamento de Workspaces (Loops Dinâmicos)
-- -----------------------------------------------------------------------------
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Navegação de workspace com o Scroll do Mouse
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- -----------------------------------------------------------------------------
-- Manipulação de Janelas (Mouse & Teclado)
-- -----------------------------------------------------------------------------
-- Antigo bindm: Passa o mouse:keycode direto na string
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })

-- Mover janelas ativas (Mod + SHIFT + Direção)
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-- -----------------------------------------------------------------------------
-- Controle de Áudio & Brilho (XF86 / Keycodes)
-- -----------------------------------------------------------------------------
hl.bind("code:122", hl.dsp.exec_cmd([[pactl set-sink-volume @DEFAULT_SINK@ -5% && notify-send " Volume: $(pamixer --get-volume)" -t 500 -i /usr/share/icons/candy-icons/status/scalable/audio-volume-low.svg]]))
hl.bind("code:123", hl.dsp.exec_cmd([[pactl set-sink-volume @DEFAULT_SINK@ +5% && notify-send " Volume: $(pamixer --get-volume)" -t 500 -i /usr/share/icons/candy-icons/status/scalable/audio-volume-high.svg]]))
hl.bind("code:121", hl.dsp.exec_cmd([[pamixer --toggle-mute && notify-send " Volume: Toggle-mute" -t 500 -i /usr/share/icons/candy-icons/status/scalable/audio-volume-muted.svg]]))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd([[pactl set-source-mute @DEFAULT_SOURCE@ toggle && notify-send "System Mic: Toggle-mute" -t 500]]))

hl.bind("code:233", hl.dsp.exec_cmd("brightnessctl -c backlight set +5%"), { locked = true })
hl.bind("code:232", hl.dsp.exec_cmd("brightnessctl -c backlight set 5%-"), { locked = true })

-- Controle de mídia
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- -----------------------------------------------------------------------------
-- Outros Atalhos & Screenshots
-- -----------------------------------------------------------------------------
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("brave"))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen("1"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen("0"))
-- hl.bind(mainMod .. " + SHIFT + F", hl.dsp.fullscreenstate("0 2"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("~/bin/set-theme.sh"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))

-- Screenshots (delimitador Lua [[]] para strings complexas do terminal)
hl.bind("Print", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]]))
hl.bind("CTRL + Print", hl.dsp.exec_cmd(".config/hypr/scripts/screenshot_window.sh"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(".config/hypr/scripts/screenshot_display.sh"))

-- -----------------------------------------------------------------------------
-- Submapas (Modo de Redimensionamento)
-- -----------------------------------------------------------------------------
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

hl.bind(mainMod .. " + Space", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    hl.dispatch(hl.dsp.window.resize({ x = 1000, y = 600 }))
    hl.dispatch(hl.dsp.window.center())
end)

-- Entra no contexto do submapa
-- hl.dsp.submap("resize")

-- local resize_steps = {
--     right = "50 0",  L = "50 0",
--     left  = "-50 0", H = "-50 0",
--     up    = "0 -50", K = "0 -50",
--     down  = "0 50",  J = "0 50"
-- }
-- for key, step in pairs(resize_steps) do
--     -- Antigo binde: Comportamento de repetição via { repeating = true }
--     -- hl.bind(key, hl.dsp.resizeactive(step), { repeating = true })
--     hl.bind(key, hl.dsp.window.resize(step), { repeating = true })
-- end

-- hl.bind("escape", hl.dsp.submap("reset"))

-- -- Sai do contexto do submapa
-- hl.dsp.submap("reset")

-- -----------------------------------------------------------------------------
-- Special Workspace (Janela Mágica)
-- -----------------------------------------------------------------------------
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.togglespecialworkspace("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.movetoworkspace("+0"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.togglespecialworkspace("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.movetoworkspace("special:magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.togglespecialworkspace("magic"))

-- Special Workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll Workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse Window Drag/Resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })