stty erase 

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

test -r /sw/bin/init.sh && . /sw/bin/init.sh

# Setting PATH for Python 2.7
# The orginal version is saved in .profile.pysave
PATH="${PATH}:/Library/Frameworks/Python.framework/Versions/2.7/bin"
PATH="${PATH}:/usr/local/bin"
export PATH
