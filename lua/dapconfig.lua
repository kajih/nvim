local dap = require 'dap'

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode-14', -- adjust as needed, must be absolute path
  name = 'lldb',
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

vim.keymap.set('n', '<F3>', function()
  require('dapui').toggle()
end)
vim.keymap.set('n', '<F5>', function()
  require('dap').continue()
end)
vim.keymap.set('n', '<F10>', function()
  require('dap').step_over()
end)
vim.keymap.set('n', '<F11>', function()
  require('dap').step_into()
end)
vim.keymap.set('n', '<F12>', function()
  require('dap').step_out()
end)

vim.keymap.set('n', '<Leader>b', function()
  require('dap').toggle_breakpoint()
end)
vim.keymap.set('n', '<Leader>B', function()
  require('dap').set_breakpoint()
end)
vim.keymap.set('n', '<Leader>dL', function()
  require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
end)
vim.keymap.set('n', '<Leader>dr', function()
  require('dap').repl.open()
end)
vim.keymap.set('n', '<Leader>dl', function()
  require('dap').run_last()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require 'dap.ui.widgets'
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require 'dap.ui.widgets'
  widgets.centered_float(widgets.scopes)
end)
