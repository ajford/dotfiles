" Vim syntax file
" Language:	Jinja XML template
" Maintainer:   Anthony J Ford <ford.anthonyj@gmail.com>
" Last Change:	2010 Aug 3

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'xml'
endif

if version < 600
  so <sfile>:p:h/jinja.vim
  so <sfile>:p:h/xml.vim
else
  runtime! syntax/jinja.vim
  runtime! syntax/xml.vim
  unlet b:current_syntax
endif

let b:current_syntax = "xmljinja"
