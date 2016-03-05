
" Add prefs for invisible hars
set encoding=utf8
"set listchars=tab:>\ ,eol:¬
set list
set ruler
set autoindent
set smartindent
set showmatch
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
syntax on
set background=dark
set hlsearch
set number
set scrolloff=5
" Random colors
highlight NonText ctermfg=darkgray
highlight SpecialKey ctermfg=darkgray

" Fix for running VIM from with screen
if match($TERM, "screen")!=-1
	set term=xterm
endif
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

"set formatoptions+=r

" highlight columns with >80 lines
" highlight OverLength cterm=underline
"match OverLength /\%81v.\+/
autocmd WinEnter * if !exists('w:created') | :match OverLength /\%81v.\+/

" C++11 syntax fix
let c_no_curly_error=1

hi ExtraWhitespace ctermbg=red
au BufWinEnter * match ExtraWhitespace /^\s* \s*\|\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/

highlight OverLength cterm=underline
"match OverLength /\%81v.\+/

set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2


colo elflord

" function
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
