return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  opts = {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "go", "python" },
    highlight = { enable = true },
  },
}
