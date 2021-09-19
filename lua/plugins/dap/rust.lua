local dap = require('dap')

--[[ Deprecated I think
local dap = require('dap')
dap.adapters.cppdbg = {
	type = 'executable',
	command = "/opt/debugAdapters/bin/OpenDebugAD7",
} ]]

--[[ Requires lldb-vscode from lldb ]]

dap.adapters.lldb = {
  name = "lldb",
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "lldb",
    request = "launch",
    miDebuggerPath = "gdb",

    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,

    cwd = "${workspaceFolder}",
    stopOnEntry = true,
    args = {},
    
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    -- Otherwise you might get the following error:
    --    Error on launch: Failed to attach to the target process
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
  }
}

dap.configurations.rust = {
  {
      type = 'lldb',
      request = 'launch',
      program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd()..'/', 'file')
      end,
      cwd = '${workspaceFolder}',
      -- terminal = 'integrated',
      sourceLanguages = { 'rust' }
  }
}

dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp
