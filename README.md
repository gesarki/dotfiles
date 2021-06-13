# Dotfiles
---
## Instructions
1. clone this project
2. `ln -s .bashrc ~/.bashrc`
3. `ln -s init.vim ~/.config/nvim/init.vim`
4. `ln -s .vimrc ~/.vimrc`
5. sed 's/#.*//' apt-packages.txt | xargs sudo apt-get install
