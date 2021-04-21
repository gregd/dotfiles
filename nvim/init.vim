"---- vim-plug setup  ----
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
let curl_exists=expand('curl')

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif
"-------- end vim-plug setup ----

set nocompatible
let mapleader = "\<Space>"

call plug#begin('~/.config/nvim/plugged')

" Color schemes
"Plug 'sainnhe/edge'
Plug 'gregd/darcula'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'
Plug 'glepnir/lspsaga.nvim'
"Plug 'simrat39/rust-tools.nvim'

" Completion
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'romgrk/nvim-treesitter-context'

" File explorer
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Top tabline 
Plug 'romgrk/barbar.nvim'

" Auto-save files
Plug '907th/vim-auto-save'

" Jump anywhere in a document
Plug 'phaazon/hop.nvim'

" Status line
Plug 'glepnir/galaxyline.nvim'

" Indent lines
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }

" Fast comment line
Plug 'terrortylor/nvim-comment'

" Git 
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" Key bindings help
Plug 'liuchengxu/vim-which-key'

" Start-up screen
Plug 'glepnir/dashboard-nvim'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

if has('termguicolors')
  set termguicolors
endif
colorscheme darcula

syntax enable
filetype plugin indent on

set number                  " Line numbers on
set relativenumber          " Relative numbers on
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set autoindent
set smartindent
set smarttab
set ignorecase
set nohlsearch
set smartcase
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set cmdheight=2
set updatetime=50
set timeoutlen=1000
set signcolumn=yes
set clipboard=unnamed,unnamedplus
set scrolljump=1        " Line to scroll when cursor leaves screen
set scrolloff=6         " Minumum lines to keep above and below cursor
set whichwrap+=<,>,h,l  " Allow backspace and cursor keys to cross line boundaries
"set cursorline          " Highlight current line
set splitright          " Puts new vsplit windows to the right of the current
set splitbelow          " Puts new split windows to the bottom of the current
set nowrap              " Do not wrap long lines
set pumheight=25        " Avoid the pop up menu occupying the whole screen
set vb t_vb=            " No more beeps
set t_Co=256            " Use 256 colors
set noswapfile          " Do not create swap files
set noshowmode          " We don't need to see things like -- INSERT -- anymore
set backspace=indent,eol,start
set nofoldenable
set mouse=a

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" Show highlight only when search is active
augroup vimrc_incsearch_highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" Quit normal mode
"nnoremap <silent> <Leader>q  :q<CR>
"nnoremap <silent> <Leader>Q  :qa!<CR>

" Quick command mode
"nnoremap <CR> :
" In the quickfix window, <CR> is used to jump to the error under the cursor, so undefine the mapping there.
"autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" Left and right can switch buffers
"nnoremap <left> :bp<CR>
"nnoremap <right> :bn<CR>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Move to the start of line
nnoremap H ^
" Move to the end of line
nnoremap L $

" Yank to the end of line
nnoremap Y y$

nnoremap J <Nop>
nnoremap <Leader>j J
nnoremap K <Nop>
"nnoremap <Leader>k K

" Display help
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" Toggle pastemode
nnoremap <silent> <Leader>tp :setlocal paste!<CR>

" do not overwritte the default register
"vnoremap <Leader>p "_dP
vnoremap <Leader>d "_d
nnoremap <Leader>d "_d

" paste many times over selected text
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'

" Open new line below and above current line
nnoremap <Leader>o o<esc>
nnoremap <Leader>O O<esc>

" qq to record, Q to replay
nnoremap Q @q

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

nnoremap <Leader>ww <C-W>w
nnoremap <Leader>wr <C-W>r
nnoremap <Leader>wc <C-W>c
nnoremap <Leader>wq <C-W>q
nnoremap <Leader>wj <C-W>j
nnoremap <Leader>wk <C-W>k
nnoremap <Leader>wh <C-W>h
nnoremap <Leader>wl <C-W>l
nnoremap <Leader>wo <C-W>o

nnoremap <Leader>wH <C-W>8<
nnoremap <Leader>wL <C-W>8>
nnoremap <Leader>wJ :resize +8<CR>
nnoremap <Leader>wK :resize -8<CR>
nnoremap <Leader>we <C-W>=
nnoremap <Leader>ws <C-W>s
nnoremap <Leader>wv <C-W>v

nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz
"nnoremap <leader>j :lnext<CR>zz
"nnoremap <leader>k :lprev<CR>zz
"nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
"nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>

