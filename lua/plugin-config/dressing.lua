local status_dressing, dressing = pcall(require, "dressing")
if not status_dressing then
  require("notify")("can't find dressing")
  return
end

dressing.setup({})
