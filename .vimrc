set nocompatible              " be iMproved, required
filetype off                  " required

"" Specify a directory for plugins
"" - For Neovim: ~/.local/share/nvim/plugged
"" - Avoid using standard Vim directory names like 'plugin'
"call plug#begin('~/.vim/plugged')
"
"" Make sure you use single quotes
"
"" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
""Plug 'junegunn/vim-easy-align'
"
"" Any valid git URL is allowed
""Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
"" Multiple Plug commands can be written in a single line using | separators
""Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"
"" On-demand loading
""Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
""Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
"" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
""" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
""Plug 'fatih/vim-go', { 'tag': '*' }
"
""" Plugin options
""Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
""" Plugin outside ~/.vim/plugged with post-update hook
""Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
""" Unmanaged plugin (manually installed and updated)
""Plug '~/my-prototype-plugin'
"
"" Initialize plugin system
"call plug#end()

" Add prefs for invisible hars
set encoding=utf8
"set listchars=tab:>\ ,eol:¬
"set list
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
"" XML formatter
"function! DoFormatXML() range
"	" Save the file type
"	let l:origft = &ft
"
"	" Clean the file type
"	set ft=
"
"	" Add fake initial tag (so we can process multiple top-level elements)
"	exe ":let l:beforeFirstLine=" . a:firstline . "-1"
"	if l:beforeFirstLine < 0
"		let l:beforeFirstLine=0
"	endif
"	exe a:lastline . "put ='</PrettyXML>'"
"	exe l:beforeFirstLine . "put ='<PrettyXML>'"
"	exe ":let l:newLastLine=" . a:lastline . "+2"
"	if l:newLastLine > line('$')
"		let l:newLastLine=line('$')
"	endif
"
"	" Remove XML header
"	exe ":" . a:firstline . "," . a:lastline . "s/<\?xml\\_.*\?>\\_s*//e"
"
"	" Recalculate last line of the edited code
"	let l:newLastLine=search('</PrettyXML>')
"
"	" Execute external formatter
"	exe ":silent " . a:firstline . "," . l:newLastLine . "!xmllint --noblanks --format --recover -"
"
"	" Recalculate first and last lines of the edited code
"	let l:newFirstLine=search('<PrettyXML>')
"	let l:newLastLine=search('</PrettyXML>')
"	
"	" Get inner range
"	let l:innerFirstLine=l:newFirstLine+1
"	let l:innerLastLine=l:newLastLine-1
"
"	" Remove extra unnecessary indentation
"	exe ":silent " . l:innerFirstLine . "," . l:innerLastLine "s/^  //e"
"
"	" Remove fake tag
"	exe l:newLastLine . "d"
"	exe l:newFirstLine . "d"
"
"	" Put the cursor at the first line of the edited code
"	exe ":" . l:newFirstLine
"
"	" Restore the file type
"	exe "set ft=" . l:origft
"endfunction
"command! -range=% FormatXML <line1>,<line2>call DoFormatXML()

nmap <silent> <leader>x :%FormatXML<CR>
vmap <silent> <leader>x :FormatXML<CR>
"" function
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
