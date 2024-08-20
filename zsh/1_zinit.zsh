# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# source "$HOME/.zinit/bin/zinit.zsh"
# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode depth"1" for \
      zdharma-continuum/zinit-annex-as-monitor \
      zdharma-continuum/zinit-annex-bin-gem-node \
      zdharma-continuum/zinit-annex-patch-dl \
      zdharma-continuum/zinit-annex-rust

#zinit ice lucid depth"1" blockf
#zinit light yuki-yano/zeno.zsh

### End of Zinit's installer chunk

zinit light romkatv/powerlevel10k

# Completion enhancements
zinit wait lucid depth"1" for \
      atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
      blockf \
      zsh-users/zsh-completions \
      atload"!_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions

# FZF: fuzzy finder
zinit ice wait lucid from"gh-r" nocompile src'key-bindings.zsh' sbin \
      dl'https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh -> _fzf_completion;
         https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh -> key-bindings.zsh;
         https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf-tmux.1 -> $ZPFX/share/man/man1/fzf-tmux.1;
         https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1 -> $ZPFX/share/man/man1/fzf.1'

zinit ice wait lucid depth"1" atload"zicompinit; zicdreplay" blockf
zinit light junegunn/fzf
zinit light Aloxaf/fzf-tab

# Snippets
zinit snippet OMZP::fancy-ctrl-z

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zstyle ':fzf-tab:*' switch-group ',' '.'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:complete:*:options' sort false
zstyle ':fzf-tab:complete:(cd|ls|exa|bat|cat|emacs|nano|v|vi|vim):*' fzf-preview 'exa -1 --color=always $realpath 2>/dev/null|| ls -1 --color=always $realpath'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
    fzf-preview 'echo ${(P)word}'


# Key bindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt EXTENDED_HISTORY
setopt HIST_BEEP
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
