" Vim Bundles: https://github.com/VundleVim/Vundle.vim
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tomtom/tcomment_vim'
call vundle#end()
filetype plugin indent on

" Display
set nowrap number cursorline colorcolumn=120
set hlsearch
set splitbelow splitright
set list listchars=tab:~\ ,trail:·
set foldmethod=indent nofoldenable

" Misc
set backspace=indent,start,eol
set timeoutlen=8000
set wildignore=*~,*.swp,*/node_modules/*,*/bower_components/*,*/target/*

" Indentation and file types
set tabstop=2 shiftwidth=2 autoindent expandtab
autocmd BufNewFile,BufRead *.handlebars set filetype=html
autocmd FileType html,java,css,xml setlocal tabstop=4 shiftwidth=4 noexpandtab

" Key mapping
let mapleader = "\<Space>"
nnoremap gy :tabp<CR>
vnoremap <Leader>fy "fy:redir! > /tmp/yank \| echo @f \| redir end<CR>
nnoremap <Leader>fp :r /tmp/yank<CR>

" NERDTree mappings and options
nnoremap <Leader>nt :NERDTreeToggle<CR>
nnoremap <Leader>nf :NERDTreeFind<CR>
nnoremap <Leader>nb :Bookmark<CR>
let NERDTreeMapJumpNextSibling='<C-N>'
let NERDTreeMapJumpPrevSibling='<C-P>'
let NERDTreeMinimalUI=1
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
