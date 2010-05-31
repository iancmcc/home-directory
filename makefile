MAKEFILEDIR = $(shell pwd)
BASHFILES = ~/.bashrc \
			~/.bash_prompt \
			~/.zenossrc \
			~/.bashgit

.DEFAULT: all

all: bash-config

bash-config-setup:
	@for f in $(BASHFILES); do \
		TARGET=`readlink $$f`; \
		if [ -e $$f ]; then \
			if [ ! -h $$f -o ! "`dirname $$TARGET`" = "$(MAKEFILEDIR)" ]; then \
				mv $$f $$f.orig; \
			fi; \
		fi; \
	done

bash-config: bash-config-setup $(BASHFILES) 

$(BASHFILES):
	@ln -s $(MAKEFILEDIR)/`basename $@` $@
