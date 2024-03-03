-- From
-- https://github.com/MarioCarrion/videos/blob/main/2023/01/nvim/lua/plugins/catppuccin-theme.lua

local present, catppuccin = pcall(require, 'catppuccin')
if not present then
  return
end

vim.opt.termguicolors = true

catppuccin.setup {
  flavour = 'mocha',
  term_colors = true,
  transparent_background = false,
  no_italic = false,
  no_bold = false,
  styles = {
    comments = { 'italic' },
    conditionals = {},
    loops = {},
    functions = { 'italic' },
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = { 'bold' },
  },
  color_overrides = {
    mocha = {
      base = '#0A0A0A', -- background
      -- surface2 = '#9A9A9A', -- comments
      -- text = '#F6F6F6',
      -- surface0 = "#FF0000", -- Indent lines?
      -- surface1 = "#00FF00", -- Line numbers?
    },
  },
  highlight_overrides = {
    mocha = function(C)
      return {
        NvimTreeNormal = { bg = C.none },
        CmpBorder = { fg = C.surface2 },
        Pmenu = { bg = C.none },
        NormalFloat = { bg = C.none },
        TelescopeBorder = { link = 'FloatBorder' },
      }
    end,
  },
}

vim.api.nvim_set_hl(0, 'LspInlayHint', { fg = "#8888FF", bg = "#0F0F0F" })

vim.cmd.colorscheme 'catppuccin-mocha'
