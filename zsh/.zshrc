# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export PATH=/Users/hayden/.local/bin:$PATH
export LSCOLORS="exfxcxdxbxegedabagacad"

eval "$(zoxide init zsh)"

# Alias
alias ls="ls -p -G"
alias la="ls -A"
alias ll="ls -l"
alias lla="ll -A"
alias g=git
alias lv=lvim

alias python=/usr/local/bin/python3
alias lg='lazygit'

