export CLICOLOR=1
export EDITOR='vim'
export LESS='-R'
export LSCOLORS='dxcxcxdxgxegedabagacad'
export PATH=~/bin:/usr/local/mysql/bin:/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH
export PROMPT_COMMAND='history -a'
export PYTHONSTARTUP="/Users/$USER/.pythonrc"

# bash 4.0 options
shopt -s autocd globstar dirspell 

# Turn off the bell
set bell-style none

###############################
#          HISTORY            #
###############################

# Append rather than overwrite history on exit
shopt -s histappend

# Keep multi-line commands in history
shopt -q -s cmdhist

# up/down searches history, doesn't just cycle
bind '"[A":history-search-backward'
bind '"[B":history-search-forward'

# Ignore common commands and tab/space lines when going through history
export HISTIGNORE="&:[ 	]*:ls:[bf]g:history*:clear:exit"

# Keep a A LOT of history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000

###############################
#     COMPLETION/GLOBBING     #
###############################

# Turn on the extended pattern matching features 
shopt -q -s extglob

# Tab to show completion possibilities, case-insensitive
bind 'set show-all-if-ambiguous on'
bind "set completion-ignore-case on"

# character denoting file's type is appended to filename when listing possible completions
bind 'set visible-stats on'

# Auto-expand ! stuff (!!, e.g.) when you hit space
bind 'Space:magic-space'

###############################
#           ALIASES           #
###############################
alias ez="easy_install"
alias gvim="open -a MacVim.app"
alias g="gvim"
alias ls='ls -lh'
alias diff='diff -u'
alias python="ipython"
alias depyc='rm -f **/*.pyc'

# git shortcuts
alias go="git co"
alias gc="git ci -m"
alias ga="git add"

# Imports of other files
if [ -f ~/.zenossrc ]; then
    . ~/.zenossrc
fi
if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi

VIRTUAL_ENV_DISABLE_PROMPT=1
if [ -f ~/bin/activate ]; then
    . ~/bin/activate
fi


# Push SSH public key to a remote box for key access
# usage: setupssh $USER@mybox
setupssh () {
    USER=${1%@*}
    BOX=${1#*@}
    if [ "$USER" = "$1" ]; then
        USER=`whoami`
    else
        # Set up user
        echo "
Host $BOX
   User $USER" >> $HOME/.ssh/config
    fi
    # Install the key
    cat ~/.ssh/id_dsa.pub | ssh $USER@$BOX "mkdir -p ~/.ssh && cat - >> ~/.ssh/authorized_keys"
}

# Create a branch in svn and an accompanying local git branch, then switch to
# that branch
svnbranch () {
    git svn branch $1
    git co svn/$1
    git checkout -b $1
}

alias cdpu="cd ~/src/zenoss/preupgrade-zenpack/ZenPacks.zenoss.PreUpgrade30/ZenPacks/zenoss/PreUpgrade30 && ls"
