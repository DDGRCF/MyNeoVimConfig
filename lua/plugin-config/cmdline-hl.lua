local status_cmdlinehl, cmdlinehl = pcall(require, "cmdline-hl")
if not status_cmdlinehl then
  vim.notify("can't find cmdline-hl", "error", { title = "Plugin" })
  return
end

cmdlinehl.setup({})
