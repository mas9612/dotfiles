" vimplug Settings ========================
call plug#begin()
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'flazz/vim-colorschemes'
Plug 'Shougo/neocomplete.vim'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'mattn/emmet-vim'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-surround'
Plug 'othree/html5.vim', {'for': 'html'}
Plug 'hail2u/vim-css3-syntax', {'for': 'css'}
Plug 'pangloss/vim-javascript', {'for': 'js'}
Plug 'jiangmiao/auto-pairs'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'scrooloose/syntastic'
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'Shougo/unite.vim'
Plug 'osyo-manga/unite-quickfix'
Plug 'osyo-manga/shabadou.vim'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Konfekt/FastFold'
Plug 'Shougo/vimshell'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'kannokanno/previm', {'for': 'markdown'}
Plug 'tpope/vim-fugitive'
call plug#end()
" vimplug Settings end ====================


" Basic Settings ==========================

filetype off

" iTerm settings
let g:hybrid_use_iTerm_colors = 1
set background=dark
colorscheme hybrid

" set autoindent
set cindent
set backupdir=$HOME/.vimbackup
set directory=$HOME/.vimbackup
set hidden
set incsearch
set hlsearch
set number
set showmatch
set matchpairs& matchpairs+=<:>
set smarttab
set grepformat=%f:%l:%m,%f,%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nh
nnoremap <ESC><ESC> :nohlsearch<CR>
set clipboard=unnamed,autoselect
set ruler           " Show cursor position to right bottom
set cursorline      " Change bgcolor of current line
" set cursorcolumn    " Change bgcolor of current column
set laststatus=2    " show bottom status line always
set mouse=a
set wildmenu wildmode=list:full

" Tab width Settings
set tabstop=4
set shiftwidth=4

set expandtab
let g:marching_backend = "sync_clang_command"
set ambiwidth=double
set backspace=indent,eol,start
au BufRead,BufNewFile *.md set filetype=markdown

nnoremap j gj
nnoremap k gk

" Coffee Script Settings
" au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
" autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
" autocmd BufWritePost *.coffee silent make!
" autocmd QuickFixCmdPost * nested cwindow | redraw!
" nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-w>h

filetype indent on
syntax on

" Basic Settings End =======================


" NeoComplete Settings ===============================
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" NeoComplete Settings End ===========================


" neocomplete-php Settings ==================
" let g:neocomplete_php_locale = 'ja'
" neocomplete-php Settings End ==============


" NERDTree Settings =========================
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" NERDTree Settings End =====================


" emmet-vim Settings ========================
let g:user_emmet_settings = {
			\ 'variables': {
			\ 'lang' : 'ja'
			\ }
			\}
" emmet -vim Settings End ===================


" syntastic Settings =========================
let g:syntastic_python_checkers = ['pyflakes', 'pep8']
" syntastic Settings End =====================


" Tex settings ================================
augroup filetype
  autocmd!
  " tex file (I always use latex)
  autocmd BufRead,BufNewFile *.tex set filetype=tex
augroup END

" disable the conceal function
let g:tex_conceal=''
" Tex settings end ============================


" vim-quickrun settings ========================
let g:quickrun_config = {
\   "_" : {
\       "runner": "vimproc",
\       "runner/vimproc/updatetime": 40,
\       "outputter" : "error",
\       "outputter/error/success" : "buffer",
\       'outputter/error/error' : 'quickfix',
\       "outputter/buffer/split" : ":botright 10sp",
\       "outputter/buffer/close_on_empty" : 1,
\   }
\}

" Press <C-c> to stop QuickRun
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
" vim-quickrun settings end ====================


" PreVim Settings ===========================
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

let g:previm_open_cmd = 'open -a "Google Chrome"'
" PreVim Settings end =======================
