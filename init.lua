-- neovim config borrowed from ojroques and mjlbach
-- github.com/kajih

-------------------- HELPERS -------------------------------
local utils = require('utils')  -- Utillity functions, like opt,map and autogroup

local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g
local opt, wo = vim.opt, vim.wo
local fmt = string.format
local map = utils.map -- Alias from utils package

-- Install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  print("Bootstrapping packer to", install_path)
  fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  cmd [[ quit! ]]
end

api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

-------------------- PLUGINS -------------------------------

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

  -- use 'kdheepak/lazygit.nvim'
  -- use 'tpope/vim-fugitive' -- Git commands in nvim
  -- use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  --
  use { 'nvim-treesitter/nvim-treesitter', branch = 'master', run = ':TSUpdate' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'master', requires = { 'nvim-treesitter/nvim-treesitter' } }
  use 'nvim-lua/plenary.nvim'

  use { 'TimUntersberger/neogit', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- Dont need tags with lsp?
  -- use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- use 'weilbith/nvim-lsp-smag'  -- tags

  use 'flazz/vim-colorschemes'
  use 'norcalli/nvim-colorizer.lua'

  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  use { 'simrat39/rust-tools.nvim', requires = { 'neovim/nvim-lspconfig', 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap' } }
  use { 'Saecki/crates.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'ray-x/go.nvim'

  use 'sbdchd/neoformat'        -- code format?
  
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-dap.nvim', requires = { 'nvim-telescope/telescope.nvim' } }

  -- use 'junegunn/fzf';  -- Using Telescope for now
  -- use 'junegunn/fzf.vim';

  -- Debugging
  use { 'mfussenegger/nvim-dap'}
  use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap'} }
  use { 'theHamsta/nvim-dap-virtual-text', requires = { 'mfussenegger/nvim-dap'} }

  use 'L3MON4D3/LuaSnip'      -- Snippets plugin

  use 'hrsh7th/nvim-cmp'      -- A completion plugin for neovim
  use 'hrsh7th/cmp-buffer'    -- cmp-source
  use 'hrsh7th/cmp-nvim-lua'  -- source for nvim lua
  use 'hrsh7th/cmp-nvim-lsp'  --
  use 'hrsh7th/cmp-path'      --
  use 'saadparwaiz1/cmp_luasnip'

  use 'ray-x/lsp_signature.nvim'  -- TODO

  use 'romainl/vim-devdocs'
  use 'folke/which-key.nvim'
  
  use 'kyazdani42/nvim-tree.lua'

  use 'p00f/nvim-ts-rainbow'
  use 'mbbill/undotree'

  use 'ctrlpvim/ctrlp.vim'

  use 'Raimondi/delimitMate'
  use 'ahmedkhalf/project.nvim'
  use 'bronson/vim-trailing-whitespace'

  use 'winston0410/commented.nvim'

  use 'ojroques/nvim-buildme'
  -- use 'ojroques/nvim-hardline'
  -- use 'ojroques/nvim-bufbar'

  use 'RishabhRD/popfix'

  use { 'SmiteshP/nvim-gps', requires = 'nvim-treesitter/nvim-treesitter' }
  use { 'ellisonleao/glow.nvim', run = function () require('glow').download_glow() end }

  use 'ryanoasis/vim-devicons' -- Mostly used in status line I think
  use 'kyazdani42/nvim-web-devicons'  -- for file icons
  use { 'famiu/feline.nvim', requires = { 'kyazdani42/nvim-web-devicons', 'lewis6991/gitsigns.nvim', 'nvim-lua/plenary.nvim'} }

  --  'ojroques/nvim-lspfuzzy';

  use 'danilamihailov/beacon.nvim'

end)

-------------------- PLUGIN SETUP --------------------------
require('keymap')
require('settings')
require('langserv_cfg')
require('cmp_cfg') --Nvim-Compe replacement

require('rust-tools').setup()
require("crates").setup()

require('go').setup()

require('dap_cfg') -- Debugging
-- require('navigator').setup() --lspSaga replacement

require('neogit').setup()

-- gitsigns / coloring / hilight
vim.cmd 'colorscheme jellyx'
require('gitsigns').setup()
vim.cmd("highlight DiffAdd ctermfg=151 ctermbg=0 guifg=#33FF33 guibg=#000000")
vim.cmd("highlight DiffDelete ctermfg=183 ctermbg=0 guifg=#FF3333 guibg=#000000")
vim.cmd("highlight DiffChange ctermfg=181 ctermbg=0 guifg=#FFFF33 guibg=#000000")
require'colorizer'.setup()

require('commented').setup(
  {
    comment_padding = " ", -- padding between starting and ending comment symbols
    keybindings = {n = "<leader>c", v = "<leader>c", nl = "<leader>cc"}, -- what key to toggle comment, nl is for mapping <leader>c$, just like dd for d
    prefer_block_comment = true, -- Set it to true to automatically use block comment when multiple lines are selected
    set_keybindings = true, -- whether or not keybinding is set on setup
    ex_mode_cmd = "Comment" -- command for commenting in ex-mode, set it null to not set the command initially.
  }
)

-- bufbar
-- require('bufbar').setup {show_bufname = 'visible', show_flags = false}
-- require('hardline').setup {}

require('feline').setup()

-- buildme
utils.map('n', '<leader>bb', '<cmd>BuildMe<CR>')
utils.map('n', '<leader>be', '<cmd>BuildMeEdit<CR>')
utils.map('n', '<leader>bs', '<cmd>BuildMeStop<CR>')

-------------------- TREE-SITTER ---------------------------
--[[
  require('nvim-treesitter.configs').setup {}
]]--

-- Code folding
utils.opt('o', 'foldlevel', 10)
utils.opt('o', 'foldmethod', 'indent')

require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = {enable = true},
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['aa'] = '@parameter.outer', ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer', ['if'] = '@function.inner',
        ['ac'] = '@class.outer', ['ic'] = '@class.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {['<leader>a'] = '@parameter.inner'},
      swap_previous = {['<leader>A'] = '@parameter.inner'},
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {[']a'] = '@parameter.outer', [']f'] = '@function.outer', [']c'] = '@class.outer'},
      goto_next_end = {[']A'] = '@parameter.outer', [']F'] = '@function.outer', [']C'] = '@class.outer'},
      goto_previous_start = {['[a'] = '@parameter.outer', ['[f'] = '@function.outer', ['[c'] = '@class.outer'},
      goto_previous_end = {['[A'] = '@parameter.outer', ['[F'] = '@function.outer', ['[C'] = '@class.outer'},
    },
  },
}

