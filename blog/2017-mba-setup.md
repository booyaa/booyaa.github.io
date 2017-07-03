extends: post.liquid
title: MacBook Air Setup
date: 4 Jun 2017 16:49:09 +0100
path: 2017/mba-setup
tags: mac, homebrew, vscode, vim, setup
---
Here's my current setup for my MacBook Air Setup. I use a range of tools like 
homebrew, Visual Studio Code and vim.

## homebrew

```shell
brew install \
        python python3 bash-git-prompt elixir figlet ffmpeg go httpie \ 
        imagemagick jq nmap zeromq reattach-to-user-namespace tmux sqlite \ 
        watch vim yarn youtube-dl doctl
```

## vscode extensions

- gitlens
- hipsum
- Insert Date String
- Liquid Language
- Prettyify JSON
- Python (Don's)
- vscode-rust

## vim plugins 

```shell
$ ls ~/.vim/bundle/
go-explorer	rust.vim	tagbar		vim-fugitive	vim-go		webapi-vim
nerdtree	syntastic	tcomment_vim	vim-gitgutter	vim-racer
```


