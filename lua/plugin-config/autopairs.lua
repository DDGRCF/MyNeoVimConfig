local status, autopairs = pcall(require, "nvim-autopairs")
if not status then
  vim.notify("can't find nvim-autopairs", "error", { title = "Plugin" })
  return
end

-- fastwrap参考官网
autopairs.setup({
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  fast_wrap = {
    map = require("keybindings").autopairs.fast_wrap,
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0,
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
  require("notify")("can't find nvim-autopairs completion cmp")
  return
end

-- 匹配用处
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
