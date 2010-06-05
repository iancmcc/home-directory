MAKEFILEDIR = $(shell pwd)
TMPDIR=$(MAKEFILEDIR)/build
BASHFILES = ~/.bashrc \
			~/.profile \
			~/.bash_prompt \
			~/.zenossrc \
			~/.bashgit \
			~/.vim \
			~/.vimrc \
			~/.gvimrc
BIN=$(HOME)/bin
PIP=$(BIN)/pip install
VIRTUALENV=$(TMPDIR)/virtualenv.py
PYTHON=$(BIN)/python
PYPACKAGES=ipython \
		   readline \
		   virtualenv \
		   zope.interface \
		   cliutils \
		   zc.buildout \
		   git+http://github.com/kevinw/pyflakes.git#egg=pyflakes


.DEFAULT: all

all: bash-config python-packages

activate: $(PYTHON)
	@source $(BIN)/activate;

$(TMPDIR):
	@mkdir -p $@
	@sleep 1

bash-config-setup:
	@for f in $(BASHFILES); do \
		TARGET=`readlink $$f`; \
		if [ -e $$f ]; then \
			if [ ! -h $$f -o `dirname "$$TARGET"` != $(MAKEFILEDIR) ]; then \
				mv $$f $$f.orig; \
			fi; \
		fi; \
	done

bash-config: bash-config-setup $(BASHFILES) 

$(BASHFILES):
	@ln -s $(MAKEFILEDIR)/`basename $@` $@

$(VIRTUALENV): | $(TMPDIR)
	@echo $@
	@cd $(TMPDIR); wget "http://bitbucket.org/ianb/virtualenv/raw/8dd7663d9811/virtualenv.py"

$(PYTHON): $(VIRTUALENV)
	@python $(VIRTUALENV) $(HOME)

python-packages: $(PYTHON)
	@$(PIP) $(PYPACKAGES)

clean:
	@rm -rf $(TMPDIR)


.PHONY: all clean bash-config-setup bash-config python-packages
