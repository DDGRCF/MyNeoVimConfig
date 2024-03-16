local status, ibl = pcall(require, "ibl")
if not status then
  vim.notify("can't find indent_blankline", "error", { title = "Plugin" })
  return
end

ibl.setup({
  exclude = {
    filetypes = {
      "dashboard",
      "packer",
      "terminal",
      "help",
      "log",
      "markdown",
      "TelescopePrompt",
      "lsp-installer",
      "lspinfo",
      "toggleterm",
    },
  },
  indent = {
    char = "│",
  },
})
