local staus_surround, surround = pcall(require, "mini.surround")
if not staus_surround then
	vim.notify("can't find mini.surround", "error", { title = "Plugin" })
	return
end

surround.setup({
	mappings = require("keybindings").surround,
})
