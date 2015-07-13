syntax on
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set number
set timeoutlen=100
set hlsearch
set cursorline

highlight Search ctermfg=black ctermbg=gray
highlight CursorLine cterm=bold ctermbg=none
highlight MatchParen ctermbg=darkblue

autocmd BufNewFile,BufRead *.html,*.handlebars set syntax=html sw=4 ts=4 noexpandtab

map <F6> :tabc<CR>
map <F7> :Texplore<CR>
map <F8> :tabp<CR>
map <F9> :tabn<CR>

