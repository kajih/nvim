
local utils = require('utils')

-- general
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

nnoremap('<C-l>', ':noh<CR>', "silent")
inoremap('jk', '<Esc>', "silent")

-- Move selection and reindent
vnoremap('<C-j>', ":m '>+1<CR>gv=gv")
vnoremap('<C-k>', ":m '<-2<CR>gv=gv")
nnoremap('<C-j>', ":m +1<CR>==")
nnoremap('<C-k>', ":m -2<CR>==")

-- yank to end of line include wrap
nnoremap('Y', 'yg$')

-- put search match in mid screen
nnoremap('n', 'nzzzv')
nnoremap('N', 'Nzzzv')

-- mark z, join line, go to z
nnoremap('J', 'mzJ`z')

-- Window resizing
nnoremap('<A-h>', '<C-w>h', "silent")
nnoremap('<A-j>', '<C-w>j', "silent")
nnoremap('<A-k>', '<C-w>k', "silent")
nnoremap('<A-l>', '<C-w>l', "silent")
noremap('<leader>sh', ':<C-u>split<CR>')
noremap('<leader>sv', ':<C-u>vsplit<CR>')

map('ä','[')
map('ö',']')

nnoremap('<F1>', function() require("harpoon.ui").toggle_quick_menu() end)
nnoremap('<F2>', ':Telescope projects<CR>')
nnoremap('<F3>', function() require("neogit").open() end)

-- Buffer nav
-- noremap <leader>z :bp<CR>
-- noremap <leader>x :bn<CR>

nnoremap(']b', ':bn<CR>')
nnoremap('[b', ':bp<CR>')
nnoremap('<leader>z', ':bp<CR>')
nnoremap('<leader>x', ':bn<CR>')

-- Close buffer
nnoremap('<leader>bd', ':bd<CR>')

nnoremap('<C-Down>',  '<C-w>2+')
nnoremap('<C-Left>',  '<C-w>2>')
nnoremap('<C-Right>', '<C-w>2<')
nnoremap('<C-Up>',    '<C-w>2-')

nnoremap('<leader>h', ':wincmd h<CR>')
nnoremap('<leader>j', ':wincmd j<CR>')
nnoremap('<leader>k', ':wincmd k<CR>')
nnoremap('<leader>l', ':wincmd l<CR>')


-- HARPOON
nnoremap("<leader>pa",function() require("harpoon.mark").add_file() end,"silent", "Harpoon Mark")
nnoremap("<leader>pq",function() require("harpoon.ui").toggle_quick_menu() end,"silent", "Harpoon Ui")
nnoremap("<leader>p1",function() require("harpoon.ui").nav_file(1) end,"silent", "Harpoon File 1")
nnoremap("<leader>p2",function() require("harpoon.ui").nav_file(2) end,"silent", "Harpoon File 2")
nnoremap("<leader>p3",function() require("harpoon.ui").nav_file(3) end,"silent", "Harpoon File 3")
nnoremap("<leader>p4",function() require("harpoon.ui").nav_file(4) end,"silent", "Harpoon File 4")

-- FTerm
nnoremap("<A-i>",function() require("FTerm").toggle() end, "silent", "Open FTerm")
