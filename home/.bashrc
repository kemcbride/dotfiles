# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH="$PATH:/usr/local/lib/node_modules/jshint/bin/jshint" # add jshint to path for syntastic-vim
export PATH="$PATH:/home/kelly/android/platform-tools:/home/kelly/npm/bin"
export PATH="$PATH:/usr/local/texlive/2015/bin/x86_64-linux" # the "vanilla texlive install" site says so
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:$HOME/cool-stuff/libsodium/lib/" # Add libsodium path for zeromq

# Include this path on windows-WSL environment, for arduino-cli
UNAME_R=$(uname -r)
if [[ $UNAME_R =~ "Microsoft" ]]; then
	export PATH="$PATH:/mnt/c/Users/Kelly/bin"
fi

export EDITOR='vim'
export VISUAL='vim'
set -o vi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set CAPS LOCK to Escape/Ctrl (on linuxy hosts)
command -v setxkbmap && setxkbmap -option 'caps:ctrl_modifier'
command -v xcape && xcape -e 'Caps_Lock=Escape'

# append to the history file, don't overwrite it
shopt -s histappend 
# get history to sync up across terminals (tmux, screen)
export PROMPT_COMMAND="history -a; history -n"
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=130000
HISTFILESIZE=-1
# don't put duplicate lines or lines starting with space in the history.
# also, ignore my "talking to myself" bash comments...
# See bash(1) for more options
HISTCONTROL=ignoreboth
HISTIGNORE="# *"


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]'
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w'
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f /usr/share/scm/scm-prompt.sh ]; then
    source /usr/share/scm/scm-prompt.sh
    export PS1="$PS1\[\033[1;33m\]\$(_dotfiles_scm_info)\[\033[0m\]$ "
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_arduino ]; then
    . ~/.bash_arduino
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon
stty ixany
stty stop undef

export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/include/" # For compiling songhaus, mostly.

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export GOPATH="/$HOME/go"

if [ -f "$HOME/.homesick/repos/homeshick/homeshick.sh" ]; then
  source "$HOME/.homesick/repos/homeshick/homeshick.sh"
  homeshick --quiet refresh
  source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
fi
PATH=/Users/blitzle/.nvm/versions/node/v22.20.0/bin:/usr/local/bin:/usr/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Applications/iTerm.app/Contents/Resources/utilities:/usr/local/lib/node_modules/jshint/bin/jshint:/home/kelly/android/platform-tools:/home/kelly/npm/bin:/usr/local/texlive/2015/bin/x86_64-linux:/Users/blitzle/.rvm/bin:/Users/blitzle/cool-stuff/libsodium/lib/:/Users/blitzle/.local/bin
