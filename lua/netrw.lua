vim.keymap.set('n', '-', '<cmd>Lexplore<CR>', { remap = true })

local function netrw_mapping()
  vim.keymap.set('n', 'H', 'u', { buffer = true, remap = true })
  vim.keymap.set('n', 'h', '-^', { buffer = true, remap = true })
  vim.keymap.set('n', 'l', '<CR>', { buffer = true, remap = true })
  vim.keymap.set('n', '.', 'gh', { buffer = true, remap = true })
  vim.keymap.set('n', 'P', '<C-w>z', { buffer = true, remap = true })
  vim.keymap.set('n', '-', '<cmd>Lexplore<CR>', { buffer = true, remap = true })
end

local user_cmds = vim.api.nvim_create_augroup('user_cmds', { clear = true })
vim.api.nvim_create_autocmd('filetype', {
  pattern = 'netrw',
  group = user_cmds,
  desc = 'Keybindings for netrw',
  callback = netrw_mapping,
})
