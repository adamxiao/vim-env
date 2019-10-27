FROM ubuntu:18.04

# refer https://github.com/JAremko/alpine-vim

MAINTAINER  Adam Xiao "http://github.com/adamxiao"

ENV DEBIAN_FRONTEND noninteractive
ENV UHOME=/root

ADD ./sources.list /etc/apt/sources.list

RUN apt-get update -y \
    && apt-get install -y \
    vim \
    git tmux zsh \
    curl wget \
    ctags cscope zsh \
    build-essential cmake python3-dev python3-requests

# vim plugins:
RUN mkdir -p $UHOME/.vim/bundle
WORKDIR $UHOME/.vim/bundle
RUN git clone --depth 1  https://github.com/Valloric/YouCompleteMe \
    && cd YouCompleteMe && git submodule update --init --recursive

RUN git clone https://github.com/VundleVim/Vundle.vim
RUN git clone https://github.com/scrooloose/nerdcommenter
RUN git clone https://github.com/tpope/vim-sleuth
RUN git clone https://github.com/majutsushi/tagbar
RUN git clone https://github.com/junegunn/fzf.vim
RUN git clone https://github.com/junegunn/vim-easy-align
RUN git clone https://github.com/skywind3000/asyncrun.vim

# build YCM with c complete
RUN cd $UHOME/.vim/bundle/YouCompleteMe && python3 ./install.py --clang-completer

# install fzf
RUN git clone https://github.com/junegunn/fzf $UHOME/.fzf \
    && cd $UHOME/.fzf && ./install --bin

# install adam vimrc
RUN mkdir $UHOME/.vim_swap
RUN cd $UHOME && git init . && git remote add origin https://github.com/adamxiao/ubuntu_10.04_etc.git && git fetch origin && git checkout master

RUN cd $UHOME/.fzf && ./install --all

WORKDIR $UHOME
