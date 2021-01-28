" -- INIT ----------------------------------------------------------------------

let g:polyglot_disabled = ['sh']

" -- PLUGINS -------------------------------------------------------------------

call plug#begin(stdpath('data') . '/plugged')

if $OS_DISTRO == 'MACOS'
  Plug '/usr/local/opt/fzf'
elseif $OS_DISTRO == 'UBUNTU'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'ojroques/vim-oscyank'
endif

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-fugitive', { 'on': [ 'G', 'Gwrite', 'Gread' ] }
Plug 'bkad/CamelCaseMotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'unblevable/quick-scope'
Plug 'alvan/vim-closetag', { 'for': [ 'html', 'javascript' ] }
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-commentary'
Plug 'bfredl/nvim-miniyank'
Plug 'machakann/vim-highlightedyank'
Plug 'glepnir/dashboard-nvim'
Plug 'Asheq/close-buffers.vim', { 'on': 'Bdelete' }
Plug 'psf/black', { 'branch': 'stable', 'on': 'Black' }
Plug 'brentyi/isort.vim', { 'on': 'Isort' }
Plug 'vimwiki/vimwiki', { 'on': [ 'VimwikiIndex', 'VimwikiMakeDiaryNote', 'VimwikiDiaryIndex' ] }
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'joshdick/onedark.vim'

call plug#end()

" -- GENERAL -------------------------------------------------------------------

set encoding=UTF-8
set t_Co=256
set termguicolors
set cursorline
syntax on
set hidden
set nowrap
set scrolloff=5
set matchpairs+=<:>
set autoread
set history=1000
set showtabline=2
set noshowmode
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
set inccommand=split
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
set textwidth=0
set formatoptions-=t

augroup FormatFile
  autocmd!
  autocmd BufEnter vifmrc,*.vifm set filetype=vim
  autocmd BufEnter * set fo-=c fo-=r fo-=o
  autocmd TermOpen * setlocal nonumber norelativenumber
  autocmd BufEnter *.py set ai ts=4 sw=4 sts=4 et
  autocmd BufWritePre *.py execute ':Black'
  autocmd BufEnter *.md setlocal conceallevel=0
augroup end

map Y y$
vmap Y "*y
nnoremap Q q
nnoremap <C-]> <C-^>
nnoremap <leader>n :noh<CR>
nnoremap <leader>ps :setlocal spell! spelllang=en_au<CR>
nnoremap <leader>pu :setlocal nobuflisted<CR>
nnoremap <leader>pp :set paste!<CR>

" reselect pasted text
noremap gV `[v`]

" switch buffer
nnoremap <silent> <S-l> :bn<CR>
nnoremap <silent> <S-h> :bp<CR>

" move selected text up down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" scroll 3 times faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" quickfix list navigation
nnoremap <leader>q :cclose<CR>
nnoremap <leader>j :cn<CR>
nnoremap <leader>k :cp<CR>

" use arrow to resize vim split
nnoremap <Up> <C-w>3+
nnoremap <Down> <C-w>3-
nnoremap <right> <C-w>3>
nnoremap <left> <C-w>3<

" -- COLOR ---------------------------------------------------------------------

let g:onedark_hide_endofbuffer = 1
colorscheme onedark

" overwrite highlight group
hi CocGitChange gui=NONE guifg=#61afef
hi CocGitAdd gui=NONE guifg=#98c379
hi CocGitDelete gui=NONE guifg=#e06c75
hi CocErrorHighlight gui=bold guifg=#e06c75
hi CocWarningHighlight gui=NONE guifg=#e5c07b
hi DiffChange gui=NONE guifg=#2b2c34 guibg=#e5c07b
hi DiffText gui=NONE guifg=#2b2c34 guibg=#de9712
hi Floaterm guibg=#282c34
hi FloatermBorder guibg=NONE guifg=#61afef
hi QuickScopePrimary guifg=#afff5f gui=underline
hi QuickScopeSecondary guifg=#5fffff gui=underline

" -- CAMELCASEMOTION -----------------------------------------------------------

