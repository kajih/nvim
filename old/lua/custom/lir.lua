local actions = require("lir.actions")
local mark_actions = require("lir.mark.actions")
local clipboard_actions = require("lir.clipboard.actions")

require("lir").setup({
	show_hidden_files = false,
	devicons = {
		enable = true,
		highlight_dirname = true,
	},
	mappings = {
		["l"] = actions.edit,
		["<C-s>"] = actions.split,
		["<C-v>"] = actions.vsplit,
		["<C-t>"] = actions.tabedit,

		["h"] = actions.up,
		["q"] = actions.quit,

		["K"] = actions.mkdir,
		["N"] = actions.newfile,
		["R"] = actions.rename,
		["@"] = actions.cd,
		["Y"] = actions.yank_path,
		["."] = actions.toggle_show_hidden,
		["D"] = actions.delete,

		["J"] = function()
			mark_actions.toggle_mark()
			vim.cmd("normal! j")
		end,
		["C"] = clipboard_actions.copy,
		["X"] = clipboard_actions.cut,
		["P"] = clipboard_actions.paste,
	},
	float = {
		winblend = 0,
		curdir_window = {
			enable = false,
			highlight_dirname = false,
		},

		-- -- You can define a function that returns a table to be passed as the third
		-- -- argument of nvim_open_win().
		-- win_opts = function()
		--   local width = math.floor(vim.o.columns * 0.8)
		--   local height = math.floor(vim.o.lines * 0.8)
		--   return {
		--     border = require("lir.float.helper").make_border_opts({
		--       "+", "─", "+", "│", "+", "─", "+", "│",
		--     }, "Normal"),
		--     width = width,
		--     height = height,
		--     row = 1,
		--     col = math.floor((vim.o.columns - width) / 2),
		--   }
		-- end,
	},
	hide_cursor = true,
})

-- custom folder icon
require("nvim-web-devicons").set_icon({
	lir_folder_icon = {
		icon = "",
		color = "#7ebae4",
		name = "LirFolderNode",
	},
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "-", [[<Cmd>execute 'e ' .. expand('%:p:h')<CR>]], { silent = true })

-- use visual mode
function _G.LirSettings()
	vim.api.nvim_buf_set_keymap(
		0,
		"x",
		"J",
		':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
		{ noremap = true, silent = true }
	)

	-- echo cwd
	vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
end

-- :lua require'lir.float'.toggle()
-- :lua require'lir.float'.init()

require("lir.git_status").setup({
	show_ignored = true,
})

vim.cmd([[augroup lir-settings]])
vim.cmd([[  autocmd!]])
vim.cmd([[  autocmd Filetype lir :lua LirSettings()]])
vim.cmd([[augroup END]])
