" Main
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set nowrap
set number
set colorcolumn=120
set timeoutlen=100
set hlsearch | nohl
set cursorline
set splitbelow
set splitright
set listchars=tab:~\ ,trail:·
"set listchars=tab:~\ ,trail:·,eol:↵

" Syntax highlight
syntax on
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
highlight Search cterm=NONE ctermbg=237

" Tab line
set showtabline=2
set tabline=%!TabLine()
function! TabLine()
  let s = ''
  let t = tabpagenr()
  for i in range(1, tabpagenr('$'))
    let buflist = tabpagebuflist(i)
    let winnr = tabpagewinnr(i)
    let s .= '%' . i . 'T'
    let s .= (i == t ? '%1*' : '%2*')
    let s .= ' '
    let s .= (i == t ? '%#TabNumSel#' : '%#TabNum#')
    let s .= i
    let s .= ' %*'
    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    if getbufvar(bufnr, 'buftype') == 'nofile'
"      " Not sure what case this is for
"      if bufname =~ '\/.'
"        let bufname = substitute(bufname, '.*\/\ze.', '', '')
"      endif
    else
      let bufname = fnamemodify(bufname, ':t')
    endif
    let s .= (bufname != '' ? bufname : '[No Name]')
    let s .= (i == t ? '%m' : '')
  endfor
  let s .= '%T%#TabLineFill#%='
  return s
endfunction

" File types
autocmd BufNewFile,BufRead *.html,*.handlebars set syntax=html sw=4 ts=4 noexpandtab
autocmd BufNewFile,BufRead *.java set syntax=java sw=4 ts=4 noexpandtab

" Java syntax
let java_highlight_functions="style"
let java_highlight_all=1
highlight link javaFuncDef Statement

