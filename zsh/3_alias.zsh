
alias df='df -h'
alias dus='du -hs'
alias dk='docker-compose'
alias dku='docker-compose up -d'
alias dkd='docker-compose down -v'
alias lzd='lazydocker'
alias code='open -a /Applications/Visual\ Studio\ Code.app'
alias pip='pip3'
alias ll='ls -l --color=auto'
alias l='ll -a'
alias cat='bat'
alias we='curl wttr.in/Choisy-le-Roi'  #current, narrow, quiet, no Follow
alias we1='curl wttr.in/Choisy-le-Roi\?1nqF' #+1day, narrow, quiet, no Follow
alias we2='curl wttr.in/Choisy-le-Roi\?2nqF' #+2days, same as above
alias v='nvim'
alias pn='pnpm'
alias t='tmux'

# Kubectl
alias k='kubectl'
alias klo='kubectl logs -f'
alias kg='kubectl get'

# PM2
alias p='pm2'
alias pm='pm2 monit'

# Git aliases
alias lg='lazygit'
alias gl='git lg2'
alias gbr='git branch'
alias gcl='git clone'
alias ga='git add'
alias gc='git commit'
alias gcf='git fcommit'
alias gco='git checkout'
alias gs='git status'
alias gf='git fetch'
alias gw='git worktree'
alias git-remove-untracked='git fetch --prune && git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -d'

alias ydl="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"


alias nvim-mini="NVIM_APPNAME=MiniNvim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
