set rnu
syntax on
set clipboard=unnamed
set nocompatible
set encoding=UTF-8
set foldmethod=syntax
filetype off

call plug#begin()

Plug 'junegunn/vim-plug'
Plug 'vim-airline/vim-airline'
Plug 'yggdroot/indentline'
Plug 'simeji/winresizer'
Plug 'scrooloose/nerdtree'
Plug 'PhilRunninger/nerdtree-visual-selection'
" Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'jnurmine/Zenburn'
Plug 'sainnhe/everforest'

call plug#end()

filetype plugin indent on

if (has("termguicolors"))
 set termguicolors
endif

set background=dark

let g:everforest_background = 'soft'
let g:everforest_better_performance = 1

colorscheme everforest
" hi Normal guibg=NONE ctermbg=NONE

set splitbelow
set splitright

"split navigations
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

"code folding
nnoremap zz za

set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab
set autoindent
set encoding=utf-8
set foldnestmax=2

autocmd FileType typescriptreact set tabstop=2 softtabstop=4 shiftwidth=2 expandtab
autocmd FileType python set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

nnoremap <C-T> :NERDTreeToggle<CR>

" Start NERDTree. If a file is specified, move the cursor to its window
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | NERDTreeToggle | endif

" Open the existing NERDTree on each new tab
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif
