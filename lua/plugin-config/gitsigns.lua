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
  signcolumn         = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl              = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl             = false, -- Toggle with `:Gitsigns toggle_linehl`
  current_line_blame = true
})
