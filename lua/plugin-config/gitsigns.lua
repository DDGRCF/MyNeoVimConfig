local status_gitsigns, gitsigns = pcall(require, "gitsigns")
if not status_gitsigns then
	vim.notify("can't find gitsigns", "error", { title = "Plugin" })
	return
end

local M = {}

local git_symbols = {
	added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
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
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
	},
	signcolumn = true,
	current_line_blame = true,
})


return M
