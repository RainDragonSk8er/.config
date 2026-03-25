# .config — Dotfiles

Personal dotfiles for a Sway-based Wayland desktop on Arch Linux.

---

## Setup Overview

| Component | Program |
|---|---|
| Window Manager | [Sway](https://swaywm.org/) |
| Status Bar | [Waybar](https://github.com/Alexays/Waybar) |
| Terminal | [Alacritty](https://alacritty.org/) + [tmux](https://github.com/tmux/tmux) |
| Shell | Zsh + [Oh My Zsh](https://ohmyz.sh/) |
| Editor | [Neovim](https://neovim.io/) |
| App Launcher | [Fuzzel](https://codeberg.org/dnkl/fuzzel) |
| Screen Locker | [Swaylock](https://github.com/swaywm/swaylock) |
| Idle Daemon | [Swayidle](https://github.com/swaywm/swayidle) |
| Clipboard | [wl-clipboard](https://github.com/bugaevc/wl-clipboard) + [clipman](https://github.com/yory8/clipman) |
| Screenshots | [grimshot](https://github.com/OctopusET/sway-contrib) (part of sway-contrib) |

---

## Required Packages

### Core (pacman)

```bash
sudo pacman -S \
  sway waybar swaylock swayidle sway-contrib \
  alacritty tmux fuzzel \
  wl-clipboard clipman \
  brightnessctl playerctl pavucontrol \
  pipewire pipewire-session-manager gst-plugin-pipewire \
  xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk \
  slurp jq \
  neovim \
  udiskie \
  firefox thunderbird discord obsidian
```

### Fonts (pacman)

```bash
sudo pacman -S \
  ttf-jetbrains-mono-nerd \
  ttf-font-awesome-5
```

> Waybar icons use **Font Awesome 5** codepoints. Installing FA6/FA7 will show wrong icons.

### AUR

```bash
yay -S \
  ttf-font-awesome-5 \
  asusctl          # ASUS power profile control (Waybar + F5 keybind)
```

### Optional / App-specific

```bash
sudo pacman -S spotify-launcher   # Workspace 6
```

---

## Fonts

| Font | Used in |
|---|---|
| `JetBrainsMono Nerd Font` | Waybar (global), Alacritty |
| `JetBrainsMono Nerd Font Mono` | Waybar clock |
| `Font Awesome 5 Free` | Waybar workspace icons, format-icons |

---

## Screen Sharing

Screen sharing on Wayland (e.g. in Firefox/Discord) requires XDG Desktop Portal with a wlroots backend. The sway config handles environment setup automatically on login:

```
exec systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK
```

Make sure `xdg-desktop-portal-wlr` and `pipewire` are running. The Waybar screencast indicator (`custom/screencast`) will show an icon when a session is active, using `~/.config/waybar/scripts/screencast-indicator.sh`.

---

## Idle & Lock

Managed by `swayidle`:

| Trigger | Action |
|---|---|
| 15 min idle | Lock screen (`swaylock`) |
| 20 min idle | Turn off displays |
| Resume | Turn displays back on |
| Before sleep | Lock screen |

Manual lock: `$mod + i`

Swaylock config is at `~/.config/swaylock/config` (Catppuccin Mocha theme).

---

## Screenshots

| Keybind | Action |
|---|---|
| `Print` | Copy full screen to clipboard |
| `$mod + Shift + s` | Copy selected area to clipboard |

Uses `grimshot` from `sway-contrib`.

---

## Key Bindings (Sway)

| Keybind | Action |
|---|---|
| `$mod + Return` | Terminal (Alacritty) |
| `$mod + d` | App launcher (Fuzzel) |
| `$mod + w` | Firefox |
| `$mod + c` | Discord |
| `$mod + e` | Thunderbird |
| `$mod + n` | Obsidian |
| `$mod + Backspace` | Kill focused window |
| `$mod + i` | Lock screen |
| `$mod + t + s` | TMUX session picker (fuzzel) |
| `$mod + f` | Fullscreen |
| `$mod + Shift + space` | Toggle floating |
| `$mod + r` | Resize mode |
| `$mod + Shift + c` | Reload Sway config |
| `$mod + Shift + q` | Exit Sway |
| `F5` | Cycle ASUS power profile |
| `Print` | Screenshot (full screen) |
| `$mod + Shift + s` | Screenshot (area) |

---

## Keyboard Layout

Norwegian + US, toggled with `Win + Space`. ASUS laptop keyboard model.

---

## Waybar Modules

**Left:** Workspaces · Power Profile (asusctl) · Spotify
**Center:** Window title · Clock (HH:MM)
**Right:** Backlight · Audio · Network · CPU · Memory · Battery · Screencast · Tray · Date

The Spotify module requires `playerctl` and only shows when Spotify is running.
The power profile module requires `asusctl`.

---

## Wallpaper

Place your wallpaper at:
```
/usr/share/backgrounds/downloaded/galaxy_purple_1440p.jpg
```

Or update the `output "*" bg ...` line in `sway/config`.

---

## Neovim

Plugin manager: [lazy.nvim](https://github.com/folke/lazy-nvim) (auto-bootstrapped on first launch).

Key plugins:
- **LSP**: `nvim-lspconfig` + `mason.nvim` for server management
- **Completion**: `blink.cmp`
- **Fuzzy find**: `telescope.nvim` with fzf-native
- **Git**: `gitsigns.nvim`
- **Go docs**: `godoc.nvim` (requires `cargo` for building `gostdsym`)

---

## Shell

Zsh with Oh My Zsh, `jonathan` theme. Sway auto-starts on TTY1 via `.zprofile`.

PATH includes:
- `~/.local/bin`
- `~/.config/bin`

---

## Display Setup (Desktop)

```
DP-1       2550x1440 @ 59.95 Hz   primary, rotated 180°
HDMI-A-1   1920x1080 @ 60 Hz      secondary, rotated 90°, positioned left
```

Workspace assignments are hardcoded to these outputs. See the `WorkLaptop` branch for a laptop-specific layout.
