local status_dressing, dressing = pcall(require, "dressing")
if not status_dressing then
  require("notify")("can't find dressing")
  return
end

dressing.setup({
  input = {
    mappings = {
      n = {
        ["<Esc>"] = "Close",
        ["<CR>"] = "Confirm",
      },
      i = {
        ["<C-e>"] = "Close",
        ["<C-k>"] = "HistoryPrev",
        ["<C-j>"] = "HistoryNext",
        ["<CR>"] = "Confirm",
      },
    },
  },
  builtin = {
    mappings = {
      ["<Esc>"] = "Close",
      ["<C-e>"] = "Close",
      ["<CR>"] = "Confirm",
    },
  },
})
