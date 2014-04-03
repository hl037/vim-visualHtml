
let s:script_path = 'visualHtml#clcb'

function! visualHtml#clcb#Launch1Browser(url)
   let bufpath = expand('%:p')
   execute "silent !\"".g:visualHtml#clcb#exe."\" " . a:url ." -t 'vim[" . getpid() ."] - ".bufpath.'\%'.a:url."' -g " . b:visualHtml.clcb.geometry . " >/dev/null 2>&1"
   redraw!
endfunction

function! visualHtml#clcb#Refresh1Browser(url)
   call visualHtml#clcb#Launch1Browser(a:url)
endfunction

function! visualHtml#clcb#Exit1Browser(url)
   let bufpath = expand('%:p')
   execute "silent !\"".g:visualHtml#clcb#exe."\" -t 'vim[" . getpid() ."] - ".bufpath.'\%'.a:url."' -d >/dev/null 2>&1"
   redraw!
endfunction

let s:settings = {
   \ 'exe' : "'clcbrowser'",
   \ 'geometry': "'683x741+683+0'"
\ }

function! s:init()
  for [key, val] in items(s:settings)
      if !exists('g:' . s:script_path . '#' . key)
          exe 'let g:' . s:script_path . '#' . key . ' = ' . val
      endif
  endfor
endfunction

call s:init()
