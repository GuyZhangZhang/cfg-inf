" =For Vundle==================================================================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'The-NERD-tree'
Plugin 'Tagbar'
Plugin 'minibufexpl.vim'
Plugin 'desert256.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'pangloss/vim-javascript'
Plugin 'python.vim'
Plugin 'php.vim'
Plugin 'go.vim'
Plugin 'Markdown'
Plugin 'tpope/vim-haml'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" =For Public==================================================================
syntax on

" set encoding
set enc=utf-8
set fenc=utf-8
set fencs=utf-8,gb18030,gb2312,gbk
set langmenu=en_US.UTF-8
let $LANG='en_US'

" set number
set nu!

" set some char visible
set list
set listchars=extends:.,precedes:.,tab:>-,trail:-

" set indent
set smartindent
set expandtab
%retab
set tabstop=4
set softtabstop=4
set cindent shiftwidth=4
set autoindent shiftwidth=4

autocmd FileType eruby,ruby,yaml set tabstop=2
autocmd FileType eruby,ruby,yaml set softtabstop=2
autocmd FileType eruby,ruby,yaml set cindent shiftwidth=2
autocmd FileType eruby,ruby,yaml set autoindent shiftwidth=2

" set highlight search
set hlsearch
set showmatch
map :nohl :nohlsearch

" set underline on action row
" set cul

" show 80 column
" set cc=80

" set fold
set foldmethod=syntax

" set not auto fold when open file
set foldlevelstart=99

" set backspace key
set backspace=indent,eol,start

" =For Plugin==================================================================

" set color
colo desert256

" for NERDTree
nmap nt :NERDTreeToggle<cr>

" for tagbar
nmap tb :TagbarToggle<cr>
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }

let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }

" for replace minibuffer
nnoremap <C-l> :w<cr>:bnext<cr>
nnoremap <C-h> :w<cr>:bprevious<cr>
