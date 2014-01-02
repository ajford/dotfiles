"
" Tango Vim Color Scheme
" =======================
"
" For best results, set up your terminal with a Tango palette.
" Instructions for GNOME Terminal:
" http://uwstopia.nl/blog/2006/07/tango-terminal
"
" author:   Michele Campeotto <micampe@micampe.it>
"
set background=dark

hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "tango"

" Default Colors
hi Normal       guifg=#eeeeec guibg=#000000
hi NonText      guifg=#555753 guibg=#000000 gui=none
hi NonText      ctermfg=darkgray

" Search
hi Search       cterm=none ctermfg=grey ctermbg=blue
hi IncSearch    cterm=none ctermfg=yellow ctermbg=green

" Window Elements
hi StatusLine   ctermfg=white ctermbg=green cterm=bold
hi StatusLineNC ctermfg=lightgray ctermbg=darkgreen
hi Folded       ctermfg=white ctermbg=none
hi Visual       ctermbg=white ctermfg=24 cterm=reverse

" Specials
hi Todo         ctermfg=white ctermbg=green
hi Title        ctermfg=white cterm=bold

" Syntax
hi Constant     ctermfg=darkyellow
hi Number       ctermfg=26
hi Float        ctermfg=26
hi Function     ctermfg=202
hi String       ctermfg=253

hi Statement    ctermfg=green
hi Type         ctermfg=green cterm=bold
hi Identifier   ctermfg=darkgreen
hi PreProc      ctermfg=darkred
hi Comment      ctermfg=248 cterm=none
hi Special      ctermfg=199 cterm=none
hi Error        ctermfg=white ctermbg=red
hi Exception    ctermfg=162
hi Include      ctermfg=214
hi Structure    ctermfg=124

" Diff
hi DiffAdd      ctermfg=gray ctermbg=blue cterm=none
hi DiffChange   ctermfg=gray ctermbg=darkgray cterm=none
hi DiffDelete   ctermfg=gray ctermbg=none cterm=none
hi DiffText     ctermfg=gray ctermbg=yellow cterm=none

