hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "tokyonight"

" Basic groups
hi Normal       ctermfg=252 ctermbg=235
hi Comment      ctermfg=240
hi Constant     ctermfg=173
hi String       ctermfg=107
hi Character    ctermfg=107
hi Number       ctermfg=109
hi Boolean      ctermfg=109
hi Float        ctermfg=109

hi Identifier   ctermfg=110
hi Function     ctermfg=75

hi Statement    ctermfg=74
hi Conditional  ctermfg=74
hi Repeat       ctermfg=74
hi Label        ctermfg=74
hi Operator     ctermfg=81
hi Keyword      ctermfg=74
hi Exception    ctermfg=81

hi PreProc      ctermfg=173
hi Include      ctermfg=173
hi Define       ctermfg=173
hi Macro        ctermfg=173
hi PreCondit    ctermfg=173

hi Type         ctermfg=110
hi StorageClass ctermfg=110
hi Structure    ctermfg=110
hi Typedef      ctermfg=110

hi Special      ctermfg=215
hi SpecialChar  ctermfg=215
hi Tag          ctermfg=215
hi Delimiter    ctermfg=240
hi SpecialComment ctermfg=240
hi Debug        ctermfg=215

" UI elements
hi CursorLine   cterm=NONE ctermbg=236
hi CursorLineNr ctermfg=180 ctermbg=236
hi LineNr       ctermfg=239
hi StatusLine   ctermfg=252 ctermbg=237
hi StatusLineNC ctermfg=239 ctermbg=236
hi VertSplit    ctermfg=237 ctermbg=237

hi Visual       ctermbg=238
hi Search       ctermfg=235 ctermbg=180
hi IncSearch    ctermfg=235 ctermbg=215

hi Pmenu        ctermfg=252 ctermbg=237
hi PmenuSel     ctermfg=235 ctermbg=110
hi PmenuSbar    ctermbg=237
hi PmenuThumb   ctermbg=240

hi Error        ctermfg=203 ctermbg=235
hi Todo         ctermfg=220 ctermbg=236
