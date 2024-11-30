FROM ubuntu:24.04

WORKDIR /root/.dotfiles

COPY . .

RUN echo "export A=1" >>~/.zshrc

RUN apt-get update && apt-get install -y curl zsh git

ENV SHELL=/bin/zsh

RUN sed -i 's/sudo//g' install.sh
RUN chmod +x install.sh && ./install.sh

ENTRYPOINT [ "/bin/zsh" ]
