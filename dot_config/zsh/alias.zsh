alias newlinestring='sed -e '\'':a'\'' -e '\''N'\'' -e '\''$!ba'\'' -e '\''s/\n/\\n/g'\'
alias newlinecomma='sed -e '\'':a'\'' -e '\''N'\'' -e '\''$!ba'\'' -e '\''s/\n/,/g'\'
alias newlinespace='sed -e '\'':a'\'' -e '\''N'\'' -e '\''$!ba'\'' -e '\''s/\n/\ /g'\'

alias ls='/bin/ls -F --color=auto'
alias lc='/bin/ls -F --color'
alias grep='/usr/bin/grep --color=auto'
alias egrep='/usr/bin/egrep --color=auto'
alias tree='tree -C'
alias s='source ~/bin/sshfzf.sh'
alias f='source ~/bin/fzfcd.sh'
alias k='~/bin/kitchenfzf.sh'
alias v="$EDITOR"
