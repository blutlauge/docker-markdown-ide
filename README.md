# Docker container including a markdown IDE

This IDE is intended for use on a NAS system. It provides

- pandoc.
- TeX Live.
- vim with appropriate plugins including but not limited to vim-markdown, vim-latex and YouCompleteMe.
- Zsh with the oh-my-zsh framwork.
- tmux.
- An SSH server and a MOSH server to be able to use this container from an iPad using the Blink shell.
- My dotfiles which ca be found at [GitHub](https://github.com/marcschlienger/dotfiles.git).
- And other mandatory stuff.

## Run
docker run -d -p 22:22 -p 60001:60001/udp --name md-ide  -v <source>:<target> marcps/markdown-ide:latest

## Connect

 - Using mosh: mosh <doc@server>; Password: screencast
 - Using ssh: ssh <doc@server>; Password: screencast
