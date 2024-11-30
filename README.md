# .dotfiles 

## Distribution

This repository is specifically designed for **Kubuntu 24.04** running **KDE Plasma 5.27** and may not work properly on other Linux distributions or versions.

## Features

- zsh shell
- zsh spaceship
- zsh autosuggestions plugin
- zsh syntax highlighting plugin
- oh-my-zsh
- nvm
- pnpm
- zoxide
- kde plasma en.intl keyboard layout with mac-like shortcuts

## Installation

0. Install system wide dependencies:

```shell
sudo apt update
sudo apt install curl zsh git
```

1. Clone the repository including all submodules

```shell
git clone --recurse-submodules git://github.com/worgho2/.dotfiles.git ~/.dotfiles
```

2. Open the repository root folder

```
cd ~/.dotfiles
```

3. Make de install script executable

```shell
sudo chmod +x install.sh
```

4. Run the install script

```shell
./install.sh
```

## Testing

There are two files being used to test the configuration in a isolated environment using `docker`:

1. `Dockerfile`: It declares the base requirements configuration. Despite not having KDE Plasma installed, it can be used to debug the installation process.
2. `test.sh`: It builds and starts a docker container attaching the zsh shell directly.