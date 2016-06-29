set nocompatible                              " choose no campatibility with legacy vi
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'kien/ctrlp.vim'

Plugin 'ervandew/supertab'

Plugin 'pangloss/vim-javascript'

Plugin 'hail2u/vim-css3-syntax'

Plugin 'othree/html5.vim'

Plugin 'Lokaltog/vim-easymotion'

Plugin 'scrooloose/nerdtree'

Plugin 'scrooloose/syntastic'

Plugin 'StanAngeloff/php.vim'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

set t_Co=256                                  " 256-color terminal
syntax on
set encoding=utf-8
set showcmd                                   " display incomplete(partial) commands in status line
set showmatch                                 " show matching brackets
set mouse=a
set cursorline
set backspace=indent,eol,start

"" Whitespace
set nowrap                                    " dont' wrap lines
set tabstop=2 shiftwidth=2                    " a tab is two spaces
set expandtab                                 " use spaces, not tabs
set wildmode=list:full                        " tab completion done better

" Visuals
set guifont=Fira_Code
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R


" Override tab settings for php
augroup filetype_php
  autocmd!
  autocmd FileType php setlocal noexpandtab shiftwidth=2 tabstop=2
augroup END

set ruler                                     " show the line number on the bar
set number                                    " line numbser
set linespace=13                              " Macvim-specific line-height
set title                                     " show filename in status bar
set more                                      " use more prompt
set autoread                                  " watch for file changes
set hidden                                    " hide buffers when they are abandoned - allow opening new files while edits are kept
set ttyfast                                   " let vim do more at once, with a modern terminal
set showmode                                  " alwasy show current mode in status bar

set nobackup
set nowritebackup
set noswapfile
set eol                                       " force blank lines at the end of file
set nobinary                                  " disallow assumption of binary (noeol) mode
set laststatus=2                              " always show the status line
set autoread                                  " instead of prompting to load changed file, just load it

" With a map leader it's possible to do extra key combinations like <leader>w saves the current file
let mapleader = ','
let g:mapleader = ','

" Mappings
nmap <Leader>ev :tabedit $MYVIMRC<cr>
nmap <Leader><space> :nohlsearch<cr>

" Auto-Commands
augroup autosourcing
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END

"" Searching
set hlsearch                                  " highlight matches
set incsearch                                 " incremental searching
set ignorecase                                " do case insensitive matching
set smartcase                                 " do smart case matching...unless they contain at least one capital letter

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

au BufRead,BufNewFile *.scss set filetype=scss

" Supertab - change popup menu color and set context vaule
highlight Pmenu ctermbg=cyan ctermfg=black gui=bold
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" Clear the ctrlp cache and open ctrlp
nnoremap <C-@> :CtrlPClearAllCaches<CR>:CtrlP<CR>

" Ctrlp doesn't show dotfiles by default
let g:ctrlp_show_hidden = 1

let g:ctrlp_max_files = 50000
let g:ctrlp_max_depth = 10

" Keep track of the status bar highlight mode (optimization)
let g:bar_mode = 0

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" change status line color depending on the state of the buffer
function! ColorizeStatusLine(...)
  if a:0 && a:1 == "i" && g:bar_mode != -1
    let g:bar_mode = -1
    highlight StatusLine ctermbg=15  ctermfg=9 guibg=#EF4E56 guifg=#FAFAFA
  else
    if &l:modified == g:bar_mode
      return
    else
      if &l:modified
        highlight StatusLine ctermbg=15 ctermfg=32 guibg=#0190D4 guifg=#FAFAFA
      else
        highlight StatusLine ctermbg=238 ctermfg=253 guibg=#D4D4D4 guifg=#666666
      endif
      let g:bar_mode = &l:modified
    endif
  endif
endfunction

augroup hi_statusline
  autocmd!
  autocmd InsertEnter * call ColorizeStatusLine("i")
  autocmd InsertLeave,CursorMoved,BufReadPost,BufWritePost * call ColorizeStatusLine()
augroup END

" remove trailing space
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

" Easy escaping to normal model
imap jj <esc>

" Auto change directory to match current file ,cd
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

highlight Search cterm=underline

" Remove search results
command! H let @/=""

abbrev gm !php artisan generate:model
abbrev gc !php artisan generate:controller
abbrev gmig !php artisan generate:migration

" Laravel framework commons
nmap <leader>lr :e app/routes.php<cr>
nmap <leader>lca :e app/config/app.php<cr>81Gf(%O
nmap <leader>lcd :e app/config/database.php<cr>
nmap <leader>lc :e composer.json<cr>

" Open splits
nmap vs :vsplit<cr>
nmap sp :split<cr>

" Create/edit file in the current directory
nmap :ed :edit %:p:h/
