# Dotfiles Notes

This repository is primarily a Sway/Wayland desktop setup with a few shell and editor configs. It is not a complete machine bootstrap. A fresh Arch install will still need packages, fonts, a few local files, and some host-specific edits before the config is usable.

## Scope

The main pieces currently used are:

- `sway/config`
- `waybar/config`
- `waybar/style.css`
- `waybar/scripts/screencast-indicator.sh`
- `alacritty/alacritty.toml`
- `fuzzel/fuzzel.ini`
- `swaylock/config`
- `tmux/tmux.conf`
- `.zprofile`
- `.zshrc`

## Required packages

Install the core desktop packages first:

```bash
sudo pacman -S \
  sway swaybg swayidle swaylock waybar \
  alacritty fuzzel tmux zsh \
  wl-clipboard clipman \
  grim slurp sway-contrib \
  brightnessctl \
  pipewire pipewire-pulse wireplumber \
  xdg-desktop-portal xdg-desktop-portal-wlr \
  pavucontrol \
  udiskie \
  neovim git ripgrep jq
```

Fonts used by the current config:

```bash
sudo pacman -S ttf-jetbrains-mono-nerd ttf-font-awesome
```

Notes:

- `grimshot` is referenced from `sway/config`. On Arch it comes from `sway-contrib`.
- `pactl` is referenced from `sway/config`. With PipeWire on Arch, that is normally provided by `pipewire-pulse`.
- `jq` is required by `waybar/scripts/screencast-indicator.sh`.
- `git` is needed for Neovim plugin bootstrap through `lazy.nvim`.

## Optional applications referenced by the config

The Sway keybindings and window assignments expect these applications to exist:

- `firefox`
- `teams-for-linux`
- `outlook-for-linux`
- `obsidian`

These are not required for the desktop to start, but the keybindings will be broken until they are installed or the bindings are edited.

On Arch, some of these are likely AUR packages rather than official repo packages.

## Shell setup

This setup assumes:

- login shell is `zsh`
- `~/.zprofile` points to `/home/jhol/.config/.zprofile`
- `~/.zshrc` points to `/home/jhol/.config/.zshrc`

Example:

```bash
ln -sf ~/.config/.zprofile ~/.zprofile
ln -sf ~/.config/.zshrc ~/.zshrc
chsh -s /bin/zsh
```

The current `.zshrc` also assumes:

- `oh-my-zsh` is installed at `~/.oh-my-zsh`
- `micromamba` is installed at `~/.local/bin/micromamba`
- `bun` is installed at `~/.bun`
- `/opt/nvim` may exist and is appended to `PATH`
- `~/.config/bin` exists and is appended to `PATH`

If you do not want those dependencies, simplify `.zshrc`.

## Session startup

The current `.zprofile` auto-starts Sway when logging into `tty1`:

- exports Wayland-related environment variables
- restarts the user `pipewire` service
- starts `udiskie -a`
- `exec`s `sway`

That means this repo assumes a TTY login workflow, not a display manager by default.

## Local files and overrides

### `~/.env`

`sway/config` includes `~/.env`, and that file is currently written in Sway config syntax, not shell syntax.

Right now it provides:

```text
set $WALLPAPER_PATH /usr/share/backgrounds/ubuntu-wallpaper-d.png
```

On Arch you must either:

1. create `~/.env` with a valid wallpaper path on your machine, or
2. remove `include ~/.env` and set `WALLPAPER_PATH` directly in `sway/config`

### Wallpapers and lock screen assets

These paths are Ubuntu-specific in the current repo and will not exist on a clean Arch install:

- `/usr/share/backgrounds/ubuntu-wallpaper-d.png`
- `/usr/share/backgrounds/ubuntu-default-greyscale-wallpaper.png`

You must replace them with valid local files.

### Host-specific monitor names

`sway/config` contains hard-coded output names for this laptop and dock setup:

- `Philips Consumer Electronics Company PHL 275S1 UK02213083288`
- `Philips Consumer Electronics Company PHL 275S1 UK02143031375`
- `eDP-1`
- `HDMI-A-1`

On a fresh machine, run:

```bash
swaymsg -t get_outputs
```

Then update the `output ...` and `workspace ... output ...` lines accordingly.

## Screen sharing

Screen sharing under Sway depends on:

- `pipewire`
- `wireplumber`
- `xdg-desktop-portal`
- `xdg-desktop-portal-wlr`

The current Waybar screen-share indicator also depends on those services being active and on `jq` being installed.

If screen sharing breaks, first confirm:

```bash
systemctl --user --no-pager --plain --type=service | rg 'pipewire|wireplumber|xdg-desktop-portal|portal-wlr'
```

## Neovim

Neovim bootstraps `lazy.nvim` automatically on first launch, so internet access and `git` are required the first time it runs.

This config likely also expects extra external tools depending on the installed plugins and LSP setup, but those are not fully documented here yet.

## Known machine-specific assumptions

These parts should be reviewed before reusing the repo elsewhere:

- monitor names and layout in `sway/config`
- wallpaper paths in `~/.env` and `swaylock/config`
- app bindings for `teams-for-linux`, `outlook-for-linux`, and `obsidian`
- `oh-my-zsh`, `micromamba`, and `bun` paths in `.zshrc`
- the auto-start-on-tty1 behavior in `.zprofile`

## First-pass bring-up checklist

1. Install the packages listed above.
2. Install the fonts listed above.
3. Symlink `.zprofile` and `.zshrc` into `$HOME`.
4. Install `oh-my-zsh` or simplify `.zshrc`.
5. Create `~/.env` with a valid `set $WALLPAPER_PATH ...` line.
6. Replace the Ubuntu wallpaper paths with files that exist on Arch.
7. Update monitor names in `sway/config`.
8. Log into `tty1` and let `.zprofile` start Sway.
9. Verify Waybar, lock screen, audio keys, brightness keys, clipboard history, screenshots, and screen sharing.
