" vim-plug manages itself
if has('vim_starting')  " {{{
  set runtimepath+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'Installing vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  endif
endif   " }}}

function! IncludePath(path)   " {{{
  let delimiter = ":"
  let pathlist = split($PATH, delimiter)
  if isdirectory(a:path) && index(pathlist, a:path) == -1
    let $PATH=a:path.delimiter.$PATH
  endif
endfunction   " }}}

call IncludePath(expand("~/.pyenv/shims"))

let s:uname = substitute(system('uname -s'), '\n\+$', '', '')


call plug#begin('~/.vim/plugged')   " {{{
Plug 'junegunn/vim-plug', {'dir': '~/.vim/plugged/vim-plug/autoload'}

" completion/lint related
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'deoplete-plugins/deoplete-go', {'do': 'make', 'for': 'go'}
Plug 'deoplete-plugins/deoplete-jedi', {'for': 'python'}
Plug 'Shougo/deoplete-clangx', {'for': ['c', 'cpp']}
Plug 'dense-analysis/ale'

Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'tell-k/vim-autopep8', {'for': 'python'}
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}
Plug 'rhysd/vim-clang-format', {'for': ['c', 'cpp', 'proto']}
Plug 'hashivim/vim-terraform', {'for': 'terraform'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'godlygeek/tabular', {'for': 'markdown'}
Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'php']}
Plug 'othree/html5.vim', {'for': 'html'}
Plug 'hail2u/vim-css3-syntax', {'for': 'css'}
Plug 'pangloss/vim-javascript', {'for': 'js'}

" git related
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv', {'on': ['Gitv']}

" others
Plug 'Konfekt/FastFold'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'kannokanno/previm', {'for': 'markdown'}
Plug 'tomtom/tcomment_vim'
Plug 'vim-scripts/Align'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'glidenote/memolist.vim'

if s:uname == 'Darwin'
  Plug '/usr/local/opt/fzf'
else
  Plug '~/.fzf'
endif
Plug 'junegunn/fzf.vim'
call plug#end()   " }}}


filetype off
filetype plugin indent off

augroup vimrc
    autocmd!
augroup END

" iterm
if s:uname == 'Darwin'
  let g:hybrid_use_iTerm_colors = 1
endif

" set options {{{
if !filereadable(expand('~/.vim/colors/hybrid.vim'))
  call mkdir('~/.vim/colors', 'p')
  call system('curl -fLo ~/.vim/colors/hybrid.vim https://raw.githubusercontent.com/mas9612/dotfiles/master/vim/colors/hybrid.vim')
endif
colorscheme hybrid
set background=dark

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis

set nowritebackup
set nobackup
set noswapfile
set hidden

set splitbelow
set splitright

set ttimeoutlen=100

