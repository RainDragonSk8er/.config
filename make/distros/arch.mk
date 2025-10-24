arch-base-update:
	sudo pacman -Syyu --noconfirm
	@echo "Update pacman packages"

arch-install-base-software:
	@echo "Install basic arch packages"
	sudo pacman -Syyu --noconfirm \
		wget \
		curl \
		vim \
		git \
		tmux \
		zsh \
		openssh 
	@echo "Installing oh-my-zsh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

arch-set-shell:
	chsh -s /usr/bin/zsh

arch-base-dotfiles:
	@echo "Linking base dotfiles from .config"
	ln -s ~/.config/.vimrc ~/.vimrc || echo ".vimrc - Already linked!"
	ln -s ~/.config/.zshrc ~/.zshrc || echo ".zshrc - Already linked!"


DEPENDENCY_TARGETS += arch-base-update
DOTFILE_TARGETS += arch-base-dotfiles
SOFTWARE_TARGETS += arch-install-base-software
HOME_TARGETS += arch-set-shell
