function sudo
    if test "$argv" = !!
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

function ..
    cd ..
end

function fish_user_key_bindings
    bind \ck 'fg %'
end

function vim_tmux
  if type tmux > /dev/null
    #if not inside a tmux session, and if no session is started, start a new session
    if test -z "$TMUX" ; and test -z $TERMINAL_CONTEXT
    tmux -2 attach; or tmux -2 new-session
    end
  end
end

alias vit='vim_tmux'
alias ll='ls -lh'
alias l='ll -a'
alias vi='/Applications/MacVim.app/Contents/MacOS/Vim'
alias rn='react-native'
alias rna='react-native run-android'
alias rni='react-native run-ios'
alias nn='nnn'

#export PATH=$HOME/bin:$PATH
#export ANDROID_HOME=~/Library/Android/sdk/
#export PATH=$ANDROID_HOME/platform-tools:$PATH
#export PATH=$ANDROID_HOME/tools:$PATH
#export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

set -gx ANDROID_HOME ~/Library/Android/sdk/
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH $ANDROID_HOME/tools $PATH
set -gx JAVA_HOME (/usr/libexec/java_home -v1.8)
#set -gx JAVA_HOME /usr/libexec/java_home


