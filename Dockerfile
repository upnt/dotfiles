FROM alpine:latest

LABEL maintainer="upnt <upnt.github@gmail.com>" \
      version="1.0"
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:ja \
    LC_ALL=en_US.UTF-8

COPY --from=upnt/neovim-docker:stable /usr/local/bin/nvim /usr/local/bin/nvim
COPY ./ /root/.config/nvim

RUN apk add --no-cache libgcc
