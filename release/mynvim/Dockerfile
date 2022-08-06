FROM debian:buster-slim
COPY --from=ghcr.io/upnt/neovim-docker:v0.7.2-buster-slim-release /usr/local/ /usr/local
COPY --from=python:slim-buster /usr/local/ /usr/local
COPY --from=node:18-buster-slim /usr/local/ /usr/local
COPY ./rc/nvim /root/.config/nvim
COPY ./rc/bash/* /root
ENV TERM xterm-256color
ENV DENO_INSTALL $HOME/.deno
ENV PATH $PATH:$DENO_INSTALL/bin
ENV LANG ja_JP.UTF-8
RUN apt-get update \
 && apt-get install -y git curl wget unzip ripgrep locales \
 && sed -i -e 's/# \(ja_JP.UTF-8\)/\1/' /etc/locale.gen \
 && sed -i -e 's/# \(ja_JP.EUC-JP\)/\1/' /etc/locale.gen \
 && locale-gen \
 && curl -fsSL https://deno.land/install.sh | sh \
 && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh \
 && sh ./installer.sh /root/.cache/dein \
 && mkdir /root/.skk \
 && wget https://skk-dev.github.io/dict/SKK-JISYO.L.gz \
 && gunzip SKK-JISYO.L.gz \
 && mv SKK-JISYO.L /root/.skk \
 && mkdir /root/workspace \
 && pip install -U pip \
 && pip install pynvim \
 && npm install --location=global neovim \
 && apt-get clean \
 && rm installer.sh \
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/* \
 && nvim -c "call dein#install()" -c "q"
WORKDIR /root/workspace
CMD nvim
