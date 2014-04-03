"html ftplugin
"-------------

if visualHtml#SetupBuffer()
   finish
endif

let b:visualHtml.urllist = [visualHtml#GetUrl(expand('%:p'))]

call visualHtml#Start()
