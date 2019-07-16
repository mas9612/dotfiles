" vim-plug manages itself
if has('vim_starting')
  set runtimepath+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'Installing vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  endif
endif

function! IncludePath(path)
  " define delimiter depends on platform
  if has('win16') || has('win32') || has('win64')
    let delimiter = ";"
  else
    let delimiter = ":"
  endif
  let pathlist = split($PATH, delimiter)
  if isdirectory(a:path) && index(pathlist, a:path) == -1
    let $PATH=a:path.delimiter.$PATH
  endif
endfunction

call IncludePath(expand("~/.pyenv/shims"))

call plug#begin('~/.vim/plugged')
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-go', {'do': 'make'}
Plug 'zchee/deoplete-jedi', {'for': 'python'}
Plug 'Shougo/deoplete-clangx', {'for': ['c', 'cpp']}

Plug 'junegunn/vim-plug', {'dir': '~/.vim/plugged/vim-plug/autoload'}
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv', {'on': ['Gitv']}
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'mattn/emmet-vim', {'for': ['htmldjango', 'html', 'css', 'php']}
Plug 'thinca/vim-quickrun', {'on': 'QuickRun'}
Plug 'tpope/vim-surround'
Plug 'othree/html5.vim', {'for': 'html'}
Plug 'hail2u/vim-css3-syntax', {'for': 'css'}
Plug 'pangloss/vim-javascript', {'for': 'js'}
Plug 'jiangmiao/auto-pairs'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'tell-k/vim-autopep8', {'for': 'python'}
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
" Plug 'lambdalisue/vim-pyenv', {'for': 'python'}
Plug 'w0rp/ale'
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Konfekt/FastFold'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'kannokanno/previm', {'for': 'markdown'}
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'tomtom/tcomment_vim'
Plug 'szw/vim-tags'
Plug 'majutsushi/tagbar'
Plug 'rhysd/vim-clang-format', {'for': ['c', 'cpp', 'proto']}
Plug 'vim-jp/vim-cpp', {'for': ['c', 'cpp']}
Plug 'osyo-manga/vim-marching', {'for': ['c', 'cpp']}
Plug 'kchmck/vim-coffee-script', {'for': 'coffee'}
Plug 'mas9612/mdslide.vim', {'for': 'markdown'}
Plug 'mas9612/md2tex.vim', {'for': 'markdown'}
Plug 'chrisbra/vim-diff-enhanced'
Plug 'osyo-manga/vim-monster', {'for': 'ruby'}
Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'hashivim/vim-terraform', {'for': 'terraform'}
Plug 'vim-scripts/Align'
Plug 'tpope/vim-abolish'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'glidenote/memolist.vim'
call plug#end()


filetype off
filetype plugin indent off

augroup vimrc
    autocmd!
augroup END

" iterm
if has('unix')
  let s:uname = system('uname -s')
  if s:uname == 'Darwin'
    let g:hybrid_use_iTerm_colors = 1
  endif
endif

" set colorscheme to hybrid
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

" set spell
" set spelllang=en,cjk
" augroup vimrc
"   autocmd FileType gitv,git,godoc setlocal nospell
" augroup END

set tags=./tags;

set diffopt=filler,vertical


iabbrev #b /**************************************************
iabbrev #e **************************************************/


let g:netrw_silent = 1


" remap
nnoremap : ;
vnoremap : ;
nnoremap ; :
vnoremap ; :

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap Q gq

nnoremap c. q:k<CR>

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


" set filetype
autocmd vimrc BufNewFile,BufRead *.html setlocal filetype=htmldjango
autocmd vimrc BufNewFile,BufRead *.coffee setlocal filetype=coffee
autocmd vimrc BufNewFile,BufRead *.tf setlocal filetype=terraform


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


" Template File setting
autocmd vimrc BufNewFile *.ly 0read $HOME/.vim/template/lilypond.txt
autocmd vimrc BufNewFile *.py 0read $HOME/.vim/template/python.txt


" binary editing mode
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


" plugin

" vim-clang-format
let g:clang_format#auto_format = 1
let g:clang_format#style_options = {
\ "AllowShortIfStatementsOnASingleLine": "false",
\ "AllowShortLoopsOnASingleLine": "false",
\ "IndentWidth": 4,
\}


" vim-marching settings
let g:marching_clang_command = "/usr/bin/clang"
let g:marching#clang_command#options = {
\   "cpp" : " -std=c++11 -stdlib=libc++"
\}
let g:marching_include_paths = [
\   "/usr/include",
\   "/usr/local/include",
\]
let g:marching_enable_neocomplete = 1
let g:marching#default_config = {
\ " ignore_pat": '^_\D'
\}


if s:uname == 'Darwin'
  let g:python3_host_prog = '/usr/local/var/pyenv/shims/python'
endif
let g:deoplete#enable_at_startup = 1

" call deoplete#custom#option({
" \ 'keyword_patterns', {
" \   '_': '\h\w*',
" \   'go': '\h\w*\.\w*',
" \   'cpp': '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*',
" \   'python': '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*',
" \ },
" })
inoremap <expr><C-g> deoplete#undo_completion()


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


" vim-quickrun settings
let g:quickrun_config = {
  \ "_" : {
  \   'runner': 'vimproc',
  \   'runner/vimproc/updatetime': 50,
  \   'outputter' : 'error',
  \   'outputter/error/success' : 'buffer',
  \   'outputter/error/error' : 'quickfix',
  \   'outputter/buffer/split' : ':botright 10sp',
  \   'outputter/buffer/close_on_empty' : 1,
  \},
  \ "cpp" : {
  \   'command': 'c++',
  \   'cmdopt': '--std=c++11 -stdlib=libc++',
  \   'exec': '%c %o %s',
  \   'args': '',
  \}
\}

" Press <C-c> to stop QuickRun
" define custom function to compatible with lazy load
function! s:quickrun_is_running()
  if exists('*quickrun#is_running()')
    return quickrun#is_running()
  else
    return 0
  end
endfunction
nnoremap <expr><silent> <C-c> <SID>quickrun_is_running() ? quickrun#sweep_sessions() : "\<C-c>"


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
" \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
" \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" },
" \ 'component': {
" \   'lineinfo': '%3l:%2v:%2{GetCurrentChars()}',
" \ },

" function! GetCurrentChars()
"   let l:mode = mode()
"
"   if l:mode == "v" || l:mode == "v" || l:mode == "\<C-v>"
"     let l:chars = wordcount().visual_chars
"   else
"     let l:chars = wordcount().cursor_chars
"   endif
"
"   return l:chars
" endfunction

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


" ale settings
let g:ale_sign_column_always = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_open_list = 1
let g:ale_pattern_options = {
\ '\.md$': {
\   'ale_enabled': 0,
\ },
\}

augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END


" vim-tags settings
let g:vim_tags_auto_generate = 1
let g:vim_tags_ctags_binary = "/usr/local/bin/ctags"


" vim-markdown settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1


" vim-diff-enhanced settings
" started In Diff-Mode set diffexpr
if &diff
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=histogram")'
endif


" mdslide.vim settings
let g:mdslide_open_browser_cmd = 'open -a Google\ Chrome'


" vim-monster settings
let g:monster#completion#rcodetools#backend = "async_rct_complete"


" vim-go settings
let g:go_fmt_command = "goimports"
let g:go_snippet_engine = "neosnippet"
let g:go_template_autocreate = 0
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1
" let g:go_metalinter_autosave = 1


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


" ack.vim settings
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


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
