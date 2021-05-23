# my little aliases
alias ls='ls -F --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias vim='nvim'
alias ren='/home/kelly/github/ren/ren'
alias vim='nvim'

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
