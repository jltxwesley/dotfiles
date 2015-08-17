dotfiles
=========
Install oh-my-zsh:
**curl -L http://install.ohmyz.sh | sh**      Or      **wget --no-check-certificate http://install.ohmyz.sh -O - | sh**


Symlink the files:
*   **ln -s  ~/.dotfiles/vim ~/.vim** etc.

Install vim bundled plugins:
*   Launch vim and run **:PluginInstall**
*   Or to install from command line: **vim +PluginInstall +qall**
*   "You Complete Me" Plugin need compiling: **cd ~/.vim/bundle/YouCompleteMe** -----> **./install.sh**


To update vim bundled plugins:
*   **cd ~/.dotfiles/vim/bundle/plugin_name**
*   **git pull origin master**







