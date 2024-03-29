# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node
### End of Zinit's installer chunk

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma/fast-syntax-highlighting
zinit light changyuheng/zsh-interactive-cd
zinit light willghatch/zsh-cdr

# Load OMZ Git library
zinit snippet OMZL::git.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::theme-and-appearance.zsh
zinit snippet OMZP::git
zinit snippet OMZP::vi-mode

zinit snippet OMZL::functions.zsh

zinit ice as"completion"
zinit snippet OMZP::docker/_docker
zinit snippet OMZP::docker-compose

zinit ice as"completion"
zinit snippet "https://raw.githubusercontent.com/exercism/cli/master/shell/exercism_completion.zsh"

zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS

zinit light romkatv/powerlevel10k

export forgit_checkout_commit=forgitgco

zinit load 'wfxr/forgit'
zinit load 'asdf-vm/asdf'

zplugin ice wait"!0" atinit"zpcompinit; zpcdreplay"

autoload -Uz compinit
compinit
zinit cdreplay -q # <- execute compdefs provided by rest of plugins

path=($HOME/go/bin $path[@])
path=($HOME/bin $path[@])
path=($HOME/.fzf/bin $path[@])
path=($HOME/dotfiles/lsp/node_modules/.bin $path[@])
path=($HOME/dotfiles/lsp/bin $path[@])

export EDITOR="nvim"
export VISUAL="nvim"
export CLICOLOR=1
export TERM="xterm-256color"
export LESS='-XRMsIg'
export LANG=C
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"

setopt EXTENDED_HISTORY
setopt HIST_BEEP
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.

alias vi='nvim'
alias vimdiff='nvim -d'
alias open='open_command'
alias df='df -h'
alias dus='du -hs'
alias dk='docker-compose'
alias dku='docker-compose up -d'
alias dkd='docker-compose down -v'
alias lzd='lazydocker'
alias code='open -a /Applications/Visual\ Studio\ Code.app'
alias pip='pip3'
alias ll='ls -l'
alias l='ll -a'
alias cat='bat'

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


# ===================================== git ====================================
# Ref: https://github.com/petitviolet/dotfiles/blob/99e67dafebfdd073952126dd9e159778fcbf3b12/_zshrc.alias#L346
# select branch
function select_from_git_branch() {
  # local list=$(git branch --sort=refname --sort=-authordate --color --all  --format='%(color:red)%(authordate:short)%(color:reset) %(objectname:short) %(align:width=45,position=left)%(color:green)%(refname:short)%(color:reset)%(end) <%(align:20,left)%(authorname)%(end)>[%(subject)] %(if)%(HEAD)%(then)* %(else)%(end)'; \
  local list=$(\
    git branch --sort=refname --sort=-committerdate --color \
      --format='%(color:red)%(authordate:short)%(color:reset) %(objectname:short) %(color:green)%(refname:short)%(color:reset) %(if)%(HEAD)%(then)* %(else)%(end)'; \
    git tag --color -l \
      --format='%(color:red)%(creatordate:short)%(color:reset) %(objectname:short) %(color:yellow)%(align:width=45,position=left)%(refname:short)%(color:reset)%(end)')

  echo $list | fzf --ansi --preview-window=down:wrap --preview 'f() {
      set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}");
      [ $# -eq 0 ] || git --no-pager log --oneline -100 --pretty=format:"%C(red)%ad%Creset %C(green)%h%Creset %C(blue)%<(15,trunc)%an%Creset: %s" --date=short --color $1;
    }; f {}' |\
    sed -e 's/\* //g' | \
    awk '{print $3}'  | \
    sed -e "s;remotes/;;g" | \
    perl -pe 's/\n/ /g'
}

# select branch to checkout
function select_git_checkout() {
    local SELECTED_FILE_TO_CHECKOUT=`select_from_git_branch | sed -e "s;origin/;;g"`
    if [ -n "$SELECTED_FILE_TO_CHECKOUT" ]; then
      BUFFER="git checkout $(echo "$SELECTED_FILE_TO_CHECKOUT" | tr '\n' ' ')"
      CURSOR=$#BUFFER
    fi
    zle accept-line
}
zle -N select_git_checkout
bindkey "^b" select_git_checkout


# ===================================== fzf ====================================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_COMPLETION_TRIGGER='..'
export FZF_COMPLETION_OPTS='+c -x'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#export FZF_DEFAULT_OPTS="--sort 20000"

export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
export FZF_PREVIEW_COMMAND="bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}"
export FZF_CTRL_T_OPTS="--min-height 30 --preview-window down:60% --preview-window noborder --preview '($FZF_PREVIEW_COMMAND) 2> /dev/null'"
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --header "Press CTRL-S to toggle sort" \
      --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                 xargs -I % sh -c 'git show --color=always % | head -$LINES'" \
      --bind "enter:execute:echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
              xargs -I % sh -c 'vim fugitive://\$(git rev-parse --show-toplevel)/.git//% < /dev/tty'"
}
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
compdef __tmux-sessions tm

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
#stty -ixon
bindkey '^s' pet-select

# ===================================== fancy-ctrl-z ==========================
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

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


#eval "$(asdf exec direnv hook zsh)"
#direnv() { asdf exec direnv "$@"; }
#eval "$(starship init zsh)"
#eval "$(luarocks path --bin)"

# Using GPG for SSH
if [[ "$(uname 2> /dev/null)" == "Darwin" ]]; then
    path=("/usr/local/opt/gnupg@2.2/bin" $path[@])
fi

#SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#export GPG_TTY=$(tty)
#export SSH_AUTH_SOCK
#gpgconf --launch gpg-agent

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
