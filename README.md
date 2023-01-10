# Neovim Config

This is my personal neovim config,Based on [AstroNvim](https://github.com/AstroNvim/AstroNvim).

## Installation

backup:

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

or

```shell
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
```

clone repo:

```shell
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
git clone https://github.com/fzdwx/user ~/.config/nvim/lua/user
nvim +PackerSync
```

# :package: Basic Setup

## Update

```shell
:AstroUpdate
```

## Install LSP

```shell
:LspInstall xxx
```

## Install language parser

```shell
:TSInstall xxx
```

## Install Debugger

```shell
:DapInstall xxx
```