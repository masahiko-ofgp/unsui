" Unsui Theme: {{{
"
" https://github.com/masahiko-ofgp/unsui
"
" Copyright 2019, All rights reserved
"
" Code licensed under the MIT license <LICENSE or
"  http://opensource.org/licenses/MIT>.
"
" @author Masahiko Hamazawa <ichigyo.zanmai@gmail.com>
scriptencoding utf8
" }}}

" Configuration: {{{

if v:version > 580
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = 'unsui'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" Palette: {{{2

let s:fg        = ['#D0D0D0', 252]

let s:bglighter = ['#424450', 238]
let s:bglight   = ['#343746', 237]
let s:bg        = ['#121212', 233]
let s:bgdark    = ['#21222C', 235]
let s:bgdarker  = ['#191A21', 234]

let s:subtle    = ['#424450', 238]

let s:selection = ['#44475A', 239]
let s:comment   = ['#585858', 240]
let s:cyan      = ['#00AF87', 36]
let s:green     = ['#87AF5F', 113]
let s:orange    = ['#FFB86C', 215]
let s:pink      = ['#AF005F', 125]
let s:purple    = ['#875FFF', 99]
let s:red       = ['#AF5F5F', 131]
let s:yellow    = ['#87875F', 101]
let s:black     = ['#000000', 0]

let s:none      = ['NONE', 'NONE']

let g:unsui_palette = {
      \ 'fg': s:fg,
      \ 'bg': s:bg,
      \ 'selection': s:selection,
      \ 'comment': s:comment,
      \ 'cyan': s:cyan,
      \ 'green': s:green,
      \ 'orange': s:orange,
      \ 'pink': s:pink,
      \ 'purple': s:purple,
      \ 'red': s:red,
      \ 'yellow': s:yellow,
      \ 'black': s:black,
      \
      \ 'bglighter': s:bglighter,
      \ 'bglight': s:bglight,
      \ 'bgdark': s:bgdark,
      \ 'bgdarker': s:bgdarker,
      \ 'subtle': s:subtle,
      \}


if has('terminal')
  let g:terminal_ansi_colors = [
      \ '#21222C', '#AF5F5F', '#87AF5F', '#87875F',
      \ '#875FFF', '#AF005F', '#00AF87', '#D0D0D0',
      \ '#585858', '#FF6E6E', '#69FF94', '#FFFFA5',
      \ '#D6ACFF', '#FF92DF', '#A4FFFF', '#FFFFFF',
      \ '#000000']
endif

" }}}2
" User Configuration: {{{2

if !exists('g:unsui_bold')
  let g:unsui_bold = 1
endif

if !exists('g:unsui_italic')
  let g:unsui_italic = 1
endif

if !exists('g:unsui_underline')
  let g:unsui_underline = 1
endif

if !exists('g:unsui_undercurl') && g:unsui_underline != 0
  let g:unsui_undercurl = 1
endif

if !exists('g:unsui_inverse')
  let g:unsui_inverse = 1
endif

if !exists('g:unsui_colorterm')
  let g:unsui_colorterm = 1
endif

"}}}2
" Script Helpers: {{{2

let s:attrs = {
      \ 'bold': g:unsui_bold == 1 ? 'bold' : 0,
      \ 'italic': g:unsui_italic == 1 ? 'italic' : 0,
      \ 'underline': g:unsui_underline == 1 ? 'underline' : 0,
      \ 'undercurl': g:unsui_undercurl == 1 ? 'undercurl' : 0,
      \ 'inverse': g:unsui_inverse == 1 ? 'inverse' : 0,
      \}

function! s:h(scope, fg, ...)
  let l:fg = copy(a:fg)
  let l:bg = get(a:, 1, ['NONE', 'NONE'])

  let l:attr_list = filter(get(a:, 2, ['NONE']), 'type(v:val) == 1')
  let l:attrs = len(l:attr_list) > 0 ? join(l:attr_list, ',') : 'NONE'

  let l:special = get(a:, 3, ['NONE', 'NONE'])
  if l:special[0] !=# 'NONE' && l:fg[0] ==# 'NONE' && !has('gui_running')
    let l:fg[0] = l:special[0]
    let l:fg[1] = l:special[1]
  endif

  let l:hl_string = [
        \ 'highlight', a:scope,
        \ 'guifg=' . l:fg[0], 'ctermfg=' . l:fg[1],
        \ 'guibg=' . l:bg[0], 'ctermbg=' . l:bg[1],
        \ 'gui=' . l:attrs, 'cterm=' . l:attrs,
        \ 'guisp=' . l:special[0],
        \]

  execute join(l:hl_string, ' ')
