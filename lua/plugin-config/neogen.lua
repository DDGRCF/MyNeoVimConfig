local status_neogen, neogen = pcall(require, "neogen")
if not status_neogen then
	vim.notify("can't find neogen", "error", { title = "Plugin" })
	return
end

neogen.setup({
	enabled = true,
	snippet_engine = "luasnip",
	input_after_comment = true,
})