" -------------------- LSP ---------------------------------
:lua <<EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  --buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --buf_set_keymap('n', 'K',  '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --buf_set_keymap('n', '<leader>ls', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  --buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  buf_set_keymap('n', '<leader>lh', ':Lspsaga hover_doc<CR>', opts)
  buf_set_keymap('n', '<leader>lr', ':Lspsaga rename<CR>', opts)
  buf_set_keymap('n', '<leader>la', ':Lspsaga code_action<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#344134
      hi LspReferenceText cterm=bold ctermbg=red guibg=#344134
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#344134
      augroup lsp_document_highlight
	autocmd! * <buffer>
	autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
	autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup ENDS
    ]], false)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "rust_analyzer" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { 
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Completion
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = false;
    nvim_lsp = true;
    nvim_lua = false;
    vsnip = true;
    spell = true;
  };
} 

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

local saga = require 'lspsaga'
saga.init_lsp_saga {
  code_action_keys = {
    quit = '<esc>',
    exec = '<CR>'
  },
  rename_action_keys = {
    quit = '<esc>',
    exec = '<CR>'  -- quit can be a table
  },
}

-- Add icons to LSP suggestions
require('lspkind').init({
    with_text = true,
})

-- Easy code commetns 
require('nvim_comment').setup()
vim.api.nvim_set_keymap("n", "<leader>cc", ":CommentToggle<CR>", {noremap=true, silent = true})
EOF

hi! link LspSagaLightBulbSign WarningSign 
hi! link LspSagaLightBulb function 

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" -------------------- LSP ---------------------------------

" Fuzzy finder
nnoremap <leader>fjf <cmd>Telescope find_files<cr>
nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fq <cmd>Telescope quickfix<cr>
nnoremap <leader>fjh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fjs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>fjc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers({ show_all_buffers = true })<cr>
nnoremap <leader>fo <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>fc <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>fp <cmd>lua require('telescope.builtin').registers()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>fd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>

" fzf
let g:fzf_preview_window = ['right:70%', 'ctrl-/']

lua <<EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    set_env = {['COLORTERM'] = 'truecolor'},
    results_height = 1,
    results_width = 0.8,
    layout_strategy = "horizontal", 
    prompt_position = "top",
    sorting_strategy = "ascending",
    --width = 0.25,
    --layout_config = {
    --  preview_width = 0.65,    
    --},
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist,
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default + actions.center,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist,
      }
    }
  }
}
EOF

" Syntax
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>ss",
      node_incremental = "<leader>ss",
      scope_incremental = "<leader>si",
      node_decremental = "<leader>sd",
    },
  },
  indent = {
    enable = false
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}
EOF

" File explorer
nnoremap <leader>nt :NvimTreeToggle<CR>
nnoremap <leader>nr :NvimTreeRefresh<CR>
nnoremap <leader>nf :NvimTreeFindFile<CR>
let g:nvim_tree_width = 40
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:nvim_tree_gitignore = 1
let g:nvim_tree_auto_open = 0 
let g:nvim_tree_auto_close = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_follow = 1
let g:nvim_tree_group_empty = 1

" Top tabline
nnoremap <silent>    <C-left> :BufferPrevious<CR>
nnoremap <silent>    <C-right> :BufferNext<CR>
nnoremap <silent>    <leader>bc :BufferClose<CR>
let bufferline = get(g:, 'bufferline', {})
let bufferline.tabpages = v:false
let bufferline.closable = v:true
let bufferline.icon_separator_active = ''

lua <<EOF
-- Jump anywhere in a document
vim.api.nvim_set_keymap('n', '<leader>ga', "<cmd>lua require'hop'.hint_words()<cr>", {})

-- Git status 

-- Git signs 
require('gitsigns').setup({
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '┃', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '▁', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '▔', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
})
EOF
hi! link GitSignsAdd PositiveSign
hi! link GitSignsChange WarningSign 
hi! link GitSignsDelete ErrorSign 

" Auto-save files
let g:auto_save = 1
let g:auto_save_silent = 1

" Status line
luafile ~/.config/nvim/eviline.lua

" Indent lines
let g:indentLine_char = ''
let g:indent_blankline_filetype = ['vim', 'rust']

" Start-up screen
let g:dashboard_default_executive = 'telescope'
let g:dashboard_custom_footer = ['']
let g:dashboard_custom_header = [
            \ '',
            \'       /\          /\          /\',
            \'    /\//\\/\    /\//\\/\    /\//\\/\',
            \' /\//\\\///\\/\//\\\///\\/\//\\\///\\/\',
            \'//\\\//\/\\///\\\//\/\\///\\\//\/\\///\\',
            \'\\//\/                            \/\\//',
            \' \/                                  \/',
            \' /\                                  /\',
            \'//\\       Neovim IDE with LSP      //\\',
            \'\\//                                \\//',
            \' \/                                  \/',
            \' /\                                  /\',
            \'//\\/\                            /\//\\',
            \'\\///\\/\//\\\///\\/\//\\\///\\/\//\\\//',
            \' \/\\///\\\//\/\\///\\\//\/\\///\\\//\/',
            \'    \/\\//\/    \/\\//\/    \/\\//\/',
            \'       \/          \/          \/',
            \'',
            \ '',
            \ ]

