# ===================================== git ====================================
# Ref: https://github.com/petitviolet/dotfiles/blob/99e67dafebfdd073952126dd9e159778fcbf3b12/_zshrc.alias#L346
# select branch
# function select_from_git_branch() {
#   local list=$(\
#     git branch --sort=refname --sort=-committerdate --color \
#       --format='%(color:red)%(authordate:short)%(color:reset) %(objectname:short) %(color:green)%(refname:short)%(color:reset) %(if)%(HEAD)%(then)* %(else)%(end)'; \
#     git tag --color -l \
#       --format='%(color:red)%(creatordate:short)%(color:reset) %(objectname:short) %(color:yellow)%(align:width=45,position=left)%(refname:short)%(color:reset)%(end)')
#
#   echo $list | fzf --ansi --preview-window=down:wrap --preview 'f() {
#       set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}");
#       [ $# -eq 0 ] || git --no-pager log --oneline -100 --pretty=format:"%C(red)%ad%Creset %C(green)%h%Creset %C(blue)%<(15,trunc)%an%Creset: %s" --date=short --color $1;
#     }; f {}' |\
#     sed -e 's/\* //g' | \
#     awk '{print $3}'  | \
#     sed -e "s;remotes/;;g" | \
#     perl -pe 's/\n/ /g'
# }
#
# # select branch to checkout
# function select_git_checkout() {
#     local SELECTED_FILE_TO_CHECKOUT=`select_from_git_branch | sed -e "s;origin/;;g"`
#     if [ -n "$SELECTED_FILE_TO_CHECKOUT" ]; then
#       BUFFER="git checkout $(echo "$SELECTED_FILE_TO_CHECKOUT" | tr '\n' ' ')"
#       CURSOR=$#BUFFER
#     fi
#     zle accept-line
# }
# zle -N select_git_checkout
# bindkey "^b" select_git_checkout

# is_in_git_repo() {
#     git rev-parse HEAD > /dev/null 2>&1
# }
#
# _gf() {
#     is_in_git_repo || return
#     git -c color.status=always status --short |
#         fzf-down -m --ansi --nth 2..,.. \
#                  --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
#         cut -c4- | sed 's/.* -> //'
# }
#
# _gb() {
#     is_in_git_repo || return
#     git branch -a --color=always | grep -v '/HEAD\s' | sort |
#         fzf-down --ansi --multi --tac --preview-window right:70% \
#                  --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
#         sed 's/^..//' | cut -d' ' -f1 |
#         sed 's#^remotes/##'
# }
#
# _gt() {
#     is_in_git_repo || return
#     git tag --sort -version:refname |
#         fzf-down --multi --preview-window right:70% \
#                  --preview 'git show --color=always {}'
# }
#
# _gh() {
#     is_in_git_repo || return
#     git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
#         fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
#                  --header 'Press CTRL-S to toggle sort' \
#                  --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
#         grep -o "[a-f0-9]\{7,\}"
# }
#
# _gr() {
#     is_in_git_repo || return
#     git remote -v | awk '{print $1 "\t" $2}' | uniq |
#         fzf-down --tac \
#                  --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1}' |
#         cut -d$'\t' -f1
# }
#
# _gs() {
#     is_in_git_repo || return
#     git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
#         cut -d: -f1
# }
#
# join-lines() {
#     local item
#     while read item; do
#         echo -n "${(q)item} "
#     done
# }

# () {
#     local c
#     for c in $@; do
#         eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
#         eval "zle -N fzf-g$c-widget"
#         eval "bindkey '^g^$c' fzf-g$c-widget"
#     done
# } f b t r h s
