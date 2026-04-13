<h3 align="center">
    <br />
    <img src="assets/catppuccin.png" width="100" alt="Logo"/><br/>
    <br />
	My Hyprland based on <br><br>
    <span style="font-size: 2em">Catppuccin</span>
</h3>

<p align="center">
  <img src="assets/macchiato.png" width="400" />
</p>

### 🗃️ Installation

#### Prerequisites
This setup is designed for Arch Linux (or Arch-based distributions) with Hyprland as the window manager. Ensure you have the following base packages installed:
- `hyprland` (window manager)
- `wayland` and related protocols

#### Dependencies
Install the required packages using pacman:

```bash
sudo pacman -S hyprland waybar rofi alacritty foot kitty swaync cava btop fastfetch fish starship nwg-dock-hyprland swww imagemagick superfile wireplumber bluetui lazydocker upower bluez-utils brightnessctl grim slurp wl-clipboard networkmanager polkit-kde-agent xdg-desktop-portal-hyprland swaylock pamixer tar unzip rofimoji hyprpicker xcolor dunst python-psutil python-gputil pyamdgpuinfo lolcat
```

For Python dependencies (for system-info.py):
```bash
pip install psutil gputil pyamdgpuinfo
```

#### Setup Steps
1. Clone or download this repository to your home directory or a temporary location.

2. Copy the configuration files:
   ```bash
   cp -r .config/* ~/.config/
   cp -r bin/* ~/
   cp -r .local/* ~/.local/
   ```

3. Make the scripts executable:
   ```bash
   chmod +x ~/bin/*.sh ~/bin/color-scripts/* ~/bin/rofi-menus/*.sh
   ```

4. (Optional) If using Fish shell, copy or link the fish config:
   ```bash
   # Already copied in step 2
   ```

5. Restart your session or run `hyprctl reload` to apply Hyprland configurations.

6. For Waybar, ensure it's launched in your Hyprland config (check ~/.config/hypr/hyprland.conf).

7. Test the scripts: Run `~/bin/battery.sh` or other scripts to verify functionality.

#### Additional Notes
- Some scripts require specific hardware (e.g., battery scripts need a battery).
- For VPN and network management, ensure NetworkManager is running.
- If using AMD GPUs, pyamdgpuinfo is for AMD GPU info in system-info.py.
- Color scripts use lolcat for coloring; install it if not included.
- For notifications, mako or dunst is used; ensure one is running.



## ❤️ Gratitude

Thanks for the inspiration, follow this repositories

- [Catppuccin](https://github.com/catppuccin/catppuccin) 
- [Meowrch](https://github.com/meowrch/meowrch)
