desc "deploy .vim .vimrc to $HOME"
task :default do
  sh "cp -a .ctags $HOME/"
  sh "cp -a .tmux.conf $HOME/"
  sh "cp -a .gitconfig $HOME/"
  sh "cp -a .gitignore_global $HOME/"

  sh "mkdir -p $HOME/.vim"
  sh "cp -a .vimrc $HOME/ && sed --version 2>/dev/null | head -1 | grep GNU &>/dev/null && sed -i '/\" =For Plugin=/,$d' $HOME/.vimrc || sed -i '' '/\" =For Plugin=/,$d' $HOME/.vimrc"
  sh "[ ! -e \"$HOME/.vim/bundle/Vundle.vim\" ] && git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim || true"
  sh "vim +PluginInstall +qall"
  sh "cp -a .vimrc $HOME/"
end
