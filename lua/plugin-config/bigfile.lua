local status_notify, bigfile = pcall(require, "bigfile")
if not status_notify then
	vim.notify("can't find bigfile", "error", { title = "Plugin" })
	return
end

require("bigfile").setup({
	filesize = 1, -- size of the file in MiB, the plugin round file sizes to the closest MiB
	pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
	features = { -- features to disable
		"indent_blankline",
		"illuminate",
		"lsp",
		"treesitter",
		"syntax",
		"matchparen",
		"vimopts",
		"filetype",
	},
})
