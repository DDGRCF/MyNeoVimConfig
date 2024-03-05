local status_venv_selector, venv_selector = pcall(require, "venv-selector")
if not status_venv_selector then
	require("notify")("can't find venv-selector")
	return
end

-- TODO: figure it out
venv_selector.setup({
	name = {
		"venv",
		".venv",
		"env",
		".env",
	},
	auto_refresh = true,
	dap_enabled = true,
})


