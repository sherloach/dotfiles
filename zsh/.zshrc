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
alias v=nvim

alias python=/usr/local/bin/python3
alias lg='lazygit'

bindkey -s ^f "tmux-sessionizer\n"

# source ~/.config/zsh/omer.zsh-theme
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/.config/zsh/zsh-git-prompt/zshrc.sh
eval "$(starship init zsh)"