endfunction

function! s:Background()
  if g:unsui_colorterm || has('gui_running')
    return s:bg
  else
    return s:none
  endif
endfunction

"}}}2
" Unsui Highlight Groups: {{{2

call s:h('UnsuiBgLight', s:none, s:bglight)
call s:h('UnsuiBgLighter', s:none, s:bglighter)
call s:h('UnsuiBgDark', s:none, s:bgdark)
call s:h('UnsuiBgDarker', s:none, s:bgdarker)

call s:h('UnsuiFg', s:fg)
call s:h('UnsuiFgUnderline', s:fg, s:none, [s:attrs.underline])
call s:h('UnsuiFgBold', s:fg, s:none, [s:attrs.bold])

call s:h('UnsuiComment', s:comment)
call s:h('UnsuiCommentBold', s:comment, s:none, [s:attrs.bold])

call s:h('UnsuiSelection', s:none, s:selection)

call s:h('UnsuiSubtle', s:subtle)

call s:h('UnsuiCyan', s:cyan)
call s:h('UnsuiCyanItalic', s:cyan, s:none, [s:attrs.italic])

call s:h('UnsuiGreen', s:green)
call s:h('UnsuiGreenBold', s:green, s:none, [s:attrs.bold])
call s:h('UnsuiGreenItalic', s:green, s:none, [s:attrs.italic])
call s:h('UnsuiGreenItalicUnderline', s:green, s:none, [s:attrs.italic, s:attrs.underline])

