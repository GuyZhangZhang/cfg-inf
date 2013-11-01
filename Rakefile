desc "deploy .vim .vimrc to $HOME"
task :default do
  sh "rsync -ar --exclude=.git --delete .vim $HOME/"
  sh "cp -a .vimrc $HOME/"
  sh "cp -a .ctags $HOME/"
end
