set lines=90
set nocompatible
syntax on
set background=dark
colorscheme solarized
set columns=300
set gfn=Letter\ Gothic\ Std\ Bold:h14
set tabpagemax=1

set transp=5

set sessionoptions+=resize,winpos
nmap SQ <ESC>:mksession! ~/.vim/Session.vim<CR>:wqa<CR>

function! RestoreSession()
    if argc() == 0
        execute 'source ~/.vim/Session.vim'
    end
endfunction

" Initialization of browsers "
autocmd VimEnter * TlistToggle
autocmd VimEnter * NERDTreeToggle $ZENHOME/Products
autocmd VimEnter * wincmd p
autocmd VimEnter * NERDTreeFind
autocmd VimEnter * wincmd p
autocmd VimEnter * vsplit
