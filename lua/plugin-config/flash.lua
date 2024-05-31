local status_flash, flash = pcall(require, "flash")
if not status_flash then
	vim.notify("can't find flash", "error", { title = "Plugin" })
	return
end

---@type Flash.Config
flash.setup({})