-- Which-Key.nvim
require("which-key").setup()

-- Telescope
require('telescope').setup()
-- require('telescope').load_extension('dap')

-- Project management
require("project_nvim").setup {
  -- Manual mode doesn't automatically change your root directory, so you have
  -- the option to manually do so using `:ProjectRoot` command.
  manual_mode = false,

  -- Methods of detecting the root directory. **"lsp"** uses the native neovim
  -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
  -- order matters: if one is not detected, the other is used as fallback. You
  -- can also delete or rearangne the detection methods.
  detection_methods = { "lsp", "pattern" },

  -- All the patterns used to detect root dir, when **"pattern"** is in
  -- detection_methods
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "Cargo.toml", "package.json" },

  -- Table of lsp clients to ignore by name
  -- eg: { "efm", ... }
  ignore_lsp = {},

  -- When set to false, you will get a message when project.nvim changes your
  -- directory. (default true)
  silent_chdir = false,
}

require('telescope').load_extension('projects')

local gps = require("nvim-gps")
gps.setup()

-- buildme
map('n', '<leader>bb', '<cmd>BuildMe<CR>')
map('n', '<leader>be', '<cmd>BuildMeEdit<CR>')
map('n', '<leader>bs', '<cmd>BuildMeStop<CR>')

--[[

-- fzf
g['fzf_action'] = {['ctrl-s'] = 'split', ['ctrl-v'] = 'vsplit'}
map('n', '<leader>/', '<cmd>BLines<CR>')
map('n', '<leader>f', '<cmd>Files<CR>')
map('n', '<leader>;', '<cmd>History:<CR>')
map('n', '<leader>r', '<cmd>Rg<CR>')
map('n', 's', '<cmd>Buffers<CR>')

-- lspfuzzy
require('lspfuzzy').setup {}

]]--


