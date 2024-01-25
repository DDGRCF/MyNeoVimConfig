local staus_surround, surround = pcall(require, "mini.surround")
if not staus_surround then
  require("notify")("can't find mini.surround")
  return
end

surround.setup({
  mappings = require("keybindings").surround,
})
