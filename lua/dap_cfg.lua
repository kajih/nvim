local utils = require('utils')

local dap = require('dap')
dap.adapters.cppdbg = {
	type = 'executable',
	command = "/opt/debugAdapters/bin/OpenDebugAD7",
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    miDebuggerPath = "gdb",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
  },
  {
    name = "Attach to gdbserver :1234",
    type = "cppdbg",
    request = "launch",
    MIMode = "gdb",
    miDebuggerServerAddress = "localhost:1234",
    miDebuggerPath = "gdb",
    cwd = "${workspaceFolder}",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

print("Setting DAP keybinds")

utils.map('n', '<leader>dh', ':lua require"dap".toggle_breakpoint()<CR>')
utils.map('n', '<leader>dH', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
utils.map('n', '<c-h>', ':lua require"dap".continue()<CR>')  -- Starts debugging
utils.map('n', '<c-j>', ':lua require"dap".step_over()<CR>')
utils.map('n', '<c-l>', ':lua require"dap".step_into()<CR>')
utils.map('n', '<c-k>', ':lua require"dap".step_out()<CR>')
utils.map('n', '<leader>dk', ':lua require"dap".up()<CR>')
utils.map('n', '<leader>dj', ':lua require"dap".down()<CR>')
utils.map('n', '<leader>dc', ':lua require"dap".disconnect({ terminateDebuggee = true });require"dap".close()<CR>')
utils.map('n', '<leader>dr', ':lua require"dap".repl.open({}, "vsplit")<CR><C-w>l')
utils.map('n', '<leader>di', ':lua require"dap.ui.variables".hover()<CR>')
utils.map('n', '<leader>dI', ':lua require"dap.ui.variables".visual_hover()<CR>')
utils.map('n', '<leader>dl', ':lua require"dap".run_last()<CR>')
utils.map('n', '<leader>d?', ':lua require"dap.ui.variables".scopes()<CR>')
utils.map('n', '<leader>de', ':lua require"dap".set_exception_breakpoints({"all"})<CR>')
-- utils.map('n', '<leader>da', ':lua require"debugHelper".attach()<CR>')
-- utils.map('n', '<leader>dA', ':lua require"debugHelper".attachToRemote()<CR>')
utils.map('n', '<leader>di', ':lua require"dap.ui.widgets".hover()<CR>')
utils.map('n', '<leader>d?', ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>')


--[[
      nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
      nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
      nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
      nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
      nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
      nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
      nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
      nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
      nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

]]

require("dapui").setup()
vim.cmd( [[ command! DapToggle :lua require"dapui".toggle() ]] )


