local status_gotopreview, gotopreview = pcall(require, "goto-preview")

if not status_gotopreview then
  vim.notify("can't find gotopreview", "error", { title = "Plugin" })
  return
end

gotopreview.setup({
  border = {"↖", "─" ,"╮", "│", "╯", "─", "╰", "│"}
})
