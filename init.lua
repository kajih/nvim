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
  cmd 'packadd packer.nvim'
  -- cmd [[ quit! ]]
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

  -- use 'dstein64/vim-startuptime'
  use 'nathom/filetype.nvim'

  use 'wbthomason/packer.nvim' -- Package manager
  use 'nvim-lua/popup.nvim'    -- not sure if deprecated
  use 'nvim-lua/plenary.nvim'
  use 'b0o/mapx.nvim'

  -- use 'kdheepak/lazygit.nvim'
  -- use 'tpope/vim-fugitive' -- Git commands in nvim
  -- use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github

  use {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    run = ':TSUpdate',
    requires = {
      {'nvim-treesitter/nvim-treesitter-textobjects', branch = 'master'}
    },
    config = [[ require('plugins/treesitter') ]],
  }

  use { 'sindrets/diffview.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }
  use { 'TimUntersberger/neogit', requires = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' } }
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  use 'flazz/vim-colorschemes'
  use 'norcalli/nvim-colorizer.lua'

  use {
    "williamboman/nvim-lsp-installer",
    requires = { "neovim/nvim-lspconfig" },
  }

  --[[ Refactoring is under heavy development currently, mostly usefull for typescript
  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-treesitter/nvim-treesitter"}
    },
  }
  ]]

  use {
    'ThePrimeagen/harpoon',
    requires = {"nvim-lua/plenary.nvim"},
    config = [[ require("harpoon").setup({}) ]],
  }

  -- Debugging
  use {'mfussenegger/nvim-dap'}
  use {'leoluz/nvim-dap-go'}
  use {'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap'}}
  use {'theHamsta/nvim-dap-virtual-text', requires = { 'mfussenegger/nvim-dap'}}

  use {
    'simrat39/rust-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap'
    }
  }

  use {
    'Saecki/crates.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'jose-elias-alvarez/null-ls.nvim'
    },
    config = [[ require('plugins/crates') ]],
  }

  use {'ray-x/go.nvim'}
  use {'ray-x/guihua.lua'}

  use {'sbdchd/neoformat'}        -- code format?
  use {'duane9/nvim-rg'}

  use { -- Find, Filter, Preview, Pick. All lua, all the time.
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }, -- FZF sorter for telescope written in c
      {'brandoncc/telescope-harpoon.nvim'},
      {'nvim-telescope/telescope-dap.nvim'}
    },
    config = [[ require('plugins/telescope') ]],
  }

  use 'hrsh7th/nvim-cmp'      -- A completion plugin for neovim
  use 'hrsh7th/cmp-buffer'    -- cmp-source
  use 'hrsh7th/cmp-nvim-lua'  -- source for nvim lua
  use 'hrsh7th/cmp-nvim-lsp'  --
  use 'hrsh7th/cmp-path'      --
  use 'saadparwaiz1/cmp_luasnip'

  -- better way to config plugins?
  use { -- Snippet Engine for Neovim written in Lua.
    'L3MON4D3/LuaSnip',
    requires = {
      "rafamadriz/friendly-snippets",   -- Snippets collection for a set of different programming languages for faster development.
    },
    config = [[ require('snippets') ]],
  }

  use 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
  use 'ray-x/lsp_signature.nvim'
  use 'romainl/vim-devdocs'

  use {
    'tamago324/lir.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'tamago324/lir-mmv.nvim',
      'tamago324/lir-bookmark.nvim',
      'tamago324/lir-git-status.nvim',
    },
    config = [[ require('plugins/lir') ]],
  }

  use 'p00f/nvim-ts-rainbow'
  use 'mbbill/undotree'

  -- use 'Raimondi/delimitMate'
  use { -- A super powerful autopairs for Neovim. It support multiple character.
    'windwp/nvim-autopairs',
    config = [[ require('plugins/autopairs') ]]
  }

  use { -- Maximizes and restores the current window in Vim
    'szw/vim-maximizer',
    config = [[ require('plugins/maximizer') ]]
  }

  use 'ahmedkhalf/project.nvim'
  use 'bronson/vim-trailing-whitespace'

  use { -- Smart and powerful comment plugin for neovim. Supports commentstring, dot repeat, left-right/up-down motions, hooks, and more
    'numToStr/Comment.nvim',
    config = [[ require('plugins/comment_nvim') ]]
  }

  use { 'machakann/vim-sandwich' }

  use { -- No-nonsense floating terminal plugin for neovim
    config = [[ require('plugins/fterm_nvim') ]]
  }

  use {
    'SmiteshP/nvim-gps',
    requires = {
      'nvim-treesitter/nvim-treesitter'
    }
  }

  use {
    'ellisonleao/glow.nvim',
    run = function () require('glow').download_glow() end
  }

  use 'ryanoasis/vim-devicons' -- Mostly used in status line I think
  use 'kyazdani42/nvim-web-devicons'  -- for file icons

  use {
    'feline-nvim/feline.nvim',
    branch = 'master',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'lewis6991/gitsigns.nvim',
    },
    config = [[ require('feline').setup({}) ]]
  }

  use {
    'rcarriga/nvim-notify',
    config = [[ require('notify').setup({}) ]]
  }

  use 'danilamihailov/beacon.nvim'
  use 'pianocomposer321/yabs.nvim'

  -- Folding
  use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

end)

-------------------- PLUGIN SETUP --------------------------

-- require('filetype').setup({})

utils.opt('o', 'termguicolors', true)

require('mapx').setup({ global = true })
require('keymap')
require('settings')
require('langserv_cfg')
require('cmp_cfg') --Nvim-Compe replacement

local neogit = require('neogit')
neogit.setup({
  disable_signs = false,
  disable_hint = false,
  disable_context_highlighting = false,
  disable_commit_confirmation = true,
  auto_refresh = true,
  disable_builtin_notifications = false,
  disable_insert_on_commit = false,
  use_magit_keybindings = true,
  commit_popup = {
      kind = "split",
  },
  -- Change the default way of opening neogit
  kind = "tab",
  -- customize displayed signs
  signs = {
    -- { CLOSED, OPENED }
    section = { ">", "v" },
    item = { ">", "v" },
    hunk = { "H", "U" },
  },
  integrations = {
    -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
    -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
    diffview = true
  },
  -- override/add mappings
  mappings = {
    -- modify status buffer mappings
    status = {
      -- Adds a mapping with "B" as key that does the "BranchPopup" command
      ["B"] = "BranchPopup",
      -- Removes the default mapping of "s"
      -- ["s"] = "",
    },
  },
})

-- gitsigns / coloring / hilight
vim.cmd("highlight DiffAdd ctermfg=151 ctermbg=0 guifg=#33FF33 guibg=#000000")
vim.cmd("highlight DiffDelete ctermfg=183 ctermbg=0 guifg=#FF3333 guibg=#000000")
vim.cmd("highlight DiffChange ctermfg=181 ctermbg=0 guifg=#FFFF33 guibg=#000000")
require('gitsigns').setup()
require'colorizer'.setup()

-------------------- CODE-FOLDING ---------------------------
utils.opt('w', 'foldcolumn', '1')
utils.opt('w', 'foldlevel', 99)
utils.opt('w', 'foldenable', true)

-- tell the sever the capability of foldingRange
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
require('ufo').setup()

-------------------- TREE-SITTER ---------------------------

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require('telescope').load_extension('dap')
require('telescope').load_extension('projects')

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

-- Status line helper
local gps = require("nvim-gps")
gps.setup()

require('plugins/dap')

