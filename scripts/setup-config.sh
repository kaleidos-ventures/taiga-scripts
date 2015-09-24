#!/bin/bash

cat > ~/.vimrc <<EOF
set nocompatible

set bs=2
set ts=4
set tw=1000000000

set expandtab
set tabstop=8
set softtabstop=4
set shiftwidth=4
filetype indent off
filetype plugin on

syntax on

set autoindent
set showmatch
set showmode
set mousehide

set nowrapscan
set hlsearch
set incsearch

set fileencoding=utf8
set encoding=utf8
EOF

cat > ~/.tmux-conf.sh <<EOF
function taiga-runserver {
    session=taiga
    state=\$(tmux ls 2>/dev/null)
    if \$(echo $state | grep -q "\$session"); then
        if \$(echo \$state | grep -qv "(attached)"); then
            tmux attach -t $session
        fi
        tmux select-window -t servers
    else
        tmux new-session -ds \$session -n servers
        tmux send-keys -t \$session 'taiga-runserver-back' C-m
        tmux attach -t \$session
    fi
}

function taiga-runserver-back {
    circusctl stop taiga
    workon taiga
    cd ~/taiga-back
    python manage.py runserver 127.0.0.1:8001
}
EOF

cat > ~/.bash_profile <<EOF
[[ -s "\$HOME/.profile" ]] && source "\$HOME/.profile" # Load the default .profile
[[ -s "\$HOME/.ruby-conf.sh" ]] && source "\$HOME/.ruby-conf.sh"
[[ -s "\$HOME/.tmux-conf.sh" ]] && source "\$HOME/.tmux-conf.sh"
EOF
