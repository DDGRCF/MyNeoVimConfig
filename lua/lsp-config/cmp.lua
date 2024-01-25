local status_cmp, cmp = pcall(require, "cmp")
if not status_cmp then
  require("notify")("can't find cmp")
  return
end

local status_luasnip, luasnip = pcall(require, "luasnip")
if not status_luasnip then
  require("notify")("can't find luasnip")
  return
end

-- for vscode like snippet
local status_luasnip_vscode, luasnip_vscode = pcall(require, "luasnip.loaders.from_vscode")
if status_luasnip_vscode then
  luasnip_vscode.lazy_load()
else
  require("notify")("can't find luasnip vscode")
end

-- 补全措施
cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  -- 指定 snippet 引擎
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- 补全源
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  -- 补全菜单设置
  formatting = require("lsp-config.ui").formatting,
  -- 快捷键设置
  mapping = cmp.mapping.preset.insert(require("keybindings").cmp(cmp, luasnip)),
})

-- / 查找模式使用 buffer 源
cmp.setup.cmdline("/", {
  -- mapping = cmp.mapping.preset.cmdline(),
  mapping = cmp.mapping.preset.cmdline(require("keybindings").cmp(cmp)),
  sources = {
    { name = "buffer" },
  },
})

-- : 命令行模式中使用 path 和 cmdline 源.
cmp.setup.cmdline(":", {
  completion = { autocomplete = false },
  mapping = cmp.mapping.preset.cmdline(require("keybindings").cmp(cmp)),
  sources = {
    { name = "path", },
    { name = "cmdline", },
  },
})
