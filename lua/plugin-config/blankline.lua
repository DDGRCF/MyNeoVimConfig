local status, ibl = pcall(require, "ibl")
if not status then
  vim.notify("没有找到 indent_blankline")
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
