call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ojroques/vim-oscyank'
Plug 'tpope/vim-fugitive'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'CopilotC-Nvim/CopilotChat.nvim'
Plug 'github/copilot.vim'
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
map <Leader>y :OSCYankVisual<CR>
map <Leader>e :tab split<CR>
map <Leader>v :vsplit<CR>
map <Leader>s :split<CR>
map <Leader>w :w<CR>
map <Leader>q :q<CR>
map <Leader>t :NERDTreeToggle<CR>
map <Leader>l :tabm +1<CR>
map <Leader>h :tabm -1<CR>

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
nmap <Leader>md :MarkdownPreviewToggle<CR>

nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gr <cmd>Telescope lsp_references<CR>
nnoremap  K <cmd>lua vim.lsp.buf.hover()<CR>

map <Leader>ct :CopilotChatToggle<CR>
map <Leader>ce :CopilotChatExplain<CR>
map <Leader>cr :CopilotChatReview<CR>
map <Leader>cf :CopilotChatFix<CR>
map <Leader>co :CopilotChatOptimize<CR>
map <Leader>cd :CopilotChatDocs<CR>

set completeopt=menuone,noinsert,noselect
set shortmess+=c

imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand-or-jump)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand-or-jump)'         : '<C-j>'

lua << END
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

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('pyright', {
  capabilities = capabilities
})
vim.lsp.enable('pyright')
vim.lsp.config('ccls', {
  capabilities = capabilities
})
vim.lsp.enable('ccls')

require('CopilotChat').setup({
  model = 'gpt-4.1',           -- AI model to use
  temperature = 0.1,           -- Lower = focused, higher = creative
  window = {
    layout = 'vertical',       -- 'vertical', 'horizontal', 'float'
    width = 0.5,              -- 50% of screen width
  },
  auto_insert_mode = true,     -- Enter insert mode when opening
  window = {
    layout = 'float',
    width = 80, -- Fixed width in columns
    height = 20, -- Fixed height in rows
    border = 'rounded', -- 'single', 'double', 'rounded', 'solid'
    title = '🤖 AI Assistant',
    zindex = 100, -- Ensure window stays on top
  },

  headers = {
    user = '👤 You',
    assistant = '🤖 Copilot',
    tool = '🔧 Tool',
  },

  separator = '━━',
  auto_fold = true, -- Automatically folds non-assistant messages
  prompts = {
    MyCustomPrompt = {
      prompt = 'Explain how it works.',
      system_prompt = 'You are very good at explaining stuff',
      mapping = '<leader>ccmc',
      description = 'My custom prompt description',
    },
    Yarrr = {
      system_prompt = 'You are fascinated by pirates, so please respond in pirate speak.',
    },
    NiceInstructions = {
      system_prompt = 'You are a nice coding tutor, so please respond in a friendly and helpful manner.',
    }
  }
})

vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
END
