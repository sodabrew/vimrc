" fastwordcompleter.vim:	automatically offers word completion
" Last Modified: Do 01. Jul 2010 11:36:58 +0200 CEST
" Author:		Jan Christoph Ebersbach <jceb@e-jc.de>
" Version:		0.2
"
" inspired by http://vim.sourceforge.net/scripts/script.php?script_id=73

" DESCRIPTION:
"  Each time you type an alphabetic character, the script attempts to complete
"  the current word. The suggested completion is draw below the word you are
"  typing. Type <C-N> to select the completion and continue with the next word.

" LIMITATIONS:
"  The script works by :imap'ping each alphabetic character, and uses
"  Insert-mode completion (:help ins-completion). It is far from perfect.
"  If there is in total only one option to complete, no completion will be
"  display because of vim's completion menu implementation.

" INSTALLATION:
"  :source it from your vimrc file or drop it in your plugin directory.
"  To activate, choose "Start Autocompletion" from the Tools menu, or type
"  :call FastWordCompletionStart()
"  To make it stop, choose "Plugin/Stop Autocompletion", or type
"  :call FastWordCompletionStop()
"  If you want to activate the script for certain filetypes, add the line
"  	let g:fastwordcompleter_filetypes = 'filetype,...'
"  to your vimrc file.

if (exists("g:loaded_fastwordcompletion") && g:loaded_fastwordcompletion) || &cp
    finish
endif
let g:loaded_fastwordcompletion = 1

if !exists('g:fastwordcompletion_nomenuone')
  set completeopt=menuone
endif

" Make an :imap for each alphabetic character, and define a few :smap's.
fun! s:FastWordCompletionStart()
  " Thanks to Bohdan Vlasyuk for suggesting a loop here:
  for c in [["A", "Z"], ["a", "z"]]
    let letter = char2nr(c[0])
    let letter_to = char2nr(c[1])
    while letter <= letter_to
      let char = nr2char(letter)
      execute "inoremap <buffer> ".char.' '.char."<C-n><C-p>"
      let letter += 1
    endwhile
  endfor
endfun

" Remove all the mappings created by FastWordCompletionStart().
" Lazy:  I do not save and restore existing mappings.
fun! s:FastWordCompletionStop()
  " Thanks to Bohdan Vlasyuk for suggesting a loop here:
  for c in [["A", "Z"], ["a", "z"]]
    let letter = char2nr(c[0])
    let letter_to = char2nr(c[1])
    while letter <= letter_to
      execute "iunmap <buffer> ".nr2char(letter)
      let letter = letter + 1
    endwhile
  endfor
endfun

if (exists('g:fastwordcompleter_filetypes') && len(g:fastwordcompleter_filetypes) > 0)
    exec 'au FileType '.g:fastwordcompleter_filetypes.' :FastWordCompletionStart'
endif

if has("menu")
  amenu &Plugin.&FastWordCompleter.&Start\ Autocompletion :FastWordCompletionStart<CR>
  amenu &Plugin.&FastWordCompleter.Sto&p\ Autocompletion :FastWordCompletionStop<CR>
endif

command! -nargs=0 FastWordCompletionStart call <SID>FastWordCompletionStart()
command! -nargs=0 FastWordCompletionStop call <SID>FastWordCompletionStop()

" vim:sts=2:sw=2:ff=unix: