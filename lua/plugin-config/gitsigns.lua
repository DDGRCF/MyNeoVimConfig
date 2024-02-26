local status_gitsigns, gitsigns = pcall(require, "gitsigns")
if not status_gitsigns then
	require("notify")("can't find gitsigns")
	return
end

local M = {}

local git_symbols = {
	added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
	modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
	deleted = "✖", -- this can only be used in the git_status source
	renamed = "󰁕", -- this can only be used in the git_status source
	-- Status type
	untracked = "",
	ignored = "",
	unstaged = "󰄱",
	staged = "",
	conflict = "",
}

M.icons = git_symbols

gitsigns.setup({
	signs = {
		add = { text = git_symbols.added },
		change = { text = git_symbols.modified },
		delete = { text = git_symbols.deleted },
		topdelete = { text = git_symbols.deleted },
		changedelete = { text = git_symbols.modified },
		untracked = { text = git_symbols.untracked },
	},
	signcolumn = true,
	current_line_blame = true,
})


return M
