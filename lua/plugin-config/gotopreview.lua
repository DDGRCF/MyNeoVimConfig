local status_gotopreview, gotopreview = pcall(require, "goto-preview")

if not status_gotopreview then
  require("notify")("can't find gotopreview")
  return
end

gotopreview.setup({
  border = {"↖", "─" ,"╮", "│", "╯", "─", "╰", "│"}
})
