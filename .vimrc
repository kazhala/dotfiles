set encoding=UTF-8
set t_Co=256
syntax on
set hidden
set nowrap
set scrolloff=5
set matchpairs+=<:>
set autoread
set history=1000
set backspace=indent,eol,start
set splitright
set number
set relativenumber
set autoindent
set nostartofline
set noerrorbells
set novisualbell
set ignorecase
set smartcase
set incsearch
set hlsearch
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
set textwidth=0
set formatoptions-=t
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"

augroup FormatFile
  autocmd!
  autocmd BufEnter vifmrc,*.vifm set filetype=vim
  autocmd BufEnter * set fo-=c fo-=r fo-=o
  autocmd BufEnter * setlocal nonumber norelativenumber
  autocmd BufEnter *.py set ai ts=4 sw=4 sts=4 et
  autocmd BufEnter *.md setlocal conceallevel=0
augroup end

command! CtrlSemicolumn normal maA;<Esc>`a
command! CtrlColumn normal maA,<Esc>`a

map Y y$
vmap Y "*y
nnoremap Q q
nnoremap <C-]> <C-^>
nnoremap <Up> <C-w>3+
nnoremap <Down> <C-w>3-
nnoremap <right> <C-w>3>
nnoremap <left> <C-w>3<
noremap gV `[v`]
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
nnoremap <leader>q :cclose<CR>
nnoremap <leader>j :cn<CR>
nnoremap <leader>k :cp<CR>
nnoremap <leader>rs *Ncgn
nnoremap <leader>n :noh<CR>
nnoremap <silent> <leader>tc :bp\|bd #<CR>
nnoremap <silent> <S-l> :bn<CR>
nnoremap <silent> <S-h> :bp<CR>
nnoremap <leader>tt :ls<CR>:b<space>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>ps :setlocal spell! spelllang=en_au<CR>
nnoremap <leader>pp :set paste!<CR>
nnoremap <leader>pu :setlocal nobuflisted<CR>
