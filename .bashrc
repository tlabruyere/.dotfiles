# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Handy Aliases
alias grep='grep --colour=auto'
#alias ls='ls --color=auto'
alias vi='vim -O'
alias ssh='ssh -X'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias egrep='egrep --color=auto'

# check this xterm alias
alias xterm='xterm -ls -sl 1000 -title `hostname`'


# Make new files/directories group-writable by default
#umask 002

# use vi mode
set -o vi

# Remember the last 5000 commands and merge
# and don't wait for the session to conclude to save history
# save at the end of execution
export HISTFILESIZE=5000

# no core files
ulimit -c 0

# turn off auto logout
export TMOUT=0

# set up proxies
#export http_proxy="wwwproxy.sandia.gov:80"
#export https_proxy="wwwproxy.sandia.gov:80"
#export ftp_proxy="wwwproxy.sandia.gov:80"

export EDITOR=vim
export CVSEDITOR=$EDITOR
export VISUAL=$EDITOR
export TERM=xterm

function parse_git_branch {
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"

#export PS1="$RED\$\[\e]0;\u@\h: \w\a\] \u@\h:\w $YELLOW \$(parse_git_branch)$GREEN\$ "
#export PS1="\[\e]0;\u@\h:\w\a\]\u@\h:\w \e[$GREEN\$(parse_git_branch)\e[m \$ "
export PS1="\[\e]0;\u@\h:\w\a\]\u@\h:\w $GREEN\$(parse_git_branch)\e[m \$ "

#export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "

# SETUP GIT DIFF TO USE BEYOND COMPARE
#git config --global diff.tool bc3
#git config --global difftool.bc3 trustExitCode true
#
#git config --global merge.tool bc3
#git config --global mergetool.bc3 trustExitCode true

#function bdme{
#    if
#}
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
#alias ctags="`brew --prefix`/bin/ctags"
