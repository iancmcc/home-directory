set lines=90
set nocompatible
syntax on
colorscheme blackboard
set columns=300
set gfn=Monaco:h12
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
