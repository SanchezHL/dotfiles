# Crear simlink en windows

Ejemplo (cmd con privilegios)
mklink /D "%localuser%\AppData\Local\nvim" "%localuser%\dotfiles\nvim"

# Instalacion de dependencias
## fd(linux)
https://github.com/sharkdp/fd#installation
apt-get install fd-find
ln -s $(which fdfind) ~/.local/bin/fd
### fd Guide
https://github.com/sharkdp/fd#how-to-use
## ripgrep
sudo apt-get install ripgrep
### rg Guide 
https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#basics

