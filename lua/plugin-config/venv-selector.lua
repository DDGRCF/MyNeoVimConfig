local status_venv_selector, venv_selector = pcall(require, "venv-selector")
if not status_venv_selector then
	vim.notify("can't find venv-selector", "error", { title = "Plugin" })
	return
end

venv_selector.setup({
	settings = {
		search = {
			anaconda_base = {
				command = "fd /python$ ~/ --full-path --color never -E /proc",
				type = "anaconda",
			},
		},
	},
})
