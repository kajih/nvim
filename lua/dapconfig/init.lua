
require 'dapconfig.bash'
require 'dapconfig.c'
require 'dapconfig.cpp'
require 'dapconfig.go'
require 'dapconfig.rust'

local log = require('plenary.log').new { plugin = 'dapconfig', level = vim.g.log_level }
local dap = require 'dap'

local function dapTarget(config)
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'
  vim.api.nvim_create_user_command('DapTarget', function(opts)
    pickers
      .new(opts, {
        prompt_title = 'Path to executable',
        finder = finders.new_oneshot_job({ 'fd', '--no-ignore', '--type', 'x' }, {}),
        sorter = conf.generic_sorter(opts),

        attach_mappings = function(buffer_number)
          actions.select_default:replace(function()
            actions.close(buffer_number)
            local selection = action_state.get_selected_entry()
            config[1]['program'] = selection[1]
          end)
          return true
        end,
      })
      :find()
  end, { nargs = 0, bang = true })
end

-- Pick target for rust
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function()
    dapTarget(dap.configurations.rust)
  end,
})

-- Pick target for go
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    dapTarget(dap.configurations.go)
  end,
})

-- Pick target for c
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'c',
  callback = function()
    dapTarget(dap.configurations.c)
  end,
})

-- Pick target for cpp
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cpp',
  callback = function()
    dapTarget(dap.configurations.cpp)
  end,
})

vim.fn.sign_define('DapStopped', { text = '', texthl = 'DiagnosticWarn' })
vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticInfo' })
vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DiagnosticError' })
vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticInfo' })
vim.fn.sign_define('DapLogPoint', { text = '.>', texthl = 'DiagnosticInfo' })

-- Catppuccin
local sign = vim.fn.sign_define
sign('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
sign('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
sign('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
