--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--─────────────────────────────────────────────────--
--   Plugin:    Comment.nvim
--   Github:    github.com/numToStr/Comment.nvim
--─────────────────────────────────────────────────--
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--

require("Comment").setup({})

local ft = require("Comment.ft")

ft.set("javascript", { "//%s", "/*%s*/" })
ft.set("yaml", "#%s")

-- Multiple filetypes
ft({ "go", "rust" }, { "//%s", "/*%s*/" })
ft({ "toml", "graphql" }, "#%s")
