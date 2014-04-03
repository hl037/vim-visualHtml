"Autoload
"--------

let s:script_path = 'visualHtml'

function! visualHtml#GetUrl(filepath)
   let m = matchlist(a:filepath, g:visualHtml#serverRoot.'/\(.*\)$')
   if !empty(m)
      return g:visualHtml#serverRootUrl."/".m[1]
   else
      return "file://".a:filepath
   endif
endfunction

function! visualHtml#LaunchBrowser()
   for u in b:visualHtml.urllist
      call b:visualHtml.Launch1Browser(u)
   endfor
endfunction

function! visualHtml#RefreshBrowser()
   for u in b:visualHtml.urllist
      call b:visualHtml.Refresh1Browser(u)
   endfor
endfunction



function! visualHtml#SetupBuffer()
   let b:visualHtml = {}
   let b:visualHtml.Launch1Browser = function(
      \ exists('g:visualHtml#Launch1Browser') ?
      \ g:visualHtml#Launch1Browser : 
      \ ('visualHtml#' . g:visualHtml#browser . '#Launch1Browser') )
      
   let b:visualHtml.Refresh1Browser = function(
      \ exists('g:visualHtml#Refresh1Browser') ?
      \ g:visualHtml#Refresh1Browser : 
      \ ('visualHtml#' . g:visualHtml#browser . '#Refresh1Browser') )
   
   let b:visualHtml.active = g:visualHtml#active
   let b:visualHtml.live = g:visualHtml#live
   
   let b:visualHtml.clcb = {}
   let b:visualHtml.clcb.geometry = g:visualHtml#clcb#geometry
   
   call visualHtml#SetActive(b:visualHtml.active)
endfunction



function! visualHtml#SetActive(b)
   let b:visualHtml.active = a:b
   augroup visualHtml
      au!
      if a:b
         if b:visualHtml.live
            au CursorHold,CursorHoldI <buffer> w | call visualHtml#RefreshBrowser()
         endif
         au BufWritePost <buffer> call visualHtml#RefreshBrowser()
      endif
   augroup END
endfunction

function! visualHtml#ToggleActive()
   if b:visualHtml.active
      call visualHtml#SetActive(0)
   else
      call visualHtml#SetActive(1)
   endif
endfunction

function! visualHtml#SetLive(b)
   let b:visualHtml.live = a:b
   if b:visualHtml.active
      call visualHtml#SetActive(1)
   endif
endfunction

function! visualHtml#ToggleLive()
   if b:visualHtml.live
      call visualHtml#SetLive(0)
   else
      call visualHtml#SetLive(1)
   endif
endfunction



let s:settings = {
   \ 'active' : 1,
   \ 'live' : 1,
   \ 'browser': "'clcb'",
   \ 'serverRoot': "'/srv/http'",
   \ 'serverRootUrl': "'http://localhost'"
\ }

function! s:init()
  for [key, val] in items(s:settings)
      if !exists(s:script_path . '#' . key)
          exe 'let g:' . s:script_path . '#' . key . ' = ' . val
      endif
  endfor
endfunction

call s:init()
