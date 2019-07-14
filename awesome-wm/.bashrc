#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
#[[ -z "$TMUX" ]] && exec tmux

# TMUX
#if which tmux > /dev/null 2>&1; then
    # if no session is started, start a new session
 #   test -z ${TMUX} && tmux

    # when quitting tmux, try to attach
  #  while test -z ${TMUX}; do
#	tmux attach || break
 #   done
#fi

export EDITOR="emacs"
export TERM="rxvt-unicode-256color"


alias ls='ls --color=auto'
alias ll='ls -la'
alias ne='emacs -nw'
alias chro='chromium'

PS1='\[\e[01;34m\][ \[\e[01;32m\]\w \[\e[01;34m\]]\[\e[01;32m\]$\[\e[01;37m\] '
archey3
