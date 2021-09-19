local utils = require('utils')

local cmd = vim.cmd
local indent, width = 2, 120

cmd 'syntax enable'
cmd 'filetype plugin indent on'
cmd 'colorscheme jellyx'

utils.opt('b', 'expandtab', true)
utils.opt('b', 'shiftwidth', indent)
utils.opt('b', 'smartindent', true)
utils.opt('b', 'tabstop', indent)

utils.opt('w', 'number', true)
-- utils.opt('w', 'relativenumber', true)

utils.opt('o', 'clipboard','unnamed,unnamedplus')
--utils.opt('o', 'completeopt', "menuone,noinsert,noselect" )    -- Completion options
utils.opt('o', 'completeopt', "menu,menuone,noselect" )    -- Completion options in cmp

utils.opt('o', 'cursorline', true)
utils.opt('o', 'formatoptions', 'crqnj')        -- Automatic formatting options
utils.opt('o', 'hidden', true)
utils.opt('o', 'ignorecase', true)
utils.opt('o', 'scrolloff', 4 )
utils.opt('o', 'shiftround', true)
utils.opt('o', 'smartcase', true)
utils.opt('o', 'joinspaces', true)
utils.opt('o', 'signcolumn', 'yes')
utils.opt('o', 'smartindent', true)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('o', 'termguicolors', true)
utils.opt('o', 'joinspaces', true)
utils.opt('o', 'list', true)        -- Show some invisible characters
utils.opt('o', 'pumheight', 12)     -- 
utils.opt('o', 'scrolloff', 4)      -- 
utils.opt('o', 'colorcolumn', tostring(width))                 -- Line length marker
utils.opt('o', 'shiftround', true)              -- Round indent
utils.opt('o', 'shiftwidth', indent)            -- Size of an indent
utils.opt('o', 'shortmess', 'atToOFc')          -- Prompt message options
utils.opt('o', 'sidescrolloff', 8)              -- Columns of context
utils.opt('o', 'textwidth', width)              -- Maximum width of text
utils.opt('o', 'updatetime', 100)               -- Delay before swap file is saved
utils.opt('o', 'wildmode', 'list:longest')      -- Command-line completion mode
utils.opt('o', 'wrap', false)       -- Disable line wrap

utils.opt('o', 'undodir', vim.fn.stdpath("cache") .. '/undodir')
utils.opt('o', 'undofile', true)

-- print(vim.fn.stdpath("config"))
-- print(vim.fn.stdpath("data"))
-- print(vim.fn.stdpath("cache"))
-- print(vim.fn.stdpath("config_dirs"))

-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
