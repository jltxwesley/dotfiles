dotfiles
===============
Install oh-my-zsh:
*   **sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"**


Clone dot files and vim vundle
*   git clone git@github.com:wesleychang/dotfiles.git
*   git clone https://github.com/gmarik/vundle.git ~/.dotfiles/vim/bundle/Vundle.vim


Add symbolic links
*   ln -s ~/.dotfiles/vim ~/.vim
*   ln -s ~/.dotfiles/vimrc ~/.vimrc
*   ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
*   ln -s ~/.dotfiles/gitconfig ~/.gitconfig
*   ln -s ~/.dotfiles/gitignore_global ~/.gitignore_global
*   ln -s ~/.dotfiles/alias ~/.alias
*   ln -s ~/.dotfiles/ackrc ~/.ackrc


Install vim plugins:
*   Launch vim and run **:PluginInstall**
*   Or install from command line: **vim +PluginInstall +qall**


Add alias:
*   echo "source ~/.alias" | tee -a ~/.zshrc


To update vim bundled plugins:
*   Lunch vim and run **:PluginUpdate**
