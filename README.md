## Neovim 

![Neovim](nvim.png)

## Use zsh as main shell

Add this code below to ~/.zshrc

```
if [ -r ~/.config/zsh/.zshrc ]; then
  source ~/.config/zsh/.zshrc
fi
```

## Change keyrepeat macOS

InitialKeyRepeat 15, 12, 10,...

```
defaults read | grep -i 'keyrepeat' # check all defaults for keyrepeat
defaults write -g InitialKeyRepeat -int 12 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
```

NOTE: The changes aren't applied until you log out and back in.
