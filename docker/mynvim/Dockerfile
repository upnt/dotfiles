FROM alpine as config
RUN apk add --update --no-cache git curl \
  && mkdir -p /root/.config/nvim \
  && git clone --depth 1 -b main https://github.com/upnt/dotfiles \
  && mv dotfiles/nvim/* /root/.config/nvim \
  && find dotfiles/bash -name ".*" | xargs -I FILE mv FILE -t /root/ \
  && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh \
  && sh ./installer.sh /root/.cache/dein

FROM debian:buster-slim
COPY --from=ghcr.io/upnt/neovim-docker:v0.7.2-buster-slim-release /usr/local/ /usr/local
COPY --from=python:slim-buster /usr/local/ /usr/local
COPY --from=node:18-buster-slim /usr/local/ /usr/local
COPY --from=config /root/.cache/dein /root/.cache/dein
COPY --from=config /root/.config/nvim /root/.config/nvim
COPY --from=config /root /root
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
 && mkdir /root/workspace \
 && pip install -U pip \
 && pip install pynvim \
 && npm install --location=global neovim \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && nvim -c "call dein#install()" -c "q"
WORKDIR /root/workspace
CMD nvim
