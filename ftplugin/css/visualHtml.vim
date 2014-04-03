"css ftplugin
"------------

if visualHtml#SetupBuffer()
   finish
endif

let previewpath = expand('%:p').'.preview'
if filereadable(previewpath)
   let flist = readfile(previewpath)
   let b:visualHtml.urllist = map(flist, "visualHtml#GetUrl(fnamemodify(v:val, ':p'))")
else
   let flist = ['index.html', 'index.htm', 'index.php']
   let previewpath = expand('%:p:h')
   let flist = map(flist, 'previewpath."/".v:val')
   let flist = filter(flist, 'file_readable(v:val)')
   let b:visualHtml.urllist = map(flist, 'visualHtml#GetUrl(v:val)')
endif

call visualHtml#Start()
