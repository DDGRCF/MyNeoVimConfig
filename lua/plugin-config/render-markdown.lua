local status, markdown = pcall(require, "render-markdown")
if not status then
	vim.notify("can't find markdown", "error", { title = "Plugin" })
	return
end

markdown.setup({})
