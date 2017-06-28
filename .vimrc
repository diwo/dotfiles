" Vim Bundles: https://github.com/VundleVim/Vundle.vim
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && vim +PluginInstall +qall
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'chrisbra/csv.vim'
Plugin 'jeetsukumaran/vim-indentwise'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fireplace'
Plugin 'guns/vim-clojure-highlight'
Plugin 'junegunn/rainbow_parentheses.vim'
Plugin 'terryma/vim-expand-region'
call vundle#end()
filetype plugin indent on

" General settings
set nowrap number ruler cursorline scrolloff=2 colorcolumn=120
set hlsearch nowrapscan
set splitbelow splitright
set list listchars=tab:~\ ,trail:·
set foldmethod=indent foldlevelstart=99 nofoldenable
set backspace=indent,start,eol
set timeoutlen=8000
set wildignore=*~,*.swp,*/node_modules/*,*/bower_components/*,*/target/*
set wildmenu wildmode=longest,list,full

let &grepprg='grep -nr $* /dev/null'
autocmd QuickFixCmdPost [^l]* cwindow
autocmd QuickFixCmdPost l* lwindow

" FileType specific settings
set tabstop=2 shiftwidth=2 expandtab autoindent
autocmd FileType html,css,xml,java,groovy setlocal tabstop=4 shiftwidth=4 noexpandtab
autocmd FileType javascript setlocal foldmethod=syntax
autocmd FileType markdown setlocal colorcolumn=80 textwidth=80
autocmd FileType csv autocmd CursorMoved <buffer> HiColumn
autocmd FileType clojure,lisp,scheme RainbowParentheses
autocmd OptionSet syntax
  \ if &syntax=~'\v^(clojure|lisp|scheme)$' |
  \   RainbowParentheses |
  \ endif

autocmd BufNewFile,BufRead *.handlebars,*.hbs setlocal filetype=html

" User commands
com! JSON execute '%!jq --indent 2 .' | retab! | setlocal syntax=json
com! XML execute '%!xmllint --format --recover -' | retab! | setlocal syntax=xml

" Key mappings
let mapleader = "\<Space>"
map z\| zszH
map [[ [{
map ]] ]}

" terryma/vim-expand-region
let g:expand_region_text_objects = {
  \ 'i(' : 1,
  \ 'a(' : 1,
  \ 'i[' : 1,
  \ 'a[' : 1,
  \ 'i{' : 1,
  \ 'a{' : 1,
  \ 'i<' : 1,
  \ 'a<' : 1,
  \ 'it' : 1,
  \ 'at' : 1,
  \ 'i"' : 1,
  \ 'a"' : 1,
  \ 'i''' : 1,
  \ 'a''' : 1,
  \ 'ip' : 1
  \}

" junegunn/rainbow_parentheses.vim
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

" fugitive mappings
nmap <Leader>gs :Gstatus<CR>

" NERDTree mappings and options
nmap <Leader>nt :NERDTreeToggle<CR>
nmap <Leader>nf :NERDTreeFind<CR>
nmap <Leader>nb :Bookmark<CR>
let NERDTreeMapJumpNextSibling='<C-N>'
let NERDTreeMapJumpPrevSibling='<C-P>'
let NERDTreeMinimalUI=1
let NERDTreeQuitOnOpen=0
let NERDTreeIgnore=[
      \ '\~$[[file]]',
      \ '.swp$[[file]]',
      \ '^node_modules$[[dir]]',
      \ '^bower_components$[[dir]]',
      \ '^target$[[dir]]'
      \ ]

" bufexplorer config
let g:bufExplorerShowRelativePath=1

" Syntax highlight
syntax on
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
highlight Search cterm=NONE ctermbg=237

" Java syntax
let java_highlight_functions="style"
let java_highlight_all=1
highlight link javaFuncDef Statement

" Clojure
let g:clojure_align_multiline_strings = 1

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
