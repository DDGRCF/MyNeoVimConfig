local status, supermaven = pcall(require, "supermaven-nvim")
if not status then
	vim.notify("can't find supermaven", "error", { title = "Plugin" })
	return
end

supermaven.setup({})
