FROM ubuntu:20.04

# refer https://github.com/JAremko/alpine-vim

MAINTAINER  Adam Xiao "iefcuxy@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV UHOME=/root
ENV LANG en_US.UTF-8
ENV LESSCHARSET utf-8

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

# install locales
RUN apt install -y locales \
	&& locale-gen zh_CN.UTF-8

# vim extra config
RUN mkdir $UHOME/.vim_swap

# code static check tools
RUN  apt install -y python3-pip \
	&& pip3 install cpplint \
	&& pip3 install autopep8 \
	&& apt install -y cppcheck

# grep tools, format tools
RUN apt install -y clang-format astyle \
	ripgrep silversearcher-ag ack

# clang-format default config
COPY dist/_clang-format /root/.clang-format
# ycm clangd default compile flags
COPY dist/compile_flags.txt /root/compile_flags.txt

#RUN mkdir -p $UHOME/.vim/bundle
#WORKDIR $UHOME/.vim/bundle
RUN cd $UHOME/.vim/bundle && git clone --depth 1  https://github.com/Valloric/YouCompleteMe \
	&& cd YouCompleteMe && git submodule update --init --recursive \
	&& python3 ./install.py --clangd-completer

RUN cd $UHOME && rm -f $UHOME/autoload/plug.vim $UHOME/.vim/vimrc $UHOME/.zshrc $UHOME/.zshrc \
	&& git init . && git remote add origin https://github.com/adamxiao/ubuntu_10.04_etc.git && git fetch origin && git checkout plug-0102

# default shell zsh
RUN chsh -s /bin/zsh

WORKDIR $UHOME

CMD ["zsh"]
