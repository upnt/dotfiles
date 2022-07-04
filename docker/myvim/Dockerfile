FROM alpine:latest
RUN apk add vim git \
 && git clone --depth 1 -b main https://github.com/upnt/dotfiles \
 && mkdir /root/.vim \
 && cp dotfiles/vim/* /root/.vim \
 && rm dotfiles -rf
WORKDIR /root/workspace
CMD vim
