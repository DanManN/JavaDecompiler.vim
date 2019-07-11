if exists("loaded_javad") || &cp || exists("#BufReadPre#*.class")
	finish
endif
let loaded_javad = 1

augroup class
	" Remove all javad autocommands
	au!
	" Enable editing of javaded files
	" set binary mode before reading the file
	" add your preferable flags after "javad" (for instance "javad -f -dead -ff -a")
	autocmd BufReadPre,FileReadPre *.class  set bin
	autocmd BufReadPost,FileReadPost *.class  call s:read(g:javad_cmd)
augroup END

" Function to check that executing "cmd [-f]" works.
" The result is cached in s:have_"cmd" for speed.
fun s:check(cmd)
	let name = substitute(a:cmd, '\(\S*\).*', '\1', '')
	if !exists("s:have_" . name)
		let e = executable(name)
		if e < 0
			let r = system(name . " --version")
			let e = (r !~ "not found" && r != "")
		endif
		exe "let s:have_" . name . "=" . e
	endif
	exe "return s:have_" . name
endfun

" After reading decompiled file: Decompiled text in buffer with "cmd"
fun s:read(cmd)
	" don't do anything if the cmd is not supported
	if !s:check(a:cmd)
		return
	endif
	" make 'patchmode' empty, we don't want a copy of the written file
	let pm_save = &pm
	set pm=
	" set 'modifiable'
	set ma
	" when filtering the whole buffer, it will become empty
	let empty = line("'[") == 1 && line("']") == line("$")
	let javadfile = expand("<afile>:r") . ".javad"
	let orig = expand("<afile>")
	" now we have no binary file, so set 'nobinary'
	set nobin
	"Split and show code in a new window
	g/.*/d
	execute "silent r !" a:cmd . " " . orig
	1
	" set file name, type and file syntax to java
	execute ":file " . javadfile
	set ft=java
	set syntax=java
	" recover global variables
	let &pm = pm_save
endfun
