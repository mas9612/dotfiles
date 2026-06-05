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

function! s:GoImports()
  let l:cursor_pos = getpos(".")
  silent! %!goimports
  call setpos(".", l:cursor_pos)
endfunction
command! GoImports call s:GoImports()

function! s:FzfEdit()
  function! s:FzfEditCallback(job, status) closure
    if filereadable(l:tmpfile)
      let l:selected = readfile(l:tmpfile)
      if !empty(l:selected)
        wincmd p
        execute "edit " . trim(l:selected[0])
      endif
      call delete(l:tmpfile)
    endif
  endfunction

  let l:tmpfile = tempname()
  let l:height = max([10, &lines * 20 / 100])
  execute "botright " . l:height . "new"
  call term_start("fzf", {
  \   "curwin": 1,
  \   "term_finish": "close",
  \   "out_io": "file",
  \   "out_name": l:tmpfile,
  \   "exit_cb": function("s:FzfEditCallback")
  \ })
endfunction
command! FzfEdit call s:FzfEdit()
nnoremap <C-p> :FzfEdit<CR>

syntax enable
filetype plugin indent on
