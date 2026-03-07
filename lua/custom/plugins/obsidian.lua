return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- use latest release, remove to use latest commit
  ft = 'markdown',
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/Documents/vaults/personal',
      },
    },
  },
}
