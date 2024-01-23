local status_flash, flash = pcall(require, "flash")
if not status_flash then
  require("notify")("can't find flash")
  return
end

---@type Flash.Config
flash.setup({})
