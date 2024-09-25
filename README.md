To install run

```sh
git clone git@github.com:jimzenn/tmux-config.git $XDG_CONFIG_HOME/tmux
tic -x "${XDG_CONFIG_HOME}/tmux/tmux-256color.terminfo"
mv ~/.tmux.conf ~/.tmux.conf.bak
ln -s "${XDG_CONFIG_HOME}/tmux/tmux.conf" "${HOME}/.tmux.conf"
```
