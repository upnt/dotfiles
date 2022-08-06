FROM debian:buster-slim
COPY --from=ghcr.io/upnt/neovim-docker:v0.7.2-buster-slim-release /usr/local/ /usr/local
COPY --from=python:slim-buster /usr/local/ /usr/local
COPY --from=node:18-buster-slim /usr/local/ /usr/local
COPY ./rc/nvim /root/.config/nvim
COPY ./rc/bash/* /root
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV TERM xterm-256color
ENV DENO_INSTALL $HOME/.deno
ENV PATH $PATH:$DENO_INSTALL/bin
RUN apt-get update \
 && apt-get install -y git curl wget unzip ripgrep locales \
 && locale-gen en_US.UTF-8 \
 && localedef -f UTF-8 -i en_US en_US.UTF-8 \
 && curl -fsSL https://deno.land/install.sh | sh \
 && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh \
 && sh ./installer.sh /root/.cache/dein \
 && mkdir /root/workspace \
 && pip install -U pip \
 && pip install pynvim \
 && npm install --location=global neovim \
 && apt-get clean \
 && rm installer.sh \
 && rm -rf /var/lib/apt/lists/* \
 && nvim -c "call dein#install()" -c "q"
WORKDIR /root/workspace
CMD nvim
