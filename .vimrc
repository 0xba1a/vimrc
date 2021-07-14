set nocompatible              " be iMproved, required
set encoding=utf-8
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/seoul256.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'vim-syntastic/syntastic'
Plugin 'reedes/vim-lexical'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'vim-scripts/vim-auto-save'
Plugin 'will133/vim-dirdiff'
Plugin 'nathanaelkane/vim-indent-guides' " >= 7.2
Plugin 'ctrlpvim/ctrlp.vim'                  " >= 7.2

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

" ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_custom_ignore = '\v[\/](build*|halon-test|tools|chassis_sim)|(\.(git))$'
" custom_ignore are ignored if custom user command is used. So disable
"if executable('ag')
"    set grepprg=ag\ --nogroup\ --nocolor
"    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"endif

" Color theme
syntax on
let g:seoul256_background = 235
colorscheme seoul256

" Spell checker - vim-lexical
augroup lexical
	autocmd!
	autocmd FileType modula2,markdown,mkd call lexical#init()
	autocmd FileType textile call lexical#init()
	autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END

let g:lexical#spell = 1

" Autosave
let g:auto_save = 1                " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0 " do not save while in insert mode

" vim-markdown
let g:vim_markdown_folding_disabled = 1

" Bullets.vim
let g:bullets_enabled_file_types = [
	\ 'markdown',
	\ 'modula2',
	\ 'text',
	\ 'gitcommit',
	\ 'scratch'
	\]

	" vim-indent-guide
	let g:indent_guides_enable_on_vim_startup = 1

" JS-beautify
" change when required
let s:opt_indent_char="\t"
map <C-f> :call JsBeautify()<cr>
autocmd FileType javascript vnoremap <buffer> <c-f> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
autocmd FileType html,markdown vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

" yankring
nnoremap <silent> <F11> :YRShow<CR>

" --------------------------------- COMMON -----------------------------------
"  Leader
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
" command W w !sudo tee % > /dev/null

" For Cent-OS machine
set tabstop=4
set shiftwidth=4
set expandtab &
autocmd FileType c,cpp set cindent
autocmd FileType c,cpp set tabstop=3
autocmd FileType c,cpp set shiftwidth=3
autocmd FileType c,cpp set expandtab


set scrolloff=30
set cursorline
set nu
set wildmenu
set lazyredraw
set pastetoggle=<F3>
map <leader>w :w!<cr>
map <leader>q :q<cr>
nnoremap * *N

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

" --------------------------------- CSCOPE -----------------------------------
map <F5> :!cscope -Rbk<CR>:cs reset<CR><CR>
set cscopequickfix=s-,c-,d-,i-,t-,e-
nmap .s :cs find s <cword> <CR>
nmap .g :cs find g <cword> <CR>
nmap .c :cs find c <cword> <CR>
nmap .t :cs find t <cword> <CR>
nmap .e :cs find e <cword> <CR>
nmap .f :cs find f <cfile> <CR>
nmap .i :cs find i <cfile> <CR>
nmap .d :cs find d <cword> <CR>

" --------------------------------- COLOR ------------------------------------
" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
set t_ut=

" Status bar - Ariline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

 "powerline setup
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
"python3 del powerline_setup
" HACK: python_setup is overridden by something else. So make it to be called
" after startup. And then remove the loaded module
autocmd VimEnter * execute "python3 powerline_setup()"
autocmd VimEnter * execute "python3 del powerline_setup"
