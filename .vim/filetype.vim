" markdown filetype file
if exists("did_load_filetypes")
    finish
endif

au BufNewFile,BufRead	*/apache2/*,*/apache/*,*/httpd/*	setfiletype apache
au BufNewFile,BufRead	build.xml	setfiletype ant
au BufNewFile,BufRead	.classpath	setfiletype eclipse_classpath

" latex suite plugin doesn't work well with XIM
au BufNewFile,BufRead	*.tex		if (&term == "builtin_gui") | setfiletype plaintex | else | setfiletype tex | endif

au BufNewFile,BufRead	*.mkd		setfiletype mkd
au BufNewFile,BufRead	*.mdwn		setfiletype mkd

au BufNewFile,BufRead	*.adoc		setfiletype asciidoc

au BufNewFile,BufRead	*.h			setfiletype c

au BufNewFile,BufRead	kontact*.tmp	setfiletype mail
au BufNewFile,BufRead	reportbug.*	setfiletype mail
au BufNewFile,BufRead	reportbug-*	setfiletype mail
au BufNewFile,BufRead	muttng-*-\w\+,muttng\w\{6\}	setfiletype mail

au BufNewFile,BufRead	.muttngrc*,Muttngrc	setfiletype muttrc
au BufNewFile,BufRead	muttngrc*,Muttngrc*	setfiletype muttrc

au BufNewFile,BufRead	.pycmailrc	setfiletype python

au BufNewFile,BufRead	hg-editor*	setfiletype hg

au BufNewFile,BufRead	logmsg2	setfiletype cg

au BufNewFile,BufRead	COMMIT_EDITMSG	setfiletype gitcommit

" catch all other filetypes as txt
au BufNewFile,BufEnter		*		if strlen(&filetype) == 0 | setfiletype txt | endif

runtime! ftdetect/*.vim
