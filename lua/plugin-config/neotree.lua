local status_neo_tree, neo_tree = pcall(require, "neo-tree")
if not status_neo_tree then
	require("notify")("can't find neo-tree")
	return
end

local status_keybindings, keybindings = pcall(require, "keybindings")
if not status_keybindings then
	require("notify")("can't find keybindings")
	return
end

-- neo-tree 配置参数
-- https://github.com/nvim-neo-tree/neo-tree.nvim.git
local keymappings = keybindings.neoTree
local neo_tree_config = {
	sources = {
		"filesystem",
		"document_symbols",
		"buffers",
		"git_status",
	},
	open_files_do_not_replace_types = {
		"terminal",
		"qf",
		"trouble",
	},
	filesystem = {
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
		use_libuv_file_watcher = true,
	},
	document_symbols = {
		follow_cursor = false
	},
	source_selector = {
		winbar = true,
		statusline = false,
		sources = {
			{
				source = "filesystem", -- string
				display_name = " 󰉓 Files ", -- string | nil
			},
			{
				source = "buffers", -- string
				display_name = " 󰈚 Buffers ", -- string | nil
			},
			{
				source = "git_status", -- string
				display_name = " 󰊢 Git ", -- string | nil
			},
			{
				source = "document_symbols",
				display_name = "  Symbols ",
			},
		},
	},
	git_status = {
		symbols = require("plugin-config.gitsigns").icons,
	},
}

neo_tree_config = vim.tbl_extend("force", neo_tree_config, keymappings)

neo_tree.setup(neo_tree_config)
