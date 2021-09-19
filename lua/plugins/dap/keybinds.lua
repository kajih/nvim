
nnoremap('<leader>dt', ':lua require"dap".toggle_breakpoint()<CR>')
nnoremap('<leader>de', ':lua require"dap".set_exception_breakpoints({"all"})<CR>', "silent")
nnoremap('<leader>dH', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")

nnoremap('<F5>', ':lua require"dapui".toggle()<CR>', "silent")
-- nnoremap('<F17>', ':lua require"dap".continue()<CR>', "silent") -- Shift F5
nnoremap('<F29>', ':lua require"dap".continue()<CR>', "silent") -- Ctrl F5

nnoremap('<F9>', ':lua require"dap".step_over()<CR>', "silent")
nnoremap('<F21>', ':lua require"dap".step_into()<CR>', "silent") -- Shift F9
nnoremap('<F33>', ':lua require"dap".step_out()<CR>', "silent")  -- Ctrl F9

nnoremap('<leader>dk', ':lua require"dap".up()<CR>', "silent")
nnoremap('<leader>dj', ':lua require"dap".down()<CR>', "silent")
nnoremap('<leader>dc', ':lua require"dap".disconnect({ terminateDebuggee = true });require"dap".close()<CR>', "silent")
nnoremap('<leader>dr', ':lua require"dap".repl.open({}, "vsplit")<CR><C-w>l', "silent")
nnoremap('<leader>di', ':lua require"dap.ui.variables".hover()<CR>', "silent")
nnoremap('<leader>dI', ':lua require"dap.ui.variables".visual_hover()<CR>', "silent")
nnoremap('<leader>dl', ':lua require"dap".run_last()<CR>', "silent")
nnoremap('<leader>d?', ':lua require"dap.ui.variables".scopes()<CR>', "silent")
-- utils.map('n', '<leader>da', ':lua require"debugHelper".attach()<CR>')
-- utils.map('n', '<leader>dA', ':lua require"debugHelper".attachToRemote()<CR>')
nnoremap('<leader>di', ':lua require"dap.ui.widgets".hover()<CR>', "silent")
nnoremap('<leader>d?', ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>', "silent")


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

