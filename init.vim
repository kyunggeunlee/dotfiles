call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ojroques/vim-oscyank'
Plug 'tpope/vim-fugitive'
call plug#end()

set hlsearch
set number relativenumber
set shiftwidth=4
set smartindent
set autoindent
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
let g:vimsyn_embed='l'

colorscheme gruvbox
set bg=dark
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
set colorcolumn=80,100,120

set mouse=a
set tags=./tags;,tags;
let g:jedi#use_tabs_not_buffers = 1

map <C-N> :tabnext<CR>
map <C-P> :tabprevious<CR>

let mapleader=" "
map <Leader>y :OSCYank<CR>
map <Leader>e :tabe<CR>
map <Leader>v :vsplit<CR>
map <Leader>s :split<CR>
map <Leader>w :w<CR>
map <Leader>q :q<CR>
map <Leader>t :NERDTreeToggle<CR>

function! Gitadd()
    let l:filename = getreg("%")
    execute printf("Git add %s", l:filename)
endfunction

function! Gitlog()
    let l:filename = getreg("%")
    let l:start = line("'<")
    let l:end = line("'>")
    execute printf("Git log -L %d,%d:%s", l:start, l:end, l:filename)
endfunction

map <Leader>ga :<C-u>call Gitadd()<CR>
map <Leader>gl :<C-u>call Gitlog()<CR>
map <Leader>gd :Git diff HEAD<CR>

nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gr <cmd>Telescope lsp_references<CR>
nnoremap  K <cmd>lua vim.lsp.buf.hover()<CR>

imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

set completeopt=menuone,noinsert,noselect
set shortmess+=c


lua << END
local lspconfig = require'lspconfig'
local on_attach = function(client)
  require'completion'.on_attach(client)
end

if vim.fn.executable('ccls') == 1 then
  lspconfig.ccls.setup{
    on_attach = on_attach,
    init_options = {
      client = { snippetSupport = false }
    }
  }
  vim.cmd('autocmd FileType c,cpp setlocal omnifunc=v:lua.vim.lsp.omnifunc')
  vim.cmd('autocmd FileType c,cpp setlocal signcolumn=yes')
end

if vim.fn.executable('pyright') == 1 then
  lspconfig.pyright.setup{
    on_attach = on_attach,
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        }
      }
    }
  }
  vim.cmd('autocmd FileType python setlocal omnifunc=v:lua.vim.lsp.omnifunc')
  vim.cmd('autocmd FileType python setlocal signcolumn=yes')
end

END
