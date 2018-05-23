FROM debian:latest
LABEL maintainer="Marc Schlienger <marc@schlienger.net>"

ENV DEBIAN_FRONTEND noninteractive

# Common packages
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    cm-super \
    curl \
    fontconfig \
    fonts-powerline \
    git \
    locales \
    locales-all \
    mosh \
    openssh-server \
    pandoc \
    pandoc-citeproc \
    python \
    python-dev \
    python3 \
    python3-dev \
    texlive \
    texlive-bibtex-extra \
    texlive-fonts-extra \
    texlive-lang-german \
    texlive-latex-extra \
    texlive-math-extra \
    tmux \
    vim-nox \
    zsh \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Locale
ENV LANG de_DE.UTF-8
ENV LANGUAGE de_DE:de
ENV LC_ALL de_DE.UTF-8

# User
RUN useradd -ms /usr/bin/zsh doc
RUN echo 'doc:screencast' | chpasswd

USER doc

# Zsh, vim and tmux
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN git clone https://github.com/marcschlienger/dotfiles.git /home/doc/dotfiles
RUN /home/doc/dotfiles/symlink.sh
RUN git clone https://github.com/VundleVim/Vundle.vim.git /home/doc/.vim/bundle/Vundle.vim
RUN vim +PluginInstall +qall
RUN /home/doc/.vim/bundle/YouCompleteMe/install.py --clang-completer
RUN git clone https://github.com/denysdovhan/spaceship-prompt.git "/home/doc/.zsh/themes/spaceship-prompt" \
    && ln -s "/home/dev/.zsh/themes/spaceship-prompt/spaceship.zsh-theme" "/home/doc/.zsh/themes/spaceship.zsh-theme"

USER root

# Fix the bug https://bugs.launchpad.net/ubuntu/+source/openssh/+bug/45234
RUN mkdir /var/run/sshd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

EXPOSE 22/tcp 60001/udp
CMD ["/usr/sbin/sshd", "-D"]

