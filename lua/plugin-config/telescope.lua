local status_telescope, telescope = pcall(require, "telescope")
if not status_telescope then
	vim.notify("can't find telescope", "error", { title = "Plugin" })
	return
end

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		initial_mode = "insert",
		mappings = require("keybindings").telescopeList,
	},
	pickers = {
		find_files = {
			hidden = false,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("notify")
