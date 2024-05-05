local status, ibl = pcall(require, "ibl")
if not status then
  vim.notify("can't find indent_blankline", "error", { title = "Plugin" })
  return
end

ibl.setup({
  exclude = {
    filetypes = {
      "help",
      "alpha",
      "dashboard",
      "neo-tree",
      "Trouble",
      "trouble",
      "lazy",
      "mason",
      "notify",
      "toggleterm",
      "lazyterm",
    },
  },
  indent = {
    char = "│",
  },
})
