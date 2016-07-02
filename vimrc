set nocompatible                                            " choose no campatibility with legacy vi
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-vinegar'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'ervandew/supertab'

Plugin 'StanAngeloff/php.vim'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'othree/html5.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/syntastic'

" SnipMate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on



" Visuals
set t_Co=256                                                " 256-color terminal
colorscheme atom-dark
syntax on
set guifont=Fira_Code
set guioptions-=l                                           " disable gui scrollbars.
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=e                                           " disable gui tabs
set encoding=utf-8
set showcmd                                                 " display incomplete(partial) commands in status line
set showmatch                                               " show matching brackets
set mouse=a
set cursorline
set backspace=indent,eol,start
set noerrorbells visualbell t_vb=                           " no bells

" MacVim
hi LineNr guibg=bg
"set foldcolumn=2
"hi foldcolumn guibg=bg
"hi vertsplit guifg=bg guibg=bg                              " get rid of split borders

" Whitespace
set nowrap                                                  " dont' wrap lines
set tabstop=2 shiftwidth=2                                  " a tab is two spaces
set expandtab                                               " use spaces, not tabs
set wildmode=list:full                                      " tab completion done better

set ruler                                                   " show the line number on the bar
set number                                                  " line number
set linespace=13                                            " Macvim-specific line-height
set title                                                   " show filename in status bar
set more                                                    " use more prompt
set hidden                                                  " hide buffers when they are abandoned - allow opening new files while edits are kept
set ttyfast                                                 " let vim do more at once, with a modern terminal
set showmode                                                " alwasy show current mode in status bar

set nobackup
set nowritebackup
set noswapfile
set eol                                                     " force blank lines at the end of file
set nobinary                                                " disallow assumption of binary (noeol) mode
set laststatus=2                                            " always show the status line
set autoread                                                " instead of prompting to load changed file, just load it
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Searching
set hlsearch                                                " highlight matches
set incsearch                                               " incremental searching
set ignorecase                                              " do case insensitive matching
set smartcase                                               " do smart case matching...unless they contain at least one capital letter

set autowriteall                                            " automatically write the file when switching buffers
set complete=.,w,b,u                                        " set our desired autocompletion matching



" With a map leader it's possible to do extra key combinations like <leader>w saves the current file
let mapleader = ','
let g:mapleader = ','
let g:bar_mode = 0                                          " keep track of the status bar highlight mode (optimization)
let NERDTreeHijackNetrw = 0
let g:airline#extensions#tabline#enabled = 1

" Mappings
nmap <Leader>ev :tabedit $MYVIMRC<cr>
nmap <Leader>es :e ~/.vim/snippets/

" Remove search highlight
nmap <Leader><space> :nohlsearch<cr>

" Toggle NERDTree
nmap <D-1> :NERDTreeToggle<cr>

" Quickly browse to any tag/symbol in the project.
" Tip: run ctags -R to regenerated the index.
nmap <Leader>f :tag<space>

" Ctrlp settings
nmap <c-R> :CtrlPBufTag<cr>
nmap <c-e> :CtrlPMRUFiles<cr>

" Show hidden files
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_files = 50000
let g:ctrlp_max_depth = 10
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
"let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30,results:30'

" Clear the ctrlp cache and open ctrlp
nnoremap <C-@> :CtrlPClearAllCaches<CR>:CtrlP<CR>

" Auto-Commands
" Override tab settings for php
augroup filetype_php
  autocmd!
  autocmd FileType php setlocal noexpandtab shiftwidth=4 tabstop=4
augroup END

" Auto soure vimrc file when it's saved
augroup autosourcing
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END

" Remove trailing space
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Split Management
set splitbelow
set splitright
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Auto change directory to match current file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Open splits
nmap vs :vsplit<cr>
nmap sp :split<cr>

" Create/edit file in the current directory
nmap :ed :edit %:p:h/



" PHP - Import classes (add use statements)
function! IPhpInsertUse()
  call PhpInsertUse()
  call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>n <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>n :call PhpInsertUse()<CR>

" PHP - Make class names full qulified
function! IPhpExpandClass()
  call PhpExpandClass()
  call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>nf <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>nf :call PhpExpandClass()<CR>

" PHP- Sort existing use statements alphabetically
autocmd FileType php inoremap <Leader>ns <Esc>:call PhpSortUse()<CR>
autocmd FileType php noremap <Leader>ns :call PhpSortUse()<CR>

" PHP-cs-fixer
let g:php_cs_fixer_level = "psr2"
nnoremap <silent><leader>pf :call PhpCsFixerFixDirectory()<CR>
