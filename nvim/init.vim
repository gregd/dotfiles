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

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" Sinppets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'

" Rust tools
Plug 'simrat39/rust-tools.nvim'

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'

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
Plug 'lukas-reineke/indent-blankline.nvim'

" Fast comment line
Plug 'terrortylor/nvim-comment'

" Git 
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" Search and replace in many files
Plug 'windwp/nvim-spectre'

" Key bindings help
"Plug 'liuchengxu/vim-which-key'

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
" set relativenumber          " Relative numbers on
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
set hidden

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

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Move to the start of line
nnoremap H ^
vnoremap H ^
" Move to the end of line
nnoremap L $
vnoremap L $

" Yank to the end of line
nnoremap Y y$

nnoremap J <Nop>
nnoremap <Leader>j J
nnoremap K <Nop>
"nnoremap <Leader>k K

" Display help
"nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

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

nnoremap <Leader>wH <C-W>10<
nnoremap <Leader>wL <C-W>10>
nnoremap <Leader>wJ :resize +10<CR>
nnoremap <Leader>wK :resize -10<CR>
nnoremap <Leader>we <C-W>=
nnoremap <Leader>ws <C-W>s
nnoremap <Leader>wv <C-W>v

nnoremap <silent> <C-l> :cnext<CR>zz
nnoremap <silent> <C-h> :cprev<CR>zz

" File explorer
nnoremap <leader>nt :NvimTreeToggle<CR>
nnoremap <leader>nr :NvimTreeRefresh<CR>
nnoremap <leader>nf :NvimTreeFindFile<CR>

" Top tabline
nnoremap <silent>    <C-j> :BufferPrevious<CR>
nnoremap <silent>    <C-k> :BufferNext<CR>
nnoremap <silent>    <C-q> :BufferClose<CR>
let bufferline = get(g:, 'bufferline', {})
let bufferline.tabpages = v:false
let bufferline.closable = v:true
let bufferline.icon_separator_active = ''

" Git status 
nnoremap <silent>    <Leader>gitd :Gvdiffsplit<CR>
nnoremap <silent>    <Leader>gitl :Gclog --<CR>

" Auto-save files
let g:auto_save = 1
let g:auto_save_silent = 1

" Status line
luafile ~/.config/nvim/eviline.lua

" Indent lines
let g:indentLine_char = ''
let g:indent_blankline_filetype = ['vim', 'rust']

" Replace in multiple files
nnoremap <leader>sr :lua require('spectre').open()<CR>

" Telescope fuzzy finder
nnoremap <leader>fjf <cmd>Telescope find_files<cr>
nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fq <cmd>Telescope quickfix<cr>
nnoremap <leader>fjh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fc <cmd>Telescope grep_string<cr>
nnoremap <leader>fjs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>fjc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers({ show_all_buffers = true })<cr>
nnoremap <leader>fo <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>fja <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>fp <cmd>lua require('telescope.builtin').registers()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>fd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap <leader>fw <cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>
nnoremap <leader>fe <cmd>lua require('telescope.builtin').diagnostics()<cr>

" fzf
let g:fzf_preview_window = ['right:70%', 'ctrl-/']

" -------------------- LSP ---------------------------------
:lua <<EOF
local nvim_lsp = require('lspconfig')
local opts = {
    tools = { 
        -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                --checkOnSave = {
                --    command = "clippy"
                --},
            }
        }
    },
}
require('rust-tools').setup(opts)

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>lh',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>lr',  '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>la',  '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>lf',  '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d',          '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d',          '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Completion
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
})

-- Easy code commetns 
require('nvim_comment').setup()
vim.api.nvim_set_keymap("n", "<leader>cc", ":CommentToggle<CR>", {noremap=true, silent = true})
vim.api.nvim_set_keymap("v", "<leader>cc", ":CommentToggle<CR>", {noremap=true, silent = true})

-- Search and replace in many files
require('spectre').setup()

-- Telescope
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    set_env = {['COLORTERM'] = 'truecolor'},
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
        vertical = {
            width = 0.8,
            height = 0.95,
            preview_height = 0.65,
        }, 
        mirror = true, 
        prompt_position = "top",
    },
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
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
}
require("telescope").load_extension("ui-select")

-- Syntax
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
  move = {
      enable = true,
      set_jumps = false, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@class.outer",
      },
    },
}

-- File explorer
require'nvim-tree'.setup {
  -- disables netrw completely
  disable_netrw       = true,
  -- hijack netrw window on startup
  hijack_netrw        = true,
  -- open the tree when running this setup function
  open_on_setup       = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup  = {},
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = false,
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = false,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd          = false,
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  filters = {
    dotfiles = false,
    custom = { '.git', 'node_modules', '.cache' }
  },
  git = { 
    enable = true, 
    ignore = true 
  },
  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 40,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
  },
  renderer = {
    indent_markers = {
      enable = true,
    }
  }
}

-- Jump anywhere in a document
require('hop').setup({create_hl_autocmd = true})
vim.api.nvim_set_keymap('n', '<leader>ga', "<cmd>lua require'hop'.hint_words()<cr>", {})

-- Git signs 
require('gitsigns').setup({
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '┃', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '▁', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '▔', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})

-- Start-up screen
local db = require('dashboard')
db.custom_header = {
            '',
            '       Neovim IDE with LSP      ',
            '',
            ''}
db.custom_center = {
  { icon = '  ',
    desc = 'Recently opened files                   ',
    action = 'Telescope oldfiles'},
  { icon = '  ',
    desc = 'Find File                               ',
    action = 'Telescope find_files'},
  { icon = '  ',
    desc = 'Find word                               ',
    action = 'Telescope live_grep'},
  { icon = '  ',
    desc ='Latest git commits                       ',
    action = 'Telescope git_commits'},
}

EOF

hi! link GitSignsAdd PositiveSign
hi! link GitSignsChange WarningSign 
hi! link GitSignsDelete ErrorSign 

