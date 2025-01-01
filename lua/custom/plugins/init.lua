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
      local harpoon = require 'harpoon'
      harpoon:setup()
      require('telescope').load_extension 'harpoon'

      vim.keymap.set('n', '<leader>pa', function()
        harpoon:list():add()
      end)

      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set('n', '<C-h>', function()
        harpoon:list():select(1)
      end)

      vim.keymap.set('n', '<C-t>', function()
        harpoon:list():select(2)
      end)

      vim.keymap.set('n', '<C-n>', function()
        harpoon:list():select(3)
      end)

      vim.keymap.set('n', '<C-s>', function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<C-S-P>', function()
        harpoon:list():prev()
      end)

      vim.keymap.set('n', '<C-S-N>', function()
        harpoon:list():next()
      end)
    end,
  },
}
