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

  use 'flazz/vim-colorschemes'
  use 'norcalli/nvim-colorizer.lua'

  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  use 'junegunn/fzf';  -- Using Telescope for now
  use 'junegunn/fzf.vim';

  use 'L3MON4D3/LuaSnip'      -- Snippets plugin

  use 'hrsh7th/nvim-cmp'      -- A completion plugin for neovim
  use 'hrsh7th/cmp-buffer'    -- cmp-source
  use 'hrsh7th/cmp-nvim-lua'  -- source for nvim lua
  use 'hrsh7th/cmp-nvim-lsp'  --
  use 'hrsh7th/cmp-path'      --
  use 'saadparwaiz1/cmp_luasnip'

  use 'romainl/vim-devdocs'
  use 'folke/which-key.nvim'

  use 'kyazdani42/nvim-tree.lua'

  use 'mbbill/undotree'

  use 'ctrlpvim/ctrlp.vim'

  use 'Raimondi/delimitMate'
  use 'ahmedkhalf/project.nvim'
  use 'bronson/vim-trailing-whitespace'

  use 'winston0410/commented.nvim'

  use 'ryanoasis/vim-devicons' -- Mostly used in status line I think
  use 'kyazdani42/nvim-web-devicons'  -- for file icons
  use { 'famiu/feline.nvim', requires = { 'kyazdani42/nvim-web-devicons', 'lewis6991/gitsigns.nvim', 'nvim-lua/plenary.nvim'} }

  -- use 'danilamihailov/beacon.nvim'

end)

-------------------- PLUGIN SETUP --------------------------
require('keymap')
require('settings')
require('langserv_cfg')
require('cmp_cfg') --Nvim-Compe replacement

-- gitsigns / coloring / hilight
vim.cmd 'colorscheme jellyx'
require('gitsigns').setup()
vim.cmd("highlight DiffAdd ctermfg=151 ctermbg=0 guifg=#33FF33 guibg=#000000")
vim.cmd("highlight DiffDelete ctermfg=183 ctermbg=0 guifg=#FF3333 guibg=#000000")
vim.cmd("highlight DiffChange ctermfg=181 ctermbg=0 guifg=#FFFF33 guibg=#000000")
require'colorizer'.setup()

require('feline').setup()

-- Code folding
utils.opt('o', 'foldlevel', 10)
utils.opt('o', 'foldmethod', 'indent')

-- Which-Key.nvim
require("which-key").setup()

-- fzf
g['fzf_action'] = {['ctrl-s'] = 'split', ['ctrl-v'] = 'vsplit'}
map('n', '<leader>/', '<cmd>BLines<CR>')
map('n', '<leader>f', '<cmd>Files<CR>')
map('n', '<leader>;', '<cmd>History:<CR>')
map('n', '<leader>r', '<cmd>Rg<CR>')
map('n', 's', '<cmd>Buffers<CR>')

-- Swe Keys fix attempt
map('n','ö','[', { noremap = false })
map('n','ä',']', { noremap = false })

-- NvimTree
map('n','<leader>pt',':NvimTreeToggle<CR>')
map('n','<leader>ntr', ':NvimTreeRefresh<CR>')
map('n','<leader>ntn', ':NvimTreeFindFile<CR>')

-- Buffer nav
map('n', '<leader>z', ':bp<CR>')
map('n', '<leader>x', ':bn<CR>')
-- Close buffer
map('n', '<leader>bd', ':bd<CR>')

