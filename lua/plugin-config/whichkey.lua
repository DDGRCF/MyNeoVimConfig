local status_whichkey, whickkey = pcall(require, "which-key")
if not status_whichkey then
  vim.notify("can't find which-key", "error", { title = "Plugin" })
  return
end

whickkey.setup({

})
