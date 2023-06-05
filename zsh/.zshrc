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

source ~/.config/zsh/agnoster.zsh-theme
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
