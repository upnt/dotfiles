FROM debian:buster-slim
COPY ./rc/vim/* /root/.vim/
COPY ./rc/bash/* /root/
RUN apt-get update \
 && apt-get install -y vim locales \
 && locale-gen en_US.UTF-8 \
 && localedef -f UTF-8 -i en_US en_US.UTF-8 \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /root/workspace
CMD vim
