local status_neo_tree, neo_tree = pcall(require, "neo-tree")
if not status_neo_tree then
  require("notify")("can't find neo-tree")
  return
end

local status_keybindings, keybindings = pcall(require, "keybindings")
if not status_keybindings then
  require("notify")("can't find keybindings")
  return
end

-- neo-tree 配置参数
-- https://github.com/nvim-neo-tree/neo-tree.nvim.git
local keymappings = keybindings.neoTree
local neo_tree_config = {
  sources = {
    "document_symbols",
    "filesystem",
    "buffers",
    "git_status",
  },
  source_selector = {
    winbar = true,
    statusline = false,
  },
}

neo_tree_config = vim.tbl_extend("force", neo_tree_config, keymappings)

neo_tree.setup(neo_tree_config)
