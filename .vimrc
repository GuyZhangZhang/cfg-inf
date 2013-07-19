colo delek
set nocompatible
" set bsdir=buffer
" set autochdir

"set enc=gb2312

"set fenc=gb18030
"set fileencoding=gb18030

"set fencs=gb18030,gbk,gb2312,utf-8
"set fileencodings=gb18030,gbk,gb2312,utf-8

"set langmenu=en_US.GB18030
set enc=utf-8
set fenc=utf-8
set fencs=utf-8,gb18030,gb2312,gbk
set langmenu=en_US.UTF-8

let $LANG = 'en_US'
"set spl=en spell
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

syntax on

set nu!

set tw=0

set ruler

set hlsearch
set showmatch

set list
set listchars=extends:.,precedes:.,tab:>-,trail:-

set smartindent
set expandtab
%retab
set tabstop=4
set softtabstop=4
set cindent shiftwidth=4
set autoindent shiftwidth=4

autocmd FileType yaml set tabstop=2
if has("autocmd")
    filetype plugin indent on
endif

set cmdheight=1

set nospell
set foldmethod=indent

set ignorecase

map :nohl :nohlsearch

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

let g:winManagerWindowLayout='FileExplorer|TagList'
let g:persistentBehaviour=0
let g:defaultExplorer=0
nmap wm :WMToggle<cr>

nnoremap <C-l> :w<cr>:bnext<cr>
nnoremap <C-h> :w<cr>:bprevious<cr>
inoremap <F5> <c-r>=strftime("%F %T")<cr>

set backspace=indent,eol,start

set cc=81
