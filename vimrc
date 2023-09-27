set hlsearch
syntax on
imap kj <Esc>

set number
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
set smartindent
set tabstop=2     " Size of a hard tabstop (ts).
set shiftwidth=2  " Size of an indentation (sw).
set expandtab     " Always uses spaces instead of tab characters (et).
set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
set autoindent    " Copy indent from current line when starting a new line.
set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).
set formatoptions-=tc " prevent auto carriage return while typing

let b:fortran_fixed_source=0
set syntax=fortran

" move among buffers with CTRL
map <C-K> :tabnext<CR>
map <C-J> :tabprevious<CR>

" ctrl-N twice toggles :set number and :set nonumber
nmap <C-N><C-N> :set invnumber<CR>
