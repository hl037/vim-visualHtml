"html ftplugin
"-------------

call visualHtml#SetupBuffer()

let b:visualHtml.urllist = [visualHtml#GetUrl(expand('%:p'))]
