#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

LOG_FILE="$DOTFILES_DIR/install.$(date +%Y-%m-%d_%H-%M-%S).log"
exec > >(tee -a $LOG_FILE)
sleep .1

info_log() {
    echo -e "\033[32m[INFO] $1\033[0m"
}

error_log() {
    echo -e "\033[31m[ERROR] $1\033[0m"
}

sync_config_file() {
    if [ -f $2 ]; then
        local BAK_FILENAME="$2.$(date +%s).bak"
        info_log "Backing up $2 to $BAK_FILENAME"
        cp -L $2 $BAK_FILENAME
        rm $2
    fi

    info_log "Creating symlink $2 -> $1"
    ln -s $1 $2
}

info_log "Checking for dependencies..."

if ! command -v curl &>/dev/null; then
    error_log "curl is not installed. Please install curl and try again."
    exit 1
fi

if ! command -v zsh &>/dev/null; then
    error_log "zsh is not installed. Please install zsh and try again."
    exit 1
fi

info_log "Installing dotfiles..."
info_log "DOTFILES_DIR: $DOTFILES_DIR"

if [ ! -d $HOME/.config ]; then
    info_log "Creating $HOME/.config directory..."
    mkdir -p $HOME/.config
else
    info_log "$HOME/.config directory already exists..."
fi

info_log "Syncing keyboard layouts..."
sync_config_file $DOTFILES_DIR/src/.config/kglobalshortcutsrc $HOME/.config/kglobalshortcutsrc

info_log "Syncing keyboard shortcuts..."
sync_config_file $DOTFILES_DIR/src/.config/kxkbrc $HOME/.config/kxkbrc

# Add cedilla to en keyboard layout
info_log "Adding cedilla to en keyboard layout..."
if [ "$GTK_IM_MODULE" != "cedilla" ]; then
    echo "GTK_IM_MODULE=cedilla" | sudo tee -a /etc/environment
fi
if [ "$QT_IM_MODULE" != "cedilla" ]; then
    echo "QT_IM_MODULE=cedilla" | sudo tee -a /etc/environment
fi

# Install nvm
NVM_VERSION="v0.40.1"
info_log "Installing nvm $NVM_VERSION..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash

# Install zoxide
info_log "Installing zoxide..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Install pnpm
info_log "Installing pnpm..."
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Syncing zshrc
info_log "Syncing zshrc..."
sync_config_file $DOTFILES_DIR/src/.zshrc $HOME/.zshrc
