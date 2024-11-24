# EMACS KEYBINDINGS
bindkey -e


# SHELL HISTORY
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=$HOME/.zsh_history


# SPACESHIP-PROMPT
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
source "$(pwd -P)/spaceship/spaceship.zsh"


# SYNTAX HIGHLIGHTING
source "$(pwd -P)/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


# AUTOSUGGESTIONS
source "$(pwd -P)/zsh-autosuggestions/zsh-autosuggestions.zsh"


# COMPLETIONS
autoload -Uz compinit
compinit


# GIT
function __git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}
function git_current_branch() {
  local ref
  ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return 0
    fi
  done

  # If no main branch was found, fall back to master but return error
  echo master
  return 1
}
function git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel develop development; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return 0
    fi
  done

  echo develop
  return 1
}
function ggp() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git push origin "${b:=$1}"
  fi
}
function ggl() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git pull origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git pull origin "${b:=$1}"
  fi
}
function gbda() {
  git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch --delete 2>/dev/null
}
alias ggpull='ggl'
alias ggpush='ggp'
alias gcm='git checkout $(git_main_branch)'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcB='git checkout -B'
alias gfa='git fetch --all --tags --prune'


# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# PNPM
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac


# ZOXIDE
export PATH=$HOME/.local/bin:$PATH
eval "$(zoxide init zsh)"