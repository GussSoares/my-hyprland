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
sudo pacman -S hyprland waybar rofi alacritty foot kitty swaync cava btop fastfetch fish starship nwg-dock-hyprland imagemagick superfile wireplumber bluetui lazydocker upower bluez-utils brightnessctl grim slurp wl-clipboard networkmanager polkit-kde-agent xdg-desktop-portal-hyprland swaylock pamixer tar unzip rofimoji hyprpicker xcolor dunst python-psutil python-gputil pyamdgpuinfo lolcat power-profiles-daemon gazelle awww zenity tlp
```

> Important for notebook battery

```bash
sudo systemctl enable --now tlp
```

For Python dependencies (for system-info.py):
```bash
pip install psutil gputil pyamdgpuinfo
```

**Important**: The Waybar configuration expects Python with specific packages to be available via a pyenv virtual environment. You can either:
1. Create a pyenv environment named `hyprland`:
   ```bash
   pyenv install 3.12  # or your preferred Python version
   pyenv virtualenv 3.12 hyprland
   pyenv activate hyprland
   pip install psutil gputil pyamdgpuinfo
   ```
2. Or modify the Waybar config to use your Python path instead of `~/.pyenv/versions/hyprland/bin/python3`

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

#### Waybar-Specific Configuration
The Waybar setup has additional requirements and customizations needed:

1. **Network Interface**: Edit `~/.config/waybar/config.jsonc` and change the hardcoded interface `"wlp0s20f3"` to match your network interface:
   ```bash
   ip link show  # to find your interface name
   # Then replace in the config
   ```

2. **Waybar Modules** require:
   - `waybar-module-pacman-updates`: for package updates indicator
   - `swaync`: for notification center (alternative to mako)
   - `gazelle` or `nmtui`: for network management
   - `kitty` or your preferred terminal for floating windows

3. **Power Menu**: The power menu script path may need adjustment. Ensure `bin/wofi-power-menu.sh` or create a similar script.

4. **Optional Applications** (for Waybar functionality):
   - `blueman`: Bluetooth manager (or use `bluetooth-menu.sh`)
   - `wiremix`: PipeWire mixer for advanced audio control
   - `lazydocker`: Container management

#### Additional Notes
- Some scripts require specific hardware (e.g., battery scripts need a battery).
- For VPN and network management, ensure NetworkManager is running.
- If using AMD GPUs, pyamdgpuinfo is for AMD GPU info in system-info.py.
- Color scripts use lolcat for coloring; install it if not included.
- For notifications, mako or dunst is used; ensure one is running.

### 🚀 Features

This Hyprland setup includes:
- **Window Manager**: Hyprland with custom keybindings and layouts.
- **Status Bar**: Waybar with modules for battery, volume, brightness, network, etc.
- **Launcher**: Rofi with custom menus for clipboard, network, power, VPN, and emoji.
- **Terminals**: Alacritty, Foot, and Kitty configurations.
- **Notifications**: Mako notification daemon.
- **Audio Visualizer**: Cava integration.
- **System Monitors**: Btop and Fastfetch.
- **Shell**: Fish with Starship prompt.
- **Utilities**: Scripts for battery, brightness, volume, screenshots, wallpaper slideshow, etc.
- **Color Scripts**: ASCII art scripts with Catppuccin theming.
- **Dock**: NWG Dock for Hyprland.

### ⌨️ Keybindings

Common keybindings (check `~/.config/hypr/hyprland.conf` for full list):
- `Super + Q`: Kill active window
- `Super + Space`: Toggle floating window
- `Super + F`: Toggle fullscreen
- `Super + D`: Launch Rofi
- `Super + Shift + E`: Power menu
- `Super + B`: Toggle Waybar
- `Print`: Screenshot
- Volume/Brightness: Function keys or custom scripts

### 🛠️ Customization

- Themes: Based on Catppuccin Mocha. Edit colors in config files.
- Wallpapers: Use `swww` for dynamic wallpapers (script in `~/.config/hypr/scripts/`).
- Fonts: Nerd Fonts recommended for icons.
- To change themes, modify the color schemes in Waybar, Hyprland, etc.

#### Wallpapers

- [Catppuccin Mocha](https://github.com/orangci/walls-catppuccin-mocha)
- [TokyoNIght](https://github.com/atraxsrc/tokyonight-wallpapers)


### 🐛 Troubleshooting

- If Waybar doesn't show: Check if all dependencies are installed and configs copied.
- Notifications not working: Ensure `mako` or `dunst` is running.
- Scripts not executing: Make sure they are executable (`chmod +x`).
- Hyprland not starting: Check logs with `hyprctl` or journalctl.
- For AMD GPUs: Install `pyamdgpuinfo` if system-info.py fails.

## ❤️ Gratitude

Thanks for the inspiration, follow this repositories

- [Catppuccin](https://github.com/catppuccin/catppuccin) 
- [Meowrch](https://github.com/meowrch/meowrch)
