-- GoPls / CodeLens
-- https://github.com/ldelossa/dotfiles/blob/master/nvim/nvim-lsp.lua

local nvim_lsp = require('lspconfig')
local lsp_installer = require("nvim-lsp-installer")
local utils = require('utils')

-- Callback function for when the LSP attaches
local common_on_attach = function(client, bufnr)
  print("Attaching " .. client.name)
  require('langserv_keymap')

  cfg = { close_timeout = 20000, } -- 20s timeout on last signature/argument
  require("lsp_signature").on_attach(cfg, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Set some keybinds conditional on server capabilities
  local opts = { noremap=true, silent=false }
  if client.server_capabilities.document_formatting then
    buf_set_keymap("n", "<Leader>ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.server_capabilities.document_range_formatting then
    buf_set_keymap("v", "<Leader>ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red gui=bold guifg=white
      hi LspReferenceText cterm=bold ctermbg=red gui=bold
      hi LspReferenceWrite cterm=bold ctermbg=red gui=bold guifg=red
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end -- //common_on_attach

lsp_installer.setup ({
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
  ui = {
    icons = {
        server_installed = "✓",
        server_pending = "➜",
        server_uninstalled = "✗"
    },
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      uninstall_server = "X",
    },
  },
})

local srv = lsp_installer.get_installed_servers()
for _, lsp in pairs(srv) do
  -- nvim_lsp[lsp.name].setup {}
  nvim_lsp[lsp.name].setup({ on_attach = common_on_attach })
end

-- nvim_lsp.sumneko_lua.setup {}
-- nvim_lsp.tsserver.setup {}
-- require('go').setup()
-- require('rust-tools').setup({server = { on_attach = common_on_attach }})
-- require("crates").setup()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "»",
      spacing = 1,
    },
    severity_sort = true,
    underline = true,
    signs = true,
    update_in_insert = false,
  }
)

