local status_gitsigns, gitsigns = pcall(require, "gitsigns")
if not status_gitsigns then
	vim.notify("can't find gitsigns", "error", { title = "Plugin" })
	return
end

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
