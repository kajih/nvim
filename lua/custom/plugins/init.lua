return {
  -- leap.nvim
  -- sneak like, because sneak is available for eclipse and idea
  {
    'ggandor/leap.nvim',
    dependencies = { 'tpope/vim-repeat', keys = { '.' } },
    config = function(_, opts)
      local leap = require 'leap'
      leap.add_default_mappings(true)
      leap.add_repeat_mappings(';', ',', {
        relative_directions = true,
        modes = { 'n', 'x', 'o' },
      })
      vim.keymap.del({ 'x', 'o' }, 'x')
      vim.keymap.del({ 'x', 'o' }, 'X')
    end,
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('harpoon').setup()
      require('telescope').load_extension 'harpoon'
    end,
  },
}
