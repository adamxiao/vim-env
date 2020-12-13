FROM ubuntu:20.04

# refer https://github.com/JAremko/alpine-vim

MAINTAINER  Adam Xiao "http://github.com/adamxiao"

ENV DEBIAN_FRONTEND noninteractive
ENV UHOME=/root
ENV LANG en_US.UTF-8
ENV LESSCHARSET utf-8

RUN apt update -y \
	&& apt install -y git wget curl \
	&& apt clean all

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
RUN git clone https://github.com/dense-analysis/ale

#ADD ./sources.list /etc/apt/sources.list

# install build software
RUN apt update \
    && apt install -y \
    vim \
    git tmux zsh \
    curl wget \
    ctags cscope \
    build-essential cmake

# install build software
RUN apt update \
    && apt install -y \
    python3-dev

# build YCM with c complete
RUN cd $UHOME/.vim/bundle/YouCompleteMe && python3 ./install.py --clang-completer --clangd-completer

# install fzf
RUN git clone https://github.com/junegunn/fzf $UHOME/.fzf \
    && cd $UHOME/.fzf && ./install --bin

# install adam vimrc
RUN mkdir $UHOME/.vim_swap
RUN cd $UHOME && git init . && git remote add origin https://github.com/adamxiao/ubuntu_10.04_etc.git && git fetch origin && git checkout master

RUN cd $UHOME/.fzf && ./install --all

# install locales
RUN apt install -y locales \
	&& locale-gen zh_CN.UTF-8

# code static check tools
RUN  apt install -y python3-pip \
	&& pip3 install cpplint \
	&& pip3 install autopep8

# install new cppcheck
#RUN apt install -y cppcheck
RUN apt update -y \
	&& apt install -y libpcre3 libpcre3-dev \
	&& mkdir -p /build/cppcheck \
	&& wget https://github.com/danmar/cppcheck/archive/2.2.tar.gz -O /build/cppcheck.tgz \
	&& tar -xzf /build/cppcheck.tgz --strip-components=1 -C /build/cppcheck && cd /build/cppcheck \
	&& make MATCHCOMPILER=yes FILESDIR=/usr/share/cppcheck HAVE_RULES=yes CXXFLAGS="-O2 -DNDEBUG -Wall -Wno-sign-compare -Wno-unused-function" install \
	&& rm -rf /build/

# default shell zsh
RUN chsh -s /bin/zsh

WORKDIR $UHOME

CMD ["zsh"]
