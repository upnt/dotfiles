FROM alpine as config
RUN apk add --update --no-cache git curl \
  && mkdir -p /root/.config/nvim \
  && git clone --depth 1 -b main https://github.com/upnt/dotfiles \
  && mv dotfiles/nvim/* /root/.config/nvim \
  && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh \
  && sh ./installer.sh /root/.cache/dein

FROM debian:buster-slim
COPY --from=upnt/neovim-docker:v0.7.0-debian-release /usr/local/ /usr/local
COPY --from=python:slim-buster /usr/local/ /usr/local
COPY --from=node:18-buster-slim /usr/local/ /usr/local
COPY --from=config /root/.cache/dein /root/.cache/dein
COPY --from=config /root/.config/nvim /root/.config/nvim
ENV DENO_INSTALL /root/.deno
ENV PATH $DENO_INSTALL/bin:$PATH
RUN apt-get update \
 && apt-get install -y git curl wget unzip \
 && curl -fsSL https://deno.land/install.sh | sh \
 && mkdir /root/workspace \
 && pip install pynvim \
 && npm install --location=global neovim \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && nvim -c "call dein#install()" -c "LspInstall pyright" -c "q"
WORKDIR /root/workspace
CMD nvim
