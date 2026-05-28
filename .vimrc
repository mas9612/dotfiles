set number
set list
set listchars=eol:$,tab:>-,trail:-
set hlsearch
set incsearch

set noswapfile

set grepprg=grep\ -nHwrI
augroup QuickFix
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

let g:netrw_liststyle = 3
let g:netrw_winsize = 15
let g:netrw_banner = 0
let g:netrw_browse_split = 4

highlight SpecialKey term=bold ctermfg=241
highlight NonText term=bold ctermfg=241

syntax enable
filetype plugin indent on
