return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Keep: telescope-powered overrides not covered by 0.11 defaults
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Superseded by Neovim 0.11 defaults — reminders to use new binds
          -- grr = references, gri = implementations, grn = rename, gra = code action, gO = document symbols, K = hover
          map('gr', function() vim.notify('gr → use grr (Neovim 0.11 default: references)', vim.log.levels.WARN) end, 'Renamed: use grr')
          map('gI', function() vim.notify('gI → use gri (Neovim 0.11 default: implementations)', vim.log.levels.WARN) end, 'Renamed: use gri')
          map('<leader>rn', function() vim.notify('<leader>rn → use grn (Neovim 0.11 default: rename)', vim.log.levels.WARN) end, 'Renamed: use grn')
          map('<leader>ca', function() vim.notify('<leader>ca → use gra (Neovim 0.11 default: code action)', vim.log.levels.WARN) end, 'Renamed: use gra')
          map('<leader>ds', function() vim.notify('<leader>ds → use gO (Neovim 0.11 default: document symbols)', vim.log.levels.WARN) end, 'Renamed: use gO')
          -- K (hover) is a Neovim 0.10+ default — no reminder needed, just removed

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method('textDocument/documentHighlight') then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        rust_analyzer = {
          on_attach = function(_, bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end,

          settings = {
            ['rust-analyzer'] = {
              checkOnSave = {
                enable = true,
                command = 'check',
                extraArgs = {
                  '--target-dir',
                  '/tmp/rust-analyzer-check',
                },
              },
            },
          },
        },

        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      --  You can press `g?` for help in this menu
      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
