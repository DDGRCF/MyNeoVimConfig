local status, neo_tree = pcall(require, "neo-tree")
if not status then
  vim.notify("没有找到 neo-tree")
  return
end

local status, keybindings = pcall(require, "keybindings")
if not status then
  vim.notify("没有找到 keybindings")
  return
end

-- neo-tree 配置参数
-- https://github.com/nvim-neo-tree/neo-tree.nvim.git
local keymappings = {}
for key, value in pairs(keybindings.neoTree) do
    keymappings[key] = value
end

neo_tree.setup(keymappings)
