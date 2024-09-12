# vim-env in ubuntu 18.04

docker run -it --restart=always -e TERM=xterm-256color --name vim -v $HOME/.ssh:/root/.ssh -v $HOME/.gitconfig:/root/.gitconfig -v $HOME/workspaces:/root/workspaces vim-env

- install YCM
- install vimrc in https://github.com/adamxiao/ubuntu_10.04_etc

## change log

2021.01.25 (coc.nvim-0125)
coc.nvim , ycm plugin, remove coc.nvim duplicate

2021.01.09 (coc.nvim-0109)
coc.nvim with more plugin
