" vim-plug manages itself
if has('vim_starting')
  set runtimepath+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'Installing vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  endif
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug', {'dir': '~/.vim/plugged/vim-plug/autoload'}

Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'nathanaelkane/vim-indent-guides'

let s:uname = substitute(system('uname -s'), '\n\+$', '', '')
if s:uname == 'Darwin'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
else
  Plug '~/.fzf'
endif
Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install()  }  }
call plug#end()

filetype off
filetype plugin indent off

augroup vimrc
    autocmd!
augroup END

set background=dark
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set hidden

set splitbelow
set splitright

set ttimeoutlen=100

set ignorecase
set smartcase
set incsearch
set hlsearch

set shiftround
set tabstop=4
set shiftwidth=4
set cindent
set smarttab
set expandtab
set ambiwidth=double
set backspace=indent,eol,start

set list
set listchars=tab:>\ ,trail:-
set number
set showmatch
set matchpairs& matchpairs+=<:>
set grepformat=%f:%l:%m,%f,%l%m,%f\ \ %l%m
set grepprg=grep\ -snHIER
set ruler
" show bottom status line always
set laststatus=2
set wildmode=list:full

set visualbell t_vb=
set noerrorbells

nnoremap : ;
vnoremap : ;
nnoremap ; :
vnoremap ; :

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap <silent><ESC><ESC> :nohlsearch<CR>

" expand '%%' to current directory in command line mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" open QuickFix window automatically after use make or grep commands
autocmd vimrc QuickFixCmdPost make,*grep* :cwindow

" remove trailing space
function! s:remove_space()
  if &filetype ==? 'markdown'
    return
  endif

  let cursor = getpos(".")
  %s/\s\+$//ge
  call setpos(".", cursor)
  unlet cursor
endfunction
autocmd vimrc BufWritePre * call <SID>remove_space()

" restore cursor position
autocmd vimrc BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

nnoremap <silent><Leader>e :NERDTreeToggle<CR>
autocmd vimrc bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:fzf_command_prefix = 'Fzf'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
\}
let g:fzf_layout = { 'down': '~30%' }

nnoremap <silent><C-p> :FzfFiles<CR>
nnoremap <silent><Leader>b :FzfBuffers<CR>
nnoremap <silent><Leader>t :FzfTags<CR>

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=NONE     ctermbg=NONE
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=8

filetype plugin indent on
runtime macros/matchit.vim
runtime ftplugin/man.vim
syntax on
