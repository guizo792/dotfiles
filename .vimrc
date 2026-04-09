" Usability
inoremap jk <Esc>

" Fzf
nnoremap <C-p> :Files<CR>

" NerdTree
nnoremap <C-t> :NERDTreeToggle<CR>

" Navigating between terminal splits
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

set hidden
set tabstop=4 shiftwidth=4 expandtab

if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

" set clipboard=unnamedplus
set autochdir

" Optional keybinding to search
nnoremap <C-f> :Rg<Space>

" Use ripgrep for content search
command! -nargs=+ Rg call fzf#vim#grep("rg --hidden --vimgrep --smart-case --glob '!.git/*' --glob '!node_modules/*' ".shellescape(<q-args>), 1, <bang>0)


" Plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'dense-analysis/ale'
Plug 'morhetz/gruvbox'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'ghifarit53/tokyonight-vim', { 'as': 'tokyonight' } 
Plug 'mileszs/ack.vim'
Plug 'mg979/vim-visual-multi'
Plug 'Yggdroot/indentLine'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

call plug#end()

function! LightlineFugitive()
  if exists('*FugitiveHead')
    let branch = FugitiveHead()
    return branch !=# '' ? ' ' . branch : ''
  endif
  return ''
endfunction

let g:lightline = {
  \ 'gruvbox': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'readonly', 'filename', 'gitbranch', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'filetype'],
  \              ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'LightlineFugitive'
  \ }
\ }

let g:airline_theme = 'catppuccin_mocha'

let g:ackprg = 'ag --nogroup --nocolor --column'

" Indentation
let g:indentLine_char = '.'      " Change the character if needed
let g:indentLine_enabled = 1

" LSP
if executable('eclipse-jdt-ls')
    " pip install java-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'eclipse-jdt-ls',
        \ 'cmd': {server_info->['eclipse-jdt-ls']},
        \ 'allowlist': ['java'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Appearance
set number relativenumber
set cursorline
syntax enable
set background=dark
set termguicolors
let g:gruvbox_contrast_dark = 'hard'    " or 'medium', 'soft'
let g:gruvbox_italic = 1
let g:gruvbox_invert_selection = '0'

" colorscheme gruvbox
" colorscheme desert
" colorscheme catppuccin_mocha
colorscheme tokyonight
set wrap
set ai
set ls=2

syntax on
filetype on
filetype plugin on
filetype indent on

" Font
" set guifont=FiraCode\ Nerd\ Font:h14

