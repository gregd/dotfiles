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

" Sensible default 
Plug 'tpope/vim-sensible'

" Color schemes
Plug 'sainnhe/edge'
"Plug 'cocopon/iceberg.vim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'
Plug 'onsails/lspkind-nvim'
"Plug 'simrat39/rust-tools.nvim'
Plug 'kosayoda/nvim-lightbulb'

" Code snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
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

" Registers popup
Plug 'gennaro-tedesco/nvim-peekup'

" Jump anywhere in a document
Plug 'phaazon/hop.nvim'

" Status line
Plug 'glepnir/galaxyline.nvim'

" Indent lines
Plug 'Yggdroot/indentLine'

" Auto close bracket on return 
Plug 'rstacruz/vim-closer'

" Git 
Plug 'TimUntersberger/neogit'
Plug 'lewis6991/gitsigns.nvim'

" Spell checker
"Plug 'lewis6991/spellsitter.nvim'

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
let g:edge_style = 'aura'
let g:edge_disable_italic_comment = 1
colorscheme edge

syntax enable
filetype plugin indent on

set number                  " Line numbers on
set relativenumber          " Relative numbers on
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set expandtab
set autoindent
set smartindent
set ignorecase
set nohlsearch
set smartcase
set tabstop=4
set softtabstop=4
set shiftwidth=4
set cmdheight=2
set updatetime=50
set timeoutlen=2000
set signcolumn=yes
set clipboard=unnamed,unnamedplus
set scrolljump=1        " Line to scroll when cursor leaves screen
set scrolloff=6         " Minumum lines to keep above and below cursor
set whichwrap+=<,>,h,l  " Allow backspace and cursor keys to cross line boundaries
set cursorline          " Highlight current line
set splitright          " Puts new vsplit windows to the right of the current
set splitbelow          " Puts new split windows to the bottom of the current
set nowrap              " Do not wrap long lines
set pumheight=25        " Avoid the pop up menu occupying the whole screen
set t_Co=256            " Use 256 colors
set noswapfile

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
" Move to the end of line
nnoremap L $
" Yank to the end of line
nnoremap Y y$
" Toggle pastemode
nnoremap <silent> <Leader>tp :setlocal paste!<CR>

" Quick command mode
"nnoremap <CR> :
" In the quickfix window, <CR> is used to jump to the error under the cursor, so undefine the mapping there.
"autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" greatest remap ever
vnoremap <leader>p "_dP
vnoremap <leader>d "_d
nnoremap <leader>d "_d

"nmap <silent> <C-k> :wincmd k<CR>
"nmap <silent> <C-j> :wincmd j<CR>
"nmap <silent> <C-h> :wincmd h<CR>
"nmap <silent> <C-l> :wincmd l<CR>

nnoremap <Leader>ww <C-W>w
nnoremap <Leader>wr <C-W>r
nnoremap <Leader>wc <C-W>c
"nnoremap <Leader>wq <C-W>q
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

nnoremap <C-k> :cnext<CR>zz
nnoremap <C-j> :cprev<CR>zz
"nnoremap <leader>k :lnext<CR>zz
"nnoremap <leader>j :lprev<CR>zz
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
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gs>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
	autocmd! * <buffer>
	autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
	autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup ENDS
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "rust_analyzer" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

require('lspkind').init({
    with_text = true,
})
EOF

" Completion
autocmd BufEnter * lua require'completion'.on_attach()
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_smart_case = 1
let g:completion_confirm_key = "\<Tab>"
let g:completion_timer_cycle = 300
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_auto_change_source = 1
let g:completion_trigger_on_delete = 1
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp','buffers','snippet']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]

" -------------------- LSP ---------------------------------

" Fuzzy finder
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fgf <cmd>Telescope git_files<cr>
nnoremap <leader>fgs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>fgc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>fvb <cmd>lua require('telescope.builtin').buffers({ show_all_buffers = true })<cr>
nnoremap <leader>fvh <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>fvc <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>fvr <cmd>lua require('telescope.builtin').registers()<cr>
nnoremap <leader>fla <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
nnoremap <leader>flr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>fld <cmd>lua require('telescope.builtin').lsp_definitions()<cr>

" fzf
let g:fzf_preview_window = ['right:70%', 'ctrl-/']

lua <<EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    layout_strategy = "horizontal", 
    prompt_position = "top",
    sorting_strategy = "ascending",
    --width = 0.25,
    --layout_config = {
    --  preview_width = 0.65,    
    --},
    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-i>"] = actions.select_horizontal,
      },
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
      init_selection = "gnn",
      node_incremental = "gnn",
      scope_incremental = "grc",
      node_decremental = "grm",
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

" Top tabline
nnoremap <silent>    <C-left> :BufferPrevious<CR>
nnoremap <silent>    <C-right> :BufferNext<CR>
nnoremap <silent>    <C-x> :BufferClose<CR>
let bufferline = get(g:, 'bufferline', {})
let bufferline.tabpages = v:false
let bufferline.closable = v:false
let bufferline.icon_separator_active = ''

lua <<EOF
-- Jump anywhere in a document
vim.api.nvim_set_keymap('n', '<C-g>', "<cmd>lua require'hop'.hint_words()<cr>", {})

-- Git status 
local neogit = require('neogit')
neogit.setup {}

-- Git signs 
require('gitsigns').setup({
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '┃', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '▁', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '▔', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '‖', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
})

-- Spell checker
--require('spellsitter').setup {
--  hl = 'SpellBad',
--  captures = {'comment'},
--  hunspell_cmd = 'hunspell',
--  hunspell_args = {'-d','en_US,pl_PL'},
--}
EOF

" Auto-save files
let g:auto_save = 1
let g:auto_save_silent = 1

" Status line
luafile ~/.config/nvim/eviline.lua

" Indent lines
let g:indentLine_char = ''

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

