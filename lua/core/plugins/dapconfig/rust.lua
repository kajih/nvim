local log = require('plenary.log').new { plugin = 'dapconfig', level = vim.g.log_level }
local dap = require 'dap'

require 'core/plugins/dapconfig/cpp'
dap.configurations.rust = dap.configurations.cpp
