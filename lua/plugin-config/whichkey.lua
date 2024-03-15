local status_whichkey, whickkey = pcall(require, "which-key")
if not status_whichkey then
  require("notify")("can't find which-key")
  return
end

whickkey.setup({

})
