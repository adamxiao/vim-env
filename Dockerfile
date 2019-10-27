FROM ubuntu:18.04

# refer https://github.com/JAremko/alpine-vim

MAINTAINER  Adam Xiao "http://github.com/adamxiao"

ENV DEBIAN_FRONTEND noninteractive

ADD ./sources.list /etc/apt/sources.list

RUN apt-get update -y \
    && apt-get install -y \
    vim \
    git tmux

# install YCM: https://github.com/ycm-core/YouCompleteMe
RUN apt-get install -y \
    build-essential cmake python3-dev

RUN  mkdir -p $HOME/bundle \
    && git clone --depth 1  https://github.com/Valloric/YouCompleteMe \
    $HOME/bundle/YouCompleteMe/

#RUN cd $HOME/bundle/YouCompleteMe \
    #&& git submodule update --init --recursive

RUN cd $HOME/bundle/YouCompleteMe/third_party \
    && git clone https://github.com/PythonCharmers/python-future

RUN cd $HOME/bundle/YouCompleteMe/third_party \
    && git clone https://github.com/ross/requests-futures

RUN cd $HOME/bundle/YouCompleteMe/third_party \
    && git clone https://github.com/certifi/python-certifi

RUN cd $HOME/bundle/YouCompleteMe/third_party \
    && git clone https://github.com/ycm-core/ycmd

RUN cd $HOME/bundle/YouCompleteMe/third_party/requests_deps \
    && git clone https://github.com/certifi/python-certifi

RUN cd $HOME/bundle/YouCompleteMe/third_party/requests_deps \
    && git clone https://github.com/chardet/chardet

RUN cd $HOME/bundle/YouCompleteMe/third_party/requests_deps \
    && git clone https://github.com/kjd/idna

RUN cd $HOME/bundle/YouCompleteMe/third_party/requests_deps \
    && git clone https://github.com/requests/requests

RUN cd $HOME/bundle/YouCompleteMe/third_party/requests_deps \
    && git clone https://github.com/urllib3/urllib3

#RUN cd $HOME/bundle/YouCompleteMe/third_party/ycmd \
    #&& git submodule update --init --recursive

RUN cd $HOME/bundle/YouCompleteMe/third_party/ycmd/third_party \
    && git clone https://github.com/defnull/bottle

RUN cd $HOME/bundle/YouCompleteMe/third_party/ycmd/third_party \
    && git clone https://github.com/ycm-core/regex.git

RUN cd $HOME/bundle/YouCompleteMe/third_party/ycmd/third_party \
    && git clone https://github.com/slezica/python-frozendict

RUN cd $HOME/bundle/YouCompleteMe/third_party/ycmd/third_party/go/src/golang.org/x \
    && git clone https://github.com/golang/tools

RUN cd $HOME/bundle/YouCompleteMe/third_party/ycmd/third_party \
    && git clone https://github.com/davidhalter/jedi

RUN cd $HOME/bundle/YouCompleteMe/third_party/ycmd/third_party/jedi_deps/ \
    && git clone https://github.com/numpy/numpydoc

RUN cd $HOME/bundle/YouCompleteMe/third_party/ycmd/third_party \
    && git clone https://github.com/davidhalter/parso

RUN cd $HOME/bundle/YouCompleteMe/third_party/ycmd/third_party \
    && rm -rf python-future && cp -r $HOME/bundle/YouCompleteMe/third_party/python-future .

RUN cd $HOME/bundle/YouCompleteMe/third_party/ycmd/third_party \
    && rm -rf python-certifi && cp -r $HOME/bundle/YouCompleteMe/third_party/python-certifi .

RUN cd $HOME/bundle/YouCompleteMe/third_party/ycmd/third_party \
    && rm -rf chardet && cp -r $HOME/bundle/YouCompleteMe/third_party/requests_deps/chardet .

RUN cd $HOME/bundle/YouCompleteMe/third_party/ycmd/third_party \
    && rm -rf idna && cp -r $HOME/bundle/YouCompleteMe/third_party/requests_deps/idna .

RUN cd $HOME/bundle/YouCompleteMe/third_party/ycmd/third_party \
    && rm -rf requests && cp -r $HOME/bundle/YouCompleteMe/third_party/requests_deps/requests .

RUN cd $HOME/bundle/YouCompleteMe/third_party/ycmd/third_party \
    && rm -rf urllib3 && cp -r $HOME/bundle/YouCompleteMe/third_party/requests_deps/urllib3 .

RUN cd $HOME/bundle/YouCompleteMe/third_party/ycmd/third_party \
    && git clone https://github.com/Pylons/waitress

RUN cd $HOME/bundle/YouCompleteMe/third_party/ycmd/third_party \
    && rmdir cregex && mv regex cregex && rmdir frozendict && mv python-frozendict frozendict

RUN apt-get install -y python3-requests

RUN python3 $HOME/bundle/YouCompleteMe/install.py --clang-completer

# TODO: install fzf
RUN git clone https://github.com/junegunn/fzf $HOME/.fzf
#RUN apt-get install -y curl wget && cd $HOME/.fzf && ./install --all

# TODO: install adam vimrc
RUN cd $HOME && git init . && git remote add origin https://github.com/adamxiao/ubuntu_10.04_etc.git && git fetch origin && git checkout master
RUN mkdir -p $HOME/.vim_swap && apt-get install -y ctags cscope zsh
RUN mkdir -p $HOME/.vim/bundle && cd $HOME/.vim/bundle && git clone https://github.com/VundleVim/Vundle.vim
#RUN vim +PluginInstall +qall

#RUN git clone https://github.com/adamxiao/ubuntu_10.04_etc

#ENTRYPOINT ["vim"]
