set nocompatible															" choose no campatibility with legacy vi
set t_Co=256                                  " 256-color terminal

syntax on
call pathogen#infect()
set runtimepath^=~/.vim/bundle/ctrlp.vim
colorscheme railscasts

set encoding=utf-8
set showcmd																		" display incomplete(partial) commands in status line
set showmatch 																" show matching brackets
filetype plugin indent on											" load file type plugins + indentation
set mouse=a

"" Whitespace
set nowrap																		" dont' wrap lines
set tabstop=2 shiftwidth=2										" a tab is two spaces
set expandtab  																" use spaces, not tabs
set wildmode=list:full                        " tab completion done better

" Override tab settings for php
augroup filetype_php
  autocmd!
  autocmd FileType php setlocal noexpandtab shiftwidth=2 tabstop=2
augroup END

set ruler             												" show the line number on the bar
set number																		" line numbser		
set title                                     " show filename in status bar
set more               												" use more prompt
set autoread            											" watch for file changes
set hidden																		" hide buffers when they are abandoned - allow opening new files while edits are kept
set ttyfast                                   " let vim do more at once, with a modern terminal
set showmode                                  " alwasy show current mode in status bar

set nobackup
set nowritebackup
set noswapfile
set eol                                       " force blank lines at the end of file
set nobinary                                  " disallow assumption of binary (noeol) mode
set laststatus=2                              " always show the status line
set autoread                                  " instead of prompting to load changed file, just load it

"" Searching
set hlsearch																	" highlight matches
set incsearch																	" incremental searching
set ignorecase          											" do case insensitive matching
set smartcase           											" do smart case matching...unless they contain at least one capital letter

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

au BufRead,BufNewFile *.scss set filetype=scss

" Supertab - change popup menu color and set context vaule
:highlight Pmenu guibg=cyan gui=bold
let g:SuperTabDefaultCompletionType = "context"

" Bring up the buffer selection menu in ctrlp
" nnoremap <C-q> :CtrlPBuffer<CR>

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

fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

