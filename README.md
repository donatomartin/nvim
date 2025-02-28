# Donato Martín's Current NVim Configuration

     ██████   █████              ███                 
    ░░██████ ░░███              ░░░                  
     ░███░███ ░███  █████ █████ ████  █████████████  
     ░███░░███░███ ░░███ ░░███ ░░███ ░░███░░███░░███ 
     ░███ ░░██████  ░███  ░███  ░███  ░███ ░███ ░███ 
     ░███  ░░█████  ░░███ ███   ░███  ░███ ░███ ░███ 
     █████  ░░█████  ░░█████    █████ █████░███ █████
    ░░░░░    ░░░░░    ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░ 

                     by Donato A. Martín

## How to Install

1. Clone this repository into your nvim configuration directory.

Windows Powershell

```shell
git clone https://github.com/dononitram/nvim.git %USERPROFILE%\AppData\Local\nvim
```

Linux Zsh

```sh
git clone https://github.com/dononitram/nvim.git ~/.config/nvim
```

2. Enjoy!


Disclaimer: Some dependencies be needed. They will be prompted as errors to the user if not installed.

Dependencies known:

- ripgrep - used to live grep through files
- unzip - used to unzip nvim-java language server providers
- npm - used to run pyright lsp
- go - used for gopls lsp

Also a Nerd Font is recomended for the web icons.

I personally use [JetBrains Mono](https://www.jetbrains.com/lp/mono/#how-to-install).
