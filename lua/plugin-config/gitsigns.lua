local status_gitsigns, gitsigns = pcall(require, "gitsigns")
if not status_gitsigns then
  require("notify")("can't find gitsigns")
  return
end

gitsigns.setup({
  signs              = {
    add = { text = "󰔤" },
    change = { text = "󰔤" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "󰔤" },
    untracked = { text = "󰔤" },
  },
  signcolumn         = true,
  current_line_blame = true
})
