-- [[ Setting options ]]
-- See `:help vim.o`
local indent, width = 2, 120

vim.b.expandtab = true
vim.b.smartindent = true
vim.b.tabstop = indent
vim.o.shiftwidth = indent
vim.o.colorcolumn = '+1'
vim.o.textwidth = width
vim.o.wrap = false

vim.o.hlsearch = false -- Set highlight on search
vim.wo.number = true -- Make line numbers default
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.breakindent = true -- Enable break indent
vim.o.undofile = true -- Save undo history
vim.o.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.o.smartcase = true
vim.o.updatetime = 250 -- Decrease update time
vim.wo.signcolumn = 'yes'

vim.o.termguicolors = true
vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience

