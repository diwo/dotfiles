" Main
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set number
set colorcolumn=120
set timeoutlen=100
set hlsearch
set cursorline

" Syntax highlight
syntax on
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" File types
autocmd BufNewFile,BufRead *.html,*.handlebars set syntax=html sw=4 ts=4 noexpandtab

" Java syntax
let java_highlight_functions="style"
let java_highlight_all=1
highlight link javaFuncDef Statement

" Keybinds
map <F6> :tabc<CR>
map <F7> :tabp<CR>
map <F8> :Texplore<CR>
map <F9> :tabn<CR>

