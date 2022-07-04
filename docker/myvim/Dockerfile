FROM alpine:latest
RUN apk add vim git \
 && git clone --depth 1 -b main https://github.com/upnt/dotfiles \
 && mv dotfiles/vim/* /root/.vimrc/vim \
 && rm dotfiles -rf
WORKDIR /root/workspace
CMD vim