-------------------- MAPPINGS ------------------------------
-- nnoremap <Leader>w :write<CR>
-- map('n', '<Leader>w', ':write<CR>', {noremap = true})

-- Fugitive / Git

-- local log = [[\%C(yellow)\%h\%Cred\%d \%Creset\%s \%Cgreen(\%ar) \%Cblue\%an\%Creset]]
--[[ Switched to neogit
map('n', '<leader>g<space>', ':Git ')
map('n', '<leader>gd', '<cmd>Gvdiffsplit<CR>')
map('n', '<leader>gg', '<cmd>Git<CR>')
map('n', '<leader>gl', fmt('<cmd>term git log --graph --all --format="%s"<CR><cmd>start<CR>', log))
]]--

-- Swe Keys fix attempt
map('n','ö','[', { noremap = false })
map('n','ä',']', { noremap = false })
-- map('n','öö','[[', { noremap = false })
-- map('n','ää',']]', { noremap = false })

-- NvimTree
map('n','<leader>pt',':NvimTreeToggle<CR>')
map('n','<leader>ntr', ':NvimTreeRefresh<CR>')
map('n','<leader>ntn', ':NvimTreeFindFile<CR>')

-- Telescope recent projects
map('n','<leader>pp',':Telescope projects<CR>')

-- Buffer nav
-- noremap <leader>z :bp<CR>
-- noremap <leader>x :bn<CR>
map('n', '<leader>z', ':bp<CR>')
map('n', '<leader>x', ':bn<CR>')
-- Close buffer
map('n', '<leader>bd', ':bd<CR>')


--[[
map('n', '<C-l>', '<cmd>nohlsearch<CR>')
map('n', '<C-w>T', '<cmd>tabclose<CR>')
map('n', '<C-w>t', '<cmd>tabnew<CR>')
map('n', '<S-Down>', '<C-w>2<')
map('n', '<S-Left>', '<C-w>2-')
map('n', '<S-Right>', '<C-w>2+')
map('n', '<S-Up>', '<C-w>2>')
map('n', '<leader>s', ':%s//gcI<Left><Left><Left><Left>')
map('n', '<leader>t', '<cmd>terminal<CR>')
map('n', '<leader>u', '<cmd>update<CR>')
map('n', '<leader>x', '<cmd>conf qa<CR>')
map('n', 'Q', '<cmd>lua warn_caps()<CR>')
map('n', 'U', '<cmd>lua warn_caps()<CR>')
map('t', '<ESC>', '&filetype == "fzf" ? "\\<ESC>" : "\\<C-\\>\\<C-n>"' , {expr = true})
map('v', '<leader>s', ':s//gcI<Left><Left><Left><Left>')

-------------------- LSP -----------------------------------
for ls, cfg in pairs({
  bashls = {}, gopls = {}, ccls = {}, jsonls = {}, pylsp = {},
}) do require('lspconfig')[ls].setup(cfg) end

map('n', '<leader>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

-------------------- COMMANDS ------------------------------
function warn_caps()
  cmd 'echohl WarningMsg'
  cmd 'echo "Caps Lock may be on"'
  cmd 'echohl None'
end

vim.tbl_map(function(c) cmd(fmt('autocmd %s', c)) end, {
  'TermOpen * lua init_term()',
  'TextYankPost * lua vim.highlight.on_yank {timeout = 200, on_visual = false}',
  'TextYankPost * if v:event.operator is "y" && v:event.regname is "+" | OSCYankReg + | endif',
})

]]--
