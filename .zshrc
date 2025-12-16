if [ -f ~/.config/dircolors ]; then
    eval $(dircolors ~/.config/dircolors)
fi

if [ -d ~/.config/zsh ]; then
  for config in ~/.config/zsh/*.zsh
  do
    source $config
  done
fi

alias luamake=/home/${HOME}/.local/share/nvim/site/pack/packer/start/lua-language-server/3rd/luamake/luamake