call s:h('UnsuiOrange', s:orange)
call s:h('UnsuiOrangeBold', s:orange, s:none, [s:attrs.bold])
call s:h('UnsuiOrangeItalic', s:orange, s:none, [s:attrs.italic])
call s:h('UnsuiOrangeBoldItalic', s:orange, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('UnsuiOrangeInverse', s:bg, s:orange)

call s:h('UnsuiPink', s:pink)
call s:h('UnsuiPinkItalic', s:pink, s:none, [s:attrs.italic])

call s:h('UnsuiPurple', s:purple)
call s:h('UnsuiPurpleBold', s:purple, s:none, [s:attrs.bold])
call s:h('UnsuiPurpleItalic', s:purple, s:none, [s:attrs.italic])

call s:h('UnsuiRed', s:red)
call s:h('UnsuiRedInverse', s:fg, s:red)

call s:h('UnsuiYellow', s:yellow)
call s:h('UnsuiYellowItalic', s:yellow, s:none, [s:attrs.italic])

call s:h('UnsuiError', s:red, s:none, [], s:red)

call s:h('UnsuiErrorLine', s:none, s:none, [s:attrs.undercurl], s:red)
call s:h('UnsuiWarnLine', s:none, s:none, [s:attrs.undercurl], s:orange)
call s:h('UnsuiInfoLine', s:none, s:none, [s:attrs.undercurl], s:cyan)

call s:h('UnsuiTodo', s:cyan, s:none, [s:attrs.bold, s:attrs.inverse])
call s:h('UnsuiSearch', s:green, s:none, [s:attrs.inverse])
call s:h('UnsuiBoundary', s:comment, s:bgdark)
call s:h('UnsuiLink', s:cyan, s:none, [s:attrs.underline])

call s:h('UnsuiDiffChange', s:orange, s:none)
call s:h('UnsuiDiffText', s:bg, s:orange)
call s:h('UnsuiDiffDelete', s:red, s:bgdark)

" }}}2

" }}}
" User Interface: {{{

set background=dark

" Required as some plugins will overwrite
call s:h('Normal', s:fg, s:Background())
call s:h('StatusLine', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineNC', s:none, s:bglight)
call s:h('StatusLineTerm', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineTermNC', s:none, s:bglight)
call s:h('WildMenu', s:bg, s:purple, [s:attrs.bold])
call s:h('CursorLine', s:none, s:black)

hi! link ColorColumn  UnsuiBgDark
hi! link CursorColumn UnsuiBgDark
hi! link CursorLineNr UnsuiRed
hi! link DiffAdd      UnsuiGreen
hi! link DiffAdded    DiffAdd
hi! link DiffChange   UnsuiDiffChange
hi! link DiffDelete   UnsuiDiffDelete
hi! link DiffRemoved  DiffDelete
hi! link DiffText     UnsuiDiffText
hi! link Directory    UnsuiPurpleBold
hi! link ErrorMsg     UnsuiRedInverse
hi! link FoldColumn   UnsuiSubtle
hi! link Folded       UnsuiBoundary
hi! link IncSearch    UnsuiOrangeInverse
hi! link LineNr       UnsuiGreen
hi! link MoreMsg      UnsuiFgBold
hi! link NonText      UnsuiSubtle
hi! link Pmenu        UnsuiBgDark
hi! link PmenuSbar    UnsuiBgDark
hi! link PmenuSel     UnsuiSelection
hi! link PmenuThumb   UnsuiSelection
hi! link Question     UnsuiFgBold
hi! link Search       UnsuiSearch
hi! link SignColumn   UnsuiComment
hi! link TabLine      UnsuiBoundary
hi! link TabLineFill  UnsuiBgDarker
hi! link TabLineSel   Normal
hi! link Title        UnsuiGreenBold
hi! link VertSplit    UnsuiBoundary
hi! link Visual       UnsuiSelection
hi! link VisualNOS    Visual
hi! link WarningMsg   UnsuiOrangeInverse

" }}}
" Syntax: {{{

" Required as some plugins will overwrite
call s:h('MatchParen', s:green, s:none, [s:attrs.underline])
call s:h('Conceal', s:comment, s:bglight)

hi! link SpecialKey UnsuiRed

hi! link Comment UnsuiComment
hi! link Underlined UnsuiFgUnderline
hi! link Todo UnsuiTodo

hi! link Error UnsuiError
hi! link SpellBad UnsuiErrorLine
hi! link SpellLocal UnsuiWarnLine
hi! link SpellCap UnsuiInfoLine
hi! link SpellRare UnsuiInfoLine

hi! link Constant UnsuiPurple
hi! link String UnsuiYellow
hi! link Character UnsuiPink
hi! link Number Constant
hi! link Boolean Constant
hi! link Float Constant

hi! link Identifier UnsuiFg
hi! link Function UnsuiFg

hi! link Statement UnsuiRed
hi! link Conditional UnsuiGreen
hi! link Repeat UnsuiGreen
hi! link Label UnsuiPink
hi! link Operator UnsuiRed
hi! link Keyword UnsuiGreen
hi! link Exception UnsuiRed

hi! link PreProc UnsuiRed
hi! link Include UnsuiFg
hi! link Define UnsuiFg
hi! link Macro UnsuiGreen
hi! link PreCondit UnsuiPink
hi! link StorageClass UnsuiPink
hi! link Structure UnsuiFg
hi! link Typedef UnsuiFg

hi! link Type UnsuiFg

hi! link Delimiter UnsuiRed

hi! link Special UnsuiRed
hi! link SpecialComment UnsuiCyanItalic
hi! link Tag UnsuiCyan
hi! link helpHyperTextJump UnsuiLink
hi! link helpCommand UnsuiPurple
hi! link helpExample UnsuiGreen
hi! link helpBacktick Special

"}}}

" Lisp setting: {{{

hi! link lispKey UnsuiCyanItalic
hi! link lispFunc UnsuiGreen
hi! link lispDecl UnsuiGreen
hi! link lispVar UnsuiCyan
hi! link lispEscapeSpecial UnsuiPink
" }}}

" Python setting: {{{
hi! link pythonInclude UnsuiGreen
hi! link pythonBuiltin UnsuiRed
hi! link pythonDecorator UnsuiCyan
hi! link pythonDecoratorName UnsuiCyan
hi! link pythonOperator UnsuiRed
hi! link pythonStatement UnsuiGreen
hi! link pythonException UnsuiGreen
hi! link pythonExceptions UnsuiPink
" }}}

" C setting: {{{
hi! link cStructure UnsuiGreen
hi! link cType UnsuiCyan
hi! link cInclude UnsuiRed
hi! link cIncluded UnsuiRed
" }}}

" vim: fdm=marker ts=2 sts=2 sw=2:
