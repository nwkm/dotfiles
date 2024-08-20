# ===================================== fzf ====================================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_COMPLETION_TRIGGER='**'
#export FZF_COMPLETION_OPTS='+c -x'
#export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{node_modules/*,.git/*}"'
#export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
#export FZF_PREVIEW_COMMAND="bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}"
#export FZF_CTRL_T_OPTS="--min-height 30 --preview-window down:60% --preview-window noborder --preview '($FZF_PREVIEW_COMMAND) 2> /dev/null'"
#export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git || git ls-tree -r --name-only HEAD || rg --files --hidden --follow --glob '!{node_modules,.git}' || find ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height 40% --ansi --prompt '∷ ' --pointer ▶ --marker ⇒"
export FZF_CTRL_T_OPTS="--preview '(bat --style=numbers --color=always {} || cat {} || tree -NC {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --exact"
export FZF_ALT_C_OPTS="--preview 'tree -NC {} | head -200'"

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


fzf-down() {
    fzf --height 50% --min-height 20 --border --bind ctrl-/:toggle-preview "$@"
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

rfzf() {
  RG_PREFIX="rga --files-with-matches"
  local file
  file="$(
    FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
      fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
        --phony -q "$1" \
        --bind "change:reload:$RG_PREFIX {q}" \
        --preview-window="70%:wrap"
  )" &&
  echo "opening $file" &&
  xdg-open "$file"
}

fzv() {
  local results=$(fzf --preview 'bat --color=always {}')
  [ -z $results ] && return
  echo "$results"
  nvim "$results"
}

__fzf-git-worktree() {
  local current
  current=$(git rev-parse --abbrev-ref HEAD)
  if [[ -z "$current" ]]; then
    >&2 echo "You must be in a git repo to get worktrees."
    return 1
  fi

  local out
  out=$(fzf \
    +m \
    --cycle \
    --exit-0 \
    --expect=ctrl-y \
    --height=25% --no-hscroll --no-mouse --no-multi \
    --prompt="${current}> " <<<"$(git worktree list)")

  local worktree
  worktree=$(head -2 <<<"$out" | tail -1)
  worktree=$(cut -f 1 -d " " <<<"$worktree")
  [[ -z "$worktree" ]] && return 1

  local key
  key=$(head -1 <<<"$out")

  if [[ "$key" == "ctrl-y" ]]; then
    printf '%s' "$worktree" | pbcopy
    printf '"%s" copied into clipboard\n' "$worktree"
    return
  fi

  # remember, can't cd inside a script!
  printf '%s\n' "$worktree"
}
zle -N __fzf-git-worktree
bindkey '^[w' __fzf-git-worktree

source "$HOME/.config/zsh/fzf-git.sh"
