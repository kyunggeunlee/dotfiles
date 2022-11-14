call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
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
map <Leader>e :tab split<CR>
map <Leader>v :vsplit<CR>
map <Leader>s :split<CR>
map <Leader>w :w<CR>
map <Leader>q :q<CR>
map <Leader>t :NERDTreeToggle<CR>

function Gitlog(is_visual_mode)
    let l:filename = getreg("%")
    if a:is_visual_mode
        let l:start = line("'<") "first line of the selected block in visual mode
        let l:end = line("'>")   "last line of the selected block in visual mode
    else
        let l:start = line("w0") "first line of the current window
        let l:end = line("w$")   "last line of the current window
    endif
    let l:cmd = printf("Git log -L %d,%d:%s", l:start, l:end, l:filename)
    echo l:cmd
    execute l:cmd
endfunction

map <Leader>ga :Git add %<CR>
map <Leader>gd :Git diff HEAD %<CR>
nmap <Leader>gl :call Gitlog(0)<CR>
vmap <Leader>gl :<C-u>call Gitlog(1)<CR>

nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gr <cmd>Telescope lsp_references<CR>
nnoremap  K <cmd>lua vim.lsp.buf.hover()<CR>

"imap <Tab> <Plug>(completion_smart_tab)
"imap <S-Tab> <Plug>(completion_smart_s_tab)

set completeopt=menuone,noinsert,noselect
set shortmess+=c


lua << END
local lspconfig = require'lspconfig'

local cmp = require'cmp'

cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig['pyright'].setup {
  capabilities = capabilities
}
lspconfig['ccls'].setup {
  capabilities = capabilities
}

END