let g:camelcasemotion_key = '<space>'

" -- VIM-TMUX-NAVIGATOR --------------------------------------------------------

let g:tmux_navigator_disable_when_zoomed = 1

" -- VIM-HIGHLIGHTEDYANK -------------------------------------------------------

let g:highlightedyank_highlight_duration = 300

" -- NETRW ---------------------------------------------------------------------

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" -- VIM-CLOSETAG -------------------------------------------------------------

let g:closetag_filenames = '*.html,*.js'
let g:closetag_emptyTags_caseSensitive = 1

" -- VIM-OSCYANK ---------------------------------------------------------------

if $OS_DISTRO == 'UBUNTU'
  augroup OSCYANK
    autocmd!
    autocmd TextYankPost *
      \ if v:event.operator is 'y' && v:event.regname is '*' | call YankOSC52(getreg('*')) | endif
  augroup end
endif

" -- NVIM-MINIYANK -------------------------------------------------------------

let g:miniyank_maxitems = 100

" clear miniyank list
function! s:ClearAllYanks() abort
python3 << EOF
from pathlib import Path
yank_file = Path(vim.funcs.stdpath("cache")).resolve().joinpath("miniyank.mpack")
if yank_file.is_file():
  with yank_file.open("r+") as file:
    file.truncate(0)
  print("Yank cleared")
else:
  print("Yank file not found")
EOF
endfunction

map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <leader>yp <Plug>(miniyank-cycle)
map <leader>yn <Plug>(miniyank-cycleback)
nnoremap <leader>yc :call <SID>ClearAllYanks()<CR>

" -- VIM-FUGITIVE -------------------------------------------------------------

nnoremap <leader>gs :G<CR>3j
nnoremap <leader>gq :G<CR>:q<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gh :diffget //2<CR>
nnoremap <leader>gl :diffget //3<CR>
nnoremap <leader>gp :Gpush<CR>

" -- CLOSE-BUFFERS -------------------------------------------------------------

nnoremap <silent> <leader>th :Bdelete hidden<CR>
nnoremap <silent> <leader>ta :Bdelete all<CR><C-w>h
nnoremap <silent> <leader>tu :Bdelete! nameless<CR>
nnoremap <silent> <leader>ts :BD<CR>
nnoremap <silent> <leader>to :Bdelete other<CR>
nnoremap <silent> <leader>tc :bp\|bd #<CR>

" -- QUICKSCOPE ----------------------------------------------------------------

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_buftype_blacklist = ['terminal', 'nofile', 'floaterm', 'fzf']
let g:qs_lazy_highlight = 1

" -- INDENTLINE ----------------------------------------------------------------

let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_fileTypeExclude = ['fzf', 'floaterm', 'vimwiki', 'markdown']
let g:indentLine_bufNameExclude = ["term:.*"]

" -- VIMWIKI -------------------------------------------------------------------

let g:vimwiki_table_mappings = 0
let g:vimwiki_list = [
  \ { 'path': '~/Documents/vimwiki/', 'syntax': 'markdown', 'ext': '.md' },
  \ { 'path': '~/Documents/vimwiki/docker', 'syntax': 'markdown', 'ext': '.md'},
  \ { 'path': '~/Documents/vimwiki/uni', 'syntax': 'markdown', 'ext': '.md'},
  \ { 'path': '~/Documents/vimwiki/database', 'syntax': 'markdown', 'ext': '.md'},
  \ { 'path': '~/Documents/vimwiki/python', 'syntax': 'markdown', 'ext': '.md'},
  \ ]

