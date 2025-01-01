-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', 'Q', '@@')
vim.keymap.set('n', 'L', '$')
vim.keymap.set('n', 'H', '^')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '<C-l>', '<cmd>noh<CR>', { silent = true })
vim.keymap.set('i', 'jk', '<Esc>', { silent = true })

-- CTags go to tag
vim.keymap.set('', '[g', 'g[', { noremap = true })
vim.keymap.set('', ']g', 'g]', { noremap = true })
vim.keymap.set('', ']t', ':tn<CR>', { noremap = true })
vim.keymap.set('', '[t', ':tp<CR>', { noremap = true })
-- Langmap equ
vim.keymap.set('', 'ög', 'g[', { noremap = true })
vim.keymap.set('', 'äg', 'g]', { noremap = true })
vim.keymap.set('', 'öt', ':tn<CR>', { noremap = true })
vim.keymap.set('', 'ät', ':tp<CR>', { noremap = true })

vim.keymap.set('n', '<leader>tn', ':tn<CR>')
vim.keymap.set('n', '<leader>tp', ':tp<CR>')

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<M-j>', ':m +1<CR>==')
vim.keymap.set('n', '<M-k>', ':m -2<CR>==')

vim.keymap.set('n', '[b', ':bp<CR>')
vim.keymap.set('n', ']b', ':bn<CR>')
-- Langmap equ
vim.keymap.set('n', 'öb', ':bp<CR>')
vim.keymap.set('n', 'äb', ':bn<CR>')

-- Close buffer
-- vim.keymap.set('n', '<leader>bd', ':bd<CR>')

vim.keymap.set('n', '<leader>xh', ':<C-u>split<CR>')
vim.keymap.set('n', '<leader>xv', ':<C-u>vsplit<CR>')

vim.keymap.set('n', '<C-Down>', '<C-w>2+')
vim.keymap.set('n', '<C-Left>', '<C-w>2>')
vim.keymap.set('n', '<C-Right>', '<C-w>2<')
vim.keymap.set('n', '<C-Up>', '<C-w>2-')

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<leader>h', '<cmd>wincmd h<CR>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>j', '<cmd>wincmd j<CR>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>k', '<cmd>wincmd k<CR>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>l', '<cmd>wincmd l<CR>', { desc = 'Move focus to the right window' })

-- FKEYS
vim.keymap.set('n', '<F2>', ':Telescope projects<CR>')

-- BarBar
vim.keymap.set('n', '<A-h>', '<Cmd>BufferPrevious<CR>')
vim.keymap.set('n', '<A-l>', '<Cmd>BufferNext<CR>')
vim.keymap.set('n', '<A-H>', '<Cmd>BufferMovePrevious<CR>')
vim.keymap.set('n', '<A-L>', '<Cmd>BufferMoveNext<CR>')
vim.keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>')
vim.keymap.set('n', '<C-c>', '<Cmd>BufferClose<CR>')

-- FTerm keybindinds
vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

vim.keymap.set('n', '<leader>nf', ':Neoformat<CR>')

-- LSP
vim.keymap.set('n', '<leader>la', '<CMD>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<leader>li', '<CMD>:LspInfo<CR>')

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })

vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous [D]iagnostic message' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next [D]iagnostic message' })

-- Langmap equ
vim.keymap.set('n', 'öd', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous [D]iagnostic message' })

vim.keymap.set('n', 'äd', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next [D]iagnostic message' })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

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
