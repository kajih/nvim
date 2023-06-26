local log = require('plenary.log').new { plugin = 'dapconfig', level = vim.g.log_level }
local dap = require 'dap'

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode-14', -- adjust as needed, must be absolute path
  name = 'lldb',
}

dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = { 'dap', '-l', '127.0.0.1:${port}' },
  },
}

dap.configurations.go = {
  {
    type = 'delve',
    name = 'Debug',
    request = 'launch',
    program = '${file}',
  },
  {
    type = 'delve',
    name = 'Debug test', -- configuration for debugging test files
    request = 'launch',
    mode = 'test',
    program = '${file}',
  },
  -- works with go.mod packages and sub packages
  {
    type = 'delve',

    name = 'Debug test (go.mod)',
    request = 'launch',
    mode = 'test',
    program = './${relativeFileDirname}',
  },
}

dap.configurations.cpp = {
  {
    name = 'Launch',

    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

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
