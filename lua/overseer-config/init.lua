local status, overseer = pcall(require, "overseer")
if not status then
  vim.notify("没有找到 overseer")
  return
end

overseer.setup()
