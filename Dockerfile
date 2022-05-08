FROM ubuntu:20.04

# refer https://github.com/JAremko/alpine-vim

MAINTAINER  Adam Xiao "iefcuxy@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV UHOME=/root
ENV LANG en_US.UTF-8
ENV LESSCHARSET utf-8

# basic vim install
RUN apt update -y \
    && apt install -y \
    vim \
    git \
    curl wget \
    universal-ctags jq python3 \
    silversearcher-ag \
    locales \
    && locale-gen zh_CN.UTF-8 \
    && locale-gen en_US.UTF-8 \
    && apt clean && rm -rf /var/lib/apt/lists/*

ADD ./dist/vimrc $UHOME/.vim/vimrc
ADD ./dist/plug.vim $UHOME/.vim/autoload/plug.vim

# install vim plugins:
RUN vim +PlugInstall +qall
#vi +':set nu' +':q!'

# vim extra config
RUN mkdir $UHOME/.vim_swap \
    && cd $UHOME && git init . \
    && git remote add origin https://github.com/adamxiao/ubuntu_10.04_etc.git \
    && git fetch origin && git checkout -f master \
    && git config --global --add safe.directory '*'

# refer https://github.com/jszakmeister/markdown2ctags
ADD ./dist/markdown2ctags.py /usr/bin/markdown2ctags.py

WORKDIR /data

ENV TERM=xterm-256color
ENTRYPOINT ["vim"]
