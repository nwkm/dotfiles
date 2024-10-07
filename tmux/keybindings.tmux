
# allow some keys to work in vim
# ref: https://superuser.com/questions/401926/how-to-get-shiftarrows-and-ctrlarrows-working-in-vim-in-tmux
#set-window-option -g xterm-keys on

# vi mode
set -g status-keys vi
setw -g mode-keys vi
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send -X copy-selection-and-cancel
bind -T copy-mode-vi Escape send -X cancel
bind -T copy-mode-vi d send -X halfpage-down
bind -T copy-mode-vi u send -X halfpage-up

# maps
unbind C-_
unbind C-b
set-option -g prefix C-a
bind C-a send-prefix
bind S set-window-option synchronize-panes
bind Space copy-mode

# make navigation between tmux and vim panes seamlessly
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

bind -n C-h if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
bind -n C-j if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
bind -n C-k if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
bind -n C-l if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'
# allow C-/ work for commenting
bind -n 'C-_' if-shell "$is_vim" "send-keys 'C-/'" "select-pane -l"

bind -T copy-mode-vi 'C-h' select-pane -L
bind -T copy-mode-vi 'C-j' select-pane -D
bind -T copy-mode-vi 'C-k' select-pane -U
bind -T copy-mode-vi 'C-l' select-pane -R

bind [ swap-window -d -t -1
bind ] swap-window -d -t +1
bind i select-pane -l

bind t split-window -v -p 30 -c "#{pane_current_path}"
bind s split-window -c "#{pane_current_path}"
bind v split-window -h -c "#{pane_current_path}"
bind c new-window -a -c "#{pane_current_path}"
bind - display-popup -d "#{pane_current_path}"

# menu to switch sessions.
bind T choose-tree

# secondary binding for C-l to retain redraw
bind C-l send-keys 'C-l'

# reload tmux.conf with prefix-t
bind C-t source-file ~/.tmux.conf \; display "Reloaded ~/.tmux.conf"

# navigate windows
bind -n M-n next-window
bind -n M-p previous-window

# navigate sessions
bind n switch-client -n
bind p switch-client -p

# bind resizing of panes to arrows (resizes by steps of 5 lines/columns)
bind Left resize-pane -L 5
bind Right resize-pane -R 5
bind Down resize-pane -D 5
bind Up resize-pane -U 5

# popup
bind -n M-b popup -d '#{pane_current_path}' -E -h 100% -w 100% -x 100% 'btop'                       #  btop process manager
bind -n M-x popup -d '#{pane_current_path}' -E -h 100% -w 100% -x 100% "tmux kill-session -a"       # kill other tmux sessions
bind -n M-K popup -d '#{pane_current_path}' -E -h 100% -w 100% -x 100% "ps aux | fzf --height 100% --layout=reverse --prompt='Select process to kill: ' | awk '{print $2}' | xargs -r sudo kill"    # pkill process

# quick window
bind q new-window -n "sql client" -c "#{pane_current_path}" "lazysql"                     # lazysql client        : https://github.com/jorgerojas26/lazysql
bind u new-window -n "rest client" -c "#{pane_current_path}" "atac -d ./atac"             # atac rest client      : yay -S atac https://github.com/Julien-cpsn/ATAC
bind t new-window -n "process manager" -c "#{pane_current_path}" "btop"                   # btop process man      : yay -S btop
bind s new-window -n "search n replace" -c "#{pane_current_path}" "serpl"                 # search and replace    : https://github.com/yassinebridi/serpl/releases
# bind d new-window -n "docker" -c "#{pane_current_path}" "lazydocker"                      # lazy docker ui        : yay -S lazydocker
# bind g new-window -n "git" -c "#{pane_current_path}" "lazygit"                            # lazy git ui           : yay -S lazygit
# bind c new-window -n "dotfiles" -c "#{pane_current_path}" "lazygit -p $mydotfiles"        # lazygit dotfiles      : lazygit in dotfiles dir
# bind f new-window -n "yazi" -c "#{pane_current_path}" "yazi"                              # yazi term filemanager : https://github.com/mkchoi212/fac

# Menu
bind m display-menu -x R -y P \
    "New Session"                        S "command-prompt -p \"New Session:\" \"new-session -A -s '%%'\"" \
    "Kill Session"                       x "kill-session" \
    "Kill Other Session(s)"              X "kill-session -a" \
    "" \
    "New Window"                         ␍ new-window \
    "Kill Window"                        k "killw"  \
    "Choose Window"                      w choose-window \
    "Previous Window"                    🡠 previous-window \
    "Next Window"                        🡢 next-window \
    "Swap Window Right"                  ↑ "swap-window -t -1" \
    "Swap Window Left"                   ↓ "swap-window -t +1" \
    "Horizontal Split"                   v "split-window -h" \
    "Vertical Split"                     s "split-window -v"  \
    "" \
    "Layout Horizontal"                  h "select-layout even-horizontal"  \
    "Layout Vertical"                    k "select-layout even-horizontal"  \
    "" \
    "Swap Pane Up"                       < "swap-pane -U" \
    "Swap Pane Down"                     > "swap-pane -D" \
    "Break Pane"                         t break-pane \
    "Join Pane"                          j "choose-window 'join-pane -h -s \"%%\"'" \
    "#{?window_zoomed_flag,Unzoom,Zoom}" z "resize-pane -Z"
