-- GoPls / CodeLens
-- https://github.com/ldelossa/dotfiles/blob/master/nvim/nvim-lsp.lua 

local nvim_lsp = require('lspconfig')
local lsp_installer = require("nvim-lsp-installer")
local utils = require('utils')

local common_on_attach = function(client, bufnr)

  print("Attaching " .. client.name)

  cfg = { close_timeout = 20000, } -- 20s timeout on last signature/argument
  require "lsp_signature".on_attach(cfg, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=false }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>aa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<Leader>fe', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  buf_set_keymap('n', '<leader>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<Leader>ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<Leader>ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
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
end

lsp_installer.on_server_ready(function(server)
  local opts = {
      on_attach = common_on_attach,
      flags = {
        debounce_text_changes = 500,
      }
  }

  -- (optional) Customize the options passed to the server
  -- if server.name == "tsserver" then
  --     opts.root_dir = function() ... end
  -- end

  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)

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

-- golang specific nvim-lsp
--[[

vim.fn.sign_define('LspDiagnosticsSignError', { text = "", texthl = "LspDiagnosticsDefaultError" })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = "", texthl = "LspDiagnosticsDefaultWarning" })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = "", texthl = "LspDiagnosticsDefaultInformation" })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = "", texthl = "LspDiagnosticsDefaultHint" })

vim.api.nvim_command('set shortmess+=c')
vim.api.nvim_command('autocmd BufEnter,CursorHold,InsertLeave * lua vim.lsp.codelens.refresh()')
vim.api.nvim_command('sign define LspDiagnosticsSignError text=🄴  texthl=Error linehl= numhl=')
vim.api.nvim_command('sign define LspDiagnosticsSignWarning text=🅆  texthl=Warning linehl= numhl=')
vim.api.nvim_command('sign define LspDiagnosticsSignInformation text=🄸  texthl=LspDiagnosticsSignInformation linehl= numhl=')
vim.api.nvim_command('sign define LspDiagnosticsSignHint text=🄷  texthl=LspDiagnosticsSignHint linehl= numhl=')


nvim_lsp["gopls"].setup {
  on_attach = on_attach, 
  flags = {
      debounce_text_changes = 150,
  },
  settings = {
      gopls = {
        experimentalPostfixCompletions = true,
        codelenses = {
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
          generate = true,
          gc_details = true,
       },
     },
   },
}


function goimports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports", "textDocument/Formatting"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit)
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.api.nvim_command('autocmd BufWritePre *.go lua goimports(1000)')
vim.api.nvim_command('autocmd BufWritePre *.go silent lua vim.lsp.buf.formatting()')
]]--
