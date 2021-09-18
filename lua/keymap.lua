
local utils = require('utils')

-- general
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

utils.map('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
utils.map('i', 'jk', '<Esc>')           -- jk to escape

-- inoremap <silent><expr> <CR> compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })
-- utils.map('i', '<CR>', [[compe#confirm('<CR>')]], {expr = true, silent = true})
