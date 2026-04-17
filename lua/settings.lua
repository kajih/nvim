-- [[ Setting options ]]
-- See `:help vim.o`

local indent, width = 2, 0

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = indent

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
vim.opt.hlsearch = true

vim.opt.shiftwidth = indent
vim.opt.colorcolumn = '+1'
vim.opt.textwidth = width
vim.opt.wrap = false

vim.wo.number = true -- Make line numbers default
vim.wo.signcolumn = 'yes'

vim.opt.termguicolors = true
vim.opt.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience

vim.opt.langmap = 'öäÖÄ;[]{}'

-- Folding via built-in treesitter (replaces nvim-ufo)
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
