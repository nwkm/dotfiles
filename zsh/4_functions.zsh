# ===================================== cdr ====================================
# Ref: https://petitviolet.hatenablog.com/entry/20190708/1562544000
function select_cdr(){
    local selected_dir=$(cdr -l | awk '{ print $2 }' | \
      fzf --preview 'f() { sh -c "ls --color -hFGl $1 2>/dev/null || gls --color -hFGl $1" }; f {}')
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N select_cdr
bindkey '^o' select_cdr

# ===================================== tmux ============================
function tn() (
    if [ -n "$1" ]
      then
         tmux switch -t $1
      else
         echo "no session name"
     fi
  )

function tm() {
    [[ -z "$1" ]] && { echo "usage: tm <session>" >&2; return 1; }
    tmux has -t $1 && tmux attach -t $1 || tmux new -s $1
}

function __tmux-sessions() {
    local expl
    local -a sessions
    sessions=( ${${(f)"$(command tmux list-sessions)"}/:[ $'\t']##/:} )
    _describe -t sessions 'sessions' sessions "$@"
}
#compdef __tmux-sessions tm

# ===================================== pet ====================================
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
  BUFFER=" $(pet search --query "$LBUFFER")"
  CURSOR=$#BUFFER
  zle redisplay
}

zle -N pet-select
#stty -ixon # allow Ctrl-S to work in terminal
#bindkey '^s' pet-select

# ===================================== ghq ====================================
# https://github.com/Songmu/ghq-handbook/blob/master/ja/05-ghq-list.md#%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE%E4%B8%80%E8%A6%A7%E3%83%91%E3%82%B9%E5%8F%96%E5%BE%97%E3%82%92%E3%81%8A%E3%81%93%E3%81%AA%E3%81%86ghq-list
fzf-src () {
    local repo=$(ghq list | fzf --query "$LBUFFER")
    if [ -n "$repo" ]; then
        repo=$(ghq list --full-path --exact $repo)
        BUFFER="cd ${repo}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-src
bindkey '^]' fzf-src

# ch - browse chrome history
ch() {
  local cols sep
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  # cp -f ~/Library/Application\ Support/Google/Chrome/Profile\ 8/History /tmp/h
  cat -- ~/Library/Application\ Support/Google/Chrome/Profile*/History > /tmp/h

  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs open
}

# nvim config switcher
nvims() {
  items=("default" "kickstart" "MiniNvim" "NvChad")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}
