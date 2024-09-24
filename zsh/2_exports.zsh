path=($HOME/.fzf/bin $path[@])

export EDITOR="nvim"
export VISUAL="nvim"
export CLICOLOR=1
export TERM="xterm-256color"
export LESS='-XRMsIg'
export LANG=C
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"
export PATH="/usr/local/bin:${PATH}"
export PATH="$PATH:${HOME}/code/flutter/bin"

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export TMUXP_CONFIGDIR=$HOME/.config/tmuxp


# Homebrew for linux
if [[ $(uname) != "Darwin" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# The next line updates PATH for the Google Cloud SDK.
# if [ -f "$HOME/soft/google-cloud-sdk/path.zsh.inc" ]; then . '$HOME/soft/google-cloud-sdk/path.zsh.inc'; fi
if [ -f "$HOME/soft/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/soft/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/soft/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/soft/google-cloud-sdk/completion.zsh.inc"; fi

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

# jenv
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="/usr/local/opt/postgresql@16/bin:$PATH"

unalias zi
eval "$(zoxide init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

export HOMEBREW_NO_AUTO_UPDATE=1

