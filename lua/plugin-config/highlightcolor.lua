local status_highlightcolor, highlightcolor = pcall(require, "nvim-highlight-colors")
if not status_highlightcolor then
	vim.notify("can't find gitsigns", "error", { title = "Plugin" })
	return
end

highlightcolor.setup({})
