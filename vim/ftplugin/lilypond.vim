setlocal runtimepath+=/usr/local/share/lilypond/2.18.2/vim/

let g:quickrun_config['lilypond'] = {
  \ 'command' : 'lilypond',
  \ 'outputter' : 'error',
  \ 'outputter/error/success' : 'null',
  \ 'outputter/error/error' : 'quickfix',
  \ 'srcfile' : expand("%"),
  \ 'exec': '%c %o %a %s',
\}

" let s:hook = {
"   \ 'name': 'open_pdf',
"   \ 'kind': 'hook',
"   \ 'config': {
"   \   'enable': 1,
"   \ },
" \ }

" function! s:hook.on_success(...)
"     let l:fileName = expand("%")
"     let l:fileName = substitute(l:fileName, "ly", "pdf", "")
"     " if not store retval to variable, E492 error occur
"     let l:result = system("open " . l:fileName)
" endfunction
"
" call quickrun#module#register(s:hook, 1)

nnoremap <silent><Leader>q :QuickRun<CR>
