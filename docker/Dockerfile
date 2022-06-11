FROM alpine as config
RUN apk add --update --no-cache git curl \
  && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh \
  && sh ./installer.sh /root/.cache/dein

FROM debian:buster-slim
COPY --from=upnt/neovim-docker:v0.7.0-debian-release /usr/local/ /usr/local
COPY --from=python:slim-buster /usr/local/ /usr/local
COPY --from=node:18-buster-slim /usr/local/ /usr/local
COPY --from=config /root/.cache/dein /root/.cache/dein
ENV DENO_INSTALL /root/.deno
ENV PATH $DENO_INSTALL/bin:$PATH
RUN apt-get update \
 && apt-get install -y git curl wget unzip \
 && mkdir /root/workspace \
 && mkdir -p /root/.config/nvim \
 && git clone https://github.com/upnt/dotfiles /root/workspace/dotfiles \
 && curl -fsSL https://deno.land/install.sh | sh \
 && pip install pynvim \
 && npm install --location=global neovim \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /root/workspace
RUN ln -s /root/workspace/dotfiles/nvim/* /root/.config/nvim
CMD nvim
