return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  lazy = false,
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'rust', 'go', 'python' },
    highlight = { enable = true },
  },
}
