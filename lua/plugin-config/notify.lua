local status_notify, notify = pcall(require, "notify")
if not status_notify then
  vim.print("can't find notify")
  return
end
notify.setup({
  timeout = 800
})

vim.notify = notify

