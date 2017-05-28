let g:quickrun_config.tex = {
  \ 'command' : 'latexmk',
  \ 'outputter' : 'error',
  \ 'outputter/error/success' : 'null',
  \ 'outputter/error/error' : 'quickfix',
  \ 'srcfile': expand('%'),
  \ 'hook/sweep/files' : [
  \   '%S:p:r.aux',
  \   '%S:p:r.bbl',
  \   '%S:p:r.blg',
  \   '%S:p:r.dvi',
  \   '%S:p:r.fdb_latexmk',
  \   '%S:p:r.fls',
  \   '%S:p:r.log',
  \   '%S:p:r.out'
  \ ],
  \ 'exec': '%c %o %a %s',
\}


" compile only a part of file
" ref.) http://auewe.hatenablog.com/entry/2013/12/25/033416
let g:quickrun_config.tmptex = {
  \ 'exec': [
  \   'mv %s %a/tmptex.latex',
  \   'latexmk -pdfdvi -pv -output-directory=%a %a/tmptex.latex',
  \ ],
  \ 'args' : expand("%:p:h:gs?\\\\?/?"),
  \ 'outputter' : 'error',
  \ 'outputter/error/success': 'null',
  \ 'outputter/error/error' : 'quickfix',
  \ 'hook/eval/enable' : 1,
  \ 'hook/eval/cd' : "%s:r",
  \ 'hook/eval/template' : '\documentclass{jarticle}'
  \                       .'\usepackage[dvipdfmx]{graphicx}'
  \                       .'\usepackage{listings,jlisting}'
  \                       .'\lstset{'
  \                       .'language={sh},'
  \                       .'basicstyle={\ttfamily},'
  \                       .'frame={tblr},'
  \                       .'numbers=left,'
  \                       .'numberstyle={\ttfamily\small},'
  \                       .'lineskip=-0.5ex,'
  \                       .'breaklines=true,'
  \                       .'}'
  \                       .'\begin{document}'
  \                       .'%s'
  \                       .'\end{document}',
  \ 'hook/sweep/files' : [
  \   '%a/tmptex.latex',
  \   '%a/tmptex.out',
  \   '%a/tmptex.fdb_latexmk',
  \   '%a/tmptex.log',
  \   '%a/tmptex.aux',
  \   '%a/tmptex.dvi',
  \   '%a/tmptex.fls'
  \ ],
\}


function! s:openPdf()
  let pdf = expand('%:p:r') . '.pdf'
  call system('open ' . pdf)
endfunction


vnoremap <silent><buffer> <Leader>q :QuickRun -mode v -type tmptex -args<CR>
nnoremap <silent><Leader>q :QuickRun<CR>

command! -nargs=0 OpenPdf call <SID>openPdf()

augroup ft_tex
  autocmd!
  autocmd BufWritePost *.tex :QuickRun
augroup END
