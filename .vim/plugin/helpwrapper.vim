" helpwrapper.vim -- Wrap several different help systems within one shortcut
" @Author       : Jan Christoph Ebersbach (jceb@e-jc.de)
" @License      : GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created      : 2010-08-14
" @Last Modified: Sat 14. Aug 2010 19:15:53 +0000 UTC
" @Revision     : 1.0
" @vi           : ft=vim:tw=80:sw=4:ts=8
"
" @Description  : Helpwrapper makes it easy to access help from within a
"                 buffer. It takes the file type and opens help when requested
"                 via <leader>K or :Help command.
" @Usage        : <leader>K oder :Help
" @TODO         :
" @Dependency   :
" @CHANGES      :

if &cp || exists("loaded_helpwrapper")
    finish
endif
let loaded_helpwrapper = 1

if !exists('g:helpwrapper_mappings')
	let g:helpwrapper_mappings = {'help': ':help', 'vim': ':help', 'man': ':Man', 'sh': ':Man', 'python': ':Pydoc'}
endif

if !exists('g:helpwrapper_default')
	let g:helpwrapper_default = 'sh'
endif

function! s:OpenHelp(cmd, visual, query)
	try
		if len(a:query)
			exec a:cmd.' afd '.a:query
		elseif a:visual
			exec a:cmd.' '.@*
		else
			exec a:cmd.' '.expand('<cword>')
		endif
	catch
		echom 'Executing help command failed: '.v:exception
	endtry
endfunction

function! s:Helpwrapper(visual, query)
	" support for files with multiple filetypes
	let fts = split(&ft, '\.')

	let opened_help = 0
	for ft in fts
		if has_key(g:helpwrapper_mappings, ft) == 1 && index([1, 2], exists(g:helpwrapper_mappings[ft])) != -1
			call s:OpenHelp(g:helpwrapper_mappings[ft], a:visual, a:query)
			let opened_help = 1
			break
		endif
	endfor

	if ! opened_help
		if has_key(g:helpwrapper_mappings, g:helpwrapper_default) &&  index([1, 2], exists(g:helpwrapper_mappings[g:helpwrapper_default])) != -1
			call s:OpenHelp(g:helpwrapper_mappings[g:helpwrapper_default], a:visual, a:query)
		else
			echom 'Unable to find help command for file type '.&ft
		endif
	endif
endfunction

nnoremap <leader>K :call <SID>Helpwrapper(0, '')<CR>
vnoremap <leader>K :call <SID>Helpwrapper(1, '')<CR>
command! -nargs=1 -complete=help Help :call <SID>Helpwrapper(0, <q-args>)
