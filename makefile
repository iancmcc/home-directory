MAKEFILEDIR = $(shell pwd)
TMPDIR=$(MAKEFILEDIR)/build
BASHFILES = ~/.bashrc \
			~/.profile \
			~/.bash_prompt \
			~/.zenossrc \
			~/.bashgit
BIN=$(HOME)/bin
EASYINSTALL=source $(BIN)/activate; $(BIN)/easy_install
VIRTUALENV=$(TMPDIR)/virtualenv.py

.DEFAULT: all

all: bash-config python-env

$(TMPDIR):
	@mkdir -p $@

bash-config-setup:
	@for f in $(BASHFILES); do \
		TARGET=`readlink $$f`; \
		if [ -e $$f ]; then \
			if [ ! -h $$f -o `dirname $$TARGET` != $(MAKEFILEDIR) ]; then \
				mv $$f $$f.orig; \
			fi; \
		fi; \
	done

bash-config: bash-config-setup $(BASHFILES) 

$(BASHFILES):
	@ln -s $(MAKEFILEDIR)/`basename $@` $@

python-env: $(BIN)/python $(BIN)/ipython

$(VIRTUALENV): $(TMPDIR)
	@cd $(TMPDIR); wget "http://bitbucket.org/ianb/virtualenv/raw/8dd7663d9811/virtualenv.py"

$(HOME)/bin/python: $(VIRTUALENV)
	@python $(VIRTUALENV) $(HOME)

$(BIN)/ipython: $(BIN)/python
	@$(EASYINSTALL) ipython

.PHONY: clean
clean:
	@rm -rf $(TMPDIR)
