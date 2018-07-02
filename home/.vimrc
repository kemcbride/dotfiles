call plug#begin()
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-obsession'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-signify'
Plug 'mtth/scratch.vim'
Plug 'junegunn/vim-emoji'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'leafgarland/typescript-vim'
Plug 'rking/ag.vim' | Plug 'Chun-Yang/vim-action-ag' " :Ag command | gag action
Plug 'flxf/uCpp.vim'
Plug 'sudar/vim-arduino-syntax'
" To learn:
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'
" Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-abolish'
" Plug 'tpope/vim-flagship'

" To use eventually some day:
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-journal'
Plug 'tpope/vim-speeddating'
" Plug 'tpope/vim-projectionist' " Requires configuration, cool for 'projects'

" Things that aren't even task-y:
Plug 'zenorocha/dracula-theme', {'rtp': 'vim'}
Plug 'dracula/vim', {'as': 'dracula'}
" Need to copy the sokoban levels to ~/.vim/plugin/level{x}.sok
Plug 'vim-scripts/sokoban.vim', {'do': 'echo dog'}
call plug#end()

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
" for dracula theme coloring...
highlight CursorLine term=underline cterm=underline
highlight Visual guibg=#6272a4

set number
set ruler
set cursorline
set splitright
set splitbelow
set scrolloff=5
set clipboard=unnamedplus " uses system clipboard - so cool & good <3

" settings for vim-LaTeX
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex' " apparently the default tex is plain tex, this is latex

" get rid of delay??? comment timeoutlen? only need ttimeout?
set ttimeoutlen=100 " timeoutlen=100
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

" DYK??? :x means :wq which means "Exit"
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

"syntastic settings:
let g:syntastic_c_checkers = ['splint']
let g:syntastic_cpp_compiler_options = ' -std=c++11'

"signify settings - default to 'off'
let g:signify_disable_by_default = 1

" sokoban settings - point to where the levels are.
let g:SokobanLevelDirectory = '/home/kelly/.vim/plugged/sokoban.vim/'

"lightline settings - lots & lots...
" Notably: colorscheme seems to have no effect...
let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ 'active' : {
	\	'right': [ [ 'syntastic', 'lineinfo' ] ],
	\ },
	\ 'component': {
	\	 'readonly': '%{&readonly?"'.emoji#for('lock').'":""}',
	\ },
	\ 'component_expand': {
	\   'syntastic': 'SyntasticStatuslineFlag',
	\ },
	\ 'component_type': {
	\   'syntastic': 'error',
	\ },
	\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
	\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
	\ }

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

set laststatus=2
set noshowmode
set nowrap

syntax on
filetype indent plugin on
