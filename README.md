# Workstation Setup

This repo contains scripts and dotfiles I use to setup a new Linux workstation.

It was inspired by https://stribny.name/blog/ansible-dev/

Only Ubuntu Linux is currently supported.

## How to use

Just clone the repo and run `./bootstrap.sh`.

## What will be installed

- [Docker](https://www.docker.com/)
- [Neovim](https://neovim.io/)
- [Helix](https://helix-editor.com/)
- [Containerlab](https://containerlab.dev/)
- [Go](https://go.dev/)
- [Github CLI](https://cli.github.com/)
- [fd](https://github.com/sharkdp/fd)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fzf](https://github.com/junegunn/fzf)
- [ipcalc](https://jodies.de/ipcalc)
- [Lazygit](https://github.com/jesseduffield/lazygit)
- [Pre-commit](https://pre-commit.com/)
- [Yazi](https://yazi-rs.github.io/)
- [Zellij](https://zellij.dev/)
- [Poetry](https://python-poetry.org/)
- [ruff](https://docs.astral.sh/ruff/)
- [Node](https://nodejs.org/) via [nvm](https://github.com/nvm-sh/nvm)
- [yamllint](https://github.com/adrienverge/yamllint)
- [yaml-language-server](https://github.com/redhat-developer/yaml-language-server)
- [ansible-language-server](https://github.com/ansible/vscode-ansible/blob/main/docs/als/README.md)
- [prettier](https://prettier.io/)

## TODO

- ~Implement dotfiles management~
- Add gopls, dlv, pyright, etc. and make it work with Helix
