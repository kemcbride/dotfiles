call plug#begin()
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-speeddating'
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale' 
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-signify'
Plug 'junegunn/vim-emoji'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'sudar/vim-arduino-syntax'
" To learn:
Plug 'mattn/webapi-vim'
Plug 'mattn/vim-gist'
Plug 'junegunn/vim-easy-align'
Plug 'Blackrush/vim-gocode'

" Things that aren't even task-y:
Plug 'zenorocha/dracula-theme', {'rtp': 'vim'}
Plug 'dracula/vim', {'as': 'dracula'}
call plug#end()

" i believe this is saving me wrt. work + syntastic + flake8
let $TMPDIR = $HOME."/tmp"
" copypasta utf-8 support ???
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

set t_Co=256

color dracula
highlight CursorLine term=underline cterm=underline
highlight Visual guibg=#6272a4

set number
set ruler
set cursorline
set splitright
set splitbelow
set scrolloff=5
set clipboard=unnamedplus " uses system clipboard - so cool & good <3

set ttimeoutlen=100
" some file types
au BufNewFile,BufRead *.sls set filetype=yaml
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.template set filetype=json

" add r to the commenting/format options
au FileType javascript setl sw=4 ts=4 sts=4 expandtab
au FileType css setl sw=4 ts=4 sts=4 expandtab
au FileType latex setl sw=2 ts=2 sts=2 expandtab fo=tcroq

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" set list

" from internet person to warn about 80 char columns
highlight ColorColumn ctermbg=233 guibg=#1a1b13
let &colorcolumn=join(range(81,82),",")

let mapleader=" "

map <Leader>e :tabe 

map <Leader>o :bn<CR>
map <Leader>p :bp<CR>
map <Leader>a :edit 
map <Leader>d :bd<CR>
map <Leader>c :close<CR>
map <Leader>m :make 
" Add quickfix shortcuts???

map <Leader>x :x<CR>
map <Leader>w :w<CR>

map <Leader>s :split 
map <Leader>v :vsplit 

map :WQ :wq
map :W :w
map :Q :q
map :Wq :wq
map :wQ :wq
map :Bd :close
map :bD :close

"signify settings - default to 'off'
" let g:signify_disable_by_default = 1
"
let g:ale_linters = {
  \ 'python': ['flake8'],
  \ }
let g:ale_fixers = {
  \ 'python': ['black'],
  \ }
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

"lightline settings - lots & lots...
" Notably: colorscheme seems to have no effect...
let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ 'active' : {
	\	'right': [ [ 'lineinfo' ] ],
	\ },
	\ 'component': {
	\	 'readonly': '%{&readonly?"'.emoji#for('lock').'":""}',
	\ },
	\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
	\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
	\ }

augroup filetype_cpp
	autocmd FileType cpp set ts=2 sts=2 sw=2 expandtab ai
	autocmd FileType cpp let g:ale_completion_enabled = 0
	let g:ale_linters = {'cpp': ['clang']}
	let g:ale_cpp_clang_executable = 'clang++'
	let g:ale_cpp_clang_options = '-std=c++17 -Wall'
	let g:ale_cpp_clangcheck_executable = 'clang-check'
	let g:ale_fix_on_save = 1
augroup END

augroup au_go_group
  autocmd!
  autocmd FileType go set noexpandtab
  autocmd FileType go set tabstop=2 shiftwidth=2 softtabstop=2
augroup END

set laststatus=2
set noshowmode
set modeline
set modelines=5 " i guess i can allow  up to 5 lines of modeline lol
set nowrap

syntax on
filetype indent plugin on
