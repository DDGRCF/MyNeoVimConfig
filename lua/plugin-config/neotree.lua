local status_neo_tree, neo_tree = pcall(require, "neo-tree")
if not status_neo_tree then
	vim.notify("can't find neo-tree", "error", { title = "Plugin" })
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
    bind_to_cwd = false, -- true creates a 2-way binding between vim's cwd and neo-tree's root
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
		use_libuv_file_watcher = true,
	},
	document_symbols = {
		follow_cursor = false,
	},
	source_selector = {
		winbar = true,
		statusline = false,
		sources = {
			{
				source = "filesystem",
				display_name = " 󰈚 Files ",
			},
			{
				source = "git_status",
				display_name = " 󰊢 Git ",
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
