arch-install-host-software:
	@echo "Install host specific arch packages"
	sudo pacman -Syyu --noconfirm \
        neovim \
        obsidian \
        alacritty \
        firefox \
        thunderbird \
		sway \
		swaylock \
		swaybg \
		waybar \
		fuzzel \
		discord \
		signal \
		spotify \
		flameshot \
		udiskie \
		fuzzel
	@echo "Install micromamba"
	"${SHELL}" <(curl -L micro.mamba.pm/install.sh)

arch-host-dotfiles:
	@echo "Linking host-specific dotfiles from .config"
	ln -s ~/.config/.zprofile ~/.zprofile || echo ".zprofile - Already linked!"

arch-sway-setup:
	@echo "Install sway wallpaper"
	wget -O /usr/share/backgrounds/downloaded/galaxy_purple_1440p.png https://i.redd.it/66sqi696dsbc1.png

DEPENDENCY_TARGETS += arch-install-host-software
DOTFILE_TARGETS += arch-host-dotfiles
HOME_TARGETS += arch-sway-setup
