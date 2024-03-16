local status_illuminate, illuminate = pcall(require, "illuminate")
if not status_illuminate then
  vim.notify("can't find illuminate", "error", { title = "Plugin" })
  return
end

illuminate.configure({
  delay = 200,
  large_file_cutoff = 2000,
  large_file_overrides = {
    providers = { "lsp", "treesitter", "regex" },
  },
})
