FROM ubuntu:24.04

WORKDIR /Projects/.dotfiles

COPY . .

RUN echo "test" >>~/.zshrc

RUN apt-get update && apt-get install -y curl zsh

ENV SHELL /bin/zsh

RUN chmod +x install.sh && ./install.sh

ENTRYPOINT [ "/bin/zsh" ]
