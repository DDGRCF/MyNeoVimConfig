local status_venv_selector, venv_selector = pcall(require, "venv-selector")
if not status_venv_selector then
	vim.notify("can't find venv-selector", "error", { title = "Plugin" })
	return
end

venv_selector.setup({
	name = {
		"venv",
		".venv",
		"env",
		".env",
	},
	dap_enabled = true,
	anaconda_base_path = "~/Anaconda3", -- NOTE: change according to your system
	anaconda_envs_path = "~/Anaconda3/envs", -- NOTE: change according to your system
})
