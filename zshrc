source ~/.zplug/init.zsh

POWERLEVEL9K_MODE='nerdfont-fontconfig'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status nvm node_version)

POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="blue"
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

zplug "b4b4r07/zsh-vimode-visual", use:"*.zsh", defer:3
zplug "zsh-users/zsh-completions"
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

# Group dependencies
# Load "emoji-cli" if "jq" is installed in this example
zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq
zplug "b4b4r07/emoji-cli", \
    on:"stedolan/jq"
# Note: To specify the order in which packages should be loaded, use the defer
#       tag described in the next section

# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug 'b4b4r07/zsh-history', as:command, use:misc/fzf-wrapper.zsh, rename-to:ff
if zplug check 'b4b4r07/zsh-history'; then
    export ZSH_HISTORY_FILE="$HOME/.zsh_history.db"
    ZSH_HISTORY_KEYBIND_GET_BY_DIR="^r"
    ZSH_HISTORY_KEYBIND_GET_ALL="^r^a"
    ZSH_HISTORY_KEYBIND_SCREEN="^r^r"
    ZSH_HISTORY_KEYBIND_ARROW_UP="^p"
    ZSH_HISTORY_KEYBIND_ARROW_DOWN="^n"
fi
# Can manage local plugins
zplug "~/.zsh", from:local

# Load theme file
#zplug 'dracula/zsh', as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# Alias

alias ll='ls -lh -G'
alias l='ll -a'
alias ne='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
alias vi='/Applications/MacVim.app/Contents/MacOS/Vim'
alias derived='rm -rf ~/Library/Developer/Xcode/DerivedData/*'
alias rn='react-native'
alias rna='react-native run-android'
alias rni='react-native run-ios'
alias nn='nnn'

# Export environment
export PATH=$HOME/bin:$PATH
export ANDROID_HOME=~/Library/Android/sdk/
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
#export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export JAVA_HOME=$(/usr/libexec/java_home)

# nnn
#export NNN_USE_EDITOR=1
#export NNN_DE_FILE_MANAGER=Finder

# Start vim with tmux
function vim_tmux() { tmux new -d "/Applications/MacVim.app/Contents/MacOS/Vim $*" \; attach; }
alias vit='vim_tmux'

# Ctrl-Z instead of fg
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="%"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fshow () {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --header "Press CTRL-S to toggle sort" \
      --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                 xargs -I % sh -c 'git show --color=always % | head -$LINES'" \
      --bind "enter:execute:echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
              xargs -I % sh -c 'vim fugitive://\$(git rev-parse --show-toplevel)/.git//% < /dev/tty'"
}
