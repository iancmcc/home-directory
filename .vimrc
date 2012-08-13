set t_Co=256
set background=dark
colorscheme solarized
syntax on

filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" Make vim incompatible to vi
set nocompatible
set modelines=0

" Tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" More common settings
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set matchpairs=(:),[:],{:},<:>
set viminfo='1000,f1,<500,:500,/500

" Moving between windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <c-h> <c-w>h
map <c-l> <c-w>l
map - <C-W>-
map + <C-W>+
map <M-<> <C-W><
map <M->> <C-W>>

" Cursor line
set ttyfast
set ruler
set backspace=indent,eol,start
set whichwrap=h,l,[,],~
set laststatus=2

" relativenumber
set number
set norelativenumber

" undofile
set shell=/usr/local/bin/bash
set lazyredraw
set matchtime=3

" Leader key
let mapleader = ","

set title
set dictionary=/usr/share/dict/words
set pastetoggle=<F3>

" Allow vim to edit crontab
set backupskip=/tmp/*,/private/tmp/*

" Enable mouse
set mouse=a

" Searching and moving
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %


" Long lines
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=79

" Special characters
set list
set listchars=tab:▸\

inoremap <leader>j <ESC>:RopeGotoDefinition<cr>

nnoremap ; :

" Remove whitespace from a file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" ,ft Fold tag, helpful for HTML editing.
nnoremap <leader>ft vatzf

" ,q Re-hardwrap Paragraph
nnoremap <leader>q gqip

" ,v Select just pasted text.
nnoremap <leader>v V`]

" ,ev Shortcut to edit .vimrc file on the fly on a vertical window.
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" jj For Qicker Escaping between normal and editing mode.
inoremap jj <ESC>

" Make Sure that Vim returns to the same line when we reopen a file"
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ execute 'normal! g`"zvzz' |
        \ endif
augroup END

nnoremap g; g;zz


" Working with split screen nicely
" Resize Split When the window is resized"
au VimResized * :wincmd =


" Wildmenu completion "
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn " Version Controls"
set wildignore+=*.aux,*.out,*.toc "Latex Indermediate files"
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg "Binary Imgs"
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "Compiled Object files"
set wildignore+=*.spl "Compiled speolling world list"
set wildignore+=*.sw? "Vim swap files"
set wildignore+=*.DS_Store "OSX SHIT"
set wildignore+=*.luac "Lua byte code"
set wildignore+=migrations "Django migrations"
set wildignore+=*.pyc "Python Object codes"
set wildignore+=*.orig "Merge resolution files"


" gvim settings

" Removing scrollbars
if has("gui_running")
    set gfn=Letter\ Gothic\ Std\ Bold:h14
    set tabpagemax=1
    set transp=5
    set sessionoptions+=resize,winpos
    set guitablabel=%-0.12t%M
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions+=a
    set guioptions+=m
    set listchars=tab:▸\ ,eol:¬         " Invisibles using the Textmate style
    autocmd VimEnter * wincmd p
    autocmd VimEnter * NERDTreeFind
    autocmd VimEnter * wincmd p
    autocmd VimEnter * vsplit
endif


autocmd bufwritepost .vimrc source ~/.vimrc

" Mapping to NERDTree
let g:NERDTreeWinPos = 'right'
nnoremap <C-n> :NERDTreeToggle<cr>
nnoremap NF :NERDTreeFind<CR>

" Mini Buffer some settigns."
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Rope Plugin settings
imap <leader>j <ESC>:RopeGotoDefinition<cr>
nmap <leader>j <ESC>:RopeGotoDefinition<cr>

" Tagbar key bindings."
nmap <leader>l <ESC>:TagbarToggle<cr>
imap <leader>l <ESC>:TagbarToggle<cr>i

" Change directory to current
function! CHANGE_CURR_DIR()
    let _dir = expand("%:p:h")
    exec "cd " . _dir
    unlet _dir
endfunction
autocmd BufEnter * call CHANGE_CURR_DIR()

if &term == "xterm-color"
	set t_kb=
	fixdel
endif

"nnoremap <silent> Q :Ex<CR>
noremap Y y$
nmap <Tab> >>
nmap <S-Tab> <<
vmap <Tab> >gv
vmap <S-Tab> <gv

nmap ,pdb Oimport pdb; pdb.set_trace()<Esc>

inoremap <D-CR> <Esc>o

autocmd Syntax python inoremap <S-CR> <Esc>A:<Esc>o
autocmd Syntax css,javascript,html inoremap <S-CR> <Esc>A;<Esc>o

map <C-/> :NERDComToggleComment



" Other stuff "
nnoremap <F5> :!pyflakes %<return>

map <leader>v <Plug>TaskList



