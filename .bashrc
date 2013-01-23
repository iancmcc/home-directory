export CLICOLOR=1
export EDITOR='mvim -v'
export LESS='-R'
export LSCOLORS='dxcxcxdxgxegedabagacad'
export PATH=/usr/local/mysql/bin:/usr/local/bin:/usr/local/sbin:/usr/local/texlive/2012/bin/universal-darwin:$PATH
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


shopt -s cdable_vars
#if shopt -q cdable_vars; then
#    complete -v -F _cd $nospace $filenames cd
#else
#    complete -F _cd $nospace $filenames cd
#fi

###############################
#           ALIASES           #
###############################
alias ez="easy_install"
alias gvim="open -a MacVim.app"
alias g="gvim"
alias ls='ls -lh'
alias diff='diff -u'
alias depyc='rm -f **/*.pyc'
alias vim="mvim -v"

# git shortcuts
alias go="git co"
alias ga="git add"

function gc() {
    git ci -m $@
    git svn dcommit
}

#VIRTUAL_ENV_DISABLE_PROMPT=1
if [ -f ~/bin/activate ]; then
    . ~/bin/activate
fi

# Imports of other files
if [ -f ~/.zenossrc ]; then
    . ~/.zenossrc
fi
if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
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


export M2_HOME=/usr/share/maven

rebuild-dsa () {
    cd ~/src/zenoss/DSA && mvn clean package -DskipTests && rm -rf ~/tmp2 && mkdir -p ~/tmp2 && mv target/zenoss-dsa*.tar.gz ~/tmp2 && cd ~/tmp2 && tar xzf * && cd zenoss-dsa-1.0-SNAPSHOT && rm -rf var/db && bin/zenoss-dsa run
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.


export NOVA_CERT=/Users/ian/.nova_auth/cacert.pem
export NOVA_PROJECT_ID=development
export NOVA_VERSION=1.1
export NOVA_USERNAME=imccracken
export NOVA_API_KEY=99fdeabc-d382-4c90-86f0-20106bf4cfd2
export NOVA_URL=http://10.175.213.10:8774/v1.1/

export WORKON_HOME=/Users/ian/.virtualenvs

source /Volumes/Speedy/zenoss/bin/virtualenvwrapper.sh

export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig
