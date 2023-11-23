local log = require('plenary.log').new { plugin = 'lspzero', level = vim.g.log_level }

-- LSP
require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = {
    'gopls',
    'lua_ls',
    'rust_analyzer',
    'jdtls',
    'clangd',
  },
}

local lsp = require('lsp-zero').preset {
  manage_nvim_cmp = {
    set_sources = 'recommended',
    set_basic_mappings = true,
    set_extra_mappings = true,
    use_luasnip = true,
    set_format = true,
    documentation_window = true,
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

require('mason-lspconfig').setup_handlers {

  function(server_name) -- default handler (optional)
    require('lspconfig')[server_name].setup({ capabilities = capabilities })
  end,

  ['gopls'] = function()
    require('lspconfig').gopls.setup {
      cmd = { 'gopls' },
      settings = {
        gopls = {
          analyses = {
            nilness = true,
            unusedparams = true,
            unusedwrite = true,
            useany = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          experimentalPostfixCompletions = true,
          gofumpt = true,
          staticcheck = true,
          usePlaceholders = true,
        },
      },
      capabilities = capabilities,
    }
  end,

  ['lua_ls'] = function()
    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
  end,
}

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps { buffer = bufnr }
  --require('lsp-inlayhints').on_attach(client, bufnr)
  require('lsp-inlayhints').on_attach(client, bufnr, false)
  require('lsp_signature').on_attach(client, bufnr)

  -- if client.name == 'jdtls' then
  --   require('jdtls').setup {
  --     cmd = { vim.fn.stdpath 'data' .. '/mason/bin/jdtls' },
  --   }
  --   require('jdtls').setup_dap { hotcodereplace = 'auto' }
  -- end
end)

lsp.setup()

local cmp = require 'cmp'
cmp.setup {
  sources = {
    { name = 'nvim_lsp', priority = 8 },
    { name = 'cmp_tabnine', priority = 8, max_item_count = 3 },
    { name = 'treesitter', priority = 7 },
    { name = 'buffer', priority = 7, keyword_length = 5 },
    { name = 'nvim_lua', priority = 5 },
    { name = 'luasnip', priority = 5 },
    { name = 'path', priority = 4 },
  },
}

-- local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
