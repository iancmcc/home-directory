set nocompatible
set enc=utf-8
filetype on
filetype plugin on
filetype indent on
let python_highlight_all = 1
syntax on
set autowrite
set incsearch
set hlsearch
set showmode
set ignorecase
set showmatch
set matchtime=2
set noerrorbells
set ru
set ts=4
set et
set number
set wmh=0
set sw=4
set tw=79
set bs=2
set smarttab
"set autoindent
"set smartindent
"autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
set matchpairs=(:),[:],{:},<:>
inoremap # X#
set pastetoggle=<F3>

set viminfo='1000,f1,<500,:500,/500

autocmd Syntax javascript match Error /,\_s*[)}\]]/ 

map <C-J> <C-W>j
map <C-K> <C-W>k
map <c-h> <c-w>h
map <c-l> <c-w>l
map - <C-W>-
map + <C-W>+
map <M-<> <C-W><
map <M->> <C-W>>

set wmw=0
set wmh=0

set wildignore=*.pyc,*.jpg,*.png,*.gif,*.gz

function! CHANGE_CURR_DIR()
    let _dir = expand("%:p:h")
    exec "cd " . _dir
    unlet _dir
endfunction
autocmd BufEnter * call CHANGE_CURR_DIR()

autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

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
set whichwrap=h,l,[,],~
set backspace=eol,start,indent

inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
autocmd Syntax html,vim inoremap < <lt>><ESC>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap """ <c-r>=QuoteDelim('"""')<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

inoremap <D-CR> <Esc>o

autocmd Syntax python inoremap <S-CR> <Esc>A:<Esc>o
autocmd Syntax css,javascript,html inoremap <S-CR> <Esc>A;<Esc>o

vnoremap (  `>a)`<i(
vnoremap )  `>a)`<i(
vnoremap {  `>a}`<i{
vnoremap }  `>a}`<i{
vnoremap "  `>a"`<i"
vnoremap '  `>a'`<i'
vnoremap `  `>a``<i`
vnoremap [  `>a]`<i[
vnoremap ]  `>a]`<i[

function! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

function! QuoteDelim(char)
  let slen = len(a:char)
  let line = getline('.')
  let col = col('.') - slen + 1
  if line[col - 2] == "\\"
    "Inserting a quoted quotation mark into the string
    return a:char
  elseif line[col - 1] == a:char
    "Escaping out of the string
    return "\<Right>"
  else
    "Starting a string
    let alist = []
    for n in range(slen)
        call add(alist,"\<Left>")
    endfor
    return a:char.a:char.join(alist,"")
  endif
endf 

function! InAnEmptyPair()
  let cur = strpart(getline('.'),getpos('.')[2]-2,2)
  for pair in (split(&matchpairs,',') + ['":"',"':'"])
    if cur == join(split(pair,':'),'')
      return 1
    endif
  endfor
  return 0
endfunc

func! DeleteEmptyPairs()
    if InAnEmptyPair()
        return "\<Left>\<Del>\<Del>"
    else
        return "\<BS>"
    endif
endfunc
inoremap <expr> <BS> DeleteEmptyPairs()

func! MultiLinePairs()
    if InAnEmptyPair()
        return "\<CR>\<Esc>O"
    else
        return "\<CR>"
    endif
endfunc
inoremap <expr> <CR> MultiLinePairs()

function! PythonCommentSelection()  range
  let commentString = "#"
  let cl = a:firstline
  let ind = 1000 
  while (cl <= a:lastline)
    if strlen(getline(cl))
      let cind = indent(cl)
      let ind = ((ind < cind) ? ind : cind)
    endif
    let cl = cl + 1
  endwhile
  if (ind == 1000)
    let ind = 1
  else
    let ind = ind + 1
  endif
  let cl = a:firstline
  execute ":".cl
  while (cl <= a:lastline)
    if strlen(getline(cl))
      execute "normal ".ind."|i".commentString
    endif
    execute "normal \<Down>"
    let cl = cl + 1
  endwhile
  execute "normal \<Up>"
endfunction

function! PythonUncommentSelection()  range
  let commentString = "#"
  let cl = a:firstline
  while (cl <= a:lastline)
    let ul = substitute(getline(cl),
             \"\\(\\s*\\)".commentString."\\(.*\\)$", "\\1\\2", "")
    call setline(cl, ul)
    let cl = cl + 1
  endwhile
  endfunction

function! TogglePythonComment() range
    let cl = a:firstline
    let fc = substitute(getline(cl), "^\\s*\\(.\\).*", "\\1", "")
    if (fc == "#")
        execute ":".a:firstline.",".a:lastline."call PythonUncommentSelection()"
    else
        execute ":".a:firstline.",".a:lastline."call PythonCommentSelection()"
    endif
endfunction

map <D-/> :call TogglePythonComment()<CR>




" TAGS "

autocmd FileType python set tags=/Users/ian/.tags/python/tags
autocmd FileType javascript set tags=/Users/ian/.tags/js/tags
cs add $CSCOPE_DB

" Other stuff "

autocmd FileType python set omnifunc=pythoncomplete#Complete

map T :TlistToggle<CR>
map Q :NERDTreeToggle $ZENHOME/Products<CR>
nmap NF :NERDTreeFind<CR>

let g:NERDTreeWinPos = 'right'

set laststatus=2
set statusline=%{GitBranch()}

