-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '<C-l>', ':noh<CR>', { silent = true })
vim.keymap.set('i', 'jk', '<Esc>', { silent = true })

vim.keymap.set('', 'ö', '[', { remap = true })
vim.keymap.set('', 'ä', ']', { remap = true })
vim.keymap.set('', 'Ö', '{', { remap = true })
vim.keymap.set('', 'Ä', '}', { remap = true })

vim.keymap.set('', 'gö', 'g[', { remap = true })
vim.keymap.set('', 'gä', 'g]', { remap = true })

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<M-j>', ':m +1<CR>==')
vim.keymap.set('n', '<M-k>', ':m -2<CR>==')

vim.keymap.set('n', ']b', ':bn<CR>')
vim.keymap.set('n', '[b', ':bp<CR>')

-- Close buffer
-- vim.keymap.set('n', '<leader>bd', ':bd<CR>')

vim.keymap.set('n', '<leader>xh', ':<C-u>split<CR>')
vim.keymap.set('n', '<leader>xv', ':<C-u>vsplit<CR>')

vim.keymap.set('n', '<C-Down>', '<C-w>2+')
vim.keymap.set('n', '<C-Left>', '<C-w>2>')
vim.keymap.set('n', '<C-Right>', '<C-w>2<')
vim.keymap.set('n', '<C-Up>', '<C-w>2-')

vim.keymap.set('n', '<leader>h', ':wincmd h<CR>')
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>')
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>')
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>')

-- FKEYS
vim.keymap.set('n', '<F1>', function()
  require('harpoon.ui').toggle_quick_menu()
end)
vim.keymap.set('n', '<F2>', ':Telescope projects<CR>')

-- HARPOON
vim.keymap.set('n', '<leader>pa', function()
  require('harpoon.mark').add_file()
end)
vim.keymap.set('n', '<leader>pq', function()
  require('harpoon.ui').toggle_quick_menu()
end)
vim.keymap.set('n', '<leader>p1', function()
  require('harpoon.ui').nav_file(1)
end)
vim.keymap.set('n', '<leader>p2', function()
  require('harpoon.ui').nav_file(2)
end)
vim.keymap.set('n', '<leader>p3', function()
  require('harpoon.ui').nav_file(3)
end)
vim.keymap.set('n', '<leader>p4', function()
  require('harpoon.ui').nav_file(4)
end)

-- BarBar
vim.keymap.set('n', '<A-h>', '<Cmd>BufferPrevious<CR>')
vim.keymap.set('n', '<A-l>', '<Cmd>BufferNext<CR>')
vim.keymap.set('n', '<A-H>', '<Cmd>BufferMovePrevious<CR>')
vim.keymap.set('n', '<A-L>', '<Cmd>BufferMoveNext<CR>')
vim.keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>')
vim.keymap.set('n', '<C-c>', '<Cmd>BufferClose<CR>')

-- Hop
local hop = require 'hop'
local directions = require('hop.hint').HintDirection
hop.setup { keys = 'etovxqpdygfblzhckisuran' }

vim.keymap.set('', 's', function()
  hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = false }
end, { remap = true })

vim.keymap.set('', 'S', function()
  hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = false }
end, { remap = true })

-- FTerm keybindinds
vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

vim.keymap.set('n', '<leader>nf', ':Neoformat<CR>')

-- LSP
vim.keymap.set('n', '<leader>la', '<CMD>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<leader>li', '<CMD>:LspInfo<CR>')

vim.keymap.set('n', '<F4>', function()
  vim.lsp.buf.code_action()
end)

-- DAP keybinds
vim.keymap.set('n', '<F3>', function()
  require('dapui').toggle()
end)
vim.keymap.set('n', '<F5>', function()
  require('dap').continue()
end)
vim.keymap.set('n', '<F10>', function()
  require('dap').step_over()
end)
vim.keymap.set('n', '<F11>', function()
  require('dap').step_into()
end)
vim.keymap.set('n', '<F12>', function()
  require('dap').step_out()
end)

vim.keymap.set('n', '<leader>b', function()
  require('dap').toggle_breakpoint()
end)
vim.keymap.set('n', '<leader>B', function()
  require('dap').set_breakpoint()
end)
vim.keymap.set('n', '<leader>dL', function()
  require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
end)
vim.keymap.set('n', '<leader>dr', function()
  require('dap').repl.open()
end)
vim.keymap.set('n', '<leader>dl', function()
  require('dap').run_last()
end)
vim.keymap.set({ 'n', 'v' }, '<leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<leader>df', function()
  local widgets = require 'dap.ui.widgets'
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<leader>ds', function()
  local widgets = require 'dap.ui.widgets'
  widgets.centered_float(widgets.scopes)
end)
