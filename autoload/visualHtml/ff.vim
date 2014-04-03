
let s:script_path = 'visualHtml#ff'

function! visualHtml#ff#Launch1Browser(url)
   execute "silent !\"".g:visualHtml#ff#exe."\" " . a:url ." >/dev/null 2>&1 &"
   redraw!
endfunction

function! visualHtml#ff#Refresh1Browser(url)
   execute "silent !echo 'window.location = \"" . a:url . "\"' | nc localhost " . g:visualHtml#ff#port . " -c"
   redraw!
   if v:shell_error != 0
      call visualHtml#ff#Launch1Browser(a:url)
   endif
endfunction

function! visualHtml#clcb#Exit1Browser(url)
endfunction

let s:settings = {
   \ 'exe': "'firefox'",
   \ 'port': 32000
\ }

function! s:init()
  for [key, val] in items(s:settings)
      if !exists('g:' . s:script_path . '#' . key)
          exe 'let g:' . s:script_path . '#' . key . ' = ' . val
      endif
  endfor
endfunction

call s:init()
