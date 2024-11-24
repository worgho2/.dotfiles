#!/bin/bash


# Install dependencies
sudo apt-get install curl zsh -y

# Install nvm
NVM_VERSION="v0.40.1"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | sh

# Install zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Backup existing zsh config
if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.bak
fi

# Create a symbolic link to the zshrc file
ln -s $(pwd)/zshrc ~/.zshrc

# TODO
# Shortcuts
# Keyboard layout
# Open razer
# kde shortcuts
