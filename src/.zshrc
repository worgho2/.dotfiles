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
SPACESHIP_CHAR_SYMBOL="❯"
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
