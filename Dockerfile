FROM ubuntu:20.04

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

# grep tools, format tools
RUN apt install -y clang-format astyle \
	ripgrep silversearcher-ag ack

# install locales
RUN apt install -y locales \
	&& locale-gen zh_CN.UTF-8 \
	&& locale-gen en_US.UTF-8

# install vim plugins
RUN mkdir -p $UHOME/.vim/bundle \
	&& cd $UHOME/.vim/bundle \
	&& git clone --depth=1 https://github.com/morhetz/gruvbox \
	&& git clone --depth=1 https://github.com/zivyangll/git-blame.vim \
	&& git clone --depth=1 https://github.com/airblade/vim-gitgutter \
	&& git clone --depth=1 https://github.com/vim-scripts/vcscommand.vim \
	&& git clone --depth=1 https://github.com/scrooloose/nerdcommenter \
	&& git clone --depth=1 https://github.com/majutsushi/tagbar \
	&& git clone --depth=1 https://github.com/junegunn/fzf.vim \
	&& git clone --depth=1 https://github.com/dense-analysis/ale \
	&& git clone --depth=1 https://github.com/neoclide/coc.nvim -b release \
	&& git clone --depth=1 https://github.com/junegunn/vim-easy-align \
	&& git clone --depth=1 https://github.com/skywind3000/asyncrun.vim \
	&& git clone --depth=1 https://github.com/scrooloose/nerdtree \
	&& git clone --depth=1 https://github.com/vim-airline/vim-airline \
	&& git clone --depth=1 https://github.com/vim-scripts/a.vim \
	&& git clone --depth=1 https://github.com/jlanzarotta/bufexplorer \
	&& git clone --depth=1 https://github.com/mbbill/fencview \
	&& git clone --depth=1 https://github.com/MarcWeber/vim-addon-mw-utils \
	&& git clone --depth=1 https://github.com/tomtom/tlib_vim \
	&& git clone --depth=1 https://github.com/garbas/vim-snipmate \
	&& git clone --depth=1 https://github.com/honza/vim-snippets \
	&& git clone --depth=1 https://github.com/Kris2k/matchit \
	&& git clone --depth=1 https://github.com/dimasg/vim-mark \
	&& git clone --depth=1 https://github.com/tpope/vim-fugitive \
	&& git clone --depth=1 https://github.com/mhinz/vim-grepper \
	&& git clone --depth=1 https://github.com/PhilRunninger/nerdtree-visual-selection \
	&& git clone --depth=1 https://github.com/Xuyuanp/nerdtree-git-plugin \
	&& git clone --depth=1 https://github.com/tpope/vim-surround \
	&& git clone --depth=1 https://github.com/tpope/vim-repeat \
	&& git clone --depth=1 https://github.com/jiangmiao/auto-pairs \
	&& git clone --depth=1 https://github.com/junegunn/fzf $UHOME/.fzf \
	&& $UHOME/.fzf/install --bin

# code static check tools
RUN apt install -y python3-pip \
	&& pip3 install cpplint \
	&& pip3 install autopep8 \
	&& apt install -y cppcheck

# install adamxiao vimrc
RUN cd $UHOME && git init . \
	&& git remote add origin https://github.com/adamxiao/ubuntu_10.04_etc.git \
	&& git fetch origin && git checkout -f master \
	&& mkdir $UHOME/.vim_swap

# install coc-clangd extension
#RUN curl -sL install-node.now.sh/lts | bash
RUN apt install -y nodejs npm clangd
COPY ./dist/coc-plug-install.sh /coc-plug-install.sh
RUN bash /coc-plug-install.sh

# clang-format default config
COPY dist/_clang-format /root/.clang-format
# ycm clangd default compile flags
COPY dist/compile_flags.txt /root/compile_flags.txt

# default shell zsh
RUN chsh -s /bin/zsh

ENV LANG en_US.UTF-8
ENV LESSCHARSET utf-8

WORKDIR $UHOME

CMD ["zsh"]
