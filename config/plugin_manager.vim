" Plugin Manager:
" ------------------

if exists('g:vimrc_plugins_loaded')
	finish
endif
let g:vimrc_plugins_loaded = 1

"filetype off        " deactivate filetype auto detection before loading bundles to force a reload (this decreases startup time a lot!)
call pathogen#infect(g:vimdir.g:sep.'bundle')
call ipi#inspect(g:vimdir.g:sep.'ipi')

filetype plugin indent on        " activate filetype auto detection, automatically load filetypeplugins, indent according to the filetype
