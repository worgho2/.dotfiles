DOTFILES_DIR="$HOME/.dotfiles"
export PATH=$HOME/.local/bin:$PATH

###############
#  OH-MY-ZSH  #
###############

export ZSH="$DOTFILES_DIR/src/.oh-my-zsh"

ZSH_THEME="spaceship"

SPACESHIP_PROMPT_ORDER=(
  user
  dir
  host
  git
  node
  docker
  aws
  exec_time
  line_sep
  jobs
  exit_code
  sudo
  char
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SUFFIX=" "

plugins=(
  git
  nvm
  zoxide
  lol
  zsh-autosuggestions
  zsh-syntax-highlighting
)

zstyle ':omz:plugins:nvm' lazy yes

source "$ZSH/oh-my-zsh.sh"

###############
# USER CONFIG #
###############

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# VSCode
export VSCODE_HOME="/usr/share/code"
case ":$PATH:" in
*":$VSCODE_HOME:"*) ;;
*) export PATH="$VSCODE_HOME:$PATH" ;;
esac
# VSCode end

# Cursor
function cursor() {
    $HOME/Applications/Cursor.AppImage --no-sandbox "${@}" > /dev/null 2>&1 & disown
}

# Cursor end

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/worgho2/.cache/lm-studio/bin"

alias yt-dl='docker run --rm -i -e PGID=$(id -g) -e PUID=$(id -u) -v "$(pwd)":/workdir:rw mikenye/youtube-dl'

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
