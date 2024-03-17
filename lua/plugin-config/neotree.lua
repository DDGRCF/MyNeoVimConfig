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
	open_files_do_not_replace_types = {
		"terminal",
		"qf",
		"trouble",
		"TelescopePrompt",
	},
	sources = {
		"filesystem",
		"document_symbols",
		"git_status",
	},
  window = {
    mappings = keymappings.window.mappings,
  },
	filesystem = {
    commands = keymappings.filesystem.commands,
		bind_to_cwd = false, -- true creates a 2-way binding between vim's cwd and neo-tree's root
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
		use_libuv_file_watcher = true,
    window = {
      mappings = keymappings.filesystem.window.mappings,
      fuzzy_finder_mappings = keymappings.filesystem.window.fuzzy_finder_mappings
    }
	},
	document_symbols = {
		follow_cursor = false,
    commands = keymappings.document_symbols.commands,
    window = {
      mappings = keymappings.document_symbols.window.mappings
    }
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
    window = {
      mappings = keymappings.git_status.mappings
    }
	},
}

neo_tree.setup(neo_tree_config)
