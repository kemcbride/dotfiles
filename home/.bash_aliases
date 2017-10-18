# my little aliases
alias ls='ls -F --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ren='/home/kelly/github/ren/ren'

alias cp='rsync -ah --progress'
alias open='gnome-open'

alias be='bundle exec'
alias bi='bundle install'
alias beg='bundle exec guard --no-notify'
# i just dont like being told every time it updates. i believe you, guard.

# for in a python virtualenv
alias vtree="tree -I 'bin*|local*|lib*|include*'"

alias uw-vpn="sudo openconnect cn-vpn.uwaterloo.ca" # - NOTE requires manual username/password

alias shaws="aws --endpoint-url http://localhost:9000"

# Reset xkbmap so you can re-jiggle your keyboard+esc/caps
alias uncap="setxkbmap -option "

# a cute lil guy
hgrep() {
  history | grep $1 | cut -d \  -f3-
  history -s "hgrep $@"
}

alias a='fasd -a'
alias s='fasd -si'
alias sd='fasd -sid'
alias sf='fasd -sif'
alias d='fasd -d'
alias f='fasd -f'
# function to execute built-in cd
fasd_cd() {
  if [ $# -le 1 ]; then
    fasd "$@"
  else
    local _fasd_ret="$(fasd -e 'printf %s' "$@")"
    [ -z "$_fasd_ret" ] && return
    [ -d "$_fasd_ret" ] && cd "$_fasd_ret" || printf %s\n "$_fasd_ret"
  fi
}
alias z='fasd_cd -d'
alias zz='fasd_cd -d -i'

fasd_ls() {
  if [ $# -le 1 ]; then
    fasd "$@"
  else
    local _fasd_ret="$(fasd -e 'printf %s' "$@")"
    echo $_fasd_ret
    [ -z "$_fasd_ret" ] && return
    [ -d "$_fasd_ret" ] && ls "$_fasd_ret" || printf %s\n "$_fasd_ret"
  fi
}

alias fl='fasd_ls -d '
