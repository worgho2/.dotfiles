#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

LOG_FILE="$DOTFILES_DIR/install.$(date +%Y-%m-%d_%H-%M-%S).log"
exec > >(tee -a $LOG_FILE)
exec 2> >(tee -a $LOG_FILE >&2)
sleep .1

log() {
    local log_color="\033[0m"

    if [ "$1" == "ERROR" ]; then
        log_color="\033[31m"
    elif [ "$1" == "INFO" ]; then
        log_color="\033[32m"
    fi

    local log_message="$log_color[$1] $2\033[0m"
    echo -e $log_message
}

sync_config_file() {
    if [ -f $2 ]; then
        local BAK_FILENAME="$2.$(date +%s).bak"
        log INFO "Backing up $2 to $BAK_FILENAME"
        cp -L $2 $BAK_FILENAME
        rm $2
    fi

    log INFO "Creating symlink $2 -> $1"

    if [ ! -d $(dirname $2) ]; then
        log INFO "Creating parent directories for $2"
        mkdir -p $(dirname $2)
    fi

    ln -s $1 $2
}

log INFO "Checking for dependencies..."

if ! command -v curl &>/dev/null; then
    log ERROR "curl is not installed. Please install curl and try again."
    exit 1
fi

if ! command -v zsh &>/dev/null; then
    log ERROR "zsh is not installed. Please install zsh and try again."
    exit 1
fi

log INFO "Installing dotfiles..."
log INFO "DOTFILES_DIR: $DOTFILES_DIR"

log INFO "Syncing keyboard layouts..."
sync_config_file $DOTFILES_DIR/src/.config/kglobalshortcutsrc $HOME/.config/kglobalshortcutsrc

log INFO "Syncing keyboard shortcuts..."
sync_config_file $DOTFILES_DIR/src/.config/kxkbrc $HOME/.config/kxkbrc

# Add cedilla to en keyboard layout
log INFO "Adding cedilla to en keyboard layout..."
if [ "$GTK_IM_MODULE" != "cedilla" ]; then
    echo "GTK_IM_MODULE=cedilla" | tee -a /etc/environment
fi
if [ "$QT_IM_MODULE" != "cedilla" ]; then
    echo "QT_IM_MODULE=cedilla" | tee -a /etc/environment
fi

# Install nvm
NVM_VERSION="v0.40.1"
log INFO "Installing nvm $NVM_VERSION..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash

# Install zoxide
log INFO "Installing zoxide..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Install pnpm
log INFO "Installing pnpm..."
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Sync zsh custom themes
log INFO "Syncing zshrc custom themes..."
sync_config_file $DOTFILES_DIR/src/.zsh/spaceship-prompt/spaceship.zsh-theme $DOTFILES_DIR/src/.oh-my-zsh/custom/themes/spaceship.zsh-theme

# Sync zsh custom plugins
log INFO "Syncing zshrc custom plugins..."
sync_config_file $DOTFILES_DIR/src/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh $DOTFILES_DIR/src/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
sync_config_file $DOTFILES_DIR/src/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh $DOTFILES_DIR/src/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
# Syncing zshrc
log INFO "Syncing zshrc..."
sync_config_file $DOTFILES_DIR/src/.zshrc $HOME/.zshrc
