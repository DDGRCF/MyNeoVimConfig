local status_window_picker, window_picker = pcall(require, "window-picker")
if not status_window_picker then
  vim.notify("can't find window-picker", "error", { title = "Plugin" })
  return
end

window_picker.setup({
  hint = "floating-big-letter"
})