augroup WikiTemplate
  autocmd!
  au BufNewFile ~/Documents/vimwiki/diary/*.md :silent 0r !diarytemplate '%'
augroup end

" -- VIM-SANDWICH --------------------------------------------------------------

let g:sandwich_no_tex_ftplugin = 1
let g:sandwich_no_vim_ftplugin = 1
let g:sandwich_no_initex_ftplugin = 1
let g:sandwich_no_julia_ftplugin = 1
let g:sandwich_no_plaintex_ftplugin = 1

nmap s <Nop>
xmap s <Nop>

" -- FZF -----------------------------------------------------------------------

let g:fzf_layout = { 'window': { 'width': 0.86, 'height': 0.80 } }
let g:fzf_history_dir = '~/.local/share/fzf-history'

" list buffers for BD
function! s:list_buffers() abort
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

" delete selected buffers
function! s:delete_buffers(lines) abort
  execute 'bwipeout!' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

" list yanks for YanksAfter
function! s:list_miniyanks() abort
  function! KeyValue(key, val)
    let line = join(a:val[0], '\n')
    if (a:val[1] ==# 'V')
      let line = '\n'.line
    endif
    return a:key.' '.line
  endfunction
  return map(miniyank#read(), function('KeyValue'))
endfunction

" past selected yank
function! s:put_miniyanks(opt, line) abort
  let key = substitute(a:line, ' .*', '', '')
  if !empty(a:line)
    let yanks = miniyank#read()[key]
    call miniyank#drop(yanks, a:opt)
  endif
endfunction

" custom function to display all floating terminal
function! s:floaterm_list() abort
  let l:bufs = floaterm#buflist#gather()
  if len(bufs) < 1
    return []
  endif
  let l:termlist = []
  for bufnr in bufs
    let l:bufinfo = getbufinfo(bufnr)[0]
    let l:name = bufinfo['name']
    let l:title = getbufvar(bufnr, 'term_title')
    let l:line = string(bufnr) . '  ' . name . '  ' . title
    call add(termlist, line)
  endfor
  return termlist
endfunction

function! s:open_floaterm(line) abort
python3 << EOF
selected_term = vim.eval("a:line")
term_buffnr = selected_term.split(" ")[0]
vim.command("let l:term_buffnr = '%s'" % term_buffnr)
EOF
  call floaterm#terminal#open_existing(str2nr(l:term_buffnr))
endfunction

" switch floaterm
command! FloatermList call fzf#run(fzf#wrap({
\ 'source':  s:floaterm_list(),
\ 'sink': { line -> s:open_floaterm(line) },
\ 'options': '--no-sort --no-multi --prompt="Floaterm> "',
\ }))

" delete buffer
command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': [ '--multi', '--prompt=BD> ', '--reverse', '--bind', 'ctrl-a:select-all+accept', '--preview', 'echo {} | awk -F "\"" "{gsub(/^[ \t]+line/,\":\", \$3); \$1=\"\"; gsub(/[ ]:[ ]/, \":\", \$0); print \$0}" | xargs -I __ "$XDG_DATA_HOME/nvim/plugged/fzf.vim/bin/preview.sh" __' ]
\ }))

" dotbare edit
command! Dots call fzf#run(fzf#wrap({
  \ 'source': 'dotbare ls-files --full-name --directory "${DOTBARE_TREE}" | awk -v home="${DOTBARE_TREE}/" "{print home \$0}"',
  \ 'sink': 'e',
  \ 'options': [ '--multi', '--prompt=Dots> ', '--preview', 'cat {}' ]
  \ }))

" list yanks
command! YanksAfter call fzf#run(fzf#wrap({
\ 'source':  s:list_miniyanks(),
\ 'sink': { line -> s:put_miniyanks('p', line) },
\ 'options': '--no-sort --prompt="Yanks> "',
\ }))

" rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

nnoremap <C-p> :Files<CR>
nnoremap <C-m> :Buffers<CR>
nnoremap <C-g> :Rg<CR>
nnoremap <leader>ff :GFiles<CR>
nnoremap <leader>fg :GFiles?<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fy :YanksAfter<CR>
nnoremap <leader>fl :FloatermList<CR>

" -- FLOATERM ------------------------------------------------------------------

let g:floaterm_keymap_toggle = '<C-f>'
let g:floaterm_keymap_new = '<leader>vv'
let g:floaterm_keymap_prev = '<leader>vp'
let g:floaterm_keymap_next = '<leader>vn'
let g:floaterm_position = 'center'
let g:floaterm_width = 0.85
let g:floaterm_height = 0.8
let g:floaterm_autoclose=2

augroup TerminalHide
  autocmd!
  autocmd FileType floaterm setlocal nobuflisted
augroup end

inoremap <silent> <C-f> <C-o>:FloatermToggle<CR>
nnoremap <C-b> :FloatermNew vifm<CR>

" -- DASHBOARD -----------------------------------------------------------------

let g:dashboard_custom_header = [
\"",
\"",
\"",
\"",
\"",
\"       ▄▄        ▄▄ ",
\"     ▄████       ███▄                                            ▄▄ ",
\"   ▄ ▀█████▄     █████                                           ▀▀ ",
\"   ▌ ▀▄██████    █████     ▌ ▄▀▀▄▄   ▄▄▀▀ ▄    ▄ ▀▀▄▄ ▓█▄    ▄█▌▐██ ▐██▄███▄▄▓███▄ ",
\"   ▌    ▀█████▄  █████     ▌     ▐  ▓      █ ▄▀     ▐▌ ██▄  ▄█▌ ▐██ ▐██   ▐██   ▓██ ",
\"   ▌   ▐  ██████ █████     ▌     ▐▌ █▀▀▀▀▀▀▀ █       █  ██ ▐██  ▐██ ▐██   ▐██   ▐██ ",
\"   ▌   ▐   ▀█████▄████     ▌     ▐▌ █        ▀▄      █   ████   ▐██ ▐██   ▐██   ▐██ ",
\"   ▌   ▐    ▀█████▄▀██     ▌     ▐   ▀▀▄▄▄▀▀   ▀▄▄▄▀▀    ▐▀▀    ▐▀▀ ▐▀▀   ▐▀▀   ▐▀▀ ",
\"   ▀   ▐      ▀█████ █ ",
\"     ▀▄▐       ▀████ ",
\"       ▀         ▀ ",
\"",
\"                                                             version: ". matchstr(execute('version'), 'NVIM v\zs[^\n]*') ."",
\"",
\"",
\"",
\"",
\"",
\ ]

function! s:close() abort
  if len(filter(range(0, bufnr('$')), 'buflisted(v:val)')) - &buflisted
    if bufloaded(bufnr('#')) && bufnr('#') != bufnr('%')
      buffer #
    else
      bnext
    endif
  else
    quit
  endif
endfunction

let g:dashboard_custom_section={
  \ '1': {
    \ 'description': ['﬘ Empty Buffer                              [e]'],
    \ 'command': ':enew'
    \ },
  \ '2': {
    \ 'description': [' Dotfiles                                  [i]'],
    \ 'command': ':Dots'
    \ },
  \ '3': {
    \ 'description': [' FileTypes                                 [t]'],
    \ 'command': ":enew \| Filetypes"
    \ },
  \ '4': {
    \ 'description': [' Mappings                                  [m]'],
    \ 'command': ':Maps'
    \ },
  \ '5': {
    \ 'description': ['ﬤ Help Tags                                 [h]'],
    \ 'command': ':Helptags'
    \ },
  \ '6': {
    \ 'description': [' Exit                                      [q]'],
    \ 'command': function('s:close')
    \ },
  \ }

augroup DashboardMaps
  autocmd!
  au FileType dashboard nnoremap <buffer> e :enew<CR>
  au FileType dashboard nnoremap <buffer> i :Dots<CR>
  au FileType dashboard nnoremap <buffer> m :Maps<CR>
  au FileType dashboard nnoremap <buffer> h :Helptags<CR>
  au FileType dashboard nnoremap <buffer> t :enew <bar> Filetypes<CR>
  au FileType dashboard nnoremap <buffer> q :call <SID>close()<CR>
augroup end

nnoremap <leader>a :Dashboard<CR>

" -- LIGHTLINE-BUFFERLINE ------------------------------------------------------

" jump mapping
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

" kill mapping
nmap <space>1 <Plug>lightline#bufferline#delete(1)
nmap <space>2 <Plug>lightline#bufferline#delete(2)
nmap <space>3 <Plug>lightline#bufferline#delete(3)
nmap <space>4 <Plug>lightline#bufferline#delete(4)
nmap <space>5 <Plug>lightline#bufferline#delete(5)
nmap <space>6 <Plug>lightline#bufferline#delete(6)
nmap <space>7 <Plug>lightline#bufferline#delete(7)
nmap <space>8 <Plug>lightline#bufferline#delete(8)
nmap <space>9 <Plug>lightline#bufferline#delete(9)
nmap <space>0 <Plug>lightline#bufferline#delete(10)

" -- LIGHTLINE -----------------------------------------------------------------

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['gitbranch', 'filename', 'readonly'],
  \     ['cocstatus']
  \   ],
  \   'right':[
  \     ['lineinfo'],
  \     ['cocdiagnostic', 'filetype'],
  \     ['gitstatus']
  \   ],
  \ },
  \ 'inactive': {
  \   'left': [
  \     ['gitbranch', 'filename'],
  \   ],
  \   'right':[
  \     ['lineinfo'],
  \     ['filetype']
  \   ],
  \ },
  \ 'tabline': {
  \   'left': [
  \     ['buffers']
  \   ],
  \ 'right': [
  \     ['vimcons'],
  \   ],
  \ },
  \ 'component': {
  \   'vimcons': '',
  \ },
  \ 'component_function': {
  \   'cocstatus': 'LightlineCocStatus',
  \   'cocdiagnostic': 'LightlineCocDiagnostic',
  \   'gitstatus': 'LightlineGitStatus',
  \   'gitbranch': 'LightlineGitBranch',
  \   'lineinfo': 'LightlineLineInfo',
  \   'filename': 'LightlineFilename',
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers',
  \   'readonly': 'LightLineReadonly',
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel',
  \   'readonly': 'warning',
  \ },
  \ 'mode_map': {'c': 'NORMAL'},
  \ }

" coc status information
function! LightlineCocStatus() abort
  if (winwidth(0) < 40)
    return ''
  endif
  let msg = get(g:, 'coc_status', '')
  return trim(msg)
endfunction

" coc lint information
function! LightlineCocDiagnostic() abort
  if (winwidth(0) < 40)
    return ''
  endif
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return ' ' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, ' ' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, ' ' . info['warning'])
  endif
  return join(msgs, ' ') == '' ? ' ' : join(msgs, ' ')
endfunction

" display lock symbol for readonly file
function! LightLineReadonly() abort
  if (winwidth(0) > 40)
    return &readonly ? '' : ''
  endif
  return ''
endfunction

" display branch detail
function! LightlineGitBranch() abort
  if (winwidth(0) > 40)
    let branch = get(g:, 'coc_git_status', '')
    return branch
  endif
  return ''
endfunction

" display file name with edit check
function! LightlineFilename() abort
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return winwidth(0) > 40 ? filename . modified : ''
endfunction

" display coc git modify detail +1 ~1 -1 etc
function! LightlineGitStatus() abort
  let status = get(b:, 'coc_git_status', '')
  return winwidth(0) > 120 ? status : ''
endfunction

" line no indicator symbols
let g:line_no_indicator_chars = ['⎺', '⎻', '─', '⎼', '⎽']

" display lineNoIndicator (from drzel/vim-line-no-indicator)
function! LineNoIndicator() abort
  let l:current_line = line('.') - 1
  let l:total_lines = line('$') - 1
  if l:current_line == 0
    let l:index = 0
  elseif l:current_line == l:total_lines
    let l:index = -1
  else
    let l:line_no_fraction = floor(l:current_line) / floor(l:total_lines)
    let l:index = float2nr(l:line_no_fraction * len(g:line_no_indicator_chars))
  endif
  return g:line_no_indicator_chars[l:index]
endfunction

" change the display of line info
function! LightlineLineInfo() abort
  return winwidth(0) > 40 ? LineNoIndicator() . ' ' . line('.') . '/' . line('$') : ''
endfunction

" use powerline symbols
let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
	\   'left': '', 'right': ''
  \}

" lightline bufferline config
let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline#bufferline#number_map = {
\ 0: '₀', 1: '₁', 2: '₂', 3: '₃', 4: '₄',
\ 5: '₅', 6: '₆', 7: '₇', 8: '₈', 9: '₉'}
let g:lightline#bufferline#unicode_symbols = 1

" overwrite the lightline onedark theme
let s:palette = g:lightline#colorscheme#onedark#palette
let s:palette.inactive.middle = [ [ '#282c34', '#282c34', 235, 113, 'NONE' ] ]
unlet s:palette

" -- COC -----------------------------------------------------------------------

set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set signcolumn=yes
set shortmess+=c

let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-eslint',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-markdownlint',
  \ 'coc-pairs',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-yaml',
  \ 'coc-git',
  \ ]

if $OS_DISTRO == 'MACOS'
  call coc#config('python.pythonPath', '/usr/local/bin/python3')
  let g:python3_host_prog = '/usr/local/bin/python3'
elseif $OS_DISTRO == 'UBUNTU'
  call coc#config('python.pythonPath', '/usr/bin/python3')
  let g:python3_host_prog = '/usr/bin/python3'
endif

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>"
  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" coc pairs
augroup CocPairs
  autocmd!
  autocmd FileType markdown let b:coc_pairs_disabled = ['`', "'"]
  autocmd FileType vim,vifm let b:coc_pairs_disabled = ['"']
augroup end

" multi cursors
function! s:select_current_word() abort
  if !get(b:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

" coc prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" coc rename
nmap <leader>rn <Plug>(coc-rename)
nnoremap <leader>rr :CocSearch <C-R>=expand("<cword>")<CR><CR>

" coc snippets
imap <C-j> <Plug>(coc-snippets-expand-jump)

" coc multi cursor
nmap <expr> <silent> <C-s> <SID>select_current_word()
xmap <silent> <C-s> <Plug>(coc-cursors-range)
nmap <silent> <leader>m <Plug>(coc-cursors-position)

" coc lsp jumps
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" coc git key map
nmap [h <Plug>(coc-git-prevchunk)
nmap ]h <Plug>(coc-git-nextchunk)
nmap <leader>hp <Plug>(coc-git-chunkinfo)
nmap <leader>hc <Plug>(coc-git-commit)
nmap <leader>hu :CocCommand git.chunkUndo<CR>
nmap <leader>hs :CocCommand git.chunkStage<CR>
nmap <leader>hf :CocCommand git.foldUnchanged<CR>

" coc git chunk obj
omap ih <Plug>(coc-git-chunk-inner)
xmap ih <Plug>(coc-git-chunk-inner)
omap ah <Plug>(coc-git-chunk-outer)
xmap ah <Plug>(coc-git-chunk-outer)

" coc function obj
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)

" coc class obj
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" coc list map
nnoremap <leader>lc :CocList commands<CR>
nnoremap <leader>ll :CocList lists<CR>
nnoremap <leader>ld :CocList diagnostics<CR>

" coc command map
nnoremap <leader>cs :CocCommand snippets.editSnippets<CR>
nnoremap <leader>cf :CocCommand prettier.formatFile<CR>
nnoremap <leader>co :CocCommand editor.action.organizeImport<CR>
augroup PyrightImportOrganize
  autocmd!
  autocmd FileType python nnoremap <buffer><leader>co :Isort<CR>
augroup end
nnoremap <leader>ce :CocRestart<CR>
vmap <leader>cf <Plug>(coc-format-selected)

" Use [g and ]g to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" coc hover show details
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation() abort
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" -- CUSTOM --------------------------------------------------------------------

" ctrl semicolumn like vscode ctrl semicolumn
command! CtrlSemicolumn normal maA;<Esc>`a
command! CtrlColumn normal maA,<Esc>`a

function! s:VisualStar(cmdtype) abort
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" cgn motion
xnoremap * :<C-u>call <SID>VisualStar('/')<CR>/<C-R>=@/<CR><CR>
nnoremap <leader>rs *Ncgn
xnoremap <leader>rs :<C-u>call <SID>VisualStar('/')<CR>/<C-R>=@/<CR><CR>Ncgn

nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
