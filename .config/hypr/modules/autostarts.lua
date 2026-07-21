-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("xrdb -load ~/.Xresources")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("apply-gsettings")
    
    hl.exec_cmd("notify-send 'Catppuccin' 'Welcome back, $USER' -i $HOME/.config/hypr/catppuccin.png -a 'Hyprland'")
    hl.exec_cmd("hyprctl setcursor Twilight-cursors 24")
end)
