FROM ubuntu:18.04

# refer https://github.com/JAremko/alpine-vim

MAINTAINER  Adam Xiao "iefcuxy@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV UHOME=/root

# basic vim install
RUN apt-get update -y \
    && apt-get install -y \
    vim \
    git tmux zsh \
    curl wget \
    ctags cscope zsh \
    build-essential cmake python3-dev python3-requests

ADD ./dist/vimrc $UHOME/.vim/vimrc
ADD ./dist/plug.vim $UHOME/.vim/autoload/plug.vim

# install vim plugins:
RUN vim +PlugInstall +qall
#vi +':set nu' +':q!'

# vim extra config
RUN mkdir $UHOME/.vim_swap

WORKDIR $UHOME
