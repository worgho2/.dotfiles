#!/bin/bash

docker build --progress=plain -t worgho2-dotfiles:test .

docker run --rm -it worgho2-dotfiles:test
