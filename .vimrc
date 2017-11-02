set nocompatible              " be iMproved, required
filetype off                  " required

let g:isUbuntu = system('uname -a | grep buntu')

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'                   " dependancy for vim-easyclip
Plugin 'junegunn/seoul256.vim'
Plugin 'vim-scripts/grep.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'vim-syntastic/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'reedes/vim-lexical'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'vim-scripts/vim-auto-save'

if g:isUbuntu != ""
	" In Ubuntu Web-dev machine only
	Plugin 'nathanaelkane/vim-indent-guides' " >= 7.2
	Plugin 'Valloric/YouCompleteMe'          " >= 7.2
	Plugin 'plasticboy/vim-markdown'
	Plugin 'digitaltoad/vim-pug'
	Plugin 'maksimr/vim-jsbeautify'
	Plugin 'tomlion/vim-solidity'
	Plugin 'YankRing.vim'
endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on

" --------------------------------- PLUGIN -----------------------------------
"NerdTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <F2> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = 'v'

" Color theme
syntax on
let g:seoul256_background = 235
colorscheme seoul256

" Status bar - Ariline
let g:airline#extensions#tabline#enabled = 1

" Spell checker - vim-lexical
augroup lexical
	autocmd!
	autocmd FileType markdown,mkd call lexical#init()
	autocmd FileType textile call lexical#init()
	autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END

let g:lexical#spell = 1

" Autosave
let g:auto_save = 1                " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0 " do not save while in insert mode

if g:isUbuntu != ""
	" vim-indent-guide
	let g:indent_guides_enable_on_vim_startup = 1

	" JS-beautify
	map <C-f> :call JsBeautify()<cr>
	autocmd FileType javascript vnoremap <buffer> <c-f> :call RangeJsBeautify()<cr>
	autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
	autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
	autocmd FileType html,markdown vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
	autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

	" vim-markdown
	let g:vim_markdown_folding_disabled = 1

	" yankring
	nnoremap <silent> <F11> :YRShow<CR>
endif

" --------------------------------- COMMON -----------------------------------
"  Leader
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

if g:isUbuntu == ""
" For Cent-OS machine
	autocmd FileType c,cpp set cindent
	autocmd FileType c,cpp set tabstop=3
	autocmd FileType c,cpp set shiftwidth=3
	autocmd FileType c,cpp set expandtab
else
	set tabstop=4
	set shiftwidth=4
endif

set scrolloff=30
set cursorline
set nu
set wildmenu
set lazyredraw
set pastetoggle=<F3>
map <leader>w :w!<cr>
map <leader>q :q<cr>

"Search related
set hlsearch
set incsearch
" unhighlight when ,<cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map fj <C-W>j
map fk <C-W>k
map fh <C-W>h
map fl <C-W>l

" move between vimgrep results
nmap fn :cn <CR>
nmap fp :cp <CR>

" work on tabs
map tn :tabnew <CR>
map tl :tabnext <CR>
map th :tabprev <CR>
map tx :tabclose <CR>

" work on buffers
map bh :bp <CR>
map bl :bn <CR>

" --------------------------------- CSCOPE -----------------------------------
nmap .s :cs find s <cword> <CR>
nmap .g :cs find g <cword> <CR>
nmap .c :cs find c <cword> <CR>
nmap .t :cs find t <cword> <CR>
nmap .e :cs find e <cword> <CR>
nmap .f :cs find f <cfile> <CR>
nmap .i :cs find i <cfile> <CR>
nmap .d :cs find d <cword> <CR>

