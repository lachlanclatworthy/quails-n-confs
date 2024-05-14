" Don't flash the terminal
set visualbell
set t_vb=

set number

" Indentation
filetype plugin indent on
set tabstop=4
set shiftwidth=4 " indent by '>'
set expandtab    " tabs to spaces

" Whitespace Handling
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/
