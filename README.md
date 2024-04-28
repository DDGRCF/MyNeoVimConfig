# MyNeoVimConfig

## Description

This repo is my neovim config.

## Requirements

1. Node
    * proxy: `npm config set registry https://registry.npmmirror.com && npm config get registry`
    * 18.04+: `https://nodejs.org/dist/v22.0.0/node-v22.0.0-linux-x64.tar.xz`
    * 16.04: `https://nodejs.org/dist/v16.20.2/node-v16.20.2-linux-x64.tar.xz`
    * `npm install fd-find && export PATH=where-fd-find:$PATH`
    * `npm install @vscode/ripgrep && export PATH=whre-vscode-ripgrep:$PATH`
2. Fzf
    * `git clone --depth 1 https://github.com/junegunn/fzf.git`(NOTE: don't delete fzf)
    * `cd fzf && bash install.sh`
3. Anaconda3
    * default: `~/Anaconda3`
