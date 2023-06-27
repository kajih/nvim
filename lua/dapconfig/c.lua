local log = require('plenary.log').new { plugin = 'dapconfig', level = vim.g.log_level }
local dap = require 'dap'

require('dapconfig/cpp')
dap.configurations.c = dap.configurations.cpp