set path& path+=./**
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
set grepprg=grep\ -nH
set ruler
set cursorline
set lazyredraw
set laststatus=2    " show bottom status line always
set wildmenu
set wildmode=list:full
set wildignore+=*.o,*.pyc

set visualbell t_vb=
set noerrorbells

set foldmethod=marker

set diffopt=internal,filler,vertical,algorithm:patience
" }}}


let g:netrw_silent = 1


" remap {{{
nnoremap : ;
vnoremap : ;
nnoremap ; :
vnoremap ; :

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap <silent><ESC><ESC> :nohlsearch<CR>

" for ctags
nnoremap <C-]> g<C-]>

" move buffer
nnoremap <silent>[b :bprevious<CR>
nnoremap <silent>]b :bnext<CR>
nnoremap <silent>[B :bfirst<CR>
nnoremap <silent>]B :blast<CR>

" quickfix
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :<C-u>cfirst<CR>
nnoremap ]Q :<C-u>clast<CR>

" expand '%%' to current directory in command line mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" use up/down key in command line mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" }}}


" set filetype
autocmd vimrc BufNewFile,BufRead *.tf setlocal filetype=terraform
autocmd vimrc BufNewFile,BufRead *.tex setlocal filetype=tex


" open QuickFix window automatically after use make or grep commands
autocmd vimrc QuickFixCmdPost make,*grep* :cwindow


" remove trailing space
function! s:remove_space()  " {{{
  if &filetype ==? 'markdown'
    return
  endif

  let cursor = getpos(".")
  %s/\s\+$//ge
  call setpos(".", cursor)
  unlet cursor
endfunction   " }}}
autocmd vimrc BufWritePre * call <SID>remove_space()

" restore cursor position
autocmd vimrc BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif


" binary editing mode {{{
function! s:edit_binary()
  if &binary
    silent %!xxd -g 1
    set filetype=xxd
  endif
endfunction

function! s:pre_save_binary()
  if &binary
    let b:cursor = getpos(".")
    silent %!xxd -r
  endif
endfunction

function! s:after_save_binary()
  if &binary
    silent %!xxd -g 1
    set nomodified
    call setpos(".", b:cursor)
    unlet b:cursor
  endif
endfunction

augroup Binary
  autocmd!
  autocmd BufReadPre *.bin let &binary=1
  autocmd BufReadPost * call <SID>edit_binary()
  autocmd BufWritePre * call <SID>pre_save_binary()
  autocmd BufWritePost * call <SID>after_save_binary()
augroup END
" }}}


" deoplete
if s:uname == 'Darwin'
  let g:python3_host_prog = '/usr/local/var/pyenv/shims/python'
else
  let g:python3_host_prog = '/usr/bin/python3'
endif

inoremap <expr><C-g> deoplete#undo_completion()
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#cgo = 1
let g:deoplete#sources#go#builtin_objects = 1
let g:deoplete#sources#go#fallback_to_source = 1


" ale settings
let g:ale_sign_column_always = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_open_list = 1
let g:ale_linters = {
\ 'go': ['gopls', 'staticcheck'],
\}
let g:ale_pattern_options = {
\ '\.md$': {
\   'ale_enabled': 0,
\ },
\}
let g:ale_cpp_clang_options = "-std=c++17 -Wall"

augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END


" vim-clang-format
let g:clang_format#auto_format = 1
let g:clang_format#style_options = {
\ "AllowShortIfStatementsOnASingleLine": "false",
\ "AllowShortLoopsOnASingleLine": "false",
\ "IndentWidth": 4,
\}


" jedi-vim
augroup jedi
    autocmd!
    autocmd FileType python setlocal completeopt-=preview
    autocmd FileType python setlocal omnifunc=jedi#completions
augroup END
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0


" vim-autopep8
let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1


" NERDTree Settings
nnoremap <silent><Leader>e :NERDTreeToggle<CR>
autocmd vimrc bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" emmet-vim Settings
let g:user_emmet_settings = {
    \ 'variables': {
    \ 'lang' : 'ja'
    \ }
\}


" Tex settings
let g:vimtex_compiler_progname = 'latexmk'
let g:vimtex_compiler_latexmk = {'options': []}
let g:vimtex_compiler_latexmk_engines = {'_' : '-pdfdvi'}
" disable the conceal function
let g:tex_conceal=''
nmap <silent><Leader>c <plug>(vimtex-compile)


" PreVim Settings
let g:previm_open_cmd = 'open -a "Google Chrome"'


" lightline settings
set noshowmode
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'fugitive', 'filename' ]
  \   ],
  \   'right': [
  \     [ 'lineinfo' ],
  \     [ 'percent' ],
  \     [ 'fileformat', 'fileencoding', 'filetype' ],
  \     [ 'linter_checking', 'linter_warnings', 'linter_errors', 'linter_ok' ],
  \   ],
  \ },
  \ 'component_function': {
  \   'fugitive': 'LightLineFugitive',
  \   'readonly': 'LightLineReadonly',
  \   'modified': 'LightLineModified',
  \   'filename': 'LightLineFilename'
  \ },
  \ 'component_expand': {
  \   'linter_checking': 'lightline#ale#checking',
  \   'linter_warnings': 'lightline#ale#warnings',
  \   'linter_errors': 'lightline#ale#errors',
  \   'linter_ok': 'lightline#ale#ok',
  \ },
  \ 'component_type': {
  \   'linter_checking': 'ok',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'ok',
  \ },
\}

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "\u2b64"
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? "\u2b60 ".branch : ''
  endif
  return ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction


" vim-markdown settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1


" vim-monster settings
let g:monster#completion#rcodetools#backend = "async_rct_complete"


" vim-go settings
let g:go_code_completion_enabled = 0
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_template_autocreate = 0
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1


" fzf.vim settings
let g:fzf_command_prefix = 'Fzf'

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
\}

" Default fzf layout
let g:fzf_layout = { 'down': '~30%' }

nnoremap <silent><C-p> :FzfFiles<CR>
nnoremap <silent><Leader>b :FzfBuffers<CR>
nnoremap <silent><Leader>t :FzfTags<CR>


" vim-terraform settings
let g:terraform_fmt_on_save = 1


" vim-indent-guides settings
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'gitv']

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=NONE     ctermbg=NONE
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=8


" memolist.vim
let g:memolist_path = "~/Dropbox/memolist"
let g:memolist_memo_date = "%Y-%m-%d %H:%M"
let g:memolist_fzf = 1
let g:memolist_memo_suffix = "md"


filetype plugin indent on
runtime macros/matchit.vim
runtime ftplugin/man.vim
syntax on
